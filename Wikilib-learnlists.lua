-- Libreria per i moduli learnlist e movelist

local lib = {}

local w = require('Wikilib')
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables')  -- luacheck: no unused
local ms = require('MiniSprite')
local box = require('Box')
local c = require("Colore-data")
local css = require('Css')
local abbr = require("Sigle-data")
local s = require("Sup-data")
local abbrLib = require('Wikilib-sigle')
local links = require('Links')

-- local trimOnly = {'x v zA'}

-- Wikicode per la cella di un gioco nell'entry level
local gameLevelCell = '| '

-- Wikicode per la cella di un gioco nell'entry tutor
local gameTutorCell = [=[| style="background:#${bg};" | [[Pokémon ${gameLink}|<span style="padding: 0.3em 0; color:#${txtColor};">'''${gameAbbr}'''</span>]]]=]

-- Wikicode per gli entrynull
local entryNull = [[|-
! style="background: #fff; padding: 0.1em 0.3em;" colspan="${cs}" | Questo Pokémon non impara nessuna mossa ${ending}.]]

local entryNullEnd = { level = 'aumentando di livello', tm = 'tramite MT',
	breed = 'tramite accoppiamento', tutor = "dall'Esperto Mosse", preevo = 'tramite evoluzioni precedenti'}

-- Contiene i title per le pre-evoluzioni
lib.preevott = {
	T = links.tt('*', "Mossa appresa dall'Esperto Mosse"),
	E = links.tt('†', "Mossa appresa tramite evento"),
	D = links.tt('‡', "Mossa appresa nel Dream World")
}

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
    local firstGame = notes:match('^(%S+)')

	if s[firstGame] then
		table.insert(pieces, 1, abbrLib.concatAbbrs(notes, s))
	elseif notes:len() < 2 then
		table.insert(pieces, 1, notes)
	else
		table.insert(pieces, 1, links.tt('*', notes))
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
lib.insertnwlns = function(str, linelength, gen, nobox)
	str = str:gsub('<br>', '')
	linelength = tonumber(linelength) or 7
	gen = gen or ''

	local res, newLinesCount = {}, 1
	local pattern, op
	if str:match('File') then
		pattern = '%[%[File:.-MS%.png|.-|link=.-%]%]'
		op = function(sprite) return sprite end
	else
		pattern = '#(.-)#'
		op = function(ndex) return ms.staticLua(ndex, gen) end
	end

	table.insert(res, '<div>')
	for minisprite in str:gmatch(pattern) do
		table.insert(res, op(minisprite))

		if (#res - newLinesCount) % linelength == 0 then
			table.insert(res, '</div><div>')
			newLinesCount = newLinesCount + 1
		end
	end
	if nobox then
		table.insert(res, '</div>')
	else
		table.insert(res, '</div></div>')

		if (#res > linelength + 2) then
			table.insert(res, 1, string.interp('<div class="roundy-5 mw-collapsible mw-collapsed" style="background: #${bg}; margin: 0.3em 0;">&nbsp;<div class="mw-collapsible-content">', { bg = c.background }))
			table.insert(res, '</div>')
		else
			table.insert(res, 1, string.interp('<div class="roundy-5" style="background: #${bg}; margin: 0.3em 0;">', { bg = c.background }))
		end
	end

	return table.concat(res)
end

-- Interfaccia per mediaWiki della funzione di cui sopra
lib.newline = function(frame)
    return lib.insertnwlns(string.trim(frame.args[1]), frame.args[2])
end

--[=[

Creates a modal containing a list of MS from the list of ndex or MS passed.

The first parameter is a string in one of the following formats:
* a list of MS links in Wikicode syntax ([[File:.-MS.png|.-|link=.-]])
* a list of ndexes, each surrounded by a pair of #
The second parameter is the gen for the ms (unused if list is in the first
format, default to the latest), the third is the text displayed inside the
element that binds the modal (default to '✔'), the fourth is the max number of
ms in a single line (default nil, that means no line breaks).

--]=]
lib.mslistToModal = function(list, gen, textDisplay, linelength)
	list = list:gsub('<br>', '')
	gen = gen or ''
	textDisplay = textDisplay or '✔'

	local res = {}
	local pattern, op
	if list:match('File') then
		pattern = '%[%[File:.-MS%.png|.-|link=.-%]%]'
		op = function(sprite) return sprite end
	else
		pattern = '#(.-)#'
		op = function(ndex) return ms.staticLua(ndex, gen) end
	end

	table.insert(res, '<span class="open-popup-element explain">')
	table.insert(res, textDisplay)
	table.insert(res, '<div class="mfp-hide pull-center max-width-xl-80 roundy" style="display: table; padding: 0.5em; background: #fff;">')

	table.insert(res, '<div>')
	local mscount = 0
	for minisprite in list:gmatch(pattern) do
		table.insert(res, op(minisprite))
		mscount = mscount + 1
		if linelength and mscount % linelength == 0 then
			table.insert(res, '</div><div>')
		end
	end
	table.insert(res, '</div>')

	table.insert(res, '</div></span>')

	return table.concat(res)
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
    return string.interp([=[|| style="padding: 0.3em;" | ${stab}[[${mossa}|<span style="color:#000;">${mossa}</span>]]${stab}${notes}
| style="padding: 0.8ex 0.3ex; height: 100%;" | ${tipo}
| style="padding: 0.1em 0.3em;" | ${pw}
| style="padding: 0.1em 0.3em;" | ${acc}%
| style="padding: 0.1em 0.3em;" | ${pp}]=],
{
    mossa = mossa,
    stab = stab,
    notes = notes,
    tipo = box.boxTipoLua(tipo, {'thick'}),
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
	return string.interp([=[|| style="padding: 0.1em 0.3em;" | ${stab}[[${mossa}|<span style="color:#000;">${mossa}</span>]]${stab}${notes}
| style="padding: 0.8ex 0.3ex; height: 100%;" | ${tipo}
| style="padding: 0.8ex 0.3ex; height: 100%;" | ${cat}
| style="padding: 0.1em 0.3em;" | ${pw}
| style="padding: 0.1em 0.3em;" | ${acc}%
| style="padding: 0.1em 0.3em;" | ${pp}]=],
{
	mossa = mossa,
    stab = stab,
    notes = notes,
    tipo = box.boxTipoLua(tipo, {'thick'}),
    cat = box.boxLua(cat, 'Categoria danno#' .. cat, cat, {'thick'},
            nil, nil, c[cat .. '_text']),
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
	return string.interp([=[|| style="padding: 0.8ex 0.3ex; height: 100%;" | ${gara}
| style="padding: 0.1em 0.3em;" | ${fash}${intr}]=],
{
    gara = box.boxLua(gara, gara .. ' (gara)', gara, {'thick'}),
    fash = lib.concathearts(fash, false),
    intr = intr and table.concat{' || style="padding: 0.3em;" | ', lib.concathearts(intr, true)} or ''
})
end

--[[

Restituisce le prime celle dei level, in numero
pari ai livelli diversi inseriti.

--]]
lib.gameslevel = function(first, second, third)

	if not third then
		--Only one of them
		if not second then
			return table.concat{gameLevelCell, ' | ',
					first}
		elseif first == second then -- Only two of them
			return table.concat{gameLevelCell, ' colspan = "2" | ',
				first}
		else
			return table.concat{gameLevelCell, ' | ', first, ' |',
				gameLevelCell, ' | ', second}
		end
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
contengono a loro volta, nell'ordine, sigla del gioco e
'Yes' o 'No' a seconda che la mossa possa essere insegnata
nel gioco o meno. La sigla visualizzata e i colori vengono presi
da Sigle/data Es:
	tutorgames{{'NB', 'No'}, {'N2B2', 'Yes'}}

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
			local gameData = abbr[game[1]][1]
			local cell = {'| style="padding: 0.8ex 0.5ex;" |'}

			if game[2] == 'Yes' then
				if gameData.display[2] then
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[Pokémon ${gamesLink}|<span style="padding: 0.3em 0; color: #fff;">'''${game1sig}'''</span><span style="padding: 0.3em 0; color: #fff;">'''${game2sig}'''</span>]]</div>]=],
					{
						bg = css.horizGradLua{gameData.display[1][2], 'dark', gameData.display[2][2], 'dark'},
						gamesLink = gameData.link,
						game1sig = gameData.display[1][1],
						game2sig = gameData.display[2][1],
					}))
				else
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[Pokémon ${gamesLink}|<span style="padding: 0.3em 0; color: #fff;">'''${gamesig}'''</span>]]</div>]=],
					{
						bg = css.horizGradLua{gameData.display[1][2], 'dark', gameData.display[1][2], 'normale'},
						gamesLink = gameData.link,
						gamesig = gameData.display[1][1],
					}))
				end
			else
				if gameData.display[2] then
					table.insert(cell, string.interp([=[
[[Pokémon ${gamesLink}|<span style="padding: 0.3em 0; color: #${game1color};">'''${game1sig}'''</span><span style="padding: 0.3em 0; color: #${game2color};">'''${game2sig}'''</span>]]]=],
					{
						gamesLink = gameData.link,
						game1sig = gameData.display[1][1],
						game2sig = gameData.display[2][1],
						game1color = c[gameData.display[1][2]].dark,
						game2color = c[gameData.display[2][2]].dark,
					}))
				else
					table.insert(cell, string.interp([=[
[[Pokémon ${gamesLink}|<span style="padding: 0.3em 0; color: #${gamecolor};">'''${gamesig}'''</span>]]]=],
					{
						gamesLink = gameData.link,
						gamesig = gameData.display[1][1],
						gamecolor = c[gameData.display[1][2]].dark,
					}))
				end
			end

			return table.concat(cell)
		end)

	-- Inizio dell'entry, bisogna inserire una nuova table row
	table.insert(cells, 1, '|-')
	return table.concat(cells, '\n')
end

-- Genera le prime celle per gli entry dei preevo
lib.preevodata = function(pars, gen)
	local ani1, tt1 = '', ''
	if pars[4] then
		ani1 = ms.staticLua(pars[4], gen or '', pars[5] or 'Bulbasaur')
		tt1 = lib.preevott[pars[6]] or ''
	end
	return string.interp([=[|-
| style="padding: 0.1em 0.3em;" | ${ani}${tt}${ani1}${tt1}]=],
{
	ani = ms.staticLua(pars[1] or '000', gen or '', pars[2] or 'Bulbasaur'),
	tt = lib.preevott[pars[3]] or '',
	ani1 = ani1,
	tt1 = tt1
})
end

-- La cella dell'entry null, utilizzata per i Pokémon che non imparano
-- mosse in un certo modo
lib.entrynull = function(entry, cs)
	return string.interp(entryNull, {
		ending = entryNullEnd[entry],
		cs = cs
	})
end

return lib
