--[[

Gen 6 version of DebRes

--]]

local dr = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local oop = require('Wikilib-oop')
local basedr = require('DebRes-base')
-- local basefooter = basedr.FooterLine
local et = require('EffTipi-5')
-- stylua: ignore end

dr.EffTable = oop.makeClass(basedr.EffTable)

-- All the possible effectiveness values, considering abilities. Therefore,
-- triple resistances are taken into account, as well as abilities like Filtro,
-- Solidroccia and Pellearsa.
-- stylua: ignore
dr.EffTable.allEff = {
    0, 0.25, 0.5, 1, 2, 4, -- Standard
    1.5, 3 -- Filtro/Solidroccia
}

--[[

EffTable constructor. It can be used in two versions.

In the first, name and formname are a string with the Pokémon name, as name +
abbreviation, and an optional extended name of the alternative form.

In the second, name and formname are tables, respectively holding types and
abilities for which the DebRes should be created.

The last parameter is the generation (see boxArgs in makeFormsLabelledBoxes).

--]]
dr.EffTable.new = function(name, formname, gen)
    local types, abils, label = dr.EffTable.parseEntryData(name, formname, gen)

    local this = setmetatable(
        dr.EffTable.super.new(types, abils, gen, et, label),
        dr.EffTable
    )

    this:computeEff()
    this:makeFooter()

    return this
end

return dr
