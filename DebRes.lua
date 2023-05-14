--[[

Creates a table displaying weaknesses and resistances of a Pokémon.

If a Pokémon has more forms, it only shows tables that are actually different.
Forms that share a table are listed above the table itself.

In its basic usage, it can be invoked with just a Pokémon name:

{{#invoke: DebRes | DebRes | Nidoking }}

It can also be invoked with types and abilities, using both positional and
named parameters (some of these parameters may be omitted):

{{#invoke: DebRes | DebRes | Veleno | Terra
    | Velenopunto | Antagonismo | Forzabruta | Remasabbia }}
{{#invoke: DebRes | DebRes | type1 = Veleno | type2 = Terra
    | abil1 = Velenopunto | abil2 = Antagonismo
    | abild = Forzabruta | abile = Remasabbia }}

{{#invoke: DebRes | DebRes | Veleno | Terra }}
{{#invoke: DebRes | DebRes | Veleno }}
{{#invoke: DebRes | DebRes | Veleno | Terra | Levitazione }}
{{#invoke: DebRes | DebRes | type1 = Veleno | abil1 = Levitazione }}

The parameter gen may be specified to create the DebRes for a specific
generation. If omitted, defaults to the current gen.

--]]

--[[ ======================== DEVELOPERS INFORMATIONS =========================

This file is actually just a proxy that should be used in pages. It parses the
input and prepares the data which is passed to actual implementations, which
are defined in subpages, and inherit from a base class defined in DebRes-base.

--]]

local dr = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local list = require('Wikilib-lists')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local basedr = require('DebRes-base')
local pokes = require("Poké-data")
local gendata = require("Gens-data")
-- stylua: ignore end

dr.debRes = function(frame)
    local p = w.trimAndMap(frame.args, string.lower)
    local pokeData = p[1]
        and (pokes[txt.parseInt(p[1]) or p[1]] or pokes[mw.text.decode(p[1])])
    local gen = tonumber(p.gen) or gendata.latest

    -- If no data is found, types and abilities are directly provided
    if not pokeData then
        local types, abils = {}, {}
        types.type1 = p[1] or p.type1 or p.type
        types.type2 = p[2] or p.type2 or types.type1
        abils.ability1 = p[3] or p.abil1 or p.abil
        abils.ability2 = p[4] or p.abil2
        abils.abilityd = p[5] or p.abild
        abils.abilitye = p[6] or p.abile
        return tostring(basedr.EffTable.new(types, abils, gen))
    end

    -- pokeData = multigen.getGen(pokeData)
    local name = multigen.getGenValue(pokeData.name, gen)

    return list.makeFormsLabelledBoxes({
        name = name:lower(),
        makeBox = basedr.EffTable.new,
        printBoxes = basedr.EffTable.printEffTables,
        boxArgs = gen,
    })
end
dr.DebRes, dr.debres = dr.debRes, dr.debRes

return dr
