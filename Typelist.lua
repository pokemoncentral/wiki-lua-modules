--[[

Modulo che, dato un tipo, restituisce l'elenco dei Pokémon
che lo hanno come primo tipo, secondo o unico

--]]

local g = {}

local mw = require('mw')

local ms = require('MiniSprite')
local r = require('Roundy')
local form = require('Wikilib-forms')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local c = require("Colore-data")
local pokes = require('Poké-data')

--[[

Classe base per una entry di tutte le tabelle
(mono-tipo, tipo primario, tipo secondario):
non è direttamente utilizzabile perché non
filtra i Pokémon in base al tipo e non stampa
le ultime celle.

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Costruttore della classe: il primo argomento
è un elemento del modulo dati Poké/data, e il
secondo la chiave associata. L'onere di ritornare
nil, in conformità a makeList in Wikilib/lists
è affidato alle sottoclassi

--]]
Entry.new = function(pokeData, name)
	local this = Entry.super.new(name, pokeData.ndex)

	this.isFooter = false

	return setmetatable(table.merge(this, pokeData), Entry)
end

Entry.toFooter = function(this)
	this.isFooter = true
end

--[[

Crea il testo di intestazione ad una tabella, dati
tipo, livello dell'intestazione e parte finale

--]]
Entry.makeHeader = function(type, level, ending)
	type = type == 'coleot' and 'Coleottero' or string.fu(type)
	local headerTags = string.rep('=', level)
	return table.concat({headerTags, 'Pokémon di tipo',
			type, ending, headerTags}, ' ')
end

--[[

Wikicode delle prime celle dell'entry: le altre,
infatti, variano in base ai tipi del Pokémon, e
sono gestite dalle sottoclassi

--]]
Entry.__tostring = function(this)
	return string.interp([=[| style="background:#FFF; border:1px solid #D8D8D8;${roundy}" | ${ndex}
| style="background:#FFF; border:1px solid #D8D8D8;" | ${ani}
| style="background:#FFF; border:1px solid #D8D8D8;" | [[${name}]]${form}]=],
	{
		roundy = this.isFooter and r.blLua() or '',
		ndex = this.ndex and string.tf(this.ndex) or '???',
		ani = ms.aniLua(string.tf(this.ndex or 0) ..
				(this.formAbbr == 'base' and '' or this.formAbbr or '')),
		name = this.name,
		form = this.formsData and this.formsData.links[this.formAbbr] or ''
	})
end

-- Classe per le entry dei Pokémon con un solo tipo
local MonoTypeEntry = oop.makeClass(Entry)

MonoTypeEntry.makeHeader = function(type)
	return MonoTypeEntry.super.makeHeader(type, 3, 'puro')
end

--[[

Costruttore della classe: il primo argomento
è un elemento del modulo dati Poké/data, il
secondo la chiave associata, e il terzo il tipo
che deve avere il Pokémon. In conformità a
makeList in Wikilib/lists, ritorna nil se
il Pokémon non è monotipo o se non ha il tipo
desiderato.

--]]
MonoTypeEntry.new = function(pokeData, name, type)
	if pokeData.type1 ~= pokeData.type2
			or type ~= pokeData.type1 then
		return nil
	end

	return setmetatable(MonoTypeEntry.super.new(pokeData,
			name), MonoTypeEntry)
end

MonoTypeEntry.__tostring = function(this)
	return string.interp([=[${firstCells}
| style="color:#FFF; background:#${std}; border: 1px solid #${dark};${roundy}" | '''${type}'''${foot}]=],
	{
		firstCells = this.super.__tostring(this),
		roundy = this.isFooter and r.brLua() or '',
		std = c[this.type1].normale,
		dark = c[this.type1].dark,
		type = string.fu(this.type1),
		foot = this.isFooter and '\n|}\n' or ''
	})
end

--[[

Classe per le entry dei Pokémon doppio tipo il
cui primo tipo è quello richiesto

--]]
local FirstTypeEntry = oop.makeClass(Entry)

FirstTypeEntry.makeHeader = function(type)
	return FirstTypeEntry.super.makeHeader(type, 4,
		'come tipo primario')
end

--[[

Costruttore della classe: il primo argomento
è un elemento del modulo dati Poké/data, il
secondo la chiave associata, e il terzo il tipo
che deve avere il Pokémon come primo. In
conformità a makeList in Wikilib/lists, ritorna
nil se il Pokémon è monotipo o se non ha il
primo tipo uguale a quello desiderato.

--]]
FirstTypeEntry.new = function(pokeData, name, type)
	if pokeData.type1 == pokeData.type2
			or type ~= pokeData.type1 then
		return nil
	end

	return setmetatable(FirstTypeEntry.super.new(pokeData,
			name), FirstTypeEntry)
end

FirstTypeEntry.__tostring = function(this)
	return string.interp([=[${firstCells}
| style="background:#${std1}; border: 1px solid #${dark1}; color:#FFF;" | '''${type1}'''
| style="background:#${std2}; border: 1px solid #${dark2};${roundy}" | [[${type2} (tipo)|<span style="color: #FFF">${type2}</span>]]${foot}]=],
	{
		firstCells = this.super.__tostring(this),
		roundy = this.isFooter and r.brLua() or '',
		std1 = c[this.type1].normale,
		dark1 = c[this.type1].dark,
		type1 = string.fu(this.type1),
		std2 = c[this.type2].normale,
		dark2 = c[this.type2].dark,
		type2 = string.fu(this.type2),
		foot = this.isFooter and '\n|}\n' or ''
	})
end

--[[

Classe per le entry dei Pokémon doppio tipo il
cui secondo tipo è quello richiesto

--]]
local SecondTypeEntry = oop.makeClass(Entry)

SecondTypeEntry.makeHeader = function(type)
	return SecondTypeEntry.super.makeHeader(type, 4,
		'come tipo secondario')
end

--[[

Costruttore della classe: il primo argomento
è un elemento del modulo dati Poké/data, il
secondo la chiave associata, e il terzo il tipo
che deve avere il Pokémon come secondo. In
conformità a makeList in Wikilib/lists, ritorna
nil se il Pokémon è monotipo o se non ha il
secondo tipo uguale a quello desiderato.

--]]
SecondTypeEntry.new = function(pokeData, name, type)
	if pokeData.type1 == pokeData.type2
			or type ~= pokeData.type2 then
		return nil
	end

	return setmetatable(SecondTypeEntry.super.new(pokeData,
			name), SecondTypeEntry)
end

SecondTypeEntry.__tostring = function(this)
	return string.interp([=[${firstCells}
| style="background:#${std1}; border: 1px solid #${dark1};" | [[${type1} (tipo)|<span style="color: #FFF">${type1}</span>]]
| style="background:#${std2}; border: 1px solid #${dark2}; color:#FFF; ${roundy}" | '''${type2}'''${foot}]=],
	{
		firstCells = this.super.__tostring(this),
		roundy = this.isFooter and r.brLua() or '',
		std1 = c[this.type1].normale,
		dark1 = c[this.type1].dark,
		type1 = string.fu(this.type1),
		std2 = c[this.type2].normale,
		dark2 = c[this.type2].dark,
		type2 = string.fu(this.type2),
		foot = this.isFooter and '\n|}\n' or ''
	})
end

--[[

Stampa lo header. Ha in ingresso il tipo da usare
per lo schema di colori e il numero di tipi da
inserire come colonne

--]]
local makeHeader = function(type, typesCount)
	return string.interp([=[{| class="roundy sortable pull-center text-center" style="background: #${bg}; border: 3px solid #${bd};"
! [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">#<span>]]
! &nbsp;
! [[Pokémon|<span style="color:#000">Pokémon<span>]]
${types}]=],
{
	bg = c[type].normale,
	bd = c[type].dark,
	types = typesCount < 2 and '! [[Tipo|<span style="color:#000">Tipo</span>]]'
		or [=[! [[Tipo|<span style="color:#000">Tipo 1</span>]]
! [[Tipo|<span style="color:#000">Tipo 2</span>]]]=]
})
end

--[[

Crea intestazione e tabella HTML per
i Pokémon di un tipo dato, mono-tipo,
con tipo primario o secondario in base
alla classe entry passata.

--]]
local makeTypeTable = function(type, Entry)
	return table.concat({Entry.makeHeader(type),
		list.makeList({
			source = pokes,
			iterator = list.pokeNames,
			entryArgs = type,
			makeEntry = Entry.new,
			header = makeHeader(type,
					Entry == MonoTypeEntry and 1 or 2)
		})}, '\n')
end

--[[

Funzione di interfaccia: si passa il titolo
della pagina, da cui viene estratto il tipo.
Ritorna le tre tabelle con i Pokémon del tipo
passato, una per i mono-tipo e le altre per
i doppio tipo con il tipo desiderato come
primo e secondo, con le relative intestazioni.

--]]
g.typelist = function(frame)
	local monoType = string.trim(mw.text.decode(frame.args[1]
			or 'sconosciuto (tipo)')):match('^(%a+) %(tipo%)$'):lower()
	local dualType = monoType == 'coleottero' and 'coleot' or monoType
	local tables = {}

	table.insert(tables, makeTypeTable(monoType, MonoTypeEntry))
	table.insert(tables, Entry.makeHeader(monoType, 3, 'parziale'))
	table.insert(tables, makeTypeTable(dualType, FirstTypeEntry))
	table.insert(tables, makeTypeTable(dualType, SecondTypeEntry))

	return table.concat(tables, '\n')
end

g.Typelist, g.TypeList, g.typeList = g.typelist,
		g.typelist, g.typelist

--[[

Funzione di interfaccia: si passa un tipo.
Ritorna le due tabelle con i Pokémon del tipo
passato, una per i mono-tipo e le altre per
i doppio tipo con il tipo desiderato come
primo, con le relative intestazioni.
Utile con il Modulo:Render per la pagina
"Elenco Pokémon per tipo"

--]]
g.monotypelist = function(frame)
	local monoType = string.trim(mw.text.decode(frame.args[1]
			or 'sconosciuto')):lower()
	local dualType = monoType == 'coleottero' and 'coleot' or monoType
	local tables = {}

	table.insert(tables, makeTypeTable(monoType, MonoTypeEntry))
	table.insert(tables, Entry.makeHeader(monoType, 3, 'come tipo primario'))
	table.insert(tables, list.makeList({
			source = pokes,
			iterator = list.pokeNames,
			entryArgs = dualType,
			makeEntry = FirstTypeEntry.new,
			header = makeHeader(dualType, 2)
		}))

	return table.concat(tables, '\n')
end

g.Monotypelist, g.MonoTypeList, g.monoTypeList =
	g.monotypelist, g.monotypelist, g.monotypelist

print(g.typelist{args={arg[1]}})

-- return g
