-- Test cases for GenerationsData

local testedmod = require("GenerationsData")

-- Used as oracles. This ensures that the tested module extracts the right
-- data, not correctness of data itself
local gendata = require("Gens-data")
local c = require("Colore-data")
local css = require("Css")

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

-- ================================ getLastGen ================================
makeTest(testedmod.getLastGen({ args = {} }), gendata.latest)

-- ================================ getOrdinal ===============================
makeTest(testedmod.getOrdinal({ args = { " 4 " } }), "quarta")
makeTest(testedmod.getOrdinal({ args = { " III " } }), "terza")

-- ================================ getRegion ================================
makeTest(testedmod.getRegion({ args = { " VII" } }), "alola")
makeTest(testedmod.getRegion({ args = { "1 " } }), "kanto")

-- ============================== getRegionColor ==============================
makeTest(testedmod.getRegionColor({ args = { " VI " } }), c.kalos.normale)
makeTest(testedmod.getRegionColor({ args = { "2 ", "dark" } }), c.johto.dark)

-- ============================ getRegionGradient ============================
makeTest(
    testedmod.getRegionGradient({ args = { " 5", "horizGrad" } }),
    css.horizGradLua({ type = "unima" })
)
makeTest(
    testedmod.getRegionGradient({ args = { " VIII", " radialGrad" } }),
    css.radialGradLua({ type = "galar" })
)

print("All tests succesfull!")
