-- "Test cases" for PokémonInfo-BoxAbil

local b = require("PokémonInfo-BoxAbil").boxAbil

-- Standard Pokémon
print(b({ args = { "Staraptor" } }))

-- Multigen with "nessuna"
print(b({ args = { "Sableye" } }))

-- Multigen and alternative forms
print(b({ args = { "Gengar" } }))

-- Grouped alternative forms
print(b({ args = { "Pikachu" } }))

-- Special children
print(b({ args = { "Basculin" } }))
print(b({ args = { "Greninja" } }))
print(b({ args = { "Zygarde" } }))
print(b({ args = { "Rockruff" } }))
