--[[

Data module for moves learning.

Given that a single file is too big for PCW, this module is actually split in
many files, and this module acts as an entry points that switches calls to
the underlying real data modules.

=== MODULE STRUCTURE
This module structure is nested many times.
The returned table has Pokémon names as indexes. Each Pokémon has a table,
whose indexes are kinds ("level", "tm", "breed", "tutor", "preevo", "event").
Each of those indexes correspond to a table, indexed by gen numbers. Finally,
each generation correspond to a table with data about moves that the Pokémon
can learn in that generation via that kind. Each kind has its structure, that
is described below:

- level:
    indexes are move names, that are associated to a list of levels,
    representing levels at which the Pokémon learns the move in the
    corresponding game. The ordering of games is given in the table
    Wikilib-learnlists.games.level of that gen.
    A level can be a number, "inizio" or "evo".

    So for instance the table
        { {"inizio"}, {"inizio", "evo"} }
    corresponding to gen 7 means that the Pokémon learns that move at level
    "inizio" in SL (first element of games[7]) and both at level "inizio"
    and "evo" in USUL (second element of games[7]).

- tm:
    each table is an array of move names that the Pokémon can learn via tm in
    that gen. Do note that a Pokémon may learn a move via tm, but for some
    games of that generation the move isn't a TM (or HM) itself.

- breed:
    TODO

- tutor:
    indexes are move name, that are associated to an array of booleans as long
    as Wikilib-learnlists.games.tutor of that gen. Each boolean specify whether
    the Pokémon can learn that move in the corresponding game or not.

- preevo:
    TODO

- breed:
    I think right now it empty (event moves aren't listed in this data module)

It's safe to assume that each Pokémon has its own table (however this is not
the case for alternative forms) and that each of these has all siz kinds.
However it is not true that for each kind you can find any generation.

=== IMPLEMENTATION NOTES
Pro switch:
* Learnlist only accesses this module twice (actually four times, but
  three of them are nearby so it can be accessed once putting it in a local
  variable)
* Movepokes traverse the whole table, but I can add here a function to traverse
  the whole data module that is efficient
* Wikilib-learnlist have a few functions accessing points of this table, but
  notihng too expensive (I think)

Pro merge:
* Movelist pays this a lot because it makes some accesses to a different poke
  for each row. In small pages this would favour switch, but big pages are
  those with performances problems, and those favour the merge (maybe, I don't
  know the relative cost)

Actually merge seems as fast as switch, and it's simpler both to code and to
use, so I picked merge.

--]]

-- ========================== Switch implementation ===========================
-- local m = {}
--
-- local data0 = require("PokéMoves-data-0")
-- local data1 = require("PokéMoves-data-1")
--
-- m.__index = function(_, key)
--     local possRes = data0[key]
--     if possRes then
--         return possRes
--     else
--         return data1[key]
--     end
-- end
--
-- setmetatable(m, m)
--
-- -- Utility to iterate over all the data module
-- m.iterate = function(f)
--     for k, v in pairs(data0) do
--         f(v, k)
--     end
--     for k, v in pairs(data1) do
--         f(v, k)
--     end
-- end

-- =========================== Merge implementation ===========================
local m = require('PokéMoves-data-0')
local data1 = require('PokéMoves-data-1')

for k, v in pairs(data1) do
    m[k] = v
end

return m
