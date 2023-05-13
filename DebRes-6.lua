--[[

Gen 6 version of DebRes

--]]

local dr = {}

-- stylua: ignore start
-- local tab = require('Wikilib-tables')
local oop = require('Wikilib-oop')
local basedr = require('DebRes-base')
-- local basefooter = basedr.FooterLine
local et = require('EffTipi-6')
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

-- -- Creates the footer for an efftable, given the primary ability, the types,
-- -- the full ability list and whether the ability is only one
-- dr.EffTable.makeFooter = function(this, types, abils)
--     this.footer = {}

--     local onlyAbil = tab.getn(abils) == 1
--     -- For non unique abilities, the effectiveness calculations have to be
--     -- made without ability, since the footer will contain lines about them.
--     local abil = onlyAbil and abils.ability1 or 'tanfo'

--     -- Adding immunities footer lines
--     if abil ~= 'magidifesa' then
--         if et.typesHaveImm[types.type1] then
--             table.insert(this.footer, basefooter.FooterLine.new('RINGTARGET',
--                     types, abils, et))
--         end

--         if types.type1 ~= types.type2 and et.typesHaveImm[types.type2] then
--             --[[
--                 Swapping types for dual typed Pokémon, since
--                 basefooter.FooterLine only checks the first one for immunities
--             --]]
--             table.insert(this.footer, basefooter.FooterLine.new('RINGTARGET',
--                     {type1 = types.type2, type2 = types.type1}, abils, et))
--         end
--     end

--     -- Adding TAKENOFF footer line for Pokémon having just one ability
--     if onlyAbil then
--         if et.modTypesAbil[abil] then
--             table.insert(this.footer, basefooter.FooterLine.new('TAKENOFF',
--                     types, abil, et))
--         end

--     -- Adding MAYBE footer line for Pokémon having more than one ability
--     else
--         local maybeAbils = tab.filter(abils, function(ability)
--                 return this.shouldAddMaybe(ability, types, et) end)
--         local maybeLines = tab.mapToNum(maybeAbils, function(ability)
--                 return basefooter.FooterLine.new('MAYBE', types, ability, et)
--             end)
--         this.footer = tab.merge(this.footer, maybeLines)
--     end

--     -- Footer should be sorted for equality and printing
--     table.sort(this.footer)
-- end

return dr
