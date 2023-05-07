-- "Test cases" for Sup

local sup = require("Sup")

-- A very long one
local solid = sup.OACRFVFHGSS({ args = {} })
print(solid)

-- The very long one, but split
local split = sup.OA({ args = { "C RFVF", "HGSS" } })
print(split)

-- Syntax equivalence

assert(solid == split, "syntax mismatch")

-- No color specified

local noColor = sup.LGPE({ args = {} })
print(noColor)

-- _abbr function
local abbr = sup._abbr({ args = { "RBG RFVF", "LGPE" } })
print(abbr)
