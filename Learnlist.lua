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

--]]

local l = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
-- local form = require('Wikilib-forms')
-- local multigen = require('Wikilib-multigen')
local lib = require('Wikilib-learnlists')
local genlib = require('Wikilib-gens')
-- local w = require('Wikilib')
local links = require('Links')
-- local ms = require('MiniSprite')
-- local css = require('Css')
local hf = require('Learnlist-hf')
-- local c = require("Colore-data")
-- local altforms = require("AltForms-data")
-- local useless = require("UselessForms-data")
local sup = require("Sup-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local pokemoves = require("PokéMoves-data")
local gendata = require("Gens-data")
local mtdata = require("Machines-data")


local STRINGS = {
    evolevelstr = 'Evo<span class="hidden-xs">luzione</span>',
    tmcell = [=[
| class="black-text" style="padding: 0.1em 0.3em;" | <span class="hidden-xs">[[File:${img} ${tipo} VI Sprite Zaino.png]]</span>[[${p1}]]]=],
}

--[[

Build the string corresponding to the last part of an entry, that is the part
without the learning method (levels for level entry, parents for breed entry,
etc.).

Arguments:
    - poke: Pokémon name or ndex
    - mossa: move name
    - notes: any note that should be added to this entry

--]]
l.entrytail = function(poke, mossa, notes)
    local data = moves[mossa]
    local stab = lib.computeSTAB(poke, mossa)
    return lib.categoryentry(stab, data.name, notes, string.fu(data.type),
                             string.fu(data.category), data.power,
                             data.accuracy, data.pp)
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
    - processData: given a single value of pokemoves[poke][kind][tostring(gen)]
                   transform it in a format more suitable for sorting and
                   printing. It is mapped over that table with flatMapToNum.
                   Takes four arguments:
                    - poke: Pokémon name or ndex
                    - gen: the generation of this entry
                    - value: the value of pokemoves[poke][kind][tostring(gen)]
                    - key: the key of that value
                   It should return an array of elements that will be sorted
                   and printed using other functions in the dict.
    - le: given two elements produced by processData, compares them
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

    local res = table.flatMapToNum(pokemoves[poke][kind][tostring(gen)],
            function(v, k) return funcDict.processData(poke, gen, v, k) end)
    table.sort(res, funcDict.le)
    local resstr = table.map(res, function(val)
        return funcDict.makeEntry(poke, gen, val)
    end)

    local pokedata = pokes[poke]
    local hfargs = { pokedata.name, pokedata.type1, pokedata.type2, gen,
                     genlib.getGen.ndex(pokedata.ndex) }
    return table.concat({
        hf[kind .. "h"]{ args = hfargs },
        table.concat(resstr, "\n"),
        hf[kind .. "f"]{ args = hfargs },
    }, "\n")
end

l.dicts = {}

--[[

Given a frame for learnlist returns the two parameters poke and gen, in this
order.

--]]
l.getParams = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local gen = p.gen or gendata.latest
    local poke = string.lower(p[1] or mw.title.getCurrentTitle().text)
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
        return l.entryLua(l.getParams(frame), kind)
    end
    l[string.fu(kind)] = l[kind]
end


-- ================================== Level ==================================
--[[

This table hold texts used when a Pokémon can't learn a move in a game. It is
guaranteed to have the very same structure as pokemoves.games

--]]
l.nogameText = {
    ["7"] = {
        "Disponibile solo in Ultrasole e Ultraluna",
        "Disponibile solo in Sole e Luna"
    },
    LGPE = { "" },
}

--[[

Creates and entry of a level learnlist.

Arguments:
    - poke: Pokémon name or ndex
    - gen: set of game for this entry. Should be an index of pokemoves.games
    - move: move name
    - levels: the set of levels to print. It should be in the following format:
        an array, of the same length ad pokemoves.games[gen], with each element
        being either a level (a number, "inizio" or "evo") or false, meaning
        that the Pokémon can't learn the move in that game

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
        l.entrytail(poke, move, ''),
    }
end

-- Compares two levels (a number, "inizio", "evo" or nil). The order is
-- "inizio" < "evo" < numbers < nil
l.leLevel = function(a, b)
    if a == "inizio" then
        return true
    elseif a == "evo" and b ~= "inizio" then
        return true
    elseif a == nil then
        return b == nil
    elseif (type(b) == "number" and a <= b) or b == nil then -- a is a number
        return true
    end
    return false
end

--[[

Comparator for levels. Given two levels tables, that are two arrays of the same
length with each element being either a level (a number, "inizio" or "evo") or
false, it returns true iff a <= b.

Sorting is lexicographic on levels, replacing false with the first subsequent
non-false value.

TODO: make this function more efficient

--]]
l.leLevelarr = function(a, b)
    for k, v in ipairs(a) do
        local aval, k1 = v, k
        -- Can't use (not aval) because that is true also for nil
        while aval == false do
            k1 = k1 + 1
            aval = a[k1]
        end
        local bval, k2 = b[k], k
        while bval == false do
            k2 = k2 + 1
            bval = b[k2]
        end
        if not l.leLevel(aval, bval) then
            return false
        end
    end
    return true
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
    -- elements of res are like
    -- {
    --     <movename>,
    --    { <level of first game or false>, <level of second game or false>, ... },
    -- }
    le = function(a, b)
        return l.leLevelarr(a[2], b[2])
    end,
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
    - move: move name, all lowercase
    - tmnum: tm or hm number. Is a pair { "M[TN]", "<number>" }
    - games: (optional) the abbr of a game, that is put as a note in sup

--]]
l.tmEntry = function(poke, move, tmnum, games)
    local tmcell = string.interp(STRINGS.tmcell, {
        img = tmnum[1],
        p1 = table.concat(tmnum),
        tipo = string.fu(moves[move].type) or 'Sconosciuto'
    })
    return table.concat{
        '|-\n',
        tmcell,
        l.entrytail(poke, move, sup[games:upper()] or ""),
    }
end

--[[

Comparator for two tm/hm pairs.

--]]
l.leTm = function(a, b)
    return a[1] > b[1] or (a[1] == b[1] and a[2] <= b[2])
end

l.dicts.tm = {
    processData = function(_, gen, move)
        return table.mapToNum(mtdata[tonumber(gen)], function(tmdata, tmkind)
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
    -- elements of res are like
    -- { <movename>, { "M[TN]", "12"}, <games abbr> }
    le = function(a, b)
        return l.leTm(a[2], b[2])
    end,
    makeEntry = function(poke, _, val)
        return l.tmEntry(poke, unpack(val))
    end,
}

addInterfaces("tm")

-- ============================================================================
return l
