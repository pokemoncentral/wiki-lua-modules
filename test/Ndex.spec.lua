-- "Test cases" for ndex and ndex-list

local ndex = require("Ndex")
local ndexlist = require("Ndex-list")
local nondex = require("test.LoadNondex")
nondex({ types = false })

-- Cases tested:
--      Standard
--      Standard
--      Base form (with alternative forms)
--      Alternative form
--      Useless form
-- stylua: ignore
print(ndex.list({args = { "067 398 487 487O 569Gi kubfu giratina aegislashS ", color = "alola" }}))

-- Pokémon without ndex nor types
print(ndex.list({ args = { "snorlobello", color = "hoenn" } }))

-- ndex-list: only fourth gen to have a readable list
print(ndexlist.listgen({ args = { " 8 " } }))
-- print(ndexlist.list{})

-- manualEntry
print(ndex.header({ args = { "galar" } }))
-- stylua: ignore start
print(ndex.manualEntry({args = { "urshifu", "urshifu", type1 = "lotta", type2 = "buio" }}))
print(ndex.manualEntry({args = { "urshifu", "urshifu", type1 = "lotta", type2 = "buio", form = "Gi" }}))
print(ndex.manualEntry({args = { "urshifu", "urshifu", type1 = "lotta", type2 = "acqua", form = "P" }}))
print(ndex.manualEntry({args = { "urshifu", "urshifu", type1 = "lotta", type2 = "acqua", form = "PGi" }}))
-- stylua: ignore end
print("</div>")
