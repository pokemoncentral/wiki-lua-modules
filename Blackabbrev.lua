--[[

This module creates link to games, displaying them in colored background.

Examples:

{{#invoke: Blackabbrev | UL }}
{{#invoke: Blackabbrev | RZS | RFVF}}
{{#invoke: Blackabbrev | HGSS | XY | ROZA }}

HINT: If you get an Errore Script, try to split an abbreviation into
smaller parts. For example:

{{#invoke: Blackabbrev | OACPtHGSS }} --> {{#invoke: Blackabbrev | OAC | Pt | HGSS }}

--]]

local tab = require('Wikilib-tables')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local m = require("Sigle-data")

-- Creates the links for a single abbreviation, as a single string
local makeLinks = function(data)
    return table.concat(lib.backgroundAbbrevLinks(data, lib.bolden))
end

-- Dynamically generated Wikicode interface
return table.map(m, function(_, abbr)

    --[[
        Wikicode arguments are first processed one-by-one by makeLinks,
        resulting in a table having a string for every argument, containing
        all the links. These strings are then concatenated.
    --]]
    return lib.onMergedAbbrs(abbr, makeLinks)
end)
