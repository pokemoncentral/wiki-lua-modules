-- "Test cases" for PokémonInfo-BoxAbil

local r = require("PokémonInfo-Regionaldex").regionaldex

-- Standard Pokémon, with different paddings
print(r({ args = { "64" } }))
print(r({ args = { "0079" } }))
print(r({ args = { "094" } }))
-- Not in an oldDex
print(r({ args = { "359" } }))
