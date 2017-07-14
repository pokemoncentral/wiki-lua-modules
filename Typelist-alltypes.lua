--[[

This module has the sole purpose of
creating the list of Pokémon by type
in the namesake page.

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
	if a.type2 == b.type2 then
		return tl.FirstTypeEntry.super.__lt(a, b)
	end
	
	return a.type2 < b.type2
end

-- Needs a different heading level than Typelist
tl.FirstTypeEntry.makeHeader = function(type)
	return tl.FirstTypeEntry.super.makeHeader(type, 3,
		'come tipo primario')
end

--[[

Wikicode interface: takes no parameters
and returns the list of all Pokémon by
type, with relative headings for every
part. Indeed, they are divided, for each
type, into mono-typed and first-typed,
the latter being sorted by second type.

Example:
{{#invoke: Typelist/alltypes | typelist }}

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
