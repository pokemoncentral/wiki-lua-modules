-- Gli entries dei learnlist di terza generazione

local z = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local abbrLib = require('Wikilib-sigle')
local s = require("Sup-data")
-- stylua: ignore end

-- Funzione chiamata da tutti gli entry per generare le celle dalla seconda in poi

local entry = function(stab, mossa, notes, tipo, pw, acc, pp, gara, exib, inib)
    return lib.basicentry(stab, mossa, notes, tipo, pw, acc, pp)
        .. lib.contestentry(gara, exib, inib)
end

-- Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        "|-\n",
        lib.gameslevel(p[1] or "&mdash;", p[2] or "&mdash;"),
        entry(
            p[12] or "",
            p[3] or "Stramontante",
            lib.makeNotes(p[11] or ""),
            p[4] or "Sconosciuto",
            p[5] or "0",
            p[6] or "0",
            p[7] or "0",
            p[8] or "Grinta",
            p[9] or "0",
            p[10] or "0"
        ),
    })
end

z.Level = z.level

-- Entry per le mosse appprese tramite MT/MN

z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return txt.interp(
        table.concat({
            [=[|-
| style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} Sprite Zaino.png]]</span>[[${p1}|<span style="color:#000;">${p1}</span>]]${games}]=],
            entry(
                p[11] or "",
                p[2] or "Fuocobomba",
                lib.makeNotes(p[10] or ""),
                p[3] or "Sconosciuto",
                p[4] or "0",
                p[5] or "0",
                p[6] or "0",
                p[7] or "Grazia",
                p[8] or "0",
                p[9] or "0"
            ),
        }),
        {
            img = string.match(p[1] or "MT55", "^(M[TN])%d"),
            p1 = p[1] or "MT55",
            tipo = p[3] or "Sconosciuto",
            games = abbrLib.concatAbbrs(p[12] or "", s),
        }
    )
end

z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento

z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return txt.interp(
        table.concat({
            [=[|-
| style="padding: 0.1em 0.3em;" | ${fathers}]=],
            entry(
                p[11] or "",
                p[2] or "Fulmine",
                lib.makeNotes(p[10] or "", abbrLib.concatAbbrs(p[12] or "", s)),
                p[3] or "Sconosciuto",
                p[4] or "0",
                p[5] or "0",
                p[6] or "0",
                p[7] or "Classe",
                p[8] or "0",
                p[9] or "0"
            ),
        }),
        {
            fathers = lib.mslistToModal(p[1] or "", "3", nil, 6),
        }
    )
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.tutorgames({ { "RFVF", p[11] }, { "S", p[12] }, { "XD", p[13] } }),
        " ",
        entry(
            p[10] or "",
            p[1] or "Schianto",
            lib.makeNotes(p[9] or ""),
            p[2] or "Sconosciuto",
            p[3] or "0",
            p[4] or "0",
            p[5] or "0",
            p[6] or "Classe",
            p[7] or "0",
            p[8] or "0"
        ),
    })
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.preevodata(p, "3"),
        " ",
        entry(
            p[15] or "",
            p[7] or "Scontro",
            lib.makeNotes(p[16] or ""),
            p[8] or "Sconosciuto",
            p[9] or "0",
            p[10] or "0",
            p[11] or "0",
            p[12] or "Grazia",
            p[13] or "0",
            p[14] or "0"
        ),
    })
end

z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi

z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return txt.interp(
        table.concat({
            [[|-
| style="padding: 0.1em 0.3em;" | ${p1}${p12}]],
            entry(
                p[11] or "",
                p[2] or "Abisso",
                lib.makeNotes(p[10] or ""),
                p[3] or "Sconosciuto",
                p[4] or "0",
                p[5] or "0",
                p[6] or "0",
                p[7] or "Acume",
                p[8] or "0",
                p[9] or "0"
            ),
        }),
        {
            p1 = p[1] or "Evento",
            p12 = lib.makeLevel(p[12]),
        }
    )
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
    return lib.entrynull("level", "9")
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
    return lib.entrynull("tm", "10")
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
    return lib.entrynull("breed", "9")
end

z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse

z.tutornull = function(frame)
    return lib.entrynull("tutor", "12")
end

z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
    return lib.entrynull("preevo", "9")
end

z.Preevonull, z.prevonull, z.Prevonull =
    z.preevonull, z.preevonull, z.preevonull

return z
