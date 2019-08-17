--[[

Data module for moves learning.

For each Pokémon there's a table that contains a table for each "generation"
(actually for each group of games that shares the same table, that can be less
than a whole generation, for instance LGPE are separated from SLUSUL).
In those tables indexes are move names, that are associated to a list of
levels, representing levels at which the Pokémon learns the move in the
corresponding game. The ordering of games is given in the table "games". A
level can be a number, "inizio" or "evo".

--]]

local m = {}

m.games = {
    [7] = { "SL", "USUL" },
    LGPE = { "LGPE" },
}

m.staraptor = {
    [7] = {
        ["zuffa"] = { {"inizio"}, {"inizio", "evo"} },
        ["attacco rapido"] = { {"inizio", 5}, {"inizio", 5} },
        ["geyser fotonico"] = { {}, {50} },
        doppioteam = { {13}, {13} },

        -- inizio = {"attacco d'ala", "attacco rapido", "azione", "ruggito", "zuffa"},
        -- evo = "zuffa",
        -- [5] = "attacco rapido",
        -- [9] = "attacco d'ala",
        -- [13] = "doppioteam",
        -- [18] = "rimonta",
        -- [23] = "turbine",
        -- [28] = "aeroassalto",
        -- [33] = "riduttore",
        -- [41] = "agilità",
        -- [49] = "baldeali",
        -- [57] = "azzardo"
    },
    LGPE = {},
}
m[398] = m.staraptor

return m
