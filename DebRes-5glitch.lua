--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon Glitch di una generazione tra la
seconda e la quinta.
Per i Pokémon glitch con più forme (Missigno.), crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes/5glitch | DebRes | ????? (FF) }}

Se un glitch con lo stesso nome compare in più giochi
il modulo crea automaticamente una tabella diversa per
ogni gioco in cui ha debolezze e resistenze diverse
richiamandolo con solo il nome.
(ATTENZIONE: non crea una tabella per ogni combinazione
di tipi diversa ma per ogni combinazione di debolezze e
resistenze diversa)

È anche possibile passare un parametro game per indicare
il gioco di cui si vuole la tabella, es:

{{#invoke: DebRes/5glitch | DebRes | Uovo Peste | game = RZS }}

--]]

local dr = {}

local mw = require('mw')

local w = require('Wikilib')
local data = require("Wikilib-data")
local gamesUtil = require('Wikilib-games')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local tab = require('Wikilib-tables')
local sig = require('Wikilib-sigle')
local drp = require('DebRes')
local et = require('EffTipi-5-glitch')
local glitch = require("Glitch-data")

--[[

Questa classe rappresenta una tabella di efficacia
tipi di prima generazione. Primariamente, contiene
informazioni riguardo l'efficacia dei vari tipi di
attacchi contro un certo Pokémon, ovvero contro una
certa combinazione di tipi; oltre a ciò, possiede
le righe che compongono il footer.

--]]
local EffTable = oop.makeClass(drp.EffTable)

--[[

Tutti i possibili moltiplicatori dell'efficacia

--]]
EffTable.allEff = {
	0, 0.25, 0.5, 1, 2, 4, -- Standard
}

--[[

Override di addLabel per inserire il nome
del gioco invece della sigla

--]]
EffTable.addLabel = function(this, label)
	if type(label) == 'table' then
		this.labels = table.merge(this.labels, label)
	else
		table.insert(this.labels, sig.gamesName(label, '/'))
	end
end

-- Override di createColors per gestire i tipi glitch
-- (nomi diversi ma stesso colore)
EffTable.createColors = function(this, types)
	-- The order is important because table.merge use mw.clone on first argument,
	-- that can't be used on data.allTypes because of mw.loadData
	local coloredTypes = table.merge({'grinta', 'grazia'}, data.allTypes)

	this.colors = {
		type1 = types.type1,
		type2 = types.type2,
	}
	for k, v in pairs(this.colors) do
		this.colors[k] = string.lower(v)
		this.colors[k] = table.search(coloredTypes, this.colors[k]) and this.colors[k] or 'sconosciuto'
	end
end

--[[

Contiene le stringhe utili per il footer

--]]
EffTable.FooterStrings = {
	-- Testo se il Pokémon ha tipi diversi da quelli dell'efficacia
	CHANGETYPE = "\n* Nonostante questo Pokémon sia di tipo ${typeOr}, subisce danni come se fosse di tipo ${typeEff}",

	-- Link ad un tipo
	TYPE = '[[${type1}]]',

	-- Link ad un doppio tipo
	DUALTYPE = '[[${type1}]]/[[${type2}]]'
}

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome + sigla gioco,
e, opzionalmente, il nome esteso del gioco

Dato che i glitch non hanno abilità che modificano le
efficacie questo modulo non si occupa di gestirle

--]]
EffTable.new = function(name, game)
	local this = setmetatable(EffTable.super.super.new(),
		EffTable)

	if game then
		name = name:gsub('(.*)'..game..'$', '%1')
		-- se viene passato il gioco, il glitch ha più
		-- forme, quindi bisogna aggiungere la label
		this:addLabel(game)
	else
		game = tab.deepSearch(glitch, name)
	end

	local data = glitch[game][tab.deepSearch(glitch[game], name)]
	-- data.typeEffectiveness viene usato solo per glitch di prima generazione
	local types = data.typeEffectiveness and table.copy(data.typeEffectiveness) or {data.type1, data.type2}
	if not types[2] then
		types[2] = types[1]
	end
	types = table.map(types, string.lower)

	-- Colori per la stampa
	this:createColors(data)

	--[[
		Per ogni possibile efficacia, se vi sono
		tipi che la hanno, inserisce una table
		con i loro nomi all'indice dell'efficacia
		stessa
	--]]
	for k, eff in ipairs(EffTable.allEff) do
		local types = et.difesa(eff, types[1], types[2])
		if #types > 0 then
			--[[
				I tipi devono essere ordinati per il
				confronto e la conversione a stringa
			--]]
			table.sort(types)
			this[eff] = types
		end
	end

	--[[
		Contiene l'unica possibile riga del footer (se c'è) dato che nessun glitch di 2 o 3
		può perdere un'immunità per colpa di un'abilità o di una mossa in queste generazioni.
	--]]
	this.footer = {}
	if data.typeEffectiveness then
		table.insert(this.footer, string.interp(EffTable.FooterStrings.CHANGETYPE,
			{
				typeOr = string.interp(data.type2 and EffTable.FooterStrings.DUALTYPE or EffTable.FooterStrings.TYPE, {
					type1 = data.type1,
					type2 = data.type2
				}),
				typeEff = string.interp(data.typeEffectiveness[2] and EffTable.FooterStrings.DUALTYPE or EffTable.FooterStrings.TYPE, {
					type1 = data.typeEffectiveness[1],
					type2 = data.typeEffectiveness[2]
				})
			}
		))
	end

	return this
end



--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon glitch e genera le table dell'efficacia
tipi di prima generazione. Se il Pokémon ha più forme,
ritorna una table per ogni forma, tutte collassabili con
solo quella della forma base estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
	local p = tab.map(mw.clone(frame.args), w.trim)
	local games = {}

	local name = mw.text.decode(p[1])

	--[[
		controlla se il glitch esiste in più giochi,
		e nel caso prepara una table con l'elenco
		dei giochi
	--]]
	if p[2] or p.game then
		table.insert(games, p[2] or p.game)
	else
		for game, glitches in pairs(glitch) do
			if tab.deepSearch(glitches, name) then
				table.insert(games, game)
			end
		end
	end

	-- Crea altData a partire da games
	local altData
	if #games > 1 then
		altData = { gamesOrder = {}, names = {} }
		for k, v in ipairs(games) do
			table.insert(altData.gamesOrder, v)
			altData.names[v] = v
		end
		-- Ordina altData.gamesOrder in modo da avere prima i giochi più vecchi
		table.sort(altData.gamesOrder , function (a, b)
			a = a == 'RZS' and 'rz' or string.lower(a)
			b = b == 'RZS' and 'rz' or string.lower(b)
			return gamesUtil.isBefore(a, b)
		end)
	end

	return list.makeFormsLabelledBoxes({
		name = name,
		makeBox = EffTable.new,
		printBoxes = EffTable.printEffTables,
		altData = altData
	})
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes
print(dr.debres{args={'????? (FF)'}})
return dr
