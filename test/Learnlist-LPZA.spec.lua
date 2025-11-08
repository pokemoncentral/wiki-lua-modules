local lib = require("test/snapshot-lib")
local l = require("Learnlist-LPZA")

lib.printHeading("No form - change type with evolution")
print(l.level({
    args = {
        "Kirlia",
        -- stylua: ignore start
        "//",
        " 2 ",
        "Evo",
        " Psichico ",
        "//",
        " 58",
        "Inizio",
        " Doppioteam",
        "//",
        "37 ",
        "100",
        "Zuffa ",
        -- stylua: ignore end
    },
}))

lib.printHeading("Alternate form")
print(l.level({
    args = {
        -- stylua: ignore start
        "Charizard",
        form = "MX",
        "//",
        " 92 ",
        " 64",
        " Oltraggio ",
        "//",
        " Evo",
        "53",
        " Tifone",
        "//",
        "Inizio ",
        "46",
        "Ferrartigli ",
        -- stylua: ignore end
    },
}))
