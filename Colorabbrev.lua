--[[

This module creates link to games, displaying them with colored abbreviations.

Examples:

{{#invoke: Colorabbrev | UL }}
{{#invoke: Colorabbrev | RZS | RFVF}}
{{#invoke: Colorabbrev | HGSS | XY | ROZA }}

HINT: If you get an Errore Script, try to split an abbreviation into
smaller parts. For example:

{{#invoke: Colorabbrev | OACPtHGSS }} --> {{#invoke: Colorabbrev | OAC | Pt | HGSS }}

However, this doesn't work if the first abbreviation is not constant, for
example if it's a parameter in a template. In that case, you can use the
_abbr function to pass all the abbreviations as parameters:

{{#invoke: Colorabbrev | _abbr | {{{1}}} }}

--]]

local lib = require('Wikilib-sigle')

-- Creates the links for a single abbreviation, as a single string
local makeLinks = function(data)
    return table.concat(lib.coloredAbbrLinks(data, lib.bolden))
end

-- Dynamically generated Wikicode interface
local ca = lib.mapAbbrs(function(_, abbr)

    --[[
        Wikicode arguments are first processed one-by-one by makeLinks,
        resulting in a table having a string for every argument, containing
        all the links. These strings are then concatenated.
    --]]
    return lib.onMergedAbbrs(abbr, makeLinks)
end)

-- Adding _abbr proxy function
lib.proxy(ca)

return ca
