-- Modulo di tabelle sui gruppi uova dei Pokémon. In caso un Pokémon non
-- abbia il secondo gruppo uova, tale indice non esiste. Tutti gli indici sono in minuscolo

local t = {}

t.bulbasaur = {group1 = 'mostro', group2 = 'erba'}
t[1] = t.bulbasaur
t.ivysaur = {group1 = 'mostro', group2 = 'erba'}
t[2] = t.ivysaur
t.venusaur = {group1 = 'mostro', group2 = 'erba'}
t[3] = t.venusaur
t.charmander = {group1 = 'mostro', group2 = 'drago'}
t[4] = t.charmander
t.charmeleon = {group1 = 'mostro', group2 = 'drago'}
t[5] = t.charmeleon
t.charizard = {group1 = 'mostro', group2 = 'drago'}
t[6] = t.charizard
t.squirtle = {group1 = 'mostro', group2 = 'acqua 1'}
t[7] = t.squirtle
t.wartortle = {group1 = 'mostro', group2 = 'acqua 1'}
t[8] = t.wartortle
t.blastoise = {group1 = 'mostro', group2 = 'acqua 1'}
t[9] = t.blastoise
t.caterpie = {group1 = 'coleottero'}
t[10] = t.caterpie
t.metapod = {group1 = 'coleottero'}
t[11] = t.metapod
t.butterfree = {group1 = 'coleottero'}
t[12] = t.butterfree
t.weedle = {group1 = 'coleottero'}
t[13] = t.weedle
t.kakuna = {group1 = 'coleottero'}
t[14] = t.kakuna
t.beedrill = {group1 = 'coleottero'}
t[15] = t.beedrill
t.pidgey = {group1 = 'volante'}
t[16] = t.pidgey
t.pidgeotto = {group1 = 'volante'}
t[17] = t.pidgeotto
t.pidgeot = {group1 = 'volante'}
t[18] = t.pidgeot
t.rattata = {group1 = 'campo'}
t[19] = t.rattata
t.raticate = {group1 = 'campo'}
t[20] = t.raticate
t.spearow = {group1 = 'volante'}
t[21] = t.spearow
t.fearow = {group1 = 'volante'}
t[22] = t.fearow
t.ekans = {group1 = 'campo', group2 = 'drago'}
t[23] = t.ekans
t.arbok = {group1 = 'campo', group2 = 'drago'}
t[24] = t.arbok
t.pikachu = {group1 = 'campo', group2 = 'magico'}
t[25] = t.pikachu
t.raichu = {group1 = 'campo', group2 = 'magico'}
t[26] = t.raichu
t.sandshrew = {group1 = 'campo'}
t[27] = t.sandshrew
t.sandslash = {group1 = 'campo'}
t[28] = t.sandslash
t["nidoran♀"] = {group1 = 'mostro', group2 = 'campo'}
t[29] = t["nidoran♀"]
t.nidorina = {group1 = 'sconosciuto'}
t[30] = t.nidorina
t.nidoqueen = {group1 = 'sconosciuto'}
t[31] = t.nidoqueen
t["nidoran♂"] = {group1 = 'mostro', group2 = 'campo'}
t[32] = t["nidoran♂"]
t.nidorino = {group1 = 'mostro', group2 = 'campo'}
t[33] = t.nidorino
t.nidoking = {group1 = 'mostro', group2 = 'campo'}
t[34] = t.nidoking
t.clefairy = {group1 = 'magico'}
t[35] = t.clefairy
t.clefable = {group1 = 'magico'}
t[36] = t.clefable
t.vulpix = {group1 = 'campo'}
t[37] = t.vulpix
t.ninetales = {group1 = 'campo'}
t[38] = t.ninetales
t.jigglypuff = {group1 = 'magico'}
t[39] = t.jigglypuff
t.wigglytuff = {group1 = 'magico'}
t[40] = t.wigglytuff
t.zubat = {group1 = 'volante'}
t[41] = t.zubat
t.golbat = {group1 = 'volante'}
t[42] = t.golbat
t.oddish = {group1 = 'erba'}
t[43] = t.oddish
t.gloom = {group1 = 'erba'}
t[44] = t.gloom
t.vileplume = {group1 = 'erba'}
t[45] = t.vileplume
t.paras = {group1 = 'coleottero', group2 = 'erba'}
t[46] = t.paras
t.parasect = {group1 = 'coleottero', group2 = 'erba'}
t[47] = t.parasect
t.venonat = {group1 = 'coleottero'}
t[48] = t.venonat
t.venomoth = {group1 = 'coleottero'}
t[49] = t.venomoth
t.diglett = {group1 = 'campo'}
t[50] = t.diglett
t.dugtrio = {group1 = 'campo'}
t[51] = t.dugtrio
t.meowth = {group1 = 'campo'}
t[52] = t.meowth
t.persian = {group1 = 'campo'}
t[53] = t.persian
t.psyduck = {group1 = 'acqua 1', group2 = 'campo'}
t[54] = t.psyduck
t.golduck = {group1 = 'acqua 1', group2 = 'campo'}
t[55] = t.golduck
t.mankey = {group1 = 'campo'}
t[56] = t.mankey
t.primeape = {group1 = 'campo'}
t[57] = t.primeape
t.growlithe = {group1 = 'campo'}
t[58] = t.growlithe
t.arcanine = {group1 = 'campo'}
t[59] = t.arcanine
t.poliwag = {group1 = 'acqua 1'}
t[60] = t.poliwag
t.poliwhirl = {group1 = 'acqua 1'}
t[61] = t.poliwhirl
t.poliwrath = {group1 = 'acqua 1'}
t[62] = t.poliwrath
t.abra = {group1 = 'umanoide'}
t[63] = t.abra
t.kadabra = {group1 = 'umanoide'}
t[64] = t.kadabra
t.alakazam = {group1 = 'umanoide'}
t[65] = t.alakazam
t.machop = {group1 = 'umanoide'}
t[66] = t.machop
t.machoke = {group1 = 'umanoide'}
t[67] = t.machoke
t.machamp = {group1 = 'umanoide'}
t[68] = t.machamp
t.bellsprout = {group1 = 'erba'}
t[69] = t.bellsprout
t.weepinbell = {group1 = 'erba'}
t[70] = t.weepinbell
t.victreebel = {group1 = 'erba'}
t[71] = t.victreebel
t.tentacool = {group1 = 'acqua 3'}
t[72] = t.tentacool
t.tentacruel = {group1 = 'acqua 3'}
t[73] = t.tentacruel
t.geodude = {group1 = 'minerale'}
t[74] = t.geodude
t.graveler = {group1 = 'minerale'}
t[75] = t.graveler
t.golem = {group1 = 'minerale'}
t[76] = t.golem
t.ponyta = {group1 = 'campo'}
t[77] = t.ponyta
t.rapidash = {group1 = 'campo'}
t[78] = t.rapidash
t.slowpoke = {group1 = 'mostro', group2 = 'acqua 1'}
t[79] = t.slowpoke
t.slowbro = {group1 = 'mostro', group2 = 'acqua 1'}
t[80] = t.slowbro
t.magnemite = {group1 = 'minerale'}
t[81] = t.magnemite
t.magneton = {group1 = 'minerale'}
t[82] = t.magneton
t["farfetch'd"] = {group1 = 'volante', group2 = 'campo'}
t[83] = t["farfetch'd"]
t.doduo = {group1 = 'volante'}
t[84] = t.doduo
t.dodrio = {group1 = 'volante'}
t[85] = t.dodrio
t.seel = {group1 = 'acqua 1', group2 = 'campo'}
t[86] = t.seel
t.dewgong = {group1 = 'acqua 1', group2 = 'campo'}
t[87] = t.dewgong
t.grimer = {group1 = 'amorfo'}
t[88] = t.grimer
t.muk = {group1 = 'amorfo'}
t[89] = t.muk
t.shellder = {group1 = 'acqua 3'}
t[90] = t.shellder
t.cloyster = {group1 = 'acqua 3'}
t[91] = t.cloyster
t.gastly = {group1 = 'amorfo'}
t[92] = t.gastly
t.haunter = {group1 = 'amorfo'}
t[93] = t.haunter
t.gengar = {group1 = 'amorfo'}
t[94] = t.gengar
t.onix = {group1 = 'minerale'}
t[95] = t.onix
t.drowzee = {group1 = 'umanoide'}
t[96] = t.drowzee
t.hypno = {group1 = 'umanoide'}
t[97] = t.hypno
t.krabby = {group1 = 'acqua 3'}
t[98] = t.krabby
t.kingler = {group1 = 'acqua 3'}
t[99] = t.kingler
t.voltorb = {group1 = 'minerale'}
t[100] = t.voltorb
t.electrode = {group1 = 'minerale'}
t[101] = t.electrode
t.exeggcute = {group1 = 'erba'}
t[102] = t.exeggcute
t.exeggutor = {group1 = 'erba'}
t[103] = t.exeggutor
t.cubone = {group1 = 'mostro'}
t[104] = t.cubone
t.marowak = {group1 = 'mostro'}
t[105] = t.marowak
t.hitmonlee = {group1 = 'umanoide'}
t[106] = t.hitmonlee
t.hitmonchan = {group1 = 'umanoide'}
t[107] = t.hitmonchan
t.lickitung = {group1 = 'mostro'}
t[108] = t.lickitung
t.koffing = {group1 = 'amorfo'}
t[109] = t.koffing
t.weezing = {group1 = 'amorfo'}
t[110] = t.weezing
t.rhyhorn = {group1 = 'mostro', group2 = 'campo'}
t[111] = t.rhyhorn
t.rhydon = {group1 = 'mostro', group2 = 'campo'}
t[112] = t.rhydon
t.chansey = {group1 = 'magico'}
t[113] = t.chansey
t.tangela = {group1 = 'erba'}
t[114] = t.tangela
t.kangaskhan = {group1 = 'mostro'}
t[115] = t.kangaskhan
t.horsea = {group1 = 'acqua 1', group2 = 'drago'}
t[116] = t.horsea
t.seadra = {group1 = 'acqua 1', group2 = 'drago'}
t[117] = t.seadra
t.goldeen = {group1 = 'acqua 2'}
t[118] = t.goldeen
t.seaking = {group1 = 'acqua 2'}
t[119] = t.seaking
t.staryu = {group1 = 'acqua 3'}
t[120] = t.staryu
t.starmie = {group1 = 'acqua 3'}
t[121] = t.starmie
t["mr. mime"] = {group1 = 'umanoide'}
t[122] = t["mr. mime"]
t.scyther = {group1 = 'coleottero'}
t[123] = t.scyther
t.jynx = {group1 = 'umanoide'}
t[124] = t.jynx
t.electabuzz = {group1 = 'umanoide'}
t[125] = t.electabuzz
t.magmar = {group1 = 'umanoide'}
t[126] = t.magmar
t.pinsir = {group1 = 'coleottero'}
t[127] = t.pinsir
t.tauros = {group1 = 'campo'}
t[128] = t.tauros
t.magikarp = {group1 = 'acqua 2', group2 = 'drago'}
t[129] = t.magikarp
t.gyarados = {group1 = 'acqua 2', group2 = 'drago'}
t[130] = t.gyarados
t.lapras = {group1 = 'mostro', group2 = 'acqua 1'}
t[131] = t.lapras
t.ditto = {group1 = 'ditto'}
t[132] = t.ditto
t.eevee = {group1 = 'campo'}
t[133] = t.eevee
t.vaporeon = {group1 = 'campo'}
t[134] = t.vaporeon
t.jolteon = {group1 = 'campo'}
t[135] = t.jolteon
t.flareon = {group1 = 'campo'}
t[136] = t.flareon
t.porygon = {group1 = 'minerale'}
t[137] = t.porygon
t.omanyte = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[138] = t.omanyte
t.omastar = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[139] = t.omastar
t.kabuto = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[140] = t.kabuto
t.kabutops = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[141] = t.kabutops
t.aerodactyl = {group1 = 'volante'}
t[142] = t.aerodactyl
t.snorlax = {group1 = 'mostro'}
t[143] = t.snorlax
t.articuno = {group1 = 'sconosciuto'}
t[144] = t.articuno
t.zapdos = {group1 = 'sconosciuto'}
t[145] = t.zapdos
t.moltres = {group1 = 'sconosciuto'}
t[146] = t.moltres
t.dratini = {group1 = 'acqua 1', group2 = 'drago'}
t[147] = t.dratini
t.dragonair = {group1 = 'acqua 1', group2 = 'drago'}
t[148] = t.dragonair
t.dragonite = {group1 = 'acqua 1', group2 = 'drago'}
t[149] = t.dragonite
t.mewtwo = {group1 = 'sconosciuto'}
t[150] = t.mewtwo
t.mew = {group1 = 'sconosciuto'}
t[151] = t.mew
t.chikorita = {group1 = 'mostro', group2 = 'erba'}
t[152] = t.chikorita
t.bayleef = {group1 = 'mostro', group2 = 'erba'}
t[153] = t.bayleef
t.meganium = {group1 = 'mostro', group2 = 'erba'}
t[154] = t.meganium
t.cyndaquil = {group1 = 'campo'}
t[155] = t.cyndaquil
t.quilava = {group1 = 'campo'}
t[156] = t.quilava
t.typhlosion = {group1 = 'campo'}
t[157] = t.typhlosion
t.totodile = {group1 = 'mostro', group2 = 'acqua 1'}
t[158] = t.totodile
t.croconaw = {group1 = 'mostro', group2 = 'acqua 1'}
t[159] = t.croconaw
t.feraligatr = {group1 = 'mostro', group2 = 'acqua 1'}
t[160] = t.feraligatr
t.sentret = {group1 = 'campo'}
t[161] = t.sentret
t.furret = {group1 = 'campo'}
t[162] = t.furret
t.hoothoot = {group1 = 'volante'}
t[163] = t.hoothoot
t.noctowl = {group1 = 'volante'}
t[164] = t.noctowl
t.ledyba = {group1 = 'coleottero'}
t[165] = t.ledyba
t.ledian = {group1 = 'coleottero'}
t[166] = t.ledian
t.spinarak = {group1 = 'coleottero'}
t[167] = t.spinarak
t.ariados = {group1 = 'coleottero'}
t[168] = t.ariados
t.crobat = {group1 = 'volante'}
t[169] = t.crobat
t.chinchou = {group1 = 'acqua 2'}
t[170] = t.chinchou
t.lanturn = {group1 = 'acqua 2'}
t[171] = t.lanturn
t.pichu = {group1 = 'sconosciuto'}
t[172] = t.pichu
t.cleffa = {group1 = 'sconosciuto'}
t[173] = t.cleffa
t.igglybuff = {group1 = 'sconosciuto'}
t[174] = t.igglybuff
t.togepi = {group1 = 'sconosciuto'}
t[175] = t.togepi
t.togetic = {group1 = 'volante', group2 = 'magico'}
t[176] = t.togetic
t.natu = {group1 = 'volante'}
t[177] = t.natu
t.xatu = {group1 = 'volante'}
t[178] = t.xatu
t.mareep = {group1 = 'mostro', group2 = 'campo'}
t[179] = t.mareep
t.flaaffy = {group1 = 'mostro', group2 = 'campo'}
t[180] = t.flaaffy
t.ampharos = {group1 = 'mostro', group2 = 'campo'}
t[181] = t.ampharos
t.bellossom = {group1 = 'erba'}
t[182] = t.bellossom
t.marill = {group1 = 'acqua 1', group2 = 'magico'}
t[183] = t.marill
t.azumarill = {group1 = 'acqua 1', group2 = 'magico'}
t[184] = t.azumarill
t.sudowoodo = {group1 = 'minerale'}
t[185] = t.sudowoodo
t.politoed = {group1 = 'acqua 1'}
t[186] = t.politoed
t.hoppip = {group1 = 'magico', group2 = 'erba'}
t[187] = t.hoppip
t.skiploom = {group1 = 'magico', group2 = 'erba'}
t[188] = t.skiploom
t.jumpluff = {group1 = 'magico', group2 = 'erba'}
t[189] = t.jumpluff
t.aipom = {group1 = 'campo'}
t[190] = t.aipom
t.sunkern = {group1 = 'erba'}
t[191] = t.sunkern
t.sunflora = {group1 = 'erba'}
t[192] = t.sunflora
t.yanma = {group1 = 'coleottero'}
t[193] = t.yanma
t.wooper = {group1 = 'acqua 1', group2 = 'campo'}
t[194] = t.wooper
t.quagsire = {group1 = 'acqua 1', group2 = 'campo'}
t[195] = t.quagsire
t.espeon = {group1 = 'campo'}
t[196] = t.espeon
t.umbreon = {group1 = 'campo'}
t[197] = t.umbreon
t.murkrow = {group1 = 'volante'}
t[198] = t.murkrow
t.slowking = {group1 = 'mostro', group2 = 'acqua 1'}
t[199] = t.slowking
t.misdreavus = {group1 = 'amorfo'}
t[200] = t.misdreavus
t.unown = {group1 = 'sconosciuto'}
t[201] = t.unown
t.wobbuffet = {group1 = 'amorfo'}
t[202] = t.wobbuffet
t.girafarig = {group1 = 'campo'}
t[203] = t.girafarig
t.pineco = {group1 = 'coleottero'}
t[204] = t.pineco
t.forretress = {group1 = 'coleottero'}
t[205] = t.forretress
t.dunsparce = {group1 = 'campo'}
t[206] = t.dunsparce
t.gligar = {group1 = 'coleottero'}
t[207] = t.gligar
t.steelix = {group1 = 'minerale'}
t[208] = t.steelix
t.snubbull = {group1 = 'campo', group2 = 'magico'}
t[209] = t.snubbull
t.granbull = {group1 = 'campo', group2 = 'magico'}
t[210] = t.granbull
t.qwilfish = {group1 = 'acqua 2'}
t[211] = t.qwilfish
t.scizor = {group1 = 'coleottero'}
t[212] = t.scizor
t.shuckle = {group1 = 'coleottero'}
t[213] = t.shuckle
t.heracross = {group1 = 'coleottero'}
t[214] = t.heracross
t.sneasel = {group1 = 'campo'}
t[215] = t.sneasel
t.teddiursa = {group1 = 'campo'}
t[216] = t.teddiursa
t.ursaring = {group1 = 'campo'}
t[217] = t.ursaring
t.slugma = {group1 = 'amorfo'}
t[218] = t.slugma
t.magcargo = {group1 = 'amorfo'}
t[219] = t.magcargo
t.swinub = {group1 = 'campo'}
t[220] = t.swinub
t.piloswine = {group1 = 'campo'}
t[221] = t.piloswine
t.corsola = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[222] = t.corsola
t.remoraid = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[223] = t.remoraid
t.octillery = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[224] = t.octillery
t.delibird = {group1 = 'acqua 1', group2 = 'campo'}
t[225] = t.delibird
t.mantine = {group1 = 'acqua 1'}
t[226] = t.mantine
t.skarmory = {group1 = 'volante'}
t[227] = t.skarmory
t.houndour = {group1 = 'campo'}
t[228] = t.houndour
t.houndoom = {group1 = 'campo'}
t[229] = t.houndoom
t.kingdra = {group1 = 'acqua 1', group2 = 'drago'}
t[230] = t.kingdra
t.phanpy = {group1 = 'campo'}
t[231] = t.phanpy
t.donphan = {group1 = 'campo'}
t[232] = t.donphan
t["porygon2"] = {group1 = 'minerale'}
t[233] = t["porygon2"]
t.stantler = {group1 = 'campo'}
t[234] = t.stantler
t.smeargle = {group1 = 'campo'}
t[235] = t.smeargle
t.tyrogue = {group1 = 'sconosciuto'}
t[236] = t.tyrogue
t.hitmontop = {group1 = 'umanoide'}
t[237] = t.hitmontop
t.smoochum = {group1 = 'sconosciuto'}
t[238] = t.smoochum
t.elekid = {group1 = 'sconosciuto'}
t[239] = t.elekid
t.magby = {group1 = 'sconosciuto'}
t[240] = t.magby
t.miltank = {group1 = 'campo'}
t[241] = t.miltank
t.blissey = {group1 = 'magico'}
t[242] = t.blissey
t.raikou = {group1 = 'sconosciuto'}
t[243] = t.raikou
t.entei = {group1 = 'sconosciuto'}
t[244] = t.entei
t.suicune = {group1 = 'sconosciuto'}
t[245] = t.suicune
t.larvitar = {group1 = 'mostro'}
t[246] = t.larvitar
t.pupitar = {group1 = 'mostro'}
t[247] = t.pupitar
t.tyranitar = {group1 = 'mostro'}
t[248] = t.tyranitar
t.lugia = {group1 = 'sconosciuto'}
t[249] = t.lugia
t["ho-oh"] = {group1 = 'sconosciuto'}
t[250] = t["ho-oh"]
t.celebi = {group1 = 'sconosciuto'}
t[251] = t.celebi
t.treecko = {group1 = 'mostro', group2 = 'drago'}
t[252] = t.treecko
t.grovyle = {group1 = 'mostro', group2 = 'drago'}
t[253] = t.grovyle
t.sceptile = {group1 = 'mostro', group2 = 'drago'}
t[254] = t.sceptile
t.torchic = {group1 = 'campo'}
t[255] = t.torchic
t.combusken = {group1 = 'campo'}
t[256] = t.combusken
t.blaziken = {group1 = 'campo'}
t[257] = t.blaziken
t.mudkip = {group1 = 'mostro', group2 = 'acqua 1'}
t[258] = t.mudkip
t.marshtomp = {group1 = 'mostro', group2 = 'acqua 1'}
t[259] = t.marshtomp
t.swampert = {group1 = 'mostro', group2 = 'acqua 1'}
t[260] = t.swampert
t.poochyena = {group1 = 'campo'}
t[261] = t.poochyena
t.mightyena = {group1 = 'campo'}
t[262] = t.mightyena
t.zigzagoon = {group1 = 'campo'}
t[263] = t.zigzagoon
t.linoone = {group1 = 'campo'}
t[264] = t.linoone
t.wurmple = {group1 = 'coleottero'}
t[265] = t.wurmple
t.silcoon = {group1 = 'coleottero'}
t[266] = t.silcoon
t.beautifly = {group1 = 'coleottero'}
t[267] = t.beautifly
t.cascoon = {group1 = 'coleottero'}
t[268] = t.cascoon
t.dustox = {group1 = 'coleottero'}
t[269] = t.dustox
t.lotad = {group1 = 'acqua 1', group2 = 'erba'}
t[270] = t.lotad
t.lombre = {group1 = 'acqua 1', group2 = 'erba'}
t[271] = t.lombre
t.ludicolo = {group1 = 'acqua 1', group2 = 'erba'}
t[272] = t.ludicolo
t.seedot = {group1 = 'campo', group2 = 'erba'}
t[273] = t.seedot
t.nuzleaf = {group1 = 'campo', group2 = 'erba'}
t[274] = t.nuzleaf
t.shiftry = {group1 = 'campo', group2 = 'erba'}
t[275] = t.shiftry
t.taillow = {group1 = 'volante'}
t[276] = t.taillow
t.swellow = {group1 = 'volante'}
t[277] = t.swellow
t.wingull = {group1 = 'acqua 1', group2 = 'volante'}
t[278] = t.wingull
t.pelipper = {group1 = 'acqua 1', group2 = 'volante'}
t[279] = t.pelipper
t.ralts = {group1 = 'amorfo'}
t[280] = t.ralts
t.kirlia = {group1 = 'amorfo'}
t[281] = t.kirlia
t.gardevoir = {group1 = 'amorfo'}
t[282] = t.gardevoir
t.surskit = {group1 = 'acqua 1', group2 = 'coleottero'}
t[283] = t.surskit
t.masquerain = {group1 = 'acqua 1', group2 = 'coleottero'}
t[284] = t.masquerain
t.shroomish = {group1 = 'magico', group2 = 'erba'}
t[285] = t.shroomish
t.breloom = {group1 = 'magico', group2 = 'erba'}
t[286] = t.breloom
t.slakoth = {group1 = 'campo'}
t[287] = t.slakoth
t.vigoroth = {group1 = 'campo'}
t[288] = t.vigoroth
t.slaking = {group1 = 'campo'}
t[289] = t.slaking
t.nincada = {group1 = 'coleottero'}
t[290] = t.nincada
t.ninjask = {group1 = 'coleottero'}
t[291] = t.ninjask
t.shedinja = {group1 = 'minerale'}
t[292] = t.shedinja
t.whismur = {group1 = 'mostro', group2 = 'campo'}
t[293] = t.whismur
t.loudred = {group1 = 'mostro', group2 = 'campo'}
t[294] = t.loudred
t.exploud = {group1 = 'mostro', group2 = 'campo'}
t[295] = t.exploud
t.makuhita = {group1 = 'umanoide'}
t[296] = t.makuhita
t.hariyama = {group1 = 'umanoide'}
t[297] = t.hariyama
t.azurill = {group1 = 'sconosciuto'}
t[298] = t.azurill
t.nosepass = {group1 = 'minerale'}
t[299] = t.nosepass
t.skitty = {group1 = 'campo', group2 = 'magico'}
t[300] = t.skitty
t.delcatty = {group1 = 'campo', group2 = 'magico'}
t[301] = t.delcatty
t.sableye = {group1 = 'umanoide'}
t[302] = t.sableye
t.mawile = {group1 = 'campo', group2 = 'magico'}
t[303] = t.mawile
t.aron = {group1 = 'mostro'}
t[304] = t.aron
t.lairon = {group1 = 'mostro'}
t[305] = t.lairon
t.aggron = {group1 = 'mostro'}
t[306] = t.aggron
t.meditite = {group1 = 'umanoide'}
t[307] = t.meditite
t.medicham = {group1 = 'umanoide'}
t[308] = t.medicham
t.electrike = {group1 = 'campo'}
t[309] = t.electrike
t.manectric = {group1 = 'campo'}
t[310] = t.manectric
t.plusle = {group1 = 'magico'}
t[311] = t.plusle
t.minun = {group1 = 'magico'}
t[312] = t.minun
t.volbeat = {group1 = 'coleottero', group2 = 'umanoide'}
t[313] = t.volbeat
t.illumise = {group1 = 'coleottero', group2 = 'umanoide'}
t[314] = t.illumise
t.roselia = {group1 = 'magico', group2 = 'erba'}
t[315] = t.roselia
t.gulpin = {group1 = 'amorfo'}
t[316] = t.gulpin
t.swalot = {group1 = 'amorfo'}
t[317] = t.swalot
t.carvanha = {group1 = 'acqua 2'}
t[318] = t.carvanha
t.sharpedo = {group1 = 'acqua 2'}
t[319] = t.sharpedo
t.wailmer = {group1 = 'campo', group2 = 'acqua 2'}
t[320] = t.wailmer
t.wailord = {group1 = 'campo', group2 = 'acqua 2'}
t[321] = t.wailord
t.numel = {group1 = 'campo'}
t[322] = t.numel
t.camerupt = {group1 = 'campo'}
t[323] = t.camerupt
t.torkoal = {group1 = 'campo'}
t[324] = t.torkoal
t.spoink = {group1 = 'campo'}
t[325] = t.spoink
t.grumpig = {group1 = 'campo'}
t[326] = t.grumpig
t.spinda = {group1 = 'campo', group2 = 'umanoide'}
t[327] = t.spinda
t.trapinch = {group1 = 'coleottero'}
t[328] = t.trapinch
t.vibrava = {group1 = 'coleottero'}
t[329] = t.vibrava
t.flygon = {group1 = 'coleottero'}
t[330] = t.flygon
t.cacnea = {group1 = 'erba', group2 = 'umanoide'}
t[331] = t.cacnea
t.cacturne = {group1 = 'erba', group2 = 'umanoide'}
t[332] = t.cacturne
t.swablu = {group1 = 'volante', group2 = 'drago'}
t[333] = t.swablu
t.altaria = {group1 = 'volante', group2 = 'drago'}
t[334] = t.altaria
t.zangoose = {group1 = 'campo'}
t[335] = t.zangoose
t.seviper = {group1 = 'campo', group2 = 'drago'}
t[336] = t.seviper
t.lunatone = {group1 = 'minerale'}
t[337] = t.lunatone
t.solrock = {group1 = 'minerale'}
t[338] = t.solrock
t.barboach = {group1 = 'acqua 2'}
t[339] = t.barboach
t.whiscash = {group1 = 'acqua 2'}
t[340] = t.whiscash
t.corphish = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[341] = t.corphish
t.crawdaunt = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[342] = t.crawdaunt
t.baltoy = {group1 = 'minerale'}
t[343] = t.baltoy
t.claydol = {group1 = 'minerale'}
t[344] = t.claydol
t.lileep = {group1 = 'acqua 3'}
t[345] = t.lileep
t.cradily = {group1 = 'acqua 3'}
t[346] = t.cradily
t.anorith = {group1 = 'acqua 3'}
t[347] = t.anorith
t.armaldo = {group1 = 'acqua 3'}
t[348] = t.armaldo
t.feebas = {group1 = 'acqua 1', group2 = 'drago'}
t[349] = t.feebas
t.milotic = {group1 = 'acqua 1', group2 = 'drago'}
t[350] = t.milotic
t.castform = {group1 = 'magico', group2 = 'amorfo'}
t[351] = t.castform
t.kecleon = {group1 = 'campo'}
t[352] = t.kecleon
t.shuppet = {group1 = 'amorfo'}
t[353] = t.shuppet
t.banette = {group1 = 'amorfo'}
t[354] = t.banette
t.duskull = {group1 = 'amorfo'}
t[355] = t.duskull
t.dusclops = {group1 = 'amorfo'}
t[356] = t.dusclops
t.tropius = {group1 = 'mostro', group2 = 'erba'}
t[357] = t.tropius
t.chimecho = {group1 = 'amorfo'}
t[358] = t.chimecho
t.absol = {group1 = 'campo'}
t[359] = t.absol
t.wynaut = {group1 = 'sconosciuto'}
t[360] = t.wynaut
t.snorunt = {group1 = 'magico', group2 = 'minerale'}
t[361] = t.snorunt
t.glalie = {group1 = 'magico', group2 = 'minerale'}
t[362] = t.glalie
t.spheal = {group1 = 'acqua 1', group2 = 'campo'}
t[363] = t.spheal
t.sealeo = {group1 = 'acqua 1', group2 = 'campo'}
t[364] = t.sealeo
t.walrein = {group1 = 'acqua 1', group2 = 'campo'}
t[365] = t.walrein
t.clamperl = {group1 = 'acqua 1'}
t[366] = t.clamperl
t.huntail = {group1 = 'acqua 1'}
t[367] = t.huntail
t.gorebyss = {group1 = 'acqua 1'}
t[368] = t.gorebyss
t.relicanth = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[369] = t.relicanth
t.luvdisc = {group1 = 'acqua 2'}
t[370] = t.luvdisc
t.bagon = {group1 = 'drago'}
t[371] = t.bagon
t.shelgon = {group1 = 'drago'}
t[372] = t.shelgon
t.salamence = {group1 = 'drago'}
t[373] = t.salamence
t.beldum = {group1 = 'minerale'}
t[374] = t.beldum
t.metang = {group1 = 'minerale'}
t[375] = t.metang
t.metagross = {group1 = 'minerale'}
t[376] = t.metagross
t.regirock = {group1 = 'sconosciuto'}
t[377] = t.regirock
t.regice = {group1 = 'sconosciuto'}
t[378] = t.regice
t.registeel = {group1 = 'sconosciuto'}
t[379] = t.registeel
t.latias = {group1 = 'sconosciuto'}
t[380] = t.latias
t.latios = {group1 = 'sconosciuto'}
t[381] = t.latios
t.kyogre = {group1 = 'sconosciuto'}
t[382] = t.kyogre
t.groudon = {group1 = 'sconosciuto'}
t[383] = t.groudon
t.rayquaza = {group1 = 'sconosciuto'}
t[384] = t.rayquaza
t.jirachi = {group1 = 'sconosciuto'}
t[385] = t.jirachi
t.deoxys = {group1 = 'sconosciuto'}
t[386] = t.deoxys
t.turtwig = {group1 = 'mostro', group2 = 'erba'}
t[387] = t.turtwig
t.grotle = {group1 = 'mostro', group2 = 'erba'}
t[388] = t.grotle
t.torterra = {group1 = 'mostro', group2 = 'erba'}
t[389] = t.torterra
t.chimchar = {group1 = 'campo', group2 = 'umanoide'}
t[390] = t.chimchar
t.monferno = {group1 = 'campo', group2 = 'umanoide'}
t[391] = t.monferno
t.infernape = {group1 = 'campo', group2 = 'umanoide'}
t[392] = t.infernape
t.piplup = {group1 = 'acqua 1', group2 = 'campo'}
t[393] = t.piplup
t.prinplup = {group1 = 'acqua 1', group2 = 'campo'}
t[394] = t.prinplup
t.empoleon = {group1 = 'acqua 1', group2 = 'campo'}
t[395] = t.empoleon
t.starly = {group1 = 'volante'}
t[396] = t.starly
t.staravia = {group1 = 'volante'}
t[397] = t.staravia
t.staraptor = {group1 = 'volante'}
t[398] = t.staraptor
t.bidoof = {group1 = 'acqua 1', group2 = 'campo'}
t[399] = t.bidoof
t.bibarel = {group1 = 'acqua 1', group2 = 'campo'}
t[400] = t.bibarel
t.kricketot = {group1 = 'coleottero'}
t[401] = t.kricketot
t.kricketune = {group1 = 'coleottero'}
t[402] = t.kricketune
t.shinx = {group1 = 'campo'}
t[403] = t.shinx
t.luxio = {group1 = 'campo'}
t[404] = t.luxio
t.luxray = {group1 = 'campo'}
t[405] = t.luxray
t.budew = {group1 = 'sconosciuto'}
t[406] = t.budew
t.roserade = {group1 = 'magico', group2 = 'erba'}
t[407] = t.roserade
t.cranidos = {group1 = 'mostro'}
t[408] = t.cranidos
t.rampardos = {group1 = 'mostro'}
t[409] = t.rampardos
t.shieldon = {group1 = 'mostro'}
t[410] = t.shieldon
t.bastiodon = {group1 = 'mostro'}
t[411] = t.bastiodon
t.burmy = {group1 = 'coleottero'}
t[412] = t.burmy
t.wormadam = {group1 = 'coleottero'}
t[413] = t.wormadam
t.mothim = {group1 = 'coleottero'}
t[414] = t.mothim
t.combee = {group1 = 'coleottero'}
t[415] = t.combee
t.vespiquen = {group1 = 'coleottero'}
t[416] = t.vespiquen
t.pachirisu = {group1 = 'campo', group2 = 'magico'}
t[417] = t.pachirisu
t.buizel = {group1 = 'acqua 1', group2 = 'campo'}
t[418] = t.buizel
t.floatzel = {group1 = 'acqua 1', group2 = 'campo'}
t[419] = t.floatzel
t.cherubi = {group1 = 'magico', group2 = 'erba'}
t[420] = t.cherubi
t.cherrim = {group1 = 'magico', group2 = 'erba'}
t[421] = t.cherrim
t.shellos = {group1 = 'acqua 1', group2 = 'amorfo'}
t[422] = t.shellos
t.gastrodon = {group1 = 'acqua 1', group2 = 'amorfo'}
t[423] = t.gastrodon
t.ambipom = {group1 = 'campo'}
t[424] = t.ambipom
t.drifloon = {group1 = 'amorfo'}
t[425] = t.drifloon
t.drifblim = {group1 = 'amorfo'}
t[426] = t.drifblim
t.buneary = {group1 = 'campo', group2 = 'umanoide'}
t[427] = t.buneary
t.lopunny = {group1 = 'campo', group2 = 'umanoide'}
t[428] = t.lopunny
t.mismagius = {group1 = 'amorfo'}
t[429] = t.mismagius
t.honchkrow = {group1 = 'volante'}
t[430] = t.honchkrow
t.glameow = {group1 = 'campo'}
t[431] = t.glameow
t.purugly = {group1 = 'campo'}
t[432] = t.purugly
t.chingling = {group1 = 'sconosciuto'}
t[433] = t.chingling
t.stunky = {group1 = 'campo'}
t[434] = t.stunky
t.skuntank = {group1 = 'campo'}
t[435] = t.skuntank
t.bronzor = {group1 = 'minerale'}
t[436] = t.bronzor
t.bronzong = {group1 = 'minerale'}
t[437] = t.bronzong
t.bonsly = {group1 = 'sconosciuto'}
t[438] = t.bonsly
t["mime jr."] = {group1 = 'sconosciuto'}
t[439] = t["mime jr."]
t.happiny = {group1 = 'sconosciuto'}
t[440] = t.happiny
t.chatot = {group1 = 'volante'}
t[441] = t.chatot
t.spiritomb = {group1 = 'amorfo'}
t[442] = t.spiritomb
t.gible = {group1 = 'mostro', group2 = 'drago'}
t[443] = t.gible
t.gabite = {group1 = 'mostro', group2 = 'drago'}
t[444] = t.gabite
t.garchomp = {group1 = 'mostro', group2 = 'drago'}
t[445] = t.garchomp
t.munchlax = {group1 = 'sconosciuto'}
t[446] = t.munchlax
t.riolu = {group1 = 'sconosciuto'}
t[447] = t.riolu
t.lucario = {group1 = 'campo', group2 = 'umanoide'}
t[448] = t.lucario
t.hippopotas = {group1 = 'campo'}
t[449] = t.hippopotas
t.hippowdon = {group1 = 'campo'}
t[450] = t.hippowdon
t.skorupi = {group1 = 'coleottero', group2 = 'acqua 3'}
t[451] = t.skorupi
t.drapion = {group1 = 'coleottero', group2 = 'acqua 3'}
t[452] = t.drapion
t.croagunk = {group1 = 'umanoide'}
t[453] = t.croagunk
t.toxicroak = {group1 = 'umanoide'}
t[454] = t.toxicroak
t.carnivine = {group1 = 'erba'}
t[455] = t.carnivine
t.finneon = {group1 = 'acqua 2'}
t[456] = t.finneon
t.lumineon = {group1 = 'acqua 2'}
t[457] = t.lumineon
t.mantyke = {group1 = 'sconosciuto'}
t[458] = t.mantyke
t.snover = {group1 = 'mostro', group2 = 'erba'}
t[459] = t.snover
t.abomasnow = {group1 = 'mostro', group2 = 'erba'}
t[460] = t.abomasnow
t.weavile = {group1 = 'campo'}
t[461] = t.weavile
t.magnezone = {group1 = 'minerale'}
t[462] = t.magnezone
t.lickilicky = {group1 = 'mostro'}
t[463] = t.lickilicky
t.rhyperior = {group1 = 'mostro', group2 = 'campo'}
t[464] = t.rhyperior
t.tangrowth = {group1 = 'erba'}
t[465] = t.tangrowth
t.electivire = {group1 = 'umanoide'}
t[466] = t.electivire
t.magmortar = {group1 = 'umanoide'}
t[467] = t.magmortar
t.togekiss = {group1 = 'volante', group2 = 'magico'}
t[468] = t.togekiss
t.yanmega = {group1 = 'coleottero'}
t[469] = t.yanmega
t.leafeon = {group1 = 'campo'}
t[470] = t.leafeon
t.glaceon = {group1 = 'campo'}
t[471] = t.glaceon
t.gliscor = {group1 = 'coleottero'}
t[472] = t.gliscor
t.mamoswine = {group1 = 'campo'}
t[473] = t.mamoswine
t["porygon-z"] = {group1 = 'minerale'}
t[474] = t["porygon-z"]
t.gallade = {group1 = 'amorfo'}
t[475] = t.gallade
t.probopass = {group1 = 'minerale'}
t[476] = t.probopass
t.dusknoir = {group1 = 'amorfo'}
t[477] = t.dusknoir
t.froslass = {group1 = 'magico', group2 = 'minerale'}
t[478] = t.froslass
t.rotom = {group1 = 'amorfo'}
t[479] = t.rotom
t.uxie = {group1 = 'sconosciuto'}
t[480] = t.uxie
t.mesprit = {group1 = 'sconosciuto'}
t[481] = t.mesprit
t.azelf = {group1 = 'sconosciuto'}
t[482] = t.azelf
t.dialga = {group1 = 'sconosciuto'}
t[483] = t.dialga
t.palkia = {group1 = 'sconosciuto'}
t[484] = t.palkia
t.heatran = {group1 = 'sconosciuto'}
t[485] = t.heatran
t.regigigas = {group1 = 'sconosciuto'}
t[486] = t.regigigas
t.giratina = {group1 = 'sconosciuto'}
t[487] = t.giratina
t.cresselia = {group1 = 'sconosciuto'}
t[488] = t.cresselia
t.phione = {group1 = 'acqua 1', group2 = 'magico'}
t[489] = t.phione
t.manaphy = {group1 = 'acqua 1', group2 = 'magico'}
t[490] = t.manaphy
t.darkrai = {group1 = 'sconosciuto'}
t[491] = t.darkrai
t.shaymin = {group1 = 'sconosciuto'}
t[492] = t.shaymin
t.arceus = {group1 = 'sconosciuto'}
t[493] = t.arceus
t.victini = {group1 = 'sconosciuto'}
t[494] = t.victini
t.snivy = {group1 = 'campo', group2 = 'erba'}
t[495] = t.snivy
t.servine = {group1 = 'campo', group2 = 'erba'}
t[496] = t.servine
t.serperior = {group1 = 'campo', group2 = 'erba'}
t[497] = t.serperior
t.tepig = {group1 = 'campo'}
t[498] = t.tepig
t.pignite = {group1 = 'campo'}
t[499] = t.pignite
t.emboar = {group1 = 'campo'}
t[500] = t.emboar
t.oshawott = {group1 = 'campo'}
t[501] = t.oshawott
t.dewott = {group1 = 'campo'}
t[502] = t.dewott
t.samurott = {group1 = 'campo'}
t[503] = t.samurott
t.patrat = {group1 = 'campo'}
t[504] = t.patrat
t.watchog = {group1 = 'campo'}
t[505] = t.watchog
t.lillipup = {group1 = 'campo'}
t[506] = t.lillipup
t.herdier = {group1 = 'campo'}
t[507] = t.herdier
t.stoutland = {group1 = 'campo'}
t[508] = t.stoutland
t.purrloin = {group1 = 'campo'}
t[509] = t.purrloin
t.liepard = {group1 = 'campo'}
t[510] = t.liepard
t.pansage = {group1 = 'campo'}
t[511] = t.pansage
t.simisage = {group1 = 'campo'}
t[512] = t.simisage
t.pansear = {group1 = 'campo'}
t[513] = t.pansear
t.simisear = {group1 = 'campo'}
t[514] = t.simisear
t.panpour = {group1 = 'campo'}
t[515] = t.panpour
t.simipour = {group1 = 'campo'}
t[516] = t.simipour
t.munna = {group1 = 'campo'}
t[517] = t.munna
t.musharna = {group1 = 'campo'}
t[518] = t.musharna
t.pidove = {group1 = 'volante'}
t[519] = t.pidove
t.tranquill = {group1 = 'volante'}
t[520] = t.tranquill
t.unfezant = {group1 = 'volante'}
t[521] = t.unfezant
t.blitzle = {group1 = 'campo'}
t[522] = t.blitzle
t.zebstrika = {group1 = 'campo'}
t[523] = t.zebstrika
t.roggenrola = {group1 = 'minerale'}
t[524] = t.roggenrola
t.boldore = {group1 = 'minerale'}
t[525] = t.boldore
t.gigalith = {group1 = 'minerale'}
t[526] = t.gigalith
t.woobat = {group1 = 'campo', group2 = 'volante'}
t[527] = t.woobat
t.swoobat = {group1 = 'campo', group2 = 'volante'}
t[528] = t.swoobat
t.drilbur = {group1 = 'campo'}
t[529] = t.drilbur
t.excadrill = {group1 = 'campo'}
t[530] = t.excadrill
t.audino = {group1 = 'magico'}
t[531] = t.audino
t.timburr = {group1 = 'umanoide'}
t[532] = t.timburr
t.gurdurr = {group1 = 'umanoide'}
t[533] = t.gurdurr
t.conkeldurr = {group1 = 'umanoide'}
t[534] = t.conkeldurr
t.tympole = {group1 = 'acqua 1'}
t[535] = t.tympole
t.palpitoad = {group1 = 'acqua 1'}
t[536] = t.palpitoad
t.seismitoad = {group1 = 'acqua 1'}
t[537] = t.seismitoad
t.throh = {group1 = 'umanoide'}
t[538] = t.throh
t.sawk = {group1 = 'umanoide'}
t[539] = t.sawk
t.sewaddle = {group1 = 'coleottero'}
t[540] = t.sewaddle
t.swadloon = {group1 = 'coleottero'}
t[541] = t.swadloon
t.leavanny = {group1 = 'coleottero'}
t[542] = t.leavanny
t.venipede = {group1 = 'coleottero'}
t[543] = t.venipede
t.whirlipede = {group1 = 'coleottero'}
t[544] = t.whirlipede
t.scolipede = {group1 = 'coleottero'}
t[545] = t.scolipede
t.cottonee = {group1 = 'erba', group2 = 'magico'}
t[546] = t.cottonee
t.whimsicott = {group1 = 'erba', group2 = 'magico'}
t[547] = t.whimsicott
t.petilil = {group1 = 'erba'}
t[548] = t.petilil
t.lilligant = {group1 = 'erba'}
t[549] = t.lilligant
t.basculin = {group1 = 'acqua 2'}
t[550] = t.basculin
t.sandile = {group1 = 'campo'}
t[551] = t.sandile
t.krokorok = {group1 = 'campo'}
t[552] = t.krokorok
t.krookodile = {group1 = 'campo'}
t[553] = t.krookodile
t.darumaka = {group1 = 'campo'}
t[554] = t.darumaka
t.darmanitan = {group1 = 'campo'}
t[555] = t.darmanitan
t.maractus = {group1 = 'erba'}
t[556] = t.maractus
t.dwebble = {group1 = 'coleottero', group2 = 'minerale'}
t[557] = t.dwebble
t.crustle = {group1 = 'coleottero', group2 = 'minerale'}
t[558] = t.crustle
t.scraggy = {group1 = 'campo', group2 = 'drago'}
t[559] = t.scraggy
t.scrafty = {group1 = 'campo', group2 = 'drago'}
t[560] = t.scrafty
t.sigilyph = {group1 = 'volante'}
t[561] = t.sigilyph
t.yamask = {group1 = 'minerale', group2 = 'amorfo'}
t[562] = t.yamask
t.cofagrigus = {group1 = 'minerale', group2 = 'amorfo'}
t[563] = t.cofagrigus
t.tirtouga = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[564] = t.tirtouga
t.carracosta = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[565] = t.carracosta
t.archen = {group1 = 'volante', group2 = 'acqua 3'}
t[566] = t.archen
t.archeops = {group1 = 'volante', group2 = 'acqua 3'}
t[567] = t.archeops
t.trubbish = {group1 = 'minerale'}
t[568] = t.trubbish
t.garbodor = {group1 = 'minerale'}
t[569] = t.garbodor
t.zorua = {group1 = 'campo'}
t[570] = t.zorua
t.zoroark = {group1 = 'campo'}
t[571] = t.zoroark
t.minccino = {group1 = 'campo'}
t[572] = t.minccino
t.cinccino = {group1 = 'campo'}
t[573] = t.cinccino
t.gothita = {group1 = 'umanoide'}
t[574] = t.gothita
t.gothorita = {group1 = 'umanoide'}
t[575] = t.gothorita
t.gothitelle = {group1 = 'umanoide'}
t[576] = t.gothitelle
t.solosis = {group1 = 'amorfo'}
t[577] = t.solosis
t.duosion = {group1 = 'amorfo'}
t[578] = t.duosion
t.reuniclus = {group1 = 'amorfo'}
t[579] = t.reuniclus
t.ducklett = {group1 = 'acqua 1', group2 = 'volante'}
t[580] = t.ducklett
t.swanna = {group1 = 'acqua 1', group2 = 'volante'}
t[581] = t.swanna
t.vanillite = {group1 = 'minerale'}
t[582] = t.vanillite
t.vanillish = {group1 = 'minerale'}
t[583] = t.vanillish
t.vanilluxe = {group1 = 'minerale'}
t[584] = t.vanilluxe
t.deerling = {group1 = 'campo'}
t[585] = t.deerling
t.sawsbuck = {group1 = 'campo'}
t[586] = t.sawsbuck
t.emolga = {group1 = 'campo'}
t[587] = t.emolga
t.karrablast = {group1 = 'coleottero'}
t[588] = t.karrablast
t.escavalier = {group1 = 'coleottero'}
t[589] = t.escavalier
t.foongus = {group1 = 'erba'}
t[590] = t.foongus
t.amoonguss = {group1 = 'erba'}
t[591] = t.amoonguss
t.frillish = {group1 = 'amorfo'}
t[592] = t.frillish
t.jellicent = {group1 = 'amorfo'}
t[593] = t.jellicent
t.alomomola = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[594] = t.alomomola
t.joltik = {group1 = 'coleottero'}
t[595] = t.joltik
t.galvantula = {group1 = 'coleottero'}
t[596] = t.galvantula
t.ferroseed = {group1 = 'erba', group2 = 'minerale'}
t[597] = t.ferroseed
t.ferrothorn = {group1 = 'erba', group2 = 'minerale'}
t[598] = t.ferrothorn
t.klink = {group1 = 'minerale'}
t[599] = t.klink
t.klang = {group1 = 'minerale'}
t[600] = t.klang
t.klinklang = {group1 = 'minerale'}
t[601] = t.klinklang
t.tynamo = {group1 = 'amorfo'}
t[602] = t.tynamo
t.eelektrik = {group1 = 'amorfo'}
t[603] = t.eelektrik
t.eelektross = {group1 = 'amorfo'}
t[604] = t.eelektross
t.elgyem = {group1 = 'umanoide'}
t[605] = t.elgyem
t.beheeyem = {group1 = 'umanoide'}
t[606] = t.beheeyem
t.litwick = {group1 = 'amorfo'}
t[607] = t.litwick
t.lampent = {group1 = 'amorfo'}
t[608] = t.lampent
t.chandelure = {group1 = 'amorfo'}
t[609] = t.chandelure
t.axew = {group1 = 'mostro', group2 = 'drago'}
t[610] = t.axew
t.fraxure = {group1 = 'mostro', group2 = 'drago'}
t[611] = t.fraxure
t.haxorus = {group1 = 'mostro', group2 = 'drago'}
t[612] = t.haxorus
t.cubchoo = {group1 = 'campo'}
t[613] = t.cubchoo
t.beartic = {group1 = 'campo'}
t[614] = t.beartic
t.cryogonal = {group1 = 'minerale'}
t[615] = t.cryogonal
t.shelmet = {group1 = 'coleottero'}
t[616] = t.shelmet
t.accelgor = {group1 = 'coleottero'}
t[617] = t.accelgor
t.stunfisk = {group1 = 'acqua 1', group2 = 'amorfo'}
t[618] = t.stunfisk
t.mienfoo = {group1 = 'campo', group2 = 'umanoide'}
t[619] = t.mienfoo
t.mienshao = {group1 = 'campo', group2 = 'umanoide'}
t[620] = t.mienshao
t.druddigon = {group1 = 'drago', group2 = 'mostro'}
t[621] = t.druddigon
t.golett = {group1 = 'minerale'}
t[622] = t.golett
t.golurk = {group1 = 'minerale'}
t[623] = t.golurk
t.pawniard = {group1 = 'umanoide'}
t[624] = t.pawniard
t.bisharp = {group1 = 'umanoide'}
t[625] = t.bisharp
t.bouffalant = {group1 = 'campo'}
t[626] = t.bouffalant
t.rufflet = {group1 = 'volante'}
t[627] = t.rufflet
t.braviary = {group1 = 'volante'}
t[628] = t.braviary
t.vullaby = {group1 = 'volante'}
t[629] = t.vullaby
t.mandibuzz = {group1 = 'volante'}
t[630] = t.mandibuzz
t.heatmor = {group1 = 'campo'}
t[631] = t.heatmor
t.durant = {group1 = 'coleottero'}
t[632] = t.durant
t.deino = {group1 = 'drago'}
t[633] = t.deino
t.zweilous = {group1 = 'drago'}
t[634] = t.zweilous
t.hydreigon = {group1 = 'drago'}
t[635] = t.hydreigon
t.larvesta = {group1 = 'coleottero'}
t[636] = t.larvesta
t.volcarona = {group1 = 'coleottero'}
t[637] = t.volcarona
t.cobalion = {group1 = 'sconosciuto'}
t[638] = t.cobalion
t.terrakion = {group1 = 'sconosciuto'}
t[639] = t.terrakion
t.virizion = {group1 = 'sconosciuto'}
t[640] = t.virizion
t.tornadus = {group1 = 'sconosciuto'}
t[641] = t.tornadus
t.thundurus = {group1 = 'sconosciuto'}
t[642] = t.thundurus
t.reshiram = {group1 = 'sconosciuto'}
t[643] = t.reshiram
t.zekrom = {group1 = 'sconosciuto'}
t[644] = t.zekrom
t.landorus = {group1 = 'sconosciuto'}
t[645] = t.landorus
t.kyurem = {group1 = 'sconosciuto'}
t[646] = t.kyurem
t.keldeo = {group1 = 'sconosciuto'}
t[647] = t.keldeo
t.meloetta = {group1 = 'sconosciuto'}
t[648] = t.meloetta
t.genesect = {group1 = 'sconosciuto'}
t[649] = t.genesect
t.chespin = {group1 = 'campo'}
t[650] = t.chespin
t.quilladin = {group1 = 'campo'}
t[651] = t.quilladin
t.chesnaught = {group1 = 'campo'}
t[652] = t.chesnaught
t.fennekin = {group1 = 'campo'}
t[653] = t.fennekin
t.braixen = {group1 = 'campo'}
t[654] = t.braixen
t.delphox = {group1 = 'campo'}
t[655] = t.delphox
t.froakie = {group1 = 'acqua 1'}
t[656] = t.froakie
t.frogadier = {group1 = 'acqua 1'}
t[657] = t.frogadier
t.greninja = {group1 = 'acqua 1'}
t[658] = t.greninja
t.bunnelby = {group1 = 'campo'}
t[659] = t.bunnelby
t.diggersby = {group1 = 'campo'}
t[660] = t.diggersby
t.fletchling = {group1 = 'volante'}
t[661] = t.fletchling
t.fletchinder = {group1 = 'volante'}
t[662] = t.fletchinder
t.talonflame = {group1 = 'volante'}
t[663] = t.talonflame
t.scatterbug = {group1 = 'coleottero'}
t[664] = t.scatterbug
t.spewpa = {group1 = 'coleottero'}
t[665] = t.spewpa
t.vivillon = {group1 = 'coleottero'}
t[666] = t.vivillon
t.litleo = {group1 = 'campo'}
t[667] = t.litleo
t.pyroar = {group1 = 'campo'}
t[668] = t.pyroar
t["flabébé"] = {group1 = 'magico'}
t[669] = t["flabébé"]
t.floette = {group1 = 'magico'}
t[670] = t.floette
t.florges = {group1 = 'magico'}
t[671] = t.florges
t.skiddo = {group1 = 'campo'}
t[672] = t.skiddo
t.gogoat = {group1 = 'campo'}
t[673] = t.gogoat
t.pancham = {group1 = 'campo', group2 = 'umanoide'}
t[674] = t.pancham
t.pangoro = {group1 = 'campo', group2 = 'umanoide'}
t[675] = t.pangoro
t.furfrou = {group1 = 'campo'}
t[676] = t.furfrou
t.espurr = {group1 = 'campo'}
t[677] = t.espurr
t.meowstic = {group1 = 'campo'}
t[678] = t.meowstic
t.honedge = {group1 = 'minerale'}
t[679] = t.honedge
t.doublade = {group1 = 'minerale'}
t[680] = t.doublade
t.aegislash = {group1 = 'minerale'}
t[681] = t.aegislash
t.spritzee = {group1 = 'magico'}
t[682] = t.spritzee
t.aromatisse = {group1 = 'magico'}
t[683] = t.aromatisse
t.swirlix = {group1 = 'magico'}
t[684] = t.swirlix
t.slurpuff = {group1 = 'magico'}
t[685] = t.slurpuff
t.inkay = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[686] = t.inkay
t.malamar = {group1 = 'acqua 1', group2 = 'acqua 2'}
t[687] = t.malamar
t.binacle = {group1 = 'acqua 3'}
t[688] = t.binacle
t.barbaracle = {group1 = 'acqua 3'}
t[689] = t.barbaracle
t.skrelp = {group1 = 'acqua 1', group2 = 'drago'}
t[690] = t.skrelp
t.dragalge = {group1 = 'acqua 1', group2 = 'drago'}
t[691] = t.dragalge
t.clauncher = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[692] = t.clauncher
t.clawitzer = {group1 = 'acqua 1', group2 = 'acqua 3'}
t[693] = t.clawitzer
t.helioptile = {group1 = 'mostro', group2 = 'drago'}
t[694] = t.helioptile
t.heliolisk = {group1 = 'mostro', group2 = 'drago'}
t[695] = t.heliolisk
t.tyrunt = {group1 = 'mostro', group2 = 'drago'}
t[696] = t.tyrunt
t.tyrantrum = {group1 = 'mostro', group2 = 'drago'}
t[697] = t.tyrantrum
t.amaura = {group1 = 'mostro'}
t[698] = t.amaura
t.aurorus = {group1 = 'mostro'}
t[699] = t.aurorus
t.sylveon = {group1 = 'campo'}
t[700] = t.sylveon
t.hawlucha = {group1 = 'umanoide'}
t[701] = t.hawlucha
t.dedenne = {group1 = 'campo', group2 = 'magico'}
t[702] = t.dedenne
t.carbink = {group1 = 'magico', group2 = 'minerale'}
t[703] = t.carbink
t.goomy = {group1 = 'drago'}
t[704] = t.goomy
t.sliggoo = {group1 = 'drago'}
t[705] = t.sliggoo
t.goodra = {group1 = 'drago'}
t[706] = t.goodra
t.klefki = {group1 = 'minerale'}
t[707] = t.klefki
t.phantump = {group1 = 'erba', group2 = 'amorfo'}
t[708] = t.phantump
t.trevenant = {group1 = 'erba', group2 = 'amorfo'}
t[709] = t.trevenant
t.pumpkaboo = {group1 = 'amorfo'}
t[710] = t.pumpkaboo
t.gourgeist = {group1 = 'amorfo'}
t[711] = t.gourgeist
t.bergmite = {group1 = 'mostro'}
t[712] = t.bergmite
t.avalugg = {group1 = 'mostro'}
t[713] = t.avalugg
t.noibat = {group1 = 'volante'}
t[714] = t.noibat
t.noivern = {group1 = 'volante'}
t[715] = t.noivern
t.xerneas = {group1 = 'sconosciuto'}
t[716] = t.xerneas
t.yveltal = {group1 = 'sconosciuto'}
t[717] = t.yveltal
t.zygarde = {group1 = 'sconosciuto'}
t[718] = t.zygarde
t.diancie = {group1 = 'sconosciuto'}
t[719] = t.diancie
t.hoopa = {group1 = 'sconosciuto'}
t[720] = t.hoopa
t.volcanion = {group1 = 'sconosciuto'}
t[721] = t.volcanion
t.rowlet = {group1 = 'volante'}
t[722] = t.rowlet
t.dartrix = {group1 = 'volante'}
t[723] = t.dartrix
t.decidueye = {group1 = 'volante'}
t[724] = t.decidueye
t.litten = {group1 = 'campo'}
t[725] = t.litten
t.torracat = {group1 = 'campo'}
t[726] = t.torracat
t.incineroar = {group1 = 'campo'}
t[727] = t.incineroar
t.popplio = {group1 = 'acqua 1', group2 = 'campo'}
t[728] = t.popplio
t.brionne = {group1 = 'acqua 1', group2 = 'campo'}
t[729] = t.brionne
t.primarina = {group1 = 'acqua 1', group2 = 'campo'}
t[730] = t.primarina
t.pikipek = {group1 = 'volante'}
t[731] = t.pikipek
t.trumbeak = {group1 = 'volante'}
t[732] = t.trumbeak
t.toucannon = {group1 = 'volante'}
t[733] = t.toucannon
t.yungoos = {group1 = 'campo'}
t[734] = t.yungoos
t.gumshoos = {group1 = 'campo'}
t[735] = t.gumshoos
t.grubbin = {group1 = 'coleottero'}
t[736] = t.grubbin
t.charjabug = {group1 = 'coleottero'}
t[737] = t.charjabug
t.vikavolt = {group1 = 'coleottero'}
t[738] = t.vikavolt
t.crabrawler = {group1 = 'acqua 3'}
t[739] = t.crabrawler
t.crabominable = {group1 = 'acqua 3'}
t[740] = t.crabominable
t.oricorio = {group1 = 'volante'}
t[741] = t.oricorio
t.cutiefly = {group1 = 'coleottero', group2 = 'magico'}
t[742] = t.cutiefly
t.ribombee = {group1 = 'coleottero', group2 = 'magico'}
t[743] = t.ribombee
t.rockruff = {group1 = 'campo'}
t[744] = t.rockruff
t.lycanroc = {group1 = 'campo'}
t[745] = t.lycanroc
t.wishiwashi = {group1 = 'acqua 2'}
t[746] = t.wishiwashi
t.mareanie = {group1 = 'acqua 1'}
t[747] = t.mareanie
t.toxapex = {group1 = 'acqua 1'}
t[748] = t.toxapex
t.mudbray = {group1 = 'campo'}
t[749] = t.mudbray
t.mudsdale = {group1 = 'campo'}
t[750] = t.mudsdale
t.dewpider = {group1 = 'acqua 1', group2 = 'coleottero'}
t[751] = t.dewpider
t.araquanid = {group1 = 'acqua 1', group2 = 'coleottero'}
t[752] = t.araquanid
t.fomantis = {group1 = 'erba'}
t[753] = t.fomantis
t.lurantis = {group1 = 'erba'}
t[754] = t.lurantis
t.morelull = {group1 = 'erba'}
t[755] = t.morelull
t.shiinotic = {group1 = 'erba'}
t[756] = t.shiinotic
t.salandit = {group1 = 'mostro', group2 = 'drago'}
t[757] = t.salandit
t.salazzle = {group1 = 'mostro', group2 = 'drago'}
t[758] = t.salazzle
t.stufful = {group1 = 'campo'}
t[759] = t.stufful
t.bewear = {group1 = 'campo'}
t[760] = t.bewear
t.bounsweet = {group1 = 'erba'}
t[761] = t.bounsweet
t.steenee = {group1 = 'erba'}
t[762] = t.steenee
t.tsareena = {group1 = 'erba'}
t[763] = t.tsareena
t.comfey = {group1 = 'erba'}
t[764] = t.comfey
t.oranguru = {group1 = 'campo'}
t[765] = t.oranguru
t.passimian = {group1 = 'campo'}
t[766] = t.passimian
t.wimpod = {group1 = 'coleottero', group2 = 'acqua 3'}
t[767] = t.wimpod
t.golisopod = {group1 = 'coleottero', group2 = 'acqua 3'}
t[768] = t.golisopod
t.sandygast = {group1 = 'amorfo'}
t[769] = t.sandygast
t.palossand = {group1 = 'amorfo'}
t[770] = t.palossand
t.pyukumuku = {group1 = 'acqua 1'}
t[771] = t.pyukumuku
t["tipo zero"] = {group1 = 'sconosciuto'}
t[772] = t["tipo zero"]
t.silvally = {group1 = 'sconosciuto'}
t[773] = t.silvally
t.minior = {group1 = 'minerale'}
t[774] = t.minior
t.komala = {group1 = 'campo'}
t[775] = t.komala
t.turtonator = {group1 = 'mostro', group2 = 'drago'}
t[776] = t.turtonator
t.togedemaru = {group1 = 'campo', group2 = 'magico'}
t[777] = t.togedemaru
t.mimikyu = {group1 = 'amorfo'}
t[778] = t.mimikyu
t.bruxish = {group1 = 'acqua 2'}
t[779] = t.bruxish
t.drampa = {group1 = 'mostro', group2 = 'drago'}
t[780] = t.drampa
t.dhelmise = {group1 = 'minerale'}
t[781] = t.dhelmise
t["jangmo-o"] = {group1 = 'drago'}
t[782] = t["jangmo-o"]
t["hakamo-o"] = {group1 = 'drago'}
t[783] = t["hakamo-o"]
t["kommo-o"] = {group1 = 'drago'}
t[784] = t["kommo-o"]
t["tapu koko"] = {group1 = 'sconosciuto'}
t[785] = t["tapu koko"]
t["tapu lele"] = {group1 = 'sconosciuto'}
t[786] = t["tapu lele"]
t["tapu bulu"] = {group1 = 'sconosciuto'}
t[787] = t["tapu bulu"]
t["tapu fini"] = {group1 = 'sconosciuto'}
t[788] = t["tapu fini"]
t.cosmog = {group1 = 'sconosciuto'}
t[789] = t.cosmog
t.cosmoem = {group1 = 'sconosciuto'}
t[790] = t.cosmoem
t.solgaleo = {group1 = 'sconosciuto'}
t[791] = t.solgaleo
t.lunala = {group1 = 'sconosciuto'}
t[792] = t.lunala
t.nihilego = {group1 = 'sconosciuto'}
t[793] = t.nihilego
t.buzzwole = {group1 = 'sconosciuto'}
t[794] = t.buzzwole
t.pheromosa = {group1 = 'sconosciuto'}
t[795] = t.pheromosa
t.xurkitree = {group1 = 'sconosciuto'}
t[796] = t.xurkitree
t.celesteela = {group1 = 'sconosciuto'}
t[797] = t.celesteela
t.kartana = {group1 = 'sconosciuto'}
t[798] = t.kartana
t.guzzlord = {group1 = 'sconosciuto'}
t[799] = t.guzzlord
t.necrozma = {group1 = 'sconosciuto'}
t[800] = t.necrozma
t.magearna = {group1 = 'sconosciuto'}
t[801] = t.magearna
t.marshadow = {group1 = 'sconosciuto'}
t[802] = t.marshadow
t.poipole = {group1 = 'sconosciuto'}
t[803] = t.poipole
t.naganadel = {group1 = 'sconosciuto'}
t[804] = t.naganadel
t.stakataka = {group1 = 'sconosciuto'}
t[805] = t.stakataka
t.blacephalon = {group1 = 'sconosciuto'}
t[806] = t.blacephalon
t.zeraora = {group1 = 'sconosciuto'}
t[807] = t.zeraora
-- t.grookey = {group1 = ''}
-- t.scorbunny = {group1 = ''}
-- t.sobble = {group1 = ''}
-- t.gossifleur = {group1 = ''}
-- t.eldegoss = {group1 = ''}
-- t.wooloo = {group1 = ''}
-- t.corviknight = {group1 = ''}
-- t.drednaw = {group1 = ''}
-- t.impidimp = {group1 = ''}
-- t.yamper = {group1 = ''}
-- t.alcremie = {group1 = ''}
-- t.rolycoly = {group1 = ''}
-- t.duraludon = {group1 = ''}
-- t.zacian = {group1 = 'sconosciuto'}
-- t.zamazenta = {group1 = 'sconosciuto'}

-- Forme alternative che esistono fuori dalla lotta e quindi
-- possono avere un gruppo uova diverso da quello della forma base

t.pikachuCs = {group1 = 'sconosciuto'}
t["025Cs"] = t.pikachuCs
t.deoxysA, t.deoxysD, t.deoxysV =
	t.deoxys, t.deoxys, t.deoxys
t["386A"], t["386D"], t["386V"] =
	t.deoxys, t.deoxys, t.deoxys
t.wormadamSa, t.wormadamSc = t.wormadam, t.wormadam
t["413Sa"], t["413Sc"] = t.wormadam, t.wormadam
t.shellosE = t.shellos
t["422E"] = t.shellos
t.gastrodonE = t.gastrodon
t["423E"] = t.gastrodon
t.giratinaO = t.giratina
t["487O"] = t.giratina
t.shayminC = t.shaymin
t["492C"] = t.shaymin
t.basculinB = t.basculin
t["550B"] = t.basculin
t.tornadusT = t.tornadus
t["641T"] = t.tornadus
t.thundurusT = t.thundurus
t["642T"] = t.thundurus
t.landorusT = t.landorus
t["645T"] = t.landorus
t.kyuremB, t.kyuremN = t.kyurem, t.kyurem
t["646B"], t["646N"] = t.kyurem, t.kyurem
t.keldeoR = t.keldeo
t["647R"] = t.keldeo
t.meloettaD = t.meloetta
t["648D"] = t.meloetta
t.greninjaD = {group1 = 'sconosciuto'}
t["658D"] = t.greninjaD
t.oricorioC, t.oricorioH, t.oricorioB =
	t.oricorio, t.oricorio, t.oricorio
t["741C"], t["741H"], t["741B"] =
	t.oricorio, t.oricorio, t.oricorio
t.lycanrocN, t.lycanrocC = t.lycanroc, t.lycanroc
t["745N"], t["745C"] = t.lycanroc, t.lycanroc
t.necrozmaV, t.necrozmaA = t.necrozma, t.necrozma
t["800V"], t["800A"] = t.necrozma, t.necrozma
t.rattataA = t.rattata
t["019A"] = t.rattata
t.raticateA = t.raticate
t["020A"] = t.raticate
t.raichuA = t.raichu
t["026A"] = t.raichu
t.sandshrewA = t.sandshrew
t["027A"] = t.sandshrew
t.sandslashA = t.sandslash
t["028A"] = t.sandslash
t.vulpixA = t.vulpix
t["037A"] = t.vulpix
t.ninetalesA = t.ninetales
t["038A"] = t.ninetales
t.diglettA = t.diglett
t["050A"] = t.diglett
t.dugtrioA = t.dugtrio
t["051A"] = t.dugtrio
t.meowthA = t.meowth
t["052A"] = t.meowth
t.persianA = t.persian
t["053A"] = t.persian
t.geodudeA = t.geodude
t["074A"] = t.geodude
t.gravelerA = t.graveler
t["075A"] = t.graveler
t.golemA = t.golem
t["076A"] = t.golem
t.grimerA = t.grimer
t["088A"] = t.grimer
t.mukA = t.muk
t["089A"] = t.muk
t.exeggutorA = t.exeggutor
t["103A"] = t.exeggutor
t.marowakA = t.marowak
t["105A"] = t.marowak

return t
