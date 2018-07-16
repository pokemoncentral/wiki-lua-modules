--[[

This module creates a link to an arbitrary page that displays the passed
abbreviation in a specified color, or every abbreviation in the game color.

The abbreviations can be specified as the name of the called function. Extra
abbreviations can be added as the "games" argument, as a space-separated list.

The color can be specified as its name in the Colore module, or as an
hexadecimal. In the case of named colors, a shade can be passed, defaulting to
'normale'

Examples:

{{#invoke: AbbrLink | RZS | Sala Antica }}
{{#invoke: AbbrLink | RZS | Sala Antica | 772299 }}
{{#invoke: AbbrLink | RZS | Sala Antica | smeraldo }}
{{#invoke: AbbrLink | RZS | Sala Antica | smeraldo | dark }}

{{#invoke: AbbrLink | RZS | games = ROZA XY | Sala Antica }}
{{#invoke: AbbrLink | RZS | games = ROZA XY | Sala Antica | 772299 }}
{{#invoke: AbbrLink | RZS | games = ROZA XY | Sala Antica | smeraldo }}
{{#invoke: AbbrLink | RZS | games = ROZA XY | Sala Antica | smeraldo | dark }}

--]]

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local w = require('Wikilib')

--[[

Creates the text to be displayed for an abbreviation data, that is, the
abbreviations of its games boldened and in the specified color.

If the color is not passed, it defaults to the games color. If the shade is
not given, 'normale' is used.

--]]
local makeText = function(data, args)
    local color, shade = args[2], args[3]
    return table.concat(lib.coloredAbbrs(data, lib.bolden, color, shade))
end

--[[

Creates the link after the processing of the abbreviations. The test to be
displayed is passed as a table in the second argument, while the link as the
first item in the first argument.

--]]
local makeLink = function(args, text)
    return string.interp('[[${link}|${text}]]', {
        link = args[1],
        text = table.concat(text)
    })
end

-- Dynamically generates lua and wikicode interfaces
return lib.makeLuaAndWikicode(function(_, abbr)
    local lua = lib.onMergedAbbrsArgs(abbr, 'games', makeText, makeLink)

    -- Not standard from Wikilib, it is necessary not to unpack
    local wikicode = function(frame)
        local p = w.trimAll(table.copy(frame.args))
        return lua(p)
    end

    return lua, wikicode
end)
