--[[

Libreria di funzioni di utilità per
i moduli che usano Sigle/data

--]]

local q = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local w = require('Wikilib')
local c = require("Colore-data")
local sig = require("Sigle-data")
local wData = require("Wikilib-data")

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
		return string.interp('[[Pokémon ${link}|${display}]]',
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
lettere colorate e in grassetto se specificato.

--]]

q.displayAbbr = function(abbrData, sep, coloredAndBold)
	local makeAbbr
	if coloredAndBold then
		makeAbbr = function(abbr, color)
			return string.interp([[<span style="color: #${c};">'''${a}'''</span>]],
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

--[[

Ritorna il nome del/i gioco/i a partire dalla sigla,
eventualmente con un separatore

--]]
q.gamesName = function(s, sep)
	return table.concat(table.map(sig[s][1].display, function(disp)
			return string.fu(disp[2])
		end), sep or '/')
end


--[[

This function returns the links to all of the games in an abbreviation data,
displayed as abbreviations with a background of the color of the game.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - makeColors: the function returning the colors to be used. It takes the
        color name as an argument, and returns the background and text color
        to be used in the link. Defaults to gameColors.

Return:
    - A list of strings, each one containing a single link.

--]]
q.backgroundAbbrevLinks = function(data, makeText, makeColors)
    makeColors = makeColors or q.gameColors
    makeText = makeText or tostring

    return q.makeLinks(data, function(text, color)
        local background, textColor = makeColors(color)
        return string.interp('<span style="padding: 0 0.3em; background: #${bg}; color: #${color};">${text}</span>', {
            bg = background,
            color = textColor,
            text = makeText(text)
        })
    end)
end

-- Returns the Wikicode to make a text bold
q.bolden = function(text)
    return table.concat{"'''", text, "'''"}
end

q.coloredAbbrevLinks = function(data, makeText, shade)
    shade = shade or 'normale'
    makeText = makeText or tostring

    return q.makeLinks(data, function(text, color)
        return string.interp('<span style="color: #${color};">${text}</span>', {
            color = c[color] and c[color][shade] or color,
            text = makeText(text)
        })
    end)
end

q.gameColors = function(game)
    local background = c[game] and c[game].normale or game
    local text = table.search(wData.whitetext, game:lower())
            and c.background
            or '000'
    return background, text
end

q.makeLinks = function(data, makeText)
    return table.map(data, function(game)
        local text = w.mapAndConcat(game.display, function(pair)
            return makeText(unpack(pair))
        end)

        return string.interp('[[${link}|${text}]]', {
            link = 'Pokémon ' .. game.link,
            text = text
        })
    end)

end

q.onMergedAbbrs = function(abbr, makeGame, postProcess)
    postProcess = postProcess or table.concat

    return function(frame)
        local args = mw.clone(frame.args)
        table.insert(args, 1, abbr)

        return postProcess(table.map(args, function(game)
            return makeGame(sig[game])
        end))
    end
end

return q
