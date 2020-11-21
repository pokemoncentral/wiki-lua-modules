-- "Test cases" for PokePrecSucc

local pps = require('PokePrecSucc')
local mw = require('mw')

-- Case tested: standard PokePrecSucc
print(pps.PokePrecSucc{args={" Staraptor "}})

-- Case tested:
--      - automatic Pokémon name detection
--      - automatic subpage detection
mw.title.setTitle("Staraptor/Immagini")
print(pps.subpage{args={}})
