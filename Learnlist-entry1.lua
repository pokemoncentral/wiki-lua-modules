-- Gli entries dei learnlist di prima generazione

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')  -- luacheck: no unused
local lib = require('Wikilib-learnlists')
local s = require("Sup-data")
local abbrLib = require('Wikilib-sigle')

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | ${level}${games}]=],
	lib.basicentry(p[8] or '', p[2] or 'Iper Raggio', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	level = p[1] or 'Inizio',
	games = abbrLib.concatAbbrs(p[9] or '', s)
})
end

z.Level = z.level

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} Sprite Zaino.png]]</span>[[${machine}|<span style="color:#000;">${machine}</span>]]${games}]=],
	lib.basicentry(p[8] or '', p[2] or 'Azione', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
	machine = p[1] or 'MT55',
	tipo = p[3] or 'Sconosciuto',
    games = abbrLib.concatAbbrs(p[9] or '', s)
})
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.preevodata(p, '1'), ' ', lib.basicentry(p[12] or '',
			p[7] or 'Scontro', lib.makeNotes(p[13] or ''),
			p[8] or 'Sconosciuto', p[9] or '0', p[10] or '0', p[11] or '0')}
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="padding: 0.1em 0.3em;" | ${event}${level}]],
	lib.basicentry(p[8] or '', p[2] or 'Abisso', lib.makeNotes(p[7] or ''),
			p[3] or 'Sconosciuto', p[4] or '0', p[5] or '0', p[6] or '0')},
{
	event = p[1] or 'Evento',
	level = lib.makeLevel(p[9])
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

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
	return lib.entrynull('preevo', '6')
end

z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
