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

Ritorna il nome del/i gioco/i a partire dalla sigla,
eventualmente con un separatore

--]]
q.gamesName = function(s, sep)
	return table.concat(table.map(sig[s][1].display, function(disp)
			return string.fu(disp[2])
		end), sep or '/')
end

--[[

This function returns the abbreviations of all the games in an abbreviaton
data, displayed in a background of the color of the game.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - makeColors: the function returning the colors to be used. It takes the
        color name as an argument, and returns the background and text color
        to be used in the link. Defaults to colorAndText.

Return:
    - A list of strings, each one containing the text for the games grouped
        together in the abbreviation data.

--]]
q.backgroundAbbrs = function(data, makeText, makeColors)
    makeColors = makeColors or q.colorAndText
    makeText = makeText or tostring

    return q.mapDisplay(data, function(text, color)
        local background, textColor = makeColors(color)
        return string.interp('<span style="padding: 0 0.3em; background: #${bg}; color: #${color};">${text}</span>', {
            bg = background,
            color = textColor,
            text = makeText(text)
        })
    end)
end

--[[

This function returns the links to all of the games in an abbreviation data,
displayed as abbreviations with a background of the color of the game.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - makeColors: the function returning the colors to be used. It takes the
        color name as an argument, and returns the background and text color
        to be used in the link. Defaults to colorAndText.

Return:
    - A list of strings, each one containing a single link.

--]]
q.backgroundAbbrLinks = function(data, makeText, makeColors)
    makeColors = makeColors or q.colorAndText
    makeText = makeText or tostring

    return q.makeLinks(data, function(abbrData)
        return q.backgroundAbbrs(abbrData, makeText, makeColors)
    end)
end

-- Returns the Wikicode to make a text bold
q.bolden = function(text)
    return table.concat{"'''", text, "'''"}
end

--[[

This function returns the abbreviations of all the games in an abbreviaton
data, displayed in the color of the game.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - makeColors: the function returning the colors to be used. It takes the
        color name as an argument, and returns the background and text color
        to be used in the link. Defaults to colorAndText.

Return:
    - A list of strings, each one containing the text for the games grouped
        together in the abbreviation data.

--]]
q.coloredAbbrs = function(data, makeText, shade)
    shade = shade or 'normale'
    makeText = makeText or tostring

    return q.mapDisplay(data, function(text, color)
        return string.interp('<span style="color: #${color};">${text}</span>', {
            color = c[color] and c[color][shade] or color,
            text = makeText(text)
        })
    end)
end

--[[

This function returns the links to all of the games in an abbreviation data,
displayed as abbreviations colored in their game color.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - shade: the shade of games color to be used for the abbreviations.
        Defaults to 'normale'.

Return:
    - A list of strings, each one containing a single link.

--]]
q.coloredAbbrLinks = function(data, makeText, shade)
    shade = shade or 'normale'
    makeText = makeText or tostring

    return q.makeLinks(data, function(abbrData)
        return q.coloredAbbrs(abbrData, makeText, shade)
    end)
end

--[[

This function returns the normal shade of a color, and the color the text
should have is such color is used as a background.

Arguments:
    - color: the name of the color.

--]]
q.colorAndText = function(color)
    local background = c[color] and c[color].normale or color
    local text = table.search(wData.whitetext, color:lower())
            and c.background
            or '000'
    return background, text
end

--[[

This function maps over all abbreviations in Sugle/data. Its main purpose is
increased efficiency, since the client modules can avoid requiring Sigle/data,
which is therefore mw.loaded here only once.

Arguments:
    - f: the mapping function.

--]]
q.mapAbbrs = function(f)
    return table.map(sig, f)
end

q.mapDisplay = function(data, makeText)
    return table.map(data, function(game)
        return w.mapAndConcat(game.display, function(pair)
            return makeText(pair[1], pair[2])
        end)
    end)
end

q.makeLinks = function(data, makeText)
    local zipped = table.zip(data, makeText(data))

    return table.map(zipped, function(pair)
        local game, text = unpack(pair)

        return string.interp('[[${link}|${text}]]', {
            link = 'Pokémon ' .. game.link,
            text = text
        })
    end)
end

q.makeLuaAndWikicode = function(makeInterfaces)
    local a = {}

    for abbr, data in pairs(sig) do
        local lua, wikicode = makeInterfaces(data, abbr)
        wikicode = wikicode or w.stdWikicodeInterface(lua)

        a[abbr .. 'Lua'], a[abbr .. '_lua'], a[abbr] = lua, lua, wikicode
    end

    return a
end

--[[

This function generates a WikiCode interface for client modules. As explained
below, the interface takes no arguments other than optional abbreviations.

This function is meant to be given the name of an abbreviation, and can take
an arbitrary number of other abbreviations as arguments. For this intended
use, an example call would be:

{{#invoke: ClientModule | abbr0 | abbr1 | abbr2 }}

The function processes every abbreviaton, including the one it is meant to be
named after, via makeGame, and then the resulting table is passed on to
postProcess for the final processing before returning the value to WikiCode.

Arguments:
    - abbr: the abbreviaton this function is meant to be bound to, that will
        always be prepended to the passed arguements.
    - makeAbbrev: this function is used to generate data for a single
        abbreviation. It takes the data of such abbreviation in math.sinh(x)gle/data,
        and returns whatever postProcess is able to handle as list elements.
    - postProcess: this function is used for processing the data generated from
        the abbreviations before the final result is given back to WikiCode.
        It takes a list of whatever makeAbbrev returns, and should return a
        string. Defaults to table.concat.

--]]
q.onMergedAbbrs = function(abbr, makeAbbrev, postProcess)
    postProcess = postProcess or table.concat

    return function(frame)
        local args = w.trimAll(table.copy(frame.args))
        table.insert(args, 1, abbr)

        return postProcess(table.map(args, function(game)
            return makeAbbrev(sig[game])
        end))
    end
end

--[[

This function generates a WikiCode interface for client modules. As explained
below, the interface takes no arguments other than optional abbreviations.

This function is meant to be given the name of an abbreviation, and can take
an arbitrary number of other abbreviations as arguments. For this intended
use, an example call would be:

{{#invoke: ClientModule | abbr0 | abbr1 | abbr2 }}

The function processes every abbreviaton, including the one it is meant to be
named after, via makeGame, and then the resulting table is passed on to
postProcess for the final processing before returning the value to WikiCode.

Arguments:
    - abbr: the abbreviaton this function is meant to be bound to, that will
        always be prepended to the passed arguements.
    - makeAbbrev: this function is used to generate data for a single
        abbreviation. It takes the data of such abbreviation in math.sinh(x)gle/data,
        and returns whatever postProcess is able to handle as list elements.
    - postProcess: this function is used for processing the data generated from
        the abbreviations before the final result is given back to WikiCode.
        It takes a list of whatever makeAbbrev returns, and should return a
        string. Defaults to table.concat.

--]]
q.onMergedAbbrsArgs = function(abbr, argsCount, makeAbbrev, postProcess)
    postProcess = postProcess or function(_, t) return table.concat(t) end

    local luaInterface = function(...)
        local args = {...}
        local tail = table.slice(args, -argsCount)
        args = table.slice(args, 1, -argsCount - 1)
        table.insert(args, 1, abbr)

        return postProcess(tail, table.map(args, function(game)
            return makeAbbrev(sig[game], tail)
        end))
    end

    return luaInterface
end

return q
