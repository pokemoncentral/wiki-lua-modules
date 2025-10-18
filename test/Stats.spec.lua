-- "Test cases" for stats

local lib = require("test/snapshot-lib")
local stats = require("Stats")

lib.printHeading("StatsBox - #1")
print(stats.statsBox({
    args = {
        hp = 255,
        atk = 5,
        def = 10,
        spatk = 93,
        spdef = 135,
        spe = 63,
        type1 = "elettro",
        type2 = "fuoco",
        bounds = "yes",
        gen = 2,
        listLink = "yes",
    },
}))

lib.printHeading("StatsBox - #2")
print(stats.statsBox({
    args = {
        hp = "50",
        atk = "220",
        def = "210",
        spatk = "90",
        spdef = "21",
        spe = "120",
        type = "acciaio",
        totalLink = "yes",
        align = "left",
    },
}))

lib.printHeading("StatsBox - First gen, with spec")
print(stats.statsBox({
    args = {
        hp = "33",
        atk = "136",
        def = "0",
        spec = "6",
        spe = "29",
        type1 = "sconosciuto",
        type2 = "normale",
        bounds = "yes",
        gen = "1",
    },
}))

lib.printHeading("TypeAvg", { "Elettro" })
print(stats.typeAvg({ args = { "Elettro" } }))

lib.printHeading("TypeAvg", { "Fuoco", "4" })
print(stats.typeAvg({ args = { "Fuoco", "4" } }))

lib.printHeading("PokeStats - Plain")
print(stats.PokeStats({ args = { "Starly" } }))

lib.printHeading("PokeStats - Strange name")
print(stats.PokeStats({ args = { "Ho-Oh" } }))

lib.printHeading("PokeStats - Huge values")
print(stats.PokeStats({ args = { "Blissey" } }))

lib.printHeading("PokeStats - Non-standard stat calculation")
print(stats.PokeStats({ args = { "Shedinja" } }))

lib.printHeading("PokeStats - Form collapse")
print(stats.PokeStats({ args = { "Arceus" } }))

lib.printHeading("PokeStats - Form non collapse")
print(stats.PokeStats({ args = { "Giratina" } }))

lib.printHeading("PokeStats - Speciali")
print(stats.PokeStats({ args = { "Magikarp" } }))

lib.printHeading("PokeStats - Multigen")
print(stats.PokeStats({ args = { "Aegislash" } }))

lib.printHeading("PokeStats - Both form multigen")
print(stats.PokeStats({ args = { "Alakazam" } }))
