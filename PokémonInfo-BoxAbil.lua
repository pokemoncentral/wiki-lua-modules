-- Box delle abilità per il PokémonInfo

local b = {}

local mw = require('mw')

local l = require('Links')
local w = require('Wikilib')
local abillib = require('Wikilib-abils')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local txt = require('Wikilib-strings')
local abils = require('PokéAbil-data')
local c = require("Colore-data")

-- !!! ATTENZIONE !!!
--- Questo modulo modifica le copie cachate degli altri moduli dati
local gre = require('GreninjaDemo-data')

--[[

Questa classe rappresenta una casella
del box delle abilità del PokémonInfo,
mantenendo informazioni sulle combinazioni
di abilità e sulle forme che le hanno.

--]]
local AbilsBox = oop.makeClass(list.Labelled)

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome/ndex + sigla,
e, opzionalmente, il nome esteso della forma

--]]
AbilsBox.new = function(name, formName)

	-- Meowstic e Pokémon con abilità non rivelata
	if abils[name].ability1 == '' then
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
			l.aColor(this.ability2)}, ' ')
	end

	local hiddenAbil = ''
	if this.abilityd then
		hiddenAbil = table.concat{'<div class="width-xl-50">',
			l.aColor(this.abilityd), '<div class="small-text">Abilit&agrave; nascosta</div></div>'}
	end

	return string.interp('<div class="flex flex-row flex-wrap flex-main-stretch flex-items-center width-xl-${boxWidth}" style="box-sizing: border-box; padding: 0.2em;">${forms}<div class="width-xl-${stdWidth}">${stdAbils}</div>${hiddenAbil}</div>',
	{
		boxWidth = this.abilityd and '100' or '50',
		stdWidth = this.abilityd and '50' or '100',
		forms = #this.labels < 1 and '' or table.concat{
			'<div class="small-text width-xl-100" style="padding-bottom: 0.2em;">',
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
	table.insert(acc, 1, '<div class="flex flex-row flex-wrap flex-main-stretch flex-items-center roundy text-center" style="background: #FFF; padding: 0.2em;">')
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
	local name = string.trim(frame.args[1] or '')
	name = string.parseInt(name) or mw.text.decode(name):lower()

	return list.makeFormsLabelledBoxes({
		name = name,
		makeBox = AbilsBox.new,
		printBoxes = printBoxes
	})
end

b.BoxAbil, b.box_abil, b.Box_abil = b.boxAbil, b.boxAbil, b.boxAbil

print(b.boxAbil{args={arg[1]}})
-- return b
