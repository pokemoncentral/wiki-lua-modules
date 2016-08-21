-- Box delle abilità per il PokémonInfo

local b = {}

local mw = require('mw')

local l = require('Links')
local w = require('Wikilib')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local txt = require('Wikilib-strings')
local abils = require('PokéAbil-data')
local alts = require("AltForms-data")
local c = require("Colore-data")

--[[

Questa classe rappresenta una casella
del box delle abilità del PokémonInfo,
mantenendo informazioni sulle combinazioni
di abilità e sulle forme che le hanno.

--]]
local AbilsBox = oop.makeClass(list.Labelled)

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome + sigla,
e, opzionalmente, il nome esteso della forma

--]]
AbilsBox.new = function(name, formName)

	-- Meowstic e Pokémon con abilità non rivelata
	if abils[name].ability1 == '' then
		return nil
	end

	local this = AbilsBox.super.new(formName)

	this = table.merge(abils[name], this)

	return setmetatable(this, AbilsBox)
end

AbilsBox.__eq = function(a, b)
	return a.ability1 == b.ability1
			and a.ability2 == b.ability2
			and a.abilityd == b.abilityd
end

--[[

Wikicode per una cella del box delle abilità:
le abilità standard sono a sinistra, quella
nascosta a destra, e le forme sopra.

--]]
AbilsBox.__tostring = function(this)
	local stdAbils = l.aColor(this.ability1)
	if this.ability2 then
		stdAbils = table.concat({stdAbils, 'o',
			this.abilityd and '<br />' or '',
			l.aColor(this.ability2)}, ' ')
	end

	local hiddenAbil = ''
	if this.abilityd then
		hiddenAbil = table.concat{'<div style="box-sizing: border-box; padding: 0 0.3em 0.5em 0.3em; min-width: 50%;">',
			l.aColor(this.abilityd), '<div class="small-text">Abilit&agrave; nascosta</div></div>'}
	end

	return string.interp('<div class="flex flex-row flex-wrap flex-main-stretch flex-items-center" style="min-width: ${boxWidth}%;">${forms}<div style="box-sizing: border-box; padding: 0 0.3em 0.5em 0.3em; min-width: ${stdWidth}%;">${stdAbils}</div>${hiddenAbil}</div>',
	{
		boxWidth = this.abilityd and '100' or '50',
		stdWidth = this.abilityd and '50' or '100',
		forms = #this.labels < 1 and '' or table.concat{
			'<div class="small-text" style="width: 100%;">',
			mw.text.listToText(this.labels, ', ', ' e '),
			'</div>'
		},
		stdAbils = stdAbils,
		hiddenAbil = hiddenAbil
	})
end

--[[

Stampa in HTML una table di AbilBoxes:
ogni forma ha una cella, che può
affiancarsi a quella di un'altra forma
in assenza di abilità nascosta.

--]]
local printBoxes = function(boxes)
	local acc = table.map(boxes, tostring)
	table.insert(acc, 1, '<div class="roundy text-center" style="background: #FFF; padding: 0.5em 0;">')
	table.insert(acc, '</div>')
	return table.concat(acc)
end

--[[

Dato il nome di un Pokémon o il suo ndex,
ritorna il box delle abilità, con una
cella per ogni diversa configurazione di
abilità delle forme alternative, con
sotto i nomi delle forme che la hanno.

--]]
b.boxAbil = function(frame)
	local name = string.trim(mw.text.decode(frame.args[1]
			or '')):lower()
	
	return list.makeFormsLabelledBoxes({
		name = name,
		makeBox = AbilsBox.new,
		printBoxes = printBoxes
	})
end

b.BoxAbil, b.box_abil, b.Box_abil = b.boxAbil, b.boxAbil, b.boxAbil

print(b.boxAbil{args={arg[1]}})
-- return b
