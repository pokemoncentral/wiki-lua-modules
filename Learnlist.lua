--[[

Creates the list of moves learned by a certain Pokémon.

Its main WikiCode interface are "level", "tm", "breed", "tutor", "preevo" and
"event", used as

{{#invoke: learnlist | level | <pokemon name> | gen = <gen> }}

where the "gen" parameter is optional and defaults to the latest generation.
This parameter doesn't exactly specify the generation, but the set of games
for the learnlist. For instance, a possible value is "LGPE" because these games
have a learnlist on their own. It should be an index of l.nogameText

Also the Pokémon name is optional and defaults to the page's name.
A typical usage is

{{#invoke: learnlist | level }}

in a Pokémon's page in order to build the list of moves it learns in the latest
generation.

-- ============================================================================

Some useful informations for developers:
    - notes are needed only for breed and preevo
    - except for level and tm, other methods has exactly one line per move.
      A move can be learned at multiple levels, and a tm or hm with a move can
      change within a generation (es: spaccaroccia)

--]]

local l = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local lib = require('Wikilib-learnlists')
local genlib = require('Wikilib-gens')
local multigen = require('Wikilib-multigen')
local wlib = require('Wikilib')
local links = require('Links')
local ms = require('MiniSprite')
local hf = require('Learnlist-hf')
local sup = require("Sup-data")
-- local pokemoves = require("PokéMoves-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local gendata = require("Gens-data")
local mtdata = require("Machines-data")


local STRINGS = {
    evolevelstr = 'Evo<span class="hidden-xs">luzione</span>',
    tmcell = [=[
| class="black-text" style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} VI Sprite Zaino.png]]</span>[[${p1}]]]=],
    breedcell = [=[
| style="padding: 0.1em 0.3em;" | ${p}]=],
}

--[[

TODO: select entry building function depending on gen (eg: gen 1 -> no category,
gen 4 -> contest entry)

Build the string corresponding to the last part of an entry, that is the part
without the learning method (levels for level entry, parents for breed entry,
etc.).

Arguments:
    - poke: Pokémon name or ndex
    - mossa: move name
    - notes: any note that should be added to this entry
    - gen: (optional) gen of the entry. Defaults to latest

--]]
l.entrytail = function(poke, mossa, notes, gen)
    local data = multigen.getgen(moves[mossa], gen)
    local stab = lib.computeSTAB(poke, mossa, nil, gen)
    return lib.categoryentry(stab, data.name, notes, string.fu(data.type),
                             string.fu(data.category), data.power,
                             data.accuracy, data.pp)
end

--[[

Add header and footer for a learnlist table.
Arguments:
    - str: body of the learnlist, to enclose between header and footer
    - poke: Pokémon name or ndex
    - gen: the generation of this entry
    - kind: kind of entry. Either "level", "tm", "breed", "tutor", "preevo" and
            "event".

--]]
l.addhf = function(str, poke, gen, kind)
    local pokedata = multigen.getGen(pokes[poke], gen)
    local hfargs = { pokedata.name, pokedata.type1, pokedata.type2, gen,
                     genlib.getGen.ndex(pokedata.ndex) }
    return table.concat({
        hf[kind .. "h"]{ args = hfargs },
        str,
        hf[kind .. "f"]{ args = hfargs },
    }, "\n")
end

--[[

General function to build an entry. Requires some functions in funcDict to
determine details of the entry.
Oop isn't used because there's no inheritance.

Arguments:
    - poke: Pokémon name or ndex
    - gen: the generation of this entry
    - kind: kind of entry. Either "level", "tm", "breed", "tutor", "preevo" and
            "event". Also used to select functions (picks the funcDict)

This function makes use of a dictionary of function, retrieved using "kind", to
implement details of the entry. It should contain the following functions:
    - processData: given a single value of pokemoves[poke][kind][gen]
                   transform it in a format more suitable for sorting and
                   printing. It is mapped over that table with dataMap.
                   Takes four arguments:
                    - poke: Pokémon name or ndex
                    - gen: the generation of this entry
                    - value: the value of pokemoves[poke][kind][gen][key]
                    - key: the key of that value
                   It should return an array of elements that will be sorted
                   and printed using other functions in the dict.
    - dataMap: the kind of map used to map processData over the collection.
               Often table.flatMapToNum or table.mapToNum
    - lt: given two elements produced by processData, compares them
          Takes two arguments, the two elements to compare.
    - makeEntry: create the string of an entry from an element produced by
                 processData.
                 Takes three arguments:
                    - poke: Pokémon name or ndex
                    - gen: the generation of this entry
                    - entry: the element produced by processData

--]]
l.entryLua = function(poke, gen, kind)
    local funcDict = l.dicts[kind]

    local res = {}
    local pmkind = lib.pokemoves[poke][kind]
    if pmkind and pmkind[gen] then
        res = funcDict.dataMap(pmkind[gen],
            function(v, k) return funcDict.processData(poke, gen, v, k) end)
    end
    local resstr
    if #res == 0 then
        resstr = lib.entrynull(kind, "100")
    else
        table.sort(res, funcDict.lt)
        resstr = wlib.mapAndConcat(res, "\n", function(val)
            return funcDict.makeEntry(poke, gen, val)
        end)
    end

    return l.addhf(resstr, poke, gen, kind)
end

l.dicts = {}

--[[

Given a frame for learnlist returns the two parameters poke and gen, in this
order.

--]]
l.getParams = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local gen = tonumber(p.gen) or gendata.latest
    local poke = string.lower(p[1] or mw.title.getCurrentTitle().baseText)
    return poke, gen
end

--[[

Adds main lua and WikiCode interfaces for a kind of entries.
Arguments:
    - kind: the kind of entry

Lua interfaces take two arguments, poke and gen.
WikiCode interfaces are described in the initial comment.

--]]
local addInterfaces = function(kind)
    l[kind .. "Lua"] = function(poke, gen)
        return l.entryLua(poke, gen, kind)
    end

    l[kind] = function(frame)
        local poke, gen = l.getParams(frame)
        return l.entryLua(poke, gen, kind)
    end
    l[string.fu(kind)] = l[kind]
end


-- ================================== Level ==================================
--[[

This table hold texts used when a Pokémon can't learn a move in a game. It is
guaranteed to have the very same structure as pokemoves.games.level

--]]
l.nogameText = {
    [1] = {
        "Disponibile solo in Giallo",
        "Disponibile solo in Rosso e Blu"
    },
    [2] = {
        "Disponibile solo in Cristallo",
        "Disponibile solo in Oro e Argento"
    },
    [3] = {
        "Non disponibile in Rubino e Zaffiro",
        "Non disponibile in Rosso Fuoco e Verde Foglia",
        "Non disponibile in Smeraldo"
    },
    [4] = {
        "Non disponibile in Diamante e Perla",
        "Non disponibile in Platino",
        "Non disponibile in Oro HeartGold e Argento SoulSilver"
    },
    [5] = {
        "Disponibile solo in Nero 2 e Bianco 2",
        "Disponibile solo in Nero e Bianco"
    },
    [6] = {
        "Disponibile solo in Rubino Omega e Zaffiro Alpha",
        "Disponibile solo in X e Y"
    },
    [7] = {
        "Disponibile solo in Ultrasole e Ultraluna",
        "Disponibile solo in Sole e Luna"
    },
    [8] = {
        "",
    }
}

--[[

Creates and entry of a level learnlist.

Arguments:
    - poke: Pokémon name or ndex
    - gen: set of game for this entry. Should be an index of
           pokemoves.games.level
    - move: move name
    - levels: the set of levels to print. It should be in the following format:
        an array, of the same length ad pokemoves.games.level[gen], with each
        element being either a level (a number, "inizio" or "evo") or false,
        meaning that the Pokémon can't learn the move in that game

--]]
l.levelEntry = function(poke, gen, move, levels)
    levels = table.map(l.nogameText[gen], function(text, idx)
        local lvl = levels[idx]
        if not lvl then
            return links.tt('&mdash;', text)
        elseif lvl == "evo" then
            return STRINGS.evolevelstr
        else
            return string.fu(lvl)
        end
    end)
    return table.concat{
        '|-\n',
        lib.gameslevel(unpack(levels)),
        l.entrytail(poke, move, '', gen),
    }
end

-- Compares two levels (a number, "inizio", "evo" or nil). The order is
-- "inizio" < "evo" < numbers < nil
l.ltLevel = function(a, b)
    if b == "inizio" then
        return false
    elseif b == "evo" and a ~= "inizio" then
        return false
    elseif b == nil then
        return a ~= nil
    elseif (type(a) == "number" and a >= b) or a == nil then -- b is a number
        return false
    end
    return true
end

--[[

Comparator for levels. Given two levels tables, that are two arrays of the same
length with each element being either a level (a number, "inizio" or "evo") or
false, it returns true iff a <= b.

Sorting is lexicographic on levels, replacing false with the first subsequent
non-false value.

TODO: make this function more efficient

--]]
l.ltLevelarr = function(a, b)
    for k, v in ipairs(a[2]) do
        local aval, k1 = v, k
        -- Can't use (not aval) because that is true also for nil
        while aval == false do
            k1 = k1 + 1
            aval = a[2][k1]
        end
        local bval, k2 = b[2][k], k
        while bval == false do
            k2 = k2 + 1
            bval = b[2][k2]
        end
        if l.ltLevel(aval, bval) then
            return true
        elseif aval ~= bval then -- if they aren't equale then bval > aval
            return false
        end
    end
    -- here aval == bval at any iteration => equality => check name
    return a[1] < b[1]
end

l.dicts.level = {
    processData = function(_, _, levels, move)
        -- levels = { {"inizio"}, {"inizio", "evo"} },
        local alllevels = table.unique(table.flatten(levels))
        return table.map(alllevels, function(lvl)
            return { move, table.map(levels, function(t)
                return table.search(t, lvl) and lvl or false
            end) }
        end)
    end,
    dataMap = table.flatMapToNum,
    -- elements of res are like
    -- {
    --     <movename>,
    --    { <level of first game or false>, <level of second game or false>, ... },
    -- }
    lt = l.ltLevelarr,
    makeEntry = function(poke, gen, val)
        return l.levelEntry(poke, gen, unpack(val))
    end,
}

addInterfaces("level")

-- ==================================== Tm ====================================
--[[

Creates an entries of a tm learnlist.

Arguments:
    - poke: Pokémon name or ndex
    - gen: generation for this entry
    - move: move name, all lowercase
    - tmnum: tm or hm number. Is a pair { "M[TN]", "<number>" }
    - games: (optional) the abbr of a game, that is put as a note in sup

--]]
l.tmEntry = function(poke, gen, move, tmnum, games)
    local tmcell = string.interp(STRINGS.tmcell, {
        img = tmnum[1],
        p1 = table.concat(tmnum),
        tipo = string.fu(multigen.getGenValue(moves[move].type, gen))
               or 'Sconosciuto'
    })
    return table.concat{
        '|-\n',
        tmcell,
        l.entrytail(poke, move, sup[games:upper()] or "", gen),
    }
end

--[[

Comparator for two tm/hm pairs.

--]]
l.ltTm = function(a, b)
    return a[1] > b[1] or (a[1] == b[1] and tonumber(a[2]) < tonumber(b[2]))
end

l.dicts.tm = {
    processData = function(_, gen, move)
        return table.mapToNum(mtdata[gen], function(tmdata, tmkind)
            local tmnum, i = table.deepSearch(tmdata, move)
            if tmnum then
                local tmnums = string.nFigures(tmnum, 2)
                if i then
                    return { move, { tmkind, tmnums }, tmdata[tmnum][i][1] }
                else
                    return { move, { tmkind, tmnums }, "" }
                end
            end
            -- Needed because otherwise the function returns 0 values and
            -- table.insert complains (there's no automatic addition of nils)
            return nil
        end)
    end,
    dataMap = table.flatMapToNum,
    -- elements of res are like
    -- { <movename>, { "M[TN]", "12"}, <games abbr> }
    lt = function(a, b)
        return l.ltTm(a[2], b[2])
    end,
    makeEntry = function(poke, gen, val)
        return l.tmEntry(poke, gen, unpack(val))
    end,
}

-- Added by hand to handle the special case with all tms
l.tmLua = function(poke, gen)
    if lib.pokemoves[poke].tm[gen].all then
        return l.addhf(hf.alltm{args={poke, gen, "tm"}}, poke, gen, "tm")
    end
    return l.entryLua(poke, gen, "tm")
end

l.tm = function(frame)
    return l.tmLua(l.getParams(frame))
end
l.Tm = l.tm
-- addInterfaces("tm")

-- ================================== Breed ==================================
l.dicts.breed = {
    processData = function(_, gen, movedata, move)
        --Bulba style: in a Pokémon page it prints parents for the latest game
        local parents = lib.moveParentsGame(movedata,
                        lib.games.breed[gen][#lib.games.breed[gen]])

        local notes = lib.breednotes(gen, move, parents[1], movedata.notes)
        local res = { move, parents[1] and parents or { 000 },
                      notes == "" and "" or links.tt("*", string.fu(notes))
                    }
        if movedata.games then
            res[3] = wlib.mapAndConcat(movedata.games,
                                       function(s) return sup[s] end)
                     .. res[3]
        end
        return res
    end,
    dataMap = table.mapToNum,
    -- elements of res are like
    -- { <movename>, { <array of parents> }, <notes> }
    lt = function(a, b)
        return a[1] < b[1]
    end,
    makeEntry = function(poke, gen, val)
        local firstcell = string.interp(STRINGS.breedcell, {
            p = lib.msarrayToModal(val[2], gen, nil, 6),
        })
        return table.concat{
            '|-\n',
            firstcell,
            l.entrytail(poke, val[1], val[3], gen),
        }
    end,
}

addInterfaces("breed")

-- ================================== Tutor ==================================
l.dicts.tutor = {
    processData = function(_, gen, games, move)
        return {
            move,
            table.zip(lib.games.tutor[gen], games, function(a, b)
                return { a, b and "Yes" or "No" }
            end)
        }
    end,
    dataMap = table.mapToNum,
    -- elements of res are like
    -- { <movename>, { <array of games pairs { <abbr>, "Yes"/"No" }> } }
    lt = function(a, b)
        for k, v in ipairs(a[2]) do
            if v[2] ~= b[2][k][2] then
                -- Equivalent to v[2] < b[2][k][2]
                return v[2] == "Yes"
            end
        end
        return a[1] < b[1]
    end,
    makeEntry = function(poke, _, val)
        return table.concat{
            '|-\n',
            lib.tutorgames(val[2]),
            l.entrytail(poke, val[1], "", gen),
        }
    end,
}

addInterfaces("tutor")

-- ================================== Preevo ==================================
l.dicts.preevo = {
    processData = function(_, _, preevos, move)
        return { move, table.map(preevos, function(ndex)
            return { ndex, "" }
        end, ipairs), games = preevos.games }
    end,
    dataMap = table.mapToNum,
    -- elements of res are like
    -- { <movename>, { <array of preevo pairs: { ndex, notes }> } }
    lt = function(a, b)
        return a[1] < b[1]
    end,
    makeEntry = function(poke, gen, val)
        local firstcell = wlib.mapAndConcat(val[2], function(pair)
            return ms.staticLua(string.tf(pair[1] or "000"), gen or "")
                   .. (lib.preevott[pair[2]] or "")
        end)
        local notes = val.games
                      and wlib.mapAndConcat(val.games, function(s) return sup[s] end)
                      or ""
        return table.concat{
            "|-\n| ",
            firstcell,
            l.entrytail(poke, val[1], notes, gen),
        }
    end,
}

addInterfaces("preevo")

-- ================================== Event ==================================
l.dicts.event = {
    processData = function(_, _, occasion, move)
        return { move, occasion }
    end,
    dataMap = table.mapToNum,
    -- elements of res are like
    -- { <movename>, <occasion> }
    lt = function(a, b)
        return a[1] < b[1]
    end,
    makeEntry = function(poke, gen, val)
        local firstcell = string.interp(STRINGS.breedcell, {
            p = val[2],
        })
        return table.concat{
            '|-\n',
            firstcell,
            l.entrytail(poke, val[1], "", gen),
        }
    end,
}

addInterfaces("event")

-- ============================================================================
return l
