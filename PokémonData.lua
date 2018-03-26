--[[

Module used as a frontend to wikicode for data modules

--]]

local b = {}

-- Data modules aren't loaded here because they probably won't be used

local txt = require('Modulo:Wikilib/strings')
local data
local abils

--[[

Ritorna la table dati passata come argomento
se questa è già stata caricata, altrimenti
ritorna il modulo passato come secondo argomento

--]]

local loadData = function(tab, moduleName)
	if not tab then
		return mw.loadData('Modulo:' .. moduleName)
	end
	return tab
end

--[[

Ritorna l'abilità richiesta al secondo argomento
del Pokémon il cui nome o ndex è passato al primo
argomento

--]]

local getAbil = function(name, abilityNumber)
	abils = loadData(abils, 'PokéAbil/data').pokeabil
	return abils[tonumber(name) or name]['ability' .. abilityNumber]
end

-- Ritorna il dex nazionale dato il nome

b.getNdex = function(frame)
	data = loadData(data, 'Poké/data').pokedata
	return string.tf(data[string.trim(frame.args[1] or ''):lower()].ndex)
end

b.get_ndex = b.getNdex

-- Ritorna il nome dato il dex nazionale

b.getName = function(frame)
	data = loadData(data, 'Poké/data').pokedata
	return data[tonumber(string.trim(frame.args[1] or ''))].name
end

b.get_name = b.getName

-- Ritorna la prima abilità dato il nome o dex nazionale

b.getAbil1 = function(frame)
	return getAbil(string.trim(frame.args[1] or ''):lower(), '1')
end

b.get_abil_1 = b.getAbil1

-- Ritorna la seconda abilità dato il nome o dex nazionale

b.getAbil2 = function(frame)
	return getAbil(string.trim(frame.args[1] or ''):lower(), '2')
end

b.get_abil_2 = b.getAbil2

-- Ritorna l'abilità nascosta dato il nome o dex nazionale

b.getAbild = function(frame)
	return getAbil(string.trim(frame.args[1] or ''):lower(), 'd')
end

b.get_abil_d, b.get_abil_h, b.get_abil_n = b.getAbild, b.getAbild, b.getAbild

--[[

Frontend for wikilib/forms.getlink: returns the link
to an'alternate form from module AltForms/data or
UselessForms/data.
The Pokémon name (first argument) can be both a name
or a ndex followed by the form abbreviation, the second
argument is a flag to get black or normal link

--]]

b.getLink = function(frame)
	local forms = require('Modulo:Wikilib/forms')
	local name, black = string.trim(frame.args[1]), string.trim(frame.args[2])
	local link = forms.getLink(name, black)
	if link ~= '' then
		return link
	else
		forms.loadUseless(false)
		return forms.getLink(name, black)
	end
end

b.getlink = b.getLink

return b
