-- "Test cases" for MTCompatto

local mtc = require("MTCompatto")

print(mtc.MTCompatto({ args = { "Invertivolt" } }))
print(mtc.MTCompatto({ args = { "Cascata" } }))

print(mtc.MTGen({ args = { "4" } }))
print(mtc.MTGen({ args = { "8" } }))
