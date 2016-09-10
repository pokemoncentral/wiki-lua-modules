--[[

Modulo che crea l'elenco Pokémon per tipo

--]]

local g = {}

local mw = require('mw')
--[[
local ms = require('MiniSprite')
local r = require('Roundy')
local form = require('Wikilib-forms')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local c = require("Colore-data")
--]]
local pokes = require('Poké-data')
local list = require('Wikilib-lists')
local data = require("Wikilib-data")
local tl = require('Typelist')

--[[

Sorting function for Entry:
Pokémon with two types are sorted first for
second type order, then for ndex

--]]
tl.Entry.__lt = function(a, b)
	if (a.type2 == b.type2) then
		return tl.Entry.super.__lt(a, b)
	end
	
	return table.search(data.typesOrder, a.type2) < table.search(data.typesOrder, b.type2)
end

--[[

Funzione di interfaccia: ritorna l'elenco Pokémon
per tipo

--]]
g.typelist = function(frame)
	local tables = {}

	--for k, type in ipairs(data.typesOrder) do
	local type = 'buio'
		local typeName = type == 'coleot' and 'coleottero' or type
		table.insert(tables, tl.makeTypeTable(typeName, tl.MonoTypeEntry))
		table.insert(tables, tl.makeTypeTable(type, tl.FirstTypeEntry, tl.Entry.makeHeader(typeName, 3, 'come tipo primario')))
	--end

	return table.concat(tables, '\n')
end

g.Typelist, g.TypeList, g.typeList = g.typelist,
		g.typelist, g.typelist

print(g.typelist())

-- return g
