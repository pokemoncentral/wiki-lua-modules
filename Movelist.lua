--[[

Right now this module is just a convenient library for movelist-entry, used to
automatically build an entry with few parameters.

WikiCode interfaces are documented at the end of this file.

===============================================================================
TODO: all this part is a LIE (like the cake)
Creates the list of Pokémon that learns a certain move.

The module has a function for kind (level, tm, ...). All these functions have 2
mandatory parameters: the move name (BASEPAGENAME is fine) and the generation
of introduction of the move. This second is of course a lack of data modules
but hey, that's what we have.

Examples:
{{#invoke: Movelist | level | {{BASEPAGENAME}} | 5 }}
{{#invoke: Movelist | tm | abbattimento | 5 }}
{{#invoke: Movelist | event | oscurotuffo | 4 }}
===============================================================================

--]]

local ml = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local lib = require('Wikilib-learnlists')
local genlib = require('Wikilib-gens')
local multigen = require('Wikilib-multigen')
local forms = require('Wikilib-forms')
local wlib = require('Wikilib')
local css = require('Css')
local links = require('Links')
local ms = require('MiniSprite')
local resp = require('Resp')
local blackabbr = require("Blackabbrev-data")
local c = require("Colore-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local groups = require("PokéEggGroup-data")
local altforms = require("AltForms-data")
local useless = require("UselessForms-data")
-- local pokemoves = require("PokéMoves-data")
local movepokes = require("MovePokés-data")
local gendata = require("Gens-data")
local mtdata = require("Machines-data")

-- ============================= Library functions ============================
--     ======================== From Movelist-entry =======================
ml.strings = {
	CELLBOX = [[
| class="black-text height-100" style="padding: 0.8ex 0.3ex;${cs}" | <div class="text-center height-100 roundy-5 vert-middle" style="${bg}; padding: 0 0.3ex;">${cnt}</div>]],
	CELLHEAD = [=[
|- class="height-100"
| class="hidden-xs" | ${num}
| ${ani}
| <span class="hidden-xs">${stab}[[${name}]]${stab}${notes}${forml}</span>
| class="hidden-sm height-100" style="padding: 0.8ex 0.3ex;" | ${types}
| class="hidden-sm height-100" style="padding: 0.8ex 0.3ex;" | ${groups}
]=],
	BOOLNO = '×',
	BOOLYES = '✔',

	HEADERBASE = [=[
{| class="roundy text-center white-rows roundy-footer" style="${bg}; border-spacing: 0; padding: 0.3ex;"
! class="roundytl hidden-xs" rowspan="${rs}" | #
! rowspan="${rs}" colspan="2" | Pokémon
! class="hidden-sm" rowspan="${rs}" | Tipo
! class="hidden-sm" style="padding: 0 0.7ex;" rowspan="${rs}" | Gruppo uova
! class="roundytr" colspan="${cs}" | ]=],
	HEADERTM = [=[
! class="roundytop" style="background: #${bg}; min-width: 4ex; line-height: 1em;" colspan="${cs}" | [[${genl} generazione|${genr}]]<div class="text-small">${tm}</div>
]=],
	HEADERTUTOR = [=[
! class="roundytop" style="background: #${bg}; min-width: 6ex;" | ${abbr}
]=],

	notes = {
		STAB = 'Ottiene il bonus di tipo ',

		SINCE = 'a partire dal${art}${gen} generazione',
		UNTIL = 'prima del${art}${gen} generazione',
		INGAME = 'in ${gen}',
	},
}

-- Table of level games for generation
ml.levelgames = {
	{ -- 1
		{bg = 'rosso', abbr = 'RVB'},
		{bg = 'giallo', abbr = 'G'},
	},
	{ -- 2
		{bg = 'oro', abbr = 'OA'},
		{bg = 'cristallo', abbr = 'C'},
	},
	{ -- 3
		{bg = 'rubino', abbr = 'RZ'},
		{bg = 'rossofuoco', abbr = 'RFVF'},
		{bg = 'smeraldo', abbr = 'S'},
	},
	{ -- 4
		{bg = 'diamante', abbr = 'DP'},
		{bg = 'platino', abbr = 'Pt'},
		{bg = 'heartgold', abbr = 'HGSS'},
	},
	{ -- 5
		{bg = 'bianco', abbr = 'NB'},
		{bg = 'bianco2', abbr = 'N2B2'},
	},
	{ -- 6
		{bg = 'x', abbr = 'XY'},
		{bg = 'rubinoomega', abbr = 'ROZA'},
	},
	{ -- 7
		{bg = 'sole', abbr = 'SL'},
		{bg = 'ultrasole', abbr = 'USUL'},
		{bg = 'lgp', abbr = 'LGPE'},
	},
	{ -- 8
		{bg = 'spada', abbr = 'SpSc'},
	},
}
-- Table of tutor games
ml.tutorgames = {
	ml.levelgames[2][2], -- C
	ml.levelgames[3][2], -- RFVF
	ml.levelgames[3][3], -- S
	{ bg = "xd", abbr = "XD" },
	ml.levelgames[4][1], -- DP
	ml.levelgames[4][2], -- Pt
	ml.levelgames[4][3], -- HGSS
	{ bg = "nero", abbr = "NB" },
	{ bg = "nero2", abbr = "N2B2" },
	ml.levelgames[6][1], -- XY
	ml.levelgames[6][2], -- ROZA
	ml.levelgames[7][1], -- SL
	ml.levelgames[7][2], -- USUL
	ml.levelgames[8][1], -- SpSc
}

--[[

Prints a (real) cell for a single value.
Arguments:
	- text: text content
	- bgcolor: name of bg color (from modulo colore)
	- bold: whether the content should be bold or not
	- colspan: the number of colspan (default 1)
	- tt: tt text (optional)
	- abbr: games abbr to add after text (optional)
--]]
ml.makeBox = function(text, bgcolor, bold, colspan, tt, abbr)
	local bg = bgcolor:lower() == "fff"
				and ""
				or css.horizGradLua{ type = bgcolor }
	text = bold and table.concat{"'''", text, "'''"} or text
	local cnt = tt and tt ~= "" and links.tt(text, tt) or text
	return string.interp(
		ml.strings.CELLBOX,
		{
			bg = bg,
			cs = colspan and colspan ~= 1
			     and ('" colspan="' .. colspan) or "",
			cnt = abbr and table.concat{"<span>", cnt, blackabbr[abbr] or "",
			                            "</span>"} or cnt,
		}
	)
end

--     ========================== From Movelist-hf =========================
ml.headers = function(tipo, kind, cs)
	return string.interp(ml.strings.HEADERBASE, {
		bg = css.horizGradLua{type = tipo},
	    rs = kind == 'event' and 1 or 2,
	    cs = cs,
	})
end

--     ================ First main cancer: tm/tutor header ================
--         ========================== Tm =============================
ml.tmhlua = function(move)
	local tipo = multigen.getGenValue(moves[move].type)
	local startgen = moves[move].gen or 1
	local gamesdata = ml.gencelldict.tm.games
	local totcs = table.fold(gamesdata, 0, function(acc, gengames)
		return acc + #gengames
	end, ipairs)
	local res = {
		ml.headers(tipo, 'tm', totcs),
		'Macchine\n|- class="white-text"\n',
	}
	local link
	for g = startgen, gendata.latest do
		local tmkind, tmnum = table.deepSearch(mtdata[g], move)
		link = tmkind
		     and table.concat{'[[', tmkind, string.nFigures(tmnum, 2), ']]'}
			 or 'Ness.'
		table.insert(res, string.interp(ml.strings.HEADERTM, {
			bg = c[gendata[g].region].normale,
			genl = gendata[g].ext,
			genr = gendata[g].roman,
			tm = link,
			cs = #gamesdata[g],
		}))
	end
	return table.concat(res)
end

-- WikiCode interface for tmhlua: the only (optional) argument is the move
-- name, defaults to {{BASEPAGENAME}}
ml.tmh = function(frame)
	local move = frame.args[1] and string.trim(frame.args[1])
	                           or mw.title.getCurrentTitle().text
	move = move:lower()
	return ml.tmhlua(move)
end

ml.TMh, ml.Tmh = ml.tmh, ml.tmh

--         ========================= Tutor ===========================
-- Given a move creates the tutor header for that move
ml.tutorhlua = function(move)
	local tipo = multigen.getGenValue(moves[move].type)
	local tutorgames = movepokes.movetutorindexes[move] or {}
	return table.concat{
		ml.headers(tipo, 'tutor', #tutorgames),
		'Gioco\n|- class="white-text"\n',
		wlib.mapAndConcat(tutorgames, function(idx)
			local data = ml.tutorgames[idx]
			return string.interp(ml.strings.HEADERTUTOR, {
				bg = c[data.bg].normale,
				abbr = data.abbr,
			})
		end),
	}
end

-- WikiCode interface for tutorhlua: the only (optional) argument is the move
-- name, defaults to {{BASEPAGENAME}}
ml.tutorh = function(frame)
	local move = frame.args[1] and string.trim(frame.args[1])
	                           or mw.title.getCurrentTitle().text
	move = move:lower()
	return ml.tutorhlua(move)
end

ml.Tutorh = ml.tutorh

--     ======== Second main cancer: datas given move, ndex and kind =======
-- Given a (physical) cell returns it columnspan
ml.getcs = function(cell)
	return cell.cs or (cell.abbr and #cell.abbr) or 1
end

--[[

Given the array of (logical) cells it prints it to a string.

A logical cell correspond to all the (real or physical) cells of a generation.
A logical cell is an array of physical cells, that are tables with some named
values:
    - str: the string to print
    - bg:  background color (from modulo colore)
    - abbr (optional): array of game abbreviations that are added to the cell,
                       the way depending on kind
    - cs (optional): the colspan for the cell. If not given, defaults to the
                     length of abbr and to 1 if that isn't given too

Args:
	- cells: the array of logical cells
	- kind: the kind of movelist

--]]
ml.printtail = function(cells, kind)
	local ttabbr = kind ~= "breed"
	local bold = kind ~= "event"
	return wlib.mapAndConcat(cells, "\n", function(logiccell)
		-- logiccell = { <physcell>, ... }
		return wlib.mapAndConcat(logiccell, "\n", function(physcell)
			-- physcell = { str = <>, bg = <>, abbr = { <>, <>, ... },
			--              [cs = #] }
			local abbrs = table.concat(physcell.abbr or {})
			local cs = ml.getcs(physcell)
			return ml.makeBox(physcell.str, physcell.bg,
			                  bold, cs,
							  ttabbr and abbrs, not ttabbr and abbrs)
		end)
	end)
end

--[[

Dict of functions to specify details of general gencell function. Tutor and
event aren't included because their strcture is fundamentally different than
the other three.
There are three keys:
	- getbasedata(g, ndex, move, args) creates the table basedata, that is a
	                                   merge of datas from data module and
								       arguments
		* g: generation of the entry (a number)
		* ndex: name or ndex of the Pokémon
		* move: move name
		* args: any additional argument, that may depend on kind:
			- "level" checks keys corresponding to games that aren't in the
			          data module. Right now only LGPE
		    - "tm" checks keys corresponding to games that aren't in the data
					  module. Right now only LGPE
	- makegencell(basedata, g) maps base data to a logical cell (array of
	                           physical cells)
		* basedata: base data, as produced by mergedata
		* g: generation of the entry (a number)
	- games: specs of games for each generation for this kind of entry. Each
	         element correspond to a generation, and is an array of dicts.
			 Elements of the array correspond to a group of games that are
			 always together in entries of that kind, and contains informations
			 about abbr and background color.

--]]
ml.gencelldict = {
	level = {
		getbasedata = function(g, ndex, move, args)
			-- local basedata = lib.pokemoves[ndex].level[g][move]
			local basedata = lib.getLevelEntry(move, ndex, g)
			-- basedata = basedata and table.copy(basedata)
			if g == 7 and args.LGPE then
				basedata = basedata or { {}, {} }
				table.insert(basedata, { args.LGPE })
			end
			return basedata
		end,
		makegencell = function(basedata, g)
			local gencell = table.map(basedata, function(t, idx)
				local noempty = #t > 0
				return {
					str = noempty and string.fu(table.concat(t, ", "))
					              or ml.strings.BOOLNO,
					bg = noempty and ml.levelgames[g][idx].bg or "fff",
					abbr = { ml.levelgames[g][idx].abbr },
				}
			end)
			return gencell
		end,
		games = ml.levelgames,
	},
	tm = {
		-- TODO: refactor to be less handcrafted
		getbasedata = function(g, ndex, move, args)
			if not table.search(lib.pokemoves[ndex].tm[g], move)
			   and not (g == 7 and args.LGPE) then
				return false
			end
			local basedata = table.map(ml.gencelldict.tm.games[g], function(game)
				if game.abbr == "" then
					return true
				end
				-- There are more games in this gen
				local idx1, idx2, idx3 = table.deepSearch(mtdata[g], move)
				if not idx1 then
					return false
				end
				if not idx3 then
					-- No idx3 => the move is a TM in every game of gen g
					return true
				end
				if mtdata[g][idx1][idx2][idx3][1] == game.abbr then
					return true
				end
				local otheridx1 = idx1 == "MT" and "MN" or "MT"
				local oidx2, oidx3 = table.deepSearch(mtdata[g][otheridx1], move)
				if oidx2 and mtdata[g][otheridx1][oidx2][oidx3][1] == game.abbr then
					return true
				end
				return false
			end)
			if g == 7 then
				if args.LGPE then
					basedata[2] = true
				else
					basedata[2] = nil
				end
			end
			return basedata
		end,
		makegencell = function(basedata, g)
			return table.map(basedata, function(find, idx)
				local game = ml.gencelldict.tm.games[g][idx]
				return {
					str = find and ml.strings.BOOLYES or ml.strings.BOOLNO,
					bg = find and game.bg or "fff",
					abbr = { game.abbr },
				}
			end)
		end,
		games = {
			{ { bg = gendata[1].region, abbr = "" } }, -- 1
			{ { bg = gendata[2].region, abbr = "" } }, -- 2
			{ -- 3
				{ bg = gendata[3].region, abbr = "RZS" },
				{ bg = gendata[3].region, abbr = "RFVF" },
			},
			{ -- 4
				{ bg = "diamante", abbr = "DPPt" },
				{ bg = "heartgold", abbr = "HGSS" },
			},
			{ { bg = gendata[5].region, abbr = "" } }, -- 5
			{ -- 6
				{bg = 'x', abbr = 'XY'},
				{bg = 'rubinoomega', abbr = 'ROZA'},
			},
			{
				{ bg = 'sole', abbr = "SLUSUL" },
				{ bg = 'lgp', abbr = "LGPE" },
			}, -- 7
			{
				{ bg = 'spada', abbr = "SpSc" },
			}, -- 8
		},
	},
	breed = {
		getbasedata = function(g, ndex, move)
			local basedata = lib.pokemoves[ndex].breed[g][move]
			return basedata and table.copy(basedata)
		end,
		makegencell = function(basedata, g)
			local gencell = table.map(basedata, function(t)
				local bg = t.games
				           and ml.levelgames[g][table.deepSearch(ml.levelgames[g],
						                                         t.games[1])].bg
						   or gendata[g].region
				return {
					str = lib.msarrayToModal(#t > 0 and t or { 0 }, g, nil, 6),
					bg = bg,
					abbr = t.games,
					cs = (not t.games) and #ml.levelgames[g] or nil,
				}
			end, ipairs)
			if basedata.games then
				table.insert(gencell, 1, {
						str = ml.strings.BOOLNO,
						bg = "fff",
						abbr = table.filter(lib.games.breed[g], function(abbr)
							return not table.deepSearch(basedata.games, abbr)
						end)
					})
			end
			return gencell
		end,
		games = ml.levelgames,
	},
}

--[[

Functions that creates the table of args for one gen and kind. This function
takes as many info as possible from data module, but support also arguments
for some games not listed in data modules (right now only LGPE).
This is just the main skeleton, completed with functions in gencelldict that
depend on kind.
Arguments:
	- g: generation (a number)
	- ndex: ndex or name of the Pokémon
	- move: name of the move
	- kind: kind of entry ("level", "tm", ...)
	- args: table of additional arguments. Only used by getbasedata in
	        gencelldict

--]]
ml.gencell = function(g, ndex, move, kind, args)
	local basedata = ml.gencelldict[kind].getbasedata(g, ndex, move, args)
	-- If no basedata the Pokémon doesn't learn the move in gen g, so empty cell
	if not basedata then
		return { {
				str = ml.strings.BOOLNO,
				bg = "fff",
				cs = #ml.gencelldict[kind].games[g]
			} }
	end
	local gencell = ml.gencelldict[kind].makegencell(basedata, g)

	-- Collapse groups with the same string value
	local res = {}
	for _, v in ipairs(gencell) do
		local idx = table.deepSearch(res, v.str)
		if not idx then
			table.insert(res, v)
		else
			res[idx].abbr = res[idx].abbr
							and table.merge(res[idx].abbr, v.abbr)
			                or v.abbr
		end
	end
	if #res == 1 then
		res[1].bg = gendata[g].region
		res[1].cs = res[1].abbr and #res[1].abbr or #ml.gencelldict[kind].games[g]
		res[1].abbr = nil
	end
	-- Pads the cell, adding cs to the last element
	local totcs = table.fold(res, 0, function(acc, cell)
		return acc + ml.getcs(cell)
	end)
	if totcs < #ml.gencelldict[kind].games[g] then
		local last = res[#res]
		last.cs = #ml.gencelldict[kind].games[g] - totcs + ml.getcs(last)
	end
	return res
end

--[[

Build the tail of an entry given some basic informations taking as much data as
possible from data modules. Some data is still required to the caller.

Arguments:
    - move: move name
    - kind: kind of the entry
    - ndex: name or ndex of the Pokémon of this entry
	- args: a table with any additional argument. Its structure depend on kind,
		but it makes use of general arguments described in ml.entry

--]]
ml.entrytail = function(move, kind, ndex, args)
	-- cells is an array of logical cells, as described in the docs of
	-- ml.printtail
    local cells = {}
    if kind == "event" then
        cells[1] = { { str = table.concat{ "<div>", args[2], "</div>" }, bg = "fff" } }
    elseif kind == "tutor" then
		cells[1] = table.map(movepokes.movetutorindexes[move], function(idx)
			local g, num = table.deepSearch(lib.games.tutor,
			                                ml.tutorgames[idx].abbr)
			local tutordata = lib.pokemoves[ndex].tutor[g]
			local find = tutordata
			             and tutordata[move]
						 and tutordata[move][num]
			return {
				str = find and ml.strings.BOOLYES or ml.strings.BOOLNO,
				bg = find and ml.tutorgames[idx].bg or "fff",
			}
		end)
	else
		local startgen = moves[move].gen or 1
		if kind == "breed" then
			startgen = math.max(startgen, 2)
		end
		for g = startgen, gendata.latest do
			cells[g - startgen + 1] = ml.gencell(g, ndex, move, kind, args)
		end
	end

    return ml.printtail(cells, kind)
end

--[[

Build the head of an entry from some basic informations. The head is the part
of the entry that doesn't depend on kind.

Args:
    - move: move name
    - ndex: name or ndex of the Pokémon of this entry. This value should be an
	        index of data modules as is.
	- args: named parameters, all optional
		* notes: any note that should be added in tt after the Pokémon's name
		* STAB: value of the stab. If not given is autocomputed (do note that
	            an empty value IS a value that means no STAB)
		* form: the abbr of the form. This argument is mandatory if the
			    Pokémon isn't a base form (so empty abbr), won't be extracted
				from ndex
		* allforms: a true value means that this entry is about all the
			        forms of this Pokémon
		* useless: a true value means that the form of this entry is
			       useless, and will be searched in the right module

--]]
ml.entryhead = function(move, ndex, args)
	local pokedata = pokes[ndex]
					 or {name = 'Missingno.', ndex = '000'}
	local forml = args.allforms and '<div class="text-small">Tutte le forme</div>'
	              or (args.useless
						and useless[ndex].links[args.form]
						or forms.getlink(tostring(ndex), false, args.form)
					)
	pokedata = table.merge(
		multigen.getGen(pokedata),
		table.copy(groups[pokedata.ndex] or {group1 = 'sconosciuto'})
	)
	local stab = args.STAB or lib.computeSTAB(ndex, move, args.form)
	local ndextf = string.tf(pokedata.ndex)
	pokedata.group1show = pokedata.group1 == 'coleottero'
							and 'Coleot'
							or (pokedata.group1 == 'non ancora scoperto'
								and 'Non ancora<div>scoperto</div>'
								or string.fu(pokedata.group1)
							)
	pokedata.group2show = pokedata.group2 == 'coleottero'
						and 'Coleot'
						or string.fu(pokedata.group2)
	pokedata.type2 = pokedata.type2 ~= pokedata.type1
					and string.fu(pokedata.type2)
					or nil
	pokedata.type1 = string.fu(pokedata.type1)

	return string.interp(ml.strings.CELLHEAD, {
		num = ndextf,
		ani = ms.staticLua(ndextf .. forms.toEmptyAbbr(args.form)),
		stab = stab,
		name = pokedata.name,
		notes = lib.makeNotes(args.notes or ''),
		forml = forml,
		types = resp.twoTypeBoxesLua(pokedata.type1, pokedata.type2, {'tiny'},
	        nil, {'vert-center'}),
		groups = resp.twoEggBoxesLua(pokedata.group1, pokedata.group2, {'tiny'},
	        nil, {'vert-center'}),
	})
end

--[[

Compute the since/until string of a given gen.
Arguments:
	- gen: a number representing the gen since/until the sentence is true
	- su: a boolean value, with true meaning SINCE and false meaning UNTIL

--]]
ml.sinceuntilstr = function(gen, su)
	local genstr = gendata[gen].ext
	return string.interp(ml.strings.notes[su and "SINCE" or "UNTIL"], {
		gen = genstr,
		art = genstr:match("^[aeiou]") and "l'" or "la ",
	})
end

-- Maps "''" to "" to compare STAB values easily (I want to consider "''" as "")
ml.flattenSTAB = function(stab)
	return stab == "''" and "" or stab
end

--[[

Compute notes for an entry.
Args:
	- move: move name
	- kind: kind of the entry
	- ndex: ndex of the Pokémon of this entry
	- args (optional): named parameters, all optional:
		* form: abbr of the form

--]]
ml.computenotes = function(move, kind, ndex, args)
	local notes = {}
	local form = args.useless and ""
	             or forms.toEmptyAbbr(args.form or forms.getabbr(tostring(ndex)))
	local pokegen
	if form ~= "" then
		ndex = type(ndex) == "string" and tonumber(ndex:sub(1, 3)) or ndex
		pokegen = genlib.getGen.game(altforms[ndex].since[form])
	else
		pokegen = genlib.getGen.ndex(pokes[ndex].ndex)
	end
	local sgen = math.max(moves[move].gen or 1, pokegen)
	-- STAB/no STAB in gen x
	-- Assumption: fixed Pokémon and move, there is only one switch between yes
	-- and no STAB
	local STAB = ml.flattenSTAB(lib.computeSTAB(ndex, move, args.form, sgen))
	for g = sgen + 1, gendata.latest do
		if STAB ~= ml.flattenSTAB(lib.computeSTAB(ndex, move, args.form, g)) then
			table.insert(notes, ml.strings.notes.STAB
			                    .. ml.sinceuntilstr(g, STAB == ""))
			-- STAB is "'''" or "", not a bool
			break
		end
	end
	-- breed notes
	if kind == "breed" then
		for g = math.max(sgen, 2), gendata.latest do
			if lib.pokemoves[ndex][kind][g] and lib.pokemoves[ndex][kind][g][move] then
				local movegendata = lib.pokemoves[ndex][kind][g][move]
				for _, parents in ipairs(movegendata) do
					local localnotes = movegendata.notes
					                   or lib.breednotes(g, move, parents[1])
					if localnotes ~= "" then
						-- Add notes: select game/gen
						local scope
						if parents.games
						   and not table.equal(parents.games, movegendata.games) then
							-- Game wise notes
							scope = "in " .. table.concat(parents.games, ", ")
						else
							-- Gen wise notes
							scope = table.concat{ "in ", gendata[g].ext,
							                      " generazione" }
						end
						table.insert(notes, scope .. " " .. localnotes)
					end
				end
			end
		end
	end
	return string.fu(table.concat(notes, "; "))
end

--[[

Creates a single entry for a movelist. It isn't fully automated because
something isn't in data modules (most notably LGPE learnsets)

Arguments:
    - move: move name
    - kind: kind of the entry
    - ndex: ndex of the Pokémon of this entry
	- args (optional): any other optional argument. General ones are:
		* notes: any note that should be added in tt after the Pokémon's name.
		         If not given is autocomputed
		* STAB: the value of the STAB. If not given is autocomputed
		* form: abbr of the form
		* allforms: a true value means that this entry is about all the
				    forms of this Pokémon
		* useless: a true value means that the form of this entry is
				     useless, and will be searched in the right module
	some are dependent on kind:
		* (kind "event") [2]: the string to print
		* (kind "level" and "tm") LGPE: level at which the Pokémon learn the
					                    move in LGPE

--]]
ml.entry = function(move, kind, ndex, args)
	args = wlib.trimAll(args)
	ndex = tonumber(ndex) or ndex
	if args.useless then
		args.form = args.form or forms.getabbr(ndex)
		ndex = tonumber(ndex:sub(1,3))
	else
		args.form = forms.getabbr(tostring(ndex), args.form) or nil
	end
	args.form = args.form or ''
	args.notes = args.notes or ml.computenotes(move, kind, ndex, args)
    return ml.entryhead(move, ndex, args)
        .. ml.entrytail(move, kind, ndex, args)
end

-- =========================== WikiCode interfaces ============================
--[[

The WikiCode interface uses two arguments plus any other arguments used by
ml.entry via args.
Arguments:
	- [1]: ndex of the Pokémon of this entry
	- movename (optional): name of the move of this entry. If not given,
	                       defaults to the page name
    - anything documented for argument "args" of ml.entry

--]]
local function makeentry(kind)
	ml[kind .. "entry"] = function(frame)
		local p = frame.args
		local movename = p.movename or mw.title.getCurrentTitle().text
		return ml.entry(string.trim(movename:lower()), kind, p[1], p)
	end
	ml[string.fu(kind) .. "entry"] = ml[kind .. "entry"]
end

makeentry("level")
makeentry("breed")
makeentry("tm")
makeentry("tutor")
makeentry("event")

return ml
