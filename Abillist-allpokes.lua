--[[

This module prints the list of all Pokémon, alternative forms included, with
their ability.

--]]

local k = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local genUtils = require('Wikilib-gens')
local abl = require('Abillist')
local pokes = require("Poké-data")
local abils = require('PokéAbil-data')
local gendata = require("Gens-data")
-- stylua: ignore end

-- Generation filtered entry
k.GenEntry = oop.makeClass(abl.Entry)

--[[

Constructor: the first argument is an entry from PokéAbil/data, the second
one its key and the third one, optional, marks the generation this entry
should display data for: if omitted, all the generation but the first are taken
in account

--]]
k.GenEntry.new = function(pokeAbil, name, gen)
    if gen and genUtils.getGen.ndex(pokes[name].ndex) ~= gen then
        return nil
    end

    if pokeAbil.ability1 == "" then
        return nil
    end

    local this = k.GenEntry.super.new(pokeAbil, name)

    return setmetatable(this, k.GenEntry)
end

--[[

Equality operator for entries' merging.

--]]
k.GenEntry.__eq = function(a, b)
    -- The two entries are equals iff their name and abilities are the same
    return a.name == b.name and tab.equal(a.abils, b.abils)
end

--[[

Print the list of Pokémon from the given generation.

--]]
local listgen = function(gen)
    return list.makeCollapsedList({
        source = abils,
        iterator = list.pokeNames,
        makeEntry = k.GenEntry.new,
        entryArgs = gen,
        header = abl.headers.makeHeader(gendata[gen].region),
        separator = abl.headers.separator,
        footer = abl.headers.makeFooter(gendata[gen].region),
        fullGroupLabel = "Tutte le forme",
    })
end

--[[

Main Wikicode interface. No parameters, just prints the list of Pokémon with
their abilities.

{{#invoke: Abillist/allpokes | abillist }}

--]]
k.abillist = function(frame) -- luacheck: no unused
    local tables = {}
    for gen = 1, gendata.latest do
        table.insert(
            tables,
            table.concat({
                "==",
                txt.fu(gendata[gen].ext),
                " generazione==",
            })
        )
        table.insert(tables, listgen(gen))
    end
    return table.concat(tables, "\n")
end

k.Abillist = k.abillist

--[[

Secondary Wikicode interface. Given a gen number, prints the list for that
generation.

Example:
{{#invoke: Abillist/allpokes | listgen | 8 }}

--]]
k.listgen = function(frame)
    return listgen(tonumber(frame.args[1]))
end

--[[

WikiCode interface to print a list of entries. Supports only Pokémon names.

Example:
{{#invoke: Abillist/allpokes | manualEntry | staraptor goomy ampharos scraggy }}

--]]
k.list = function(frame)
    local ndexlist = frame.args[1]
    local res = { abl.headers.makeHeader(txt.trim(frame.args.color)) }
    for ndex in ndexlist:gmatch("[^ ]+") do
        table.insert(res, tostring(k.GenEntry.new(abils[ndex], ndex)))
    end
    table.insert(res, abl.headers.makeFooter(txt.trim(frame.args.color)))
    return table.concat(res, "\n|-\n")
    -- return table.concat(res, "\n|-\n") .. "\n" .. abl.headers.makeFooter(txt.trim(frame.args.color))
end
k.List = k.list

return k
