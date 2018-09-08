-- "Test cases" for Typelist

local pokeData = require('PokémonData')

-- ================================ getName ================================
-- Standard case
print(pokeData.getName{args={'398'}})

-- Few digits
print(pokeData.getName{args={'65'}})

-- getName alt form
print(pokeData.getName{args={'487O'}})

-- getName useless form
print(pokeData.getName{args={'422E'}})

-- getName both (Minior is better than Pikachu because it has a form in both)
print(pokeData.getName{args={'774R'}})

-- ================================ getFormName ===============================
-- AltForms
print(pokeData.getFormName{args={'800A'}})

-- UselessForms
print(pokeData.getFormName{args={'422E'}})

-- BothForms
print(pokeData.getFormName{args={'774R'}})

-- Base form
print(pokeData.getFormName{args={'422'}})

-- Empty form name, few digits
print(pokeData.getFormName{args={'28'}})

-- Pokémon without alternative form
print(pokeData.getFormName{args={'398'}})

-- ================================ getAbil ================================
-- Standard cases, names or two digits
print(pokeData.getAbil1{args={'065'}})
print(pokeData.getAbil2{args={'alakazam'}})
print(pokeData.getAbild{args={'65'}})

-- Second ability on Pokémon with only one ability
print(pokeData.getAbil2{args={'398'}})

-- Alternative form ability
print(pokeData.getAbil1{args={'487O'}})
print(pokeData.getAbild{args={'giratinaO'}})

-- Old gen ability
print(pokeData.getAbil1{args={'94', gen = '5'}})

-- ================================ getType ================================
-- Standard case
print(pokeData.getType1{args={'398'}})
print(pokeData.getType2{args={'398'}})

-- Second type on Pokémon with only one type, two digits
print(pokeData.getType2{args={'65'}})

-- Alternative form type
print(pokeData.getType1{args={'493Fu'}})
print(pokeData.getType2{args={'479L'}})

-- Old gen type
print(pokeData.getType2{args={'082', gen = '1'}})

-- ================================ getLink ================================
-- Standard case
print(pokeData.getLink{args={'487'}})
print(pokeData.getLink{args={'487O'}})

-- Empty base form link
print(pokeData.getLink{args={'028A'}})
print(pokeData.getLink{args={'028'}})

-- BothForms
print(pokeData.getLink{args={'774R'}})

-- Pokémon without alternative forms
print(pokeData.getLink{args={'398'}})
