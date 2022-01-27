--[[

Learnlist entries for LPA.
Below are described parameters of each kind of entry.

NOTE: STAB is autocomputed if empty. If you want to force an empty value (eg.
because autocompting is wrong) you should use the special value "no". To
autocompute the stab the Pokémon name is taken as ROOTPAGENAME, so outside of
Pokémon (sub)pages this will result in a script error. To fix this, just force
a value for the stab in every entry.

Level entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the learning level in LPA, 5 is the mastery level
in LPA

-- Tm entry:
-- 1 is the move name, 2 is the STAB (if empty is autocomputed),
-- 3 are optional notes, 4 is the MT of the move in SpSc, 5 is
-- the MT of the move in DLPS. Both are autocomputed if empty, to
-- force empty use the value "no"

-- Breed entry:
-- 1 is the list of parents, 2 is the move name, 3 is the STAB
-- (if empty is autocomputed), 4 to 6 are optional notes

-- Tutor entry:
-- 1 is the move name. 2 is the STAB (if empty is autocomputed),
-- 3 are optional notes, 4 is yes/no for SpSc, 5 is yes/no for IA
-- 6 is yes/no for DLPS

-- Preevo entry:
-- 1 is the move name. 2 is the STAB (if empty is autocomputed),
-- 2 is ndex, 3 (optional) notes of the first evolution that learn the move,
-- 4 and 5 are the same for the second

-- Event entry:
-- 1 is move name, 2 is the STAB (if empty is autocomputed),
-- 3 are optional notes, 4 is the event

--]]

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')			-- luacheck: no unused
local lib = require('Wikilib-learnlists')
local multigen = require('Wikilib-multigen')
local movesLPA = require("Move-LPA-data")
local sup = require("Sup-data")

local strings = {
	TMENTRYCELL = [=[|-
| class="black-text" style="padding: 0.1em 0.3em;" | ${content} ]=],
	TMIMGLINK = [=[<span class="hidden-xs">[[File:${kind} ${tipo} VIII Sprite Zaino.png]]</span>[[${kind}${num}]]]=],
	TMSLASH = [[&nbsp;/&nbsp;]],
	BREEDENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}',
	-- EVENTENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}${p10}',
}

-- Compute the displayed STAB from the input.
-- "move" is the move name, "stabval" is the value of stab passed to the call
local getSTAB = function(move, stabval)
	if stabval == "No" then
		return ""
	elseif stabval and stabval ~= "" then
		return stabval
	else
		return lib.computeSTAB(mw.title.getCurrentTitle().rootText:lower(), move, nil, 8)
	end
end

-- Temporary replacement for lib.basicentry because I don't know power, accuracy and PP of LPA moves
local wdata = require("Wikilib-data")
local box = require('Box')

lib.basicentry = function(stab, mossa, notes, tipo, pw, acc, pp)
	local tipobox
	if table.search(wdata.allTypes, tipo:lower()) then
		tipobox = box.boxTipoLua(tipo, {'thick'})
	else
		tipobox = box.boxLua(tipo, tipo, nil, "thick", "box-sconosciuto")
	end
    return string.interp([=[|| style="padding: 0.3em;" class="black-text" | ${stab}${mossa}${stab}${notes}
| style="padding: 0.8ex 0.3ex; height: 100%;" | ${tipo}]=],
{
    mossa = mossa == "&nbsp;" and mossa or table.concat{"[[", mossa, "]]"},
    stab = stab,
    notes = notes,
    tipo = tipobox,
})
end

local entry = function(mossa, stab, notes)
	local data = multigen.getGen(movesLPA[string.lower(mossa)])
    return lib.basicentry(getSTAB(mossa, stab),
						  mossa, notes, string.fu(data.type),
						  data.power, data.accuracy, data.pp)
end

-- Level entry
z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		'|-\n',
		lib.gameslevel(lib.makeEvoText(p[4]), lib.makeEvoText(p[5])),
		entry(p[1] or 'Geloraggio', p[2], lib.makeNotes(p[3] or ''))
	}
end
z.Level = z.level

-- Entry per le mosse apprese tramite esperto mosse
z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		lib.tutorgames{ {'LPA', p[4]} },
		' ',
		entry(p[1] or 'Tuono',
			  p[2],
			  lib.makeNotes(p[3] or '')
		)
	}
end
z.Tutor = z.tutor

-- -- Entry per le mosse apprese tramite evoluzioni precedenti
-- z.preevo = function(frame)
--     local p = lib.sanitize(mw.clone(frame.args))
--     return table.concat{
-- 		lib.autopreevo(p, 3, '8'),
-- 		' ',
-- 		entry(p[1] or 'Bora', p[2], '')
-- 	}
-- end
-- z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- -- Entry per le mosse apprese tramite eventi
-- z.event = function(frame)
--     local p = lib.sanitize(mw.clone(frame.args))
--     return table.concat{
-- 		string.interp(strings.BREEDENTRY, {
-- 				p1 = p[4] or 'Evento',
-- 				-- p10 = lib.makeLevel(p[5]),
-- 			}
-- 		),
-- 		entry(p[1] or 'Bora', p[2], lib.makeNotes(p[3] or ''))
-- 	}
-- end
-- z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello
z.levelnull = function(_)
	return lib.entrynull('level', '11')
end
z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse
z.tutornull = function(_)
	return lib.entrynull('tutor', '13')
end
z.Tutornull = z.tutornull

-- -- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti
-- z.preevonull = function(_)
-- 	return lib.entrynull('preevo', '10')
-- end
-- z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
