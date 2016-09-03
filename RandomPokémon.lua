--[[

Questo modulo sceglie un Pokémon randomicamente e ne
fa usi diversi in base alla funzione

--]]

local p = {}

local form = require('Wikilib-forms')
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local ot = require('Wikilib-others')
local data = require("Wikilib-data")
local pokedata = require("Poké-data")
local alt = require("AltForms-data")
local useless = require("UselessForms-data")

-- Ritorna un ndex randomico

local randomNdex = function()
	math.randomseed(os.time())
	return math.random(data.pokeNum)
--	return ot.random(data.pokeNum)
end

--[[

Ritorna le forme alternative nella nomenclatura degli artwork.
Si aspetta la sigla della forma e il nome del Pokémon

--]]

local getArtworkForm = function(abbr, name)

	-- Forma base

	if abbr == 'base' then
		return ''
	end

	formName = (alt[name] or useless[name]).names[abbr]

	-- Mega e archeo evoluzioni

	if form.hasMega(name) then
		return table.concat{'-', abbr:find('M') and 'Mega' or 'Archeo',
			formName:match(' [XY]') or ''}
	end

	--[[

	Altre forme alternative: è necessario rimuovere
	un'eventuale prima parola, es 'Forma' o 'Manto'

	--]]

	return '-' .. (formName:match('%S*%s(.+)') or formName)
end

-- Ritorna l'artwork di un Pokèmon random

p.artwork = function(frame)
	local dimensione = string.trim(frame.args[1] or '100')
	local num = tonumber(frame.args[2]) or randomNdex()
	local nome = pokedata[num].name
	local forme = nil
	if alt[num] then
		forme = alt[num].gamesOrder
	elseif useless[num] then
		forme = useless[num].gamesOrder
	end
	num = string.three_figures(num)
	if forme then
		num = num .. getArtworkForm(forme[math.random(table.getn(forme))], nome:lower())
	end
	return string.interp("[[File:Artwork${num}.png|center|${dimensione}x${dimensione}px|link=${nome}]]",
		{num = num, nome = nome, dimensione = dimensione})
end

print(p[table.remove(arg, 1)]{args=arg})
-- return p
