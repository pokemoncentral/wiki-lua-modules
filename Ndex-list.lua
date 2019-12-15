--[[

This module prints the list of all Pokémon, useless alternative forms
included, for the ndex list (ie: only name, MS and type).

--]]

local n = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local list = require('Wikilib-lists')
-- local oop = require('Wikilib-oop')
local genUtils = require('Wikilib-gens')
-- local multigen = require('Wikilib-multigen')
local entry = require('Ndex')
local pokes = require('Poké-data')
local gendata = require("Gens-data")
local useless = require("UselessForms-data")

--[[

Print the list of Pokémon from the given generation.
Data (ie: types) are from the latest gen.

--]]
local listgen = function(gen)
    -- Creates a fake Poké/data table with data for Pokémon from a single gen,
    -- but adding also useless forms
    local source = table.filter(pokes, function(v, k)
        return not string.parseInt(k)
               and genUtils.getGen.ndex(v.ndex) == gen
    end)
    for upoke, uval in pairs(useless) do
        if source[upoke] then
            for _, v in pairs(uval.gamesOrder) do
                if v ~= "base" then
                    source[upoke .. v] = source[upoke]
                end
            end
        end
    end

    return list.makeList({
        source = source,
        iterator = list.pokeNames,
        makeEntry = entry.Entry.new,
        -- entryArgs = gen,
        header = entry.headerLua(gendata[gen].region),
        separator = "",
        footer = "</div>",
    })
end

--[[

Main Wikicode interface. No parameters, just prints the list of Pokémon.

{{#invoke: Ndex/list | list }}

--]]
n.list = function(_)
    local tables = {}
    for gen = 1, gendata.latest do
        table.insert(tables, table.concat{
            "==", string.fu(gendata[gen].ext), " generazione==" })
        table.insert(tables, listgen(gen))
    end
    return table.concat(tables, "\n")
end

--[[

Secondary Wikicode interface. Given a gen number, prints the list for that
generation.

Example:
{{#invoke: Ndex/list | listgen | 4 }}

--]]
n.listgen = function(frame)
    return listgen(tonumber(frame.args[1]))
end
n.Listgen = n.listgen

return n
