--[[

Un collegamento che visualizza la sigla colorata
specificata, con opzionalmente un separatore per
i singoli giochi della sigla.

Se chiamato da lua ha la possibilità di avere la
sigla non colorata (in Wikicode sarebbe solo
motivo di inefficienza)

Esempio:

{{#invoke: AbbrLink | RZS | Sala Antica }}

--]]


local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')

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
    return lib.onMergedAbbrsArgs(abbr, 1, makeText, makeLink)
end)
