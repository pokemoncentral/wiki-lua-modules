-- Dumps the exports of a lua module as JSON

package.path = table.concat({ package.path, ";../?.lua;./?.lua" })

local json = require("cjson")
local mod = require(arg[1])
print(json.encode(mod))
