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
local EffTable = setmetatable({}, {__call = function(self, ...)
	return self.new(...) end })
EffTable.__index = EffTable

-- Stringhe utili
EffTable.strings = {

	--[[
		Wikicode per la parte iniziale di un box
		(Debolezze, Immunità, Danno Normale, ecc)
	--]]
	BOX_INIT = [=[| class="roundy" style="padding: 0; background: #${bg};" | <span style="line-height: ${height}ex;">'''${text}'''</span><div class="roundy pull-right text-left grid" style="margin: -2px; border-spacing: 0; padding: 0; width: 70%; border: 2px solid #${bd};">]=],
	
	-- Wikicode per una riga di tipi aventi la stessa efficacia
	BOX_LINE = [=[<div class="grid-row"><div class="roundy${rd} grid-cell text-center align-middle" style="width: 5%; background: #FFF;">${eff}×</div><div class="grid-cell" style="padding: 0 0 0 0.2em;">${types}</div></div>]=],
	
	-- Wikicode per il separatore di righe con la stessa efficacia
	LINES_SEPARATOR = [=[<div class="grid-row"><div class="grid-cell" style="height: 2px; padding: 0; background: #${bg};"></div><div class="grid-cell" style="height: 2px; padding: 0; background: #${bg};"></div></div>]=]
}

--[[

Tutte i possibili moltiplicatori dell'efficacia

--]]
EffTable.allEff = {
	0, 0.25, 0.5, 1, 2, 4, -- Standard
}

--[[

Altezza di una riga di Boxtipo in ex (1px -> 0.1ex):
line-height + 2*padding + 2*border + 2*margin

--]]
EffTable.typesLineHeight = 4.4

--[[

Usata per calcolare l'altezza delle label in ex
dei box in funzione del numero di righe di ogni
efficacia contenuta: avendo una width del 18%,
i boxtipo si dispongono in massimo cinque per
riga, con i restanti a formarne una in più.
Infine, si tiene conto anche del separatore di
righe, di altezza 2px (-> 0.3ex).

--]]
EffTable.getHeight = function(box)
	local totalLinesHeight = 0
	for k, line in ipairs(box) do
		totalLinesHeight = totalLinesHeight +
				math.ceil(#line.types / 5) *
				EffTable.typesLineHeight
	end
	return totalLinesHeight + (#box - 1) * 0.3
end

--[[

Visualizzazione dei moltiplicatori di efficacia,
se diversa dal semplice numero

--]]
EffTable.effStrings = {
	[0.5] = '½',
	[0.25] = '¼'
}

--[[

Ritorna la visualizzazione dell'efficacia, se
presente, altrimenti semplicemente il numero
con la virgola come separatore decimale

--]]
EffTable.displayEff = function(eff)
	return EffTable.effStrings[eff] or
		(tostring(eff):gsub('%.', ','))
end

--[[

Usata per il sorting delle righe dei tipi
aventi la stessa efficacia, fa in modo che
vengano ordinate per efficacia decrescente

--]]
EffTable.greatestEffFirst = function(line0, line1)
	return line0.eff > line1.eff
end

-- Stampa i tipi dati come Boxes tipi
EffTable.printTypes = function(types)
	return box.listLua(types, ' inline-block',
		'margin: 0.3ex; padding: 0.3ex 0; width: 18%; line-height: 3ex; font-weight: bold; box-sizing: border-box;', true)
end

--[[

Stampa una riga di tipi aventi la stessa
efficacia, aggiungendo il bordo inferiore
se indicato

--]]
EffTable.printEffLine = function(data, colors, roundy)
	return string.interp(EffTable.strings.BOX_LINE,
		{
			rd = roundy or '',
			eff = EffTable.displayEff(data.eff),
			types = EffTable.printTypes(data.types)
		})
end

-- Stampa un singolo box (Debolezze, Immunità, Danno Normale, ecc)
EffTable.printSingleBox = function(boxData, colors)

	--[[
		Il controllo andrebbe comunque fatto dopo la
		seconda table.remove, ma qui è più leggibile
	--]]
	if #boxData == 1 then
		return string.interp(table.concat{EffTable.strings.BOX_INIT,
				EffTable.printEffLine(boxData[1], colors), '</div>'},
		{
			bg = colors.cells,
			height = EffTable.getHeight(boxData),
			text = boxData.text,
			bd = colors.bg
		})
	end

	--[[
		L'altezza della label del box va calcolata
		ora perché dopo si manipola boxData
	--]]
	local height = EffTable.getHeight(boxData)

	local linesSep = string.interp(EffTable.strings.LINES_SEPARATOR,
			{bg = colors.bg})
	
	-- Prima e ultima riga hanno l'efficacia arrotondata
	local firstLine = EffTable.printEffLine(table.remove(boxData, 1),
			colors, 'top')
	local lastLine = EffTable.printEffLine(table.remove(boxData),
			colors, 'bottom')

	-- Controllo superfluo, ma il caso con due righe è molto comune
	local allLines
	if #boxData > 0 then
		allLines = table.map(boxData, function(lineData)
				if type(lineData) == 'table' then
					return EffTable.printEffLine(lineData, colors)
				end
			end)
	else
		allLines = {}
	end

	table.insert(allLines, 1, firstLine)
	table.insert(allLines, lastLine)
	return string.interp(table.concat{EffTable.strings.BOX_INIT,
			table.concat(allLines, linesSep), '</div>'},
		{
			bg = colors.cells,
			height = height,
			text = boxData.text,
			bd = colors.bg
		})
end

--[[

Stampa i boxes (Debolezze, Resistenze, ecc)
passati solo se hanno almeno una riga

--]]
EffTable.printEffBoxes = function(boxes, colors)
	boxes = table.filter(boxes, function(box)
			return type(box) ~= 'table' or #box > 0
	end)
	return table.concat(table.map(boxes, function(box)
			return EffTable.printSingleBox(box, colors)
		end), '\n|-\n')
end

--[[

Costruttore della classe: ha in ingresso i tipi

I tipi potrebbero essere tipi glitch inesistenti nel
modulo EffTipi. In questo caso, non hanno nessuna debolezza
o resistenza e devono quindi comportarsi di conseguenza

--]]
EffTable.new = function(types, forms)
	local this = setmetatable({}, EffTable)

	local monoType = types[1] == types[2]

	-- Colori per la stampa
	this.colors = {
		bg = c[types[1]].normale,
		cells = c[types[1]].light,
		bd = c[types[2]][monoType and 'dark' or 'normale']
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

	--[=[
	--[[
		Contiene le righe del footer sotto forma di
		istanze di EffTable.FooterLine
	--]]
	this.footer = {}
	]=]

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
	--[=[if not table.equal(a.footer, b.footer) then
		return false
	end]=]
	
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

Stampa la tabella dell'efficacia tipi in
WikiCode: inserisce solo i valori di
efficacia con almeno un tipo e il footer se
ha almeno una riga

--]]
EffTable.__tostring = function(this)
	local weak = {text = 'Debolezze'}
	local std = {text = 'Danno normale'}
	local res = {text = 'Resistenze'}
	local imm = {text = 'Immunit&agrave;'}

	local interpData = {
		bg = this.colors.bg,
		bd = this.colors.bd,
		foot = ''--[==[foot = #this.footer < 1 and '' or string.interp([=[

|-
| class="roundy text-left text-small" style="padding: 2px; background: #${bg};" | ${lines}]=],
				{
					bg = this.colors.cells,
					lines = table.concat(table.map(this.footer, tostring))
				})]==]
	}

	-- Non si può usare ipairs perché gli indici non sono interi
	for eff, types in pairs(this) do
		if type(eff) == 'number' then
			--[[
				Non si usa eff come indice perché così le tables
				sono ordinabili, avendo indici interi
			--]]
			if eff == 0 then
				table.insert(imm, {eff = 0, types = types})
			elseif eff < 1 then
				table.insert(res, {eff = eff, types = types})
			elseif eff == 1 then
				table.insert(std, {eff = 1, types = types})
			else -- eff > 1
				table.insert(weak, {eff = eff, types = types})
			end
		end
	end

	-- È inutile ordinare imm e std, hanno un solo elemento
	table.sort(res, EffTable.greatestEffFirst)
	table.sort(weak, EffTable.greatestEffFirst)
	
	interpData.effBoxes = EffTable.printEffBoxes({weak, std, 
			res, imm}, this.colors)

	-- Si può andare a capo con effBoxes perché ce n'è sempre almeno uno
	local tab = string.interp([[{| class="roundy pull-center text-center" style="width: 80%; max-width: 80%; background: #${bg}; border: 3px solid #${bd};"
${effBoxes}${foot}
|}]], interpData)

	return tab
end

--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon, il suo ndex o una combo tipi
e genera le table dell'efficacia tipi di prima generazione. Se il 
Pokémon ha più forme, ritorna una table per ogni forma,
tutte collassabili con solo quella della forma base
estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
	local p = tab.map(mw.clone(frame.args), w.trim)

	-- Se tra i parametri c'è game, allora cerca il Pokémon in quel gioco
	local game, index
	if p.game then
		game = p.game
		index = table.deepSearch(pokes[game], p[1])
	else
		game, index = table.deepSearch(pokes, p[1])
		-- Se il Pokémon è stato trovato non vengono passati i tipi
		-- quindi il secondo parametro se c'è è il gioco
		-- (avviene comunque un ulteriore controllo)
		game = pokes[p[2]] and p[2] or game
	end
	local pokeData = pokes[game][index]

	local types = {}

	--[[
		If no data is found, first parameter is
		the type, that is no Pokémon is given and
		types are directly provided
	--]]
	if not pokeData then
		types[1] = p[1] or p.type1 or p.type
		types[2] = p[2] or p.type2 or types[1]
	else
		types[1] = pokeData.type1
		types[2] = pokeData.type2 or pokeData.type1
	end

	return tostring(EffTable.new(types))
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes

--local arg = {"Missingno.", 'G'}
print(dr.DebRes{args=arg})
-- return dr
