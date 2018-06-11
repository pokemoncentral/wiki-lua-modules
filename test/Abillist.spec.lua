-- "Test cases" for abillist

local abillist = require('Abillist').abillist

-- Case tested:
--      All abilities, ability in every position
--      No second and hidden ability
--      Lack second, ability in first
--      Lack second, ability in hidden
print(abillist{args={'buio', 'Prepotenza'}})

-- Multi-gen
print(abillist{args={'spettro', 'Pedinombra'}})

-- Event ability in other page
print(abillist{args={'terra', 'Frangiaura'}})

-- Event ability in page
print(abillist{args={'acqua', 'Morfosintonia'}})
