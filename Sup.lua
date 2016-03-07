-- Collegamenti in apice ai giochi tramite le sigle colorate

local x = {}

local txt = require('Wikilib-strings')
local lib = require('Wikilib-sigle')
local c = require('Colore-data')
local m = require('Sigle-data')

--[=[

Ritorna la sigla del gioco in apice e
colorata del colore corrispondente.
Pair è una coppia della subtable
display degli elementi di Sigle/data,
ovvero:
    - primo elemento: sigla del gioco
    - secondo elemento: colore del gioco

--]=]

local singleDisplay = function(pair)
	return string.interp([[<sup style="color:#${color};">'''${abbr}'''</sup>]],
		{
			color = c[pair[2]].normale,
			abbr = pair[1]
		})
end

-- Crea la funzione d'interfaccia per ogni sigla

for abbr, data in pairs(m) do
	x[abbr] = function(frame) return lib.abbrLinks(data, singleDisplay) end
end

return x
