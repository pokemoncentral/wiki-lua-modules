--[[

This module creates links to the games, displaying their extended names, given
the abbreviations. It handles commas and " e " separators. It displays the
links in a specified color, or as the default color on the wiki.

The abbreviations can be specified as the name of the called function. Extra
abbreviations can be added as the "games" argument, as a space-separated list.

The color can be given as a named color in Colore module, or as a hexadecimal.
A shade can also be specified, that defaults to 'normale'.

Examples:

{{#invoke: GamesColorLinks | RZS }}
{{#invoke: GamesColorLinks | RZS | 772299 }}
{{#invoke: GamesColorLinks | RZS | smeraldo }}
{{#invoke: GamesColorLinks | RZS | smeraldo | dark }}

{{#invoke: GamesColorLinks | RZS | games = ROZA XY }}
{{#invoke: GamesColorLinks | RZS | games = ROZA XY | 772299 }}
{{#invoke: GamesColorLinks | RZS | games = ROZA XY | smeraldo }}
{{#invoke: GamesColorLinks | RZS | games = ROZA XY | smeraldo | dark }}

If the first abbreviation is not constant, for example if it's a parameter in a
template, the above calls don't work. In that case, you can use the _abbr
function to pass all the abbreviations in the "games" argument:

{{#invoke: GamesColorLinks | _abbr | games = {{{1}}} | Sala Antica | 772299 }}

--]]

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local lib = require('Wikilib-sigle')
local w = require('Wikilib')
local c = require("Colore-data")

--[[

This function operates on a single abbreviation data, pairing together every
link target with a list of its games names.

--]]
local makeText = function(data)
    return table.map(data, function(game)
        local text = game.text or game.link:gsub('^Pokémon ', '')

        -- Splitting by ' e ', so that games paired by that can be joined via
        -- commas instead later.
        local singleGames = mw.text.split(text, ' e ')

        return {game.link, w.trimAll(singleGames)}
    end)
end

--[[

This function returns a function that creates a link given a pair of link
target and list of games. The two arguments of the external function determine
the color the links are displayed in, and the separator used for the last two
games.

--]]
local makeColoredLink = function(color, sep)
    return function(link)
        local target, text = table.unpack(link)

        return string.interp('[[${link}|<span style="color: #${color};">${text}</span>]]', {
            color = color,
            link = target,
            text = mw.text.listToText(text, ', ', sep)
        })
    end
end

--[[

This function creates all of the links, given the arguments for the color and
a list of target-text pairs (actually, the library gives a list of lists of
pairs, but it is flattened).

--]]
local makeAllLinks = function(args, links)

    -- The library returns a nested list
    links = table.flatten(links)

    local color, shade = table.unpack(args)

    --[[
        First try to index colore/data: if such color does not exist, an
        hexadecimal is assumed. If it is not, 'inherit' is used
    --]]
    color = c[color] and c[color][shade or 'normale']
        or color or 'inherit'

    -- All but the last links use the comma as a separator within a link
    local makeLink = makeColoredLink(color, ', ')

    local last = table.remove(links)

    --[[
    If the last link contains more than one games, then the ' e ' is added
    as a seaprator within the last link, and a comma should be used as the
    separator preceding the last link.

    In case the last link is a single game, then no ' e ' will be added as
    a separator, meaning that ' e ' itself should be used as a separator
    before the last link.
    --]]
    local beforeLastSep = #last[2] > 1 and ', ' or ' e '

    -- The last link needs an ' e ' as a separator
    last = makeColoredLink(color, ' e ')(last)

    --[[
        One link only implies empty init later on, that is annoying to manage
        with table.concat. It's easier and more efficient to handle it here.
    --]]
    if #links == 0 then
        return last
    end

    -- All but the last links are concatenated using a comma
    local init = w.mapAndConcat(links, makeLink, ', ')

    return table.concat{init, beforeLastSep, last}
end

-- Dynamically generates lua and wikicode interfaces
local gcl = lib.makeLuaAndWikicode(function(_, abbr)
    local lua = lib.onMergedAbbrsArgs(abbr, 'games', makeText, makeAllLinks)

    -- Not standard from Wikilib, it is necessary not to unpack
    local wikicode = function(frame)
        local p = w.trimAll(table.copy(frame.args))
        return lua(p)
    end

    return lua, wikicode
end)

-- Adding _abbr proxy function
lib.proxy(gcl, 'games')

return gcl
