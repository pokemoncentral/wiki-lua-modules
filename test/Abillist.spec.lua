-- "Test cases" for abillist

local abillist = require('Abillist').abillist

-- Case tested:
--      All abilities, ability in every position
--      No second and hidden ability
--      Lack second, ability in first
--      Lack second, ability in hidden
print(abillist{args={'buio', 'Prepotenza'}})

-- Multi-gen, form labels
print(abillist{args={'volante', 'Levitazione'}})

-- Event ability in other page
print(abillist{args={'terra', 'Frangiaura'}})

-- Event ability in page
print(abillist{args={'acqua', 'Morfosintonia'}})

if #arg > 0 then
    -- Specific ability from command line
    print(abillist{args={'elettro', arg[1]}})
end
