-- Modulo di tabelle dati sui Pokémon. Tutti gli indici sono in minuscolo;

local t = {}

-- Contiene la table con numero del dex nazionale, nome, e tipo/i dei Pokémon
-- ognuno raggiungibile sia tramite il nome che il numero.

t.bulbasaur = {name = 'Bulbasaur', ndex = 1, type1 = 'erba', type2 = 'veleno'}
t[1] = t.bulbasaur
t.ivysaur = {name = 'Ivysaur', ndex = 2, type1 = 'erba', type2 = 'veleno'}
t[2] = t.ivysaur
t.venusaur = {name = 'Venusaur', ndex = 3, type1 = 'erba', type2 = 'veleno'}
t[3] = t.venusaur
t.charmander = {name = 'Charmander', ndex = 4, type1 = 'fuoco', type2 = 'fuoco'}
t[4] = t.charmander
t.charmeleon = {name = 'Charmeleon', ndex = 5, type1 = 'fuoco', type2 = 'fuoco'}
t[5] = t.charmeleon
t.charizard = {name = 'Charizard', ndex = 6, type1 = 'fuoco', type2 = 'volante'}
t[6] = t.charizard
t.squirtle = {name = 'Squirtle', ndex = 7, type1 = 'acqua', type2 = 'acqua'}
t[7] = t.squirtle
t.wartortle = {name = 'Wartortle', ndex = 8, type1 = 'acqua', type2 = 'acqua'}
t[8] = t.wartortle
t.blastoise = {name = 'Blastoise', ndex = 9, type1 = 'acqua', type2 = 'acqua'}
t[9] = t.blastoise
t.caterpie = {name = 'Caterpie', ndex = 10, type1 = 'coleottero', type2 = 'coleottero'}
t[10] = t.caterpie
t.metapod = {name = 'Metapod', ndex = 11, type1 = 'coleottero', type2 = 'coleottero'}
t[11] = t.metapod
t.butterfree = {name = 'Butterfree', ndex = 12, type1 = 'coleot', type2 = 'volante'}
t[12] = t.butterfree
t.weedle = {name = 'Weedle', ndex = 13, type1 = 'coleot', type2 = 'veleno'}
t[13] = t.weedle
t.kakuna = {name = 'Kakuna', ndex = 14, type1 = 'coleot', type2 = 'veleno'}
t[14] = t.kakuna
t.beedrill = {name = 'Beedrill', ndex = 15, type1 = 'coleot', type2 = 'veleno'}
t[15] = t.beedrill
t.pidgey = {name = 'Pidgey', ndex = 16, type1 = 'normale', type2 = 'volante'}
t[16] = t.pidgey
t.pidgeotto = {name = 'Pidgeotto', ndex = 17, type1 = 'normale', type2 = 'volante'}
t[17] = t.pidgeotto
t.pidgeot = {name = 'Pidgeot', ndex = 18, type1 = 'normale', type2 = 'volante'}
t[18] = t.pidgeot
t.rattata = {name = 'Rattata', ndex = 19, type1 = 'normale', type2 = 'normale'}
t[19] = t.rattata
t.raticate = {name = 'Raticate', ndex = 20, type1 = 'normale', type2 = 'normale'}
t[20] = t.raticate
t.spearow = {name = 'Spearow', ndex = 21, type1 = 'normale', type2 = 'volante'}
t[21] = t.spearow
t.fearow = {name = 'Fearow', ndex = 22, type1 = 'normale', type2 = 'volante'}
t[22] = t.fearow
t.ekans = {name = 'Ekans', ndex = 23, type1 = 'veleno', type2 = 'veleno'}
t[23] = t.ekans
t.arbok = {name = 'Arbok', ndex = 24, type1 = 'veleno', type2 = 'veleno'}
t[24] = t.arbok
t.pikachu = {name = 'Pikachu', ndex = 25, type1 = 'elettro', type2 = 'elettro'}
t[25] = t.pikachu
t.raichu = {name = 'Raichu', ndex = 26, type1 = 'elettro', type2 = 'elettro'}
t[26] = t.raichu
t.sandshrew = {name = 'Sandshrew', ndex = 27, type1 = 'terra', type2 = 'terra'}
t[27] = t.sandshrew
t.sandslash = {name = 'Sandslash', ndex = 28, type1 = 'terra', type2 = 'terra'}
t[28] = t.sandslash
t['nidoran♀'] = {name = 'Nidoran♀', ndex = 29, type1 = 'veleno', type2 = 'veleno'}
t[29] = t['nidoran♀']
t.nidorina = {name = 'Nidorina', ndex = 30, type1 = 'veleno', type2 = 'veleno'}
t[30] = t.nidorina
t.nidoqueen = {name = 'Nidoqueen', ndex = 31, type1 = 'veleno', type2 = 'terra'}
t[31] = t.nidoqueen
t['nidoran♂'] = {name = 'Nidoran♂', ndex = 32, type1 = 'veleno', type2 = 'veleno'}
t[32] = t['nidoran♂']
t.nidorino = {name = 'Nidorino', ndex = 33, type1 = 'veleno', type2 = 'veleno'}
t[33] = t.nidorino
t.nidoking = {name = 'Nidoking', ndex = 34, type1 = 'veleno', type2 = 'terra'}
t[34] = t.nidoking
t.clefairy = {name = 'Clefairy', ndex = 35, type1 = 'folletto', type2 = 'folletto'}
t[35] = t.clefairy
t.clefable = {name = 'Clefable', ndex = 36, type1 = 'folletto', type2 = 'folletto'}
t[36] = t.clefable
t.vulpix = {name = 'Vulpix', ndex = 37, type1 = 'fuoco', type2 = 'fuoco'}
t[37] = t.vulpix
t.ninetales = {name = 'Ninetales', ndex = 38, type1 = 'fuoco', type2 = 'fuoco'}
t[38] = t.ninetales
t.jigglypuff = {name = 'Jigglypuff', ndex = 39, type1 = 'normale', type2 = 'folletto'}
t[39] = t.jigglypuff
t.wigglytuff = {name = 'Wigglytuff', ndex = 40, type1 = 'normale', type2 = 'folletto'}
t[40] = t.wigglytuff
t.zubat = {name = 'Zubat', ndex = 41, type1 = 'veleno', type2 = 'volante'}
t[41] = t.zubat
t.golbat = {name = 'Golbat', ndex = 42, type1 = 'veleno', type2 = 'volante'}
t[42] = t.golbat
t.oddish = {name = 'Oddish', ndex = 43, type1 = 'erba', type2 = 'veleno'}
t[43] = t.oddish
t.gloom = {name = 'Gloom', ndex = 44, type1 = 'erba', type2 = 'veleno'}
t[44] = t.gloom
t.vileplume = {name = 'Vileplume', ndex = 45, type1 = 'erba', type2 = 'veleno'}
t[45] = t.vileplume
t.paras = {name = 'Paras', ndex = 46, type1 = 'coleot', type2 = 'erba'}
t[46] = t.paras
t.parasect = {name = 'Parasect', ndex = 47, type1 = 'coleot', type2 = 'erba'}
t[47] = t.parasect
t.venonat = {name = 'Venonat', ndex = 48, type1 = 'coleot', type2 = 'veleno'}
t[48] = t.venonat
t.venomoth = {name = 'Venomoth', ndex = 49, type1 = 'coleot', type2 = 'veleno'}
t[49] = t.venomoth
t.diglett = {name = 'Diglett', ndex = 50, type1 = 'terra', type2 = 'terra'}
t[50] = t.diglett
t.dugtrio = {name = 'Dugtrio', ndex = 51, type1 = 'terra', type2 = 'terra'}
t[51] = t.dugtrio
t.meowth = {name = 'Meowth', ndex = 52, type1 = 'normale', type2 = 'normale'}
t[52] = t.meowth
t.persian = {name = 'Persian', ndex = 53, type1 = 'normale', type2 = 'normale'}
t[53] = t.persian
t.psyduck = {name = 'Psyduck', ndex = 54, type1 = 'acqua', type2 = 'acqua'}
t[54] = t.psyduck
t.golduck = {name = 'Golduck', ndex = 55, type1 = 'acqua', type2 = 'acqua'}
t[55] = t.golduck
t.mankey = {name = 'Mankey', ndex = 56, type1 = 'lotta', type2 = 'lotta'}
t[56] = t.mankey
t.primeape = {name = 'Primeape', ndex = 57, type1 = 'lotta', type2 = 'lotta'}
t[57] = t.primeape
t.growlithe = {name = 'Growlithe', ndex = 58, type1 = 'fuoco', type2 = 'fuoco'}
t[58] = t.growlithe
t.arcanine = {name = 'Arcanine', ndex = 59, type1 = 'fuoco', type2 = 'fuoco'}
t[59] = t.arcanine
t.poliwag = {name = 'Poliwag', ndex = 60, type1 = 'acqua', type2 = 'acqua'}
t[60] = t.poliwag
t.poliwhirl = {name = 'Poliwhirl', ndex = 61, type1 = 'acqua', type2 = 'acqua'}
t[61] = t.poliwhirl
t.poliwrath = {name = 'Poliwrath', ndex = 62, type1 = 'acqua', type2 = 'lotta'}
t[62] = t.poliwrath
t.abra = {name = 'Abra', ndex = 63, type1 = 'psico', type2 = 'psico'}
t[63] = t.abra
t.kadabra = {name = 'Kadabra', ndex = 64, type1 = 'psico', type2 = 'psico'}
t[64] = t.kadabra
t.alakazam = {name = 'Alakazam', ndex = 65, type1 = 'psico', type2 = 'psico'}
t[65] = t.alakazam
t.machop = {name = 'Machop', ndex = 66, type1 = 'lotta', type2 = 'lotta'}
t[66] = t.machop
t.machoke = {name = 'Machoke', ndex = 67, type1 = 'lotta', type2 = 'lotta'}
t[67] = t.machoke
t.machamp = {name = 'Machamp', ndex = 68, type1 = 'lotta', type2 = 'lotta'}
t[68] = t.machamp
t.bellsprout = {name = 'Bellsprout', ndex = 69, type1 = 'erba', type2 = 'veleno'}
t[69] = t.bellsprout
t.weepinbell = {name = 'Weepinbell', ndex = 70, type1 = 'erba', type2 = 'veleno'}
t[70] = t.weepinbell
t.victreebel = {name = 'Victreebel', ndex = 71, type1 = 'erba', type2 = 'veleno'}
t[71] = t.victreebel
t.tentacool = {name = 'Tentacool', ndex = 72, type1 = 'acqua', type2 = 'veleno'}
t[72] = t.tentacool
t.tentacruel = {name = 'Tentacruel', ndex = 73, type1 = 'acqua', type2 = 'veleno'}
t[73] = t.tentacruel
t.geodude = {name = 'Geodude', ndex = 74, type1 = 'roccia', type2 = 'terra'}
t[74] = t.geodude
t.graveler = {name = 'Graveler', ndex = 75, type1 = 'roccia', type2 = 'terra'}
t[75] = t.graveler
t.golem = {name = 'Golem', ndex = 76, type1 = 'roccia', type2 = 'terra'}
t[76] = t.golem
t.ponyta = {name = 'Ponyta', ndex = 77, type1 = 'fuoco', type2 = 'fuoco'}
t[77] = t.ponyta
t.rapidash = {name = 'Rapidash', ndex = 78, type1 = 'fuoco', type2 = 'fuoco'}
t[78] = t.rapidash
t.slowpoke = {name = 'Slowpoke', ndex = 79, type1 = 'acqua', type2 = 'psico'}
t[79] = t.slowpoke
t.slowbro = {name = 'Slowbro', ndex = 80, type1 = 'acqua', type2 = 'psico'}
t[80] = t.slowbro
t.magnemite = {name = 'Magnemite', ndex = 81, type1 = 'elettro', type2 = 'acciaio'}
t[81] = t.magnemite
t.magneton = {name = 'Magneton', ndex = 82, type1 = 'elettro', type2 = 'acciaio'}
t[82] = t.magneton
t['farfetch&#39;d'] = {name = "Farfetch'd", ndex = 83, type1 = 'normale', type2 = 'volante'}
t[83] = t['farfetch&#39;d']
t.doduo = {name = 'Doduo', ndex = 84, type1 = 'normale', type2 = 'volante'}
t[84] = t.doduo
t.dodrio = {name = 'Dodrio', ndex = 85, type1 = 'normale', type2 = 'volante'}
t[85] = t.dodrio
t.seel = {name = 'Seel', ndex = 86, type1 = 'acqua', type2 = 'acqua'}
t[86] = t.seel
t.dewgong = {name = 'Dewgong', ndex = 87, type1 = 'acqua', type2 = 'ghiaccio'}
t[87] = t.dewgong
t.grimer = {name = 'Grimer', ndex = 88, type1 = 'veleno', type2 = 'veleno'}
t[88] = t.grimer
t.muk = {name = 'Muk', ndex = 89, type1 = 'veleno', type2 = 'veleno'}
t[89] = t.muk
t.shellder = {name = 'Shellder', ndex = 90, type1 = 'acqua', type2 = 'acqua'}
t[90] = t.shellder
t.cloyster = {name = 'Cloyster', ndex = 91, type1 = 'acqua', type2 = 'ghiaccio'}
t[91] = t.cloyster
t.gastly = {name = 'Gastly', ndex = 92, type1 = 'spettro', type2 = 'veleno'}
t[92] = t.gastly
t.haunter = {name = 'Haunter', ndex = 93, type1 = 'spettro', type2 = 'veleno'}
t[93] = t.haunter
t.gengar = {name = 'Gengar', ndex = 94, type1 = 'spettro', type2 = 'veleno'}
t[94] = t.gengar
t.onix = {name = 'Onix', ndex = 95, type1 = 'roccia', type2 = 'terra'}
t[95] = t.onix
t.drowzee = {name = 'Drowzee', ndex = 96, type1 = 'psico', type2 = 'psico'}
t[96] = t.drowzee
t.hypno = {name = 'Hypno', ndex = 97, type1 = 'psico', type2 = 'psico'}
t[97] = t.hypno
t.krabby = {name = 'Krabby', ndex = 98, type1 = 'acqua', type2 = 'acqua'}
t[98] = t.krabby
t.kingler = {name = 'Kingler', ndex = 99, type1 = 'acqua', type2 = 'acqua'}
t[99] = t.kingler
t.voltorb = {name = 'Voltorb', ndex = 100, type1 = 'elettro', type2 = 'elettro'}
t[100] = t.voltorb
t.electrode = {name = 'Electrode', ndex = 101, type1 = 'elettro', type2 = 'elettro'}
t[101] = t.electrode
t.exeggcute = {name = 'Exeggcute', ndex = 102, type1 = 'erba', type2 = 'psico'}
t[102] = t.exeggcute
t.exeggutor = {name = 'Exeggutor', ndex = 103, type1 = 'erba', type2 = 'psico'}
t[103] = t.exeggutor
t.cubone = {name = 'Cubone', ndex = 104, type1 = 'terra', type2 = 'terra'}
t[104] = t.cubone
t.marowak = {name = 'Marowak', ndex = 105, type1 = 'terra', type2 = 'terra'}
t[105] = t.marowak
t.hitmonlee = {name = 'Hitmonlee', ndex = 106, type1 = 'lotta', type2 = 'lotta'}
t[106] = t.hitmonlee
t.hitmonchan = {name = 'Hitmonchan', ndex = 107, type1 = 'lotta', type2 = 'lotta'}
t[107] = t.hitmonchan
t.lickitung = {name = 'Lickitung', ndex = 108, type1 = 'normale', type2 = 'normale'}
t[108] = t.lickitung
t.koffing = {name = 'Koffing', ndex = 109, type1 = 'veleno', type2 = 'veleno'}
t[109] = t.koffing
t.weezing = {name = 'Weezing', ndex = 110, type1 = 'veleno', type2 = 'veleno'}
t[110] = t.weezing
t.rhyhorn = {name = 'Rhyhorn', ndex = 111, type1 = 'terra', type2 = 'roccia'}
t[111] = t.rhyhorn
t.rhydon = {name = 'Rhydon', ndex = 112, type1 = 'terra', type2 = 'roccia'}
t[112] = t.rhydon
t.chansey = {name = 'Chansey', ndex = 113, type1 = 'normale', type2 = 'normale'}
t[113] = t.chansey
t.tangela = {name = 'Tangela', ndex = 114, type1 = 'erba', type2 = 'erba'}
t[114] = t.tangela
t.kangaskhan = {name = 'Kangaskhan', ndex = 115, type1 = 'normale', type2 = 'normale'}
t[115] = t.kangaskhan
t.horsea = {name = 'Horsea', ndex = 116, type1 = 'acqua', type2 = 'acqua'}
t[116] = t.horsea
t.seadra = {name = 'Seadra', ndex = 117, type1 = 'acqua', type2 = 'acqua'}
t[117] = t.seadra
t.goldeen = {name = 'Goldeen', ndex = 118, type1 = 'acqua', type2 = 'acqua'}
t[118] = t.goldeen
t.seaking = {name = 'Seaking', ndex = 119, type1 = 'acqua', type2 = 'acqua'}
t[119] = t.seaking
t.staryu = {name = 'Staryu', ndex = 120, type1 = 'acqua', type2 = 'acqua'}
t[120] = t.staryu
t.starmie = {name = 'Starmie', ndex = 121, type1 = 'acqua', type2 = 'psico'}
t[121] = t.starmie
t['mr. mime'] = {name = 'Mr. Mime', ndex = 122, type1 = 'psico', type2 = 'folletto'}
t[122] = t['mr. mime']
t.scyther = {name = 'Scyther', ndex = 123, type1 = 'coleot', type2 = 'volante'}
t[123] = t.scyther
t.jynx = {name = 'Jynx', ndex = 124, type1 = 'ghiaccio', type2 = 'psico'}
t[124] = t.jynx
t.electabuzz = {name = 'Electabuzz', ndex = 125, type1 = 'elettro', type2 = 'elettro'}
t[125] = t.electabuzz
t.magmar = {name = 'Magmar', ndex = 126, type1 = 'fuoco', type2 = 'fuoco'}
t[126] = t.magmar
t.pinsir = {name = 'Pinsir', ndex = 127, type1 = 'coleottero', type2 = 'coleottero'}
t[127] = t.pinsir
t.tauros = {name = 'Tauros', ndex = 128, type1 = 'normale', type2 = 'normale'}
t[128] = t.tauros
t.magikarp = {name = 'Magikarp', ndex = 129, type1 = 'acqua', type2 = 'acqua'}
t[129] = t.magikarp
t.gyarados = {name = 'Gyarados', ndex = 130, type1 = 'acqua', type2 = 'volante'}
t[130] = t.gyarados
t.lapras = {name = 'Lapras', ndex = 131, type1 = 'acqua', type2 = 'ghiaccio'}
t[131] = t.lapras
t.ditto = {name = 'Ditto', ndex = 132, type1 = 'normale', type2 = 'normale'}
t[132] = t.ditto
t.eevee = {name = 'Eevee', ndex = 133, type1 = 'normale', type2 = 'normale'}
t[133] = t.eevee
t.vaporeon = {name = 'Vaporeon', ndex = 134, type1 = 'acqua', type2 = 'acqua'}
t[134] = t.vaporeon
t.jolteon = {name = 'Jolteon', ndex = 135, type1 = 'elettro', type2 = 'elettro'}
t[135] = t.jolteon
t.flareon = {name = 'Flareon', ndex = 136, type1 = 'fuoco', type2 = 'fuoco'}
t[136] = t.flareon
t.porygon = {name = 'Porygon', ndex = 137, type1 = 'normale', type2 = 'normale'}
t[137] = t.porygon
t.omanyte = {name = 'Omanyte', ndex = 138, type1 = 'roccia', type2 = 'acqua'}
t[138] = t.omanyte
t.omastar = {name = 'Omastar', ndex = 139, type1 = 'roccia', type2 = 'acqua'}
t[139] = t.omastar
t.kabuto = {name = 'Kabuto', ndex = 140, type1 = 'roccia', type2 = 'acqua'}
t[140] = t.kabuto
t.kabutops = {name = 'Kabutops', ndex = 141, type1 = 'roccia', type2 = 'acqua'}
t[141] = t.kabutops
t.aerodactyl = {name = 'Aerodactyl', ndex = 142, type1 = 'roccia', type2 = 'volante'}
t[142] = t.aerodactyl
t.snorlax = {name = 'Snorlax', ndex = 143, type1 = 'normale', type2 = 'normale'}
t[143] = t.snorlax
t.articuno = {name = 'Articuno', ndex = 144, type1 = 'ghiaccio', type2 = 'volante'}
t[144] = t.articuno
t.zapdos = {name = 'Zapdos', ndex = 145, type1 = 'elettro', type2 = 'volante'}
t[145] = t.zapdos
t.moltres = {name = 'Moltres', ndex = 146, type1 = 'fuoco', type2 = 'volante'}
t[146] = t.moltres
t.dratini = {name = 'Dratini', ndex = 147, type1 = 'drago', type2 = 'drago'}
t[147] = t.dratini
t.dragonair = {name = 'Dragonair', ndex = 148, type1 = 'drago', type2 = 'drago'}
t[148] = t.dragonair
t.dragonite = {name = 'Dragonite', ndex = 149, type1 = 'drago', type2 = 'volante'}
t[149] = t.dragonite
t.mewtwo = {name = 'Mewtwo', ndex = 150, type1 = 'psico', type2 = 'psico'}
t[150] = t.mewtwo
t.mew = {name = 'Mew', ndex = 151, type1 = 'psico', type2 = 'psico'}
t[151] = t.mew
t.chikorita = {name = 'Chikorita', ndex = 152, type1 = 'erba', type2 = 'erba'}
t[152] = t.chikorita
t.bayleef = {name = 'Bayleef', ndex = 153, type1 = 'erba', type2 = 'erba'}
t[153] = t.bayleef
t.meganium = {name = 'Meganium', ndex = 154, type1 = 'erba', type2 = 'erba'}
t[154] = t.meganium
t.cyndaquil = {name = 'Cyndaquil', ndex = 155, type1 = 'fuoco', type2 = 'fuoco'}
t[155] = t.cyndaquil
t.quilava = {name = 'Quilava', ndex = 156, type1 = 'fuoco', type2 = 'fuoco'}
t[156] = t.quilava
t.typhlosion = {name = 'Typhlosion', ndex = 157, type1 = 'fuoco', type2 = 'fuoco'}
t[157] = t.typhlosion
t.totodile = {name = 'Totodile', ndex = 158, type1 = 'acqua', type2 = 'acqua'}
t[158] = t.totodile
t.croconaw = {name = 'Croconaw', ndex = 159, type1 = 'acqua', type2 = 'acqua'}
t[159] = t.croconaw
t.feraligatr = {name = 'Feraligatr', ndex = 160, type1 = 'acqua', type2 = 'acqua'}
t[160] = t.feraligatr
t.sentret = {name = 'Sentret', ndex = 161, type1 = 'normale', type2 = 'normale'}
t[161] = t.sentret
t.furret = {name = 'Furret', ndex = 162, type1 = 'normale', type2 = 'normale'}
t[162] = t.furret
t.hoothoot = {name = 'Hoothoot', ndex = 163, type1 = 'normale', type2 = 'volante'}
t[163] = t.hoothoot
t.noctowl = {name = 'Noctowl', ndex = 164, type1 = 'normale', type2 = 'volante'}
t[164] = t.noctowl
t.ledyba = {name = 'Ledyba', ndex = 165, type1 = 'coleot', type2 = 'volante'}
t[165] = t.ledyba
t.ledian = {name = 'Ledian', ndex = 166, type1 = 'coleot', type2 = 'volante'}
t[166] = t.ledian
t.spinarak = {name = 'Spinarak', ndex = 167, type1 = 'coleot', type2 = 'veleno'}
t[167] = t.spinarak
t.ariados = {name = 'Ariados', ndex = 168, type1 = 'coleot', type2 = 'veleno'}
t[168] = t.ariados
t.crobat = {name = 'Crobat', ndex = 169, type1 = 'veleno', type2 = 'volante'}
t[169] = t.crobat
t.chinchou = {name = 'Chinchou', ndex = 170, type1 = 'acqua', type2 = 'elettro'}
t[170] = t.chinchou
t.lanturn = {name = 'Lanturn', ndex = 171, type1 = 'acqua', type2 = 'elettro'}
t[171] = t.lanturn
t.pichu = {name = 'Pichu', ndex = 172, type1 = 'elettro', type2 = 'elettro'}
t[172] = t.pichu
t.cleffa = {name = 'Cleffa', ndex = 173, type1 = 'folletto', type2 = 'folletto'}
t[173] = t.cleffa
t.igglybuff = {name = 'Igglybuff', ndex = 174, type1 = 'normale', type2 = 'folletto'}
t[174] = t.igglybuff
t.togepi = {name = 'Togepi', ndex = 175, type1 = 'folletto', type2 = 'folletto'}
t[175] = t.togepi
t.togetic = {name = 'Togetic', ndex = 176, type1 = 'folletto', type2 = 'volante'}
t[176] = t.togetic
t.natu = {name = 'Natu', ndex = 177, type1 = 'psico', type2 = 'volante'}
t[177] = t.natu
t.xatu = {name = 'Xatu', ndex = 178, type1 = 'psico', type2 = 'volante'}
t[178] = t.xatu
t.mareep = {name = 'Mareep', ndex = 179, type1 = 'elettro', type2 = 'elettro'}
t[179] = t.mareep
t.flaaffy = {name = 'Flaaffy', ndex = 180, type1 = 'elettro', type2 = 'elettro'}
t[180] = t.flaaffy
t.ampharos = {name = 'Ampharos', ndex = 181, type1 = 'elettro', type2 = 'elettro'}
t[181] = t.ampharos
t.bellossom = {name = 'Bellossom', ndex = 182, type1 = 'erba', type2 = 'erba'}
t[182] = t.bellossom
t.marill = {name = 'Marill', ndex = 183, type1 = 'acqua', type2 = 'folletto'}
t[183] = t.marill
t.azumarill = {name = 'Azumarill', ndex = 184, type1 = 'acqua', type2 = 'folletto'}
t[184] = t.azumarill
t.sudowoodo = {name = 'Sudowoodo', ndex = 185, type1 = 'roccia', type2 = 'roccia'}
t[185] = t.sudowoodo
t.politoed = {name = 'Politoed', ndex = 186, type1 = 'acqua', type2 = 'acqua'}
t[186] = t.politoed
t.hoppip = {name = 'Hoppip', ndex = 187, type1 = 'erba', type2 = 'volante'}
t[187] = t.hoppip
t.skiploom = {name = 'Skiploom', ndex = 188, type1 = 'erba', type2 = 'volante'}
t[188] = t.skiploom
t.jumpluff = {name = 'Jumpluff', ndex = 189, type1 = 'erba', type2 = 'volante'}
t[189] = t.jumpluff
t.aipom = {name = 'Aipom', ndex = 190, type1 = 'normale', type2 = 'normale'}
t[190] = t.aipom
t.sunkern = {name = 'Sunkern', ndex = 191, type1 = 'erba', type2 = 'erba'}
t[191] = t.sunkern
t.sunflora = {name = 'Sunflora', ndex = 192, type1 = 'erba', type2 = 'erba'}
t[192] = t.sunflora
t.yanma = {name = 'Yanma', ndex = 193, type1 = 'coleot', type2 = 'volante'}
t[193] = t.yanma
t.wooper = {name = 'Wooper', ndex = 194, type1 = 'acqua', type2 = 'terra'}
t[194] = t.wooper
t.quagsire = {name = 'Quagsire', ndex = 195, type1 = 'acqua', type2 = 'terra'}
t[195] = t.quagsire
t.espeon = {name = 'Espeon', ndex = 196, type1 = 'psico', type2 = 'psico'}
t[196] = t.espeon
t.umbreon = {name = 'Umbreon', ndex = 197, type1 = 'buio', type2 = 'buio'}
t[197] = t.umbreon
t.murkrow = {name = 'Murkrow', ndex = 198, type1 = 'buio', type2 = 'volante'}
t[198] = t.murkrow
t.slowking = {name = 'Slowking', ndex = 199, type1 = 'acqua', type2 = 'psico'}
t[199] = t.slowking
t.misdreavus = {name = 'Misdreavus', ndex = 200, type1 = 'spettro', type2 = 'spettro'}
t[200] = t.misdreavus
t.unown = {name = 'Unown', ndex = 201, type1 = 'psico', type2 = 'psico'}
t[201] = t.unown
t.wobbuffet = {name = 'Wobbuffet', ndex = 202, type1 = 'psico', type2 = 'psico'}
t[202] = t.wobbuffet
t.girafarig = {name = 'Girafarig', ndex = 203, type1 = 'normale', type2 = 'psico'}
t[203] = t.girafarig
t.pineco = {name = 'Pineco', ndex = 204, type1 = 'coleottero', type2 = 'coleottero'}
t[204] = t.pineco
t.forretress = {name = 'Forretress', ndex = 205, type1 = 'coleot', type2 = 'acciaio'}
t[205] = t.forretress
t.dunsparce = {name = 'Dunsparce', ndex = 206, type1 = 'normale', type2 = 'normale'}
t[206] = t.dunsparce
t.gligar = {name = 'Gligar', ndex = 207, type1 = 'terra', type2 = 'volante'}
t[207] = t.gligar
t.steelix = {name = 'Steelix', ndex = 208, type1 = 'acciaio', type2 = 'terra'}
t[208] = t.steelix
t.snubbull = {name = 'Snubbull', ndex = 209, type1 = 'folletto', type2 = 'folletto'}
t[209] = t.snubbull
t.granbull = {name = 'Granbull', ndex = 210, type1 = 'folletto', type2 = 'folletto'}
t[210] = t.granbull
t.qwilfish = {name = 'Qwilfish', ndex = 211, type1 = 'acqua', type2 = 'veleno'}
t[211] = t.qwilfish
t.scizor = {name = 'Scizor', ndex = 212, type1 = 'coleot', type2 = 'acciaio'}
t[212] = t.scizor
t.shuckle = {name = 'Shuckle', ndex = 213, type1 = 'coleot', type2 = 'roccia'}
t[213] = t.shuckle
t.heracross = {name = 'Heracross', ndex = 214, type1 = 'coleot', type2 = 'lotta'}
t[214] = t.heracross
t.sneasel = {name = 'Sneasel', ndex = 215, type1 = 'buio', type2 = 'ghiaccio'}
t[215] = t.sneasel
t.teddiursa = {name = 'Teddiursa', ndex = 216, type1 = 'normale', type2 = 'normale'}
t[216] = t.teddiursa
t.ursaring = {name = 'Ursaring', ndex = 217, type1 = 'normale', type2 = 'normale'}
t[217] = t.ursaring
t.slugma = {name = 'Slugma', ndex = 218, type1 = 'fuoco', type2 = 'fuoco'}
t[218] = t.slugma
t.magcargo = {name = 'Magcargo', ndex = 219, type1 = 'fuoco', type2 = 'roccia'}
t[219] = t.magcargo
t.swinub = {name = 'Swinub', ndex = 220, type1 = 'ghiaccio', type2 = 'terra'}
t[220] = t.swinub
t.piloswine = {name = 'Piloswine', ndex = 221, type1 = 'ghiaccio', type2 = 'terra'}
t[221] = t.piloswine
t.corsola = {name = 'Corsola', ndex = 222, type1 = 'acqua', type2 = 'roccia'}
t[222] = t.corsola
t.remoraid = {name = 'Remoraid', ndex = 223, type1 = 'acqua', type2 = 'acqua'}
t[223] = t.remoraid
t.octillery = {name = 'Octillery', ndex = 224, type1 = 'acqua', type2 = 'acqua'}
t[224] = t.octillery
t.delibird = {name = 'Delibird', ndex = 225, type1 = 'ghiaccio', type2 = 'volante'}
t[225] = t.delibird
t.mantine = {name = 'Mantine', ndex = 226, type1 = 'acqua', type2 = 'volante'}
t[226] = t.mantine
t.skarmory = {name = 'Skarmory', ndex = 227, type1 = 'acciaio', type2 = 'volante'}
t[227] = t.skarmory
t.houndour = {name = 'Houndour', ndex = 228, type1 = 'buio', type2 = 'fuoco'}
t[228] = t.houndour
t.houndoom = {name = 'Houndoom', ndex = 229, type1 = 'buio', type2 = 'fuoco'}
t[229] = t.houndoom
t.kingdra = {name = 'Kingdra', ndex = 230, type1 = 'acqua', type2 = 'drago'}
t[230] = t.kingdra
t.phanpy = {name = 'Phanpy', ndex = 231, type1 = 'terra', type2 = 'terra'}
t[231] = t.phanpy
t.donphan = {name = 'Donphan', ndex = 232, type1 = 'terra', type2 = 'terra'}
t[232] = t.donphan
t.porygon2 = {name = 'Porygon2', ndex = 233, type1 = 'normale', type2 = 'normale'}
t[233] = t.porygon2
t.stantler = {name = 'Stantler', ndex = 234, type1 = 'normale', type2 = 'normale'}
t[234] = t.stantler
t.smeargle = {name = 'Smeargle', ndex = 235, type1 = 'normale', type2 = 'normale'}
t[235] = t.smeargle
t.tyrogue = {name = 'Tyrogue', ndex = 236, type1 = 'lotta', type2 = 'lotta'}
t[236] = t.tyrogue
t.hitmontop = {name = 'Hitmontop', ndex = 237, type1 = 'lotta', type2 = 'lotta'}
t[237] = t.hitmontop
t.smoochum = {name = 'Smoochum', ndex = 238, type1 = 'ghiaccio', type2 = 'psico'}
t[238] = t.smoochum
t.elekid = {name = 'Elekid', ndex = 239, type1 = 'elettro', type2 = 'elettro'}
t[239] = t.elekid
t.magby = {name = 'Magby', ndex = 240, type1 = 'fuoco', type2 = 'fuoco'}
t[240] = t.magby
t.miltank = {name = 'Miltank', ndex = 241, type1 = 'normale', type2 = 'normale'}
t[241] = t.miltank
t.blissey = {name = 'Blissey', ndex = 242, type1 = 'normale', type2 = 'normale'}
t[242] = t.blissey
t.raikou = {name = 'Raikou', ndex = 243, type1 = 'elettro', type2 = 'elettro'}
t[243] = t.raikou
t.entei = {name = 'Entei', ndex = 244, type1 = 'fuoco', type2 = 'fuoco'}
t[244] = t.entei
t.suicune = {name = 'Suicune', ndex = 245, type1 = 'acqua', type2 = 'acqua'}
t[245] = t.suicune
t.larvitar = {name = 'Larvitar', ndex = 246, type1 = 'roccia', type2 = 'terra'}
t[246] = t.larvitar
t.pupitar = {name = 'Pupitar', ndex = 247, type1 = 'roccia', type2 = 'terra'}
t[247] = t.pupitar
t.tyranitar = {name = 'Tyranitar', ndex = 248, type1 = 'roccia', type2 = 'buio'}
t[248] = t.tyranitar
t.lugia = {name = 'Lugia', ndex = 249, type1 = 'psico', type2 = 'volante'}
t[249] = t.lugia
t['ho-oh'] = {name = 'Ho-Oh', ndex = 250, type1 = 'fuoco', type2 = 'volante'}
t[250] = t['ho-oh']
t.celebi = {name = 'Celebi', ndex = 251, type1 = 'psico', type2 = 'erba'}
t[251] = t.celebi
t.treecko = {name = 'Treecko', ndex = 252, type1 = 'erba', type2 = 'erba'}
t[252] = t.treecko
t.grovyle = {name = 'Grovyle', ndex = 253, type1 = 'erba', type2 = 'erba'}
t[253] = t.grovyle
t.sceptile = {name = 'Sceptile', ndex = 254, type1 = 'erba', type2 = 'erba'}
t[254] = t.sceptile
t.torchic = {name = 'Torchic', ndex = 255, type1 = 'fuoco', type2 = 'fuoco'}
t[255] = t.torchic
t.combusken = {name = 'Combusken', ndex = 256, type1 = 'fuoco', type2 = 'lotta'}
t[256] = t.combusken
t.blaziken = {name = 'Blaziken', ndex = 257, type1 = 'fuoco', type2 = 'lotta'}
t[257] = t.blaziken
t.mudkip = {name = 'Mudkip', ndex = 258, type1 = 'acqua', type2 = 'acqua'}
t[258] = t.mudkip
t.marshtomp = {name = 'Marshtomp', ndex = 259, type1 = 'acqua', type2 = 'terra'}
t[259] = t.marshtomp
t.swampert = {name = 'Swampert', ndex = 260, type1 = 'acqua', type2 = 'terra'}
t[260] = t.swampert
t.poochyena = {name = 'Poochyena', ndex = 261, type1 = 'buio', type2 = 'buio'}
t[261] = t.poochyena
t.mightyena = {name = 'Mightyena', ndex = 262, type1 = 'buio', type2 = 'buio'}
t[262] = t.mightyena
t.zigzagoon = {name = 'Zigzagoon', ndex = 263, type1 = 'normale', type2 = 'normale'}
t[263] = t.zigzagoon
t.linoone = {name = 'Linoone', ndex = 264, type1 = 'normale', type2 = 'normale'}
t[264] = t.linoone
t.wurmple = {name = 'Wurmple', ndex = 265, type1 = 'coleottero', type2 = 'coleottero'}
t[265] = t.wurmple
t.silcoon = {name = 'Silcoon', ndex = 266, type1 = 'coleottero', type2 = 'coleottero'}
t[266] = t.silcoon
t.beautifly = {name = 'Beautifly', ndex = 267, type1 = 'coleot', type2 = 'volante'}
t[267] = t.beautifly
t.cascoon = {name = 'Cascoon', ndex = 268, type1 = 'coleottero', type2 = 'coleottero'}
t[268] = t.cascoon
t.dustox = {name = 'Dustox', ndex = 269, type1 = 'coleot', type2 = 'veleno'}
t[269] = t.dustox
t.lotad = {name = 'Lotad', ndex = 270, type1 = 'acqua', type2 = 'erba'}
t[270] = t.lotad
t.lombre = {name = 'Lombre', ndex = 271, type1 = 'acqua', type2 = 'erba'}
t[271] = t.lombre
t.ludicolo = {name = 'Ludicolo', ndex = 272, type1 = 'acqua', type2 = 'erba'}
t[272] = t.ludicolo
t.seedot = {name = 'Seedot', ndex = 273, type1 = 'erba', type2 = 'erba'}
t[273] = t.seedot
t.nuzleaf = {name = 'Nuzleaf', ndex = 274, type1 = 'erba', type2 = 'buio'}
t[274] = t.nuzleaf
t.shiftry = {name = 'Shiftry', ndex = 275, type1 = 'erba', type2 = 'buio'}
t[275] = t.shiftry
t.taillow = {name = 'Taillow', ndex = 276, type1 = 'normale', type2 = 'volante'}
t[276] = t.taillow
t.swellow = {name = 'Swellow', ndex = 277, type1 = 'normale', type2 = 'volante'}
t[277] = t.swellow
t.wingull = {name = 'Wingull', ndex = 278, type1 = 'acqua', type2 = 'volante'}
t[278] = t.wingull
t.pelipper = {name = 'Pelipper', ndex = 279, type1 = 'acqua', type2 = 'volante'}
t[279] = t.pelipper
t.ralts = {name = 'Ralts', ndex = 280, type1 = 'psico', type2 = 'folletto'}
t[280] = t.ralts
t.kirlia = {name = 'Kirlia', ndex = 281, type1 = 'psico', type2 = 'folletto'}
t[281] = t.kirlia
t.gardevoir = {name = 'Gardevoir', ndex = 282, type1 = 'psico', type2 = 'folletto'}
t[282] = t.gardevoir
t.surskit = {name = 'Surskit', ndex = 283, type1 = 'coleot', type2 = 'acqua'}
t[283] = t.surskit
t.masquerain = {name = 'Masquerain', ndex = 284, type1 = 'coleot', type2 = 'volante'}
t[284] = t.masquerain
t.shroomish = {name = 'Shroomish', ndex = 285, type1 = 'erba', type2 = 'erba'}
t[285] = t.shroomish
t.breloom = {name = 'Breloom', ndex = 286, type1 = 'erba', type2 = 'lotta'}
t[286] = t.breloom
t.slakoth = {name = 'Slakoth', ndex = 287, type1 = 'normale', type2 = 'normale'}
t[287] = t.slakoth
t.vigoroth = {name = 'Vigoroth', ndex = 288, type1 = 'normale', type2 = 'normale'}
t[288] = t.vigoroth
t.slaking = {name = 'Slaking', ndex = 289, type1 = 'normale', type2 = 'normale'}
t[289] = t.slaking
t.nincada = {name = 'Nincada', ndex = 290, type1 = 'coleot', type2 = 'terra'}
t[290] = t.nincada
t.ninjask = {name = 'Ninjask', ndex = 291, type1 = 'coleot', type2 = 'volante'}
t[291] = t.ninjask
t.shedinja = {name = 'Shedinja', ndex = 292, type1 = 'coleot', type2 = 'spettro'}
t[292] = t.shedinja
t.whismur = {name = 'Whismur', ndex = 293, type1 = 'normale', type2 = 'normale'}
t[293] = t.whismur
t.loudred = {name = 'Loudred', ndex = 294, type1 = 'normale', type2 = 'normale'}
t[294] = t.loudred
t.exploud = {name = 'Exploud', ndex = 295, type1 = 'normale', type2 = 'normale'}
t[295] = t.exploud
t.makuhita = {name = 'Makuhita', ndex = 296, type1 = 'lotta', type2 = 'lotta'}
t[296] = t.makuhita
t.hariyama = {name = 'Hariyama', ndex = 297, type1 = 'lotta', type2 = 'lotta'}
t[297] = t.hariyama
t.azurill = {name = 'Azurill', ndex = 298, type1 = 'normale', type2 = 'folletto'}
t[298] = t.azurill
t.nosepass = {name = 'Nosepass', ndex = 299, type1 = 'roccia', type2 = 'roccia'}
t[299] = t.nosepass
t.skitty = {name = 'Skitty', ndex = 300, type1 = 'normale', type2 = 'normale'}
t[300] = t.skitty
t.delcatty = {name = 'Delcatty', ndex = 301, type1 = 'normale', type2 = 'normale'}
t[301] = t.delcatty
t.sableye = {name = 'Sableye', ndex = 302, type1 = 'buio', type2 = 'spettro'}
t[302] = t.sableye
t.mawile = {name = 'Mawile', ndex = 303, type1 = 'acciaio', type2 = 'folletto'}
t[303] = t.mawile
t.aron = {name = 'Aron', ndex = 304, type1 = 'acciaio', type2 = 'roccia'}
t[304] = t.aron
t.lairon = {name = 'Lairon', ndex = 305, type1 = 'acciaio', type2 = 'roccia'}
t[305] = t.lairon
t.aggron = {name = 'Aggron', ndex = 306, type1 = 'acciaio', type2 = 'roccia'}
t[306] = t.aggron
t.meditite = {name = 'Meditite', ndex = 307, type1 = 'lotta', type2 = 'psico'}
t[307] = t.meditite
t.medicham = {name = 'Medicham', ndex = 308, type1 = 'lotta', type2 = 'psico'}
t[308] = t.medicham
t.electrike = {name = 'Electrike', ndex = 309, type1 = 'elettro', type2 = 'elettro'}
t[309] = t.electrike
t.manectric = {name = 'Manectric', ndex = 310, type1 = 'elettro', type2 = 'elettro'}
t[310] = t.manectric
t.plusle = {name = 'Plusle', ndex = 311, type1 = 'elettro', type2 = 'elettro'}
t[311] = t.plusle
t.minun = {name = 'Minun', ndex = 312, type1 = 'elettro', type2 = 'elettro'}
t[312] = t.minun
t.volbeat = {name = 'Volbeat', ndex = 313, type1 = 'coleottero', type2 = 'coleottero'}
t[313] = t.volbeat
t.illumise = {name = 'Illumise', ndex = 314, type1 = 'coleottero', type2 = 'coleottero'}
t[314] = t.illumise
t.roselia = {name = 'Roselia', ndex = 315, type1 = 'erba', type2 = 'veleno'}
t[315] = t.roselia
t.gulpin = {name = 'Gulpin', ndex = 316, type1 = 'veleno', type2 = 'veleno'}
t[316] = t.gulpin
t.swalot = {name = 'Swalot', ndex = 317, type1 = 'veleno', type2 = 'veleno'}
t[317] = t.swalot
t.carvanha = {name = 'Carvanha', ndex = 318, type1 = 'acqua', type2 = 'buio'}
t[318] = t.carvanha
t.sharpedo = {name = 'Sharpedo', ndex = 319, type1 = 'acqua', type2 = 'buio'}
t[319] = t.sharpedo
t.wailmer = {name = 'Wailmer', ndex = 320, type1 = 'acqua', type2 = 'acqua'}
t[320] = t.wailmer
t.wailord = {name = 'Wailord', ndex = 321, type1 = 'acqua', type2 = 'acqua'}
t[321] = t.wailord
t.numel = {name = 'Numel', ndex = 322, type1 = 'fuoco', type2 = 'terra'}
t[322] = t.numel
t.camerupt = {name = 'Camerupt', ndex = 323, type1 = 'fuoco', type2 = 'terra'}
t[323] = t.camerupt
t.torkoal = {name = 'Torkoal', ndex = 324, type1 = 'fuoco', type2 = 'fuoco'}
t[324] = t.torkoal
t.spoink = {name = 'Spoink', ndex = 325, type1 = 'psico', type2 = 'psico'}
t[325] = t.spoink
t.grumpig = {name = 'Grumpig', ndex = 326, type1 = 'psico', type2 = 'psico'}
t[326] = t.grumpig
t.spinda = {name = 'Spinda', ndex = 327, type1 = 'normale', type2 = 'normale'}
t[327] = t.spinda
t.trapinch = {name = 'Trapinch', ndex = 328, type1 = 'terra', type2 = 'terra'}
t[328] = t.trapinch
t.vibrava = {name = 'Vibrava', ndex = 329, type1 = 'terra', type2 = 'drago'}
t[329] = t.vibrava
t.flygon = {name = 'Flygon', ndex = 330, type1 = 'terra', type2 = 'drago'}
t[330] = t.flygon
t.cacnea = {name = 'Cacnea', ndex = 331, type1 = 'erba', type2 = 'erba'}
t[331] = t.cacnea
t.cacturne = {name = 'Cacturne', ndex = 332, type1 = 'erba', type2 = 'buio'}
t[332] = t.cacturne
t.swablu = {name = 'Swablu', ndex = 333, type1 = 'normale', type2 = 'volante'}
t[333] = t.swablu
t.altaria = {name = 'Altaria', ndex = 334, type1 = 'drago', type2 = 'volante'}
t[334] = t.altaria
t.zangoose = {name = 'Zangoose', ndex = 335, type1 = 'normale', type2 = 'normale'}
t[335] = t.zangoose
t.seviper = {name = 'Seviper', ndex = 336, type1 = 'veleno', type2 = 'veleno'}
t[336] = t.seviper
t.lunatone = {name = 'Lunatone', ndex = 337, type1 = 'roccia', type2 = 'psico'}
t[337] = t.lunatone
t.solrock = {name = 'Solrock', ndex = 338, type1 = 'roccia', type2 = 'psico'}
t[338] = t.solrock
t.barboach = {name = 'Barboach', ndex = 339, type1 = 'acqua', type2 = 'terra'}
t[339] = t.barboach
t.whiscash = {name = 'Whiscash', ndex = 340, type1 = 'acqua', type2 = 'terra'}
t[340] = t.whiscash
t.corphish = {name = 'Corphish', ndex = 341, type1 = 'acqua', type2 = 'acqua'}
t[341] = t.corphish
t.crawdaunt = {name = 'Crawdaunt', ndex = 342, type1 = 'acqua', type2 = 'buio'}
t[342] = t.crawdaunt
t.baltoy = {name = 'Baltoy', ndex = 343, type1 = 'terra', type2 = 'psico'}
t[343] = t.baltoy
t.claydol = {name = 'Claydol', ndex = 344, type1 = 'terra', type2 = 'psico'}
t[344] = t.claydol
t.lileep = {name = 'Lileep', ndex = 345, type1 = 'roccia', type2 = 'erba'}
t[345] = t.lileep
t.cradily = {name = 'Cradily', ndex = 346, type1 = 'roccia', type2 = 'erba'}
t[346] = t.cradily
t.anorith = {name = 'Anorith', ndex = 347, type1 = 'roccia', type2 = 'coleot'}
t[347] = t.anorith
t.armaldo = {name = 'Armaldo', ndex = 348, type1 = 'roccia', type2 = 'coleot'}
t[348] = t.armaldo
t.feebas = {name = 'Feebas', ndex = 349, type1 = 'acqua', type2 = 'acqua'}
t[349] = t.feebas
t.milotic = {name = 'Milotic', ndex = 350, type1 = 'acqua', type2 = 'acqua'}
t[350] = t.milotic
t.castform = {name = 'Castform', ndex = 351, type1 = 'normale', type2 = 'normale'}
t[351] = t.castform
t.kecleon = {name = 'Kecleon', ndex = 352, type1 = 'normale', type2 = 'normale'}
t[352] = t.kecleon
t.shuppet = {name = 'Shuppet', ndex = 353, type1 = 'spettro', type2 = 'spettro'}
t[353] = t.shuppet
t.banette = {name = 'Banette', ndex = 354, type1 = 'spettro', type2 = 'spettro'}
t[354] = t.banette
t.duskull = {name = 'Duskull', ndex = 355, type1 = 'spettro', type2 = 'spettro'}
t[355] = t.duskull
t.dusclops = {name = 'Dusclops', ndex = 356, type1 = 'spettro', type2 = 'spettro'}
t[356] = t.dusclops
t.tropius = {name = 'Tropius', ndex = 357, type1 = 'erba', type2 = 'volante'}
t[357] = t.tropius
t.chimecho = {name = 'Chimecho', ndex = 358, type1 = 'psico', type2 = 'psico'}
t[358] = t.chimecho
t.absol = {name = 'Absol', ndex = 359, type1 = 'buio', type2 = 'buio'}
t[359] = t.absol
t.wynaut = {name = 'Wynaut', ndex = 360, type1 = 'psico', type2 = 'psico'}
t[360] = t.wynaut
t.snorunt = {name = 'Snorunt', ndex = 361, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[361] = t.snorunt
t.glalie = {name = 'Glalie', ndex = 362, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[362] = t.glalie
t.spheal = {name = 'Spheal', ndex = 363, type1 = 'ghiaccio', type2 = 'acqua'}
t[363] = t.spheal
t.sealeo = {name = 'Sealeo', ndex = 364, type1 = 'ghiaccio', type2 = 'acqua'}
t[364] = t.sealeo
t.walrein = {name = 'Walrein', ndex = 365, type1 = 'ghiaccio', type2 = 'acqua'}
t[365] = t.walrein
t.clamperl = {name = 'Clamperl', ndex = 366, type1 = 'acqua', type2 = 'acqua'}
t[366] = t.clamperl
t.huntail = {name = 'Huntail', ndex = 367, type1 = 'acqua', type2 = 'acqua'}
t[367] = t.huntail
t.gorebyss = {name = 'Gorebyss', ndex = 368, type1 = 'acqua', type2 = 'acqua'}
t[368] = t.gorebyss
t.relicanth = {name = 'Relicanth', ndex = 369, type1 = 'acqua', type2 = 'roccia'}
t[369] = t.relicanth
t.luvdisc = {name = 'Luvdisc', ndex = 370, type1 = 'acqua', type2 = 'acqua'}
t[370] = t.luvdisc
t.bagon = {name = 'Bagon', ndex = 371, type1 = 'drago', type2 = 'drago'}
t[371] = t.bagon
t.shelgon = {name = 'Shelgon', ndex = 372, type1 = 'drago', type2 = 'drago'}
t[372] = t.shelgon
t.salamence = {name = 'Salamence', ndex = 373, type1 = 'drago', type2 = 'volante'}
t[373] = t.salamence
t.beldum = {name = 'Beldum', ndex = 374, type1 = 'acciaio', type2 = 'psico'}
t[374] = t.beldum
t.metang = {name = 'Metang', ndex = 375, type1 = 'acciaio', type2 = 'psico'}
t[375] = t.metang
t.metagross = {name = 'Metagross', ndex = 376, type1 = 'acciaio', type2 = 'psico'}
t[376] = t.metagross
t.regirock = {name = 'Regirock', ndex = 377, type1 = 'roccia', type2 = 'roccia'}
t[377] = t.regirock
t.regice = {name = 'Regice', ndex = 378, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[378] = t.regice
t.registeel = {name = 'Registeel', ndex = 379, type1 = 'acciaio', type2 = 'acciaio'}
t[379] = t.registeel
t.latias = {name = 'Latias', ndex = 380, type1 = 'drago', type2 = 'psico'}
t[380] = t.latias
t.latios = {name = 'Latios', ndex = 381, type1 = 'drago', type2 = 'psico'}
t[381] = t.latios
t.kyogre = {name = 'Kyogre', ndex = 382, type1 = 'acqua', type2 = 'acqua'}
t[382] = t.kyogre
t.groudon = {name = 'Groudon', ndex = 383, type1 = 'terra', type2 = 'terra'}
t[383] = t.groudon
t.rayquaza = {name = 'Rayquaza', ndex = 384, type1 = 'drago', type2 = 'volante'}
t[384] = t.rayquaza
t.jirachi = {name = 'Jirachi', ndex = 385, type1 = 'acciaio', type2 = 'psico'}
t[385] = t.jirachi
t.deoxys = {name = 'Deoxys', ndex = 386, type1 = 'psico', type2 = 'psico'}
t[386] = t.deoxys
t.turtwig = {name = 'Turtwig', ndex = 387, type1 = 'erba', type2 = 'erba'}
t[387] = t.turtwig
t.grotle = {name = 'Grotle', ndex = 388, type1 = 'erba', type2 = 'erba'}
t[388] = t.grotle
t.torterra = {name = 'Torterra', ndex = 389, type1 = 'erba', type2 = 'terra'}
t[389] = t.torterra
t.chimchar = {name = 'Chimchar', ndex = 390, type1 = 'fuoco', type2 = 'fuoco'}
t[390] = t.chimchar
t.monferno = {name = 'Monferno', ndex = 391, type1 = 'fuoco', type2 = 'lotta'}
t[391] = t.monferno
t.infernape = {name = 'Infernape', ndex = 392, type1 = 'fuoco', type2 = 'lotta'}
t[392] = t.infernape
t.piplup = {name = 'Piplup', ndex = 393, type1 = 'acqua', type2 = 'acqua'}
t[393] = t.piplup
t.prinplup = {name = 'Prinplup', ndex = 394, type1 = 'acqua', type2 = 'acqua'}
t[394] = t.prinplup
t.empoleon = {name = 'Empoleon', ndex = 395, type1 = 'acqua', type2 = 'acciaio'}
t[395] = t.empoleon
t.starly = {name = 'Starly', ndex = 396, type1 = 'normale', type2 = 'volante'}
t[396] = t.starly
t.staravia = {name = 'Staravia', ndex = 397, type1 = 'normale', type2 = 'volante'}
t[397] = t.staravia
t.staraptor = {name = 'Staraptor', ndex = 398, type1 = 'normale', type2 = 'volante'}
t[398] = t.staraptor
t.bidoof = {name = 'Bidoof', ndex = 399, type1 = 'normale', type2 = 'normale'}
t[399] = t.bidoof
t.bibarel = {name = 'Bibarel', ndex = 400, type1 = 'normale', type2 = 'acqua'}
t[400] = t.bibarel
t.kricketot = {name = 'Kricketot', ndex = 401, type1 = 'coleottero', type2 = 'coleottero'}
t[401] = t.kricketot
t.kricketune = {name = 'Kricketune', ndex = 402, type1 = 'coleottero', type2 = 'coleottero'}
t[402] = t.kricketune
t.shinx = {name = 'Shinx', ndex = 403, type1 = 'elettro', type2 = 'elettro'}
t[403] = t.shinx
t.luxio = {name = 'Luxio', ndex = 404, type1 = 'elettro', type2 = 'elettro'}
t[404] = t.luxio
t.luxray = {name = 'Luxray', ndex = 405, type1 = 'elettro', type2 = 'elettro'}
t[405] = t.luxray
t.budew = {name = 'Budew', ndex = 406, type1 = 'erba', type2 = 'veleno'}
t[406] = t.budew
t.roserade = {name = 'Roserade', ndex = 407, type1 = 'erba', type2 = 'veleno'}
t[407] = t.roserade
t.cranidos = {name = 'Cranidos', ndex = 408, type1 = 'roccia', type2 = 'roccia'}
t[408] = t.cranidos
t.rampardos = {name = 'Rampardos', ndex = 409, type1 = 'roccia', type2 = 'roccia'}
t[409] = t.rampardos
t.shieldon = {name = 'Shieldon', ndex = 410, type1 = 'roccia', type2 = 'acciaio'}
t[410] = t.shieldon
t.bastiodon = {name = 'Bastiodon', ndex = 411, type1 = 'roccia', type2 = 'acciaio'}
t[411] = t.bastiodon
t.burmy = {name = 'Burmy', ndex = 412, type1 = 'coleottero', type2 = 'coleottero'}
t[412] = t.burmy
t.wormadam = {name = 'Wormadam', ndex = 413, type1 = 'coleot', type2 = 'erba'}
t[413] = t.wormadam
t.mothim = {name = 'Mothim', ndex = 414, type1 = 'coleot', type2 = 'volante'}
t[414] = t.mothim
t.combee = {name = 'Combee', ndex = 415, type1 = 'coleot', type2 = 'volante'}
t[415] = t.combee
t.vespiquen = {name = 'Vespiquen', ndex = 416, type1 = 'coleot', type2 = 'volante'}
t[416] = t.vespiquen
t.pachirisu = {name = 'Pachirisu', ndex = 417, type1 = 'elettro', type2 = 'elettro'}
t[417] = t.pachirisu
t.buizel = {name = 'Buizel', ndex = 418, type1 = 'acqua', type2 = 'acqua'}
t[418] = t.buizel
t.floatzel = {name = 'Floatzel', ndex = 419, type1 = 'acqua', type2 = 'acqua'}
t[419] = t.floatzel
t.cherubi = {name = 'Cherubi', ndex = 420, type1 = 'erba', type2 = 'erba'}
t[420] = t.cherubi
t.cherrim = {name = 'Cherrim', ndex = 421, type1 = 'erba', type2 = 'erba'}
t[421] = t.cherrim
t.shellos = {name = 'Shellos', ndex = 422, type1 = 'acqua', type2 = 'acqua'}
t[422] = t.shellos
t.gastrodon = {name = 'Gastrodon', ndex = 423, type1 = 'acqua', type2 = 'terra'}
t[423] = t.gastrodon
t.ambipom = {name = 'Ambipom', ndex = 424, type1 = 'normale', type2 = 'normale'}
t[424] = t.ambipom
t.drifloon = {name = 'Drifloon', ndex = 425, type1 = 'spettro', type2 = 'volante'}
t[425] = t.drifloon
t.drifblim = {name = 'Drifblim', ndex = 426, type1 = 'spettro', type2 = 'volante'}
t[426] = t.drifblim
t.buneary = {name = 'Buneary', ndex = 427, type1 = 'normale', type2 = 'normale'}
t[427] = t.buneary
t.lopunny = {name = 'Lopunny', ndex = 428, type1 = 'normale', type2 = 'normale'}
t[428] = t.lopunny
t.mismagius = {name = 'Mismagius', ndex = 429, type1 = 'spettro', type2 = 'spettro'}
t[429] = t.mismagius
t.honchkrow = {name = 'Honchkrow', ndex = 430, type1 = 'buio', type2 = 'volante'}
t[430] = t.honchkrow
t.glameow = {name = 'Glameow', ndex = 431, type1 = 'normale', type2 = 'normale'}
t[431] = t.glameow
t.purugly = {name = 'Purugly', ndex = 432, type1 = 'normale', type2 = 'normale'}
t[432] = t.purugly
t.chingling = {name = 'Chingling', ndex = 433, type1 = 'psico', type2 = 'psico'}
t[433] = t.chingling
t.stunky = {name = 'Stunky', ndex = 434, type1 = 'veleno', type2 = 'buio'}
t[434] = t.stunky
t.skuntank = {name = 'Skuntank', ndex = 435, type1 = 'veleno', type2 = 'buio'}
t[435] = t.skuntank
t.bronzor = {name = 'Bronzor', ndex = 436, type1 = 'acciaio', type2 = 'psico'}
t[436] = t.bronzor
t.bronzong = {name = 'Bronzong', ndex = 437, type1 = 'acciaio', type2 = 'psico'}
t[437] = t.bronzong
t.bonsly = {name = 'Bonsly', ndex = 438, type1 = 'roccia', type2 = 'roccia'}
t[438] = t.bonsly
t['mime jr.'] = {name = 'Mime Jr.', ndex = 439, type1 = 'psico', type2 = 'folletto'}
t[439] = t['mime jr.']
t.happiny = {name = 'Happiny', ndex = 440, type1 = 'normale', type2 = 'normale'}
t[440] = t.happiny
t.chatot = {name = 'Chatot', ndex = 441, type1 = 'normale', type2 = 'volante'}
t[441] = t.chatot
t.spiritomb = {name = 'Spiritomb', ndex = 442, type1 = 'spettro', type2 = 'buio'}
t[442] = t.spiritomb
t.gible = {name = 'Gible', ndex = 443, type1 = 'drago', type2 = 'terra'}
t[443] = t.gible
t.gabite = {name = 'Gabite', ndex = 444, type1 = 'drago', type2 = 'terra'}
t[444] = t.gabite
t.garchomp = {name = 'Garchomp', ndex = 445, type1 = 'drago', type2 = 'terra'}
t[445] = t.garchomp
t.munchlax = {name = 'Munchlax', ndex = 446, type1 = 'normale', type2 = 'normale'}
t[446] = t.munchlax
t.riolu = {name = 'Riolu', ndex = 447, type1 = 'lotta', type2 = 'lotta'}
t[447] = t.riolu
t.lucario = {name = 'Lucario', ndex = 448, type1 = 'lotta', type2 = 'acciaio'}
t[448] = t.lucario
t.hippopotas = {name = 'Hippopotas', ndex = 449, type1 = 'terra', type2 = 'terra'}
t[449] = t.hippopotas
t.hippowdon = {name = 'Hippowdon', ndex = 450, type1 = 'terra', type2 = 'terra'}
t[450] = t.hippowdon
t.skorupi = {name = 'Skorupi', ndex = 451, type1 = 'veleno', type2 = 'coleot'}
t[451] = t.skorupi
t.drapion = {name = 'Drapion', ndex = 452, type1 = 'veleno', type2 = 'buio'}
t[452] = t.drapion
t.croagunk = {name = 'Croagunk', ndex = 453, type1 = 'veleno', type2 = 'lotta'}
t[453] = t.croagunk
t.toxicroak = {name = 'Toxicroak', ndex = 454, type1 = 'veleno', type2 = 'lotta'}
t[454] = t.toxicroak
t.carnivine = {name = 'Carnivine', ndex = 455, type1 = 'erba', type2 = 'erba'}
t[455] = t.carnivine
t.finneon = {name = 'Finneon', ndex = 456, type1 = 'acqua', type2 = 'acqua'}
t[456] = t.finneon
t.lumineon = {name = 'Lumineon', ndex = 457, type1 = 'acqua', type2 = 'acqua'}
t[457] = t.lumineon
t.mantyke = {name = 'Mantyke', ndex = 458, type1 = 'acqua', type2 = 'volante'}
t[458] = t.mantyke
t.snover = {name = 'Snover', ndex = 459, type1 = 'erba', type2 = 'ghiaccio'}
t[459] = t.snover
t.abomasnow = {name = 'Abomasnow', ndex = 460, type1 = 'erba', type2 = 'ghiaccio'}
t[460] = t.abomasnow
t.weavile = {name = 'Weavile', ndex = 461, type1 = 'buio', type2 = 'ghiaccio'}
t[461] = t.weavile
t.magnezone = {name = 'Magnezone', ndex = 462, type1 = 'elettro', type2 = 'acciaio'}
t[462] = t.magnezone
t.lickilicky = {name = 'Lickilicky', ndex = 463, type1 = 'normale', type2 = 'normale'}
t[463] = t.lickilicky
t.rhyperior = {name = 'Rhyperior', ndex = 464, type1 = 'terra', type2 = 'roccia'}
t[464] = t.rhyperior
t.tangrowth = {name = 'Tangrowth', ndex = 465, type1 = 'erba', type2 = 'erba'}
t[465] = t.tangrowth
t.electivire = {name = 'Electivire', ndex = 466, type1 = 'elettro', type2 = 'elettro'}
t[466] = t.electivire
t.magmortar = {name = 'Magmortar', ndex = 467, type1 = 'fuoco', type2 = 'fuoco'}
t[467] = t.magmortar
t.togekiss = {name = 'Togekiss', ndex = 468, type1 = 'folletto', type2 = 'volante'}
t[468] = t.togekiss
t.yanmega = {name = 'Yanmega', ndex = 469, type1 = 'coleot', type2 = 'volante'}
t[469] = t.yanmega
t.leafeon = {name = 'Leafeon', ndex = 470, type1 = 'erba', type2 = 'erba'}
t[470] = t.leafeon
t.glaceon = {name = 'Glaceon', ndex = 471, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[471] = t.glaceon
t.gliscor = {name = 'Gliscor', ndex = 472, type1 = 'terra', type2 = 'volante'}
t[472] = t.gliscor
t.mamoswine = {name = 'Mamoswine', ndex = 473, type1 = 'ghiaccio', type2 = 'terra'}
t[473] = t.mamoswine
t['porygon-z'] = {name = 'Porygon-Z', ndex = 474, type1 = 'normale', type2 = 'normale'}
t[474] = t['porygon-z']
t.gallade = {name = 'Gallade', ndex = 475, type1 = 'psico', type2 = 'lotta'}
t[475] = t.gallade
t.probopass = {name = 'Probopass', ndex = 476, type1 = 'roccia', type2 = 'acciaio'}
t[476] = t.probopass
t.dusknoir = {name = 'Dusknoir', ndex = 477, type1 = 'spettro', type2 = 'spettro'}
t[477] = t.dusknoir
t.froslass = {name = 'Froslass', ndex = 478, type1 = 'ghiaccio', type2 = 'spettro'}
t[478] = t.froslass
t.rotom = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'spettro'}
t[479] = t.rotom
t.uxie = {name = 'Uxie', ndex = 480, type1 = 'psico', type2 = 'psico'}
t[480] = t.uxie
t.mesprit = {name = 'Mesprit', ndex = 481, type1 = 'psico', type2 = 'psico'}
t[481] = t.mesprit
t.azelf = {name = 'Azelf', ndex = 482, type1 = 'psico', type2 = 'psico'}
t[482] = t.azelf
t.dialga = {name = 'Dialga', ndex = 483, type1 = 'acciaio', type2 = 'drago'}
t[483] = t.dialga
t.palkia = {name = 'Palkia', ndex = 484, type1 = 'acqua', type2 = 'drago'}
t[484] = t.palkia
t.heatran = {name = 'Heatran', ndex = 485, type1 = 'fuoco', type2 = 'acciaio'}
t[485] = t.heatran
t.regigigas = {name = 'Regigigas', ndex = 486, type1 = 'normale', type2 = 'normale'}
t[486] = t.regigigas
t.giratina = {name = 'Giratina', ndex = 487, type1 = 'spettro', type2 = 'drago'}
t[487] = t.giratina
t.cresselia = {name = 'Cresselia', ndex = 488, type1 = 'psico', type2 = 'psico'}
t[488] = t.cresselia
t.phione = {name = 'Phione', ndex = 489, type1 = 'acqua', type2 = 'acqua'}
t[489] = t.phione
t.manaphy = {name = 'Manaphy', ndex = 490, type1 = 'acqua', type2 = 'acqua'}
t[490] = t.manaphy
t.darkrai = {name = 'Darkrai', ndex = 491, type1 = 'buio', type2 = 'buio'}
t[491] = t.darkrai
t.shaymin = {name = 'Shaymin', ndex = 492, type1 = 'erba', type2 = 'erba'}
t[492] = t.shaymin
t.arceus = {name = 'Arceus', ndex = 493, type1 = 'normale', type2 = 'normale'}
t[493] = t.arceus
t.victini = {name = 'Victini', ndex = 494, type1 = 'psico', type2 = 'fuoco'}
t[494] = t.victini
t.snivy = {name = 'Snivy', ndex = 495, type1 = 'erba', type2 = 'erba'}
t[495] = t.snivy
t.servine = {name = 'Servine', ndex = 496, type1 = 'erba', type2 = 'erba'}
t[496] = t.servine
t.serperior = {name = 'Serperior', ndex = 497, type1 = 'erba', type2 = 'erba'}
t[497] = t.serperior
t.tepig = {name = 'Tepig', ndex = 498, type1 = 'fuoco', type2 = 'fuoco'}
t[498] = t.tepig
t.pignite = {name = 'Pignite', ndex = 499, type1 = 'fuoco', type2 = 'lotta'}
t[499] = t.pignite
t.emboar = {name = 'Emboar', ndex = 500, type1 = 'fuoco', type2 = 'lotta'}
t[500] = t.emboar
t.oshawott = {name = 'Oshawott', ndex = 501, type1 = 'acqua', type2 = 'acqua'}
t[501] = t.oshawott
t.dewott = {name = 'Dewott', ndex = 502, type1 = 'acqua', type2 = 'acqua'}
t[502] = t.dewott
t.samurott = {name = 'Samurott', ndex = 503, type1 = 'acqua', type2 = 'acqua'}
t[503] = t.samurott
t.patrat = {name = 'Patrat', ndex = 504, type1 = 'normale', type2 = 'normale'}
t[504] = t.patrat
t.watchog = {name = 'Watchog', ndex = 505, type1 = 'normale', type2 = 'normale'}
t[505] = t.watchog
t.lillipup = {name = 'Lillipup', ndex = 506, type1 = 'normale', type2 = 'normale'}
t[506] = t.lillipup
t.herdier = {name = 'Herdier', ndex = 507, type1 = 'normale', type2 = 'normale'}
t[507] = t.herdier
t.stoutland = {name = 'Stoutland', ndex = 508, type1 = 'normale', type2 = 'normale'}
t[508] = t.stoutland
t.purrloin = {name = 'Purrloin', ndex = 509, type1 = 'buio', type2 = 'buio'}
t[509] = t.purrloin
t.liepard = {name = 'Liepard', ndex = 510, type1 = 'buio', type2 = 'buio'}
t[510] = t.liepard
t.pansage = {name = 'Pansage', ndex = 511, type1 = 'erba', type2 = 'erba'}
t[511] = t.pansage
t.simisage = {name = 'Simisage', ndex = 512, type1 = 'erba', type2 = 'erba'}
t[512] = t.simisage
t.pansear = {name = 'Pansear', ndex = 513, type1 = 'fuoco', type2 = 'fuoco'}
t[513] = t.pansear
t.simisear = {name = 'Simisear', ndex = 514, type1 = 'fuoco', type2 = 'fuoco'}
t[514] = t.simisear
t.panpour = {name = 'Panpour', ndex = 515, type1 = 'acqua', type2 = 'acqua'}
t[515] = t.panpour
t.simipour = {name = 'Simipour', ndex = 516, type1 = 'acqua', type2 = 'acqua'}
t[516] = t.simipour
t.munna = {name = 'Munna', ndex = 517, type1 = 'psico', type2 = 'psico'}
t[517] = t.munna
t.musharna = {name = 'Musharna', ndex = 518, type1 = 'psico', type2 = 'psico'}
t[518] = t.musharna
t.pidove = {name = 'Pidove', ndex = 519, type1 = 'normale', type2 = 'volante'}
t[519] = t.pidove
t.tranquill = {name = 'Tranquill', ndex = 520, type1 = 'normale', type2 = 'volante'}
t[520] = t.tranquill
t.unfezant = {name = 'Unfezant', ndex = 521, type1 = 'normale', type2 = 'volante'}
t[521] = t.unfezant
t.blitzle = {name = 'Blitzle', ndex = 522, type1 = 'elettro', type2 = 'elettro'}
t[522] = t.blitzle
t.zebstrika = {name = 'Zebstrika', ndex = 523, type1 = 'elettro', type2 = 'elettro'}
t[523] = t.zebstrika
t.roggenrola = {name = 'Roggenrola', ndex = 524, type1 = 'roccia', type2 = 'roccia'}
t[524] = t.roggenrola
t.boldore = {name = 'Boldore', ndex = 525, type1 = 'roccia', type2 = 'roccia'}
t[525] = t.boldore
t.gigalith = {name = 'Gigalith', ndex = 526, type1 = 'roccia', type2 = 'roccia'}
t[526] = t.gigalith
t.woobat = {name = 'Woobat', ndex = 527, type1 = 'psico', type2 = 'volante'}
t[527] = t.woobat
t.swoobat = {name = 'Swoobat', ndex = 528, type1 = 'psico', type2 = 'volante'}
t[528] = t.swoobat
t.drilbur = {name = 'Drilbur', ndex = 529, type1 = 'terra', type2 = 'terra'}
t[529] = t.drilbur
t.excadrill = {name = 'Excadrill', ndex = 530, type1 = 'terra', type2 = 'acciaio'}
t[530] = t.excadrill
t.audino = {name = 'Audino', ndex = 531, type1 = 'normale', type2 = 'normale'}
t[531] = t.audino
t.timburr = {name = 'Timburr', ndex = 532, type1 = 'lotta', type2 = 'lotta'}
t[532] = t.timburr
t.gurdurr = {name = 'Gurdurr', ndex = 533, type1 = 'lotta', type2 = 'lotta'}
t[533] = t.gurdurr
t.conkeldurr = {name = 'Conkeldurr', ndex = 534, type1 = 'lotta', type2 = 'lotta'}
t[534] = t.conkeldurr
t.tympole = {name = 'Tympole', ndex = 535, type1 = 'acqua', type2 = 'acqua'}
t[535] = t.tympole
t.palpitoad = {name = 'Palpitoad', ndex = 536, type1 = 'acqua', type2 = 'terra'}
t[536] = t.palpitoad
t.seismitoad = {name = 'Seismitoad', ndex = 537, type1 = 'acqua', type2 = 'terra'}
t[537] = t.seismitoad
t.throh = {name = 'Throh', ndex = 538, type1 = 'lotta', type2 = 'lotta'}
t[538] = t.throh
t.sawk = {name = 'Sawk', ndex = 539, type1 = 'lotta', type2 = 'lotta'}
t[539] = t.sawk
t.sewaddle = {name = 'Sewaddle', ndex = 540, type1 = 'coleot', type2 = 'erba'}
t[540] = t.sewaddle
t.swadloon = {name = 'Swadloon', ndex = 541, type1 = 'coleot', type2 = 'erba'}
t[541] = t.swadloon
t.leavanny = {name = 'Leavanny', ndex = 542, type1 = 'coleot', type2 = 'erba'}
t[542] = t.leavanny
t.venipede = {name = 'Venipede', ndex = 543, type1 = 'coleot', type2 = 'veleno'}
t[543] = t.venipede
t.whirlipede = {name = 'Whirlipede', ndex = 544, type1 = 'coleot', type2 = 'veleno'}
t[544] = t.whirlipede
t.scolipede = {name = 'Scolipede', ndex = 545, type1 = 'coleot', type2 = 'veleno'}
t[545] = t.scolipede
t.cottonee = {name = 'Cottonee', ndex = 546, type1 = 'erba', type2 = 'folletto'}
t[546] = t.cottonee
t.whimsicott = {name = 'Whimsicott', ndex = 547, type1 = 'erba', type2 = 'folletto'}
t[547] = t.whimsicott
t.petilil = {name = 'Petilil', ndex = 548, type1 = 'erba', type2 = 'erba'}
t[548] = t.petilil
t.lilligant = {name = 'Lilligant', ndex = 549, type1 = 'erba', type2 = 'erba'}
t[549] = t.lilligant
t.basculin = {name = 'Basculin', ndex = 550, type1 = 'acqua', type2 = 'acqua'}
t[550] = t.basculin
t.sandile = {name = 'Sandile', ndex = 551, type1 = 'terra', type2 = 'buio'}
t[551] = t.sandile
t.krokorok = {name = 'Krokorok', ndex = 552, type1 = 'terra', type2 = 'buio'}
t[552] = t.krokorok
t.krookodile = {name = 'Krookodile', ndex = 553, type1 = 'terra', type2 = 'buio'}
t[553] = t.krookodile
t.darumaka = {name = 'Darumaka', ndex = 554, type1 = 'fuoco', type2 = 'fuoco'}
t[554] = t.darumaka
t.darmanitan = {name = 'Darmanitan', ndex = 555, type1 = 'fuoco', type2 = 'fuoco'}
t[555] = t.darmanitan
t.maractus = {name = 'Maractus', ndex = 556, type1 = 'erba', type2 = 'erba'}
t[556] = t.maractus
t.dwebble = {name = 'Dwebble', ndex = 557, type1 = 'coleot', type2 = 'roccia'}
t[557] = t.dwebble
t.crustle = {name = 'Crustle', ndex = 558, type1 = 'coleot', type2 = 'roccia'}
t[558] = t.crustle
t.scraggy = {name = 'Scraggy', ndex = 559, type1 = 'buio', type2 = 'lotta'}
t[559] = t.scraggy
t.scrafty = {name = 'Scrafty', ndex = 560, type1 = 'buio', type2 = 'lotta'}
t[560] = t.scrafty
t.sigilyph = {name = 'Sigilyph', ndex = 561, type1 = 'psico', type2 = 'volante'}
t[561] = t.sigilyph
t.yamask = {name = 'Yamask', ndex = 562, type1 = 'spettro', type2 = 'spettro'}
t[562] = t.yamask
t.cofagrigus = {name = 'Cofagrigus', ndex = 563, type1 = 'spettro', type2 = 'spettro'}
t[563] = t.cofagrigus
t.tirtouga = {name = 'Tirtouga', ndex = 564, type1 = 'acqua', type2 = 'roccia'}
t[564] = t.tirtouga
t.carracosta = {name = 'Carracosta', ndex = 565, type1 = 'acqua', type2 = 'roccia'}
t[565] = t.carracosta
t.archen = {name = 'Archen', ndex = 566, type1 = 'roccia', type2 = 'volante'}
t[566] = t.archen
t.archeops = {name = 'Archeops', ndex = 567, type1 = 'roccia', type2 = 'volante'}
t[567] = t.archeops
t.trubbish = {name = 'Trubbish', ndex = 568, type1 = 'veleno', type2 = 'veleno'}
t[568] = t.trubbish
t.garbodor = {name = 'Garbodor', ndex = 569, type1 = 'veleno', type2 = 'veleno'}
t[569] = t.garbodor
t.zorua = {name = 'Zorua', ndex = 570, type1 = 'buio', type2 = 'buio'}
t[570] = t.zorua
t.zoroark = {name = 'Zoroark', ndex = 571, type1 = 'buio', type2 = 'buio'}
t[571] = t.zoroark
t.minccino = {name = 'Minccino', ndex = 572, type1 = 'normale', type2 = 'normale'}
t[572] = t.minccino
t.cinccino = {name = 'Cinccino', ndex = 573, type1 = 'normale', type2 = 'normale'}
t[573] = t.cinccino
t.gothita = {name = 'Gothita', ndex = 574, type1 = 'psico', type2 = 'psico'}
t[574] = t.gothita
t.gothorita = {name = 'Gothorita', ndex = 575, type1 = 'psico', type2 = 'psico'}
t[575] = t.gothorita
t.gothitelle = {name = 'Gothitelle', ndex = 576, type1 = 'psico', type2 = 'psico'}
t[576] = t.gothitelle
t.solosis = {name = 'Solosis', ndex = 577, type1 = 'psico', type2 = 'psico'}
t[577] = t.solosis
t.duosion = {name = 'Duosion', ndex = 578, type1 = 'psico', type2 = 'psico'}
t[578] = t.duosion
t.reuniclus = {name = 'Reuniclus', ndex = 579, type1 = 'psico', type2 = 'psico'}
t[579] = t.reuniclus
t.ducklett = {name = 'Ducklett', ndex = 580, type1 = 'acqua', type2 = 'volante'}
t[580] = t.ducklett
t.swanna = {name = 'Swanna', ndex = 581, type1 = 'acqua', type2 = 'volante'}
t[581] = t.swanna
t.vanillite = {name = 'Vanillite', ndex = 582, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[582] = t.vanillite
t.vanillish = {name = 'Vanillish', ndex = 583, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[583] = t.vanillish
t.vanilluxe = {name = 'Vanilluxe', ndex = 584, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[584] = t.vanilluxe
t.deerling = {name = 'Deerling', ndex = 585, type1 = 'normale', type2 = 'erba'}
t[585] = t.deerling
t.sawsbuck = {name = 'Sawsbuck', ndex = 586, type1 = 'normale', type2 = 'erba'}
t[586] = t.sawsbuck
t.emolga = {name = 'Emolga', ndex = 587, type1 = 'elettro', type2 = 'volante'}
t[587] = t.emolga
t.karrablast = {name = 'Karrablast', ndex = 588, type1 = 'coleottero', type2 = 'coleottero'}
t[588] = t.karrablast
t.escavalier = {name = 'Escavalier', ndex = 589, type1 = 'coleot', type2 = 'acciaio'}
t[589] = t.escavalier
t.foongus = {name = 'Foongus', ndex = 590, type1 = 'erba', type2 = 'veleno'}
t[590] = t.foongus
t.amoonguss = {name = 'Amoonguss', ndex = 591, type1 = 'erba', type2 = 'veleno'}
t[591] = t.amoonguss
t.frillish = {name = 'Frillish', ndex = 592, type1 = 'acqua', type2 = 'spettro'}
t[592] = t.frillish
t.jellicent = {name = 'Jellicent', ndex = 593, type1 = 'acqua', type2 = 'spettro'}
t[593] = t.jellicent
t.alomomola = {name = 'Alomomola', ndex = 594, type1 = 'acqua', type2 = 'acqua'}
t[594] = t.alomomola
t.joltik = {name = 'Joltik', ndex = 595, type1 = 'coleot', type2 = 'elettro'}
t[595] = t.joltik
t.galvantula = {name = 'Galvantula', ndex = 596, type1 = 'coleot', type2 = 'elettro'}
t[596] = t.galvantula
t.ferroseed = {name = 'Ferroseed', ndex = 597, type1 = 'erba', type2 = 'acciaio'}
t[597] = t.ferroseed
t.ferrothorn = {name = 'Ferrothorn', ndex = 598, type1 = 'erba', type2 = 'acciaio'}
t[598] = t.ferrothorn
t.klink = {name = 'Klink', ndex = 599, type1 = 'acciaio', type2 = 'acciaio'}
t[599] = t.klink
t.klang = {name = 'Klang', ndex = 600, type1 = 'acciaio', type2 = 'acciaio'}
t[600] = t.klang
t.klinklang = {name = 'Klinklang', ndex = 601, type1 = 'acciaio', type2 = 'acciaio'}
t[601] = t.klinklang
t.tynamo = {name = 'Tynamo', ndex = 602, type1 = 'elettro', type2 = 'elettro'}
t[602] = t.tynamo
t.eelektrik = {name = 'Eelektrik', ndex = 603, type1 = 'elettro', type2 = 'elettro'}
t[603] = t.eelektrik
t.eelektross = {name = 'Eelektross', ndex = 604, type1 = 'elettro', type2 = 'elettro'}
t[604] = t.eelektross
t.elgyem = {name = 'Elgyem', ndex = 605, type1 = 'psico', type2 = 'psico'}
t[605] = t.elgyem
t.beheeyem = {name = 'Beheeyem', ndex = 606, type1 = 'psico', type2 = 'psico'}
t[606] = t.beheeyem
t.litwick = {name = 'Litwick', ndex = 607, type1 = 'spettro', type2 = 'fuoco'}
t[607] = t.litwick
t.lampent = {name = 'Lampent', ndex = 608, type1 = 'spettro', type2 = 'fuoco'}
t[608] = t.lampent
t.chandelure = {name = 'Chandelure', ndex = 609, type1 = 'spettro', type2 = 'fuoco'}
t[609] = t.chandelure
t.axew = {name = 'Axew', ndex = 610, type1 = 'drago', type2 = 'drago'}
t[610] = t.axew
t.fraxure = {name = 'Fraxure', ndex = 611, type1 = 'drago', type2 = 'drago'}
t[611] = t.fraxure
t.haxorus = {name = 'Haxorus', ndex = 612, type1 = 'drago', type2 = 'drago'}
t[612] = t.haxorus
t.cubchoo = {name = 'Cubchoo', ndex = 613, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[613] = t.cubchoo
t.beartic = {name = 'Beartic', ndex = 614, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[614] = t.beartic
t.cryogonal = {name = 'Cryogonal', ndex = 615, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[615] = t.cryogonal
t.shelmet = {name = 'Shelmet', ndex = 616, type1 = 'coleottero', type2 = 'coleottero'}
t[616] = t.shelmet
t.accelgor = {name = 'Accelgor', ndex = 617, type1 = 'coleottero', type2 = 'coleottero'}
t[617] = t.accelgor
t.stunfisk = {name = 'Stunfisk', ndex = 618, type1 = 'terra', type2 = 'elettro'}
t[618] = t.stunfisk
t.mienfoo = {name = 'Mienfoo', ndex = 619, type1 = 'lotta', type2 = 'lotta'}
t[619] = t.mienfoo
t.mienshao = {name = 'Mienshao', ndex = 620, type1 = 'lotta', type2 = 'lotta'}
t[620] = t.mienshao
t.druddigon = {name = 'Druddigon', ndex = 621, type1 = 'drago', type2 = 'drago'}
t[621] = t.druddigon
t.golett = {name = 'Golett', ndex = 622, type1 = 'terra', type2 = 'spettro'}
t[622] = t.golett
t.golurk = {name = 'Golurk', ndex = 623, type1 = 'terra', type2 = 'spettro'}
t[623] = t.golurk
t.pawniard = {name = 'Pawniard', ndex = 624, type1 = 'buio', type2 = 'acciaio'}
t[624] = t.pawniard
t.bisharp = {name = 'Bisharp', ndex = 625, type1 = 'buio', type2 = 'acciaio'}
t[625] = t.bisharp
t.bouffalant = {name = 'Bouffalant', ndex = 626, type1 = 'normale', type2 = 'normale'}
t[626] = t.bouffalant
t.rufflet = {name = 'Rufflet', ndex = 627, type1 = 'normale', type2 = 'volante'}
t[627] = t.rufflet
t.braviary = {name = 'Braviary', ndex = 628, type1 = 'normale', type2 = 'volante'}
t[628] = t.braviary
t.vullaby = {name = 'Vullaby', ndex = 629, type1 = 'buio', type2 = 'volante'}
t[629] = t.vullaby
t.mandibuzz = {name = 'Mandibuzz', ndex = 630, type1 = 'buio', type2 = 'volante'}
t[630] = t.mandibuzz
t.heatmor = {name = 'Heatmor', ndex = 631, type1 = 'fuoco', type2 = 'fuoco'}
t[631] = t.heatmor
t.durant = {name = 'Durant', ndex = 632, type1 = 'coleot', type2 = 'acciaio'}
t[632] = t.durant
t.deino = {name = 'Deino', ndex = 633, type1 = 'buio', type2 = 'drago'}
t[633] = t.deino
t.zweilous = {name = 'Zweilous', ndex = 634, type1 = 'buio', type2 = 'drago'}
t[634] = t.zweilous
t.hydreigon = {name = 'Hydreigon', ndex = 635, type1 = 'buio', type2 = 'drago'}
t[635] = t.hydreigon
t.larvesta = {name = 'Larvesta', ndex = 636, type1 = 'coleot', type2 = 'fuoco'}
t[636] = t.larvesta
t.volcarona = {name = 'Volcarona', ndex = 637, type1 = 'coleot', type2 = 'fuoco'}
t[637] = t.volcarona
t.cobalion = {name = 'Cobalion', ndex = 638, type1 = 'acciaio', type2 = 'lotta'}
t[638] = t.cobalion
t.terrakion = {name = 'Terrakion', ndex = 639, type1 = 'roccia', type2 = 'lotta'}
t[639] = t.terrakion
t.virizion = {name = 'Virizion', ndex = 640, type1 = 'erba', type2 = 'lotta'}
t[640] = t.virizion
t.tornadus = {name = 'Tornadus', ndex = 641, type1 = 'volante', type2 = 'volante'}
t[641] = t.tornadus
t.thundurus = {name = 'Thundurus', ndex = 642, type1 = 'elettro', type2 = 'volante'}
t[642] = t.thundurus
t.reshiram = {name = 'Reshiram', ndex = 643, type1 = 'drago', type2 = 'fuoco'}
t[643] = t.reshiram
t.zekrom = {name = 'Zekrom', ndex = 644, type1 = 'drago', type2 = 'elettro'}
t[644] = t.zekrom
t.landorus = {name = 'Landorus', ndex = 645, type1 = 'terra', type2 = 'volante'}
t[645] = t.landorus
t.kyurem = {name = 'Kyurem', ndex = 646, type1 = 'drago', type2 = 'ghiaccio'}
t[646] = t.kyurem
t.keldeo = {name = 'Keldeo', ndex = 647, type1 = 'acqua', type2 = 'lotta'}
t[647] = t.keldeo
t.meloetta = {name = 'Meloetta', ndex = 648, type1 = 'normale', type2 = 'psico'}
t[648] = t.meloetta
t.genesect = {name = 'Genesect', ndex = 649, type1 = 'coleot', type2 = 'acciaio'}
t[649] = t.genesect
t.chespin = {name = 'Chespin', ndex = 650, type1 = 'erba', type2 = 'erba'}
t[650] = t.chespin
t.quilladin = {name = 'Quilladin', ndex = 651, type1 = 'erba', type2 = 'erba'}
t[651] = t.quilladin
t.chesnaught = {name = 'Chesnaught', ndex = 652, type1 = 'erba', type2 = 'lotta'}
t[652] = t.chesnaught
t.fennekin = {name = 'Fennekin', ndex = 653, type1 = 'fuoco', type2 = 'fuoco'}
t[653] = t.fennekin
t.braixen = {name = 'Braixen', ndex = 654, type1 = 'fuoco', type2 = 'fuoco'}
t[654] = t.braixen
t.delphox = {name = 'Delphox', ndex = 655, type1 = 'fuoco', type2 = 'psico'}
t[655] = t.delphox
t.froakie = {name = 'Froakie', ndex = 656, type1 = 'acqua', type2 = 'acqua'}
t[656] = t.froakie
t.frogadier = {name = 'Frogadier', ndex = 657, type1 = 'acqua', type2 = 'acqua'}
t[657] = t.frogadier
t.greninja = {name = 'Greninja', ndex = 658, type1 = 'acqua', type2 = 'buio'}
t[658] = t.greninja
t.bunnelby = {name = 'Bunnelby', ndex = 659, type1 = 'normale', type2 = 'normale'}
t[659] = t.bunnelby
t.diggersby = {name = 'Diggersby', ndex = 660, type1 = 'normale', type2 = 'terra'}
t[660] = t.diggersby
t.fletchling = {name = 'Fletchling', ndex = 661, type1 = 'normale', type2 = 'volante'}
t[661] = t.fletchling
t.fletchinder = {name = 'Fletchinder', ndex = 662, type1 = 'fuoco', type2 = 'volante'}
t[662] = t.fletchinder
t.talonflame = {name = 'Talonflame', ndex = 663, type1 = 'fuoco', type2 = 'volante'}
t[663] = t.talonflame
t.scatterbug = {name = 'Scatterbug', ndex = 664, type1 = 'coleottero', type2 = 'coleottero'}
t[664] = t.scatterbug
t.spewpa = {name = 'Spewpa', ndex = 665, type1 = 'coleottero', type2 = 'coleottero'}
t[665] = t.spewpa
t.vivillon = {name = 'Vivillon', ndex = 666, type1 = 'coleot', type2 = 'volante'}
t[666] = t.vivillon
t.litleo = {name = 'Litleo', ndex = 667, type1 = 'fuoco', type2 = 'normale'}
t[667] = t.litleo
t.pyroar = {name = 'Pyroar', ndex = 668, type1 = 'fuoco', type2 = 'normale'}
t[668] = t.pyroar
t['flabébé'] = {name = 'Flabébé', ndex = 669, type1 = 'folletto', type2 = 'folletto'}
t[669] = t['flabébé']
t.floette = {name = 'Floette', ndex = 670, type1 = 'folletto', type2 = 'folletto'}
t[670] = t.floette
t.florges = {name = 'Florges', ndex = 671, type1 = 'folletto', type2 = 'folletto'}
t[671] = t.florges
t.skiddo = {name = 'Skiddo', ndex = 672, type1 = 'erba', type2 = 'erba'}
t[672] = t.skiddo
t.gogoat = {name = 'Gogoat', ndex = 673, type1 = 'erba', type2 = 'erba'}
t[673] = t.gogoat
t.pancham = {name = 'Pancham', ndex = 674, type1 = 'lotta', type2 = 'lotta'}
t[674] = t.pancham
t.pangoro = {name = 'Pangoro', ndex = 675, type1 = 'lotta', type2 = 'buio'}
t[675] = t.pangoro
t.furfrou = {name = 'Furfrou', ndex = 676, type1 = 'normale', type2 = 'normale'}
t[676] = t.furfrou
t.espurr = {name = 'Espurr', ndex = 677, type1 = 'psico', type2 = 'psico'}
t[677] = t.espurr
t.meowstic = {name = 'Meowstic', ndex = 678, type1 = 'psico', type2 = 'psico'}
t[678] = t.meowstic
t.honedge = {name = 'Honedge', ndex = 679, type1 = 'acciaio', type2 = 'spettro'}
t[679] = t.honedge
t.doublade = {name = 'Doublade', ndex = 680, type1 = 'acciaio', type2 = 'spettro'}
t[680] = t.doublade
t.aegislash = {name = 'Aegislash', ndex = 681, type1 = 'acciaio', type2 = 'spettro'}
t[681] = t.aegislash
t.spritzee = {name = 'Spritzee', ndex = 682, type1 = 'folletto', type2 = 'folletto'}
t[682] = t.spritzee
t.aromatisse = {name = 'Aromatisse', ndex = 683, type1 = 'folletto', type2 = 'folletto'}
t[683] = t.aromatisse
t.swirlix = {name = 'Swirlix', ndex = 684, type1 = 'folletto', type2 = 'folletto'}
t[684] = t.swirlix
t.slurpuff = {name = 'Slurpuff', ndex = 685, type1 = 'folletto', type2 = 'folletto'}
t[685] = t.slurpuff
t.inkay = {name = 'Inkay', ndex = 686, type1 = 'buio', type2 = 'psico'}
t[686] = t.inkay
t.malamar = {name = 'Malamar', ndex = 687, type1 = 'buio', type2 = 'psico'}
t[687] = t.malamar
t.binacle = {name = 'Binacle', ndex = 688, type1 = 'roccia', type2 = 'acqua'}
t[688] = t.binacle
t.barbaracle = {name = 'Barbaracle', ndex = 689, type1 = 'roccia', type2 = 'acqua'}
t[689] = t.barbaracle
t.skrelp = {name = 'Skrelp', ndex = 690, type1 = 'veleno', type2 = 'acqua'}
t[690] = t.skrelp
t.dragalge = {name = 'Dragalge', ndex = 691, type1 = 'veleno', type2 = 'drago'}
t[691] = t.dragalge
t.clauncher = {name = 'Clauncher', ndex = 692, type1 = 'acqua', type2 = 'acqua'}
t[692] = t.clauncher
t.clawitzer = {name = 'Clawitzer', ndex = 693, type1 = 'acqua', type2 = 'acqua'}
t[693] = t.clawitzer
t.helioptile = {name = 'Helioptile', ndex = 694, type1 = 'elettro', type2 = 'normale'}
t[694] = t.helioptile
t.heliolisk = {name = 'Heliolisk', ndex = 695, type1 = 'elettro', type2 = 'normale'}
t[695] = t.heliolisk
t.tyrunt = {name = 'Tyrunt', ndex = 696, type1 = 'roccia', type2 = 'drago'}
t[696] = t.tyrunt
t.tyrantrum = {name = 'Tyrantrum', ndex = 697, type1 = 'roccia', type2 = 'drago'}
t[697] = t.tyrantrum
t.amaura = {name = 'Amaura', ndex = 698, type1 = 'roccia', type2 = 'ghiaccio'}
t[698] = t.amaura
t.aurorus = {name = 'Aurorus', ndex = 699, type1 = 'roccia', type2 = 'ghiaccio'}
t[699] = t.aurorus
t.sylveon = {name = 'Sylveon', ndex = 700, type1 = 'folletto', type2 = 'folletto'}
t[700] = t.sylveon
t.hawlucha = {name = 'Hawlucha', ndex = 701, type1 = 'lotta', type2 = 'volante'}
t[701] = t.hawlucha
t.dedenne = {name = 'Dedenne', ndex = 702, type1 = 'elettro', type2 = 'folletto'}
t[702] = t.dedenne
t.carbink = {name = 'Carbink', ndex = 703, type1 = 'roccia', type2 = 'folletto'}
t[703] = t.carbink
t.goomy = {name = 'Goomy', ndex = 704, type1 = 'drago', type2 = 'drago'}
t[704] = t.goomy
t.sliggoo = {name = 'Sliggoo', ndex = 705, type1 = 'drago', type2 = 'drago'}
t[705] = t.sliggoo
t.goodra = {name = 'Goodra', ndex = 706, type1 = 'drago', type2 = 'drago'}
t[706] = t.goodra
t.klefki = {name = 'Klefki', ndex = 707, type1 = 'acciaio', type2 = 'folletto'}
t[707] = t.klefki
t.phantump = {name = 'Phantump', ndex = 708, type1 = 'spettro', type2 = 'erba'}
t[708] = t.phantump
t.trevenant = {name = 'Trevenant', ndex = 709, type1 = 'spettro', type2 = 'erba'}
t[709] = t.trevenant
t.pumpkaboo = {name = 'Pumpkaboo', ndex = 710, type1 = 'spettro', type2 = 'erba'}
t[710] = t.pumpkaboo
t.gourgeist = {name = 'Gourgeist', ndex = 711, type1 = 'spettro', type2 = 'erba'}
t[711] = t.gourgeist
t.bergmite = {name = 'Bergmite', ndex = 712, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[712] = t.bergmite
t.avalugg = {name = 'Avalugg', ndex = 713, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t[713] = t.avalugg
t.noibat = {name = 'Noibat', ndex = 714, type1 = 'volante', type2 = 'drago'}
t[714] = t.noibat
t.noivern = {name = 'Noivern', ndex = 715, type1 = 'volante', type2 = 'drago'}
t[715] = t.noivern
t.xerneas = {name = 'Xerneas', ndex = 716, type1 = 'folletto', type2 = 'folletto'}
t[716] = t.xerneas
t.yveltal = {name = 'Yveltal', ndex = 717, type1 = 'buio', type2 = 'volante'}
t[717] = t.yveltal
t.zygarde = {name = 'Zygarde', ndex = 718, type1 = 'drago', type2 = 'terra'}
t[718] = t.zygarde
t.diancie = {name = 'Diancie', ndex = 719, type1 = 'roccia', type2 = 'folletto'}
t[719] = t.diancie
t.hoopa = {name = 'Hoopa', ndex = 720, type1 = 'psico', type2 = 'spettro'}
t[720] = t.hoopa
t.volcanion = {name = 'Volcanion', ndex = 721, type1 = 'fuoco', type2 = 'acqua'}
t[721] = t.volcanion
-- t.magearna = {name = 'Magearna', ndex = 0xDENIELOPUZZA, type1 = 'acciaio', type2 = 'folletto'}
-- t[0xDENIELOPUZZA] = t.magearna

-- I dati sulle forme alternative che cambiano tipo rispetto alla forma base
-- NOTA BENE: Entrambi gli indici sono stringa

t.castformS = {name = 'Castform', ndex = 351, type1 = 'fuoco', type2 = 'fuoco'}
t['351S'] = t.castformS
t.castformP = {name = 'Castform', ndex = 351, type1 = 'acqua', type2 = 'acqua'}
t['351P'] = t.castformP
t.castformN = {name = 'Castform', ndex = 351, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t['351N'] = t.castformN
t.wormadamSa = {name = 'Wormadam', ndex = 413, type1 = 'coleot', type2 = 'terra'}
t['413Sa'] = t.wormadamSa
t.wormadamSc = {name = 'Wormadam', ndex = 413, type1 = 'coleot', type2 = 'acciaio'}
t['413Sc'] = t.wormadamSc
t.rotomC = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'fuoco'}
t['479C'] = t.rotomC
t.rotomL = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'acqua'}
t['479L'] = t.rotomL
t.rotomG = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'ghiaccio'}
t['479G'] = t.rotomG
t.rotomV = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'volante'}
t['479V'] = t.rotomV
t.rotomT = {name = 'Rotom', ndex = 479, type1 = 'elettro', type2 = 'erba'}
t['479T'] = t.rotomT
t.shayminC = {name = 'Shaymin', ndex = 492, type1 = 'erba', type2 = 'volante'}
t['492C'] = t.shayminC
t.darmanitanZ = {name = 'Darmanitan', ndex = 555, type1 = 'fuoco', type2 = 'psico'}
t['555Z'] = t.darmanitanZ
t.meloettaD = {name = 'Meloetta', ndex = 648, type1 = 'normale', type2 = 'lotta'}
t['648D'] = t.meloettaD
t.hoopaL = {name = 'Hoopa', ndex = 720, type1 = 'psico', type2 = 'buio'}
t['720L'] = t.hoopaL

-- Gli alias per le altre forme alternative rilevanti

t.deoxysA, t['386A'], t.deoxysD, t['386D'], t.deoxysV, t['386V'] =
	t.deoxys, t.deoxys, t.deoxys, t.deoxys, t.deoxys, t.deoxys
t.giratinaO, t['487O'] = t.giratina, t.giratina
t.basculinB, t['550B'] = t.basculin, t.basculin
t.tornadusT, t['641T'] = t.tornadus, t.tornadus
t.thundurusT, t['642T'] = t.thundurus, t.thundurus
t.landorusT, t['645T'] = t.landorus, t.landorus
t.kyuremN, t['646N'], t.kyuremB, t['646B'] =
	t.kyurem, t.kyurem, t.kyurem, t.kyurem
t.meowsticF, t['678F'], t.meowsticM, t['678M'] =
	t.meowstic, t.meowstic, t.meowstic, t.meowstic
t.aegislashS, t['681S'] = t.aegislash, t.aegislash
t.pumpkabooS, t['710S'], t.pumpkabooL, t['710L'], t.pumpkabooXL, t['710XL'] =
	t.pumpkaboo, t.pumpkaboo, t.pumpkaboo, t.pumpkaboo, t.pumpkaboo, t.pumpkaboo
t.gourgeistS, t['711S'], t.gourgeistL, t['711L'], t.gourgeistXL, t['711XL'] =
	t.gourgeist, t.gourgeist, t.gourgeist, t.gourgeist, t.gourgeist, t.gourgeist

-- I dati sulle megaevoluzioni; sono raggiungibili soltanto tramite il nome, dato che non hanno un ndex proprio
-- Il nome è composto dal nome del Pokémon seguito da 'M'

t.venusaurM = {name = 'MegaVenusaur', ndex = 3, type1 = 'erba', type2 = 'veleno'}
t['003M'] = t.venusaurM
t.charizardMX = {name = 'MegaCharizard X', ndex = 6, type1 = 'fuoco', type2 = 'drago'}
t['006MX'] = t.charizardMX
t.charizardMY = {name = 'MegaCharizard Y', ndex = 6, type1 = 'fuoco', type2 = 'volante'}
t['006MY'] = t.charizardMY
t.blastoiseM = {name = 'MegaBlastoise', ndex = 9, type1 = 'acqua', type2 = 'acqua'}
t['009M'] = t.blastoiseM
t.beedrillM = {name = 'MegaBeedrill', ndex = 15, type1 = 'coleot', type2 = 'veleno'}
t['015M'] = t.beedrillM
t.pidgeotM = {name = 'MegaPidgeot', ndex = 18, type1 = 'normale', type2 = 'volante'}
t['018M'] = t.pidgeotM
t.alakazamM = {name = 'MegaAlakazam', ndex = 65, type1 = 'psico', type2 = 'psico'}
t['065M'] = t.alakazamM
t.slowbroM = {name = 'MegaSlowbro', ndex = 80, type1 = 'acqua', type2 = 'psico'}
t['080M'] = t.slowbroM
t.gengarM = {name = 'MegaGengar', ndex = 94, type1 = 'spettro', type2 = 'veleno'}
t['094M'] = t.gengarM
t.kangaskhanM = {name = 'MegaKangaskhan', ndex = 115, type1 = 'normale', type2 = 'normale'}
t['115M'] = t.kangaskhanM
t.pinsirM = {name = 'MegaPinsir', ndex = 127, type1 = 'coleot', type2 = 'volante'}
t['127M'] = t.pinsirM
t.gyaradosM = {name = 'MegaGyarados', ndex = 130, type1 = 'acqua', type2 = 'buio'}
t['130M'] = t.gyaradosM
t.aerodactylM = {name = 'MegaAerodactyl', ndex = 142, type1 = 'roccia', type2 = 'volante'}
t['142M'] = t.aerodactylM
t.mewtwoMX = {name = 'MegaMewtwo X', ndex = 150, type1 = 'psico', type2 = 'lotta'}
t['150MX'] = t.mewtwoMX
t.mewtwoMY = {name = 'MegaMewtwo Y', ndex = 150, type1 = 'psico', type2 = 'psico'}
t['150MY'] = t.mewtwoMY
t.ampharosM = {name = 'MegaAmpharos', ndex = 181, type1 = 'elettro', type2 = 'drago'}
t['181M'] = t.ampharosM
t.steelixM = {name = 'MegaSteelix', ndex = 208, type1 = 'acciaio', type2 = 'terra'}
t['208M'] = t.steelixM
t.scizorM = {name = 'MegaScizor', ndex = 212, type1 = 'coleot', type2 = 'acciaio'}
t['212M'] = t.scizorM
t.heracrossM = {name = 'MegaHeracross', ndex = 214, type1 = 'coleot', type2 = 'lotta'}
t['214M'] = t.heracrossM
t.houndoomM = {name = 'MegaHoundoom', ndex = 229, type1 = 'buio', type2 = 'fuoco'}
t['229M'] = t.houndoomM
t.tyranitarM = {name = 'MegaTyranitar', ndex = 248, type1 = 'roccia', type2 = 'buio'}
t['248M'] = t.tyranitarM
t.sceptileM = {name = 'MegaSceptile', ndex = 254, type1 = 'erba', type2 = 'drago'}
t['254M'] = t.sceptileM
t.blazikenM = {name = 'MegaBlaziken', ndex = 257, type1 = 'fuoco', type2 = 'lotta'}
t['257M'] = t.blazikenM
t.swampertM = {name = 'MegaSwampert', ndex = 260, type1 = 'acqua', type2 = 'terra'}
t['260M'] = t.swampertM
t.gardevoirM = {name = 'MegaGardevoir', ndex = 282, type1 = 'psico', type2 = 'folletto'}
t['282M'] = t.gardevoirM
t.sableyeM = {name = 'MegaSableye', ndex = 302, type1 = 'buio', type2 = 'spettro'}
t['302M'] = t.sableyeM
t.mawileM = {name = 'MegaMawile', ndex = 303, type1 = 'acciaio', type2 = 'folletto'}
t['303M'] = t.mawileM
t.aggronM = {name = 'MegaAggron', ndex = 306, type1 = 'acciaio', type2 = 'acciaio'}
t['306M'] = t.aggronM
t.medichamM = {name = 'MegaMedicham', ndex = 308, type1 = 'lotta', type2 = 'psico'}
t['308M'] = t.medichamM
t.manectricM = {name = 'MegaManectric', ndex = 310, type1 = 'elettro', type2 = 'elettro'}
t['310M'] = t.manectricM
t.sharpedoM = {name = 'MegaSharpedo', ndex = 319, type1 = 'acqua', type2 = 'buio'}
t['319M'] = t.sharpedoM
t.cameruptM = {name = 'MegaCamerupt', ndex = 323, type1 = 'fuoco', type2 = 'terra'}
t['323M'] = t.cameruptM
t.altariaM = {name = 'MegaAltaria', ndex = 334, type1 = 'drago', type2 = 'folletto'}
t['334M'] = t.altariaM
t.banetteM = {name = 'MegaBanette', ndex = 354, type1 = 'spettro', type2 = 'spettro'}
t['354M'] = t.banetteM
t.absolM = {name = 'MegaAbsol', ndex = 359, type1 = 'buio', type2 = 'buio'}
t['359M'] = t.absolM
t.glalieM = {name = 'MegaGlalie', ndex = 362, type1 = 'ghiaccio', type2 = 'ghiaccio'}
t['362M'] = t.glalieM
t.salamenceM = {name = 'MegaSalamence', ndex = 373, type1 = 'drago', type2 = 'volante'}
t['373M'] = t.salamenceM
t.metagrossM = {name = 'MegaMetagross', ndex = 376, type1 = 'acciaio', type2 = 'psico'}
t['376M'] = t.metagrossM
t.latiasM = {name = 'MegaLatias', ndex = 380, type1 = 'drago', type2 = 'psico'}
t['380M'] = t.latiasM
t.latiosM = {name = 'MegaLatios', ndex = 381, type1 = 'drago', type2 = 'psico'}
t['381M'] = t.latiosM
t.rayquazaM = {name = 'MegaRayquaza', ndex = 384, type1 = 'drago', type2 = 'volante'}
t['384M'] = t.rayquazaM
t.kyogreA = {name = 'ArcheoKyogre', ndex = 382, type1 = 'acqua', type2 = 'acqua'}
t['382A'] = t.kyogreA
t.groudonA = {name = 'ArcheoGroudon', ndex = 383, type1 = 'terra', type2 = 'fuoco'}
t['383A'] = t.groudonA
t.lopunnyM = {name = 'MegaLopunny', ndex = 428, type1 = 'normale', type2 = 'lotta'}
t['428M'] = t.lopunnyM
t.garchompM = {name = 'MegaGarchomp', ndex = 445, type1 = 'drago', type2 = 'terra'}
t['445M'] = t.garchompM
t.lucarioM = {name = 'MegaLucario', ndex = 448, type1 = 'lotta', type2 = 'acciaio'}
t['448M'] = t.lucarioM
t.abomasnowM = {name = 'MegaAbomasnow', ndex = 460, type1 = 'erba', type2 = 'ghiaccio'}
t['460M'] = t.abomasnowM
t.galladeM = {name = 'MegaGallade', ndex = 475, type1 = 'psico', type2 = 'lotta'}
t['475M'] = t.galladeM
t.audinoM = {name = 'MegaAudino', ndex = 531, type1 = 'normale', type2 = 'folletto'}
t['531M'] = t.audinoM
t.diancieM = {name = 'MegaDiancie', ndex = 719, type1 = 'roccia', type2 = 'folletto'}
t['719M'] = t.diancieM

return t
