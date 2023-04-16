-- "Test cases" for Typelist

local pokeData = require("PokémonData")

--[[

Run a single test. The first argument is the computed value, the second is the
expected result.

--]]
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

-- ================================== getNdex =================================
makeTest(pokeData.getNdex({ args = { " Staraptor " } }), "0398")
makeTest(pokeData.getNdex({ args = { "alakazam" } }), "0065")
makeTest(pokeData.getNdex({ args = { " giratina", form = "O" } }), "0487")
makeTest(pokeData.getNdex({ args = { "Minior", form = "R" } }), "0774")

-- ================================ getName ================================
-- Standard case
makeTest(pokeData.getName({ args = { "0398" } }), "Staraptor")

-- Few digits
makeTest(pokeData.getName({ args = { "65" } }), "Alakazam")

-- getName alt form
makeTest(pokeData.getName({ args = { "0681S" } }), "Aegislash")

-- getName alt form less digits
makeTest(pokeData.getName({ args = { "487O" } }), "Giratina")

-- getName useless form
makeTest(pokeData.getName({ args = { "422E" } }), "Shellos")

-- getName both (Minior is better than Pikachu because it has a form in both)
makeTest(pokeData.getName({ args = { "774R" } }), "Minior")

-- ================================ getFormName ===============================
-- AltForms
makeTest(
    pokeData.getFormName({ args = { "800A" } }),
    "Necrozma Ali dell'Aurora"
)

-- UselessForms
makeTest(pokeData.getFormName({ args = { "422E" } }), "Mare Est")

-- BothForms
makeTest(pokeData.getFormName({ args = { "774R" } }), "Nucleo Rosso")

-- Base form
makeTest(pokeData.getFormName({ args = { "422" } }), "Mare Ovest")

-- Empty form name, few digits
makeTest(pokeData.getFormName({ args = { "28" } }), "")

-- Pokémon without alternative form
makeTest(pokeData.getFormName({ args = { "398" } }), "")

-- ================================ getAbil ================================
-- Standard cases, names or two digits
makeTest(pokeData.getAbil1({ args = { "065" } }), "Sincronismo")
makeTest(pokeData.getAbil2({ args = { "Alakazam" } }), "Forza Interiore")
makeTest(pokeData.getAbild({ args = { "65" } }), "Magicscudo")
makeTest(pokeData.getAbile({ args = { "744" } }), "Mente Locale")

-- Second ability on Pokémon with only one ability
makeTest(pokeData.getAbil2({ args = { "398" } }), "")

-- Alternative form ability
makeTest(pokeData.getAbil1({ args = { "487O" } }), "Levitazione")

-- Old gen ability
makeTest(pokeData.getAbil1({ args = { "94", gen = "5" } }), "Levitazione")

-- ================================ getType ================================
-- Standard case
makeTest(pokeData.getType1({ args = { "398" } }), "Normale")
makeTest(pokeData.getType2({ args = { "398" } }), "Volante")

-- Name
makeTest(pokeData.getType1({ args = { "Ho-Oh" } }), "Fuoco")

-- Second type on Pokémon with only one type, two digits
makeTest(pokeData.getType2({ args = { "65" } }), "Psico")

-- Coleot
makeTest(pokeData.getType2({ args = { "0752" } }), "Coleottero")
makeTest(pokeData.getShortType2({ args = { "0752" } }), "Coleot")
makeTest(pokeData.getShortType1({ args = { "0752" } }), "Acqua")
makeTest(pokeData.getShortType1({ args = { "Caterpie" } }), "Coleottero")

-- Alternative form type
makeTest(pokeData.getType1({ args = { "493Fu" } }), "Fuoco")
makeTest(pokeData.getType2({ args = { "479L" } }), "Acqua")

-- Name and alternative form type
makeTest(pokeData.getType2({ args = { "Rotom ", form = "L" } }), "Acqua")

-- Old gen type
makeTest(pokeData.getType2({ args = { "082", gen = "1" } }), "Elettro")

-- Gradient types
makeTest(pokeData.gradTypes({ args = { "400" } }), "normale-acqua")
makeTest(pokeData.gradTypes({ args = { "035", gen = "1" } }), "normale-normale")

-- ================================ getStat ================================
-- Standard
makeTest(pokeData.getStat({ args = { "398", "hp" } }), 85)
makeTest(pokeData.getStat({ args = { "65", "spatk" } }), 135)

-- Alternative form
makeTest(pokeData.getStat({ args = { "487O", "def" } }), 100)

-- Old gen
makeTest(pokeData.getStat({ args = { "189", "spdef", gen = "2" } }), 85)

-- Alt form from name in an old gen
makeTest(
    pokeData.getStat({ args = { "Aegislash", "atk", form = "S", gen = "6" } }),
    150
)

-- =============================== getCriesList ===============================
-- Standard
makeTest(
    pokeData.getCriesList({ args = { "800" } }),
    "V-Necrozma Criniera del Vespro,A-Necrozma Ali dell'Aurora,U-UltraNecrozma"
)
-- Only some form
makeTest(pokeData.getCriesList({ args = { "710" } }), "XL-Maxi")
-- No alternative forms
makeTest(pokeData.getCriesList({ args = { "398" } }), "")
-- All alternative forms equal
makeTest(pokeData.getCriesList({ args = { "487" } }), "all")

-- ============================= getPokeTextColor =============================
-- Standard cases
makeTest(pokeData.getPokeTextColor({ args = { " Luxray " } }), "black-text")
makeTest(pokeData.getPokeTextColor({ args = { " Gengar " } }), "white-text")
makeTest(pokeData.getPokeTextColor({ args = { " 065" } }), "black-text")
makeTest(pokeData.getPokeTextColor({ args = { "249" } }), "white-text")

-- Alt forms
makeTest(pokeData.getPokeTextColor({ args = { " 65M " } }), "black-text")
makeTest(pokeData.getPokeTextColor({ args = { "487O" } }), "white-text")
makeTest(
    pokeData.getPokeTextColor({ args = { "giratina", form = "O" } }),
    "white-text"
)

-- Useless forms (probably they shouldn't even work, but here we go)
makeTest(pokeData.getPokeTextColor({ args = { " 0422E " } }), "white-text")

-- Gen parameter
makeTest(
    pokeData.getPokeTextColor({ args = { " 082 ", gen = " 1 " } }),
    "black-text"
)

-- ================================ getLink ================================
-- Those should be last because loads useless in Wikilib-forms
-- Standard case
makeTest(
    pokeData.getLink({ args = { "487" } }),
    '<div class="small-text">[[Giratina/Forme|Forma Alterata]]</div>'
)
makeTest(
    pokeData.getLink({ args = { "487O" } }),
    '<div class="small-text">[[Giratina/Forme|Forma Originale]]</div>'
)

-- Empty base form link
makeTest(
    pokeData.getLink({ args = { "028A" } }),
    '<div class="small-text">[[Forma di Alola#Sandshrew e Sandslash|Forma di Alola]]</div>'
)
makeTest(pokeData.getLink({ args = { "028" } }), "")

-- BothForms
makeTest(
    pokeData.getLink({ args = { "774R" } }),
    '<div class="small-text">[[Minior/Forme|Nucleo Rosso]]</div>'
)

-- Two kinds of "generic" links (ie: Mega and Galar)
makeTest(pokeData.getLink({ args = { "080" } }), "")
makeTest(
    pokeData.getLink({ args = { "080M" } }),
    '<div class="small-text">[[Megaevoluzione#Slowbro|MegaSlowbro]]</div>'
)
makeTest(
    pokeData.getLink({ args = { "080G" } }),
    '<div class="small-text">[[Forma di Galar#Slowbro|Forma di Galar]]</div>'
)

-- Urshifu (strange Gigamax)
makeTest(
    pokeData.getLink({ args = { "892PGi", "black" } }),
    '<div class="small-text black-text">[[Urshifu/Forme|Urshifu Gigamax (Stile Pluricolpo)]]</div>'
)

-- Pokémon without alternative forms
makeTest(pokeData.getLink({ args = { "398" } }), "")

-- Plain link
makeTest(
    pokeData.getLink({ args = { "487", "plain" } }),
    "[[Giratina/Forme|Forma Alterata]]"
)

-- Pokémon without alternative forms
makeTest(pokeData.getLink({ args = { "398", "black" } }), "")

-- Pokémon name
makeTest(
    pokeData.getLink({ args = { "giratina ", form = "O" } }),
    '<div class="small-text">[[Giratina/Forme|Forma Originale]]</div>'
)
-- ============================================================================
print("All tests succesfull!")
