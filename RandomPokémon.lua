--[[

Questo modulo sceglie un Pokémon randomicamente e ne
fa usi diversi in base alla funzione

--]]

local p = {}

local form = require('Wikilib-forms')
local tab = require('Wikilib-tables') -- luacheck: no unused
local txt = require('Wikilib-strings') -- luacheck: no unused
local data = require("Wikilib-data")
local pokedata = require("Poké-data")
local alt = require("AltForms-data")
local useless = require("UselessForms-data")

-- Ritorna un ndex randomico
local randomNdex = function()
	math.randomseed(os.time())
	return math.random(data.pokeNum)
end

-- Ritorna l'artwork di un Pokèmon random
p.artwork = function(frame)
	local dimensione = string.trim(frame.args[1] or '100')
	local num = tonumber(frame.args[2]) or randomNdex()
	local nome = pokedata[num].name
	local forme = nil
	alt = form.allFormsData()
	if alt[num] then
		forme = alt[num].gamesOrder
	end
	num = string.three_figures(num)
	if forme then
		num = num .. form.toEmptyAbbr(forme[math.random(table.getn(forme))], nome:lower())
	end

	return string.interp("[[File:Artwork${num}.png|center|${dimensione}x${dimensione}px|link=${nome}]]",
		{num = num, nome = nome, dimensione = dimensione})
end

print(p[table.remove(arg, 1)]{args=arg})
-- return p
