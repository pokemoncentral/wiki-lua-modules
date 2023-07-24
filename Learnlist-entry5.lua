-- Gli entry dei learnlist di quinta generazione

local z = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local abbrLib = require('Wikilib-sigle')
local links = require('Links')
local s = require("Sup-data")
-- stylua: ignore end

--Entry per le mosse apprese aumentando di livello

z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        "|-\n",
        lib.gameslevel(
            p[1]
                or links.tt(
                    "''Assente''",
                    "Disponibile solo in Nero 2 e Bianco 2"
                ),
            p[2]
                or links.tt(
                    "''Assente''",
                    "Disponibile solo in Nero 2 e Bianco 2"
                )
        ),
        lib.categoryentry(
            p[10] or "",
            p[3] or "Geloraggio",
            lib.makeNotes(p[9] or ""),
            p[4] or "Sconosciuto",
            p[5] or "Speciale",
            p[6] or "0",
            p[7] or "0",
            p[8] or "0"
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
            lib.categoryentry(
                p[9] or "",
                p[2] or "Purogelo",
                lib.makeNotes(p[8] or ""),
                p[3] or "Sconosciuto",
                p[4] or "Speciale",
                p[5] or "0",
                p[6] or "0",
                p[7] or "0"
            ),
        }),
        {
            img = string.match(p[1] or "MT55", "^(M[TN])%d"),
            p1 = p[1] or "MT55",
            tipo = p[3] or "Sconosciuto",
            games = abbrLib.concatAbbrs(p[10] or "", s),
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
            lib.categoryentry(
                p[8] or "",
                p[2] or "Lanciafiamme",
                lib.makeNotes(p[9] or "", abbrLib.concatAbbrs(p[10] or "", s)),
                p[3] or "Sconosciuto",
                p[4] or "Stato",
                p[5] or "0",
                p[6] or "0",
                p[7] or "0"
            ),
        }),
        {
            fathers = lib.mslistToModal(p[1] or "", "5", nil, 6),
        }
    )
end

z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse

z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.tutorgames({ { "NB", p[9] }, { "N2B2", p[10] } }),
        " ",
        lib.categoryentry(
            p[8] or "",
            p[1] or "Tuono",
            lib.makeNotes(p[7] or ""),
            p[2] or "Sconosciuto",
            p[3] or "Stato",
            p[4] or "0",
            p[5] or "0",
            p[6] or "0"
        ),
    })
end

z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti

z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.preevodata(p, "5"),
        " ",
        lib.categoryentry(
            p[13] or "",
            p[7] or "Scontro",
            "",
            p[8] or "Sconosciuto",
            p[9] or "Stato",
            p[10] or "0",
            p[11] or "0",
            p[12] or "0"
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
| style="padding: 0.1em 0.3em;" | ${p1}${p10}]],
            lib.categoryentry(
                p[9] or "",
                p[2] or "Bora",
                lib.makeNotes(p[8] or ""),
                p[3] or "Sconosciuto",
                p[4] or "Fisico",
                p[5] or "0",
                p[6] or "0",
                p[7] or "0"
            ),
        }),
        {
            p1 = p[1] or "Evento",
            p10 = lib.makeLevel(p[10]),
        }
    )
end

z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello

z.levelnull = function(frame)
    return lib.entrynull("level", "8")
end

z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN

z.tmnull = function(frame)
    return lib.entrynull("tm", "8")
end

z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento

z.breednull = function(frame)
    return lib.entrynull("breed", "7")
end

z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse

z.tutornull = function(frame)
    return lib.entrynull("tutor", "10")
end

z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti

z.preevonull = function(frame)
    return lib.entrynull("preevo", "7")
end

z.Preevonull, z.prevonull, z.Prevonull =
    z.preevonull, z.preevonull, z.preevonull

return z
