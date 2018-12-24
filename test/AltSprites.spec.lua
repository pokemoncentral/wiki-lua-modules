-- "Test cases" for abillist

local altSprites = require('AltSprites').altSprites

-- Standard
print(altSprites{args={'Genesect'}})

-- Useless
print(altSprites{args={'Gastrodon'}})

-- Hand-handled
print(altSprites{args={'Deoxys'}})

-- Mid-generation form
print(altSprites{args={'Kyurem'}})

-- Case tested:
--  	both AltForms and UselessForms
--		forms with until
--		mid-generation form
--		problems that can arise with Pikachu
print(altSprites{args={'Pikachu'}})
