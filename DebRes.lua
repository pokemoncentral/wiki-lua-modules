--[[

Creates a table displaying weaknesses and resistances of a Pokémon.

It exposes two interfaces. The first one is "DebRes", and is meant to be used
in Pokémon pages. It can be invoked with just a Pokémon name:

{{#invoke: DebRes | DebRes | Nidoking }}
{{#invoke: DebRes | DebRes | {{BASEPAGENAME}} }}

If the Pokémon has multiple forms, it creates a table for each. If multiple
forms have the exact same table, it shows it only once listing the relative
forms above the table itself.

The second interface, "single", is more fine grained. It can be invoked with a
Pokémon name (possibly specifying the form) and it creates the table for that
form only. It can also be invoked with types and abilities, using both
positional and named parameters (some of these parameters may be omitted):

{{#invoke: DebRes | Single | Giratina | form = O }}
{{#invoke: DebRes | Single | Veleno | Terra
    | Velenopunto | Antagonismo | Forzabruta | Remasabbia }}
{{#invoke: DebRes | Single | type1 = Veleno | type2 = Terra
    | abil1 = Velenopunto | abil2 = Antagonismo
    | abild = Forzabruta | abile = Remasabbia }}
{{#invoke: DebRes | DebRes | Veleno | Terra }}
{{#invoke: DebRes | DebRes | Veleno }}
{{#invoke: DebRes | DebRes | Veleno | Terra | Levitazione }}
{{#invoke: DebRes | DebRes | type1 = Veleno | abil1 = Levitazione }}

The parameter gen may be specified to create the table for a specific
generation. If omitted, defaults to the current gen.

--]]

--[[ ======================== DEVELOPERS INFORMATIONS =========================

This file is actually just a proxy that should be used in pages. It parses the
input and prepares the data, which is then passed to the real implementation in
DebRes-base.

--]]

local dr = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local list = require('Wikilib-lists')
local multigen = require('Wikilib-multigen')
local formlib = require('Wikilib-forms')
local w = require('Wikilib')
local basedr = require('DebRes-base')
local pokes = require("Poké-data")
local gendata = require("Gens-data")
-- stylua: ignore end

dr.debRes = function(frame)
    local p = w.trimAndMap(frame.args, string.lower)
    local pokeData = p[1]
        and (pokes[txt.parseInt(p[1]) or p[1]] or pokes[mw.text.decode(p[1])])

    -- If no data is found, types and abilities are directly provided
    if not pokeData then
        return dr.single(frame)
            .. "[[Categoria:Moduli con parametri deprecati]]"
    end

    local name = multigen.getGenValue(pokeData.name)

    return list.makeFormsLabelledBoxes({
        name = name:lower(),
        makeBox = basedr.EffTable.new,
        printBoxes = basedr.EffTable.printEffTables,
        boxArgs = gendata.latest,
    })
end
dr.DebRes, dr.debres = dr.debRes, dr.debRes

dr.single = function(frame)
    local p = w.trimAll(frame.args)
    local ndex, abbr = formlib.getndexabbr(p[1] or "", p.form)
    local pokename = formlib.nameToDataindex(ndex, abbr)
    local gen = tonumber(p.gen) or gendata.latest

    if not pokes[pokename] then
        -- If no data is found, types and abilities are directly provided
        p = tab.map(p, string.lower)
        local types, abils = {}, {}
        types.type1 = p[1] or p.type1 or p.type
        types.type2 = p[2] or p.type2 or types.type1
        abils.ability1 = p[3] or p.abil1 or p.abil
        abils.ability2 = p[4] or p.abil2
        abils.abilityd = p[5] or p.abild
        abils.abilitye = p[6] or p.abile
        return tostring(basedr.EffTable.new(types, abils, gen))
    else
        -- We never add a label because this is always a single box
        return tostring(basedr.EffTable.new(pokename, nil, gen))
    end
end
dr.Single = dr.single

return dr
