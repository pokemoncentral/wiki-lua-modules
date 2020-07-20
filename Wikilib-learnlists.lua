-- Libreria per i moduli learnlist e movelist

local lib = {}

local w = require('Wikilib')
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables')  -- luacheck: no unused
local ms = require('MiniSprite')
local box = require('Box')
local c = require("Colore-data")
local css = require('Css')
local sig = require("Sigle-data")
local s = require("Sup-data")
local abbrLib = require('Wikilib-sigle')
local links = require('Links')
local pokes = require("Poké-data")
local moves = require("Move-data")
-- local tmdata = require("Machines-data")
local forms = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local evolib = require('Wikilib-evos')
local wdata = require("Wikilib-data")


local strings = {
	-- Wikicode per la cella di un gioco nell'entry level
	GAMELEVELCELL = '| ',
	-- Wikicode per la cella di un gioco nell'entry tutor
	-- GAMETUTORCELL = [=[
-- | style="background:#${bg};" | [[${gameLink}|<span style="padding: 0.3em 0; color:#${txtColor};">'''${gameAbbr}'''</span>]]]=]
	-- Wikicode per gli entrynull
	ENTRYNULL = [[|-
! class="white-bg" style="padding: 0.1em 0.3em;" colspan="${cs}" | Questo Pokémon non impara nessuna mossa ${ending}.]],

}

-- local trimOnly = {'x v zA'}

local entryNullEnd = { level = 'aumentando di livello', tm = 'tramite MT',
	breed = 'tramite accoppiamento', tutor = "dall'Insegnamosse",
	preevo = 'tramite evoluzioni precedenti', event = 'tramite evento' }

-- Contiene i title per le pre-evoluzioni
lib.preevott = {
	T = links.tt('*', "Mossa appresa dall'Esperto Mosse"),
	E = links.tt('†', "Mossa appresa tramite evento"),
	D = links.tt('‡', "Mossa appresa nel Dream World")
}

-- Games for various kinds of learn, divided by gen
lib.games = {
level = { { "RB", "G" }, { "OA", "C" }, { "RZ", "RFVF", "S" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" }, { "SpSc" },
},
breed = { {}, { "OA", "C" }, { "RZ", "RFVF", "S" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" }, { "SpSc" },
},
tutor = { {}, { "C" }, { "RFVF", "S", "XD" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" }, { "SpSc", "IA" },
},
}


--[[

Normalize the type "coleot" to "coleottero",
the only form that (in my dreams) should be
used within modules but for printing

I do know this REALLY seems a function I should
put in a shared library (Wikilib-something), but
it's here because my hope is for it to be a
temporary workaround until I normalize data
modules with "coleottero", confining "coleot"
to outputs and banishing it forever from internal
representations.
Heed my words, future mantainer of this code (that
is, whp, just myself), for I hereby task you with
such a burden.
-- Flavio, 02/05/20

Pls sign yourself here with the date whenever you
use this function, so we can witness the failure
of my proposal.

Used again (I hoped it would take longer) -- Flavio, 07/05/2020

--]]
local normalizeColeot = function(type)
	return type == "coleot" and "coleottero" or type
end

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

--[[

Given a string encloses it within a modal. textDisplay is the text displayed
inside the element that binds the modal (defaults to '✔')

--]]
lib.toModal = function(str, textDisplay)
	return table.concat({
		'<span class="open-popup-element explain">',
		textDisplay or '✔',
		'<div class="mfp-hide pull-center max-width-xl-80 roundy white-bg" style="display: table; padding: 0.5em;">',
		str,
		'</div></span>',
	})
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

	local res = {}
	local pattern, op
	if list:match('File') then
		pattern = '%[%[File:.-MS%.png|.-|link=.-%]%]'
		op = function(sprite) return sprite end
	else
		pattern = '#(.-)#'
		op = function(ndex) return ms.staticLua(ndex, gen) end
	end

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

	return lib.toModal(table.concat(res), textDisplay)
end

--[=[

Creates a modal containing a list of MS from an array of ndexes.

The second parameter is the gen for the ms (default to the latest), the third
is the text displayed inside the element that binds the modal (default to '✔'),
the fourth is the max number of ms in a single line (default nil, that means no
line breaks).

--]=]
lib.msarrayToModal = function(array, gen, textDisplay, linelength)
	gen = gen or ''

	local res = {}

	table.insert(res, '<div>')
	local mscount = 0
	for _, ndex in ipairs(array) do
		table.insert(res, ms.staticLua(type(ndex) == "number"
		                               and string.tf(ndex) or ndex, gen))
		mscount = mscount + 1
		if linelength and mscount % linelength == 0 then
			table.insert(res, '</div><div>')
		end
	end
	table.insert(res, '</div>')

	return lib.toModal(table.concat(res), textDisplay)
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

-- ========================= Entry building functions =========================
--[[

Le celle comuni a tutti gli entry nelle generazioni
precedenti l'introduzione delle categorie danno.

--]]
lib.basicentry = function(stab, mossa, notes, tipo, pw, acc, pp)
    local tipobox
    if table.search(wdata.allTypes, tipo:lower()) then
        tipobox = box.boxTipoLua{type = tipo, confs = {'thick'}}
    else
        tipobox = box.boxLua{text = tipo, confs = {'thick'}, classes = {'box-sconosciuto'}}
    end
    return string.interp([=[|| style="padding: 0.3em;" class="black-text" | ${stab}${mossa}${stab}${notes}
| style="padding: 0.8ex 0.3ex; height: 100%;" | ${tipo}
| style="padding: 0.1em 0.3em;" | ${pw}
| style="padding: 0.1em 0.3em;" | ${acc}%
| style="padding: 0.1em 0.3em;" | ${pp}]=],
{
    mossa = mossa == "&nbsp;" and mossa or table.concat{"[[", mossa, "]]"},
    stab = stab,
    notes = notes,
    tipo = tipobox,
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
    local tipobox
    -- This thing is ineficient af, but anyway
    if table.search(table.map(wdata.allTypes, normalizeColeot), tipo:lower()) then
        tipobox = box.boxTipoLua{type = tipo, confs = {'thick'}}
    else
        tipobox = box.boxLua{text = tipo, confs = {'thick'}, classes = {'box-sconosciuto'}}
    end
    return string.interp([=[|| class="black-text" style="padding: 0.1em 0.3em;" | ${stab}${mossa}${stab}${notes}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${tipo}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${cat}
| style="padding: 0.1em 0.3em;" | ${pw}
| style="padding: 0.1em 0.3em;" | ${acc}%
| style="padding: 0.1em 0.3em;" | ${pp}]=],
{
	mossa = mossa == "&nbsp;" and mossa or table.concat{"[[", mossa, "]]"},
    stab = stab,
    notes = notes,
    tipo = tipobox,
    cat = box.boxLua{text = cat, link = 'Categoria danno#' .. cat,
        confs = {'thick'}, classes = {'box-' .. cat:lower()}},
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
    gara = box.boxLua{text = gara, link = gara .. ' (gara)', color = gara,
        confs = {'thick'}},
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
			return table.concat{strings.GAMELEVELCELL, ' | ',
					first}
		elseif first == second then -- Only two of them
			return table.concat{strings.GAMELEVELCELL, ' colspan = "2" | ',
				first}
		else
			return table.concat{strings.GAMELEVELCELL, ' | ', first, ' |',
				strings.GAMELEVELCELL, ' | ', second}
		end
	end

	-- All three are the same
	if first == second and second == third then
		return table.concat{strings.GAMELEVELCELL, ' colspan = "3" | ',
				first}

	-- First and second are the same but third is different
	elseif first == second then
		return table.concat{strings.GAMELEVELCELL, ' colspan = "2" | ',
				first, ' |', strings.GAMELEVELCELL, ' | ', third}

	-- First and third are the same, but second is different
	elseif first == third then
		return table.concat{strings.GAMELEVELCELL, ' colspan = "2" | ',
				first, ' |', strings.GAMELEVELCELL, ' | ', second}

	-- Second and third are the same, but first is different
	elseif second == third then
		return table.concat{strings.GAMELEVELCELL, ' | ', first, ' |',
				strings.GAMELEVELCELL, ' colspan = "2" | ', second}

	-- All of them are different
	else
		return table.concat{strings.GAMELEVELCELL, ' | ', first, ' |',
				strings.GAMELEVELCELL, ' | ', second, ' |',
				strings.GAMELEVELCELL, ' | ', third}
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
			local gameData = sig[game[1]][1]
			local cell = {'| style="padding: 0.8ex 0.5ex;" |'}

			if game[2] == 'Yes' then
				if gameData.display[2] then
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5 white-text" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[${gamesLink}|<span style="padding: 0.3em 0;">'''${game1sig}'''</span><span style="padding: 0.3em 0;">'''${game2sig}'''</span>]]</div>]=],
					{
						bg = css.horizGradLua{gameData.display[1][2], 'dark', gameData.display[2][2], 'dark'},
						gamesLink = gameData.link,
						game1sig = gameData.display[1][1],
						game2sig = gameData.display[2][1],
					}))
				else
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5 white-text" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[${gamesLink}|<span style="padding: 0.3em 0;">'''${gamesig}'''</span>]]</div>]=],
					{
						bg = css.horizGradLua{gameData.display[1][2], 'dark', gameData.display[1][2], 'normale'},
						gamesLink = gameData.link,
						gamesig = gameData.display[1][1],
					}))
				end
			else
				if gameData.display[2] then
					table.insert(cell, string.interp([=[
[[${gamesLink}|<span style="padding: 0.3em 0; color: #${game1color};">'''${game1sig}'''</span><span style="padding: 0.3em 0; color: #${game2color};">'''${game2sig}'''</span>]]]=],
					{
						gamesLink = gameData.link,
						game1sig = gameData.display[1][1],
						game2sig = gameData.display[2][1],
						game1color = c[gameData.display[1][2]].dark,
						game2color = c[gameData.display[2][2]].dark,
					}))
				else
					table.insert(cell, string.interp([=[
[[${gamesLink}|<span style="padding: 0.3em 0; color: #${gamecolor};">'''${gamesig}'''</span>]]]=],
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

--[[

Build the first cell of a preevo entry, autocomputing the name of the
poke from the ndex.
Right now is an interface to the previous function, ideally someone will
TODO refactor this

Arguments:
    - pars: a table that, from a certain index onward, contains an alternating
             sequence of ndex and notes, representing each an ndex of a preevo
             and the relative notes (optional)
    - idx: the index at which the required sequence of values starts in pars
    - gen: the generation of the entry

--]]
lib.autopreevo = function(pars, idx, gen)
    local fakep = { }
    local i = 1
	local j = idx
	-- I don't like an indexed iteration, but it seems for the best here
	-- Can't use #pars because there are nils if some parameter is not given
	while pars[j] do
		fakep[i] = pars[j]
		fakep[i + 2] = pars[j + 1]

		fakep[i + 1] = (pokes[fakep[i]] or pokes[tonumber(fakep[i])]).name
		i = i + 3
		j = j + 2
	end
    return lib.preevodata(fakep, tostring(gen))
end


-- La cella dell'entry null, utilizzata per i Pokémon che non imparano
-- mosse in un certo modo
lib.entrynull = function(entry, cs)
	return string.interp(strings.ENTRYNULL, {
		ending = entryNullEnd[entry],
		cs = cs
	})
end

--[[

Computes the STAB value given the ndex and move name. If ndex or movename
doesn't matches an entry of the respective module, an empty string is returned.
Arguments:
	- ndex: either the ndex or the Pokémon's name, all but the abbr lowercase
	- movename: name of the move to compute the STAB against
	- form (optional): abbr or extended form name
	- gen (optional): the generation in which compute the STAB. Defaults to the
					  latest

--]]
lib.computeSTAB = function(ndex, movename, form, gen)
	local name, abbr = forms.getnameabbr(tostring(ndex), form)
	local iname = forms.toEmptyAbbr(abbr) == "" and name
				or (type(name) == 'number' and string.tf(name) or name)
				   .. forms.toEmptyAbbr(abbr)
	-- The or pokes[name] is needed for useless forms, not indexed in Poké-data
	local pokedata = multigen.getGen(pokes[iname] or pokes[name], gen)
	local movedata = moves[movename:lower()]
	local movetype = multigen.getGenValue(movedata.type, gen)
	if not pokedata or not movedata
	   or (multigen.getGenValue(movedata.power, gen) == '&mdash;'
	       and not multigen.getGenValue(movedata.stab, gen)) then
		return ""
	elseif (movetype == normalizeColeot(pokedata.type1)
	        or movetype == normalizeColeot(pokedata.type2)) then
		return "'''"
	elseif table.search(table.map(evolib.evoTypesList(iname, gen), normalizeColeot), movetype)
	       or table.search(table.map(evolib.formTypesList(iname, gen), normalizeColeot), movetype) then
		return "''"
	else
		return ""
	end
end

--[[

Given the table for a learnlist breed of a Pokémon in a gen and a game, return
the list of parents for that game.
Arguments:
	- movedata: table associated with the move in PokéMoves[poke].breed
	- game: the abbr of the game

--]]
lib.moveParentsGame = function(movedata, game)
	for _, v in ipairs(movedata) do
		if v.games and table.search(v.games, game) then
			return v
		end
	end
	return movedata[1]
end

--[[

Make the text to signal that a move is
learned upon evolution (ie: "Evoluzione"
on desktop, "Evo" on mobile)

--]]
lib.makeEvoText = function(t)
	return (t == "Evo" or t == "Evoluzione")
			and 'Evo<span class="hidden-xs">luzione</span>'
			or t
end

return lib
