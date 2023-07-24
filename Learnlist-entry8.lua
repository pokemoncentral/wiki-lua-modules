--[[

Learnlist entries for 8th gen.
Below are described parameters of each kind of entry.

NOTE: STAB is autocomputed if empty. If you want to force an empty value (eg.
because autocompting is wrong) you should use the special value "no". To
autocompute the stab the Pokémon name is taken as ROOTPAGENAME, so outside of
Pokémon (sub)pages this will result in a script error. To fix this, just force
a value for the stab in every entry.

Level entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the level in SpSc, 5 is the level
in BDSP

Tm entry:
1 is the move name, 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the MT of the move in SpSc, 5 is
the MT of the move in DLPS. Both are autocomputed if empty, to
force empty use the value "no"

Breed entry:
1 is the list of parents, 2 is the move name, 3 is the STAB
(if empty is autocomputed), 4 to 6 are optional notes

Tutor entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is yes/no for SpSc, 5 is yes/no for IA
6 is yes/no for DLPS

Preevo entry:
1 is the move name. 2 is the STAB (if empty is autocomputed),
2 is ndex, 3 (optional) notes of the first evolution that learn the move,
4 and 5 are the same for the second

Event entry:
1 is move name, 2 is the STAB (if empty is autocomputed),
3 are optional notes, 4 is the event

--]]

local z = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local multigen = require('Wikilib-multigen')
local moves = require("Move-data")
local sup = require("Sup-data")
-- stylua: ignore end

local strings = {
    TMENTRYCELL = [=[|-
| class="black-text" style="padding: 0.1em 0.3em;" | ${content} ]=],
    TMIMGLINK = [=[<span class="hidden-xs">[[File:${kind} ${tipo} VIII Sprite Zaino.png]]</span>[[${kind}${num}]]]=],
    TMSLASH = [[&nbsp;/&nbsp;]],
    BREEDENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}',
    -- EVENTENTRY = '|-\n| style="padding: 0.1em 0.3em;" | ${p1}${p10}',
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
            8
        )
    end
end

local entry = function(mossa, stab, notes)
    local data = multigen.getGen(moves[string.lower(mossa)])
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
        lib.gameslevel(lib.makeEvoText(p[4]), lib.makeEvoText(p[5])),
        entry(p[1] or "Geloraggio", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Level = z.level

-- MT/DT moves entry
z.tm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local movename = p[1] or "geloraggio"

    -- Autocompute the MT/DT number for both SpSc and DLPS
    local tmkind1, tmnum1
    if p[4] and p[4] ~= "no" then
        tmkind1, tmnum1 = string.match(p[4], "^([MD][TN])(%d+)")
    elseif not p[4] then
        tmkind1, tmnum1 = lib.getTMNum(movename:lower(), 8, "SpSc")
    end
    local tmkind2, tmnum2
    if p[5] and p[5] ~= "no" then
        tmkind2, tmnum2 = string.match(p[5], "^([MD][TN])(%d+)")
    elseif not p[5] then
        tmkind2, tmnum2 = lib.getTMNum(movename:lower(), 8, "DLPS")
    end

    local movetype =
        txt.fu(multigen.getGenValue(moves[string.lower(movename)].type, 8))
    local cellcnt, notes
    if tmkind1 == tmkind2 and tmnum1 == tmnum2 then
        -- Same MT in both games
        cellcnt = txt.interp(strings.TMIMGLINK, {
            kind = tmkind1,
            num = tostring(tmnum1),
            tipo = movetype,
        })
        notes = ""
    elseif not tmkind1 or not tmkind2 then
        -- MT only in one game
        notes = tmkind1 and "SpSc" or "DLPS"
        local tmkind = tmkind1 or tmkind2
        local tmnum = tmnum1 or tmnum2
        cellcnt = txt.interp(strings.TMIMGLINK, {
            kind = tmkind,
            num = tostring(tmnum),
            tipo = movetype,
        }) .. sup[notes]
    else
        -- MT in both games, but different numbers
        local tm1str = txt.interp(strings.TMIMGLINK, {
            kind = tmkind1,
            num = tostring(tmnum1),
            tipo = movetype,
        }) .. sup.SpSc
        local tm2str = txt.interp(strings.TMIMGLINK, {
            kind = tmkind2,
            num = tostring(tmnum2),
            tipo = movetype,
        }) .. sup.DLPS
        cellcnt = table.concat({ tm1str, strings.TMSLASH, tm2str })
    end

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
            p1 = lib.mslistToModal(p[1] or "", "8", nil, 6),
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
        lib.tutorgames({ { "SpSc", p[4] }, { "IA", p[5] }, { "DLPS", p[6] } }),
        " ",
        entry(p[1] or "Tuono", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Tutor = z.tutor

-- Entry per le mosse apprese tramite evoluzioni precedenti
z.preevo = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    return table.concat({
        lib.autopreevo(p, 3, "8"),
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
            -- p10 = lib.makeLevel(p[5]),
        }),
        entry(p[1] or "Bora", p[2], lib.makeNotes(p[3] or "")),
    })
end
z.Event = z.event

-- Entry per i Pokémon che non imparano mosse aumentando di livello
z.levelnull = function(_)
    return lib.entrynull("level", "11")
end
z.Levelnull = z.levenull

-- Entry per i Pokémon che non imparano mosse tramite MT/MN
z.tmnull = function(_)
    return lib.entrynull("tm", "11")
end
z.Tmnull = z.tmnull

-- Entry per i Pokémon che non imparano mosse tramite accoppiamento
z.breednull = function(_)
    return lib.entrynull("breed", "10")
end
z.Breednull = z.breednull

-- Entry per i Pokémon che non imparano mosse dall'esperto mosse
z.tutornull = function(_)
    return lib.entrynull("tutor", "13")
end
z.Tutornull = z.tutornull

-- Entry per i Pokémon che non imparano mosse tramite evoluzioni precedenti
z.preevonull = function(_)
    return lib.entrynull("preevo", "10")
end
z.Preevonull, z.prevonull, z.Prevonull =
    z.preevonull, z.preevonull, z.preevonull

return z
