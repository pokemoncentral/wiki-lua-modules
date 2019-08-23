--[[

Data module for moves learning.

For each Pokémon there's a table that contains a table for each generation.
In those tables indexes are move names, that are associated to a list of
levels, representing levels at which the Pokémon learns the move in the
corresponding game. The ordering of games is given in the table "games". A
level can be a number, "inizio" or "evo".

So for instance the table

{"inizio"}, {"inizio", "evo"}

corresponding to gen 7 means that the Pokémon learns that move at level
"inizio" in SL (first element of games["7"]) and both at level "inizio" and
"evo" in USUL (second element of games["7"]).

Some useful informations:
    - notes are needed only for breed and preevo
    - except for level and tm, other methods has exactly one line per move.
      A move can be learned at multiple levels, and a tm or hm with a move can
      change within a generation (es: spaccaroccia)

TODO: create a script to autogenerate preevo and breed tables.

--]]

local m = {}

m.games = {
level = { { "RB", "G" }, { "OA", "C" }, { "RZ", "RFVF", "S" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" },
},
tutor = { {}, { "C" }, { "RFVF", "S", "XD" },
    { "DP", "Pt", "HGSS" }, { "NB", "N2B2" }, { "XY", "ROZA" },
    { "SL", "USUL" },
}
}


m.zubat = {
level = {
    [7] = {
        sgomento = { {3} },
    },
},
tm = {}, breed = {}, tutor = {}, preevo = {}, event = {},
}
m[041] = m.zubat
m["farfetch'd"] = {
level = {
    [6] = {
        retromarcia = { {30} }
    },
    [7] = {},
},
tm = {},
breed = {
    [7] = {
        vendetta = { {335, 461, 501, 502, 503, 626} },
    },
},
tutor = {}, preevo = {}, event = {},
}
m[083] = m["farfetch'd"]
m.skarmory = {
level = {
    [7] = {
        alacciaio = { {23} },
    },
},
tm = {}, breed = {}, tutor = {}, preevo = {}, event = {},
}
m[227] = m.skarmory
m.pidove = {
level = {},
tm = {
    [7] = { "individua" },
},
breed = {}, tutor = {}, preevo = {}, event = {},
}
m[519] = m.pidove

m.mew = {
    level = {

    },
    tm = {
        [1] = { all = true }, -- Mew can learn any move via tm
        [2] = { all = true }, -- Mew can learn any move via tm
        [3] = { all = true }, -- Mew can learn any move via tm
        [4] = { all = true }, -- Mew can learn any move via tm
        [5] = { all = true }, -- Mew can learn any move via tm
        [6] = { all = true }, -- Mew can learn any move via tm
        [7] = { all = true }, -- Mew can learn any move via tm
    },
    breed = {},
    tutor = {},
    preevo = {},
    event = {},
}
m[151] = m.mew

m.starly = {
level = {},
tm = {},
breed = {
    [6] = {},
    [7] = {
        sgomento = { {041, 042, 169, 198, 430, 333, 334, 722, 723, 724} },
        individua = { {519, 520, 521} },
        vendetta = { {083} },
        alacciaio = { {227, 661, 662, 663}, "solo di martedì", games = {"USUL"} },
        retromarcia = { {083} },
    },
},
tutor = {}, preevo = {}, event = {},
}

m.staraptor = {
level = {
    [6] = {},
    [7] = {
        zuffa = { {"inizio"}, {"inizio", "evo"} },
        ["attacco rapido"] = { {"inizio", 5}, {"inizio", 5} },
        ["geyser fotonico"] = { {}, {50} },
        doppioteam = { {13}, {13} },
    },
},
tm = {
    [6] = { "spaccaroccia", "sub", "furto", "energipalla", "protezione" },
    [7] = {},
},
breed = m.starly.breed,
tutor = {
    [6] = {},
    [7] = {
        baraonda = { false, true },
        russare = { false, true },
        ondacalda  = { false, true },
    }
},
preevo = {
    [6] = {},
    [7] = {
        semebomba = { 396, 397 },
    },
},
event = {
    [6] = {},
    [7] = {
        giudizio = "Muccainvolo di Maze",
    },
},
}
m[398] = m.staraptor

m["fennekin"] = {
level = {
      {}, {}, {}, {}, {},
      {
        braciere={ { 5 }, { 5 } },
        colpocoda={ { "inizio" }, { "inizio" } },
        fortuncanto={ { 25 }, { 25 } },
        fuocobomba={ { 48 }, { 48 } },
        fuocofatuo={ { 38 }, { 38 } },
        giornodisole={ { 43 }, { 43 } },
        graffio={ { "inizio" }, { "inizio" } },
        gridodilotta={ { 11 }, { 11 } },
        lanciafiamme={ { 35 }, { 35 } },
        magicozona={ { 46 }, { 46 } },
        nitrocarica={ { 14 }, { 14 } },
        psichico={ { 41 }, { 41 } },
        psicoraggio={ { 17 }, { 17 } },
        psicoshock={ { 31 }, { 31 } },
        schermoluce={ { 27 }, { 27 } },
        turbofuoco={ { 20 }, { 20 } }
      },
      {
        braciere={ { 5 }, { 5 } },
        colpocoda={ { "inizio" }, { "inizio" } },
        fortuncanto={ { 25 }, { 25 } },
        fuocobomba={ { 48 }, { 48 } },
        fuocofatuo={ { 38 }, { 38 } },
        giornodisole={ { 43 }, { 43 } },
        graffio={ { "inizio" }, { "inizio" } },
        gridodilotta={ { 11 }, { 11 } },
        lanciafiamme={ { 35 }, { 35 } },
        magicozona={ { 46 }, { 46 } },
        nitrocarica={ { 14 }, { 14 } },
        psichico={ { 41 }, { 41 } },
        psicoraggio={ { 17 }, { 17 } },
        psicoshock={ { 31 }, { 31 } },
        schermoluce={ { 27 }, { 27 } },
        turbofuoco={ { 20 }, { 20 } }
      }
    },
tm = {
      {}, {}, {}, {}, {},
      {
        "nitrocarica", "coro", "echeggiavoce", "bruciatutto", "confidenza", "crescipugno",
        "mangiasogni", "taglio", "lanciafiamme", "solarraggio", "tossina",
        "psichico", "doppioteam", "schermoluce", "fuocobomba", "riposo",
        "sostituto", "furto", "protezione", "bullo", "attrazione", "sonnolalia",
        "ritorno", "frustrazione", "salvaguardia", "introforza", "pioggiadanza",
        "giornodisole", "psicamisù", "fuocofatuo", "facciata", "vampata",
        "divieto", "laccioerboso", "psicoshock", "forzasegreta"
      },
      {
        "coro",
        "lanciafiamme", "solarraggio", "tossina", "psichico", "doppioteam",
        "schermoluce", "fuocobomba", "mangiasogni", "riposo", "sostituto",
        "furto", "protezione", "bullo", "attrazione", "sonnolalia", "ritorno",
        "frustrazione", "salvaguardia", "introforza", "pioggiadanza", "giornodisole",
        "psicamisù", "fuocofatuo", "facciata", "vampata", "divieto", "laccioerboso",
        "psicoshock", "nitrocarica", "echeggiavoce", "cuordileone", "confidenza"
      }
    },
breed = {
      {}, {}, {}, {}, {},
      { desiderio={ {} }, ipnosi={ {} }, magivelo={ {} }, ondacalda={ {} } },
      {
        ["campo psichico"]={ {}, games={ "USUL" } },
        desiderio={ {} },
        ipnosi={ {} },
        magivelo={ {} },
        ondacalda={ {} }
      }
    },
tutor = {
      {}, {}, {}, {}, {},
      {
        codacciaio={ false, true },
        fiammapatto={ true, true },
        magicozona={ false, true },
        magivelo={ false, true },
        ondacalda={ false, true },
        ripicca={ false, true },
        russare={ false, true },
        supplica={ false, true }
      },
      {
        codacciaio={ false, true },
        fiammapatto={ true, true },
        magicozona={ false, true },
        magivelo={ false, true },
        ondacalda={ false, true },
        ripicca={ false, true },
        russare={ false, true },
        supplica={ false, true }
      }
    },
preevo = {},
event = {},
}
m[653] = m["fennekin"]

return m
