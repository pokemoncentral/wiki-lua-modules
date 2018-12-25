--[[

Library for Evo/data module use.

--]]

local ev = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local forms = require('Wikilib-forms')
local evodata = require("Evo-data")
local pokes = require("Poké-data")

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
        table.map(evotab.evos, function(v)
            acc = ev.foldEvoTree(v, acc, func)
        end, ipairs) -- Uses ipairs to keep the module's order
    end
    return acc
end

--[[

Given a Pokémon name or ndex, returns the evotable of that Pokémon, not of its
whole evolutionary line.

--]]
ev.preciseEvotable = function(name)
    local ndex = pokes[forms.nameToDataindex(name)].ndex
    return ev.foldEvoTree(evodata[ndex], nil, function(acc, v)
        if acc then
            return acc
        elseif v.ndex == ndex then
            return v
        else
            return nil
        end
    end)
end

--[[

Given a Pokémon name or ndex, returns the evo tree pruned of branches that
aren't in the subtree nor in the path to root of that Pokémon, that is the tree
reachable by going only up or only down.
That is the exact tree that Evobox should print.

Example: given Eevee, this functions returns Eevee and all its evolutions, but
given Vaporeon it returns only Eevee with evolution Vaporeon, pruning away all
the other evolutions.

--]]
ev.prunedEvotree = function(name)
    local ndex = pokes[forms.nameToDataindex(name)].ndex
    -- Support function. Needed because it's recursive. Local to access ndex and
    -- simplify pass to map. Two step declaration because it's recursive
    local recPruneEvoTree
    recPruneEvoTree = function(evotab)
        if (evotab.ndex == ndex) then
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

    return recPruneEvoTree(evodata[ndex])
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

--]]
ev.evoList = function(name)
    return ev.foldEvoTree(ev.preciseEvotable(name), {}, function(acc, v)
        table.insert(acc, v.ndex)
        return acc
    end)
end

--[[

Given a Pokémon's ndex, returns the list of types of its evolutions that it
doesn't have.

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

return ev
