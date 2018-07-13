--[[

This module creates link to games, displaying them in superscripts
with colored abbreviations.

Examples:

{{#invoke: Sup | UL }}
{{#invoke: Sup | RZS | RFVF}}
{{#invoke: Sup | HGSS | XY | ROZA }}

HINT: If you get an Errore Script, try to split an abbreviation into
smaller parts. For example:

{{#invoke: Sup | OACPtHGSS }} --> {{#invoke: Sup | OAC | Pt | HGSS }}

--]]

local tab = require('Wikilib-tables')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local m = require("Sigle-data")

-- Creates the links for a single abbreviation, as a single string
local makeLinks = function(data)
    return table.concat(lib.coloredAbbrevLinks(data, lib.bolden))
end

-- Wraps a list of links content in sup tags
local makeSup = function(links)
    table.insert(links, 1, '<sup>')
    table.insert(links, '</sup>')
    return table.concat(links)
end

-- Dynamically generated Wikicode interface
return table.map(m, function(_, abbr)

    --[[
        Wikicode arguments are first processed one-by-one by makeLinks,
        resulting in a table having a string for every argument, containing
        all the links. These strings are then concatenated and wrapped in sup
        tags by makeSup.
    --]]
    return lib.onMergedAbbrs(abbr, makeLinks, makeSup)
end)
