-- Gli entry dei learnlist di settima generazione

local z = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local moves = require("Move-data")

-- stab, mossa, notes, tipo, cat, pw, acc, pp, gara, exib, inib
local entry = function(stab, mossa, notes)
	local data = moves[string.lower(mossa)]
    return lib.categoryentry(stab, mossa, notes, string.fu(data.type), string.fu(data.category), data.power, data.accuracy, data.pp)
end

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{'|-\n', lib.gameslevel(p[1]),
		entry(p[4] or '', p[2] or 'Geloraggio', lib.makeNotes(p[3] or ''))}
end

z.Level = z.level

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[File:${img} ${tipo} VI Sprite Zaino.png]]
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[${p1}|<span style="color:#000;">${p1}</span>]]]=],
		entry(p[4] or '', p[2] or 'Purogelo', lib.makeNotes(p[3] or ''))},
{
	img = string.match(p[1] or 'MT55', '^(M[TN])%d'),
	p1 = p[1] or 'MT55',
	tipo = string.fu(moves[string.lower(p[2] or 'Purogelo')].type) or 'Sconosciuto'
})
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return string.interp(table.concat{[[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}]],
		entry(p[4] or '', p[2] or 'Lanciafiamme', lib.makeNotes(p[3] or ''))},
{
	p1 = lib.insertnwlns(p[1] or '', nil, '7')
})
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat{lib.tutorgames{{'S', p[4], 'So'}, {'L', p[4]}},
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
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${p1}${p10}]],
		entry(p[4] or '', p[2] or 'Bora', lib.makeNotes(p[3] or ''))},
{
	p1 = p[1] or 'Evento',
	p10 = lib.makeLevel(p[5])
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
