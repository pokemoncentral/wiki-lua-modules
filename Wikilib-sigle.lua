--[[

Utility function for modules using Sigle/data

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
data, displayed in a background of the color of the game, or a very light gray
if the game has no color.

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
displayed as abbreviations with a background of the color of the game, or
a very light gray if the game has no color.

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
data, displayed in the specified color and shade. The color can be passed as
an hexadecimal or as a named color; it defaults to each game's own color, or
black if the game has no color. The shade default is 'normale'.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - textColor: The color the abbreviations should have. Can be a named color
        or an hexadecimal Defaults to each game's own color.
    - shade: The shade of the color to use. Defaults to 'normale'.

Return:
    - A list of strings, each one containing the text for the games grouped
        together in the abbreviation data.

--]]
q.coloredAbbrs = function(data, makeText, textColor, shade)
    shade = shade or 'normale'
    makeText = makeText or tostring

    return q.mapDisplay(data, function(text, gameColor)
        -- If the game has no color, using the text color from q.colorAndText
        local color = textColor or gameColor or ({q.colorAndText()})[2]
        return string.interp('<span style="color: #${color};">${text}</span>', {
            -- This is ok also for when c[color][shade] evaluates to false
            color = c[color] and c[color][shade] or color,
            text = makeText(text)
        })
    end)
end

--[[

This function returns the links to all of the games in an abbreviation data,
displayed displayed in the specified color and shade. The color can be passed
as an hexadecimal or as a named color; it defaults to each game's own color, or
black if the game has no color. The shade default is 'normale'.

Arguments:
    - data: the data of an abbreviation, from module Sigle/data.
    - makeText: the function creating the text to be displayed. It takes the
        abbreviation of a single game, and returns the text to be displayed
        in the link. Defaults to tostring.
    - textColor: The color the abbreviations should have. Can be a named color
        or an hexadecimal Defaults to each game's own color.
    - shade: the shade of games color to be used for the abbreviations.
        Defaults to 'normale'.

Return:
    - A list of strings, each one containing a single link.

--]]
q.coloredAbbrLinks = function(data, makeText, textColor, shade)
    shade = shade or 'normale'
    makeText = makeText or tostring

    return q.makeLinks(data, function(abbrData)
        return q.coloredAbbrs(abbrData, makeText, textColor, shade)
    end)
end

--[[

This function takes as input a color as found in the elements if display key
in abbreviation data. It returns two hexadecimal colors: the first one is the
passed color one, the second one is the color the text should have if the first
color is used as a background.

The color can be passed in the following formats. A named color, in which case
the normale shade will be returned. An hexadecimal, that will be returned
unchanged: however, in this case the text color will always be black. Nil, that
implies returning a very light gray and black, as background and text color
respectively.

Arguments:
    - color: input color, as found in display keys items.

--]]
q.colorAndText = function(color)
    if not color then
        return c.background, '000'
    end

    -- This is ok also for when c[color].normale evaluates to false
    local background = c[color] and c[color].normale or color
    local text = table.search(wData.whitetext, color:lower())
            and c.background
            or '000'

    return background, text
end

--[[

This function concatenates the string representation of the passed
abbreviations, as found in the given data module. Every non-found abbreviaton
will have the empty string as its string representation.

Arguments:
    - abbrs: The abbreviations to be merged, as a space separated string or as
        a table
    - dataModule: The data module holding the content that will be
        concatenated.

--]]
q.concatAbbrs = function(abbrs, dataModule)
    abbrs = type(abbrs) == 'string' and mw.text.split(abbrs, ' ') or abbrs

    return w.mapAndConcat(abbrs, function(abbr)
        return dataModule[abbr] or ''
    end)
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

--[[

This function maps over the display key of every game in the passed
abbreviation data. The results of the mapping are concatenated for every
display property, so that the returned table is one-dimensioned.

Arguments:
    - data: The source abbreviation data.
    - makeText: The mapping function. It takes as parameters the two elements
        of display key elements, that is the abbreviation and the color of a
        game. Must return a string.

Return:
    - A list of string, each one resulting from the concatenation of the items
        in the display key of a game, after mapping.

--]]
q.mapDisplay = function(data, makeText)
    return table.map(data, function(game)
        return w.mapAndConcat(game.display, function(pair)
            return makeText(pair[1], pair[2])
        end)
    end)
end

--[[

This function returns a list of links from the passed abbreviation data. The
links target is the page in the link key of every game in the data, while the
displayed text is obtained by mapping with the specified function.

Arguments:
    - data: The source abbreviation data.
    - makeText: The mapping function that produces the text to be displayed
        for every game in the abbreviation data. Takes such data as an
        argument, and must return a table with the text for every game in the
        data, in the same order as they are in the abbreviation data.

Return:
    - A list of links, one for each game in the abbreviation data.

--]]
q.makeLinks = function(data, makeText)
    local zipped = table.zip(data, makeText(data))

    return table.map(zipped, function(pair)
        local game, text = unpack(pair)

        return string.interp('[[${link}|${text}]]', {
            link = game.link,
            text = text
        })
    end)
end

--[[

This function returns a table containing interface functions, both for lua and
wikicode. Wikicode interfaces are named after abbreviations, while lua
interfaces have the 'Lua' and '_lua' suffixes.

The interfaces are created by means of makeInterfaces, that must return at
least the lua function: the wikicode interface defaults to the standard one
calling the lua interface as in Wikilib.stdWikicodeInterface.

Arguments:
    - makeInterfaces: This is the functino used to generate the lua interfaces,
        and optionally the wikicode ones. Its parameters are abbreviation data
        and its abbreviation. Must return the lua function and optionally the
        wikicode one.

--]]
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

This function is meant to be named after an abbreviation, and can take an
arbitrary number of additional abbreviations as arguments, even
space-seaparated within a single argument. For this intended use, an example
call would be:

{{#invoke: ClientModule | abbr0 | abbr1 | abbr2 abbr3 | abbr4 }}

The returned function processes every abbreviaton, including the one it is
meant to be named after, via makeGame, and then the resulting table is passed
on to postProcess for the final processing before returning the value to
WikiCode.

Arguments:
    - abbr: the abbreviaton this function is meant to be bound to, that will
        always be prepended to the passed arguments.
    - makeAbbrev: this function is used to generate data for a single
        abbreviation. It takes the data of such abbreviation in Sigle/data,
        and returns whatever postProcess is able to handle as its list items.
    - postProcess: this function is used for processing the data generated from
        the abbreviations before the final result is given back to WikiCode.
        It takes a list of whatever makeAbbrev returns, and should return a
        string. Defaults to table.concat.

--]]
q.onMergedAbbrs = function(abbr, makeAbbrev, postProcess)
    postProcess = postProcess or table.concat

    return function(frame)
        local args = w.trimAll(table.copy(frame.args))
        args = table.flatMap(args, function(argument)
            return mw.text.split(argument, ' ')
        end)
        table.insert(args, 1, abbr)

        return postProcess(table.map(args, function(game)
            return makeAbbrev(sig[game])
        end))
    end
end

--[[

This function generates a lua interface for client modules. As explained
below, the interface takes a single table, containing both arbitrary arguments
and extra abbreviations.

This function is meant to be named after an abbreviation, and takes as
argument a single table. One of the keys is meant to store some extra
abbreviations, either as a table or as a space-separated list. The other items
are the other arguments that the function needs.

Some example calls:

myModule.abbr0{games = {'abbr1', 'abbr2'}, arg1, arg2, arg3)
myModule.abbr0{games = 'abbr1 abbr2', arg1, arg2, arg3)
myModule.abbr0{arg1, arg2, arg3}

The returned function processes every abbreviaton, including the one it is
meant to be named after, via makeGame, and then the resulting table is passed
on to postProcess for the final processing before returning the value to
WikiCode.

Arguments:
    - abbr: the abbreviaton this function is meant to be bound to, that will
        always be prepended to the passed arguments.
    - abbrKey: the key of the table the abbreviations are stored at.
        Defaults to 'games'
    - makeAbbrev: this function is used to generate data for a single
        abbreviation. It takes the data of such abbreviation in Sigle/data and
        the fixed final arguments packed in a table. It returns whatever
        postProcess is able to handle as its list elements.
    - postProcess: this function is used for processing the data generated from
        the abbreviations before the final result is given back to WikiCode.
        It takes the fixed final arguments packed in a table and a list of
        whatever makeAbbrev returns, and should return a string. Defaults to
        a function concatenating the second argument.

--]]
q.onMergedAbbrsArgs = function(abbr, abbrKey, makeAbbrev, postProcess)
    postProcess = postProcess or function(_, t) return table.concat(t) end
    abbrKey = abbrKey or 'games'

    local luaInterface = function(args)
        local abbrs = args[abbrKey] or {}

        if type(abbrs) == 'string' then
            abbrs = abbrs == '' and {} or mw.text.split(abbrs, ' ')
        end
        table.insert(abbrs, 1, abbr)

        args[abbrKey] = nil

        return postProcess(args, table.map(abbrs, function(game)
            return makeAbbrev(sig[game], args)
        end))
    end

    return luaInterface
end

return q
