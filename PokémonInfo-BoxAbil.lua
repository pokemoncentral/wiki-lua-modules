-- Abilities box for template PokémonInfo

local j = {}

local mw = require('mw')

local l = require('Links')
local abillib = require('Wikilib-abils')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local abils = require('PokéAbil-data')

-- Table holding Pikachu forms to be ignored
local ignorableForms = {'pikachuR', 'pikachuD', 'pikachuCn', 'pikachuS',
    'pikachuW'}

--[[

This class represents a cell of the abilities box and contains information
about the abilities and the forms that share the same abilities combination.

--]]
local AbilsBox = oop.makeClass(list.Labelled)

--[[

Constructor: takes the name of the Pokémon, and an optionally extended name of
the form. The name is given in the form name/ndex + abbreviation,

--]]
AbilsBox.new = function(name, formName)

	-- Pokémon whose ability is yet unknown
	if abils[name].ability1 == '' then
		return nil
	end

	-- Pikachu (@nalkio visto che questo Pokémon fa danni?)
	if table.search(ignorableForms, name) then
		return nil
	end

	local this = AbilsBox.super.new(formName)

	this = table.merge(abillib.lastAbils(abils[name]), this)

	return setmetatable(this, AbilsBox)
end

AbilsBox.__eq = function(a, b)
	return a.ability1 == b.ability1
			and a.ability2 == b.ability2
			and a.abilityd == b.abilityd
            and a.abilitye == b.abilitye
end

--[[

Wikicode for an abilities box cell: the standard abilities are on the left,
and the hidden one is on the right. The event ability takes the place of the
hidden ability when there is none, otherwise it sits below. The form names
are added at the top, if present.

--]]
AbilsBox.__tostring = function(this)
	local stdAbils = l.aColor(this.ability1)
	if this.ability2 then
		stdAbils = table.concat({stdAbils, 'o',
			l.aColor(this.ability2)}, ' ')
	end

	local hiddenAbil = ''
	if this.abilityd then
		hiddenAbil = table.concat{'<div class="width-xl-50">',
			l.aColor(this.abilityd), '<div class="small-text">Abilit&agrave; nascosta</div></div>'}
	end

    local eventAbil = ''
	if this.abilitye then
		eventAbil = string.interp('<div class="width-xl-${width}">${abil}<div class="small-text">Abilit&agrave; evento</div></div>',
                {
                    width = this.abilityd and '100' or '50',
                    abil = l.aColor(this.abilitye)
                })
	end

	return string.interp('<div class="flex flex-row flex-wrap flex-main-stretch flex-items-center width-xl-100" style="padding: 0.2em;">${forms}<div class="width-xl-${stdWidth}">${stdAbils}</div>${hiddenAbil}${eventAbil}</div>',
	{
		stdWidth = (this.abilityd or this.abilitye) and '50' or '100',
		forms = #this.labels < 1 and '' or table.concat{
			'<div class="small-text width-xl-100" style="padding-bottom: 0.2em;">',
			mw.text.listToText(this.labels, ', ', ' e '),
			'</div>'
		},
		stdAbils = stdAbils,
		hiddenAbil = hiddenAbil,
        eventAbil = eventAbil
	})
end

-- HTML code for the forms cells
local printBoxes = function(boxes)
	local acc = table.map(boxes, tostring)
	table.insert(acc, 1, '<div class="roundy text-center" style="background: #FFF; padding: 0.2em;">')
	table.insert(acc, '</div>')
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

print(j.boxAbil{args={arg[1]}})
-- return b
