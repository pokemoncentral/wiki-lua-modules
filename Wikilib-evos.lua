--[[

Library for Evo/data module use.

--]]

local ev = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local forms = require('Wikilib-forms')
local evodata = require("Evo-data")
local pokes = require("Poké-data")

--[[

Given a Pokémon's table from Evo/data and an identifier of a Pokémon, check
whether the table belongs to that Pokémon or not.
The identifier can be either an ndex (possibly with an abbr) or a name.

This function is based on the assumption that a Pokémon's name won't ever be
the same as an ndex with abbr; if that is ever falsified by TPCi this function
have to be rewritten.

--]]
ev.ownTable = function(pkmn, evotab)
    -- if type(pkmn) == 'number' then
    --     return pkmn == evotab.ndex
    -- if evotab.name == pkmn then
    --     return true
    -- else
    --     return evotab.ndex == pkmn
    -- end
    return pkmn == evotab.name or pkmn == evotab.ndex
end

--[[

Given a Pokémon's table from Evo/data module, applies a fold on the tree rooted
at that table.
The function takes the accumulator as the first argument, then the value.
The visit is prefix (lowest level before) and branches are visited in the
module's order.

--]]
ev.foldEvoTree = function(evotab, acc, func)
    acc = func(acc, evotab)
    if evotab.evos then
        acc = table.fold(evotab.evos, acc, function(acc1, v)
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
    -- simplify pass to map. Two step declaration because it's recursive
    local recPruneEvoTree
    recPruneEvoTree = function(evotab)
        if ev.ownTable(name, evotab) then
            return evotab
        end
        if not evotab.evos then
            return nil
        end
        local result = {}
        result.evos = table.mapToNum(evotab.evos, recPruneEvoTree, ipairs)
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

Given a Pokémon name od ndex, returns the list of types of its evolutions that
it doesn't have.

--]]
ev.evoTypesList = function(name)
    local thisdata = pokes[forms.nameToDataindex(name)]
    return table.filter(table.unique(table.flatMap(ev.foldEvoTree(ev.preciseEvotable(name), {}, function(acc, v)
        table.insert(acc, v.ndex)
        return acc
    end), function(ndex)
        return { pokes[ndex].type1, pokes[ndex].type2 }
    end)), function(type)
        return not (type == thisdata.type1 or type == thisdata.type2)
    end)
end

--[[

Given a Pokémon name or ndex return true iff that Pokémon can't evolve further.

--]]
ev.isFullyEvolved = function(name)
    return ev.preciseEvotable(name).evos == nil
    -- return table.empty(ev.preciseEvotable(name).evos)
end

return ev
