--[[

Modulo che crea l'elenco Pokémon per tipo

--]]

local g = {}

local data = require("Wikilib-data")
local tl = require('Typelist')

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
