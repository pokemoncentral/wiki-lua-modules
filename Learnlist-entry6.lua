-- Gli entry dei learnlist di sesta generazione

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')

local entry = function(stab, mossa, notes, tipo, cat, pw, acc, pp, gara, exib, inib)
    return lib.categoryentry(stab, mossa, notes, tipo, cat, pw, acc, pp) ..
		lib.contestentry(gara, exib, inib)
end

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{'|-\n', lib.gameslevel(p[1] or
		[[<span class="explain" title="Disponibile solo in Rubino Omega e Zaffiro Alpha">''Assente''</span>]],
		p[2] or [[<span class="explain" title="Disponibile solo in X e Y">''Assente''</span>]]),
		entry(p[10] or '', p[3] or 'Geloraggio', lib.makeNotes(p[9] or ''),
			p[4] or 'Sconosciuto', p[5] or 'Speciale', p[6] or '0', p[7] or '0',
			p[8] or '0', p[11] or 'Sconosciuto', p[12] or '?', p[13] or '?')}
end

z.Level = z.level

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[File:${img} ${tipo} Sprite Zaino.png]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[${p1}|<span style="color:#000;">${p1}</span>]]]=],
		entry(p[9] or '', p[2] or 'Purogelo', lib.makeNotes(p[8] or ''),
			p[3] or 'Sconosciuto', p[4] or 'Speciale', p[5] or '0', p[6] or '0',
			p[7] or '0', p[10] or 'Sconosciuto', p[11] or '?', p[12] or '?')},
{
	img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
	p1 = p[1] or 'MT55',
	tipo = p[3] or 'Sconosciuto'
})
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}]],
		entry(p[9] or '', p[2] or 'Lanciafiamme', lib.makeNotes(p[8] or ''),
			p[3] or 'Sconosciuto', p[4] or 'Stato', p[5] or '0', p[6] or '0',
			p[7] or '0', p[10] or 'Sconosciuto', p[11] or '?', p[12] or '?')},
{
	p1 = lib.insertnwlns(p[1] or '')
})
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.tutorgames{{'X', p[9]}, {'Y', p[9]},
		{'RO', p[10]}, {'ZA', p[10]}}, ' ', entry(p[8] or '',
			p[1] or 'Tuono', lib.makeNotes(p[7] or ''), p[2] or 'Sconosciuto',
			p[3] or 'Stato', p[4] or '0', p[5] or '0', p[6] or '0',
			p[11] or 'Sconosciuto', p[12] or '?', p[13] or '?')}
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.preevodata(p, '6'), ' ', entry(p[13] or '',
		p[7] or 'Scontro', '', p[8] or 'Sconosciuto', p[9] or 'Stato',
		p[10] or '0', p[11] or '0', p[12] or '0', p[14] or 'Sconosciuto',
		p[15] or '?', p[16] or '?')}
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}${p10}]],
		entry(p[9] or '', p[2] or 'Bora', lib.makeNotes(p[8] or ''),
			p[3] or 'Sconosciuto', p[4] or 'Fisico', p[5] or '0',
			p[6] or '0', p[7] or '0', p[11] or 'Sconosciuto',
			p[12] or '?', p[13] or '?')},
{
	p1 = p[1] or 'Evento',
	p10 = lib.makeLevel(p[10])
})
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="11" | Questo Pokémon non impara nessuna mossa aumentando di livello]]
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="11" | Questo Pokémon non impara nessuna mossa tramite MT.]]
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="10" | Questo Pokémon non impara nessuna mossa tramite accoppiamento.]]
end

z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse

z.tutornull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="13" | Questo Pokémon non impara nessuna mossa dall'Esperto Mosse.]]
end

z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="10" | Questo Pokémon non impara nessuna mossa appresa tramite evoluzioni precedenti.]]
end

z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
