-- "Test cases" for Statlist-fullevo

local lib = require("test/snapshot-lib")
local s = require("Statlist-fullevo")

lib.printHeading("Statlist-fullevo")
print(s.statlist())
