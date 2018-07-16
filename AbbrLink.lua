--[[

This module creates a link to an arbitrary page that displays the passed
abbreviation in the games colors.

Un collegamento che visualizza la sigla colorata
specificata, con opzionalmente un separatore per
i singoli giochi della sigla.

Se chiamato da lua ha la possibilità di avere la
sigla non colorata (in Wikicode sarebbe solo
motivo di inefficienza)

Example:

{{#invoke: AbbrLink | RZS | Sala Antica }}

--]]


local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local w = require('Wikilib')

local makeText = function(data)
    return table.concat(lib.coloredAbbrs(data, lib.bolden))
end

local makeLink = function(args, text)
    local link = args[1]
    return string.interp('[[${link}|${text}]]', {
        link = link,
        text = table.concat(text)
    })
end

return lib.makeLuaAndWikicode(function(_, abbr)
    local lua = lib.onMergedAbbrsArgs(abbr, 'games', makeText, makeLink)

    -- Not standard from Wikilib, it is necessary not to unpack
    local wikicode = function(frame)
        local p = w.trimAll(table.copy(frame.args))
        return lua(p)
    end

    return lua, wikicode
end)
