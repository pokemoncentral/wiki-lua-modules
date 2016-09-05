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

local w = require('Wikilib')
local tab = require('Wikilib-tables')
local lib = require('Wikilib-sigle')
local abbr = require("Sigle-data")

for abbr, data in pairs(abbr) do
	local abbrLua = abbr .. 'Lua'

	a[abbrLua] = function(link, sep, colored)
		return string.interp('[[${link}|${abbr}]]',
			{
				link = link,
				abbr = lib.displayAbbr(data, sep, colored)
			})
	end
	a[abbr .. '_lua'] = a[abbrLua]

	a[abbr] = function(frame)
		local p = w.trimAll(mw.clone(frame.args))
		return a[abbrLua](p[1], p[2], true)
	end
end

return a
