-- Libreria per il modulo Squadra

local lib = {}
local c = require('Colore-data')

-- Implementa lo switch sulla classe allenatore
trainerClass = {
	Grunt = 'Team Rocket Grunt',
	Admin = 'Executive'
}
trainerClass.Executive = trainerClass.Admin

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

Ritorna i valori esadecimali dei colori prendendoli dal
modulo colore/data qualora non siano già esadecimali.
Se chiamata con due tabelle utilizza la prima con sorgente
e aggiunge elementi alla seconda; se invece la seconda
non è presente, viene creata al suo posto una tabella vuota.

--]]

lib.gethex = function(sources, toadd)
	toadd = toadd or {}
	for k, v in pairs(sources) do
		toadd[k] = (c[v:match('(%S+)')] and c[v:match('(%S+)')][v:match('%s(%a+)') or 'normale']) or v
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
