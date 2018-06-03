-- "Test cases" for debRes

local debRes = require('DebRes').debRes

-- Somethign normal first
print(debRes{args={'Luxio'}})

-- Immunities
print(debRes{args={'Shuppet'}})

-- Multiple ability
print(debRes{args={'Dewgong'}})

-- Single Ability
print(debRes{args={'Duskull'}})

-- Immunity by both type and ability
print(debRes{args={'Rhydon'}})

-- Filtro, Solidroccia & co
print(debRes{args={'Mr. Mime'}})

-- Filtro only
print(debRes{args={'Aggron'}})

-- Multiple forms collapse into one
print(debRes{args={'Scizor'}})

-- Some forms collapse
print(debRes{args={'Charizard'}})

-- No forms collapse
print(debRes{args={'Altaria'}})
