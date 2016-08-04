--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon, con tanto di note nel footer.
Per i Pokémon con più forme, crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes | DebRes | Nidoking }}

O direttamente con tipi e abilità, sia con parametri
posizionali che con con nome, es:

{{#invoke: DebRes | DebRes | Veleno | Terra | Velenopunto | Antagonismo | Forzabruta }}
{{#invoke: DebRes | DebRes | type1=Veleno | type2=Terra | abil1=Velenopunto | abil2=Antagonismo | abild=Clorofilla }}

Può essere chiamato anche con un solo tipo e una sola abilità, es:

{{#invoke: DebRes | DebRes | Spettro | | Levitazione }}
{{#invoke: DebRes | DebRes | type=Spettro | abil=Levitazione }}

Può essere chiamato anche con un solo tipo, es

{{#invoke: DebRes | DebRes | Spettro }}
{{#invoke: DebRes | DebRes | type=Spettro }}

Può essere chiamato anche con due soli tipi, es

{{#invoke: DebRes | DebRes | Veleno | Terra }}
{{#invoke: DebRes | DebRes | type1=Veleno | type2=Terra }}

Si potrebbe anche mescolare notazione posizionale e con nome, ma
consiglio vivamente di NON FARLO

--]]

local dr = {}

local mw = require('mw')

local w = require('Wikilib')
local forms = require('Wikilib-forms')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local et = require('EffTipi')
local box = require('Boxtipo')
local link = require('Links')
local pokes = require('Poké-data')
local alt = require('AltForms-data')
local abils = require('PokéAbil-data')
local c = require('Colore-data')

--[[

Questa classe rappresenta una tabella di efficacia
tipi. Primariamente, contiene informazioni riguardo
l'efficacia dei vari tipi di attacchi contro un
certo Pokémon (o forma alternativa), ovvero contro
una certa combinazione di tipi e abilità; oltre a
ciò, possiede le righe che compongono il footer e
le forme che hanno tali dati di efficacia tipi.

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

Tutte i possibili moltiplicatori dell'efficacia,
considerando anche le triple resistenze e gli
effetti di Filtro/Solidroccia e Pellearsa

--]]
EffTable.allEff = {0, 0.25, 0.5, 1, 2, 4, -- Standard
-- 0.125, -- Tripla resistenza (al momento inutile)
-- 0.3125, 0.625, 1.25, 2.5, 5, -- Pellearsa (al momento inutile)
1.5 -- 3 -- Filtro/Solidroccia (al momento 3 è inutile)
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

Ritorna true se bisogna aggiungere una
riga del footer di categoria MAYBE per
una certa abilità, dati i tipi del Pokémon.
Ciò accade se l'abilità non modifica
l'efficacia di tipi a cui i tipi propri
del Pkoémon danno già immunità

--]]
EffTable.shouldAddMaybe = function(abil, types)
	local abilMod = et.modTypesAbil[abil]
	local immType1 = et.typesHaveImm[types[1]]
	local immType2 = et.typesHaveImm[types[2]]

	if not abilMod then
		return false
	end
	if not (immType1 or immType2) then
		return true
	end

	for k, type in pairs(abilMod) do
		if immType1 and table.search(immType1, type)
				or immType2 and table.search(immType2, type) then
			return false
		end
	end
	return true
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

Costruttore della classe: ha in ingresso i tipi,
le abilità, ed eventuali uno o più nomi di forme

--]]
EffTable.new = function(types, abils, forms)
	local this = setmetatable({}, EffTable)
	
	types = table.map(types, string.lower)
	abils = table.map(abils, string.lower)
	
	local monoType = types[1] == types[2]
	
	-- Dati per la stampa
	this.colors = {
		bg = c[types[1]].normale,
		cells = c[types[1]].light,
		bd = c[types[2]][monoType and 'dark' or 'normale']
	}
	
	local onlyAbil = table.getn(abils) == 1
	
	--[[
		Se l'abilità non è unica, il calcolo
		dell'efficacia va fatto senza abilità,
		poiché se ne terrà conto nel footer
	--]]
	local abil = onlyAbil and abils.ability1 or 'tanfo'
	
	--[[
		Per ogni possibile efficacia, se vi sono
		tipi che la hanno, inserisce una table
		con i loro nomi all'indice dell'efficacia
		stessa
	--]]
	for k, eff in ipairs(EffTable.allEff) do
		local types = et.difesa(eff, types[1], types[2], abil)
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
		istanze di EffTable.FooterLine
	--]]
	this.footer = {}
	
	if abil ~= 'magidifesa' then
		if et.typesHaveImm[types[1]] then
			table.insert(this.footer, EffTable.FooterLine.new('RINGTARGET',
					types, abils))
		end
		
		--[[
			I tipi vanno scambiati perché il costruttore
			di EffTable.FooterLine controlla solo il primo
		--]]
		if not monoType and et.typesHaveImm[types[2]] then
			table.insert(this.footer, EffTable.FooterLine.new('RINGTARGET',
					{types[2], types[1]}, abils))
		end
	end
	if onlyAbil then
		if et.modTypesAbil[abil] then
			table.insert(this.footer, EffTable.FooterLine.new('TAKENOFF',
					types, abil))
		end
	else
		
		-- Can't use table.map because of string indexes
		for key, abil in pairs(abils) do
			if EffTable.shouldAddMaybe(abil, types) then
				table.insert(this.footer, EffTable.FooterLine.new('MAYBE',
						types, abil))
			end
		end
	end
	
	-- Va mantenuta ordinata per il contronfo e la stampa
	table.sort(this.footer)

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
	if not table.equal(a.footer, b.footer) then
		return false
	end
	
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

-- Aggiunge una forma a quelle presenti
EffTable.addForm = function(this, form)
	table.insert(this.forms, form)
end

--[[

Setta le classi css per l'espandibilità,
dunque se la tabella sarà espandibile e
se sarà ridotta o meno di default

--]]
EffTable.setCollapse = function(this, collapse)
	this.collapse = collapse
end

--[[

Stampa la tabella dell'efficacia tipi in
WikiCode: inserisce solo i valori di
efficacia almeno un tipo e il footer se
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
		foot = #this.footer < 1 and '' or string.interp([=[

|-
| class="roundy text-left text-small" style="padding: 2px; background: #${bg};" | ${lines}]=],
				{
					bg = this.colors.cells,
					lines = table.concat(table.map(this.footer, tostring))
				})
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

	if this.forms then
		return string.interp([[==== ${title} ====
<div class="${collapse}">
${tab}
</div>]],
			{
				title = mw.text.listToText(this.forms, ', ', ' e '),
				collapse = this.collapse or '',
				tab = tab
			})
	end
	
	return tab
end

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
EffTable.FooterLine = setmetatable({}, {__call = function(self, ...)
	return self.new(...) end })
EffTable.FooterLine.__index = EffTable.Footer

-- Stringhe utili
EffTable.FooterLine.strings = {

	-- Inizio del testo del footer per la categoria MAYBE
	MAYBE = 'Se questo Pok&eacute;mon ha [[${abil} (abilità)|${abil}]] ',

	-- Inizio del testo del footer per la categoria TAKENOFF
	TAKENOFF = 'Se questo Pok&eacute;mon perde [[${abil} (abilità)|${abil}]], o se ne sono annullati gli effetti, ',
		
	-- Inizio del testo del footer per la categoria RINGTARGET
	RINGTARGET = 'Se questo Pok&eacute;mon tiene un [[Facilsaglio]]',
	
	-- Stringhe da concatenare a RINGTARGET per alcuni tipi
	SPETTRO = ', se un avversario usa [[Preveggenza (mossa)|Preveggenza]] o [[Segugio (mossa)|Segugio]] o ha [[Nervisaldi (abilità)|Nervisaldi]], ',
	BUIO = ' o se un avversario usa [[Miracolvista (mossa)|Miracolvista]], ',
	VOLANTE = ' o una [[Ferropalla]] o se viene usata [[Gravità (mossa)|Gravit&agrave;]], ',
	
	--[[
		Stringhe da concatenare a RINGTARGET quando un'
		abilità e un il tipo danno la stessa immunità
	--]]
	NOT_HAVE_ABIL = 'e se non ha [[${abil} (abilità)|${abil}]], ',
	IMM_TAKENOFF = 'e se ha perso [[${abil} (abilità)|${abil}]] o ne sono stati annullati gli effetti, ',
	
	-- Testo per la nuova efficacia
	EFF = "l'efficacia delle mosse di tipo ${types} &egrave; pari a ${eff}×"
}

-- Ordine delle categorie, per l'ordinamento delle righe
EffTable.FooterLine.kindOrder = {'MAYBE', 'TAKENOFF', 'RINGTARGET'}

--[[

Ritorna true se abil dà immunità a type.
Si verifica che l'efficacia di type su
un ipotetico Pokémon che non ha immunità
derivanti dai tipi sia nulla

--]]
EffTable.FooterLine.abilityGrantsImm = function(abil, type)
	return 0 == et.efficacia(type, 'elettro', 'elettro', abil)
end

--[[

Contiene funzioni che generano la parte iniziale
del footer in base alla categoria

--]]
EffTable.FooterLine.init = {}

-- Parte iniziale per la categoria MAYBE
EffTable.FooterLine.init.MAYBE = function(abil)
	return string.interp(EffTable.FooterLine.strings.MAYBE,
			{abil = txt.camelCase(abil)})
end

-- Parte iniziale per la categoria TAKENOFF
EffTable.FooterLine.init.TAKENOFF = function(abil)
	return string.interp(EffTable.FooterLine.strings.TAKENOFF,
			{abil = txt.camelCase(abil)})
end

--[[

Parte iniziale per la categoria RINGTARGET:
aggiunge le stringhe necessarie per alcuni
tipi e abilità e concatena il tutto

--]]
EffTable.FooterLine.init.RINGTARGET = function(abils, type)
	local pieces = {EffTable.FooterLine.strings.RINGTARGET}

	table.insert(pieces, EffTable.FooterLine.strings[type:upper()]
			or ' ')
	
	--[[
		Se l'abilità è una sola, bisogna inserire una
		stringa diversa in caso di immunità condivise
	--]]
	local notAbil = table.getn(abils) == 1
			and EffTable.FooterLine.strings.IMM_TAKENOFF
			or EffTable.FooterLine.strings.NOT_HAVE_ABIL
	
	--[[
		Per ogni abilità, controlla se ha un'immunità
		condivisa con il tipo del footer, e in tal caso
		inserisce una stringa a tal proposito
	--]]
	for k, abil in pairs(abils) do
		for k, typeImm in pairs(et.typesHaveImm[type:lower()]) do
			if EffTable.FooterLine.abilityGrantsImm(abil, typeImm) then
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
EffTable.FooterLine.new = function(kind, types, abil)
	local this = setmetatable({}, EffTable.FooterLine)
	
	kind = kind:upper()
	types = table.map(types, string.lower)
	abil = type(abil) ~= 'table' and abil:lower() or
			table.map(abil, string.lower)
	
	-- La categoria di riga
	this.kind = kind
	
	-- La parte iniziale della riga del footer
	this.init = '\n*' .. EffTable.FooterLine.init[kind](abil, types[1])
	
	--[[
		Per ogni nuova efficacia ha una subtable
		con i tipi che hanno detta efficacia: tali
		subtables vanno tenute ordinate per la
		conversione a stringa stampa e il confronto
		con table.equal
	--]]
	this.newEff = {}

	--[[
		Filtro, Solidroccia e Magidifesa sono casi
		particolari da trattare separatamente,
		ammesso che si stia creando una riga relativa
		alle abilità
	--]]
	if kind ~= 'RINGTARGET' then
		if abil == 'filtro' or abil == 'solidroccia' then
		
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

			local x2 = et.difesa(2, types[1], types[2], 'tanfo')
			table.sort(x2) -- Vedi commento a this.newEff
			this.newEff[x2Key] = x2
			
			local x4 = et.difesa(4, types[1], types[2], 'tanfo')
			
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
			this.tostring = string.interp(table.concat{'\n*', EffTable.FooterLine.strings.TAKENOFF,
					[=[solo mosse di tipo <span style="background:#${bgn}">[[Normale (tipo)|<span style="padding: 0.2ex 0.3em; color:#FFF">Normale</span>]]</span> e <span style="background:#${bgl}">[[Lotta (tipo)|<span style="padding: 0.2ex 0.3em; color:#FFF;">Lotta</span>]]</span> non lo renderanno esausto.]=]},
					{
						abil = 'Magidifesa',
						bgn = c.normale.normale,
						bgl = c.lotta.normale
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
		if types[1] == types[2] then
			this.newEff[1] = et.typesHaveImm[types[1]]
			table.sort(this.newEff[1]) -- Vedi commento a this.newEff
			
			return this
		else
			newTypes = et.typesHaveImm[types[1]]
			
			--[[
				Quando perde l'immunita, ai fini del
				calcolo danni il Pokémon è monotipo
			--]]
			types[1] = types[2]
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
		local eff = et.efficacia(type, types[1],
				types[2], abil)
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
EffTable.FooterLine.__eq = function(a, b)
	return a.tostring and b.tostring 
		or not (a.tostring or b.tostring)
			and a.init == b.init
			and table.equal(a.newEff, b.newEff)
end

--[[

Operatore minore, per l'ordinamento:
confronta gli indici delle categorie in
EffTable.FooterLine.kindOrder e in caso
di uguaglianza i testi iniziali

--]]
EffTable.FooterLine.__lt = function(a, b)
	local aIndex = table.search(EffTable.FooterLine.kindOrder, a.kind)
	local bIndex = table.search(EffTable.FooterLine.kindOrder, b.kind)
	return aIndex == bIndex and a.init < b.init or aIndex < bIndex
end

--[[

Conversione a stringa.

Per ogni efficacia crea la stringa con
l'elenco dei tipi corrispondenti in campo
colorato, per poi concatenarle tutte alla
parte iniziale

--]]
EffTable.FooterLine.__tostring = function(this)
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
		table.insert(newEff, string.interp(EffTable.FooterLine.strings.EFF,
				{
					types = mw.text.listToText(colorTypes, ', ', ' e '),
					eff = EffTable.displayEff(eff)
				}))
	end
	
	return table.concat{this.init, mw.text.listToText(newEff, ', ', ' e '), '.'}
end

--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon, il suo ndex o una combo tipi +
abilità e genera le table dell'efficacia tipi. Se il 
Pokémon ha più forme, ritorna una table per ogni forma,
tutte collassabili con solo quella della forma base
estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
	local pokeData = pokes[string.parseInt(p[1]) or p[1]]
	
	--[[
		If no data is found, first parameter is
		the type, that is no Pokémon is given and
		types and abilities are directly provided
	--]]
	if not pokeData then
		local types, abils = {}, {}
		types[1] = p[1] or p.type1 or p.type
		types[2] = p[2] or p.type2 or types[1]
		abils.ability1 = p[3] or p.abil1 or p.abil
		abils.ability2 = p[4] or p.abil2
		abils.abilityd = p[5] or p.abild
		return tostring(EffTable.new(types, abils))
	end

	local name = pokeData.name:lower()
	local altData = alt[name]
	
	if altData then
		local effTables = {}
		--[[
			Scorrendo gamesOrder i Box saranno già ordinati
			senza bisogno di sorting successivo.
			
			Non si può usare table.map perché ciò porterebbe
			ad avere buchi negli indici di effTables, cosa
			difficilmente gestibile
		--]]
		for k, abbr in ipairs(altData.gamesOrder) do
			abbr = abbr == '' and 'base' or abbr
			local name = abbr == 'base' and name or name .. abbr
			local formPoke, formAbils = pokes[name], abils[name]
			local formName = altData.names[abbr]
			local formEffTable = EffTable.new({formPoke.type1, formPoke.type2},
					formAbils, formName)
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
		
		-- Se c'è una sola table non bisogna far collassare niente
		if #effTables == 1 then
			return tostring(effTables[1])
		end
		
		--[[
			Si rendono tutte le tables collasabili e tutte
			tranne la prima collassate di default
		--]]
		return table.concat(table.map(effTables, function(effTable, key)
				effTable:setCollapse('mw-collapsible' ..
						(key == 1 and '' or ' mw-collapsed'))
				return tostring(effTable)
			end), '\n')
	else
		return tostring(EffTable.new({pokeData.type1,
				pokeData.type2}, abils[name]))
	end
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes

print(dr.DebRes{args=arg})
-- return dr
