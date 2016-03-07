-- Libreria di funzioni sulle generazioni

local gens = {}

local tab = require('Wikilib-tables')
local data = require('Gens-data')

-- Il primo argomento è un indice delle sottotables delle tables delle
-- singole generazioni del modulo gensdata, mentre il secondo è un valore
-- da cercare in dette sottotables. Ritorna la generazione in cui si è
-- trovato il valore, o nil in caso contrario o di indice non valido

local searchThroughGens = function(index, value)
	for k, v in ipairs(data) do
		if type(v[index]) == 'table' and table.search(v[index], value) then
			return k
		end
	end
	return nil
end


-- Questa table contiene varie funzioni che ritornano la generazione di
-- appartenenza dell'argomento, o ' in caso di errore

gens.getGen = {}

gens.get_gen, gens.getgen = gens.getGen, gens.getGen

-- Ritorna la generazione dato il dex nazionale di un Pokémon

gens.getGen.ndex = function(ndex)
	ndex = tonumber(ndex)
	if not ndex then
		return 0
	end
	if ndex < 152 then
		return 1
	elseif ndex < 252 then
		return 2
	elseif ndex < 387 then
		return 3
	elseif ndex < 494 then
		return 4
	elseif ndex < 650 then
		return 5
	else
		return 6
	end
end

-- Ritorna la generazione del gioco passato come sigla

gens.getGen.game = function(abbr)
	return searchThroughGens('games', abbr:lower())
end

return gens
