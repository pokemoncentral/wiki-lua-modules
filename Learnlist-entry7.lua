-- Gli entry dei learnlist di settima generazione

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')			-- luacheck: no unused
local lib = require('Wikilib-learnlists')
local moves = require("Move-data")
local links = require('Links')

-- stab, mossa, notes, tipo, cat, pw, acc, pp, gara, exib, inib
local entry = function(stab, mossa, notes)
	local data = moves[string.lower(mossa)]
    return lib.categoryentry(stab, mossa, notes, string.fu(data.type), string.fu(data.category), data.power, data.accuracy, data.pp)
end

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
	if p[1] == 'Evo' or p[1] == 'Evoluzione' then
		p[1] = 'Evo<span class="hidden-xs">luzione</span>'
	end
	if p[2] == 'Evo' or p[2] == 'Evoluzione' then
		p[2] = 'Evo<span class="hidden-xs">luzione</span>'
	end
    return table.concat{'|-\n', lib.gameslevel(
			p[1] or links.tt('&mdash;', 'Disponibile solo in Ultrasole e Ultraluna'),
			p[2] or links.tt('&mdash;', 'Disponibile solo in Sole e Luna')
		),
		entry(p[5] or '', p[3] or 'Geloraggio', lib.makeNotes(p[4] or ''))}
end

z.Level = z.level
-- It's perfect un corno, doesn't work becuase it takes one more parameter
-- Wrapper for level function, adding a "second level"
z.levelLGPE = function(frame)
	table.insert(frame.args, 1, frame.args[1])
	return z.level(frame)
end

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} VI Sprite Zaino.png]]</span>[[${p1}|<span style="color:#000;">${p1}</span>]]]=],
		entry(p[4] or '', p[2] or 'Purogelo', lib.makeNotes(p[3] or ''))},
{
	img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
	p1 = p[1] or 'MT55',
	tipo = string.fu(moves[string.lower(p[2] or 'Purogelo')].type) or 'Sconosciuto'
})
end

z.Tm = z.tm
-- It's perfect, here just to make easier a future update
z.tmLGPE = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="padding: 0.1em 0.3em;" | ${p1}]],
		entry(p[4] or '', p[2] or 'Lanciafiamme', lib.makeNotes(p[3] or '', lib.makeNotes(p[5] or '', lib.makeNotes(p[6] or ''))))},
{
	p1 = lib.mslistToModal(p[1] or '', '7', nil, 6)
})
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.tutorgames{{'SL', p[4]}, {'USUL', p[5]}},
			' ', entry(p[3] or '',
			p[1] or 'Tuono', lib.makeNotes(p[2] or ''))}
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.preevodata(p, '7'), ' ', entry(p[8] or '',
		p[7] or 'Scontro', '')}
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="padding: 0.1em 0.3em;" | ${p1}${p10}]],
		entry(p[4] or '', p[2] or 'Bora', lib.makeNotes(p[3] or ''))},
{
	p1 = p[1] or 'Evento',
	p10 = lib.makeLevel(p[5])
})
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
	return lib.entrynull('level', '11')
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
	return lib.entrynull('tm', '11')
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
	return lib.entrynull('breed', '10')
end

z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse

z.tutornull = function(frame)
	return lib.entrynull('tutor', '13')
end

z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
	return lib.entrynull('preevo', '10')
end

z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
