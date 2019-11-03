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
local pokemoves = require('PokéMoves-data')
local tmdata = require("Machines-data")
local forms = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local evolib = require('Wikilib-evos')

-- local trimOnly = {'x v zA'}

-- Wikicode per la cella di un gioco nell'entry level
local gameLevelCell = '| '

-- Wikicode per la cella di un gioco nell'entry tutor
local gameTutorCell = [=[| style="background:#${bg};" | [[${gameLink}|<span style="padding: 0.3em 0; color:#${txtColor};">'''${gameAbbr}'''</span>]]]=]

-- Wikicode per gli entrynull
local entryNull = [[|-
! class="white-bg" style="padding: 0.1em 0.3em;" colspan="${cs}" | Questo Pokémon non impara nessuna mossa ${ending}.]]

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
    { "SL", "USUL" },
},
breed = { {}, { "OA", "C" }, { "RZ", "RFVF", "S" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" },
},
tutor = { {}, { "C" }, { "RFVF", "S", "XD" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" },
},
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
	return string.interp([=[|| class="black-text" style="padding: 0.1em 0.3em;" | ${stab}[[${mossa}]]${stab}${notes}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${tipo}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${cat}
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
			local gameData = sig[game[1]][1]
			local cell = {'| style="padding: 0.8ex 0.5ex;" |'}

			if game[2] == 'Yes' then
				if gameData.display[2] then
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[${gamesLink}|<span style="padding: 0.3em 0; color: #fff;">'''${game1sig}'''</span><span style="padding: 0.3em 0; color: #fff;">'''${game2sig}'''</span>]]</div>]=],
					{
						bg = css.horizGradLua{gameData.display[1][2], 'dark', gameData.display[2][2], 'dark'},
						gamesLink = gameData.link,
						game1sig = gameData.display[1][1],
						game2sig = gameData.display[2][1],
					}))
				else
					table.insert(cell, string.interp([=[
<div class="text-center roundy-5" style="${bg}; padding: 0 0.5ex; margin-bottom: 0.2ex;">[[${gamesLink}|<span style="padding: 0.3em 0; color: #fff;">'''${gamesig}'''</span>]]</div>]=],
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

-- La cella dell'entry null, utilizzata per i Pokémon che non imparano
-- mosse in un certo modo
lib.entrynull = function(entry, cs)
	return string.interp(entryNull, {
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
	elseif (movetype == pokedata.type1 or movetype == pokedata.type2) then
		return "'''"
	elseif table.search(evolib.evoTypesList(iname, gen), movetype)
	       or table.search(evolib.formTypesList(iname, gen), movetype) then
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

Given something, compute breed notes, ie. "breed chain", "the parent should
have learned the move in a previous gen" or "no parent can learn the move".
Arguments:
	- gen: the generation of this entry
	- move: the name of the move
	- parent: any parent listed in the data module
	- basenotes (optional): notes from the data module
	                        (ie. pokemoves[poke][kind][gen][move].notes)

--]]
lib.breednotes = function(gen, move, parent, basenotes)
	local notes = { basenotes }
	-- To compute notes it checks only one parent because they should all be
	-- the same for this. Otherwise the different one would be the only one
	-- (for instance: parents that need a chain aren't listed if there are
	-- some that doesn't)

	if parent and not lib.canLearn(move, parent, gen, {"breed"}) then
		if lib.learnKind(move, parent, gen, "breed") then
			-- Parent can learn by breed but not in any other way: chain
			table.insert(notes, 1, "catena di accoppiamenti")
		-- In theory this second check is useless because a parent wouldn't
		-- be listed if it doesn't learn the move, so if it doesn't in this
		-- gen it should in a past one
		-- elseif lib.learnPreviousGen(move, parent1, gen) then
		else
			table.insert(notes, 1, "il padre deve aver imparato la mossa in una generazione precedente")
		end
	elseif not parent then
		table.insert(notes, 1, "nessun genitore può apprendere la mossa")
	end

	return table.concat(notes, ", ")
end

-- ========================== Check learn functions ==========================
--[[

Given a move, an ndex, a gen and a kind check whether that Pokémon can learn
that move in that generation in that kind. Return a true value if it can, a
false otherwise.
Arguments:
	- move: name of the move
	- ndex: name or ndex of the Pokémon
	- gen: generation (a string)
	- kind: kind of learnlist ("level", "tm", ...)

--]]
lib.learnKind = function(move, ndex, gen, kind)
	local pmkind = pokemoves[ndex][kind]
	if not pmkind or not pmkind[gen] then
		return false
	end
	local mdata = pmkind[gen]
	if kind == "tm" then
		local mlist = mdata.all and tmdata[gen] or mdata
		-- Extra parentheses to force a single return value
		return (table.deepSearch(mlist, move))
	else
		return mdata[move]
	end
end

--[[

Given a move and an ndex check whether that Pokémon can learn the given move
in a given generation. Return a true value if it can, a false otherwise. It is
also possible to give an array of kind that aren't considered when determining
whether it can learn the move or not.
Arguments:
	- move: name of the move
	- ndex: name or ndex of the Pokémon
	- gen: generation
	- excludekinds: (optional) array of kinds to exclude

--]]
lib.canLearn = function(move, ndex, gen, excludekinds)
	excludekinds = excludekinds or {}
	return table.any(pokemoves[ndex], function(_, kind)
		if table.search(excludekinds, kind) then
			return false
		end
		return lib.learnKind(move, ndex, gen, kind)
	end)
end

--[[

Check whether a a Pokémon can learn a move in a generation previous than the
given one. If it can't returns false, otherwise the highest generation in which
it can  learn it.
Arguments:
	- move: name of the move
	- ndex: name or ndex of the Pokémon
	- gen: the gen considered: the function controls any generation strictly
	       lower than this.
	- firstgen: (optional) the lowest gen to check. Defaults to 1

--]]
lib.learnPreviousGen = function(move, ndex, gen, firstgen)
	for g = gen - 1, firstgen or 1, -1 do
		if table.any(pokemoves[ndex], function(_, kind)
			return lib.learnKind(move, ndex, g, kind)
		end) then
			return g
		end
	end
	return false
end

--[[

Computes the list of moves that a Pokémon can learn in any way, possibly
excluding breed.
Arguments:
	- ndex: name or ndex of the Pokémon
	- gen: generation to compute the list for
	- excludekinds: (optional) an array of kinds to esclude from the list. For
	                instance, if this argument is { "breed" } moves that the
					Pokémon can only learn by breed aren't included.
Return an array of move names.

--]]
lib.learnset = function(ndex, gen, excludekinds)
	local movedata = pokemoves[ndex]
	excludekinds = excludekinds or {}
	local res = {}
	if movedata.tm[gen] and not table.search(excludekinds, "tm") then
		res = table.copy(movedata.tm[gen])
		table.insert(excludekinds, "tm")
	end
	for kind, data in pairs(movedata) do
		if not table.search(excludekinds, kind) and data[gen] then
			res = table.merge(res, table.keys(data[gen]))
		end
	end
	return table.unique(res)
end

return lib
