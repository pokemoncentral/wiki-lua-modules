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

local a = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local w = require('Wikilib')
--[[
    This is the only module that cannot use onMergedAbbr, so we can give up
    optimizations here.
--]]
local abbrs = require("Sigle-data")

for abbr in pairs(abbrs) do
    local abbrLua = abbr .. 'Lua'

    a[abbrLua] = function(...)
        local args = {...}
        local link = table.remove(args)
        table.insert(args, 1, abbr)

        return string.interp('[[${link}|${abbr}]]', {
            link = link,

            -- All of the abbreviations should be displayed in the same link
            abbr = w.mapAndConcat(args, function(game)
                return table.concat(lib.coloredAbbrevLinks(abbrs[game],
                    lib.bolden))
            end)
        })
    end
    a[abbr .. '_lua'] = a[abbrLua]

    a[abbr] = function(frame)
        local p = w.trimAll(table.copy(frame.args))
        return a[abbrLua](unpack(p))
    end
end

return a
