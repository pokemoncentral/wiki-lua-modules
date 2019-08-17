--[[

Data module for moves learning.

For each Pokémon there's a table that contains a table for each "generation"
(actually for each group of games that shares the same table, that can be less
than a whole generation, for instance LGPE are separated from SLUSUL).
In those tables indexes are move names, that are associated to a list of
levels, representing levels at which the Pokémon learns the move in the
corresponding game. The ordering of games is given in the table "games". A
level can be a number, "inizio" or "evo".

So for instance the table

{"inizio"}, {"inizio", "evo"}

corresponding to gen 7 means that the Pokémon learns that move at level
"inizio" in SL (first element of games["7"]) and both at level "inizio" and
"evo" in USUL (second element of games["7"]).

TODO: something for notes. Inquire: are notes associated with moves or the pair
      (move, level)?
TODO: inquire: for other kind of learnlist (tm, breed, etc.) are there moves
      with more than one "level"?

--]]

local m = {}

m.games = {
    ["7"] = { "SL", "USUL" },
    LGPE = { "LGPE" },
}

m.staraptor = {
    ["7"] = {
        ["zuffa"] = { {"inizio"}, {"inizio", "evo"} },
        ["attacco rapido"] = { {"inizio", 5}, {"inizio", 5} },
        ["geyser fotonico"] = { {}, {50} },
        doppioteam = { {13}, {13} },
    },
    LGPE = {},
}
m[398] = m.staraptor

return m
