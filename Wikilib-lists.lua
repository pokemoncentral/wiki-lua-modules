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
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused
local alts = require('AltForms-data')

--[[-----------------------------------------

                    Utility

--]]-----------------------------------------

--[[

Replaces the label with the parameter when
all forms share the same box. If only one form
exists, it deletes all the labels instead.
The boxes are returned for composition convenience.

--]]
local allForms = function(boxes, label)
    if #boxes == 1 then
        local box = boxes[1]
        if box:labelFormsCount() == 1 then
            box:emptyLabel()
        else
            box:replaceLabel(label)
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

-- local next_poke_name = nextPokeName

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

        List-creating functions

--]]-----------------------------------------

--[[

Creates a list where every entry is a row in an HTML table.

Arguments (names because they are many):
    - source: table to scan to retrieve the data.
    - makeEntry: constructor of the class representing an entry.
    - entryArgs: optional, value to be passed to the entry constructor as last
        argument. Defaults to nil.
    - iterator: optional, the iterator used to traverse source. Default to
        pairs.
    - header: wikicode to be used as table-header.
    - separator: optional, the separator to be used when concatenating entries.
        It's both prefixed and appended newlines, Defaults to
        |- style="height: 100%"
    - footer: optional, the footer for the HTML table. A newline is prepended
        to it, but not the separator. Defaults to '|}'.

The class representing the entries, needs to implement the following interface:
    - constructor(): Takes as parameters an element of source, its key and
        entryArgs when specified. Must return nil if the entry should not be
        included in the list.
    - __lt(): Used to sort the entries list by means of table.sort.
    - __tostring(): Returns the wikicode representing the entry.
--]]
l.makeList = function(args)
    args.footer = '\n' .. (args.footer or '|}')

    -- "height: 100%" is just CSS making fun of us, can't really hurt anything
    args.separator = table.concat{'\n',
            args.separator or '|- style="height: 100%"', '\n'}

    local makeEntry = function(sourceData, sourceKey)
        return args.makeEntry(sourceData, sourceKey, args.entryArgs)
    end

    local entries = table.mapToNum(args.source, makeEntry, args.iterator)
    table.sort(entries)

    table.insert(entries, 1, args.header)

    return w.mapAndConcat(entries, args.separator, tostring) .. args.footer
end

--[[

Creates a list where every entry is a row in an HTML table, entries grouped by
a property. Entries grouped that holds the same data are merged, and the labels
of the entries are merged. Groups of one element are printed without the label.
If a whole group is collapsed in a single entry, the label may become a custom
text.

Arguments (names because they are many):
	- source: table to scan to retrieve the data.
	- makeEntry: constructor of the class representing an entry.
	- entryArgs: optional, value to be passed to the entry constructor as last
        argument. Defaults to nil.
	- iterator: optional, the iterator used to traverse source. Default to
        pairs.
	- header: wikicode to be used as table-header.
    - separator: optional, the separator to be used when concatenating entries.
        It's both prefixed and appended newlines, Defaults to
        |- style="height: 100%"
    - footer: optional, the footer for the HTML table. A newline is prepended
        to it, but not the separator. Defaults to '|}'.
	- fullGroupLabel: optional, the label to use when a whole group generates a
		single entry. Defaults to 'Tutte le forme'

The class representing the entries, needs to implement the following interface:
    - constructor(): Takes as parameters an element of source, its key and
        entryArgs when specified. Must return nil if the entry should not be
        included in the list.
    - __lt(): Used to sort the entries list by means of table.sort.
    - __tostring(): Returns the wikicode representing the entry.
    - __eq(): tells whether two boxes hold the same data, and should therefore
        be merged.
    - groupID(): Returns the identifier of the group this entry belongs to.
        There's no need for the ID to be sortable.
    - getLabel(): Returns this entry's label(s).
    - addLabel(): Adds a form name to the current label set.
    - labelFormsCount(): returns the number of labels currently in the label.
    - replaceLabel(): Replaces the label as a whole with the passed one.
    - emptyLabel(): Empties the label.
--]]
l.makeGroupedList = function(args)
    args.footer = '\n' .. (args.footer or '|}')
    args.fullGroupLabel = args.fullGroupLabel or 'Tutte le forme'

    -- "height: 100%" is just CSS making fun of us, can't really hurt anything
    args.separator = table.concat{'\n',
            args.separator or '|- style="height: 100%"', '\n'}

    local makeEntry = function(sourceData, sourceKey)
        return args.makeEntry(sourceData, sourceKey, args.entryArgs)
    end

    local entries = table.map(args.source, makeEntry, args.iterator)
    local groups = table.groupBy(entries, function(v)
        return v:groupID()
    end)
    entries = table.flatMapToNum(groups, function(group)
        local groupEntries = {}

        for k, entry in pairs(group) do
            local index = table.search(groupEntries, entry)
            if index then
                groupEntries[index]:addLabel(entry:getLabel())
            else
                table.insert(groupEntries, entry)
            end
        end
        -- No need for sorting here because all entries are sorted after the
        -- flatten
        return allForms(groupEntries, args.fullGroupLabel)
    end)
    table.sort(entries)

    table.insert(entries, 1, args.header)

    return w.mapAndConcat(entries, args.separator, tostring) .. args.footer
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
        ad avere buchi negli indici di boxes, cosa
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

    return args.printBoxes(allForms(boxes, 'Tutte le forme'))
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

-- Returns the labels
l.Labelled.getLabel = function(this)
    return this.labels
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

--[[

Base class of a Pokémon entry for a labelled list. Inherits from Labelled and
add the sort, like PokeSortableEntry, and the grouping by ndex. The sort is by
ndex first, using the name if it's missing. With the same ndex, entries are
sorted by form order (according to gamesOrder). The form abbr in case of
multiple labels is the least.

Note that the labels are the abbr, NOT the formNames. The duty to convert abbr
to extended name is left to the printing function.

--]]
l.PokeLabelledEntry = oop.makeClass(l.Labelled)

l.PokeLabelledEntry.new = function(name, ndex)
    local baseName, abbr = form.getNameAbbr(name)

    local this = setmetatable(l.PokeLabelledEntry.super.new(abbr),
        l.PokeLabelledEntry)
    this.ndex = ndex
    this.name = name

    if not this.ndex then
        this.fallbackSort = this.name
    end

    this.formsData = alts[baseName]
    if this.formsData then
        this.formAbbr = abbr
    end

    return this
end

l.PokeLabelledEntry.__lt = l.sortNdex

l.PokeLabelledEntry.groupID = function(this)
    return this.ndex
end

--[[

Should be reimplemented to take into account the change in this.formAbbr

]]
l.PokeLabelledEntry.replaceLabel = function(this, label)
    l.PokeLabelledEntry.super.replaceLabel(this, label)

    if type(label) == 'table' then
        -- Takes care also of the empty label case
        this.formAbbr = label[1]
        for k, v in ipairs(label) do
            if form.abbrLT(this.formsData, v, this.formAbbr) then
                this.formAbbr = v
            end
        end
    else
        -- This can happen also because of label change to 'Tutte le forme',
        -- thus this check
        if this.formsData.names[label] then
            this.formAbbr = label
        else
            this.formAbbr = 'base'
        end
    end
end

l.PokeLabelledEntry.addLabel = function(this, label)
    if type(label) ~= 'table' then
        label = {label}
    end
    for k, v in ipairs(label) do
        table.insert(this.labels, v)
        if form.abbrLT(this.formsData, v, this.formAbbr) then
            this.formAbbr = v
        end
    end
end

return l
