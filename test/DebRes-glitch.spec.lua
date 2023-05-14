-- "Test cases" for DebRes-1glitch and DebRes-2glitch

local dr1 = require("DebRes-1glitch").debRes
local dr2 = require("DebRes-2glitch").debRes

-- Something "normal" first
print(dr1({ args = { " 'M (00) " } }))
print(dr1({ args = { " Trainer (Pokémon glitch) " } }))
print(dr1({ args = { "ゥ (C1)  " } }))

-- Missingno. (aka forms)
print(dr1({ args = { "MissingNo." } }))

-- Type effectiveness
print(dr1({ args = { "▶ A" } }))

-- ============================== DebRes-2glitch ==============================
-- Standard case
print(dr2({ args = { "Unown glitch" } }))

-- Types Grinta e Grazia
print(dr2({ args = { "- (Pokémon glitch)" } }))

-- Equal multiple forms
print(dr2({ args = { "? (Pokémon glitch)" } }))
print(dr2({ args = { " ?????????? " } }))

-- Different multiple forms
print(dr2({ args = { "????? (FF)" } }))
