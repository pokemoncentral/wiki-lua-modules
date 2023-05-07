--[[

This module creates link to games, displaying them with colored abbreviations
and some space around. Mainly used to have colored abbrs aligned with
blackabbrevs.
For everything else, this is the same as colorabbrev.

Examples:

{{#invoke: Colorabbrevspace | UL }}
{{#invoke: Colorabbrevspace | RZS | RFVF}}
{{#invoke: Colorabbrevspace | HGSS | XY | ROZA }}

HINT: If you get an Errore Script, try to split an abbreviation into
smaller parts. For example:

{{#invoke: Colorabbrevspace | OACPtHGSS }} --> {{#invoke: Colorabbrevspace | OAC | Pt | HGSS }}

However, this doesn't work if the first abbreviation is not constant, for
example if it's a parameter in a template. In that case, you can use the
_abbr function to pass all the abbreviations as parameters:

{{#invoke: Colorabbrevspace | _abbr | {{{1}}} }}

--]]

-- stylua: ignore
local lib = require('Wikilib-sigle')

-- Creates the links for a single abbreviation, as a single string
local makeLinks = function(data)
    return table.concat(lib.coloredSpaceAbbrLinks(data, lib.bolden))
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
