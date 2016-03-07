--[[

Libreria di funzioni di utilità per
i moduli che usano Sigle/data

--]]

local q = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local c = require('Colore-data')

--[[

Crea i link ai giochi contenuti in games,
visualizzandone le sigle come specificato
da singleDisplay.

Questa deve ritornare la visualizzazione di
una singola sigla, avendo come argomento una
coppia della subtable display degli elementi
di Sigle/data, ovvero:
    - primo elemento: sigla del gioco
    - secondo elemento: colore del gioco

--]]

q.abbrLinks = function(games, singleDisplay)
	return table.concat(table.map(games, function(data)
		return string.interp('[[${link}|${display}]]',
			{
				link = data.link,
				display = table.concat(table.map(data.display,
						singleDisplay))
			})
		end))
end

--[[

Crea i link ai giochi contenuti in games,
visualizzandone il testo usando display.

Questa deve ritornare la visualizzazione
del link, avendo come argomento il valore
dell'indice text, o link se il primo è
assente, degli elementi di Sigle/data

--]]

q.textLinks = function(games, display)
	local links = table.map(games, function(data)
		return string.interp('[[Pokémon ${link}|${display}]]',
			{
				link = data.link,
				display = display(data.text or data.link)
			})
		end)
	--[[
		Se l'ultimo link ha ' e ' nel testo visualizzato
		non serve aggiungerlo come separatore finale
	--]]
	return links[#links]:find('|.* e .*%]%]') and table.concat(links, ', ')
			or mw.text.listToText(links, ', ', ' e ')
end

--[[

Crea la sigla del gioco a partire i suoi dati, con
un eventuale separatore a dividere i giochi e con
lettere colorate se specificato.

--]]

q.displayAbbr = function(abbrData, sep, colored)
	local makeAbbr
	if colored then
		makeAbbr = function(abbr, color)
			return string.interp('<span style="color: #${c};">${a}</span>',
				{
					c = c[color].normale,
					a = abbr
				})
		end
	else
		makeAbbr = function(abbr) return abbr end
	end
		
	return table.concat(table.map(abbrData, function(gamesData)
			return table.concat(table.map(gamesData.display, function(displayData)
					return makeAbbr(displayData[1], displayData[2])
				end), sep)
		end), sep)
end

return q
