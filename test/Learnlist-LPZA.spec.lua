local lib = require("test/snapshot-lib")
local l = require("Learnlist-LPZA")

lib.printHeading("Level - No form - change type with evolution")
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
        " 92",
        "Inizio",
        " Teletrasporto",
        "//",
        "37 ",
        "100",
        "Zuffa ",
        -- stylua: ignore end
    },
}))

lib.printHeading("Level - Alternate form")
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

lib.printHeading("TM - No form - change type with evolution")
print(l.tm({
    args = {
        "Kirlia",
        -- stylua: ignore start
        "//",
        " MT028 ",
        " Fogliamagica ",
        "//",
        " MT089",
        " Magibrillio",
        "//",
        " MT094",
        " Calmamente",
        "//",
        "MT102 ",
        "Focalcolpo ",
        "no",
        "//",
        "MT017",
        "Lanciafiamme",
        "yes",
        -- stylua: ignore end
    },
}))

lib.printHeading("TM - Alternate form")
print(l.tm({
    args = {
        -- stylua: ignore start
        "Charizard",
        form = "MX",
        "//",
        " MT045 ",
        " Dragobolide ",
        "//",
        " MT012",
        " Attacco d'ala",
        "//",
        "MT082 ",
        "Alacciaio ",
        -- stylua: ignore end
    },
}))

lib.printHeading("Event - No form - change type with evolution")
print(l.event({
    args = {
        "Kirlia",
        -- stylua: ignore start
        "//",
        " Dopo mangiato ",
        " Virata ",
        "//",
        " Quando compri le pentole da Giorgio Mastrota",
        " Assorbibacio",
        "//",
        "Una volta unto il cestello della bicicletta con l'antigelo",
        "Breccia ",
        -- stylua: ignore end
    },
}))

lib.printHeading("Event - Alternate form")
print(l.event({
    args = {
        -- stylua: ignore start
        "Charizard",
        form = "MX",
        "//",
        " Al compiersi dell'ultimo giro intorno al divano ",
        " Dragospiro ",
        "//",
        " Non appena hai pestato il mattoncino Lego®",
        " Ali del Fato",
        "//",
        "Prima di rotolare giù da colli scoscesi ",
        "Frana ",
        -- stylua: ignore end
    },
}))
