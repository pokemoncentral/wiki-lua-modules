-- "Test cases" for Statlist-unique

local lib = require("test/snapshot-lib")
local s = require("Statlist-unique")

lib.printHeading("Latest gen")
print(s.statlistUnique({ args = {} }))

lib.printHeading("Gen 3")
print(s.statlistUnique({ args = { 3 } }))
