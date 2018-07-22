-- "Test cases" for Colorabbrev

local ca = require('Colorabbrev')

-- A very long one
local solid = ca.OACRFVFHGSS{args={}}
print(solid)

-- The very long one, but split
local split = ca.OA{args={'C', 'RFVF', 'HGSS'}}
print(split)

-- Syntax equivalence

assert(solid == split, 'syntax mismatch')

-- No color specified

local noColor = ca.LGPE{args={}}
print(noColor)
