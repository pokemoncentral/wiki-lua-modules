-- "Test cases" for Statlist

local lib = require("test/snapshot-lib")
local s = require("Statlist")

lib.printHeading("Statlist")
print(s.statlist())
