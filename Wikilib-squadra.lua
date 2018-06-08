-- Libreria per il modulo Squadra

local lib = {}
local c = require("Colore-data")

-- Implementa lo switch sulla classe allenatore
lib.trainerClass = {
	Grunt = 'Team Rocket Grunt',
	Admin = 'Executive'
}
lib.trainerClass.Executive = lib.trainerClass.Admin

-- Mette il giusto numero di Poké Ball vuote e piene in fondo alla tabella

lib.balls = function(num1, num2)
	local party = {'[[File:Ballfull.png]]'}
	for a = 2, num1 do
		table.insert(party, '[[File:Ballfull.png]]')
	end
	for a = num1 + 1, num2 and 3 or 6 do
		table.insert(party, '[[File:Ballempty.png]]')
	end
	if num2 then
		for a = 1, num2 do
			table.insert(party, '[[File:Ballfull.png]]')
		end
		for a = num2 + 1, 3 do
			table.insert(party, '[[File:Ballempty.png]]')
		end
	end
	return table.concat(party)
end

--[[

Takes a string that can be both a color name (possibly followed by a variant)
or an hex. In the former case returns the pair (name, variant), in the latter
returns the hex, adding a leading hash if needed.

--]]

lib.getColor = function(colorString)
	local colorName = colorString:match('(%S+)')
	if c[colorName] then
		return colorName, colorString:match('%s(%a+)') or 'normale'
	end
	return colorString:find('%X') and '#' .. colorString or colorString
end

--[[

Ritorna i valori esadecimali dei colori prendendoli dal
modulo colore/data qualora non siano già esadecimali.
Se chiamata con due tabelle utilizza la prima come sorgente
e aggiunge elementi alla seconda; se invece la seconda
non è presente, viene creata al suo posto una tabella vuota.

--]]

lib.gethex = function(sources, toadd)
	toadd = toadd or {}
	for k, v in pairs(sources) do
		local name, var = lib.getColor(v)
		toadd[k] = var and c[name][var] or name
	end
	return toadd
end

-- Dà la giusta impaginazione ai Box dei Pokémon

lib.party = function(poke, separator)
	for k, v in pairs(poke) do
		poke[k] = '|\n' .. v
	end
	if #poke > 4 then
		table.insert(poke, 4, separator)
	elseif #poke == 4 then
		table.insert(poke, 3, separator)
	end
	return table.concat(poke, '\n')
end

return lib
