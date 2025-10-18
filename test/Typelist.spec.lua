-- "Test cases" for Typelist

local lib = require("test/snapshot-lib")
local typelist = require("Typelist").typelist

lib.printHeading("TypeList", { "Fuoco" })
print(typelist({ args = { "Fuoco" } }))

if #arg > 0 then
    -- Specific ability from command line
    print(typelist({ args = { arg[1] } }))
end
