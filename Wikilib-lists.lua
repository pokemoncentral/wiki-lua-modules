--[[

Modulo di utilità per creare elenchi. Sfrutta
l'object oriented programming per offrire delle
funzioni che fanno buona parte dei task più
comuni della creazione di liste, come creare
delle entry scorrendo un elenco di un modulo
dati e concatenare le entry così ottenute.

Aiuta anche nell'ordinamento delle entry,
definendo implicitamente delle interfacce che
rendono possibile l'automazione del sorting.

--]]
local l = {}

local form = require('Wikilib-forms')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local w = require('Wikilib')
local alts = require('AltForms-data')

--[[-----------------------------------------

				Iteratori

--]]-----------------------------------------

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

--[[-----------------------------------------

				Ordinamento

--]]-----------------------------------------

--[[

Funzione da passare a table.sort per ordinare le
entry in base alla forma alternativa: non viene
fatto nessun controllo sulla presenza delle stesse.

Sfrutta la seguente interfaccia:
	- formsData: Dati delle forme alternative del
		modulo AltForms/data del Pokémon a cui la
		entry è relativa
	- formAbbr: sigla della forma alternativa a cui
		la entry si riferisce
--]]
l.sortForm = function(a, b)

	--[[
		A volte lua confronta un elemento con se stesso,
		e se non si fa così non funziona più niente
	--]]
	if a == b then
		return false
	end
	return table.search(a.formsData.gamesOrder, a.formAbbr)
			< table.search(b.formsData.gamesOrder, b.formAbbr)
end

l.sort_form = l.sortForm

--[[

Funzione da passare a table.sort per ordinare le
entry in base al numero di dex nazionale e forma
alternativa. Gli ndex non definiti vengono posti
dopo quelli definiti, e si può specificare un
criterio di ordinamento tra ndex inesistenti.

Sfrutta la seguente interfaccia:
	- ndex: Numero di dex nazionale del Pokémon
		cui la entry è relativa
	- fallbackSort: property da utilizzare per
		l'ordinamento delle entry senza ndex
	- formsData: Dati delle forme alternative del
		modulo AltForms/data del Pokémon a cui la
		entry è relativa
	- formAbbr: sigla della forma alternativa a cui
		la entry si riferisce
--]]
l.sortNdex = function(a, b)

	--[[
		A volte lua confronta un elemento con se stesso,
		e se non si fa così non funziona più niente
	--]]
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

--[[-----------------------------------------

		Funzioni per creare elenchi

--]]-----------------------------------------

--[[

Crea un elenco in cui ogni entry è la riga di
una tabella HTML.

Gli argomenti sono named poiché sono molti:
	- source: la table lua da scorrere per
		prelevare i dati.
	- makeEntry: costruttore della classe
		che rappresenta una entry.
	- entryArgs: opzionale, argomento
		supplementare da passare al
		costruttore della entry.
	- iterator: iteratore con cui scorrere
		la table lua sorgente dei dati;
		facoltativo, ha come default pairs.
	- header: wikicode per l'intestazione
		della tabella HTML.
	- footer: wikicode per il footer della
		tabella HTML. Opzionale, se non
		fornito, la entry deve implementare
		il metodo toFooter().

La classe che rappresenta le entries deve
implementare la seguente interfaccia:
	- costruttore(): prende in ingeresso un
		elemento della table lua da cui
		vengono prelevati i dati, la chiave
		corrispondente, ed un eventuale terzo
		argomento specificato come parametro
		a makeList di nome 'entryArgs'.
		Deve ritornare nil se l'entry non
		deve essere inserita nella lista.
	- __lt(): usato per l'ordinamento con
		table.sort.
	- toFooter(): trasforma la entry nel
		footer della table. Opzionale,
		necessario solo in assensa di argomento
		di nome 'footer' a makeList.
	- __tostring(): conversione a stringa,
		deve ritornare il wikicode per una
		riga della tabella HTML relativa
		alla entry corrente.
--]]
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

--[[-----------------------------------------

			Classi di utilità

--]]-----------------------------------------

--[[

Classe base per una entry relativa ad un Pokémon
che implementa l'interfaccia per l'ordinamento
tramite numero di dex nazionale, con il nome
come criterio in caso di ndex mancante.

--]]
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
