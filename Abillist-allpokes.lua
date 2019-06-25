--[[

This module prints the list of all Pokémon, alternative forms included, with
their ability.

--]]

local k = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local genUtils = require('Wikilib-gens')
-- local genlib = require('Wikilib-multigen')
local abl = require('Abillist')
-- local css = require('Css')
-- local links = require('Links')
-- local ms = require('MiniSprite')
-- local resp = require('Resp')
local pokes = require("Poké-data")
local abils = require('PokéAbil-data')
local gendata = require("Gens-data")

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
    return a.name == b.name and table.equal(a.abils, b.abils)
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
        footer = abl.headers.footer,
        fullGroupLabel = 'Tutte le forme',
    })
end

--[[

Main Wikicode interface. No parameters, just prints the list of Pokémon with
their abilities.

{{#invoke: Abillist/allpokes | abillist }}

--]]
k.abillist = function(frame)  -- luacheck: no unused
    local tables = {}
    for gen=1,gendata.latest do
        table.insert(tables, table.concat{
            "==", string.fu(gendata[gen].ext), " generazione==" })
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

return k
