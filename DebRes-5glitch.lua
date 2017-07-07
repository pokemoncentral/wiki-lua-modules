--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon Glitch di una generazione tra la
seconda e la quinta.
Per i Pokémon glitch con più forme (Missigno.), crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes/5glitch | DebRes | - }}

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
	1.5 -- Filtro/Solidroccia (3 è inutile entro la quinta gen)
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

--[[

Contiene le stringhe utili per il footer

--]]
EffTable.FooterStrings = {
	-- Testo se il Pokémon ha tipi diversi da quelli dell'efficacia
	CHANGETYPE = "\n* Nonostante questo Pokémon sia di tipo ${typeOr}, subisce danni come se fosse di tipo ${typeEff}",

	-- Link ad un tipo
	TYPE = '[[${type1} (tipo)|${type1}]]',

	-- Link ad un doppio tipo
	DUALTYPE = '[[${type1} (tipo)|${type1}]]/[[${type2} (tipo)|${type2}]]'
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
	local types = data.typeEffectiveness and table.cloneLoadData(data.typeEffectiveness) or {data.type1, data.type2
	if not types[2] then
		types[2] = types[1]
	end
	types = table.map(types, string.lower)

	-- Colori per la stampa
	local printColors = {type1 = data.type1:gsub(' ', '_')}
	printColors.type2 = data.type2 and data.type2:gsub(' ', '_') or printColors.type1
	this:createColors(printColors)

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
		Contiene le righe del footer sotto forma di
		istanze di dr.EffTable.FooterLine
	--]]
	this.footer = {}
	-- l'unica riga del footer possibile è quella delle immunità dei tipi
	if et.typesHaveImm[types.type1] then
		table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
				types, abils))
	end
	
	--[[
		I tipi vanno scambiati perché il costruttore
		di dr.EffTable.FooterLine controlla solo il primo
	--]]
	if not (types.type1 == types.type2) and et.typesHaveImm[types.type2] then
		table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
				{type1 = types.type2, type2 = types.type1}, abils))
	end
	--[[
	
	data.typeEffectiveness è essere presente solo in glitch di prima generazione
	
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
	--]]

	return this
end



-----------------------------------  Costruttore della classe di DebRes (copiato)  ---------------------------------

	--[[
		Contiene le righe del footer sotto forma di
		istanze di dr.EffTable.FooterLine
	--]]
	this.footer = {}
	
	if abil ~= 'magidifesa' then
		if et.typesHaveImm[types.type1] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
					types, abils))
		end
		
		--[[
			I tipi vanno scambiati perché il costruttore
			di dr.EffTable.FooterLine controlla solo il primo
		--]]
		if not (types.type1 == types.type2) and et.typesHaveImm[types.type2] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
					{type1 = types.type2, type2 = types.type1}, abils))
		end
	end

	if onlyAbil then
		if et.modTypesAbil[abil] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('TAKENOFF',
					types, abil))
		end
	else
		
		-- Can't use table.map because of string indexes
		for key, abil in pairs(abils) do
			if dr.EffTable.shouldAddMaybe(abil, types) then
				table.insert(this.footer, dr.EffTable.FooterLine.new('MAYBE',
						types, abil))
			end
		end
	end
	
	-- Va mantenuta ordinata per il contronfo e la stampa
	table.sort(this.footer)

	return this




-----------------------------------   FOOTER COPIATO DA DEBRES ------------------------------

--[[

Questa classe rappresenta una riga del footer;
per fare ciò maniente informazioni sulla
categoria di riga, sulla parte iniziale del
testo della riga e sui tipi che cambiano
efficacia, associandoli alla nuova.

Le possibili categorie di riga sono tre:
	- MAYBE: usata quando un Pokémon potrebbe
		avere una certa abilità, poiché ne ha
		più di una possibile; indica l'efficacia
		dei tipi in presenza di detta abilità
	- TAKENOFF: usata per i Pokémon che hanno
		una sola abilità possibile, indica che
		le informazioni sono relative al caso 
		in cui il Pokémon perda l'abilità
	- RINGTARGET: usata con i Pokémon che hanno
		immunità dovute ai tipi, indica
		l'efficacia dei tipi verso cui si ha
		immunità nel caso queste siano perse

--]]
dr.EffTable.FooterLine = oop.makeClass()

-- Stringhe utili
dr.EffTable.FooterLine.strings = {
	-- Inizio del testo del footer per la categoria RINGTARGET
	RINGTARGET = 'Se questo Pok&eacute;mon tiene un [[Facilsaglio]]',

	-- Testo per la nuova efficacia
	EFF = "l'efficacia delle mosse di tipo ${types} &egrave; pari a ${eff}×"
}

-- Ordine delle categorie, per l'ordinamento delle righe
dr.EffTable.FooterLine.kindOrder = {'MAYBE', 'TAKENOFF', 'RINGTARGET'}

--[[

Ritorna true se abil dà immunità a type.
Si verifica che l'efficacia di type su
un ipotetico Pokémon che non ha immunità
derivanti dai tipi sia nulla

--]]
dr.EffTable.FooterLine.abilityGrantsImm = function(abil, type)
	return 0 == et.efficacia(type, 'elettro', 'elettro', abil)
end

--[[

Contiene funzioni che generano la parte iniziale
del footer in base alla categoria

--]]
dr.EffTable.FooterLine.init = {}

-- Parte iniziale per la categoria MAYBE
dr.EffTable.FooterLine.init.MAYBE = function(abil)
	return string.interp(dr.EffTable.FooterLine.strings.MAYBE,
			{abil = txt.camelCase(abil)})
end

-- Parte iniziale per la categoria TAKENOFF
dr.EffTable.FooterLine.init.TAKENOFF = function(abil)
	return string.interp(dr.EffTable.FooterLine.strings.TAKENOFF,
			{abil = txt.camelCase(abil)})
end

--[[

Parte iniziale per la categoria RINGTARGET:
aggiunge le stringhe necessarie per alcuni
tipi e abilità e concatena il tutto

--]]
dr.EffTable.FooterLine.init.RINGTARGET = function(abils, type)
	local pieces = {dr.EffTable.FooterLine.strings.RINGTARGET}

	table.insert(pieces, dr.EffTable.FooterLine.strings[type:upper()]
			or ' ')
	
	--[[
		Se l'abilità è una sola, bisogna inserire una
		stringa diversa in caso di immunità condivise
	--]]
	local notAbil = table.getn(abils) == 1
			and dr.EffTable.FooterLine.strings.IMM_TAKENOFF
			or dr.EffTable.FooterLine.strings.NOT_HAVE_ABIL
	
	--[[
		Per ogni abilità, controlla se ha un'immunità
		condivisa con il tipo del footer, e in tal caso
		inserisce una stringa a tal proposito
	--]]
	for k, abil in pairs(abils) do
		for k, typeImm in pairs(et.typesHaveImm[type:lower()]) do
			if dr.EffTable.FooterLine.abilityGrantsImm(abil, typeImm) then
				table.insert(pieces, string.interp(notAbil,
						{abil = txt.camelCase(abil)}))
			end
		end
	end
	return table.concat(pieces)
end

--[[

Costruttore della classe: ha in ingresso la
categoria di riga, i tipi e una sola abilità,
fatta eccezione per la categoria RINGTARGET
in cui si hanno invece tutte le abilità.

--]]
dr.EffTable.FooterLine.new = function(kind, types, abil)
	local this = setmetatable({}, dr.EffTable.FooterLine)
	
	kind = kind:upper()
	types = table.map(types, string.lower)
	abil = type(abil) ~= 'table' and abil:lower() or
			table.map(abil, string.lower)
	
	-- La categoria di riga
	this.kind = kind
	
	-- La parte iniziale della riga del footer
	this.init = '\n*' .. dr.EffTable.FooterLine.init[kind](abil, types.type1)
	
	--[[
		Per ogni nuova efficacia ha una subtable
		con i tipi che hanno detta efficacia: tali
		subtables vanno tenute ordinate per la
		conversione a stringa stampa e il confronto
		con table.equal
	--]]
	this.newEff = {}

	--[[
		Filtro, Solidroccia, Scudoprisma e Magidifesa sono
		casi particolari da trattare separatamente,
		ammesso che si stia creando una riga relativa
		alle abilità
	--]]
	if kind ~= 'RINGTARGET' then
		if abil == 'filtro' or abil == 'solidroccia' or abil == 'scudoprisma' then
		
			--[[
				Se l'abilità viene persa, la nuova
				efficacia è piena, altrimenti ridotta
			--]]
			local x2Key, x4Key
			if kind == 'TAKENOFF' then
				x2Key, x4Key = 2, 4
			else
				x2Key, x4Key = 1.5, 3
			end

			local x2 = et.difesa(2, types.type1, types.type2, 'tanfo')
			table.sort(x2) -- Vedi commento a this.newEff
			this.newEff[x2Key] = x2
			
			local x4 = et.difesa(4, types.type1, types.type2, 'tanfo')
			
			-- Non è detto che vi siano doppie debolezze
			if #x4 > 0 then
				table.sort(x4) -- Vedi commento a this.newEff
				this.newEff[x4Key] = x4
			end
			
			return this
		elseif abil == 'magidifesa' then
		
			--[[
				Un footer standard sarebbe troppo lungo per
				Magidifesa, inoltre è, e molto probabilmente
				resterà, abilità peculiare di Shedinja. Si
				opta quindi per una gestione custom.
			--]]
			this.tostring = string.interp(table.concat{'\n*', dr.EffTable.FooterLine.strings.TAKENOFF,
					[=[solo mosse di tipo ${normale} e ${lotta} non lo renderanno esausto.]=]},
					{
						abil = 'Magidifesa',
						normale = link.colorType('Normale'),
						lotta = link.colorType('Lotta')
					})
			
			return this
		end
	end
	
	local newTypes
	if kind == 'RINGTARGET' then
	
		--[[
			Se si controllano le immunità e il Pokémon
			ha un solo tipo la nuova efficacia è 1x
		--]]
		if types.type1 == types.type2 then
			this.newEff[1] = et.typesHaveImm[types.type1]
			table.sort(this.newEff[1]) -- Vedi commento a this.newEff
			
			return this
		else
			newTypes = et.typesHaveImm[types.type1]
			
			--[[
				Quando perde l'immunita, ai fini del
				calcolo danni il Pokémon è monotipo
			--]]
			types.type1 = types.type2
		end
	else
		newTypes = et.modTypesAbil[abil]
		
		--[[
			Se la categoria è TAKENOFF l'abilità non va
			considerata nel calcolo danni del footer
		--]]
		abil = kind == 'TAKENOFF' and 'tanfo' or abil 
	end
	table.sort(newTypes) -- Vedi commento a this.newEff

	--[[
		Per ogni tipo in newTypes calcola la nuova
		efficacia, e se questa esiste non esiste
		la crea, altrimenti aggiunge il tipo a
		quelli già presenti
	--]]
	for k, type in ipairs(newTypes) do
		local eff = et.efficacia(type, types.type1,
				types.type2, abil)
		if this.newEff[eff] then
			table.insert(this.newEff[eff], type)
		else
			this.newEff[eff] = {type}
		end
	end
	
	return this
end	

--[[

Operatore di uguaglianza: ritorna true
se le due FooterLine hanno entrambi
il membro tostring, o se nessuna delle
due lo ha e hano uguali sia init che
newEff

--]]
dr.EffTable.FooterLine.__eq = function(a, b)
	return a.tostring and b.tostring 
		or not (a.tostring or b.tostring)
			and a.init == b.init
			and table.equal(a.newEff, b.newEff)
end

--[[

Operatore minore, per l'ordinamento:
confronta gli indici delle categorie in
dr.EffTable.FooterLine.kindOrder e in caso
di uguaglianza i testi iniziali

--]]
dr.EffTable.FooterLine.__lt = function(a, b)
	local aIndex = table.search(dr.EffTable.FooterLine.kindOrder, a.kind)
	local bIndex = table.search(dr.EffTable.FooterLine.kindOrder, b.kind)
	return aIndex == bIndex and a.init < b.init or aIndex < bIndex
end

--[[

Conversione a stringa.

Per ogni efficacia crea la stringa con
l'elenco dei tipi corrispondenti in campo
colorato, per poi concatenarle tutte alla
parte iniziale

--]]
dr.EffTable.FooterLine.__tostring = function(this)
	if this.tostring then
		return this.tostring
	end

	local newEff = {}
	--[[
		Can't use table.map because this.newEff has
		string index, that won't work with table.concat
	--]]
	for eff, types in pairs(this.newEff) do
		local colorTypes = table.map(types, function(type)
				return link.colorType(type)
			end)
		table.insert(newEff, string.interp(dr.EffTable.FooterLine.strings.EFF,
				{
					types = mw.text.listToText(colorTypes, ', ', ' e '),
					eff = dr.EffTable.displayEff(eff)
				}))
	end
	
	return table.concat{this.init, mw.text.listToText(newEff, ', ', ' e '), '.'}
end

------------------------------------ FINE FOOTER ----------------------------------------





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
			return tab.search(data.gamesChron, string.lower(a)) < tab.search(data.gamesChron, string.lower(b))
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

return dr
