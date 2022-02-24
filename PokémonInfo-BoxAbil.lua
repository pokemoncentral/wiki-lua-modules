-- Abilities box for template PokémonInfo

local j = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local l = require('Links')
local oop = require('Wikilib-oop')
local multigen = require('Wikilib-multigen')
local list = require('Wikilib-lists')
local abils = require("PokéAbil-data")

--[[

This class represents a cell of the abilities box and contains information
about the abilities and the forms that share the same abilities combination.

--]]
local AbilsBox = oop.makeClass(list.Labelled)

--[[

Static fields and methods

--]]
AbilsBox.STRINGS = {
    singleAbilBox = '<div class="width-xl-33 width-xs-50" style="padding: 0.2em;">${abil}<div class="small-text">${desc}</div></div>',
    singleAbilNoLabel = '<div class="width-xl-33 width-xs-50" style="padding: 0.2em;">${abil}</div>',
    formAbilsBox = '<div>${forms}</div><div class="flex flex-row flex-wrap flex-items-end flex-main-stretch" style="padding: 0.2em;">${abils}</div>',
    formLabel = "<div class=\"width-xl-100\" style=\"padding-bottom: 0.2em;\">'''${label}'''</div>",
    LABELS = {
        ability1 = "Prima abilit&agrave;",
        ability2 = "Seconda abilit&agrave;",
        abilityd = "Abilit&agrave; speciale",
        abilitye = "Abilit&agrave; evento",
    },
}

-- Table holding forms to be ignored
AbilsBox.ignorableForms = {
    'pikachuR', 'pikachuD', 'pikachuCn', 'pikachuS', 'pikachuW',
    'pikachuCm', 'eeveeCm',
}

--[[

Constructor: takes the name of the Pokémon, and an optionally extended name of
the form. The name is given in the form name/ndex + abbreviation,

--]]
AbilsBox.new = function(name, formName)
    -- Pokémon whose ability is yet unknown
    if abils[name].ability1 == '' then
        return nil
    end

    -- Ignored forms
    if table.search(AbilsBox.ignorableForms, name) then
        return nil
    end

    local this = AbilsBox.super.new(formName)

    this.abils = abils[name]

    return setmetatable(this, AbilsBox)
end

AbilsBox.__eq = function(a, b)
    return table.equal(a.abils, b.abils)
end

-- Prints a single ability. If it's "Nessuna", it returns a "-" without link
local toStringAbil = function(abil)
    if abil == "Nessuna" or abil == "Sconosciuta" then
        return "&mdash;"
    end
    return l.aColor(abil)
end

--[[

Get the function to print a single ability.

--]]
AbilsBox.getAbilityPrinter = function(this)
    local str = table.getn(this.abils) == 1
                and AbilsBox.STRINGS.singleAbilNoLabel
                or AbilsBox.STRINGS.singleAbilBox
    return function(ability, key)
        return string.interp(str, {
            abil = multigen.printSpans(multigen.getGenSpan(ability), toStringAbil),
            desc = AbilsBox.STRINGS.LABELS[key],
        })
    end
end

--[[

Wikicode for an abilities box cell: the standard abilities are on the left,
and the hidden one is on the right. The event ability takes the place of the
hidden ability when there is none, otherwise it sits below. The form names
are added at the top, if present.

--]]
AbilsBox.__tostring = function(this)
    local abilBoxes = table.map(this.abils, this:getAbilityPrinter())

    local temp = {}
    -- Inserting ensures to avoid holes for concat
    table.insert(temp, abilBoxes.ability1)
    table.insert(temp, abilBoxes.ability2)
    table.insert(temp, abilBoxes.abilityd)
    table.insert(temp, abilBoxes.abilitye)
    local abilstring = table.concat(temp)

    local forms = #this.labels < 1
                  and ''
                  or string.interp(AbilsBox.STRINGS.formLabel, {
                      label = mw.text.listToText(this.labels, ', ', ' e '),
                  })

    return string.interp(AbilsBox.STRINGS.formAbilsBox, {
        abils = abilstring,
        forms = forms,
    })
end

-- HTML code for the forms cells
local printBoxes = function(boxes)
    local acc = table.map(boxes, tostring)
    return table.concat(acc)
end

--[[

Given a Pokémon name, or its ndex, returns the HTML code for the template
PokémonInfo abilities box. Every combination of abilities has its own cell,
with the forms that have if displayed above.

--]]
j.boxAbil = function(frame)
    local name = string.trim(frame.args[1] or '')
    name = string.parseInt(name) or mw.text.decode(name):lower()

    return list.makeFormsLabelledBoxes({
        name = name,
        makeBox = AbilsBox.new,
        printBoxes = printBoxes
    })
end

j.BoxAbil, j.box_abil, j.Box_abil = j.boxAbil, j.boxAbil, j.boxAbil

return j
