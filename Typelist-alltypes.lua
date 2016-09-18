--[[

Modulo che crea l'elenco Pokémon per tipo

--]]

local g = {}

local data = require("Wikilib-data")
local tl = require('Typelist')
local c = require("Colore-data")

--[[

Sorting function for Entry:
Pokémon with two types are sorted first for
second type order, then for ndex

--]]
tl.FirstTypeEntry.__lt = function(a, b)
	if (a.type2 == b.type2) then
		return tl.FirstTypeEntry.super.__lt(a, b)
	end
	
	return a.type2 < b.type2
end

tl.FirstTypeEntry.makeHeader = function(type)
	return tl.FirstTypeEntry.super.makeHeader(type, 3,
		'come tipo primario')
end

--[[

Override of tostring functions to link to
the page of the first type

--]]
tl.MonoTypeEntry.__tostring = function(this)
	return string.interp([=[${firstCells}
| style="color:#FFF; background:#${std}; border: 1px solid #${dark};" | [[${type} (tipo)|<span style="color: #FFF">${type}</span>]]]=],
	{
		firstCells = this.super.__tostring(this),
		roundy = this.isFooter and r.brLua() or '',
		std = c[this.type1].normale,
		dark = c[this.type1].dark,
		type = string.fu(this.type1),
	})
end

tl.FirstTypeEntry.__tostring = function(this)
	return string.interp([=[${firstCells}
| style="background:#${std1}; border: 1px solid #${dark1}; color:#FFF;" | [[${type1} (tipo)|<span style="color: #FFF">${type1}</span>]]
| style="background:#${std2}; border: 1px solid #${dark2};" | [[${type2} (tipo)|<span style="color: #FFF">${type2}</span>]]]=],
	{
		firstCells = this.super.__tostring(this),
		std1 = c[this.type1].normale,
		dark1 = c[this.type1].dark,
		type1 = string.fu(this.type1),
		std2 = c[this.type2].normale,
		dark2 = c[this.type2].dark,
		type2 = string.fu(this.type2),
	})
end

--[[

Funzione di interfaccia: ritorna l'elenco Pokémon
per tipo

--]]
g.typelist = function(frame)
	local tables = {}

	for k, type in ipairs(data.allTypes) do
		local typeName = type == 'coleot' and 'coleottero' or type
		table.insert(tables, tl.makeTypeTable(typeName, tl.MonoTypeEntry))
		table.insert(tables, tl.makeTypeTable(type, tl.FirstTypeEntry))
	end

	return table.concat(tables, '\n')
end

g.Typelist, g.TypeList, g.typeList = g.typelist,
		g.typelist, g.typelist

print(g.typelist())

-- return g
