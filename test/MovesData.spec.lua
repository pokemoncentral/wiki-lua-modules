-- Test cases for MovesData

local movesData = require("MovesData")

-- Run a single test. The first argument is the computed value, the second is
-- the expected result.
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

-- ================================ getType ================================
-- Standard case
makeTest(movesData.getType({ args = { "Psichico" } }), "Psico")

-- Strange characters
makeTest(movesData.getType({ args = { "Attacco d'Ala" } }), "Volante")

-- ============================= getDamageCategory ============================
-- Normal cases
makeTest(movesData.getDamageCategory({ args = { "Baldeali" } }), "Fisico")
makeTest(movesData.getDamageCategory({ args = { "fortuncanto" } }), "Stato")

-- ================================ getPower ================================
-- Standard case
makeTest(movesData.getPower({ args = { "Oscurotuffo" } }), 120)

-- &mdash;
makeTest(movesData.getPower({ args = { "inondazione" } }), "&mdash;")

-- ================================ getAccuracy ===============================
-- Standard case
makeTest(movesData.getAccuracy({ args = { "dragobolide" } }), 90)

-- &mdash;
makeTest(movesData.getAccuracy({ args = { "Comete" } }), "&mdash;")

-- ================================ getPP ================================
-- Standard case
makeTest(movesData.getPP({ args = { "Supplica" } }), 25)

-- ============================================================================
print("All tests succesfull!")
