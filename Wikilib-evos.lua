--[[

Library for Evo/data module use.

--]]

local ev = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local forms = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local evodata = require("Evo-data")
local pokes = require("Poké-data")
-- stylua: ignore end

--[[

Given a Pokémon's table from Evo/data and an identifier of a Pokémon, check
whether the table belongs to that Pokémon or not.
The identifier can be either an ndex (possibly with an abbr) or a name.

This function is based on the assumption that a Pokémon's name won't ever be
the same as an ndex with abbr; if that is ever falsified by TPCi this function
have to be rewritten.

--]]
ev.ownTable = function(pkmn, evotab)
    return pkmn == evotab.name or pkmn == evotab.ndex
end

--[[

Given a Pokémon's table from Evo/data module, applies a fold on the tree rooted
at that table.
The function takes the accumulator as the first argument, then the value.
The visit is postfix (highest level before) and branches are visited in the
module's order.

--]]
ev.foldEvoTree = function(evotab, acc, func)
    acc = func(acc, evotab)
    if evotab.evos then
        acc = tab.fold(evotab.evos, acc, function(acc1, v)
            return ev.foldEvoTree(v, acc1, func)
        end, ipairs) -- Uses ipairs to keep the module's order
    end
    return acc
end

--[[

Given a Pokémon name or ndex, returns the evotable of that Pokémon, not of its
whole evolutionary line, that is the subtree rooted at the Pokémon's node.

--]]
ev.preciseEvotable = function(name)
    return ev.foldEvoTree(evodata[name], nil, function(acc, v)
        if acc then
            return acc
        elseif ev.ownTable(name, v) then
            return v
        else
            return nil
        end
    end)
end

--[[

Given a Pokémon name or ndex (possibly with abbr), returns the evo tree pruned
of branches that aren't in the subtree nor in the path to root of that Pokémon.
I.e: the exact tree that Evobox should print.

Example: given Eevee, this functions returns Eevee and all its evolutions, but
given Vaporeon it returns only Eevee with evolution Vaporeon, pruning away all
other evolutions.

The parameter should be the ndex as found in the evo-data module (that is, three
digits possibly followed by the abbr, in first uppercase).

--]]
ev.prunedEvotree = function(name)
    -- Support function. Needed because it's recursive. Local to access ndex and
    -- simplify pass to map.
    local function recPruneEvoTree(evotab)
        if ev.ownTable(name, evotab) then
            return evotab
        end
        if not evotab.evos then
            return nil
        end
        local result = {}
        result.evos = tab.mapToNum(evotab.evos, recPruneEvoTree, ipairs)
        if #result.evos == 0 then
            return nil
        end
        for k, v in pairs(evotab) do
            if k ~= "evos" then
                result[k] = v
            end
        end
        return result
    end

    return recPruneEvoTree(evodata[name])
end

--[[

Given two Pokémon names or ndexes returns true iff they are in the same
evolutionary line. The two arguments must be able to index Poké/data.

--]]
ev.sameEvoLine = function(name1, name2)
    return evodata[name1] == evodata[name2]
end

--[[

Given a Pokémon's ndex, returns the list of all Pokémon in which it can evolve.
The list is of ndexes.
If a Pokémon without ndex should be inserted in this list, it doesn't appear.

--]]
ev.evoList = function(name)
    return ev.foldEvoTree(ev.preciseEvotable(name), {}, function(acc, v)
        table.insert(acc, v.ndex)
        return acc
    end)
end

--[[

Given a Pokémon name or ndex return the list of names of Pokémon that can
evolve into it. The list is sorted in reverse evolution order.

--]]
ev.preevoList = function(name)
    local function explore(evotab)
        if ev.ownTable(name, evotab) then
            return {}
        end
        if not evotab.evos then
            return nil
        end
        for _, v in pairs(evotab.evos) do
            local acc = explore(v)
            if acc then
                table.insert(acc, evotab.name)
                return acc
            end
        end
        return nil
    end
    return explore(evodata[name])
end

--[[

Given a Pokémon name od ndex, returns the list of types of its evolutions that
it doesn't have.
The optional argument gen specifies in which gen this should be computed,
defaults to the latest.

--]]
ev.evoTypesList = function(name, gen)
    local thisdata = pokes[name] or pokes[forms.getnameabbr(name)]
    return tab.filter(
        tab.unique(
            tab.flatMap(
                ev.foldEvoTree(ev.preciseEvotable(name), {}, function(acc, v)
                    table.insert(acc, v.ndex)
                    return acc
                end),
                function(ndex)
                    local pokedata = pokes[ndex]
                        or pokes[forms.getnameabbr(name)]
                    return multigen.getGen(
                        { pokedata.type1, pokedata.type2 },
                        gen
                    )
                end
            )
        ),
        function(type)
            return not (type == thisdata.type1 or type == thisdata.type2)
        end
    )
end

--[[

Given a Pokémon name od ndex, returns the list of types of its alternative
forms (only those in which it can change) that it doesn't have.
The optional argument gen specifies in which gen this should be computed,
defaults to the latest.

--]]
ev.formTypesList = function(name, gen)
    local formstab = evodata.forms[name]
    if not formstab then
        return {}
    end
    local thisdata = pokes[name] or pokes[forms.getnameabbr(name)]
    return tab.filter(
        tab.unique(tab.flatMap(formstab, function(tt)
            return tab.flatMap(tt, function(formtab)
                local pokedata = pokes[forms.uselessToEmpty(formtab.name)]
                return multigen.getGen({ pokedata.type1, pokedata.type2 }, gen)
            end)
        end)),
        function(type)
            return not (type == thisdata.type1 or type == thisdata.type2)
        end
    )
end

--[[

Given a Pokémon name or ndex return true iff that Pokémon can't evolve further.

--]]
ev.isFullyEvolved = function(name)
    -- BREEDONLY means that a Pokémon breeds from the evos table, but doesn't
    -- evolve into it, hence it's fully evolved (cfr. Phione).
    local precEvotable = ev.preciseEvotable(name)
    local BREEDONLY = evodata.conditions.BREEDONLY
    if precEvotable.conditions and precEvotable.conditions[BREEDONLY] then
        return true
    end
    return precEvotable.evos == nil
end

--[[

Given a Pokémon name or ndex return the name of the Pokémon that can evolve
into it. If no such Pokémon exists, return nil.

--]]
ev.directPreevo = function(name)
    return ev.foldEvoTree(evodata[name], nil, function(acc, v)
        if acc then
            return acc
        elseif
            v.evos
            and tab.any(v.evos, function(a)
                return ev.ownTable(name, a)
            end)
        then
            return v.name
        else
            return nil
        end
    end)
end

return ev
