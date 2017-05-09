-- Entries per i movelist

local m = {}

local mw = require('mw')

local w = require('Wikilib')
local ms = require('MiniSprite')
local lib = require('Wikilib-learnlists')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local forms = require('Wikilib-forms')
local c = require("Colore-data")
local css = require('Css')
local box = require('Box')
local gendata = require("Gens-data")
local abbr = require("Blackabbrev-data")
local pokes = require("Poké-data")
local groups = require("PokéEggGroup-data")
local libdata = require("Wikilib-data")

-- Rappresentazione stringa dei parametri booleani
local boolDisplay = {No = '×', Yes = '✔'}

--[[

Associa la generazione ad ogni sigla che può
essere l'indice di un parametro

--]]
local gameGens = {Y = 1, C = 2, FRLG = 3, E = 3, HGSS = 4,
		PTHGSS = 4, B2W2 = 5, ORAS = 6, SM = 7}

-- Contiene i colori di background delle celle del tutor
local tutorCellsColors = {'cristallo', 'rossofuoco',
	'smeraldo', 'xd', 'diamante', 'platino', 'heartgold',
	'nero', 'nero2', 'x', 'rubinoomega', 'sole'
}

--[[

Crea una cella dati:
	- colore di background
	- colore del testo
	- colspan
	- contenuto della cella
Non sono presenti valori default

--]]
local makeCell = function(bg, tc, cs, cnt, collapsed)
	return string.interp([[| style="color: #${tc}; height: 100%; padding: 0.8ex 0.3ex;" colspan="${cs}" | ${content}]], {
		tc = tc,
		cs = cs,
		content = string.interp(string.lower(bg) == 'fff' and [['''${cnt}''']] or [[<div class="text-center roundy-5 flex flex-row flex-main-center flex-items-center ${collapsed}" style="${bg}; padding: 0 2px; height: 100%;">'''${cnt}'''</div>]], {
			bg = string.lower(bg) == 'fff' and '' or css.horizGradLua(bg, 'normale', bg, 'light'),
			cnt = cnt,
			collapsed = collapsed and 'mw-collapsible mw-collapsed' or '',
		}),
	})
end

--[[

Dati per la divisione delle celle delle generazioni in
base al gioco che compare come parametro: di ognuna delle
due celle risultanti, è specificato il colore di background,
quello del testo e una sigla, che viene usata per il
title o il sup

--]]
local splitCellsData = {}
splitCellsData.Y = {{bg = 'rosso', txt = 'verde', abbr = 'RVB'},
	{bg = 'giallo', txt = 'giallo', abbr = 'G'}}
splitCellsData.C = {{bg = 'oro', txt = 'argento', abbr = 'OA'},
	{bg = 'cristallo', txt = 'cristallo', abbr = 'C'}}
splitCellsData.FRLG = {{bg = 'rubino', txt = 'zaffiro', abbr = 'RZS'},
	{bg = 'rossofuoco', txt = 'verdefoglia', abbr = 'RFVF'}}
splitCellsData.E = {{bg = 'rubino', txt = 'zaffiro', abbr = 'RZRFVF'},
	{bg = 'smeraldo', text = 'smeraldo', abbr = 'S'}}
splitCellsData.HGSS = {{bg = 'diamante', txt = 'platino', abbr = 'DPPt'},
	{bg = 'heartgold', txt = 'soulsilver', abbr = 'HGSS'}}
splitCellsData.PtHGSS = {{bg = 'diamante', txt = 'perla', abbr = 'DP'},
	{bg = 'heartgold', txt = 'soulsilver', abbr = 'PtHGSS'}}
splitCellsData.B2W2 = {{bg = 'bianco', txt = 'nero', abbr = 'NB'},
	{bg = 'bianco2', txt = 'nero2', abbr = 'N2B2'}}
splitCellsData.ORAS = {{bg = 'x', txt = 'y', abbr = 'XY'},
	{bg = 'rubinoomega', txt = 'zaffiroalpha', abbr = 'ROZA'}}
splitCellsData.SM = {{bg = 'sole', txt = 'luna', abbr = 'SL'}}

--[[

Ritorna l'indice della cella relativa ad una
generazione, data la generazione iniziale dell'
entry e uno tra la generazione corrente o un gioco

--]]
local getGenIndex = function(startGen, game)
	return (type(game) == 'number' and game or
			gameGens[game:upper()]) + 1 - startGen
end

--[[

Divide una certa cella di una generazione in due, usando
una funzione per creare le nuove celle: il risultato è poi
concatenato e inserito nella cella della stessa generazione,
in modo da avere un numero di celle fisso. Argomenti:
	- cells: l'elenco di celle delle generazioni
	- data: i dati da inserire nelle celle
	- startGen: la generazione iniziale dell'entry
	- game: indice del parametro che causa la divisione,
			normalmente una sigla di un gioco
	- makeCell: la funzione usata per creare le nuove celle
	- collapse (opzionale): specifica se le celle devono
			essere collassate o meno. Default false

--]]
local splitCell = function(cells, data, startGen, game, makeCell, collapse)
	local genIndex = getGenIndex(startGen, game)
	cells[genIndex] = table.concat{makeCell(data[genIndex],
			splitCellsData[game][1], collapse), '\n',
			makeCell(data[game], splitCellsData[game][2], collapse)}
end

--[[

Crea una cella con il contenuto specificato
avente un title usando i dati forniti per il
colore di background, il colore del testo e
il title

--]]
local makeTitleCell = function(content, cellData)
	return makeCell(content == '×' and 'FFF' or cellData.bg,
			cellData.txt, '1',
			table.concat{'<span class="explain" title="', cellData.abbr,
			'">', content, '</span>'})
end

--[[

Crea una cella con il contenuto specificato avente
un sup solo se il primo è significativo. Il colore
di background, quello del testo e il sup vengono
presi dai dati forniti.

--]]
local makeSupCell = function(content, cellData, collapse)
	if content == '×' then
		return makeCell('FFF', cellData.txt, '1', content)
	else
		return makeCell(cellData.bg, cellData.txt, '1',
			content .. abbr[cellData.abbr], collapse)
	end
end

--[[

Divide una certa cella di una generazione in due, usando
i title nelle celle nuove; per maggiori informazioni
leggere il commento a splitCel più su.

--]]
local splitTitle = function(cells, data, startGen, game, collapse)
	return splitCell(cells, data, startGen, game, makeTitleCell, collapse)
end

--[[

Divide una certa cella di una generazione in due, usando
i sup nelle celle nuove; per maggiori informazioni
leggere il commento a splitCel più su.

--]]
local splitSup = function(cells, data, startGen, game, collapse)
	return splitCell(cells, data, startGen, game, makeSupCell, collapse)
end

--[[

Genera le celle relative all'appendimento della
mossa nelle generazioni. Argomenti:
	- startGen: generazione iniziale dell'entry
	- data: dati da inserire nelle celle
	- splitCells: funzione usata per dividere la
			cella delle generazioni in due
	- collapse (opzionale): specifica se il contenuto
			delle celle deve essere collassato. Default false

--]]
local tail = function(startGen, data, splitCells, collapse)
	local store = {}

	-- Si inseriscono dapprima i dati standard delle generazioni
	for k = startGen, gendata.latest do
		local cellData = data[getGenIndex(startGen, k)]
		local bgColor, txtColor
		if cellData == '×' then
			bgColor = 'FFF'
			txtColor = '000'
		else
			bgColor = gendata[k].region
			txtColor = 'FFF'
		end
		table.insert(store, makeCell(bgColor, txtColor, '2', cellData, collapse))
	end
	
	-- Si dividono le celle delle generazioni se necessario
	for game in pairs(data) do
		if type(game) == 'string' then
			splitCells(store, data, startGen, game, collapse)
		end
	end
	
	return table.concat(store, '\n')
end

-- Le prime celle degli entry
local head = function(ndex, stab, notes, form)
	local ndexFigures = ndex:match('^(%d+)')
	local abbr = forms.getabbr(ndex, form)
	local pokedata = table.cloneLoadData(pokes[abbr == 'base' and tonumber(ndexFigures) or ndexFigures .. abbr]
		or {name = 'Missingno.', ndex = '000'})
	pokedata = table.merge(pokedata, table.cloneLoadData(groups[pokedata.ndex] or {group1 = 'sconosciuto'}))
	pokedata.group1show = pokedata.group1 == 'coleottero' and 'Coleot' or (pokedata.group1 == 'non ancora scoperto' and 'Non ancora<div>scoperto</div>' or string.fu(pokedata.group1))
	pokedata.group2show = pokedata.group2 == 'coleottero' and 'Coleot' or string.fu(pokedata.group2)
	pokedata.type2 = pokedata.type2 ~= pokedata.type1 and string.fu(pokedata.type2) or nil
	pokedata.type1 = string.fu(pokedata.type1)
	local boxClasses = '-5 flex flex-row flex-main-center flex-items-center'
	local boxStyles = 'padding: 0 2px; margin-bottom: 0.2ex;'

	return string.interp([=[|- style="height: 100%;"
| class="hidden-xs" | ${num}
| ${ani}
| ${stab}[[${name}]]${stab}${notes}${forml}
| class="hidden-sm" style="height: 100%;${typesmall} padding: 0.8ex 0.3ex;" | ${types}
| class="hidden-sm" style="height: 100%;${groupsmall} padding: 0.8ex 0.3ex;" | ${groups}
]=],
{
	num = ndexFigures,
	ani = ms.staticLua(ndexFigures .. (abbr == 'base' and '' or abbr)),
	stab = stab,
	name = pokedata.name,
	notes = lib.makeNotes(notes or ''),
	forml = forms.getlink(ndex, false, form),
	std = c[pokedata.group1 .. '_uova'].normale,
	types = box.boxTipoLua(pokedata.type1, boxClasses, boxStyles .. (pokedata.type2 and 'height: 50%;' or ' height: 100%;')) .. (pokedata.type2 and box.boxTipoLua(pokedata.type2, boxClasses, boxStyles .. 'height: 50%;') or ''),
	typesmall = pokedata.type2 and 'font-size: 90%;' or '',
	groups = box.boxLua(pokedata.group1show, pokedata.group1 .. ' (gruppo uova)', pokedata.group1 .. '_uova', boxClasses, boxStyles .. (pokedata.group2 and 'height: 50%;' or ' height: 100%;')) .. (pokedata.group2 and box.boxLua(pokedata.group2show, pokedata.group2 .. ' (gruppo uova)', pokedata.group2 .. '_uova', boxClasses, boxStyles .. 'height: 50%;') or ''),
	groupsmall = pokedata.group2 and 'font-size: 90%;' or '',
})
end

--[[

Elimina da frame.args i parametri inutili, presenti solo
per compatibilità con il vecchio template e il vecchio
modulo

--]]
local removeOldParams = function(p)
	local pokedata = pokes[tonumber(p[1])] or pokes[p[1]] or {name = 'Missingno.'}

	-- rimuove il parametro 2 se è il nome del Pokémon
	if (string.fu(p[2]) == pokedata.name) then
		table.remove(p, 2)
	end
	-- rimuove i parametri 3, 4 e 5 (ora 2, 3 e 4)
	--		se 3 è 1 o 2 (il numero di tipi)
	--		e se 4 e 5 sono tipi
	if ((p[2] == '1' or p[2] == '2') and p[3] and
		(table.search(libdata.allTypes, string.lower(p[3])) or string.lower(p[3]) == 'coleottero')) then
		table.remove(p, 4)
		table.remove(p, 3)
		table.remove(p, 2)
	end

	return p
end

--[[

Crea un'entry nel caso in cui, oltre alle celle con i dati del
Pokémon, vi siano una o due celle per generazione. Argomenti:
	- p: i parametri passati dal wikicode.
	- makeText: la funzione che, a partire dai parametri, ricava
			il testo da inserire nella cella della generazione
	- splitCells: la funzione usata per dividere la cella delle
			generazioni in due
	- latestGenDefault (opzionale): valore default per la cella
			dell'ultima generazione. Se non specificato, viene
			usato, sempre come default, il valore della penultima
			generazione
	- collapse (opzionale): se il contenuto delle celle deve essere
			collassato o meno. Se non specificato, false

--]]
local entry = function(p, makeText, splitCells, latestGenDefault, collapse)
	--[[
		Dovendo usare table.filter, e quindi ipairs, è
		necessario che non vi siano nil prima dell'ultimo
		parametro, ragion per cui il terzo argomento  è
		esplicitamente settato a false
	--]]
	p = w.trimAndMap(p, string.fu, false)

	local gen = tonumber(table.remove(p, 1)) or gendata.latest+1
	local note, stab = p.note or '', p.STAB or ''
	local form = string.lower(p.form or '')
	p = removeOldParams(p)

	p.note, p.STAB, p.form = nil, nil, nil
	p[(1 + gendata.latest) - gen] = p[(1 + gendata.latest) - gen] or latestGenDefault or p[gendata.latest - gen]
	p[(2 + gendata.latest) - gen] = p[(2 + gendata.latest) - gen] or 'N/D'

	--[[
		Si applica makeText solo ai dati relativi all'
		apprendimento della mossa nelle generazioni,
		scartando quelli del Pokémon.
	--]]

	local data = table.map(table.filter(p, function(_, key)
			return type(key) == 'string' or key > 1 and key < (3 + gendata.latest) - gen
		end), makeText)

	return head(p[1] or '000', stab, note, form) .. tail(gen, data, splitCells, collapse)
end

--[[

Interfaccia per le entry livello: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.level = function(frame)
	return entry(mw.clone(frame.args), function(v) return v == 'No'
			and '×' or v end, splitTitle)
end

m.Level = m.level

--[[

Interfaccia per le entry macchina: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.tm = function(frame)
	return entry(mw.clone(frame.args), function(h)
			return boolDisplay[h] or h end, splitTitle, 'No')
end

m.Tm, m.TM = m.tm, m.tm

--[[

Interfaccia per le entry breed: si aspetta come
primo argomento la generazione, seguita dagli altri

--]]
m.breed = function(frame)
	return entry(mw.clone(frame.args), function(v) return v == 'No'
			and '×' or (v:match('%#') and lib.insertnwlns(v, 6, nil, true) or v)
		end, splitSup, nil, true)
end

m.Breed = m.breed

--[[

Interfaccia per le entry event: costruisce il wikicode
per interpolazione.

--]]
m.event = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu)
	p = removeOldParams(p)

	return string.interp([=[${h}
| style="padding: 0.5ex;" | ${event}${level}]=],
{
	h = head(p[1] or '000', p.STAB or '', p.notes or '', p.form or ''),
	event = p[2] or 'Per la fine del mondo',
	level = lib.makeLevel(p.level)
})
end

m.Event = m.event

--[[

Interfaccia per le entry tutor. Non usa la funzione
doit perché le celle non sono una per generazione

--]]
m.tutor = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.fu)
	p = removeOldParams(p)

	local store = {head(p[1] or '000', p.STAB or '', p.notes or '', p.form or '')}

	-- Si scorrono i parametri relativi ai giochi
	for k = 2, #p do
		if p[k] == 'Yes' then
			table.insert(store, makeCell(tutorCellsColors[k - 1], 'FFF', '1', '✔'))
		elseif p[k] == 'No' then
			table.insert(store, makeCell('FFF', '000', '1', '×'))
		end
	end
	return table.concat(store, '\n')
end

m.Tutor = m.tutor

return m
