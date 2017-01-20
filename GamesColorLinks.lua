-- Dalle sigle dei giochi, ritorna il link agli stessi
-- del colore passato

local l = {}

local txt = require('Wikilib-strings')
local lib = require('Wikilib-sigle')
local s = require("Sigle-data")

-- Crea la funzione d'interfaccia per ogni sigla

for abbr, data in pairs(s) do
	l[abbr] = function(frame)
		--[[
			Ritorna il testo passato del colore
			specificato come argomento dal wikicode:
			dal momento che può ricevere come
			argomento solo il testo da visualizzare,
			deve essere una closure
		--]]
		local display = function(text)
			return string.interp('<span style="color:#${color}">${text}</span>',
				{
					color = string.trim(frame.args[1] or 'FFF'),
					text = text
				})
		end
		return lib.textLinks(data, display)
	end
end

-- print(l[arg[1]]{args={arg[2]}})
return l
