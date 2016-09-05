-- Gli entry dei learnlist di quarta generazione

local z = {}

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local s = require("Sup-data")

-- Funzione chiamata da tutti gli entry per generare le celle dalla seconda in poi

local entry = function(stab, mossa, notes, tipo, cat, pw, acc, pp, gara, hearts)
    return lib.categoryentry(stab, mossa, notes, tipo, cat, pw, acc, pp) ..
		lib.contestentry(gara, hearts)
end

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}${games}]=],
	entry(p[11] or '', p[2] or 'Scontro', lib.makeNotes(p[10] or ''),
		p[3] or 'Sconosciuto', p[4] or 'Stato', p[5] or '0', p[6] or '0',
		p[7] or '0', p[8] or 'Bellezza', p[9] or '0')},
	{
		p1 = p[1] or 'Inizio',
		games = s[p[12]] or ''
	})
end

z.Level = z.level

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[File:${img} ${tipo} Sprite Zaino.png]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[${p1}|<span style="color:#000;">${p1}</span>]]${games}]=],
	entry(p[11] or '', p[2] or 'Scontro', lib.makeNotes(p[10] or ''),
		p[3] or 'Sconosciuto', p[4] or 'Stato', p[5] or '0', p[6] or '0',
		p[7] or '0', p[8] or 'Bellezza', p[9] or '0')},
	{
		img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
		p1 = p[1] or 'MT55',
		tipo = p[3] or 'Sconosciuto',
		games = s[p[12]] or ''
	})
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${fathers}]=],
	entry(p[11] or '', p[2] or 'Scontro', lib.makeNotes(p[10] or '',
		s[p[12]] or ''), p[3] or 'Sconosciuto', p[4] or 'Stato', p[5] or '0',
		p[6] or '0', p[7] or '0', p[8] or 'Bellezza', p[9] or '0')},
{
	fathers = lib.insertnwlns(p[1] or '')
})
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.tutorgames{{'D', p[11]}, {'P', p[11]},
		{'Pt', p[12]}, {'HG', p[13]}, {'SS', p[13]}}, ' ',
    entry(p[10] or '', p[1] or 'Schianto', lib.makeNotes(p[9] or ''),
		p[2] or 'Sconosciuto', p[3] or 'Stato', p[4] or '0', p[5] or '0',
		p[6] or '0', p[7] or 'Bellezza', p[8] or '0')}
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.preevodata(p, '5'), ' ', entry(p[15] or '',
	    p[7] or 'Scontro', lib.makeNotes(p[16] or ''),
	    p[8] or 'Sconosciuto', p[9] or 'Stato', p[10] or '0', p[11] or '0',
	    p[12] or '0', p[13] or 'Bellezza', p[14] or '0')}
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}${p12}]],
	entry(p[11] or '', p[2] or 'Scontro', lib.makeNotes(p[10] or ''),
		p[3] or 'Sconosciuto', p[4] or 'Fisico', p[5] or '0', p[6] or '0',
		p[7] or '0', p[8] or 'Bellezza', p[9] or '0')},
	{
		p1 = p[1] or 'Evento',
		p12 = lib.makeLevel(p[12])
	})
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="9" | Questo Pokémon non impara nessuna mossa aumentando di livello]]
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="10" | Questo Pokémon non impara nessuna mossa tramite MT.]]
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
    return [[|-
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="9" | Questo Pokémon non impara nessuna mossa tramite accoppiamento.]]
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
! style="background:#FFFFFF; border:1px solid #D8D8D8;" colspan="9" | Questo Pokémon non impara nessuna mossa appresa tramite evoluzioni precedenti.]]
end

z.Preevonull, z.prevonull, z.Prevonull = z.preevonull, z.preevonull, z.preevonull

return z
