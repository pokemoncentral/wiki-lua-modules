-- "Test cases" for PokémonInfo-BoxAbil

local b = require("PokémonInfo-BoxTipi").boxTipi

-- Standard Pokémon
print(b({ args = { "Staraptor" } }))

-- Multigen
print(b({ args = { "Magneton" } }))

-- Alternative forms
print(b({ args = { "Rotom" } }))

-- Multigen and grouped alternative forms
print(b({ args = { "Gardevoir" } }))

-- Special children
print(b({ args = { "Ogerpon" } }))
