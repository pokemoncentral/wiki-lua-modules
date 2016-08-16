-- Box dei tipi per il PokémonInfo

local b = {}

local mw = require('mw')

local l = require('Links')
local w = require('Wikilib')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local txt = require('Wikilib-strings')
local alts = require("AltForms-data")
local c = require("Colore-data")
local pokes = require("Poké-data")

--[[

Crea un Box. Un Box è una struttura dati che
rappresenta una casella del box dei tipi del
PokémonInfo: vi sono infatti i due tipi e una
table con i nomi delle forme che li hanno

--]]
local TypesBox = oop.makeClass(list.Labelled)

TypesBox.new = function(name, formName)
	local this = setmetatable(TypesBox.super.new(formName),
			TypesBox)

	local pokeData = pokes[name]
	this.type1, this.type2 = pokeData.type1, pokeData.type2
	this.width = 0

	return this
end

TypesBox.__eq = function(a, b)
	return a.type1 == b.type1 and a.type2 == b.type2
end

TypesBox.setWidth = function(this, width)
	this.width = width
end

TypesBox.__tostring = function(this)
	return string.interp('<div class="inline-block align-top" style="margin: 0 -1px; width: ${width}%;">${type1}${type2}${forms}</div>',
	{
		width = this.width,
		type1 = l.typeColor(this.type1),
		type2 = this.type1 == this.type2 and '' or l.typeColor(this.type2),
		forms = #this.labels < 1 and '' or table.concat{
			'<div class="small-text">',
			mw.text.listToText(this.labels, ', ', ' e '),
			'<div>'
		}
	})
end

-- Stampa in HTML una riga di Boxes
local printLine = function(line)
	local width = math.floor(100 / #line)

	return w.mapAndConcat(line, function(box)
			box:setWidth(width)
			return tostring(box)
		end)
end

--[[

Stampa in HTML una table di Boxes: questi sono
suddivisi in righe da tre finché non ne rimangono
o quattro, caso in cui sono divisi in due righe
da due, o meno di quattro, caso in cui invece
si fa una sola riga

--]]

local printBoxes = function(boxes)
	local acc = {'<div class="roundy" style="background: #FFF; padding: 5px 2px;">'}

	repeat
		local line, size = nil, #boxes
		--[[
			Si rimuove sempre in prima posizione perché
			lua aggiorna gli indici dopo ogni table.remove
		--]]
		if size > 4 then
			line = {
				table.remove(boxes, 1),
				table.remove(boxes, 1),
				table.remove(boxes, 1)
			}
		elseif size == 4 then
			line = {
				table.remove(boxes, 1),
				table.remove(boxes, 1)
			}
		else
			line = {}
			for k = 1, size do
				table.insert(line, table.remove(boxes, 1))
			end
		end
		table.insert(acc, '<div>')
		table.insert(acc, printLine(line))
		table.insert(acc, '</div>')
	until #boxes == 0
	
	table.insert(acc, '</div>')	
	return table.concat(acc)
end

--[[

Dato il nome di un Pokémon o il suo ndex,
ritorna il box dei tipi, con una cella
per ogni diversa combinazione di tipi
delle forme alternative, con sotto i nomi
delle forme che li hanno

--]]
b.boxTipi = function(frame)
	local name = string.trim(frame.args[1] or ''):lower()
	local pokeData = pokes[string.parseInt(name) or name]
			or pokes[mw.text.decode(name)]
	name = pokeData.name:lower()
	local altData = alts[name]
	
	--[[
		Il Pokémon non ha forme alternative,
		o le ha ma non cambiano tipo: si
		ritorna un solo box senza forme
	--]]
	if not (altData and altData.changetype) then
		return tostring(TypesBox.new(name))
	end

	return list.makeFormsLabelledBoxes({
		name = name,
		makeBox = TypesBox.new,
		printBoxes = printBoxes
	})
end

b.BoxTipi, b.box_tipi, b.Box_tipi = b.boxTipi, b.boxTipi, b.boxTipi

print(b.boxTipi{args={arg[1]}})
-- return b
