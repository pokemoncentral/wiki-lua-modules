-- "Test cases" for DebRes-1glitch

local dr = require("DebRes-1-glitch").debRes

-- Something "normal" first
print(dr({ args = { " 'M (00) " } }))
print(dr({ args = { " Trainer (Pokémon glitch) " } }))
print(dr({ args = { "ゥ (C1)  " } }))

-- Missingno. (aka forms)
print(dr({ args = { "MissingNo." } }))

-- Type effectiveness
print(dr({ args = { "▶ A" } }))
