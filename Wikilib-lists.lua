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

local w = require('Wikilib')
local form = require('Wikilib-forms')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local alts = require('AltForms-data')

--[[-----------------------------------------

					Utility

--]]-----------------------------------------

--[[

Replaces the label with 'Tutte le forme' when
all forms share the same box. If only one form
exists, it deletes all the labels instead.
The boxes are returned for composition convenience.

--]]
local allForms = function(boxes)
	if #boxes == 1 then
		local box = boxes[1]
		if box:labelFormsCount() == 1 then
			box:emptyLabel()
		else
			box:replaceLabel('Tutte le forme')
		end
	end
	return boxes
end

--[[-----------------------------------------

				Iterators

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

    --[[
        "height: 100%" is just CSS making fun
        of us, can't really hurt anything
    --]]
	return w.mapAndConcat(entries,
            table.concat{'\n' .. args.separator .. '\n'},
			tostring)
end

--[[

Creates and prints a list of boxes for all
forms of a given Pokémon: boxes holding the
same data are merged, and the name of the
form is added to the label of the box itself.
If the Pokémon has no alternative forms, only
the box for the base one is printed. When all
forms share the same box, the label is replaced
with 'Tutte le forme'. If only one box exists,
and it has only one form name in the label,
the label itseld its emptied.

Parameters are named:
	- name: name or ndex of the Pokémon whose
		noxes are created. Must be the base form.
	- makeBox: Constructor of the classes
		representing a box.
	- boxArgs: extra parameter which will be passed
	    to the box constructor after the regular ones.
	- printBoxes: prints the boxes to a string.
	- altData: Alternative forms data.
		Defaults to AltForms-data module.

The class representing a box must implement
the following interface:
	- constructor(): Takes as parameters the
		name of the Pokémon, in the format
		name + abbreviation, as found in data
		modules, and the form extended name,
		if any.
	- __eq(): tells whether two boxes hold the
		same data, and should therefore be merged.
	- addLabel(): adds a form name to the current
		label set.
	- labelFormsCount(): returns the number of
		form names currently in the label.
	- replaceLabel(): replaces the label as a whole
		with the passed one.
	- emptyLabel(): deletes all the form names from
		the label.
--]]
l.makeFormsLabelledBoxes = function(args)
    local makeBox = function(sourceData, sourceKey)
        return args.makeBox(sourceData, sourceKey,
            args.boxArgs)
    end

	local altData = args.altData or alts[args.name]

	if not altData then
		return args.printBoxes({makeBox(args.name)})
	end

	local boxes = {}

	--[[
		Scorrendo gamesOrder i boxes saranno già ordinati
		senza bisogno di sorting successivo.

		Non si può usare table.map perché ciò porterebbe
		ad avere buchi negli indici di effTables, cosa
		difficilmente gestibile
	--]]
	for k, abbr in ipairs(altData.gamesOrder) do
		local formName = altData.names[abbr]
		--[[
			Se viene passato l'ndex, la forma base deve
			restare un number, quindi non può essere
			concatenata alla stringa vuota
		--]]
		local name = abbr == 'base' and args.name
				or (args.name .. abbr)
		local formBox = makeBox(name, formName)

		local index = table.search(boxes, formBox)
		if index then
			boxes[index]:addLabel(formName)
		else
			table.insert(boxes, formBox)
		end
	end

	return args.printBoxes(allForms(boxes))
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

--[[

Base class of an object having a label.
Implements methods addLabel(), hasLabel()
and replaceLabel() required by makeFormsLabelledBoxes.

--]]
l.Labelled = oop.makeClass()

--[[

Sostituisce la label con quella passata, sia
essa una sola label o una table di labels.

--]]
l.Labelled.replaceLabel = function(this, label)

	-- Table vuota anche in caso label non sia dato
	this.labels = type(label) == 'table'
		and label or {label}
end

l.Labelled.new = function(label)
	local this = setmetatable({}, l.Labelled)

	this:replaceLabel(label)

	return this
end

-- Aggiunge una label o una table di labels
l.Labelled.addLabel = function(this, label)
	if type(label) == 'table' then
		this.labels = table.merge(this.labels, label)
	else
		table.insert(this.labels, label)
	end
end

-- Deletes all the form names from the label
l.Labelled.emptyLabel = function(this)
	this:replaceLabel({})
end

-- Returns the number of labels
l.Labelled.labelFormsCount = function(this)
	return #this.labels
end

-- Ritorna true se la label è settata
l.Labelled.hasLabel = function(this)
	return this:labelFormsCount() > 0
end

return l
