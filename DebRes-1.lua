--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon nella prima generazione.
Per i Pokémon con più forme, crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes/1 | DebRes | Parasect }}

Oppure con una combinazione di tipi:

{{#invoke: DebRes/1 | DebRes | Coleottero | Erba }}
{{#invoke: DebRes/1 | DebRes | type1=Coleottero | type2=Erba }}

--]]

local dr = {}

local mw = require('mw')

local w = require('Wikilib')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local tab = require('Wikilib-tables')
local drp = require('DebRes')
local et = require('EffTipi-1')
local pokes = require("Poké-data")

--[[

Questa classe rappresenta una tabella di efficacia
tipi di prima generazione. Primariamente, contiene
informazioni riguardo l'efficacia dei vari tipi di
attacchi contro un certo Pokémon, ovvero contro una
certa combinazione di tipi; oltre a ciò, possiede
le righe che compongono il footer.

--]]
dr.EffTable = oop.makeClass(drp.EffTable)

--[[

Tutti i possibili moltiplicatori dell'efficacia

--]]
dr.EffTable.allEff = {
	0, 0.25, 0.5, 1, 2, 4, -- Standard
}

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome + sigla gioco,
e, opzionalmente, il nome esteso dell gioco

--]]
dr.EffTable.new = function(name, formName)
	local types

	if type(name) == 'table' and type(formName) == 'table' then
		types = table.map(name, string.lower)
	else
		types = pokes[name]
	end

	local this = setmetatable(dr.EffTable.super.super.new(),
			dr.EffTable)
	this.collapse = ''

	local monoType = types.type1 == types.type2

	-- Dati per la stampa
	this:createColors(types)

	--[[
		Per ogni possibile efficacia, se vi sono
		tipi che la hanno, inserisce una table
		con i loro nomi all'indice dell'efficacia
		stessa
	--]]
	for k, eff in ipairs(dr.EffTable.allEff) do
		local types = et.difesa(eff, types.type1, types.type2, abil)
		if #types > 0 then

			--[[
				I tipi devono essere ordinati per il
				confronto e la conversione a stringa
			--]]
			table.sort(types)
			this[eff] = types
		end
	end

	this.footer = {}

	return this
end

--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon o una coppia di tipi
e genera le table dell'efficacia tipi di prima generazione. Se
il Pokémon ha più forme, ritorna una table per ogni forma,
tutte collassabili con solo quella della forma base
estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
	local pokeData = pokes[string.parseInt(p[1]) or p[1]]
			or pokes[mw.text.decode(p[1])]

	--[[
		If no data is found, the first parameter is
		the type, that is no Pokémon is given and
		types are directly provided
	--]]
	if not pokeData then
		local types = {}
		types.type1 = p[1] or p.type1 or p.type
		types.type2 = p[2] or p.type2 or types.type1
		return tostring(dr.EffTable.new(types, {}))
	end

	return list.makeFormsLabelledBoxes({
		name = pokeData.name:lower(),
		makeBox = dr.EffTable.new,
		printBoxes = dr.EffTable.printEffTables
	})
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes

local arg = {"Parasect"}
print(dr.DebRes{args=arg})
-- return dr
