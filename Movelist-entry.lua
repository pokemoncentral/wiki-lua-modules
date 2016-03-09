-- Entries per i movelist

local m = {}

local mw = require('mw')

local w = require('Wikilib')
local ms = require('MiniSprite')
local lib = require('Wikilib-learnlists')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local forms = require('Wikilib-forms')
local c = require('Colore-data')
local gendata = require('Gens-data')
local sup = require('Sup-data')

-- Rappresentazione stringa dei parametri booleani
local boolDisplay = {No = '×', Yes = '✔'}

-- Contiene i colori di background delle celle del tutor
local tutorCellsColors = {c.cristallo.normale, c.rossofuoco.normale,
		c.smeraldo.normale, c.xd.normale, c.diamante.normale,
		c.platino.normale, c.heartgold.normale, c.nero.normale,
		c.nero2.normale, c.x.normale, c.rubinoomega.normale}


--[[

Crea una cella dati:
	- colore di background
	- colore del testo
	- colspan
	- contenuto della cella
Non sono presenti valori default

--]]
local makeCell = function(bg, tc, cs, cnt)
	return string.interp([[| style="background:#${bg}; color:#${tc};" colspan="${cs}" | '''${cnt}''']],
{
	bg = bg,
	tc = tc,
	cs = cs,
	cnt = cnt
})
end

-- Ritorna le due celle concatenate dopo la divisione usando i title

local twoCellsTitle = function(firstCell, secondCell)
	return table.concat{
		makeCell(firstCell.content == '×' and 'FFF' or c[firstCell.bg].light,
			c[firstCell.txt].dark, '1', table.concat{'<span class="explain" title="',
			firstCell.title, '">', firstCell.content, '</span>'}),
		'\n',
		makeCell(secondCell.content == '×' and 'FFF' or c[secondCell.bg].light,
			c[secondCell.txt].dark, '1', table.concat{'<span class="explain" title="',
			secondCell.title, '">', secondCell.content, '</span>'})}
end

-- Ritorna le due celle concatenate dopo la divisione usando i sup

local twoCellsBreed = function(firstCell, secondCell)
	if firstCell.content == '×' then
		firstCell = makeCell('FFF', c[firstCell.txt].dark, '1', firstCell.content)
	else
		firstCell = makeCell(c[firstCell.bg].light, c[firstCell.txt].dark, '1',
			firstCell.content .. sup[firstCell.title])
	end
	if secondCell.content == '×' then
		secondCell = makeCell('FFF', c[secondCell.txt].dark, '1', secondCell.content)
	else
		secondCell = makeCell(c[secondCell.bg].light, c[secondCell.txt].dark, '1',
			secondCell.content .. sup[secondCell.title])
	end
	return table.concat{firstCell, '\n', secondCell}
end

-- Le tables da passare a twoCellsTitle e twoCellsBreed, senza content
-- perché dipende dall'argomento 'data'

local twoCellsTables = {}
twoCellsTables.Y = {{bg = 'rosso', txt = 'verde', title = 'RVB'},
	{bg = 'giallo', txt = 'giallo', title = 'G'}}
twoCellsTables.C = {{bg = 'oro', txt = 'argento', title = 'OA'},
	{bg = 'cristallo', txt = 'cristallo', title = 'C'}}
twoCellsTables.FRLG = {{bg = 'rubino', txt = 'zaffiro', title = 'RZS'},
	{bg = 'rossofuoco', txt = 'verdefoglia', title = 'RFVF'}}
twoCellsTables.HGSS = {{bg = 'diamante', txt = 'platino', title = 'DPPt'},
	{bg = 'heartgold', txt = 'soulsilver', title = 'HGSS'}}
twoCellsTables.PtHGSS = {{bg = 'diamante', txt = 'perla', title = 'DP'},
	{bg = 'heartgold', txt = 'soulsilver', title = 'PtHGSS'}}
twoCellsTables.B2W2 = {{bg = 'bianco', txt = 'nero', title = 'NB'},
	{bg = 'bianco2', txt = 'nero2', title = 'N2B2'}}
twoCellsTables.ORAS = {{bg = 'x', txt = 'y', title = 'XY'},
	{bg = 'rubinoomega', txt = 'zaffiroalpha', title = 'ROZA'}}

-- Divide la cella della generazione in due se vi sono differenze nella stessa generazioni
-- Non chiamata per il breed

local split = {}

split.Y = function(cells, data, gen)
	twoCellsTables.Y[1].content = data[1]
	twoCellsTables.Y[2].content = data.Y
	cells[1] = twoCellsTitle(twoCellsTables.Y[1], twoCellsTables.Y[2])
end

split.C = function(cells, data, gen)
	twoCellsTables.C[1].content = data[3 - gen]
	twoCellsTables.C[2].content = data.C
	cells[3 - gen] = twoCellsTitle(twoCellsTables.C[1], twoCellsTables.C[2])
end

split.FRLG = function(cells, data, gen)
	twoCellsTables.FRLG[1].content = data[4 - gen]
	twoCellsTables.FRLG[2].content = data.FRLG
	cells[4 - gen] = twoCellsTitle(twoCellsTables.FRLG[1], twoCellsTables.FRLG[2])
end

split.HGSS = function(cells, data, gen)
	twoCellsTables.HGSS[1].content = data[5 - gen]
	twoCellsTables.HGSS[2].content = data.HGSS
	cells[5 - gen] = twoCellsTitle(twoCellsTables.HGSS[1], twoCellsTables.HGSS[2])
end

split.PtHGSS = function(cells, data, gen)
	twoCellsTables.PtHGSS[1].content = data[5 - gen]
	twoCellsTables.PtHGSS[2].content = data.PtHGSS
	cells[5 - gen] = twoCellsTitle(twoCellsTables.PtHGSS[1], twoCellsTables.PtHGSS[2])
end

split.B2W2 = function(cells, data, gen)
	twoCellsTables.B2W2[1].content = data[6 - gen]
	twoCellsTables.B2W2[2].content = data.B2W2
	cells[6 - gen] = twoCellsTitle(twoCellsTables.B2W2[1], twoCellsTables.B2W2[2])
end

split.ORAS = function(cells, data, gen)
	twoCellsTables.ORAS[1].content = data[7 - gen]
	twoCellsTables.ORAS[2].content = data.ORAS
	cells[7 - gen] = twoCellsTitle(twoCellsTables.ORAS[1], twoCellsTables.ORAS[2])
end

-- Divide in due le celle della generazione qualora vi siano differenze per il breed

local splitbreed = {}

splitbreed.Y = function(cells, data, gen)
	twoCellsTables.Y[1].content = data[1]
	twoCellsTables.Y[2].content = data.Y
	cells[1] = twoCellsBreed(twoCellsTables.Y[1], twoCellsTables.Y[2])
end

splitbreed.C = function(cells, data, gen)
	twoCellsTables.C[1].content = data[3 - gen]
	twoCellsTables.C[2].content = data.C
	cells[3 - gen] = twoCellsBreed(twoCellsTables.C[1], twoCellsTables.C[2])
end

splitbreed.FRLG = function(cells, data, gen)
	twoCellsTables.FRLG[1].content = data[4 - gen]
	twoCellsTables.FRLG[2].content = data.FRLG
	cells[4 - gen] = twoCellsBreed(twoCellsTables.FRLG[1], twoCellsTables.FRLG[2])
end

splitbreed.HGSS = function(cells, data, gen)
	twoCellsTables.HGSS[1].content = data[5 - gen]
	twoCellsTables.HGSS[2].content = data.HGSS
	cells[5 - gen] = twoCellsBreed(twoCellsTables.HGSS[1], twoCellsTables.HGSS[2])
end

splitbreed.PtHGSS = function(cells, data, gen)
	twoCellsTables.PtHGSS[1].content = data[5 - gen]
	twoCellsTables.PtHGSS[2].content = data.PtHGSS
	cells[5 - gen] = twoCellsBreed(twoCellsTables.PtHGSS[1], twoCellsTables.PtHGSS[2])
end

splitbreed.B2W2 = function(cells, data, gen)
	twoCellsTables.B2W2[1].content = data[6 - gen]
	twoCellsTables.B2W2[2].content = data.B2W2
	cells[6 - gen] = twoCellsBreed(twoCellsTables.B2W2[1], twoCellsTables.B2W2[2])
end

--[[

Genera le celle relative all'appendimento della
mossa nelle generazioni. Argomenti:
	- startGen: generazione iniziale
	- data: dati da inserire nelle celle
	- splitCells: table di funzioni che specificano come
			dividere la cella delle generazioni in due
--]]
local tail = function(startGen, data, splitCells)
	local store = {}
	
	-- Si inseriscono dapprima i dati standard delle generazioni
	for k = startGen, gendata.latest do
		local cellData = data[k - startGen + 1]
		local bgColor, txtColor
		if cellData == '×' then
			bgColor = 'FFF'
			txtColor = '000'
		else
			bgColor = c[gendata[k].region].normale
			txtColor = 'FFF'
		end
		table.insert(store, makeCell(bgColor, txtColor, '2', cellData))
	end
	
	-- Si dividono le celle delle generazioni se necessario
	for game in pairs(data) do
		if type(game) == 'string' then
			splitCells[game](store, data, startGen)
		end
	end
	
	return table.concat(store, '\n')
end

-- Le prime celle degli entry
local head = function(ndex, name, type1, type2, stab, notes, form)
	local ndexFigures = ndex:match('^(%d+)')
	return string.interp([=[|- style="background:#fff"
| style="width: 26px;" | ${num}
| style="width: 26px;" | ${ani}
| style="width: 75px;" | ${stab}[[${name}]]${stab}${notes}${forml}
| style="background:#${std}; width: ${wd} | [[${tipo1} (tipo)|<span style="color:#FFF;">${tipo1}</span>]]${tipo2}
]=],
{
	num = ndexFigures,
	ani = ms.aniLua(ndexFigures .. forms.getabbr(ndex, form)),
	stab = stab,
	name = name,
	notes = lib.makeNotes(notes or ''),
	forml = forms.getlink(ndex, false, form),
	std = c[type1].normale,
	tipo1 = type1,
	wd = type1 == type2 and '100px;" colspan="2"' or '50px;"',
	tipo2 = type1 == type2 and '' or string.interp('\n| style="width: 50px; background:#${std};" | [[${tipo} (tipo)|<span style="color:#FFF;">${tipo}</span>]]',
		{std = c[type2].normale, tipo = type2})
})
end

--[[

Crea un'entry nel caso in cui, oltre alle celle con i dati del
Pokémon, vi siano una o due celle per generazione. Argomenti:
	- p: i parametri passati dal wikicode.
	- makeText: la funzione che, a partire dai parametri, ricava
			il testo da inserire nella cella della generazione
	- splitCells: la table di funzioni che specificano come
			dividere la cella delle generazioni in due
	- latestGenDefault (opzionale): valore default per la cella
			dell'ultima generazione. Se non specificato, viene
			usato, sempre come default, il valore della penultima
			generazione
--]]
local entry = function(p, makeText, splitCells, latestGenDefault)
	--[[
		Dovendo usare table.filter, e quindi ipairs, è
		necessario che non vi siano nil prima dell'ultimo
		parametro, ragion per cui il terzo argomento  è
		esplicitamente settato a false
	--]]
	p = w.trimAndMap(p, string.fu, false)

	local gen = tonumber(table.remove(p, 1)) or 7
	local note, stab = p.note or '', p.STAB or ''
	local form = string.lower(p.form or '')

	p.note, p.STAB, p.form = nil, nil, nil
	p[12 - gen] = p[12 - gen] or latestGenDefault or p[11 - gen]

	--[[
		Si applica makeText solo ai dati relativi all'
		apprendimento della mossa nelle generazioni,
		scartando quelli del Pokémon.
	--]]
	local data = table.map(table.filter(p, function(_, key)
			return type(key) == 'string' or key > 5 and key < 13 - gen
		end), makeText)

	return head(p[1] or '000', p[2] or 'Missingno.', p[4] or 'Sconosciuto',
			p[5] or 'Sconosciuto', stab, note, form) .. tail(gen, data, splitCells)
end

--[[

Interfaccia per le entry livello: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.level = function(frame)
	return entry(mw.clone(frame.args),
			function(v) return v == 'No' and '×' or v end, split)
end

m.Level = m.level

--[[

Interfaccia per le entry macchina: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.tm = function(frame)
	return entry(mw.clone(frame.args),
			function(h) return boolDisplay[h] end, split, 'No')
end

m.Tm, m.TM = m.tm, m.tm

--[[

Interfaccia per le entry breed: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.breed = function(frame)
	return entry(mw.clone(frame.args), function(v) return v == 'No'
			and '×' or lib.insertnwlns(v, 6) end, splitbreed)
end

m.Breed = m.breed

--[[

Interfaccia per le entry event: costruisce il wikicode
per interpolazione.

--]]
m.event = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu)
	return string.interp([=[${h}
| style="background:#FFF;" colspan="2" | ${event}]=],
{
	h = head(p[1] or '000', p[2] or 'Missingno.', p[4] or 'Sconosciuto',
			p[5] or 'Sconosciuto', p.STAB or '', p.notes or '', p.form or ''),
	event = p[6] or 'Per la fine del mondo'
})
end

m.Event = m.event

--[[

Interfaccia per le entry tutor. Non usa la funzione
doit perché le celle non sono una per generazione

--]]
m.tutor = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu)
	local store = {head(p[1] or '000', p[2] or 'missingno.', p[4] or 'Sconosciuto',
			p[5] or 'Sconosciuto', p.STAB or '', p.notes or '', p.form or '')}

	-- Si scorrono i parametri relativi ai giochi
	for k = 6, #p do
		if p[k] == 'Yes' then
			table.insert(store, makeCell(tutorCellsColors[k - 5], 'FFF', '1', '✔'))
		elseif p[k] == 'No' then
			table.insert(store, makeCell('FFF', 'FFF', '1', '&nbsp;'))
		end
	end
	return table.concat(store, '\n')
end

m.Tutor = m.tutor

return m
