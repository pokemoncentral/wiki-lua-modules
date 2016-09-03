-- Collegamenti ai giochi tramite le loro sigle: lettere colorate in campo trasparente

local x = {}

local txt = require('Wikilib-strings')
local lib = require('Wikilib-sigle')
local c = require("Colore-data")
local m = require("Sigle-data")

--[=[

Ritorna la sigla del gioco colorata
del colore corrispondente. Pair è una
coppia della subtable display degli
elementi di Sigle/data, ovvero:
    - primo elemento: sigla del gioco
    - secondo elemento: colore del gioco

--]=]

local singleDisplay = function(pair)
	return string.interp([[<span style="color:#${color};">'''${abbr}'''</span>]],
		{
			color = c[pair[2]].normale,
			abbr = pair[1]
		})
end

-- Crea la funzione d'interfaccia per ogni sigla

for abbr, data in pairs(m) do
	x[abbr] = function(frame) return lib.abbrLinks(data, singleDisplay) end
end

print(x[arg[1]]())
-- return x
