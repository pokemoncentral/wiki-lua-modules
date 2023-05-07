-- "Test cases" for Spr

local spr = require("Spr")

-- Random thing
print(spr.spr({ args = { "479L", "Platino", "shiny back", "30px" } }))

-- Old gen, without gender
print(spr.Spr({ args = { "123", "Rubino", "male back shiny" } }))

-- Female only
print(spr.Spr({ args = { "478", "xy", "male" } }))

-- Current gen
print(spr.Spr({ args = { "133", "current", "male" } }))
