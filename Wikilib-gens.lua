-- Libreria di funzioni sulle generazioni

local gens = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local data = require("Gens-data")
-- stylua: ignore end

-- Il primo argomento è un indice delle sottotables delle tables delle
-- singole generazioni del modulo gensdata, mentre il secondo è un valore
-- da cercare in dette sottotables. Ritorna la generazione in cui si è
-- trovato il valore, o nil in caso contrario o di indice non valido

local searchThroughGens = function(index, value)
    for k, v in ipairs(data) do
        if type(v[index]) == "table" and tab.search(v[index], value) then
            return k
        end
    end
    return nil
end

--[[

Returns whether the passed generation is valid,
that is a number between 1 and `latest`

--]]
gens.isValidGen = function(gen)
    return type(gen) == "number" and gen > 0 and gen <= data.latest
end
gens.isvalidgen, gens.is_valid_gen = gens.isValidGen, gens.isValidGen

-- Questa table contiene varie funzioni che ritornano la generazione di
-- appartenenza dell'argomento, o ' in caso di errore

gens.getGen = {}

gens.get_gen, gens.getgen = gens.getGen, gens.getGen

-- Ritorna la generazione dato il dex nazionale di un Pokémon

gens.getGen.ndex = function(ndex)
    ndex = tonumber(ndex)

    if not ndex then
        return data.latestGen + 1
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
    elseif ndex < 722 then
        return 6
    elseif ndex < 810 then
        return 7
    elseif ndex < 906 then
        return 8
    elseif ndex < 1011 then
        return 9
    end
end

-- Ritorna la generazione del gioco passato come sigla

gens.getGen.game = function(abbr)
    return searchThroughGens("games", abbr:lower())
end

gens.latest = {}

-- The latest game
gens.latest.game = data[data.latest].games[#data[data.latest].games]

-- Whether a given ndex is internal or real. Internal means that we use it, but
-- it has never been confirmed by official sources, such as Pokémon HOME
gens.isNdexInternal = function(ndex)
    return false
end

-- Given an ndex, return the appropriate string representation. Takes care of
-- possibly nil as well as internal ndexes.
gens.ndexToString = function(ndex)
    if not ndex or gens.isNdexInternal(ndex) then
        return "???"
    end
    return txt.tf(ndex)
end

return gens
