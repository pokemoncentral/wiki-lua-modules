-- Gli entries dei learnlist di seconda generazione

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local s = require("Sup-data")
local abbrLib = require('Wikilib-sigle')

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | ${p1}${games}]=],
	lib.basicentry(p[8] or '', p[2] or 'Iper Raggio', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	p1 = p[1] or 'Inizio',
	games = abbrLib.concatAbbrs(p[9] or '', s)
})
end

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} Sprite Zaino.png]]</span>[[${p1}|<span style="color:#000;">${p1}</span>]]${games}]=],
	lib.basicentry(p[8] or '', p[2] or 'Azione', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
	p1 = p[1] or 'MT55',
	tipo = p[3] or 'Sconosciuto',
    games = abbrLib.concatAbbrs(p[9] or '', s)
})
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | ${fathers}]=],
	lib.basicentry(p[8] or '', p[2] or 'Schianto', lib.makeNotes(p[7] or '',
			abbrLib.concatAbbrs(p[9] or '', s)), p[3] or 'Sconosciuto',
            p[4] or '0', p[5] or '0', p[6] or '0')},
{
	-- We use gen 3 MS because gen 1/2 are indistinguishable
    fathers = lib.mslistToModal(p[1] or '', '3', nil, 6)
})
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.tutorgames{{'C', 'Yes'}}, ' ',
			lib.basicentry(p[7] or '', p[1] or 'Schianto',
				lib.makeNotes(p[6] or ''), p[2] or 'Sconosciuto',
				p[3] or '0', p[4] or '0', p[5] or '0')}
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
	-- We use gen 3 MS because gen 1/2 are indistinguishable
    return table.concat{lib.preevodata(p, '3'), ' ',
			lib.basicentry(p[12] or '', p[7] or 'Scontro',
				lib.makeNotes(p[13] or ''), p[8] or 'Sconosciuto',
				p[9] or '0', p[10] or '0', p[11] or '0')}
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="padding: 0.1em 0.3em;" | ${p1}${p9}]],
		lib.basicentry(p[8] or '', p[2] or 'Abisso', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	p1 = p[1] or 'Evento',
	p9 = lib.makeLevel(p[9])
})
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
	return lib.entrynull('level', '6')
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
	return lib.entrynull('tm', '7')
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
	return lib.entrynull('breed', '6')
end

z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse

z.tutornull = function(frame)
	return lib.entrynull('tutor', '6')
end

z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
	return lib.entrynull('preevo', '6')
end

z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
