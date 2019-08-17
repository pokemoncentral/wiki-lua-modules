--[[

Creates the list of moves learned by a certain Pokémon.

Its main WikiCode interface is "learnlist", used as

{{#invoke: learnlist | learnlist | <pokemon name> | gen = <gen> }}

where the "gen" parameter is optional and defaults to the latest generation.
Also the Pokémon name is optional and defaults to the page's name.
A typical usage is

{{#invoke: learnlist | learnlist }}

in a Pokémon's page in order to build the list of moves it learns in the latest
generation.

--]]

local l = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
-- local form = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local lib = require('Wikilib-learnlists')
-- local w = require('Wikilib')
local links = require('Links')
-- local ms = require('MiniSprite')
local css = require('Css')
local hf = require('Learnlist-hf')
-- local c = require("Colore-data")
-- local altforms = require("AltForms-data")
-- local useless = require("UselessForms-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local pokemoves = require("PokéMoves-data")
local gendata = require("Gens-data")

local evostr = 'Evo<span class="hidden-xs">luzione</span>'

l.entry = function(poke, mossa, notes)
    local data = moves[mossa]
    local stab = lib.computeSTAB(poke, mossa)
    return lib.categoryentry(stab, data.name, notes, string.fu(data.type),
                             string.fu(data.category), data.power,
                             data.accuracy, data.pp)
end

l.getParams = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
    local gen = p.gen or gendata.latest
    local poke = string.lower(p[1] or mw.title.getCurrentTitle().text)
    return poke, gen
end

-- ================================== Level ==================================
l.levelEntry = function(poke, gen, levels, move, notes)
    levels = table.map(levels, function(lvl)
        if lvl == "evo" then
            return evostr
        else
            return string.fu(lvl)
        end
    end)
    return table.concat{'|-\n', lib.gameslevel(
            levels[1] or links.tt('&mdash;', 'Disponibile solo in Ultrasole e Ultraluna'),
            levels[2] or links.tt('&mdash;', 'Disponibile solo in Sole e Luna')
        ),
        l.entry(poke, move, lib.makeNotes(notes or ''))
    }
end

--[[

Creates the table of moves learned by level.
Both parameters are mandatory.

--]]
l.levelLua = function(poke, gen)
	local res = table.flatMap(pokemoves[poke][tonumber(gen) or gen], function(levels, move)
        -- ["zuffa"] = { {"inizio"}, {"inizio", "evo"} },
        local alllevels = table.unique(table.flatten(levels))
        return table.map(alllevels, function(lvl)
            return { move, table.map(levels, function(t)
                return table.search(t, lvl) and lvl or nil
            end) }
        end)
    end)
    -- elements of res are like
    -- { <movename>, {
    --     { <level of first game or nil> },
    --     { <level of second game or nil> }, ... }
    -- }
    table.sort(res, function(a, b)
        -- TODO: choose the order (something like lexicographic on levels, then
        -- on move names)
        return a[1] < b[1]
    end)
    res = table.map(res, function(val)
        return l.levelEntry(poke, gen, val[2], val[1], "")
    end)
    local pokedata = pokes[poke]
    local hfargs = {pokedata.name, pokedata.type1, pokedata.type2, gen, gen}
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
