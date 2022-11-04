--[[

Learnlist entries for 9th gen. Below are described parameters of each kind of
entry.

NOTE: STAB is autocomputed if empty. If you want to force an empty value (eg.
because autocompting is wrong) you should use the special value "no". To
autocompute the stab the Pokémon name is taken as ROOTPAGENAME, so outside of
Pokémon (sub)pages this will result in a script error. To fix this, just force
a value for the stab in every entry.

Level entry: 1 is the move name. 2 is the STAB (if empty is autocomputed), 3
are optional notes, 4 is the level in SV

Tm entry: 1 is the move name, 2 is the STAB (if empty is autocomputed), 3 are
optional notes, 4 is the MT of the move in SV. This is autocomputed if empty,
to force empty use the value "no"

Breed entry: 1 is the list of parents, 2 is the move name, 3 is the STAB (if
empty is autocomputed), 4 to 6 are optional notes

Tutor entry: 1 is the move name. 2 is the STAB (if empty is autocomputed), 3
are optional notes, 4 is yes/no for SV

Preevo entry: 1 is the move name. 2 is the STAB (if empty is autocomputed), 2
is ndex, 3 (optional) notes of the first evolution that learn the move, 4 and 5
are the same for the second

Event entry: 1 is move name, 2 is the STAB (if empty is autocomputed), 3 are
optional notes, 4 is the event

--]]

local z = {}

local mw = require("mw")

-- stylua: ignore start
local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local multigen = require('Wikilib-multigen')
local moves = require("Move-data")
local sup = require("Sup-data")
-- stylua: ignore end

local entryGen = 9 -- This is a constant

local strings = {
    TMENTRYCELL = [=[|-
| class="black-text" style="padding: 0.1em 0.3em;" | ${content} ]=],
    TMIMGLINK = [=[<span class="hidden-xs">[[File:${kind} ${tipo} VIII Sprite Zaino.png]]</span>[[${kind}${num}]]]=],
    TMSLASH = [[&nbsp;/&nbsp;]],
    BREEDENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}',
}

-- Compute the displayed STAB from the input.
-- "move" is the move name, "stabval" is the value of stab passed to the call
local getSTAB = function(move, stabval)
    if stabval == "No" then
        return ""
    elseif stabval and stabval ~= "" then
        return stabval
    else
        return lib.computeSTAB(
            mw.title.getCurrentTitle().rootText:lower(),
            move,
            nil,
            entryGen
        )
    end
end

local entry = function(mossa, stab, notes)
    local data = multigen.getGen(moves[string.lower(mossa)], entryGen)
    return lib.categoryentry(
        getSTAB(mossa, stab),
        mossa,
        notes,
        txt.fu(data.type),
        txt.fu(data.category),
        data.power,
        data.accuracy,
        data.pp
    )
end

-- Level entry
z.level = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        "|-\n",
        lib.gameslevel(lib.makeEvoText(p[4])),
        entry(p[1] or "Geloraggio", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Level = z.level

-- MT/DT moves entry
z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local movename = p[1] or "geloraggio"

    -- Autocompute the MT/DT number for SV
    local tmkind, tmnum
    if p[4] and p[4] ~= "no" then
        tmkind, tmnum = string.match(p[4], "^([MD][TN])(%d+)")
    elseif not p[4] then
        tmkind, tmnum = lib.getTMNum(movename:lower(), entryGen, "SV")
    end

    local movetype = txt.fu(
        multigen.getGenValue(moves[string.lower(movename)].type, entryGen)
    )
    local cellcnt = txt.interp(strings.TMIMGLINK, {
        kind = tmkind,
        num = tostring(tmnum),
        tipo = movetype,
    })
    local notes = ""

    return table.concat({
        txt.interp(strings.TMENTRYCELL, { content = cellcnt }),
        entry(movename, p[2], lib.makeNotes(p[3] or notes or "")),
    })
end
z.Tm = z.tm

-- Entry per le mosse apprese tramite accoppiamento
z.breed = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        txt.interp(strings.BREEDENTRY, {
            p1 = lib.mslistToModal(p[1] or "", entryGen, nil, 6),
        }),
        entry(
            p[2] or "Lanciafiamme",
            p[3],
            lib.makeNotes(
                p[4] or "",
                lib.makeNotes(p[5] or "", lib.makeNotes(p[6] or ""))
            )
        ),
    })
end
z.Breed = z.breed

-- Entry per le mosse apprese tramite esperto mosse
z.tutor = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.tutorgames({ { "SV", p[4] } }),
        " ",
        entry(p[1] or "Tuono", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti
z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.autopreevo(p, 3, entryGen),
        " ",
        entry(p[1] or "Bora", p[2], ""),
    })
end
z.Preevo, z.prevo, z.Prevo = z.preevo, z.preevo, z.preevo

-- Entry per le mosse apprese tramite eventi
z.event = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        txt.interp(strings.BREEDENTRY, {
            p1 = p[4] or "Evento",
        }),
        entry(p[1] or "Bora", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello
z.levelnull = function(_)
    return lib.entrynull("level", 7)
end
z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN
z.tmnull = function(_)
    return lib.entrynull("tm", 7)
end
z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento
z.breednull = function(_)
    return lib.entrynull("breed", 7)
end
z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse
z.tutornull = function(_)
    return lib.entrynull("tutor", 7)
end
z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti
z.preevonull = function(_)
    return lib.entrynull("preevo", 7)
end
z.Preevonull, z.prevonull, z.Prevonull =
    z.preevonull, z.preevonull, z.preevonull

return z
