--[[

Creates the list of moves learned by a certain Pokémon.

Its main WikiCode interface are "level", "tm", "breed", "tutor", "preevo" and
"event", used as

{{#invoke: learnlist | levellist | <pokemon name> | gen = <gen> }}

where the "gen" parameter is optional and defaults to the latest generation.
This parameter doesn't exactly specify the generation, but the set of games
for the learnlist. For instance, a possible value is "LGPE" because these games
have a learnlist on their own. It should be an index of l.nogameText

Also the Pokémon name is optional and defaults to the page's name.
A typical usage is

{{#invoke: learnlist | levellist }}

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
local pokes = require("Poké-data")
local moves = require("Move-data")
local pokemoves = require("PokéMoves-data")
local gendata = require("Gens-data")


local STRINGS = {
    evolevelstr = 'Evo<span class="hidden-xs">luzione</span>',
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

Given a frame for learnlist returns the two parameters poke and gen, in this
order.

--]]
l.getParams = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local gen = p.gen or gendata.latest
    local poke = string.lower(p[1] or mw.title.getCurrentTitle().text)
    return poke, gen
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
    - notes: any additional note for this entry

--]]
l.levelEntry = function(poke, gen, move, levels, notes)
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
        l.entrytail(poke, move, lib.makeNotes(notes or '')),
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

--[[

Creates the table of moves learned by level.
Both parameters are mandatory.

--]]
l.levelLua = function(poke, gen)
	local res = table.flatMapToNum(pokemoves[poke][tostring(gen)], function(levels, move)
        -- levels = { {"inizio"}, {"inizio", "evo"} },
        local alllevels = table.unique(table.flatten(levels))
        return table.map(alllevels, function(lvl)
            return { move, table.map(levels, function(t)
                return table.search(t, lvl) and lvl or false
            end), "" } -- TODO: add notes
        end)
    end)
    -- elements of res are like
    -- {
    --     <movename>,
    --    { <level of first game or false>, <level of second game or false>, ... },
    --     <notes>,
    -- }
    table.sort(res, function(a, b)
        return l.leLevelarr(a[2], b[2])
    end)
    res = table.map(res, function(val)
        return l.levelEntry(poke, gen, val[1], val[2], val[3] or "")
    end)
    local pokedata = pokes[poke]
    local hfargs = { pokedata.name, pokedata.type1, pokedata.type2, gen,
                     genlib.getGen.ndex(pokedata.ndex) }
    return table.concat({
        hf.levelh{ args = hfargs },
        table.concat(res, "\n"),
        hf.levelf{ args = hfargs },
    }, "\n")
end

-- WikiCode wrapper of levelLua
l.level = function(frame)
    return l.levelLua(l.getParams(frame))
end
l.Level = l.level

l.learnlist = function(frame)
    return ""
end
l.Learnlist = l.learnlist

return l
