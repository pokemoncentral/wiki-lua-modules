-- Libreria per i moduli learnlist e movelist

local lib = {}

local w = require('Wikilib')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local ms = require('MiniSprite')
local c = require('Colore-data')
local abbr = require('Sigle-data')
local s = require('Sup-data')

-- local trimOnly = {'x v zA'}

-- Wikicode per la cella di un gioco nell'entry level
local gameLevelCell = '| style="background:#FFF; border:1px solid #D8D8D8;"'
-- local str = '| style="background:#${bg}; color: #${txt}; border:1px solid #D8D8D8;" | ${lvl}'

-- Wikicode per la cella di un gioco nell'entry tutor
local gameTutorCell = [=[| style="background:#${bg}; border: 1px solid #${bd};" | [[Pokémon ${gameLink}|<span style="padding: 0.3em 0; color:#${txtColor};">'''${gameAbbr}'''</span>]]]=]

-- Contiene i title per le pre-evoluzioni
lib.preevott = {T = [[<span class="explain" title="Mossa appresa dall'Esperto Mosse">*</span>]], E = [[<span class="explain" title="Mossa appresa tramite evento">†</span>]], D = [[<span class="explain" title="Mossa appresa nel Dream World">‡</span>]]}

--[[

Processa i parametri passati al modulo, effettuando
trim e first_uppercase.

--]]
lib.sanitize = function(tab)
    return w.trimAndMap(tab, function(str)
		if str == 'x v zA' then
		-- if table.search(trimOnly, str) then
		    return str
		end
		return string.firstUppercase(str)
	end)
end

--[[

Crea le note: il primo parametro sono le note vere e
proprie, i seguenti eventuali altre stringhe da aggiungere.

Se le note sono una sigla, se ne fa il sup; se invece
sono la stringa vuota o un solo carattere, lo si lascia
invariato; negli altri casi le si usano come title.

--]]
lib.makeNotes = function(notes, ...)
	local pieces = {...}
	if s[notes] then
		table.insert(pieces, 1, s[notes])
	elseif notes:len() < 2 then
		table.insert(pieces, 1, notes)
	else
		table.insert(pieces, 1, '<span class="explain" title="')
		table.insert(pieces, 2, notes)
		table.insert(pieces, 3, '">*</span>')
	end
	return table.concat(pieces)
end

--[[

Ritorna un sup con il livello se l'argomento
è valudo, altrimenti la stringa vuota

--]]
lib.makeLevel = function(level)
	return level and table.concat{'<sup>Lv.', level, '</sup>'} or ''
end

--[[

Manda a capo ogni tot mini sprite, utilizzata
nell'entry per il breed, nella cella dei padri

--]]
lib.insertnwlns = function(str, linelength)
	str = str:gsub('<br>', '')
	linelength = tonumber(linelength) or 7

	local res, newLinesCount = {}, 0
	local pattern, op
	if str:match('File') then
		pattern = '%[%[File:.-MS%.png|.-|link=.-%]%]'
		op = function(sprite) return sprite end
	else
		pattern = '#(.-)#'
		op = function(ndex) return ms.staticLua(ndex) end
	end

	for minisprite in str:gmatch(pattern) do
		table.insert(res, op(minisprite))

		if (#res - newLinesCount) % linelength == 0 then
			table.insert(res, '<br>')
			newLinesCount = newLinesCount + 1
		end
	end

	return table.concat(res)
end

-- Interfaccia per mediaWiki della funzione di cui sopra
lib.newline = function(frame)
    return lib.insertnwlns(string.trim(frame.args[1]), frame.args[2])
end

-- Funzione che restituisce i cuori per le gare
lib.concathearts = function(n, black)
	local N = tonumber(n)
	if N == nil or N == 0 then
		return tostring(n)
	end
	return table.concat{n, ' <span style="color:#', black and '000' or 'FFAAAA',
		';">', string.rep('♥', N), '</span>'}
end

-- Interfaccia per mediaWiki della funzione di cui sopra
lib.hearts = function(frame)
	return lib.concathearts(string.trim(frame.args[1]),
			string.trim(frame.args[2] or ''):lower() == 'black')
end

--[[

Le celle comuni a tutti gli entry nelle generazioni
precedenti l'introduzione delle categorie danno.

--]]
lib.basicentry = function(stab, mossa, notes, tipo, pw, acc, pp)
    return string.interp([=[|| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${stab}[[${mossa} (mossa)|<span style="color:#000;">${mossa}</span>]]${stab}${notes}
| style="background:#${tipo_std}; border:1px solid #${tipo_dark};" | [[${tipo} (tipo)|<span style="color:#FFFFFF">${tipo}</span>]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${pw}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${acc}%
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${pp}]=],
{
   	mossa = mossa,
    stab = stab,
    notes = notes,
    tipo_std = c[tipo].normale,
    tipo_dark = c[tipo].dark,
    tipo = tipo,
    pw = pw,
    acc = acc,
    pp = pp
})
end

--[[

Le celle comuni a tutti gli entry nelle generazioni
successive l'introduzione delle categorie danno.

--]]
lib.categoryentry = function(stab, mossa, notes, tipo, cat, pw, acc, pp)
	return string.interp([=[|| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${stab}[[${mossa} (mossa)|<span style="color:#000;">${mossa}</span>]]${stab}${notes}
| style="background:#${tipo_std}; border:1px solid #${tipo_dark};" | [[${tipo} (tipo)|<span style="color:#FFFFFF">${tipo}</span>]]
| style="background:#${cat_std}; border:1px solid #${cat_dark};" | [[${cat} (categoria danno)|<span style="color:#${cat_text}">${cat}</span>]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${pw}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${acc}%
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${pp}]=],
{
	mossa = mossa,
    stab = stab,
    notes = notes,
    tipo_std = c[tipo].normale,
    tipo_dark = c[tipo].dark,
    tipo = tipo,
	cat_std = c[cat].normale,
    cat_dark = c[cat].dark,
    cat_text = c[cat .. '_text'],
    cat = cat,
	pw = pw,
    acc = acc,
    pp = pp
})
end

--[[

DA USARE CON UNO DEI PRECEDENTI ENTRY.

Ritorna soltanto le celle relative alle gare, vale
a dire virtù, fascino e, se passato, intralcio

--]]
lib.contestentry = function(gara, fash, intr)
	return string.interp([=[|| style="background:#${gara_std}; border:1px solid #${gara_dark};" | [[${gara} (gara)|<span style="color:#000">${gara}</span>]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${fash}${intr}]=],
{
    gara_std = c[gara].normale,
    gara_dark = c[gara].dark,
    gara = gara,
    fash = lib.concathearts(fash, false),
    intr = intr and table.concat{' || style="background:#FFF; border:1px solid #D8D8D8;" | ', lib.concathearts(intr, true)} or ''
})
end

--[[

Restituisce le prime celle dei level, in numero
pari ai livelli diversi inseriti.

--]]
lib.gameslevel = function(first, second, third)

	-- Only two of them
	if not third then
		if first == second then
			return table.concat{gameLevelCell, ' colspan = "2" | ',
					first}
		end
		return table.concat{gameLevelCell, ' | ', first, ' |',
				gameLevelCell, ' | ', second}
	end

	-- All three are the same
	if first == second and second == third then
		return table.concat{gameLevelCell, ' colspan = "3" | ',
				first}

	-- First and second are the same but third is different
	elseif first == second then
		return table.concat{gameLevelCell, ' colspan = "2" | ',
				first, ' |', gameLevelCell, ' | ', third}

	-- First and third are the same, but second is different
	elseif first == third then
		return table.concat{gameLevelCell, ' colspan = "2" | ',
				first, ' |', gameLevelCell, ' | ', second}

	-- Second and third are the same, but first is different
	elseif second == third then
		return table.concat{gameLevelCell, ' | ', first, ' |',
				gameLevelCell, ' colspan = "2" | ', second}

	-- All of them are different
	else
		return table.concat{gameLevelCell, ' | ', first, ' |',
				gameLevelCell, ' | ', second, ' |',
				gameLevelCell, ' | ', third}
	end
end

--[[

Restituisce l'inizio dell'entry delle mosse tutor, comprensivo
delle celle dei giochi: si aspetta una table di tables, che
contengono a loro volta, nell'ordine, sigla da visualizzare,
'Yes' o 'No' a seconda che la mossa possa essere insegnata
nel gioco o meno, e eventualmente la sigla del gioco quando
è diversa da quella da visualizzare. Es:
	tutorgames{{'N', 'No'}, {'B', 'No', 'Bi'},
			{'N2', 'Yes'}, {'B2', 'Yes'}}

Non si possono usare indici stringa per le sottotables per
questioni di ordinamento, mentre all'interno delle stesse
allungherebbe soltanto la chiamata

--]]
lib.tutorgames = function(games)
	local cells = table.map(games, function(game)
			--[[
				Uso del Modulo:Sigle/data per ricavare il
				colore del gioco dalla sigla
			--]]
			local gameData = abbr[game[3] or game[1]][1]
			local gameColor = c[gameData.display[1][2]]

			local values = {bd = gameColor.dark,
				gameLink = gameData.link, gameAbbr = game[1]}

			if game[2] == 'Yes' then
				values.bg = gameColor.normale
				values.txtColor = '000'
			else
				values.bg = c.background
				values.txtColor = gameColor.dark
			end

			return string.interp(gameTutorCell, values)
		end)

	-- Inizio dell'entry, bisogna inserire una nuova table row
	table.insert(cells, 1, '|-')
	return table.concat(cells, '\n')
end

-- Genera le prime celle per gli entry dei preevo
lib.preevodata = function(pars, gen)
	local ani1, tt1 = '', ''
	if pars[4] then
		ani1 = ms.aniLua(pars[4], gen or '', pars[5] or 'Bulbasaur')
		tt1 = lib.preevott[pars[6]] or ''
	end
	return string.interp([=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${ani}${tt}${ani1}${tt1}]=],
{
	ani = ms.aniLua(pars[1] or '000', gen or '', pars[2] or 'Bulbasaur'),
	tt = lib.preevott[pars[3]] or '',
	ani1 = ani1,
	tt1 = tt1
})
end

return lib
