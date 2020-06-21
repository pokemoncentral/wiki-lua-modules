--[[

TODO: write "tests"

Learnlist entries for 8th gen.
Below parameters of each kind of entry are described.
NOTE: STAB is autocomputed if empty. If you want to force an empty value (eg.
because autocompting is wrong) you should use the special value "no"

Level entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the level

Tm entry:
1 is the move name, 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the MT of the move (if empty is
autocomputed)

Breed entry:
1 is the list of parents, 2 is the move name, 3 is the STAB
(if empty is autocomputed), 4 to 6 are optional notes

Tutor entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is yes/no for SpSc, 5 is yes/no for IA

Preevo entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
2 is ndex, 3 (optional) notes of the first evolution that learn the move,
4 and 5 are the same for the second

Event entry:
1 is move name, 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the event

--]]

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')			-- luacheck: no unused
local lib = require('Wikilib-learnlists')
local multigen = require('Wikilib-multigen')
local moves = require("Move-data")
local mtdata = require("Machines-data")

local strings = {
	TMENTRY = [=[|-
| class="black-text" style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} VIII Sprite Zaino.png]]</span>[[${p1}]]]=],
	BREEDENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}',
	-- EVENTENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}${p10}',
}

-- Compute the displayed STAB from the input.
-- "move" is the move name, "stabval" is the value of stab passed to the call
local getSTAB = function(move, stabval)
	if stabval == "no" then
		return ""
	elseif stabval ~= "" then
		return stabval
	else
		return lib.computeSTAB(mw.title.getCurrentTitle().text:lower(), move, nil, 8)
	end
end

local entry = function(mossa, stab, notes)
	local data = multigen.getGen(moves[string.lower(mossa)])
    return lib.categoryentry(getSTAB(mossa, stab),
							 mossa, notes,
							 string.fu(data.type), string.fu(data.category),
							 data.power, data.accuracy, data.pp)
end

-- Level entry
z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		'|-\n',
		lib.gameslevel(lib.makeEvoText(p[4])),
		entry(p[1] or 'Geloraggio', p[2] or '', lib.makeNotes(p[3] or ''))
	}
end
z.Level = z.level

-- MT/DT moves entry
z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
	local movename = p[1] or "geloraggio"
	-- Autocompute the MT/DT number
	local tmkind, tmnum
	if p[4] then
		tmkind, tmnum = string.match(p[4], '^([MD][TN])(%d+)')
	else
		tmkind, tmnum = table.deepSearch(mtdata[8], string.lower(movename))
	end
    return table.concat{
		string.interp(strings.TMENTRY, {
			img = tmkind,
			p1 = tmkind .. tostring(tmnum),
			tipo = string.fu(moves[string.lower(movename)].type or 'Sconosciuto')
		}),
		entry(movename, p[2] or '', lib.makeNotes(p[3] or '')),
	}
end
z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento
z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		string.interp(strings.BREEDENTRY, {
			p1 = lib.mslistToModal(p[1] or '', '8', nil, 6)
		}),
		entry(p[2] or 'Lanciafiamme',
			  p[3] or '',
			  lib.makeNotes(p[4] or '',
			                lib.makeNotes(p[5] or '',
							lib.makeNotes(p[6] or '')))
		),
	}
end
z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse
z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		lib.tutorgames{ {'SpSc', p[4]}, {'IA', p[5]} },
		' ',
		entry(p[1] or 'Tuono',
			  p[2] or '',
			  lib.makeNotes(p[3] or '')
		)
	}
end
z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti
z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
	local move = table.remove(p, 1)
	local stab = table.remove(p, 1)
    return table.concat{
		lib.preevodata(p, '8'),
		' ',
		entry(move or 'Bora', stab, '')
	}
end
z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi
z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{
		string.interp(strings.BREEDENTRY, {
				p1 = p[4] or 'Evento',
				-- p10 = lib.makeLevel(p[5]),
			}
		),
		entry(p[1] or 'Bora', p[2] or '', lib.makeNotes(p[3] or ''))
	}
end
z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello
z.levelnull = function(_)
	return lib.entrynull('level', '11')
end
z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN
z.tmnull = function(_)
	return lib.entrynull('tm', '11')
end
z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento
z.breednull = function(_)
	return lib.entrynull('breed', '10')
end
z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse
z.tutornull = function(_)
	return lib.entrynull('tutor', '13')
end
z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti
z.preevonull = function(_)
	return lib.entrynull('preevo', '10')
end
z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
