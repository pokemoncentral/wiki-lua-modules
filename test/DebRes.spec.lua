-- "Test cases" for debRes

local dr = require("DebRes")

-- ================================== DebRes ==================================
-- Somethign normal first
print(dr.debRes({ args = { "Luxio" } }))

-- Immunities
print(dr.debRes({ args = { "Shuppet" } }))

-- Multiple ability
print(dr.debRes({ args = { "Dewgong" } }))

-- Single Ability
print(dr.debRes({ args = { "Duskull" } }))

-- Immunity by both type and ability
print(dr.debRes({ args = { "Rhydon" } }))

-- Filtro, Solidroccia & co
print(dr.debRes({ args = { "Mr. Mime" } }))

-- Filtro only
print(dr.debRes({ args = { "Aggron" } }))

-- Multiple forms collapse into one
print(dr.debRes({ args = { "Scizor" } }))

-- Some forms collapse
print(dr.debRes({ args = { "Charizard" } }))

-- No forms collapse
print(dr.debRes({ args = { "Altaria" } }))

-- ================================== Single ==================================
-- It automatically checks that positional and named produces the same output

local function checkEqual(argsPos, argsNamed)
    local drPos = dr.single({ args = argsPos })
    -- Outputs the first
    print(drPos)
    -- Check equality
    assert(
        drPos == dr.single({ args = argsNamed }),
        "Positional and named parameters produce different outputs"
    )
end

checkEqual({
    "Veleno",
    "Terra",
    "Velenopunto",
    "Antagonismo",
    "Acquascolo",
    "Remasabbia",
}, {
    type1 = "Veleno",
    type2 = "Terra",
    abil1 = "Velenopunto",
    abil2 = "Antagonismo",
    abild = "Acquascolo",
    abile = "Remasabbia",
})

checkEqual(
    { "Spettro", "", "Levitazione" },
    { type = "Spettro", abil = "Levitazione" }
)

checkEqual({ "Spettro" }, { type = "Spettro" })

checkEqual({ "Veleno", "Terra" }, { type1 = "Veleno", type2 = "Terra" })

-- Old gen

-- Gen 1
print(dr.single({ args = { "Parasect", gen = 1 } }))

-- Gen 2, added Dark and Steel
print(dr.single({ args = { "Gengar", gen = 2 } }))

-- Gen 3, Steel resisted to Dark and Ghost
print(dr.single({ args = { "Metagross", gen = 3 } }))

-- Gen 3, with types and abilities
print(dr.single({
    args = { "Acciaio", "Spettro", "Levitazione", "Acquascolo", gen = 3 },
}))

-- Gen 6, old ability (changed in gen 7)
print(dr.single({ args = { "Gengar", gen = 6 } }))

-- Alternative form
print(dr.single({ args = { "Rotom", form = "L", gen = 4 } }))
print(dr.single({ args = { "Rotom", form = "L", gen = 5 } }))
