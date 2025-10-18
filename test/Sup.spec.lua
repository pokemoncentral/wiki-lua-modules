-- "Test cases" for Sup

local lib = require("test/snapshot-lib")
local sup = require("Sup")

lib.printHeading("A very long one")
local solid = sup.OACRFVFHGSS({ args = {} })
print(solid)

lib.printHeading("The very long one, but split")
local split = sup.OA({ args = { "C RFVF", "HGSS" } })
print(split)

-- Syntax equivalence

assert(solid == split, "syntax mismatch")

lib.printHeading("No color specified")
print(sup.LGPE({ args = {} }))

lib.printHeading("_abbr function")
print(sup._abbr({ args = { "RBG RFVF", "LGPE" } }))
