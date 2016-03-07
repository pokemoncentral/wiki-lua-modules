-- Entries per i movelist

local m = {}

local mw = require('mw')

local ms = require('MiniSprite')
local lib = require('Wikilib-learnlists')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local forms = require('Wikilib-forms')
local c = require('Colore-data')
local gendata = require('Gens-data')
local sup = require('Sup-data')

-- Interpola alla cella base i parametri passati

local makeCell = function(bg, tc, cs, cnt)
	return string.interp([[| style="background:#${bg}; color:#${tc}" colspan="${cs}" | '''${cnt}''']],
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

-- Genera le ultime celle degli entries, dati generazione e contenuto

local tail = function(gen, p, dual)
	local store = {}
	for k = gen, 6 do
		table.insert(store, makeCell(p[k - gen + 1] == '×' and 'FFF' or
			c[gendata[k].region].normale, p[k - gen + 1] == '×' and '000' or 'FFF',
			'2', p[k - gen + 1]))
	end
	for k in pairs(p) do
		if type(k) == 'string' then
			dual[k](store, p, gen)
		end
	end
	return table.concat(store, '\n')
end

-- Le prime celle degli entry

local head = function(ndex, name, type1, type2, stab, notes, form)
	return string.interp([=[|- style="background:#fff"
| width="26px" | ${num}
| width="26px" | ${ani}
| width="75px" | ${stab}[[${name}]]${stab}${notes}${forml}
| style="background:#${std}; width: ${wd} | [[${tipo1} (tipo)|<span style="color:#FFF;">${tipo1}</span>]]${tipo2}
]=],
{
	num = ndex:match('(%d+)'),
	ani = ms.aniLua(ndex:match('(%d+)') .. forms.getabbr(ndex, form)),
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

-- Args: la tabella con i parametri e una funzione per determinare i il contenuto delle ultime celle.
-- Estrae la generazione, poi scorre tutta la tabella cercando i parametri delle ultime celle
-- e memorizzando i valori corrispondenti in un'altra tabella, che poi viene passata alla funzione tail.

local doit = function(p, values, dual, default)
	local gen = tonumber(table.remove(p, 1)) or 7,
	local note, stab = p.note or '', p.STAB or ''
	local form = string.lower(p.form or '')
	p.note, p.STAB, p.form = nil, nil, nil
	p[12 - gen] = p[12 - gen] or default or p[11 - gen]	
	local data = table.filter(function(_, key)
		return type(key) == 'string' or key > 5 and key < 13 - gen
	end)
	return head(p[1] or '000', p[2] or 'missingno.', p[4] or 'Sconosciuto', p[5] or 'Sconosciuto', stab, note, form) ..
		tail(gen, data, dual)
end

-- Interfaccia per gli entry di livello: si aspetta come
-- primo argomento la generazione, seguita dagli altri

m.level = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu, false)
	return doit(p, function(v) return v == 'No' and '×' or v end, split)
end

m.Level = m.level

-- Interfaccia per gli entry di macchine: si aspetta come
-- primo argomento la generazione, seguita dagli altri

m.tm = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu, false)
	return doit(p, function(h) local v = {No = '×', Yes = '✔'} return v[h] end, split, 'No')
end

m.Tm, m.TM = m.tm, m.tm

-- Interfaccia per gli entry di breed: si aspetta come
-- primo argomento la generazione, seguita dagli altri

m.breed = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu, false)
	return doit(p, function(v) return v == 'No' and '×' or lib.insertnwlns(v, 6) end, splitbreed)
end

m.Breed = m.breed

-- Interfaccia per gli entry di event: interpola alla stringa le variabili passate

m.event = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu, false)
	return string.interp([=[${h}
| style="background:#FFF;" colspan="2" | ${event}]=],
{
	h = head(p[1] or '000', p[2] or 'missingno.', p[4] or 'Sconosciuto', p[5] or 'Sconosciuto', p.STAB or '', p.notes or '',
		p.form or ''),
	event = p[6] or 'Per la fine del mondo'
})
end

m.Event = m.event

-- Interfaccia per i tutor. Non usa la funzione doit perché le celle non sono una per generazione

m.tutor = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu)
	local store = {head(p[1] or '000', p[2] or 'missingno.', p[4] or 'Sconosciuto', p[5] or 'Sconosciuto', p.STAB or '', p.notes or '', p.form or '')}
	local games = {'cristallo', 'rossofuoco', 'smeraldo', 'xd', 'diamante', 'platino', 'heartgold', 'nero', 'nero2', 'x', 'rubinoomega'}
	for b = 6, #p do
		if p[b] == 'Yes' then
			table.insert(store, makeCell(c[games[b - 5]].normale, 'FFF', '1', '✔'))
		elseif p[b] == 'No' then
			table.insert(store, makeCell('FFF', 'FFF', '1', '&nbsp;'))
		end
	end
	return table.concat(store, '\n')
end

m.Tutor = m.tutor

return m
