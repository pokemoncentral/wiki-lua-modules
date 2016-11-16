--[[

Libreria per il modulo PokéAbil/data per
gestire meglio i cambi di abilità tra generazioni

--]]

local al = {}

local tab = require('Wikilib-tables')
local gen = require("Gens-data")

--[[

Ritorna un numero random compreso tra i due
argomenti, presi come estremo inferiore (primo)
e superiore (secondo) dell'intervallo

--]]
al.lastabils = function(abil)
	return table.map(abil, function(v)
		if (type(v) == 'string') then
			return v
		end
		for i=gen.lastGen,3,-1 do
			if (v[i]) then
				return v[i]
			end
		end
	end)
end

al.lastAbils, al.Lastabils, al.LastAbils =
	al.lastabils, al.lastabils, al.lastabils

--[[

Ritorna una table contenente le varie abilità del
Pokémon sotto forma di table con un elemento abil
e due elementi first e last, che contengono la prima
e l'ultima generazione in cui il Pokémon ha quella
abilità.

Se il parametro è una stringa, ritorna semplicemente la stringa

--]]
al.abilspan = function(abil)
	if type(abil) == 'string' then
		return abil
	end
	local as = { {abil = 'placeholder', s = 2, e = 2} }
	for i=3,gen.lastGen do
		if (abil[i]) then
			table.insert(as, {abil = abil[i], s = i, e = i})
		else
			as[#as].e = i
		end
	end
	table.remove(as, 1)
	return as
end

al.abilSpan, al.Abilspan, al.AbilSpan =
	al.abilspan, al.abilspan, al.abilspan

return al
