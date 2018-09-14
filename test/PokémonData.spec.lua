-- "Test cases" for Typelist

local pokeData = require('PokémonData')
local tests = {}

-- ================================ getName ================================
-- Tests 1, 5
-- Standard case
table.insert(tests, { pokeData.getName{args={'398'}}, 'Staraptor' })

-- Few digits
table.insert(tests, { pokeData.getName{args={'65'}}, 'Alakazam' })

-- getName alt form
table.insert(tests, { pokeData.getName{args={'487O'}}, 'Giratina' })

-- getName useless form
table.insert(tests, { pokeData.getName{args={'422E'}}, 'Shellos' })

-- getName both (Minior is better than Pikachu because it has a form in both)
table.insert(tests, { pokeData.getName{args={'774R'}}, 'Minior' })

-- ================================ getFormName ===============================
-- Tests 6, 11
-- AltForms
table.insert(tests, { pokeData.getFormName{args={'800A'}}, "Necrozma Ali dell'Aurora" })

-- UselessForms
table.insert(tests, { pokeData.getFormName{args={'422E'}}, 'Mare Est' })

-- BothForms
table.insert(tests, { pokeData.getFormName{args={'774R'}}, 'Nucleo Rosso' })

-- Base form
table.insert(tests, { pokeData.getFormName{args={'422'}}, 'Mare Ovest' })

-- Empty form name, few digits
table.insert(tests, { pokeData.getFormName{args={'28'}}, '' })

-- Pokémon without alternative form
table.insert(tests, { pokeData.getFormName{args={'398'}}, '' })

-- ================================ getAbil ================================
-- Tests 12, 18
-- Standard cases, names or two digits
table.insert(tests, { pokeData.getAbil1{args={'065'}}, 'Sincronismo' })
table.insert(tests, { pokeData.getAbil2{args={'alakazam'}}, 'Forza Interiore' })
table.insert(tests, { pokeData.getAbild{args={'65'}}, 'Magicscudo' })

-- Second ability on Pokémon with only one ability
table.insert(tests, { pokeData.getAbil2{args={'398'}}, '' })

-- Alternative form ability
table.insert(tests, { pokeData.getAbil1{args={'487O'}}, 'Levitazione' })
table.insert(tests, { pokeData.getAbild{args={'giratinaO'}}, '' })

-- Old gen ability
table.insert(tests, { pokeData.getAbil1{args={'94', gen = '5'}}, 'Levitazione' })

-- ================================ getType ================================
-- Tests 19, 24
-- Standard case
table.insert(tests, { pokeData.getType1{args={'398'}}, 'Normale' })
table.insert(tests, { pokeData.getType2{args={'398'}}, 'Volante' })

-- Second type on Pokémon with only one type, two digits
table.insert(tests, { pokeData.getType2{args={'65'}}, 'Psico' })

-- Alternative form type
table.insert(tests, { pokeData.getType1{args={'493Fu'}}, 'Fuoco' })
table.insert(tests, { pokeData.getType2{args={'479L'}}, 'Acqua' })

-- Old gen type
table.insert(tests, { pokeData.getType2{args={'082', gen = '1'}}, 'Elettro' })

-- ================================ getLink ================================
-- Tests 25, 30
-- Standard case
table.insert(tests, {
	pokeData.getLink{args={'487'}},
	'<div class="small-text">[[Differenze di forma#Giratina|Forma Alterata]]</div>'
})
table.insert(tests, {
	pokeData.getLink{args={'487O'}},
	'<div class="small-text">[[Differenze di forma#Giratina|Forma Originale]]</div>'
})

-- Empty base form link
table.insert(tests, {
	pokeData.getLink{args={'028A'}},
	'<div class="small-text">[[Forma di Alola#Sandshrew e Sandslash|Forma di Alola]]</div>'
})
table.insert(tests, { pokeData.getLink{args={'028'}}, '' })

-- BothForms
table.insert(tests, {
	pokeData.getLink{args={'774R'}},
	'<div class="small-text">[[Differenze di forma#Minior|Nucleo Rosso]]</div>'
})

-- Pokémon without alternative forms
table.insert(tests, { pokeData.getLink{args={'398'}}, '' })


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
