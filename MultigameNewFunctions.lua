--[[

This file is NOT meant to be a module. It's just a collection of functions and
data that I don't know where to put yet, during developement. Probably this
will be split in a data module, a new Wikilib module and/or Wikilib-multigen.

Quindi proverei a tenere la cosa attuale di scrivere i dati solo quando
cambiano, solo che per gioco invece che per gen, e aggiungere i moduli per dire
"cose che non esistono nei vari giochi", e poi Wikilib-multigen si smazza tutto

--]]

local p = {}

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local wdata = require("Wikilib-data")
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
        -- Here type(idx) is assumed "string", because it should be a game
        return idx
    end
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

We use an entry for game, listing ndexes (FORMS INCLUDED) of Pokémon that are
in that game. It could be useful also a function for each game that, given an
ndex return true iff the ndex exists in that game.

Rationale: when you need a single check "Poké x is in game y" is fast in both
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
    lgpe = function(ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return ndex and (ndex == 808 or ndex == 809 or ndex <= 151)
    end,
    spsc = function(ndex)
        return table.search(p.pokepresence.spsc, ndex) and true
    end,
    dlps = function(ndex)
        if type(ndex) ~= "number" then
            ndex = pokes[ndex] and pokes[ndex].ndex
        end
        return ndex and (ndex <= 493)
    end,
    lpa = function(ndex)
        return table.search(p.pokepresence.lpa, ndex) and true
    end,
}

-- ===========================================================================
-- =========================== Getter functions ==============================
-- ===========================================================================

--[[

Generic getter function for some data.

--]]

return p
