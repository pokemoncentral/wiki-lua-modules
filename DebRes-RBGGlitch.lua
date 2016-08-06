--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon Glitch di prima generazione.
Per i Pokémon glitch con più forme (Missigno.), crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes | DebRes | 'M (00) }}

Oppure con il nome di un Pokémon e un gioco, es:

{{#invoke: DebRes | DebRes | Missigno. | RB }}
{{#invoke: DebRes | DebRes | Missigno. | game=RB }}

Se un glitch con lo stesso nome compare in più giochi
il modulo crea automaticamente una tabella diversa per
ogni gioco in cui ha debolezze e resistenze diverse
richiamandolo con solo il nome
(ATTENZIONE: non crea una tabella per ogni combinazione
di tipi diversa ma per ogni combinazione di debolezze e
resistenze diversa)

O direttamente con i tipi, sia con parametri
posizionali che con con nome, es:

{{#invoke: DebRes | DebRes | Veleno | Terra }}
{{#invoke: DebRes | DebRes | type1=Veleno | type2=Terra }}

Può essere chiamato anche con un solo tipo, es

{{#invoke: DebRes | DebRes | Spettro }}
{{#invoke: DebRes | DebRes | type=Spettro }}

Si potrebbe anche mescolare notazione posizionale e con nome, ma
consiglio vivamente di NON FARLO

--]]

local dr = {}

local mw = require('mw')

local w = require('Wikilib')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local data = require('Wikilib-data')
local oop = require('Wikilib-oop')
local drp = require('DebRes')
local sig = require('Sigle-data')
local et = require('EffTipi1-Glitch')
local box = require('Boxtipo')
local link = require('Links')
local pokes = require('Glitch-data')
local c = require('Colore-data')

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

Costruttore della classe: ha in ingresso i tipi

I tipi potrebbero essere tipi glitch inesistenti nel
modulo EffTipi. In questo caso, non hanno nessuna debolezza
o resistenza e devono quindi comportarsi di conseguenza

--]]
EffTable.new = function(types, forms)
	local this = setmetatable({}, EffTable)

	-- Colori per la stampa
	this.colors = {
		bg = c[types[1]].normale,
		cells = c[types[1]].light,
		bd = c[types[2]][types[1] == types[2] and 'dark' or 'normale']
	}

	-- Dopo i colori, i tipi vanno passati al lowercase
	types = tab.map(types, string.lower)

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
		this.footer is istantiated to use parent's
		__tostring method
	--]]
	this.footer = {}

	if forms then
		this.forms = type(forms) == 'table' and forms or {forms}
	end

	return this
end

--[[

Operatore di uguaglianza: ritorna true se sono uguali sia
i footer che i valori di efficacia con i tipi associati

--]]
EffTable.__eq = function(a, b)
	--[[
		Si scorre EffTable.allEff perché se si
		scorresse a o b si potrebbe non controllare
		tutti i valori di efficacia dell'altro
	--]]
	for k, eff in pairs(EffTable.allEff) do
		if not table.equal(a[eff], b[eff]) then
			return false
		end
	end

	return true
end

--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon glitch o una combinazione tipi
e genera le table dell'efficacia tipi di prima generazione. Se
il Pokémon ha più forme, ritorna una table per ogni forma,
tutte collassabili con solo quella della forma base
estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
	local p = tab.map(mw.clone(frame.args), w.trim)
	local forms = {}

	-- Se tra i parametri c'è game, allora cerca il Pokémon in quel gioco
	local game, index
	if p.game then
		game = p.game
		index = table.deepSearch(pokes[game], p[1])
		table.insert(forms, pokes[game][index])
	elseif p[2] then
		-- Se il Pokémon è stato trovato non sono stati passati i
		-- tipi quindi il secondo parametro se c'è è il gioco
		-- (avviene comunque un ulteriore controllo)
		game = pokes[p[2]] and p[2] or game
		index = table.deepSearch(pokes[game], p[1])
		table.insert(forms, pokes[game][index])
	else
		--[[
			controlla se il glitch esiste in più giochi,
			e nel caso prepara una table con l'elenco
			dei giochi e dei tipi che ha in quel gioco
		--]]
		for game, glitches in pairs(pokes) do
			local index = tab.deepSearch(glitches, p[1])
			if index then
				table.insert(forms, { game=game, data=glitches[index] })
			end
		end
		-- ordina forms in modo da avere prima i giochi più vecchi
		table.sort(forms, function (a, b)
			return tab.search(data.gamesChron, string.lower(a.game)) < tab.search(data.gamesChron, string.lower(b.game))
		end)
	end


	--[[
		If no data is found, first parameter is
		the type, that is no Pokémon is given and
		types are directly provided
	--]]
	if not forms[1] then
		local types = {}
		types[1] = p[1] or p.type1 or p.type
		types[2] = p[2] or p.type2 or types[1]
		return tostring(EffTable.new(types))
	end

	--[[
		If #forms <= 1 there is only one form, so
		returns the single table
	--]]
	if #forms <= 1 then
		local types = {}
		types[1] = forms[1].data.type1
		types[2] = forms[1].data.type2 or forms[1].data.type1
		return tostring(EffTable.new(types))
	end

	local effTables = {}
	--[[
		Per ogni forma in forms genera la table con il suo titolo
	--]]
	for k, form in ipairs(forms) do
		local types = { form.data.type1, form.data.type2 }
		local formName = table.concat(table.map(sig[form.game][1].display, function(disp)
			return string.fu(disp[2])
		end), '/')
		local formEffTable = EffTable.new(types, formName)
		local formPlaced = false
		--[[
			Bisogna controllare la tabella dell'efficacia tipi è
			uguale ad una già inserita
		--]]
		for k, effTable in ipairs(effTables) do
			if formEffTable == effTable then
				effTable:addForm(formName)
				formPlaced = true
				break
			end
		end
		--[[
			Non si può inserire nel for qua sopra perché ipairs
			giustamente includerebbe la nuova EffTable nel loop
		--]]
		if not formPlaced then
			table.insert(effTables, formEffTable)
		end
	end

	return table.concat(table.map(effTables, tostring), '\n')
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes

local arg = {"PkMn ▼PkMn"}
print(dr.DebRes{args=arg})
-- return dr
