local l = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local form = require('Wikilib-forms')
local oop = require('Wikilib-oop')
local w = require('Wikilib')
local alts = require('AltForms-data')

--[[

Stateless iterator sui soli nomi dei Pokémon
nei moduli dati, ovvero le chiavi strings
che non iniziano con delle cifre

--]]
local nextPokeName = function(tab, key)
	local nextKey, nextValue = key
	repeat
		nextKey, nextValue = next(tab, nextKey)
	until not nextKey or not string.parseInt(nextKey)
	return nextKey, nextValue
end

local next_poke_name = nextPokeName

-- Stateless iterator da usare nei generic for loops
l.pokeNames = function(tab)
	return nextPokeName, tab
end

l.poke_names = l.pokeNames

l.sortForm = function(a, b)
	if a == b then
		return false
	end
	return table.search(a.formsData.gamesOrder, a.formAbbr)
			< table.search(b.formsData.gamesOrder, b.formAbbr)
end

l.sort_form = l.sortForm

l.sortNdex = function(a, b)
	if a == b then
		return false
	end

	-- If at least one ndex is not defined
	if not (a.ndex and b.ndex) then

		-- The defined ndex gets sorted first
		if a.ndex then
			return true
		elseif b.ndex then
			return false

		-- No ndex defined, using fallback
		else
			return a.fallbackSort < b.fallbackSort
		end
	end
		
	
	if a.ndex ~= b.ndex then
		return a.ndex < b.ndex
	end
	return l.sortForm(a, b)
end

l.sort_ndex = l.sortNdex

l.makeList = function(args)
	local makeEntry = function(sourceData, sourceKey)
		return args.makeEntry(sourceData, sourceKey,
				args.entryArgs)
	end

	local entries = table.mapToNum(args.source,
			makeEntry, args.iterator)
	table.sort(entries)

	table.insert(entries, 1, args.header)
	if args.footer then
		table.insert(entries, args.footer)
	else
		entries[#entries]:toFooter()
	end

	return w.mapAndConcat(entries, '\n|-\n',
			tostring)
end

l.PokeSortableEntry = oop.makeClass()

l.PokeSortableEntry.new = function(name, ndex)
	local this = setmetatable({ndex = ndex, name = name},
		l.PokeSortableEntry)

	if not this.ndex then
		this.fallbackSort = this.name
	end

	local baseName, abbr = form.getNameAbbr(name)

	this.formsData = alts[baseName]
	if this.formsData then
		this.formAbbr = abbr
	end
	
	return this
end

l.PokeSortableEntry.__lt = l.sortNdex

return l
