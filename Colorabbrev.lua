--[[

This module creates link to games, displaying them with colored abbreviations.

Examples:

{{#invoke: Colorabbrev | UL }}
{{#invoke: Colorabbrev | RZS | RFVF}}
{{#invoke: Colorabbrev | HGSS | XY | ROZA }}

HINT: If you get an Errore Script, try to split an abbreviation into
smaller parts. For example:

{{#invoke: Colorabbrev | OACPtHGSS }} --> {{#invoke: Colorabbrev | OAC | Pt | HGSS }}

--]]

local lib = require('Wikilib-sigle')

-- Creates the links for a single abbreviation, as a single string
local makeLinks = function(data)
    return table.concat(lib.coloredAbbrevLinks(data, lib.bolden))
end

-- Dynamically generated Wikicode interface
return lib.mapAbbrs(function(_, abbr)

    --[[
        Wikicode arguments are first processed one-by-one by makeLinks,
        resulting in a table having a string for every argument, containing
        all the links. These strings are then concatenated.
    --]]
    return lib.onMergedAbbrs(abbr, makeLinks)
end)
