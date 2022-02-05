-- Test cases for GenerationsData

local testedmod = require('GenerationsData')
local tests = {}

-- Used as oracles. This ensures that the tested module extracts the right
-- data, not correctness of data itself
local gendata = require("Gens-data")
local c = require("Colore-data")
local css = require("Css")

-- ================================ getLastGen ================================
-- Tests 1
table.insert(tests, { testedmod.getLastGen{args={}}, gendata.latest })

-- ================================ getOrdinal ===============================
-- Tests 2, 3
table.insert(tests, { testedmod.getOrdinal{args={' 4 '}}, "quarta" })
table.insert(tests, { testedmod.getOrdinal{args={' III '}}, "terza" })

-- ================================ getRegion ================================
-- Tests 4, 5
table.insert(tests, { testedmod.getRegion{args={' VII'}}, 'alola' })
table.insert(tests, { testedmod.getRegion{args={'1 '}}, 'kanto' })

-- ============================== getRegionColor ==============================
-- Tests 6, 7
table.insert(tests, { testedmod.getRegionColor{args={' VI '}}, c.kalos.normale })
table.insert(tests, { testedmod.getRegionColor{args={'2 ', 'dark'}}, c.johto.dark })

-- ============================ getRegionGradient ============================
-- Tests 8, 9
table.insert(tests, { testedmod.getRegionGradient{args={' 5', 'horizGrad'}}, css.horizGradLua{ type = 'unima'} })
table.insert(tests, { testedmod.getRegionGradient{args={' VIII', ' radialGrad'}}, css.radialGradLua{ type = 'galar'} })

-- ==================== Actual execution ======================
for n, v in ipairs(tests) do
    if v[1] ~= v[2] then
        print(table.concat{
            'Test ',
            tostring(n),
            ' failed: ',
            v[2],
            ' expected, but ',
            v[1],
            ' got'
        })
        return
    end
end
print('All tests succesfull!')
