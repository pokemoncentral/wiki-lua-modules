--[[

Right now this module is just a convenient library for movelist-entry, used to
automatically build an entry with few parameters.

===============================================================================
TODO
Creates the list of Pokémon that learns a certain move.

The module has a function for kind (level, tm, ...). All these functions have 2
mandatory parameters: the move name (BASEPAGENAME is fine) and the generation
of introduction of the move. This second is of course a lack of data modules
but hey, that's what we have.

Examples:
{{#invoke: Movelist | level | {{BASEPAGENAME}} | 5 }}
{{#invoke: Movelist | tm | abbattimento | 5 }}
{{#invoke: Movelist | event | oscurotuffo | 4 }}

--]]

local ml = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local lib = require('Wikilib-learnlists')
-- local genlib = require('Wikilib-gens')
local multigen = require('Wikilib-multigen')
local forms = require('Wikilib-forms')
local wlib = require('Wikilib')
-- local links = require('Links')
local css = require('Css')
local links = require('Links')
local ms = require('MiniSprite')
local resp = require('Resp')
-- local hf = require('Movelist-hf')
local blackabbr = require("Blackabbrev-data")
-- local sig = require("Sigle-data")
-- local sup = require("Sup-data")
local pokes = require("Poké-data")
-- local moves = require("Move-data")
local groups = require("PokéEggGroup-data")
local useless = require("UselessForms-data")
local pokemoves = require("PokéMoves-data")
local gendata = require("Gens-data")
-- local mtdata = require("Machines-data")

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
		-- {bg = 'lgp', abbr = 'LGPE'},
	},
}

--[[

Prints a (real) cell for a single value.
Arguments:
	- text: text content
	- bgcolor: name of bg color (from colore module)
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

--     ================ First main cancer: tm/breed header ================

--     ======== Second main cancer: datas given move, ndex and kind =======
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
			local cs = physcell.cs or physcell.abbr and #physcell.abbr or 1
			return ml.makeBox(physcell.str, physcell.bg,
			                  bold, cs,
							  ttabbr and abbrs, not ttabbr and abbrs)
		end)
	end)
end

--[[

Functions that creates the table of args for one gen and kind "level".
-- TODO: docs

--]]
ml.genlevelcell = function(g, ndex, move, args)
	local basedata = pokemoves[ndex].level[g][move]
	local gencell
	if basedata then
		gencell = table.map(basedata, function(t, idx)
			local empty = #t > 0
			return {
				str = empty and string.fu(table.concat(t, ", "))
				            or ml.strings.BOOLNO,
				bg = empty and ml.levelgames[g][idx].bg or "fff",
				abbr = { ml.levelgames[g][idx].abbr },
			}
		end)
	else
		gencell = table.map(ml.levelgames[g], function(v)
			return {
				str = ml.strings.BOOLNO,
				bg = "fff",
				abbr = { v.abbr },
			}
		end)
	end
	-- TODO: this is an horrible workaround, I know I can do better
	if g == 7 and args.LGPE then
		table.insert(gencell, { str = args.LGPE, bg = "lgp",
		                           abbr = { "LGPE" } })
	end
	-- Collapse groups with the same string value
	local res = {}
	for _, v in ipairs(gencell) do
		local idx = table.deepSearch(res, v.str)
		if not idx then
			table.insert(res, v)
		else
			-- res[idx].abbr = table.merge(res[idx].abbr, v.abbr)
			table.insert(res[idx].abbr, v.abbr[1])
		end
	end
	if #res == 1 then
		res[1].cs = #res[1].abbr
		res[1].abbr = nil
	end
	-- TODO: horrible solution pt. 2
	if g == 7 and not args.LGPE then
		local last = res[#res]
		last.cs = (last.cs and last.cs or #last.abbr) + 1
	end
	return res
end

--[[

This functions build the tail of an entry given move, Pokémon and kind taking
datas from data module. Some data is still required to the caller.

Arguments:
    - move: move name
    - kind: kind of the entry
    - ndex: name or ndex of the Pokémon of this entry
	- args: a table with any additional argument. Its structure depend on kind,
		but it makes use of general arguments described in ml.entry

"tutor": an array of "X", "yes" and "no" at most as long as
		entry.tutorCellsColors. Each value is interpreted as no cell, can
		learn and can't learn respectively. Trailing missing values are
		the same as "X".

--]]
ml.entrytail = function(move, kind, ndex, args)
	-- cells is an array of logical cells, as described in the docs of
	-- ml.printtail
    local cells = {}
    if kind == "event" then
        cells[1] = { str = args[1], bg = "fff" }
    elseif kind == "tutor" then
		-- TODO
	elseif kind == "level" then
		for g = 1, gendata.latest do
			cells[g] = ml.genlevelcell(g, ndex, move, args or {})
		end
    elseif table.search({"tm", "breed"}, kind) then
		-- TODO
        -- local basedata = pokemoves[ndex][kind][gen][move]
    end
    return ml.printtail(cells, kind)
end

--[[

TODO: write docs, autocompute some notes from data module

Args:
    - move: move name
    - ndex: name or ndex of the Pokémon of this entry. This value should be an
	        index of data modules as is.
	- notes: any note that should be added in tt after the Pokémon's name
	- form (optional): the abbr of the form. This argument is mandatory if the
			Pokémon isn't a base form (so empty abbr), won't be extracted from
			ndex
	- allforms (optional): a true value means that this entry is about all the
			 forms of this Pokémon
	- useless (optional): a true value means that the form of this entry is
			useless, and will be searched in the right module

--]]
ml.entryhead = function(move, ndex, notes, form, allforms, isUseless)
	local pokedata = pokes[ndex]
					 or {name = 'Missingno.', ndex = '000'}
	local forml = allforms and '<div class="text-small">Tutte le forme</div>'
	              or (isUseless
						and useless[ndex].links[form]
						or forms.getlink(tostring(ndex), false, form)
					)
	pokedata = table.merge(
		multigen.getGen(pokedata),
		table.copy(groups[pokedata.ndex] or {group1 = 'sconosciuto'})
	)
	local stab = lib.computeSTAB(ndex, move, form)
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
		ani = ms.staticLua(ndextf .. forms.toEmptyAbbr(form)),
		stab = stab,
		name = pokedata.name,
		notes = lib.makeNotes(notes or ''),
		forml = forml,
		types = resp.twoTypeBoxesLua(pokedata.type1, pokedata.type2, {'tiny'},
	        nil, {'vert-center'}),
		groups = resp.twoEggBoxesLua(pokedata.group1, pokedata.group2, {'tiny'},
	        nil, {'vert-center'}),
	})
end

--[[

TODO: docs

Args:
    - move: move name
    - kind: kind of the entry
    - ndex: ndex of the Pokémon of this entry
	- args (optional): any other optional argument. General ones are:
		* notes: any note that should be added in tt after the Pokémon's name
		* form: abbr of the form
		* allforms: a true value means that this entry is about all the
				    forms of this Pokémon
		* useless: a true value means that the form of this entry is
				     useless, and will be searched in the right module
	some are dependent on kind:
		* (kind "event") [1]: the string to print
		* (kind "level") LGPE: level at which the Pokémon learn the move in
					           LGPE, because it isn't in the data module

--]]
ml.entry = function(move, kind, ndex, args)
	ndex = tonumber(ndex) or ndex
	if args.useless then
		args.form = args.form or forms.getabbr(ndex)
		ndex = tonumber(ndex:sub(1,3))
	else
		args.form = forms.getabbr(tostring(ndex), args.form) or nil
	end
    return ml.entryhead(move, ndex, args.notes or '',
						args.form or '',
						args.allforms, args.useless)
        .. ml.entrytail(move, kind, ndex, args)
end

-- TODO: temporary test function
ml.entryTEST = function(frame)
	local p = frame.args
	return ml.entry(mw.title.getCurrentTitle().text:lower(), "level", p[2], p)
end

return ml
