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
table.insert(tests, { pokeData.getAbil2{args={'Alakazam'}}, 'Forza Interiore' })
table.insert(tests, { pokeData.getAbild{args={'65'}}, 'Magicscudo' })
table.insert(tests, { pokeData.getAbile{args={'744'}}, 'Mente Locale' })

-- Second ability on Pokémon with only one ability
table.insert(tests, { pokeData.getAbil2{args={'398'}}, '' })

-- Alternative form ability
table.insert(tests, { pokeData.getAbil1{args={'487O'}}, 'Levitazione' })

-- Old gen ability
table.insert(tests, { pokeData.getAbil1{args={'94', gen = '5'}}, 'Levitazione' })

-- ================================ getType ================================
-- Tests 19, 27
-- Standard case
table.insert(tests, { pokeData.getType1{args={'398'}}, 'Normale' })
table.insert(tests, { pokeData.getType2{args={'398'}}, 'Volante' })

-- From name
table.insert(tests, { pokeData.getType1{args={'Ho-Oh'}}, 'Fuoco' })

-- Second type on Pokémon with only one type, two digits
table.insert(tests, { pokeData.getType2{args={'65'}}, 'Psico' })

-- Alternative form type
table.insert(tests, { pokeData.getType1{args={'493Fu'}}, 'Fuoco' })
table.insert(tests, { pokeData.getType2{args={'479L'}}, 'Acqua' })

-- Old gen type
table.insert(tests, { pokeData.getType2{args={'082', gen = '1'}}, 'Elettro' })

-- Gradient types
table.insert(tests, { pokeData.gradTypes{args={'400'}}, 'normale-acqua'})
table.insert(tests, { pokeData.gradTypes{args={'035', gen = '1'}},
    'normale-normale'})

-- ================================ getStat ================================
-- Tests 28, 31
-- Standard
table.insert(tests, { pokeData.getStat{args={'398', 'hp'}}, 85 })
table.insert(tests, { pokeData.getStat{args={'65', 'spatk'}}, 135 })

-- Alternative form
table.insert(tests, { pokeData.getStat{args={'487O', 'def'}}, 100 })

-- Old gen
table.insert(tests, { pokeData.getStat{args={'189', 'spdef', gen = '2'}}, 85 })

-- =============================== getCriesList ===============================
-- Tests 32, 35
-- Standard
table.insert(tests, {
    pokeData.getCriesList{args={'800'}},
    'V-Necrozma Criniera del Vespro,A-Necrozma Ali dell\'Aurora,U-UltraNecrozma'
})
-- Only some form
table.insert(tests, {
    pokeData.getCriesList{args={'710'}},
    'XL-Maxi'
})
-- No alternative forms
table.insert(tests, {
    pokeData.getCriesList{args={'398'}},
    ''
})
-- All alternative forms equal
table.insert(tests, {
    pokeData.getCriesList{args={'487'}},
    'all'
})

-- ================================ getLink ================================
-- Those should be last because loads useless in Wikilib-forms
-- Tests 36, 45
-- Standard case
table.insert(tests, {
    pokeData.getLink{args={'487'}},
    '<div class="small-text">[[Giratina/Forme|Forma Alterata]]</div>'
})
table.insert(tests, {
    pokeData.getLink{args={'487O'}},
    '<div class="small-text">[[Giratina/Forme|Forma Originale]]</div>'
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
    '<div class="small-text">[[Minior/Forme|Nucleo Rosso]]</div>'
})

-- Two kinds of "generic" links (ie: Mega and Galar)
table.insert(tests, {
    pokeData.getLink{args={'080'}}, ''
})
table.insert(tests, {
    pokeData.getLink{args={'080M'}},
    '<div class="small-text">[[Megaevoluzione#Slowbro|MegaSlowbro]]</div>'
})
table.insert(tests, {
    pokeData.getLink{args={'080G'}},
    '<div class="small-text">[[Forma di Galar#Slowbro|Forma di Galar]]</div>'
})

-- Urshifu (strange Gigamax)
table.insert(tests, {
    pokeData.getLink{args={'892PGi', "black"}},
    '<div class="small-text black-text">[[Urshifu/Forme|Urshifu Gigamax (Stile Pluricolpo)]]</div>'
})

-- Pokémon without alternative forms
table.insert(tests, { pokeData.getLink{args={'398'}}, '' })

-- Tests 46, 47
-- Standard case
table.insert(tests, {
    pokeData.getLink{args={'487', 'plain'}},
    '[[Giratina/Forme|Forma Alterata]]'
})

-- Pokémon without alternative forms
table.insert(tests, { pokeData.getLink{args={'398', 'black'}}, '' })

-- ===================
-- Standard cases
table.insert(tests, { pokeData.getPokeTextColor{args={" Luxray "}}, "black-text" })
table.insert(tests, { pokeData.getPokeTextColor{args={" Gengar "}}, "white-text" })
table.insert(tests, { pokeData.getPokeTextColor{args={" 065"}}, "black-text" })
table.insert(tests, { pokeData.getPokeTextColor{args={ "249" }}, "white-text" })

-- Alt forms
table.insert(tests, { pokeData.getPokeTextColor{args={" alakazamM "}}, "black-text" })
table.insert(tests, { pokeData.getPokeTextColor{args={"487O"}}, "white-text" })

-- Useless forms (probably they shouldn't even work, but here we go)
table.insert(tests, { pokeData.getPokeTextColor{args={" shellosE "}}, "white-text" })

-- Gen parameter
table.insert(tests, { pokeData.getPokeTextColor{args={" 082 ", gen = " 1 "}}, "black-text" })

-- ==================== Actual execution ======================
for n, v in ipairs(tests) do
    if v[1] ~= v[2] then
        print(table.concat{
            'Test ',
            tostring(n),
            ' failed: ',
            v[2],
            ' expected, but ',
            v[1] or 'nil',
            ' got'
        })
        return
    end
end
print('All tests succesfull!')
