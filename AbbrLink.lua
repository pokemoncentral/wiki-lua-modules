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

local mw = require('mw')

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local w = require('Wikilib')

for abbr in pairs(lib.abbrs) do
    local abbrLua = abbr .. 'Lua'

    a[abbrLua] = function(...)
        local args = {...}
        local link = table.remove(args)
        table.insert(args, 1, abbr)

        return string.interp('[[${link}|${abbr}]]', {
            link = link,
            abbr = w.mapAndConcat(args, function(game)
                return lib.coloredAbbrevLinks(lib.abbrs[game], lib.bolden)
            end)
        })
    end
    a[abbr .. '_lua'] = a[abbrLua]

    a[abbr] = function(frame)
        local p = w.trimAll(mw.clone(frame.args))
        return a[abbrLua](unpack(p))
    end
end

return a
