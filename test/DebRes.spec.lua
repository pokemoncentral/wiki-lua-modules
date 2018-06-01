-- "Test cases" for debRes

local debRes = require('DebRes').debRes

-- Somethign normal first
print(debRes{args={'Luxio'}})

-- Immunities
print(debRes{args={'Mudsdale'}})

-- Multiple forms collapse into one
print(debRes{args={'Scizor'}})
