-- "Test cases" for Statlist

local s = require("Statlist-unique")

print(s.statlistUnique({ args = {} }))

print(s.statlistUnique({ args = { 3 } }))
