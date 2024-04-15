--[[

Module with all the colors.

This returns the hexadecimal string of the required color.

Example invocations:
{{#invoke: colore | fuoco }}
{{#invoke: colore | fuoco | light }}

--]]

local c = {}
-- stylua: ignore
local txt = require('Wikilib-strings')

-- Main function, which generates the function for a single color given the
-- three hexadecimals
local function _colore(normale, light, dark)
    return function(frame)
        local variante = txt.trim(frame.args[1] or "normale"):lower()
        local colors = { normale = normale, light = light, dark = dark }
        return colors[variante] or error("Unexpected variant")
    end
end

-- Simple const function: returns the same value irrespective of parameters
local function const(val)
    return function()
        return val
    end
end

-- Types

c.acciaio = _colore("60A1B8", "A2D0E0", "25657C")
c.Acciaio = c.acciaio
c.acqua = _colore("2980EF", "83B9FF", "004DAF")
c.Acqua = c.acqua
c.buio = _colore("50413F", "747474", "110B0A")
c.Buio = c.buio
c.coleottero = _colore("91A119", "C5D260", "5C6800")
c.Coleottero, c.coleot, c.Coleot = c.coleottero, c.coleottero, c.coleottero
c.drago = _colore("5060E1", "909CFF", "1222A0")
c.Drago = c.drago
c.elettro = _colore("FAC000", "FFE695", "987500")
c.Elettro = c.elettro
c.erba = _colore("3FA129", "81D36E", "165F06")
c.Erba = c.erba
c.folletto = _colore("EF70EF", "FFCDFF", "BF31BF")
c.Folletto = c.folletto
c.fuoco = _colore("E62829", "FF7172", "840001")
c.Fuoco = c.fuoco
c.ghiaccio = _colore("3FD8FF", "BCF2FF", "0098BF")
c.Ghiaccio = c.ghiaccio
c.lotta = _colore("FF8000", "FFB162", "9C4E00")
c.Lotta = c.lotta
c.normale = _colore("9FA19F", "D8D8D8", "5B615B")
c.Normale = c.normale
c.ombra = _colore("604E82", "8674A8", "3E3355")
c.Ombra = c.ombra
c.psico = _colore("EF4179", "FF96B8", "9E0234")
c.Psico = c.psico
c.roccia = _colore("AFA981", "DBD8C8", "746C38")
c.Roccia = c.roccia
c.sconosciuto = _colore("68A090", "9DC1B7", "44685E")
c.Sconosciuto, c["???"] = c.sconosciuto, c.sconosciuto
c.spettro = _colore("704170", "9C809C", "380838")
c.Spettro = c.spettro
c.terra = _colore("915121", "C2895F", "4A2000")
c.Terra = c.terra
c.veleno = _colore("9141CB", "C078F4", "450474")
c.Veleno = c.veleno
c.volante = _colore("81B9EF", "BDDFFF", "3075B8")
c.Volante = c.volante

-- Glitch aliases
-- Aliases with the underscore are needed because of module css

c.Glitch, c.glitch = c.sconosciuto, c.sconosciuto
c.IIIItoto, c.iiiitoto, c.Uccello, c.uccello =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["6!2?2 A"], c["6!2?2 a"], c["x v zA"], c["x v za"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["6!2?2_A"], c["6!2?2_a"], c["x_v_zA"], c["x_v_za"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c.L, c.l, c.B, c.b = c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c[",K Pk(nome del giocatore)xX"], c[",k pk(nome del giocatore)xx"] =
    c.sconosciuto, c.sconosciuto
c[",K_Pk(nome_del_giocatore)xX"], c[",k_pk(nome_del_giocatore)xx"] =
    c.sconosciuto, c.sconosciuto
c["Allen. Jr ♀"], c["allen. jr ♀"], c["Allen._Jr_♀"], c["allen._jr_♀"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["Normale (glitch)"], c["normale (glitch)"], c["Normale_(glitch)"], c["normale_(glitch)"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["Pokémaniaco"], c["pokémaniaco"] = c.sconosciuto, c.sconosciuto
c["'l) m) ZM"], c["'l) m) zm"], c["'l)_m)_ZM"], c["'l)_m)_zm"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["(Classe dell'ultimo allenatore affrontato)"] = c.sconosciuto
c["(Classe_dell'ultimo_allenatore_affrontato)"] = c.sconosciuto
c["(classe dell'ultimo allenatore affrontato)"] = c.sconosciuto
c["(classe_dell'ultimo_allenatore_affrontato)"] = c.sconosciuto
c["Qi JT(nome del giocatore)? POké BB(nome del Pokémon) de W N"] =
    c.sconosciuto
c["Qi_JT(nome_del_giocatore)?_POké_BB(nome_del_Pokémon)_de_W_N"] =
    c.sconosciuto
c["qi jt(nome del giocatore)? poké bb(nome del pokémon) de w n"] =
    c.sconosciuto
c["qi_jt(nome_del_giocatore)?_poké_bb(nome_del_pokémon)_de_w_n"] =
    c.sconosciuto
c["Poké BB"], c["poké bb"], c["Poké_BB"], c["poké_bb"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["8 8 9 5"], c["8_8_9_5"], c["999"], c["?"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto, c.sconosciuto
c["66848.04"], c["' ♀ ♀ ' 2222 37572"], c["'_♀_♀_'_2222_37572"] =
    c.sconosciuto, c.sconosciuto, c.sconosciuto

-- Damage categories

c.Fisico = _colore("C92112", "D96358", "82150B")
c.fisico = c.Fisico
c.Speciale = _colore("4F5870", "83899A", "333948")
c.speciale = c.Speciale
c.Stato = _colore("8C888C", "AEABAE", "5B585B")
c.stato = c.Stato
c.Fisico_text = const("F67A1A")
c.fisico_text = c.Fisico_text
c.Speciale_text = const("FFFFFF")
c.speciale_text = c.Speciale_text
c.Stato_text = const("F7F7F7")
c.stato_text = c.Stato_text

-- Games

c.argento = _colore("C0C0C0", "D6D6D6", "7D7D7D")
c.Argento = c.argento
c.soulsilver = _colore("C0C0E1", "D6D6EB", "7D7D92")
c.Soulsilver, c.SoulSilver = c.soulsilver, c.soulsilver
c.br = _colore("DCA202", "FFD461", "684D02")
c.Battle_revolution, c.battle_revolution, c.Battlerevolution, c.battlerevolution, c.Br, c.BR =
    c.br, c.br, c.br, c.br, c.br, c.br
c.bianco = _colore("C3C3C3", "D8D8D8", "7F7F7F")
c.Bianco = c.bianco
c.bianco_2 = _colore("E3CED0", "EDDFE0", "948687")
c.Bianco_2, c.Bianco2, c.bianco2, c["bianco 2"], c["Bianco 2"] =
    c.bianco_2, c.bianco_2, c.bianco_2, c.bianco_2, c.bianco_2
c.blu = _colore("1111FF", "7777FF", "0B0BA6")
c.Blu = c.blu
c.colo = _colore("B6CAE4", "CFDCED", "768394")
c.Colo, c.colosseum, c.Colosseum = c.colo, c.colo, c.colo
c.cristallo = _colore("4FD9FF", "8CE6FF", "338DA6")
c.Cristallo = c.cristallo
c.diamante = _colore("AAAAFF", "CCCCFF", "6F6FA6")
c.Diamante = c.diamante
c.giallo = _colore("FFD733", "FFE57A", "A68C21")
c.Giallo = c.giallo
c.md = _colore("D78144", "DECAA9", "7C4B2D")
c.Md, c.MD = c.md, c.md
c.md_blu = _colore("095BAF", "5A91C9", "063D75")
c.Md_blu, c.Mdblu, c.mdblu, c["md blu"], c["Md blu"] =
    c.md_blu, c.md_blu, c.md_blu, c.md_blu, c.md_blu
c.md_cielo = _colore("7BB54F", "A6CD89", "527935")
c.Md_cielo, c.Mdcielo, c.mdcielo, c["md cielo"], c["Md cielo"] =
    c.md_cielo, c.md_cielo, c.md_cielo, c.md_cielo, c.md_cielo
c.md_oscurita = _colore("C3141B", "D76166", "830D12")
c.Md_oscurita, c.Mdoscurita, c.mdoscurita, c["md oscurita"], c["Md oscurita"] =
    c.md_oscurita, c.md_oscurita, c.md_oscurita, c.md_oscurita, c.md_oscurita
c["Md_oscurità"], c["Mdoscurità"], c["mdoscurità"], c["md oscurità"], c["Md oscurità"] =
    c.md_oscurita, c.md_oscurita, c.md_oscurita, c.md_oscurita, c.md_oscurita
c.md_portali = _colore("7D6A7A", "AE9EAC", "4D3249")
c.Md_portali, c.mdportali, c.Mdportali, c["md portali"], c["Md portali"] =
    c.md_portali, c.md_portali, c.md_portali, c.md_portali, c.md_portali
c.md_rosso = _colore("C50C50", "D85C8A", "840836")
c.Md_rosso, c.Mdrosso, c.mdrosso, c["md rosso"], c["Md rosso"] =
    c.md_rosso, c.md_rosso, c.md_rosso, c.md_rosso, c.md_rosso
c.md_tempo = _colore("2190C7", "6AB5D9", "166185")
c.Md_tempo, c.Mdtempo, c.mdtempo, c["md tempo"], c["Md tempo"] =
    c.md_tempo, c.md_tempo, c.md_tempo, c.md_tempo, c.md_tempo
c.md_super = _colore("A5A3D2", "CCC9FF", "7471A6")
c.Md_super, c.mdsuper, c.Mdsuper, c["md super"], c["Md super"] =
    c.md_super, c.md_super, c.md_super, c.md_super, c.md_super
c.super_md, c.Super_md, c.supermd, c.Supermd, c["super md"], c["Super md"] =
    c.md_super, c.md_super, c.md_super, c.md_super, c.md_super, c.md_super
c.mddx = _colore("FFC809", "FFEBA6", "A68100")
c.Mddx, c.md_dx, c.Md_dx, c.MDDX = c.mddx, c.mddx, c.mddx, c.mddx
c.nero = _colore("444444", "858585", "2C2C2C")
c.Nero = c.nero
c.nero_2 = _colore("424B50", "848A8D", "2B3134")
c.Nero_2, c.Nero2, c.nero2, c["nero 2"], c["Nero 2"] =
    c.nero_2, c.nero_2, c.nero_2, c.nero_2, c.nero_2
c.OsA = _colore("2D4B98", "768ABC", "1D3163")
c.osA, c.osa = c.OsA, c.OsA
c.oro = _colore("DAA520", "E7C46E", "8E6B15")
c.Oro = c.oro
c.heartgold = _colore("B69E00", "CEB654", "766700")
c.Heartgold, c.HeartGold = c.heartgold, c.heartgold
c.perla = _colore("FFAAAA", "FFC8C8", "A66F6F")
c.Perla = c.perla
c.platino = _colore("999999", "BDBDBD", "646464")
c.Platino = c.platino
c["pokémon"] = _colore("E5653C", "E2947C", "A62F19")
c["Pokémon"] = c["pokémon"]
c.ranger = _colore("F7681A", "FA9D6A", "A14411")
c.Ranger = c.ranger
c.rosso = _colore("FF1111", "FF7777", "A60B0B")
c.Rosso = c.rosso
c.rossofuoco = _colore("FF7327", "FFA472", "A64B19")
c.Rossofuoco, c.RossoFuoco, c["Rosso Fuoco"] =
    c.rossofuoco, c.rossofuoco, c.rossofuoco
c.rubino = _colore("A00000", "D42E2E", "680000")
c.Rubino = c.rubino
c.rubinoomega = _colore("AB2813", "C87365", "6F1A0C")
c.Rubinoomega, c.RubinoOmega, c["Rubino Omega"] =
    c.rubinoomega, c.rubinoomega, c.rubinoomega
c.smeraldo = _colore("00A000", "2ED42E", "006800")
c.Smeraldo = c.smeraldo
c.TL = _colore("2CB8E9", "76D1F1", "1D7898")
c.Tl, c.tl = c.TL, c.TL
c.verde = _colore("11BB11", "A7DB8D", "0B7A0B")
c.Verde = c.verde
c.verdefoglia = _colore("00DD00", "59E959", "015701")
c.Verdefoglia, c.VerdeFoglia, c["Verde Foglia"] =
    c.verdefoglia, c.verdefoglia, c.verdefoglia
c.x = _colore("025DA6", "5A96C5", "013D6C")
c.X = c.x
c.y = _colore("EA1A3E", "F16A81", "981128")
c.Y = c.y
c.xd = _colore("604E82", "8674A8", "3E3355")
c.XD, c.Xd = c.xd, c.xd
c.zaffiro = _colore("0000A0", "5959C1", "000068")
c.Zaffiro = c.zaffiro
c.zaffiroalpha = _colore("26649C", "729ABF", "194166")
c.Zaffiroalpha, c.ZaffiroAplha, c["Zaffiro Alpha"] =
    c.zaffiroalpha, c.zaffiroalpha, c.zaffiroalpha
c.sole = _colore("F2952D", "FFC587", "A45500")
c.Sole = c.sole
c.luna = _colore("5599C8", "9ACFF4", "155785")
c.Luna = c.luna
c.ultrasole = _colore("EE7936", "FFB58C", "B54000")
c.Ultrasole = c.ultrasole
c.ultraluna = _colore("884799", "AF8DB7", "440E52")
c.Ultraluna = c.ultraluna
c.LG_pikachu = _colore("ffcf11", "fff4c3", "d09e2a")
c["LG Pikachu"], c.LG_Pikachu, c.lg_pikachu, c.LGP =
    c.LG_pikachu, c.LG_pikachu, c.LG_pikachu, c.LG_pikachu
c.lgp, c.lgpikachu, c["Let's Go, Pikachu!"] =
    c.LG_pikachu, c.LG_pikachu, c.LG_pikachu
c.LG_eevee = _colore("c47e39", "f9c876", "6a3f31")
c["LG Eevee"], c.LG_Eevee, c.lg_eevee, c.LGE =
    c.LG_eevee, c.LG_eevee, c.LG_eevee, c.LG_eevee
c.lge, c.lgeevee, c["Let's Go, Eevee!"] = c.LG_eevee, c.LG_eevee, c.LG_eevee
c.conquest = _colore("EC9722", "F8DF9D", "945F13")
c.Conquest = c.conquest
c.spada = _colore("00AEEF", "6AE5FF", "0079CD")
c.Spada = c.spada
c.scudo = _colore("ED1165", "FA89AB", "851042")
c.Scudo = c.scudo
c.isolaarmatura = _colore("F5E036", "FFFAA9", "F7AF00")
c.Isolaarmatura = c.isolaarmatura
c.landacorona = _colore("009D88", "00D668", "004C65")
c.Landacorona = c.landacorona
c.diamantelucente = _colore("01A4E7", "BFE4F6", "0154A4")
c["Diamante Lucente"], c["diamante lucente"] =
    c.diamantelucente, c.diamantelucente
c.perlasplendente = _colore("C584DD", "DBC1E4", "875D96")
c["Perla Splendente"], c["perla splendente"] =
    c.perlasplendente, c.perlasplendente
c.leggendearceus = _colore("CECDBE", "EFEEE1", "9B9A8F")
c["Leggende Pokémon: Arceus"], c["Leggende Arceus"], c["leggende arceus"] =
    c.leggendearceus, c.leggendearceus, c.leggendearceus
c.scarlatto = _colore("D90D19", "FF8088", "700007")
c.Scarlatto = c.scarlatto
c.violetto = _colore("842F8C", "C787C7", "39003E")
c.Violetto = c.violetto
c.mascheraturchese = _colore("00A29A", "70ECE6", "005955")
c.Mascheraturchese = c.mascheraturchese
c.discoindaco = _colore("094260", "528CAB", "002030")
c.Discoindaco = c.discoindaco

-- Regions

c.kanto = _colore("FF173D", "FF6680", "870018")
c.Kanto = c.kanto
c.johto = _colore("FF6600", "FFB287", "C33E00")
c.Johto = c.johto
c.hoenn = _colore("FFCE1C", "FFFF7D", "D9B200")
c.Hoenn = c.hoenn
c.sinnoh = _colore("9ECF17", "DEFF70", "649600")
c.Sinnoh = c.sinnoh
c.unima = _colore("00C200", "66FF36", "299100")
c.Unima, c.unova, c.Unova = c.unima, c.unima, c.unima
c.kalos = _colore("1FE0B4", "A1FFE1", "00A388")
c.Kalos = c.kalos
c.alola = _colore("00A2FF", "73DCFF", "004FFF")
c.Alola = c.alola
c.galar = _colore("FF3DF0", "FF85F7", "B81684")
c.Galar = c.galar
c.hisui, c.Hisui = c.sinnoh, c.sinnoh
c.paldea = _colore("A8A8A8", "D1D1D1", "707070")
c.Paldea = c.paldea
c.luminopoli, c.Luminopoli = c.kalos, c.kalos

c.settipelago = _colore("52CC91", "8DEBBC", "2B915E")
c.Settipelago = c.settipelago
c.auros = _colore("817548", "ADA588", "544C2F")
c.Auros, c.orre, c.Orre = c.auros, c.auros, c.auros
c.kaloscentrale = _colore("D1D1D1", "EAEAEA", "BBBBBB")
c.Kaloscentrale, c.Kalosce, c.kalosce =
    c.kaloscentrale, c.kaloscentrale, c.kaloscentrale
c["kalos centrale"], c["Kalos centrale"], c.kalosCentrale =
    c.kaloscentrale, c.kaloscentrale, c.kaloscentrale
c.kaloscostiera = _colore("013D6C", "026FC4", "002847")
c.Kaloscostiera, c.Kalosco, c.kalosco =
    c.kaloscostiera, c.kaloscostiera, c.kaloscostiera
c["kalos costiera"], c["Kalos costiera"], c.kalosCostiera =
    c.kaloscostiera, c.kaloscostiera, c.kaloscostiera
c.kalosmontana = _colore("981128", "EA1A3E", "76071A")
c.Kalosmontana, c.Kalosmo, c.kalosmo =
    c.kalosmontana, c.kalosmontana, c.kalosmontana
c["kalos montana"], c["Kalos montana"], c.kalosMontana =
    c.kalosmontana, c.kalosmontana, c.kalosmontana
c.orange = _colore("FF7F00", "FFAC59", "A65300")
c.Orange = c.orange
c.cristalline = _colore("FFB200", "FFD36B", "AE7E00")
c.Cristalline, c.decolora, c.Decolora =
    c.cristalline, c.cristalline, c.cristalline
c.melemele = c.giallo
c.Melemele, c["mele mele"], c["Mele mele"], c["Mele Mele"] =
    c.melemele, c.melemele, c.melemele, c.melemele
c.akala = c.psico
c.Akala = c.akala
c.ulaula = c.rosso
c.Ulaula, c["ula ula"], c["Ula ula"], c["Ula Ula"] =
    c.ulaula, c.ulaula, c.ulaula, c.ulaula
c.poni = c.spettro
c.Poni = c.poni
c.nordivia = c.mascheraturchese
c.Nordivia = c.nordivia

c.fiore, c.Fiore = c.ranger, c.ranger
c.almia, c.Almia = c.OsA, c.OsA
c.oblivia, c.Oblivia = c.TL, c.TL
c.pasio, c.Pasio = c.orange, c.orange

-- Stats

c.abilita = _colore("317BEE", "83B4FF", "2052A4")
c.Abilita, c["Abilità"], c["abilità"] = c.abilita, c.abilita, c.abilita
c.agilita = _colore("38BD62", "83EEA4", "188339")
c.Agilita, c["Agilità"], c["agilità"] = c.agilita, c.agilita, c.agilita
c.attacco = _colore("EACA2F", "FFFBE6", "B88C00")
c.Attacco, c.atk = c.attacco, c.attacco
c.attacco_speciale = _colore("26BAE0", "B2E3EF", "15687D")
c.Attacco_speciale, c.attaccospeciale, c.spatk =
    c.attacco_speciale, c.attacco_speciale, c.attacco_speciale
c["attacco speciale"], c["Attacco speciale"] =
    c.attacco_speciale, c.attacco_speciale
c.difesa = _colore("E5721D", "FFC499", "8E3600")
c.Difesa, c.def = c.difesa, c.difesa
c.difesa_speciale = _colore("4C6CD4", "9EB5FF", "0A163D")
c.Difesa_speciale, c.difesaspeciale, c.spdef =
    c.difesa_speciale, c.difesa_speciale, c.difesa_speciale
c["difesa speciale"], c["Difesa speciale"] =
    c.difesa_speciale, c.difesa_speciale
c.forza = _colore("FF4131", "FF9494", "BD2018")
c.Forza = c.forza
c.PS = _colore("58E810", "E1FFD3", "2E7A08")
c.Ps, c.ps, c.hp = c.PS, c.PS, c.PS
c.resistenza = _colore("EECD31", "FFE683", "C58308")
c.Resistenza = c.resistenza
c.speciali = _colore("3ECDB4", "A3FFEF", "179881")
c.Speciali, c.spec = c.speciali, c.speciali
c.velocita = _colore("D425CE", "EF8DEC", "380036")
c.Velocita, c.spe = c.velocita, c.velocita
c["Velocità"], c["velocità"] = c.velocita, c.velocita
c.thlon = _colore("90a8e0", "B7C6EB", "5E6D92")
c.Thlon, c["PokéAthlon"], c["pokéathlon"] = c.thlon, c.thlon, c.thlon

-- Colori zone
-- NB: La regex è {{colorezona/(.*?)|(.*?)}} --> {{#invoke: colore | zona_$2 | $1}}, con le variabili invertite.
-- E prima va fatto {{colorezona/text|(.*?)}} --> {{#invoke: colore | zona_text | $1}}
-- E prima ancora {{colorezona/(.*?)}} --> {{#invoke: colore | zona_terra | $1}}

c.zona_grotta = _colore("CC8F66", "E0B192", "A66A42")
c.zona_cave, c.zona_Grotta, c.zona_caverna =
    c.zona_grotta, c.zona_grotta, c.zona_grotta
c.zona_terra = _colore("75C977", "A2E0A3", "4AA14D")
c.zona_Terra, c.zona_land = c.zona_terra, c.zona_terra
c.zona_foresta = _colore("3A822D", "71AD64", "34612D")
c.zona_Foresta, c.zona_bosco, c.zona_forest =
    c.zona_foresta, c.zona_foresta, c.zona_foresta
c.zona_nebbia = _colore("B5ADC7", "CAC1DE", "9E98AD")
c.zona_Nebbia, c.zona_fog = c.zona_nebbia, c.zona_nebbia
c.zona_palude = _colore("7792BD", "BDA595", "3D6633")
c.zona_Palude, c.zona_marsh = c.zona_palude, c.zona_palude
c.zona_cenere = _colore("9C8583", "B8A09E", "856765")
c.zona_Cenere, c.zona_ash = c.zona_cenere, c.zona_cenere
c.zona_rovine = _colore("BFB895", "EBE5CA", "9E9773")
c.zona_Rovine, c.zona_ruins = c.zona_rovine, c.zona_rovine
c.zona_sabbia = _colore("D6BD7C", "DBCFA0", "B59B59")
c.zona_Sabbia, c.zona_deserto, c.zona_sand =
    c.zona_sabbia, c.zona_sabbia, c.zona_sabbia
c.zona_lago = _colore("66BDCC", "85D4DE", "538FBD")
c.zona_Lago, c.zona_lake = c.zona_lago, c.zona_lago
c.zona_oceano = _colore("485CC2", "5A98F5", "1E3F94")
c.zona_Oceano, c.zona_ocean = c.zona_oceano, c.zona_oceano
c.zona_sottacqua = _colore("6053AD", "737AC7", "553894")
c.zona_Sottacqua, c.zona_underwater = c.zona_sottacqua, c.zona_sottacqua
c.zona_montagna = _colore("B8907D", "D4B5A7", "7A5443")
c.zona_Montagna, c.zona_mountain = c.zona_montagna, c.zona_montagna
c.zona_vulcano = _colore("D20000", "D23434", "A30000")
c.zona_Vulcano, c.zona_volcano = c.zona_vulcano, c.zona_vulcano
c.zona_neve = _colore("DCEBEF", "E1EFF2", "BBCDD1")
c.zona_Neve, c.zona_snow = c.zona_neve, c.zona_neve
c.zona_spazio = _colore("222222", "555555", "000000")
c.zona_Spazio, c.zona_space = c.zona_spazio, c.zona_spazio
c.zona_distorsione = _colore("5A65DB", "CC8562", "2622A8")
c.zona_Distorsione, c.zona_distortion = c.zona_distorsione, c.zona_distorsione
c.zona_ombra = _colore("472E63", "604E82", "1A0A2C")
c.zona_Ombra, c.zona_shadow = c.zona_ombra, c.zona_ombra
c.zona_edificio = _colore("A8B9BD", "C3D8DE", "8A9CA1")
c.zona_Edificio, c.zona_building, c.zona_palazzo =
    c.zona_edificio, c.zona_edificio, c.zona_edificio
c.zona_strada = _colore("ABA9A4", "CFCDC7", "949391")
c.zona_Strada, c.zona_road = c.zona_strada, c.zona_strada
c.zona_citta = _colore("D9D9D9", "E6E6E6", "CCCCCC")
c.zona_Citta, c.zona_city, c.zona_City =
    c.zona_citta, c.zona_citta, c.zona_citta
c["zona_città"], c["zona_Città"] = c.zona_citta, c.zona_citta
c.zona_normale, c.zona_Normale = c.normale, c.normale
c.zona_fuoco, c.zona_Fuoco = c.fuoco, c.fuoco
c.zona_acqua, c.zona_Acqua = c.acqua, c.acqua
c.zona_erba, c.zona_Erba = c.erba, c.erba
c.zona_elettro, c.zona_Elettro = c.elettro, c.elettro
c.zona_lotta, c.zona_Lotta = c.lotta, c.lotta
c.zona_volante, c.zona_Volante = c.volante, c.volante
c.zona_veleno, c.zona_Veleno = c.veleno, c.veleno
c.zona_coleot, c.zona_Coleot = c.coleottero, c.coleottero
c.zona_coleottero, c.zona_Coleottero = c.coleottero, c.coleottero
c.zona_roccia, c.zona_Roccia = c.roccia, c.roccia
c.zona_terratipo, c.zona_Terratipo = c.terra, c.terra
c.zona_psico, c.zona_Psico = c.psico, c.psico
c.zona_ghiaccio, c.zona_Ghiaccio = c.ghiaccio, c.ghiaccio
c.zona_drago, c.zona_Drago = c.drago, c.drago
c.zona_spettro, c.zona_Spettro = c.spettro, c.spettro
c.zona_buio, c.zona_Buio = c.buio, c.buio
c.zona_acciaio, c.zona_Acciaio = c.acciaio, c.acciaio
c.zona_folletto, c.zona_Folletto = c.folletto, c.folletto
c.zona_rosso, c.zona_Rosso = c.rosso, c.rosso
c.zona_blu, c.zona_Blu = c.blu, c.blu
c.zona_verde, c.zona_Verde = c.verde, c.verde
c.zona_giallo, c.zona_Giallo = c.giallo, c.giallo
c.zona_arena, c.zona_Arena = c.arena, c.arena
c.zona_azienda, c.zona_Azienda = c.azienda, c.azienda
c.zona_cupola, c.zona_Cupola = c.cupola, c.cupola
c.zona_dojo, c.zona_Dojo = c.dojo, c.dojo
c.zona_maniero, c.zona_Maniero = c.maniero, c.maniero
c.zona_palazzo, c.zona_Palazzo = c.palazzo, c.palazzo
c.zona_palco, c.zona_Palco = c.palco, c.palco
c.zona_parcolotta, c.zona_Parcolotta, c.zona_Parco_lotta, c.zona_parco_lotta =
    c.parco_lotta, c.parco_lotta, c.parco_lotta, c.parco_lotta
c.zona_piramide, c.zona_Piramide = c.piramide, c.piramide
c.zona_serpe, c.zona_Serpe = c.serpe, c.serpe
c.zona_torre, c.zona_Torre = c.torre, c.torre

c.zona_text = function(frame)
    local zone = string.trim(frame.args[1] or ""):lower()
    local colors = {
        palude = "573118",
        vulcano = "FFBC00",
        spazio = "FFFFFF",
        distorsione = "E0FAFF",
    }
    colors.marsh = colors.palude
    colors.volcano = colors.vulcano
    colors.space, colors.shadow, colors.ombra =
        colors.spazio, colors.spazio, colors.spazio
    colors.distortion = colors.distorsione
    return colors[zone] or "000000"
end

-- Colore pcwiki

c.pcwiki = function(frame)
    local var = (string.trim(frame.args[1] or "normale")):lower()
    local colors = {
        ["medium light"] = "B1D6FF",
        ["medium dark"] = "5BA0FF",
        normale = "7CBAFF",
        light = "D0E6FF",
        dark = "0078FF",
    }
    return colors[var]
end
c.PCWiki, c.PCwiki = c.pcwiki, c.pcwiki

-- Colori ore

c.giorno = _colore("5ED0FF", "96E0FF", "4192B3")
c.Giorno = c.giorno
c.mattina = _colore("FFFFAA", "FFFFC8", "B3B377")
c.Mattina = c.mattina
c.notte = _colore("003366", "597A9B", "002347")
c.Notte = c.notte
c.sera = _colore("FF8741", "FEAD7E", "AD3F00")
c.Sera = c.sera
c.Giorno_text = const("000000")
c.giorno_text = c.Giorno_text
c.Mattina_text = const("000000")
c.mattina_text = c.Mattina_text
c.Notte_text = const("FFFF99")
c.notte_text = c.Notte_text
c.sera_text = const("000000")
c.Sera_text = c.sera_text

-- Colori stagioni

c.autunno = _colore("F89058", "FAB189", "AE653D")
c.Autunno = c.autunno
c.inverno = _colore("F0D8F8", "F4E3FA", "A897AE")
c.Inverno = c.inverno
c.estate = _colore("78D0F8", "A0DEFA", "5492AE")
c.Estate = c.estate
c.primavera = _colore("B0F858", "C7FA89", "7BAE3D")
c.Primavera = c.primavera

-- Colori giorni della settimana (NOTA: questi colori non hanno shade)
c.lunedi = const("FF0000")
c.Lunedi, c["lunedì"], c["Lunedì"] = c.lunedi, c.lunedi, c.lunedi
c.martedi = const("FF7F00")
c.Martedi, c["martedì"], c["Martedì"] = c.martedi, c.martedi, c.martedi
c.mercoledi = const("F9CB00")
c.Mercoledi, c["mercoledì"], c["Mercoledì"] =
    c.mercoledi, c.mercoledi, c.mercoledi
c.giovedi = const("00CE00")
c.Giovedi, c["giovedì"], c["Giovedì"] = c.giovedi, c.giovedi, c.giovedi
c.venerdi = const("0000FF")
c.Venerdi, c["venerdì"], c["Venerdì"] = c.venerdi, c.venerdi, c.venerdi
c.sabato = const("4B0082")
c.Sabato = c.sabato
c.domenica = const("9400D3")
c.Domenica = c.domenica

-- Colori gare

c.acume = _colore("78C850", "A7DB8D", "4E8234")
c.Acume, c.Amaro, c.amaro = c.acume, c.acume, c.acume
c.bellezza = _colore("6890F0", "9DB7F5", "445E9C")
c.Bellezza, c.Secco, c.secco = c.bellezza, c.bellezza, c.bellezza
c.classe = _colore("F08030", "F5AC78", "9C531F")
c.Classe, c.Pepato, c.pepato = c.classe, c.classe, c.classe
c.gara = _colore("E090A8", "EBB7C6", "925E6D")
c.Gara = c.gara
c.grazia = _colore("F85888", "FA92B2", "A13959")
c.Grazia, c.Dolce, c.dolce = c.grazia, c.grazia, c.grazia
c.grinta = _colore("F8D030", "FAE078", "A1871F")
c.Grinta, c.Aspro, c.aspro = c.grinta, c.grinta, c.grinta

-- Colori gcc

c.acqua_gcc = _colore("5BC7E5", "94DBEE", "3B8295")
c.Acqua_gcc, c["acqua gcc"], c["Acqua gcc"] =
    c.acqua_gcc, c.acqua_gcc, c.acqua_gcc
c.lampo_gcc = _colore("FAB536", "FCCE7C", "A37523")
c.Lampo_gcc, c["lampo gcc"], c["Lampo gcc"] =
    c.lampo_gcc, c.lampo_gcc, c.lampo_gcc
c.drago_gcc = _colore("C6A114", "DAC266", "81690D")
c.Drago_gcc, c["drago gcc"], c["Drago gcc"] =
    c.drago_gcc, c.drago_gcc, c.drago_gcc
c.erba_gcc = _colore("7DB808", "AAD15E", "517805")
c.Erba_gcc, c["erba gcc"], c["Erba gcc"] = c.erba_gcc, c.erba_gcc, c.erba_gcc
c.folletto_gcc = _colore("E03A83", "EA7EAE", "912555")
c.Folletto_gcc, c["folletto gcc"], c["Folletto gcc"] =
    c.folletto_gcc, c.folletto_gcc, c.folletto_gcc
c.fuoco_gcc = _colore("E24242", "EC8484", "932B2B")
c.Fuoco_gcc, c["fuoco gcc"], c["Fuoco gcc"] =
    c.fuoco_gcc, c.fuoco_gcc, c.fuoco_gcc
c.incolore_gcc = _colore("E5D6D0", "EEE4E0", "958B87")
c.Incolore_gcc, c["incolore gcc"], c["Incolore gcc"] =
    c.incolore_gcc, c.incolore_gcc, c.incolore_gcc
c.arcobaleno_gcc, c.Arcobaleno_gcc, c["arcobaleno gcc"], c["Arcobaleno gcc"] =
    c.incolore_gcc, c.incolore_gcc, c.incolore_gcc, c.incolore_gcc
c.metallo_gcc = _colore("8A776E", "B3A6A1", "5A4D48")
c.Metallo_gcc, c["metallo gcc"], c["Metallo gcc"] =
    c.metallo_gcc, c.metallo_gcc, c.metallo_gcc
c.oscurita_gcc = _colore("2C2E2B", "767775", "1D1E1C")
c.Oscurita_gcc, c["oscurita gcc"], c["Oscurita gcc"] =
    c.oscurita_gcc, c.oscurita_gcc, c.oscurita_gcc
c["oscurità_gcc"], c["Oscurità_gcc"], c["oscurità gcc"], c["Oscurità gcc"] =
    c.oscurita_gcc, c.oscurita_gcc, c.oscurita_gcc, c.oscurita_gcc
c.psiche_gcc = _colore("A65E9A", "C596BD", "6C3D64")
c.Psiche_gcc, c["psiche gcc"], c["Psiche gcc"] =
    c.psiche_gcc, c.psiche_gcc, c.psiche_gcc
c.supporto_gcc = _colore("DC2222", "E66363", "9A1717")
c.Supporto_gcc, c["supporto gcc"], c["Supporto gcc"] =
    c.supporto_gcc, c.supporto_gcc, c.supporto_gcc
c.aiuto_gcc, c.Aiuto_gcc, c["aiuto gcc"], c["Aiuto gcc"] =
    c.supporto_gcc, c.supporto_gcc, c.supporto_gcc, c.supporto_gcc
c.combattimento_gcc = _colore("FF501F", "FF8D6D", "A63414")
c.Combattimento_gcc, c["combattimento gcc"], c["Combattimento gcc"] =
    c.combattimento_gcc, c.combattimento_gcc, c.combattimento_gcc
c.allenatore_gcc = _colore("FFE955", "FFFCE4", "B3A33B")
c.Allenatore_gcc, c["allenatore gcc"], c["Allenatore gcc"] =
    c.allenatore_gcc, c.allenatore_gcc, c.allenatore_gcc
c.trainer_gcc, c.Trainer_gcc, c["trainer gcc"], c["Trainer gcc"] =
    c.allenatore_gcc, c.allenatore_gcc, c.allenatore_gcc, c.allenatore_gcc
c["pokébody_gcc"] = _colore("146837", "5A9572", "0E4926")
c["Pokébody_gcc"], c["pokébody gcc"], c["Pokébody gcc"] =
    c["pokébody_gcc"], c["pokébody_gcc"], c["pokébody_gcc"]
c["poké-body_gcc"], c["Poké-body_gcc"], c["poké-body gcc"], c["Poké-body gcc"] =
    c["pokébody_gcc"],
    c["pokébody_gcc"],
    c["pokébody_gcc"],
    c["pokébody_gcc"]
c["poképower_gcc"] = _colore("850921", "A95263", "5D0617")
c["Poképower_gcc"], c["poképower gcc"], c["Poképower gcc"] =
    c["poképower_gcc"], c["poképower_gcc"], c["poképower_gcc"]
c["poké-power_gcc"], c["Poké-power_gcc"], c["poké-power gcc"], c["Poké-power gcc"] =
    c["poképower_gcc"],
    c["poképower_gcc"],
    c["poképower_gcc"],
    c["poképower_gcc"]
c.abilita_gcc = _colore("C84923", "D87F64", "8C3318")
c.Abilita_gcc, c["abilita gcc"], c["Abilita gcc"] =
    c.abilita_gcc, c.abilita_gcc, c.abilita_gcc
c["abilità_gcc"], c["Abilità_gcc"], c["abilità gcc"], c["Abilità gcc"] =
    c.abilita_gcc, c.abilita_gcc, c.abilita_gcc, c.abilita_gcc
c.strumento_gcc = _colore("7777EE", "A6A6F4", "4D4D9B")
c.Strumento_gcc, c["strumento gcc"], c["Strumento gcc"] =
    c.strumento_gcc, c.strumento_gcc, c.strumento_gcc
c.stadio_gcc = _colore("90E183", "B7EBAE", "5E9255")
c.Stadio_gcc, c["stadio gcc"], c["Stadio gcc"] =
    c.stadio_gcc, c.stadio_gcc, c.stadio_gcc

-- Colori Parco Lotta

c.arena = _colore("FFC115", "FFD767", "A67E0E")
c.Arena = c.arena
c.azienda = _colore("3291C1", "7AB7D7", "215E7E")
c.Azienda, c.fabbrica, c.Fabbrica = c.azienda, c.azienda, c.azienda
c.cupola = _colore("AD32DA", "D35CFF", "71009B")
c.Cupola = c.cupola
c.dojo = _colore("20811D", "2DBA29", "043503")
c.Dojo = c.dojo
c.maniero = _colore("40AD72", "83CAA3", "2A714A")
c.Maniero = c.maniero
c.palazzo = _colore("F6F60A", "FFFF67", "888600")
c.Palazzo = c.palazzo
c.palco = _colore("F87A97", "FFADC0", "A14F62")
c.Palco = c.palco
c.parco_lotta = _colore("3FA9D0", "82C7E0", "296E87")
c.Parco_lotta, c.Parco_Lotta, c.Parcolotta, c.parcolotta =
    c.parco_lotta, c.parco_lotta, c.parco_lotta, c.parco_lotta
c.piramide = _colore("FF5900", "FF9049", "A13500")
c.Piramide = c.piramide
c.serpe = _colore("7D000C", "B51826", "300105")
c.Serpe = c.serpe
c.torre = _colore("D6553C", "E49080", "8B3727")
c.Torre = c.torre

-- Colori tasche

c.bacche = _colore("6161FD", "BBC5FF", "08088C")
c.Bacche = c.bacche
c.macchine = _colore("9248E5", "D4ABFD", "1F0042")
c.Macchine, c["MT e MN"] = c.macchine, c.macchine
c["pokéball"] = _colore("C88820", "E0A038", "B87008")
c["Pokéball"], c["poké Ball"], c["Poké Ball"], c["PokéBall"] =
    c["pokéball"], c["pokéball"], c["pokéball"], c["pokéball"]
c.rimedi = _colore("00BE00", "99FF99", "006100")
c.Rimedi = c.rimedi
c.strumenti = _colore("0296C8", "6DE0FF", "00384B")
c.Strumenti = c.strumenti
c.strumentibase = _colore("F93333", "FFA7A7", "8E0808")
c.Strumentibase, c["strumenti base"], c["Strumenti base"] =
    c.strumentibase, c.strumentibase, c.strumentibase
c.strumentilotta = _colore("3070E0", "4880F0", "2058C8")
c.Strumentilotta, c["strumenti lotta"], c["Strumenti lotta"] =
    c.strumentilotta, c.strumentilotta, c.strumentilotta
c.strumentivari, c["strumenti vari"], c["Strumenti vari"], c["strumenti Vari"], c["Strumenti Vari"] =
    c.strumenti, c.strumenti, c.strumenti, c.strumenti, c.strumenti
c.messaggi = _colore("1890B0", "18A8D0", "208090")
c.Messaggi = c.messaggi
c.cristalliz = _colore("AB6900", "FFB744", "4D1F00")
c.Cristalliz, c.cristalliZ, c.CristalliZ =
    c.cristalliz, c.cristalliz, c.cristalliz
c["cristalli z"], c["Cristalli z"], c["cristalli Z"], c["Cristalli Z"] =
    c.cristalliz, c.cristalliz, c.cristalliz, c.cristalliz
c.cristalli_z, c.Cristalli_z, c.cristalli_Z, c.Cristalli_Z =
    c.cristalliz, c.cristalliz, c.cristalliz, c.cristalliz
c.Tesori, c.tesori = c.oro, c.oro

-- Colori gruppi uova

c.mostro_uova = _colore("D25064", "D25064", "933846")
c.Mostro_uova = c.mostro_uova
c["acqua_1_uova"] = _colore("97B5FD", "97B5FD", "697FB1")
c["Acqua_1_uova"], c["acqua 1_uova"], c["Acqua 1_uova"] =
    c["acqua_1_uova"], c["acqua_1_uova"], c["acqua_1_uova"]
c.coleottero_uova = _colore("AAC22A", "AAC22A", "77881D")
c.Coleottero_uova = c.coleottero_uova
c.volante_uova = _colore("B29AFA", "B29AFA", "7C6CAF")
c.Volante_uova = c.volante_uova
c.campo_uova = _colore("E0C068", "E0C068", "9D8649")
c.Campo_uova = c.campo_uova
c.magico_uova = _colore("FFC8F0", "FFC8F0", "B38CA8")
c.Magico_uova = c.magico_uova
c.erba_uova = _colore("82D25A", "82D25A", "5B933F")
c.Erba_uova = c.erba_uova
c.umanoide_uova = _colore("D29682", "D29682", "93695B")
c.Umanoide_uova = c.umanoide_uova
c["acqua_3_uova"] = _colore("5876BE", "5876BE", "3D5285")
c["Acqua_3_uova"], c["acqua 3_uova"], c["Acqua 3_uova"] =
    c["acqua_3_uova"], c["acqua_3_uova"], c["acqua_3_uova"]
c.minerale_uova = _colore("7A6252", "7A6252", "554439")
c.Minerale_uova = c.minerale_uova
c.amorfo_uova = _colore("8A8A8A", "8A8A8A", "606060")
c.Amorfo_uova = c.amorfo_uova
c["acqua_2_uova"] = _colore("729AFA", "729AFA", "506CAF")
c["Acqua_2_uova"], c["acqua 2_uova"], c["Acqua 2_uova"] =
    c["acqua_2_uova"], c["acqua_2_uova"], c["acqua_2_uova"]
c.ditto_uova = _colore("A664BF", "A664BF", "744686")
c.Ditto_uova = c.ditto_uova
c.drago_uova = _colore("7A42FF", "7A42FF", "552EB3")
c.Drago_uova = c.drago_uova
c.sconosciuto_uova = _colore("0080C0", "0080C0", "005986")
c.Sconosciuto_uova = c.sconosciuto_uova
c.asessuato_uova = _colore("333333", "333333", "232323")
c.Asessuato_uova = c.asessuato_uova
c.genere_sconosciuto_uova, c.Genere_sconosciuto_uova =
    c.asessuato_uova, c.asessuato_uova
c["genere sconosciuto_uova"], c["Genere sconosciuto_uova"] =
    c.asessuato_uova, c.asessuato_uova

-- Varie ed eventuali

c.arancione, c.Arancione = c.orange, c.orange
c.bulba = _colore("C4E673", "E0F2B6", "80964B")
c.Bulba = c.bulba
c.background = const("EAEAEA")
c.Background = c.background
c["club pokémiglia"] = _colore("389AD8", "9ECEEC", "075282")
c["Club pokémiglia"], c["club_pokémiglia"], c["Club_pokémiglia"] =
    c["club pokémiglia"], c["club pokémiglia"], c["club pokémiglia"]
c.FFFFFF = const("FFFFFF")
c.ffffff = c.FFFFFF
c["000000"] = const("000000")
c["000"] = c["000000"]
c.bronzo = _colore("DEAB79", "EBCDAF", "856749")
c.Bronzo = c.bronzo
c.camilla = _colore("525252", "8E8E8E", "353535")
c.Camilla = c.camilla
c.nardo = _colore("E88058", "F0AA8F", "C84040")
c.Nardo = c.nardo
c.diantha = _colore("E64A80", "F08FB1", "A5385C")
c.Diantha = c.diantha
c.dw = _colore("E78EA0", "F3DBDE", "984852")
c.Dw, c.DW, c.dream_world, c.Dream_world, c["dream world"], c["Dream world"] =
    c.dw, c.dw, c.dw, c.dw, c.dw, c.dw
c.ghicocca = _colore("F0A018", "F8C038", "A05840")
c.Ghicocca, c.ghicocche = c.ghicocca, c.ghicocca
c.olio = _colore("BAB1C9", "DCD7E3", "978CAE")
c.Olio = c.olio
c["pokéwalker"] = _colore("D82D40", "ED7B88", "700A16")
c["Pokéwalker"], c.pokewalker, c.Pokewalker =
    c["pokéwalker"], c["pokéwalker"], c["pokéwalker"]
c["safari amici"] = _colore("68AA57", "AFDBA5", "447039")
c["Safari amici"], c.safari_amici, c.Safari_amici =
    c["safari amici"], c["safari amici"], c["safari amici"]
c["Parco amici"], c["parco amici"], c.Parco_amici, c.parco_amici =
    c["zona_terra"], c["zona_terra"], c["zona_terra"], c["zona_terra"]
c.HOME, c.Home, c.home = c.agilita, c.agilita, c.agilita
c.teamrocket = _colore("4F5253", "B92C1A", "EAEAEA")
c.TeamRocket, c["team rocket"], c["Team Rocket"], c.team_rocket, c.Team_Rocket =
    c.teamrocket, c.teamrocket, c.teamrocket, c.teamrocket, c.teamrocket

return c
