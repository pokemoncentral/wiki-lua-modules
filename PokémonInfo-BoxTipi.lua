-- Box dei tipi per il PokémonInfo

local b = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local l = require('Links')
local pokes = require('Poké-data')
-- AltForms/data should stay require, mw.loadData messes with table library
local forms = require('AltForms-data') 
local c = require('Colore-data')

--[[

Crea un Box. Un Box è una struttura dati che
rappresenta una casella del box dei tipi del
PokémonInfo: vi sono infatti i due tipi e una
table con i nomi delle forme che li hanno

--]]

local makeBox = function(type1, type2, form)
	return {type1 = type1, type2 = type2, forms = {form}}
end

-- Controlla se i due tipi passati sono quelli di un box dato

local sameTypes = function(box, type1, type2)
	return box.type1 == type1 and box.type2 == type2;
end

-- Stampa in HTML una riga di Boxes			

local printLine = function(line)
	local width = math.floor(100 / #line)

	return table.concat(table.map(line, function(box)
			return string.interp('<div class="inline-block align-top" style="margin: 0 -1px; width: ${width}%;">${type1}${type2}<div class="small-text">${forms}</div></div>',
				{
					width = width,
					type1 = l.typeColor(box.type1),
					type2 = box.type1 == box.type2 and '' or l.typeColor(box.type2),
					forms = mw.text.listToText(box.forms, ', ', ' e ')
				})
		end))
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
	local name = (pokes[string.trim(frame.args[1]:lower())]
			or pokes[tonumber(frame.args[1])]).name:lower()
	local altData = forms[name]
	
	-- Il Pokémon non ha forme alternative: si ritornano solo i tipi

	if not (altData and altData.changetype) then
		local pokeData = pokes[name]
		return string.interp('<div class="roundy" style="background: #FFF; padding: 5px 2px;">${type1}${type2}</div>',
			{
				type1 = l.typeColor(pokeData.type1),
				type2 = pokeData.type1 == pokeData.type2
						and '' or l.typeColor(pokeData.type2)
			})
	end

	-- Il primo Box è quello della forma base

	local boxes = {
		makeBox(pokes[name].type1, pokes[name].type2, altData.names.base)
	}
	--[[
		Si toglie la forma base (che ha sempre indice 1)
		dal gamesOrder, poiché è già stata inserita
	--]]	
	table.remove(altData.gamesOrder, 1)

	--[[
		Scorrendo gamesOrder i Box saranno già ordinati
		senza bisogno di sorting successivo
	--]]
	for k, abbr in ipairs(altData.gamesOrder) do
		local formPoke = pokes[name .. abbr]
		local formPlaced = false
		
		-- Bisogna controllare se i tipi della forma siano già in un altro Box

		for k, box in ipairs(boxes) do
			if sameTypes(box, formPoke.type1, formPoke.type2) then
				table.insert(box.forms, altData.names[abbr])
				formPlaced = true
				break
			end
		end
		--[[
			Non si può inserire nel for qua sopra perché ipairs
			giustamente includerebbe il nuovo Box nel loop
		--]]
		if not formPlaced then
			table.insert(boxes, makeBox(formPoke.type1, formPoke.type2,
					altData.names[abbr]))
		end
	end

	return printBoxes(boxes)
end

b.BoxTipi, b.box_tipi, b.Box_tipi = b.boxTipi, b.boxTipi, b.boxTipi

print(b.boxTipi{args={arg[1]}})
-- return b
