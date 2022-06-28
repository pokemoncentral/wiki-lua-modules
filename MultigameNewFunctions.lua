--[[

This file is NOT meant to be a module. It's just a collection of functions and
data that I don't know where to put yet, during developement. Probably this
will be split in a data module, a new Wikilib module and/or Wikilib-multigen.

Quindi proverei a tenere la cosa attuale di scrivere i dati solo quando
cambiano, solo che per gioco invece che per gen, e aggiungere i moduli per dire
"cose che non esistono nei vari giochi", e poi Wikilib-multigen si smazza
tutto. Questo vuol dire che le chiamate non possono passare solo la tabella con
i dati, ma devono anche dire da dove proviene, così che Wikilib-multigen possa
fare i controlli incorciati se quell'info compare in quel gioco.

--]]

local p = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local wdata = require("Wikilib-data")
local wgens = require("Wikilib-gens")
local gendata = require("Gens-data")
local altforms = require("AltForms-data")
local pokes = require("Poké-data")

--[[

Given a generation, returns the first game in that generation. On a game name,
it is the identity.

This function is used to convert from generation changing values to the new
game changing format. IT IS ONLY MEANT FOR TEMPORARY USE IN THE INITIAL
DEVELOPEMENT STAGE BEFORE FULL CONVERSION OF DATA MODULES.

--]]
p.togame = function(idx)
    if type(idx) == "number" then
        return gendata[idx].games[1]
    else
        assert(type(idx) == "string") -- it should be a game
        return idx
    end
end

--[[

Given a data table using gen keys, convert it to the new format using games

IT IS ONLY MEANT FOR TEMPORARY USE IN THE INITIAL DEVELOPEMENT STAGE BEFORE
FULL CONVERSION OF DATA MODULES.

--]]
p.updateDataTable = function(data)
    if type(data) ~= "table" then
        return data
    end
    local newdata = {}
    for k, v in pairs(data) do
        newdata[p.togame(k)] = v
    end
    return newdata
end

--[[

Data module for the absence of various kind of informations in a game.

--]]
p.fieldabsence = {
    lgpe = { 'abil' },
    lpa = { 'abil' },
}

--[[

Data module for the presence of Pokémon in a game.

We use an entry for game, listing ndexes (forms included) of Pokémon that are
in that game. It could be useful also a function for each game that, given an
ndex return true iff the ndex exists in that game.

Rationale: when you need a single check "Poké x is in game y" it's fast in both
ways. The issue is for mass queries, and pages with Pokémon lists are much
heavier than ones with games lists. Moreover, our solution takes less memory.

PROs of our indexing:
- fast listing of all Pokémon in a game
- less memory occupancy (a table per game vs a table per Pokémon)

PROs of the transpose:
- fast check of presence

--]]
p.pokepresence = {
    lgpe = { nil },
    spsc = {  },
    dlps = { nil },
    lpa = {
        025, 026, 035, 036, 037, '037A', 038, '038A', 041, 042, 046, 047, 054,
        055, '058H', '059H', 063, 064, 065, 066, 067, 068, 072, 073, 074, 075,
        076, 077, 078, 081, 082, 092, 093, 094, 095, '100H', '101H', 108, 111,
        112, 113, 114, 122, 123, 125, 126, 129, 130, 133, 134, 135, 136, 137,
        143, 155, 156, '157H', 169, 172, 173, 175, 176, 185, 190, 193, 196,
        197, 198, 200, 201, 207, 208, '211H', 212, 214, 215, '215H', 216, 217,
        220, 221, 223, 224, 226, 233, 234, 239, 240, 242, 265, 266, 267, 268,
        269, 280, 281, 282, 299, 315, 339, 340, 355, 356, 358, 361, 362, 363,
        364, 365, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398,
        399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412,
        413, '413Sc', '413Sa', 414, 415, 416, 417, 418, 419, 420, 421, '421S',
        422, '422E', 423, '423E', 424, 425, 426, 427, 428, 429, 430, 431, 432,
        433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446,
        447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460,
        461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474,
        475, 476, 477, 478, 479, '479C', '479L', '479G', '479V', '479T', 480,
        481, 482, 483, '483O', 484, '484O', 485, 486, 487, '487O', 488, 489,
        490, 491, 492, '492C', 493, 501, 502, '503H', 548, '549H', '550Bi',
        '570H', '571H', 627, '628H', 641, '641T', 642, '642T', 645, '645T',
        700, 704, '705H', '706H', 712, '713H', 72, 723, '724H', 899, 900, 901,
        902, 903, 904, 905, '905T'
    },
}
-- Adding Arceus
for abbr, _ in pairs(altforms.arceus.names) do
    if abbr ~= 'base' then
        table.insert(p.pokepresence.lpa, '493' .. abbr)
    end
end

-- TODO: we __could__ speed these up with a binary search, but anyway.
p.isingame = {
    oa = function (ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return wgens.getGen.ndex(ndex) <= 2
    end,
    pt = function (ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return wgens.getGen.ndex(ndex) <= 4
    end,
    lgpe = function(ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return ndex and (ndex == 808 or ndex == 809 or ndex <= 151)
    end,
    spsc = function(ndex)
        return tab.search(p.pokepresence.spsc, ndex) and true
    end,
    dlps = function(ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return ndex and (ndex <= 493)
    end,
    lpa = function(ndex)
        return tab.search(p.pokepresence.lpa, ndex) and true
    end,
}

-- ===========================================================================
-- =========================== Getter functions ==============================
-- ===========================================================================
--[[

Getter logic:
(1) check whether poke is in game
(2) check whether data is in game
(3) use the old multigen approach to get the latest previous value

All getters return nil if either the Pokémon or the field is not in the game.

--]]

-- It would be so awesome, it would be so cool to define an iterator for this.
--[[

Stateless iterator on game keys in reverse chronological order, starting from a
given game.

Internally, the iterator keeps the index of the game in wdata.gamesChron

TODO: test this shit, maybe it doesn't work

--]]
-- local prevGameName = function(tab, idx)
--     local nextKey
--     repeat
--         nextKey = wdata.gamesChron[idx]
--         idx -= 1
--     until nextKey and tab[nextKey]
--     return idx, tab[nextKey]
-- end
-- l.gameNames = function(tab, startgame)
--     return prevGameName, tab, table.search(wdata.gamesChron, startgame)
-- end

--[[

Given a game and a table, return the name of the most recent game before the
given one that is a key in the table.

TODO: test this shit, maybe it doesn't work

--]]
p.prevGame = function(game, tab)
    local idx = table.search(wdata.gamesChron, game)
    local nextKey
    repeat
        if idx <= 0 then
            return nil
        end
        nextKey = wdata.gamesChron[idx]
        idx = idx - 1
    until tab[nextKey]
    return nextKey
end

--[[

Returns the value of a property in an entry for the given game. Data is the
data module entry. Poke is the Pokémon to access (key used to index the data
module). Field is the filed to access (eg. type, abil). The game defaults to
the latest.

--]]
p.getGameValue = function(data, poke, field, game)
    game = game or wgens.latest.game

    if not p.isingame[game](poke) then
        return nil
    end
    if table.search(p.fieldabsence[game] or {}, field) then
        return nil
    end

    -- Will we have data that is not a table? Probably yes
    if type(data) ~= 'table' then
        return data
    end

    return data[p.prevGame(game, data)]
end
p.getgamevalue = p.getGameValue

--[[

Extracts the value of the given game for every multi-generation property of the
provided entry.

--]]
p.getGame = function(entry, poke, field, game)
    game = game or wgens.latest.game

    local mapper

    if not p.isingame[game](poke) then
        mapper = function() return nil end
    elseif table.search(p.fieldabsence[game] or {}, field) then
        mapper = function() return nil end
    else
        mapper = function(data) return p.getGameValue(data, poke, field, game) end
    end

    return table.map(entry, mapper)
end
-- p.getgen, mg.get_gen = mg.getGen, mg.getGen

-- -- TODO from here on

-- --[[

-- Returns whether a generation span covers the
-- whole interval of generations. The span can be
-- given as two arguments or as a table having
-- the values as first and second elements.

-- --]]
-- mg.isFullGenSpan = function(first, last)
--     if type(first) == 'table' then
--         first, last = first[1], first[2]
--     end

--     return first == 1 and last == gendata.latest
-- end
-- mg.isfullgenspan, mg.is_full_gen_span = mg.isFullGenSpan, mg.isFullGenSpan

-- --[[

-- If value is passed, returns the first and the last
-- generation for which it is valid in the given entry
-- property.
-- Otherwise, it returns an array having a table for
-- every value with the following structure:
--     - val: the value itself
--     - first: the first generation the value is valid.
--     - last: the last generation the value is valid.
-- The array is ordered by first generation.

-- --]]
-- mg.getGenSpan = function(data, value)
--     if value then
--         if type(data) ~= 'table' then
--             return 1, gendata.latest
--         end

--         local last, first = gendata.latest

--         for gen = 1, gendata.latest do
--             if data[gen] == value then
--                 first = gen
--             elseif data[gen] and first then
--                 last = gen - 1
--                 break
--             end
--         end

--         return first, last

--     else
--         if type(data) ~= 'table' then
--             return {{
--                 val = data,
--                 first = 1,
--                 last = gendata.latest
--             }}
--         end

--         local spans = {}
--         for gen = 1, gendata.latest do
--             local value = data[gen]
--             if value then
--                 local first, last = mg.getGenSpan(data, value)
--                 table.insert(spans, {
--                     val = value,
--                     first = first,
--                     last = last
--                 })
--             end
--         end
--         return spans
--     end
-- end
-- mg.getgenspan, mg.get_gen_span = mg.getGenSpan, mg.getGenSpan

-- --[[

-- Returns a table with generations spans of every
-- property in the entry, including multi-generation
-- ones, which will have an extra table nesting.

-- --]]
-- mg.getGenSpans = function(entry)

--     --[[
--         Passing mg.getGenSpan directly to table.map
--         yelds wrong results, since it is always passed
--         the key in the table as the second argument.
--     --]]
--     return table.map(entry, function(data)
--         return mg.getGenSpan(data) end)
-- end
-- mg.getgenspans, mg.get_gen_spans = mg.getGenSpans, mg.getGenSpans

-- --[[

-- Returns whether the given entry has a
-- multi-generation proerty.

-- --]]
-- mg.hasMultiGen = function(entry)
--     return table.any(entry, function(data)
--         return type(data) == 'table' end)
-- end
-- mg.hasmultigen, mg.has_multi_gen = mg.hasMultiGen, mg.hasMultiGen

-- --[[

-- Returns the first generation of a multigen property. If the given
-- property isn't multigen, returns nil.

-- --]]
-- mg.getFirstGen = function(data)
--     if type(data) ~= 'table' then
--         return nil
--     end

--     local g = 1
--     while not data[g] do
--         g = g + 1
--     end
--     return g
-- end
-- mg.getfirstgen = mg.getFirstGen

-- --[[

-- Prints a table of generation spans in the most
-- common way, that is every value on one line, with
-- relative first and last generation as superscripts.
-- The second argument is a function that returns a
-- string given the value, and defaults to tostring.
-- If there is only one span, no superscripts are
-- generated. When first and last generation are the
-- same, only one number is displayed.

-- --]]
-- mg.printSpans = function(spans, printVal)
--     printVal = printVal or tostring
--     if #spans == 1 then
--         return printVal(spans[1].val)
--     end

--     return w.mapAndConcat(spans,
--         function(data)
--             local first = gendata[data.first].roman
--             local bounds
--             if data.last ~= data.first and data.last == gendata.latest then
--                 bounds = gendata[data.first].roman .. '+'
--             else
--                 local last = gendata[data.last].roman
--                 bounds = table.concat(table.unique{first, last}, '-')
--             end
--             return string.interp('<div>${val}<sup style="padding-left: 0.3em;">${bounds}</sup></div>',
--                 {
--                     val = printVal(data.val),
--                     bounds = bounds,
--                 })
--         end)
-- end
-- mg.printspans, mg.print_spans = mg.printSpans, mg.printSpans


return p
