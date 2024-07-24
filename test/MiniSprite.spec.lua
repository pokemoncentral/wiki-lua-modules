-- Test cases for PokémonData

local ms = require("MiniSprite")

--[[

Run a single test. The first argument is the computed value, the second is the
expected result.

--]]
local function makeTest(actual, expected)
    if actual ~= expected then
        error(table.concat({
            'Test failed: "',
            expected,
            '" expected, but got "',
            actual or "nil",
            '"',
        }))
    end
end

makeTest(
    ms.static({ args = { " 487O " } }),
    "[[File:Minim487O.png|Giratina|40px|link=Giratina]]"
)
makeTest(
    ms.ani({ args = { " 63 ", gen = "2 " } }),
    "[[File:Ani63MS2.gif|Abra|link=Abra]]"
)
makeTest(
    ms.static({ args = { "398", gen = " 7" } }),
    "[[File:398MS7.png|Staraptor|link=Staraptor]]"
)
makeTest(
    ms.static({ args = { "398", female = "yes", shiny = " yes " } }),
    "[[File:Minifsh398.png|Staraptor|40px|link=Staraptor]]"
)
makeTest(
    ms.static({ args = { "851", game = "SpSc" } }),
    "[[File:851MSSpSc.png|Centiskorch|40px|link=Centiskorch]]"
)
makeTest(
    ms.static({ args = { "398", game = "DLPS" } }),
    "[[File:398MSDLPS.png|Staraptor|40px|link=Staraptor]]"
)
makeTest(
    ms.static({ args = { "0398", game = " LPA " } }),
    "[[File:Iconlpam0398.png|Staraptor|40px|link=Staraptor]]"
)
makeTest(
    ms.static({ args = { "398", game = " SL " } }),
    "[[File:398MS7.png|Staraptor|link=Staraptor]]"
)
makeTest(
    ms.static({ args = { "063", game = " rz " } }),
    "[[File:063MS5.png|Abra|link=Abra]]"
)

print("All tests succesfull!")
