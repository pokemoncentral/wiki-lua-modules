local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local w = require('Wikilib')

local l = {}

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
		entries[#entries] =
				entries[#entries]:toFooter()
	end

	return w.mapAndConcat(entries, '\n|-\n',
			tostring)
end

return l
