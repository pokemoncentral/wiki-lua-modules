-- Collegamenti ai giochi tramite le loro sigle: campo colorato e testo nero/bianco

local x = {}

local txt = require('Wikilib-strings')
local lib = require('Wikilib-sigle')
local c = require("Colore-data")
local m = require("Sigle-data")
local wd = require("Wikilib-data")

--[=[

Ritorna la sigla del gioco sullo sfondo
del colore corrispondente. Pair è una
coppia della subtable display degli
elementi di Sigle/data, ovvero:
    - primo elemento: sigla del gioco
    - secondo elemento: colore del gioco

--]=]

local singleDisplay = function(pair)
   return string.interp([[<span style="padding: 0 0.3em; color:#${text}; background: #${colore};">'''${sigla}'''</span>]],
	{
		text = table.search(wd.whitetext, pair[2]:lower()) and c.background or '000',
		colore = c[pair[2]].normale,
		sigla = pair[1],
	})
end

-- Crea la funzione d'interfaccia per ogni sigla

for abbr, data in pairs(m) do
	x[abbr] = function(frame) return lib.abbrLinks(data, singleDisplay) end
end

return x
