-- Crea gli elenchi di Pokémon per dex nazionale o regionale

local d = {}

local txt = require('Wikilib-strings')
local ms = require('MiniSprite')
local roundy = require('Roundy')
local dex = require("Dex-data")
local pokes = require("Poké-data")
local c = require("Colore-data")

local chunks = 50
local entryText = [=[
|- style="background:#FFFFFF;"
| ${rdex}
| #${ndex}
| ${ms}
| [[${name}]]
| colspan="${cs}" style="background:#${type1Color};" | [[${type1}|<span style="color:#FFFFFF">${type1}</span>]]${type2}]=]
local entryType2 = [=[
| style="background:#${type2Color};" | [[${type2}|<span style="color:#FFFFFF">${type2}</span>]]]=]
local footerText = [=[
|-
| style="background:#FFFFFF; ${rbl}" | ${rdex}
| style="background:#FFFFFF;" | #${ndex}
| style="background:#FFFFFF;" | ${ms}
| style="background:#FFFFFF;" | [[${name}]]
| style="background:#${type1Color}; ${rbr}" colspan="${cs}" | [[${type1}|<span style="color:#FFFFFF">${type1}</span>]]${type2}]=]
local footerType2 = [=[
| style="background:#${type2Color}; ${rbr}" | [[${type2}|<span style="color:#FFFFFF">${type2}</span>]]]=]

local title = function(start)
	local stop = start + chunks - (start == 1 and 0 or 1)
	return table.concat{'===', string.tf(start), '-',
		string.tf(stop), ' (da ', pokes[start].name,
		' a ', pokes[stop].name, ')==='}
end

local entry = function(rdex, ndex, footer)
	if type(rdex) == 'number' then
		rdex = string.three_figures(rdex)
	end
	if type(ndex) == 'number' then
		ndex = string.three_figures(ndex)
	end
	local poke = pokes[tonumber(ndex)]
	local text, type2text
	if footer then
		text, type2Text = footerText, footerType2
	else
		text, type2Text = entryText, entryType2
	end
	return string.interp(text,
		{
			rbl = roundy.blLua('6px'),
			rdex = rdex and '#' .. rdex or '&mdash;',
			ndex = ndex,
			ms = ms.aniLua(ndex),
			name = poke.name,
			rbr = poke.type1 == poke.type2 and roundy.brLua('6px') or '',
			cs = poke.type1 == poke.type2 and '2' or '1',
			type1Color = c[poke.type1].normale,
			type1 = string.fu(poke.type1),
			type2 = poke.type1 == poke.type2 and '' or
				string.interp(type2Text,
					{
						type2Color = c[poke.type2].normale,
						rbr = roundy.brLua('6px'),
						type2 = string.fu(poke.type2)
					})
		})
end

d.kanto = function(frame)
	local data = {title(1)}
	for kndex, ndex in ipairs(dex.kanto) do
		if kndex ~= 1 and kndex % chunks == 1 then
			table.insert(data, entry(kndex, ndex, true))
			table.insert(data, title(kndex + 1))
		else
			table.insert(data, entry(kndex, ndex, false))
		end
	end
	return table.concat(data, '\n')
end

-- return d
print(d.kanto())
