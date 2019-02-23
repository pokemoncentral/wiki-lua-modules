-- "Test cases" for MovesData

local movesData = require('MovesData')
local tests = {}

-- ================================ getType ================================
-- Tests 1, 2
-- Standard case
table.insert(tests, { movesData.getType{args={'Psichico'}}, 'Psico' })

-- Strange characters
table.insert(tests, { movesData.getType{args={"Attacco d'Ala"}}, 'Volante' })

-- ============================= getDamageCategory ============================
-- Tests 3, 4
-- Normal cases
table.insert(tests, { movesData.getDamageCategory{args={'Baldeali'}}, "Fisico" })
table.insert(tests, { movesData.getDamageCategory{args={'fortuncanto'}}, "Stato" })


-- ================================ getPower ================================
-- Tests 5, 6
-- Standard case
table.insert(tests, { movesData.getPower{args={'Oscurotuffo'}}, 120 })

-- &mdash;
table.insert(tests, { movesData.getPower{args={'inondazione'}}, '&mdash;' })

-- ================================ getAccuracy ================================
-- Tests 7, 8
-- Standard case
table.insert(tests, { movesData.getAccuracy{args={'dragobolide'}}, 90 })

-- &mdash;
table.insert(tests, { movesData.getAccuracy{args={'Comete'}}, '&mdash;' })

-- ================================ getPP ================================
-- Tests 9
-- Standard case
table.insert(tests, { movesData.getPP{args={'Supplica'}}, 25 })

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
