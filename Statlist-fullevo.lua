--[[

This module prints a list of all fully evolved Pokémon base statistics.

Generation I has a separate table because it has different statistics, while
the other are merged into one.

--]]

local s = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local gamesUtil = require('Wikilib-games')
local evo = require('Wikilib-evos')
local evodata = require("Evo-data")
local stats = require('PokéStats-data')
local stl = require('Statlist')


--[[

Class representing an entry for the base statistics list. By subclassing
Statlist.Entry is almost ready to go.

--]]
local Entry = oop.makeClass(stl.Entry)

--[[

Constructor: inherits from its superclass, only adding a filter for Pokémon
not fully evolved. Parameters are as the superclass.

--]]
Entry.new = function(stat, poke, gen)
    if gen and not gamesUtil.isInGen(poke, gen) then
        return nil
    end

    if evodata[poke] and not evo.isFullyEvolved(poke) then
        return nil
    end

    local this = Entry.super.new(stat, poke, gen)

    return setmetatable(this, Entry)
end

--[[

Wiki interface function: called with no argument, returns the list of all
fully evolved Pokémon statistics for all generations but the first, which
has a separate table.

Example:
{{#invoke: Statlist/fullevo | statlist }}

--]]
s.statlist = function(frame)        -- luacheck: no unused
    return table.concat({
        [[===Dalla seconda generazione in poi===]],
        list.makeCollapsedList({
            source = stats,
            makeEntry = Entry.new,
            iterator = list.pokeNames,
            header = stl.headers.header,
            fullGroupLabel = 'Tutte le forme'
        }),
        [[===Nella prima generazione===]],
        list.makeCollapsedList({
            source = stats,
            makeEntry = Entry.new,
            entryArgs = 1,
            iterator = list.pokeNames,
            header = stl.headers.firstGenHeader,
            fullGroupLabel = 'Tutte le forme'
        })
    }, '\n')
end

s.Statlist = s.statlist

return s
