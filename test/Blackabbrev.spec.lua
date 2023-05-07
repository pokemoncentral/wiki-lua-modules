-- "Test cases" for Blackabbrev

local ba = require("Blackabbrev")

-- A very long one, with both black and white text
local solid = ba.RuZaSmRFVF({ args = {} })
print(solid)

-- The very long one, but split
local split = ba.RuZa({ args = { "Sm", "RFVF" } })
print(split)

-- Syntax equivalence

assert(solid == split, "syntax mismatch")

-- No color specified

local noColor = ba.LGPE({ args = {} })
print(noColor)

-- _abbr function

local abbr = ba._abbr({ args = { "RBG RFVF LGPE" } })
print(abbr)

-- Test Ranger

local ranger1 = ba.Ra({ args = {} })
print(ranger1)

local ranger2 = ba.OSA({ args = {} })
print(ranger2)

local ranger3 = ba.TDL({ args = {} })
print(ranger3)
