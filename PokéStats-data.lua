--[[

Data module for Pokémon stats.

--]]

local d = {}

d.bulbasaur = {hp = 45, atk = 49, def = 49, spatk = 65, spdef = 65, spe = 45, spec = 65}
d[1] = d.bulbasaur
d.ivysaur = {hp = 60, atk = 62, def = 63, spatk = 80, spdef = 80, spe = 60, spec = 80}
d[2] = d.ivysaur
d.venusaur = {hp = 80, atk = 82, def = 83, spatk = 100, spdef = 100, spe = 80, spec = 100}
d[3] = d.venusaur
d.charmander = {hp = 39, atk = 52, def = 43, spatk = 60, spdef = 50, spe = 65, spec = 50}
d[4] = d.charmander
d.charmeleon = {hp = 58, atk = 64, def = 58, spatk = 80, spdef = 65, spe = 80, spec = 65}
d[5] = d.charmeleon
d.charizard = {hp = 78, atk = 84, def = 78, spatk = 109, spdef = 85, spe = 100, spec = 85}
d[6] = d.charizard
d.squirtle = {hp = 44, atk = 48, def = 65, spatk = 50, spdef = 64, spe = 43, spec = 50}
d[7] = d.squirtle
d.wartortle = {hp = 59, atk = 63, def = 80, spatk = 65, spdef = 80, spe = 58, spec = 65}
d[8] = d.wartortle
d.blastoise = {hp = 79, atk = 83, def = 100, spatk = 85, spdef = 105, spe = 78, spec = 85}
d[9] = d.blastoise
d.caterpie = {hp = 45, atk = 30, def = 35, spatk = 20, spdef = 20, spe = 45, spec = 20}
d[10] = d.caterpie
d.metapod = {hp = 50, atk = 20, def = 55, spatk = 25, spdef = 25, spe = 30, spec = 25}
d[11] = d.metapod
d.butterfree = {hp = 60, atk = 45, def = 50, spatk = {[2] = 80, [6] = 90}, spdef = 80, spe = 70, spec = 80}
d[12] = d.butterfree
d.weedle = {hp = 40, atk = 35, def = 30, spatk = 20, spdef = 20, spe = 50, spec = 20}
d[13] = d.weedle
d.kakuna = {hp = 45, atk = 25, def = 50, spatk = 25, spdef = 25, spe = 35, spec = 25}
d[14] = d.kakuna
d.beedrill = {hp = 65, atk = {[1] = 80, [6] = 90}, def = 40, spatk = 45, spdef = 80, spe = 75, spec = 45}
d[15] = d.beedrill
d.pidgey = {hp = 40, atk = 45, def = 40, spatk = 35, spdef = 35, spe = 56, spec = 35}
d[16] = d.pidgey
d.pidgeotto = {hp = 63, atk = 60, def = 55, spatk = 50, spdef = 50, spe = 71, spec = 50}
d[17] = d.pidgeotto
d.pidgeot = {hp = 83, atk = 80, def = 75, spatk = 70, spdef = 70, spe = {[1] = 91, [6] = 101}, spec = 70}
d[18] = d.pidgeot
d.rattata = {hp = 30, atk = 56, def = 35, spatk = 25, spdef = 35, spe = 72, spec = 25}
d[19] = d.rattata
d.raticate = {hp = 55, atk = 81, def = 60, spatk = 50, spdef = 70, spe = 97, spec = 50}
d[20] = d.raticate
d.spearow = {hp = 40, atk = 60, def = 30, spatk = 31, spdef = 31, spe = 70, spec = 31}
d[21] = d.spearow
d.fearow = {hp = 65, atk = 90, def = 65, spatk = 61, spdef = 61, spe = 100, spec = 61}
d[22] = d.fearow
d.ekans = {hp = 35, atk = 60, def = 44, spatk = 40, spdef = 54, spe = 55, spec = 40}
d[23] = d.ekans
d.arbok = {hp = 60, atk = {[1] = 85, [7] = 95}, def = 69, spatk = 65, spdef = 79, spe = 80, spec = 65}
d[24] = d.arbok
d.pikachu = {hp = 35, atk = 55, def = {[1] = 30, [6] = 40}, spatk = 50, spdef = {[2] = 40, [6] = 50}, spe = 90, spec = 50}
d[25] = d.pikachu
d.raichu = {hp = 60, atk = 90, def = 55, spatk = 90, spdef = 80, spe = {[1] = 100, [6] = 110}, spec = 90}
d[26] = d.raichu
d.sandshrew = {hp = 50, atk = 75, def = 85, spatk = 20, spdef = 30, spe = 40, spec = 30}
d[27] = d.sandshrew
d.sandslash = {hp = 75, atk = 100, def = 110, spatk = 45, spdef = 55, spe = 65, spec = 55}
d[28] = d.sandslash
d['nidoran♀'] = {hp = 55, atk = 47, def = 52, spatk = 40, spdef = 40, spe = 41, spec = 40}
d[29] = d['nidoran♀']
d.nidorina = {hp = 70, atk = 62, def = 67, spatk = 55, spdef = 55, spe = 56, spec = 55}
d[30] = d.nidorina
d.nidoqueen = {hp = 90, atk = {[1] = 82, [6] = 92}, def = 87, spatk = 75, spdef = 85, spe = 76, spec = 75}
d[31] = d.nidoqueen
d['nidoran♂'] = {hp = 46, atk = 57, def = 40, spatk = 40, spdef = 40, spe = 50, spec = 40}
d[32] = d['nidoran♂']
d.nidorino = {hp = 61, atk = 72, def = 57, spatk = 55, spdef = 55, spe = 65, spec = 55}
d[33] = d.nidorino
d.nidoking = {hp = 81, atk = {[1] = 92, [6] = 102}, def = 77, spatk = 85, spdef = 75, spe = 85, spec = 75}
d[34] = d.nidoking
d.clefairy = {hp = 70, atk = 45, def = 48, spatk = 60, spdef = 65, spe = 35, spec = 60}
d[35] = d.clefairy
d.clefable = {hp = 95, atk = 70, def = 73, spatk = {[2] = 85, [6] = 95}, spdef = 90, spe = 60, spec = 85}
d[36] = d.clefable
d.vulpix = {hp = 38, atk = 41, def = 40, spatk = 50, spdef = 65, spe = 65, spec = 65}
d[37] = d.vulpix
d.ninetales = {hp = 73, atk = 76, def = 75, spatk = 81, spdef = 100, spe = 100, spec = 100}
d[38] = d.ninetales
d.jigglypuff = {hp = 115, atk = 45, def = 20, spatk = 45, spdef = 25, spe = 20, spec = 25}
d[39] = d.jigglypuff
d.wigglytuff = {hp = 140, atk = 70, def = 45, spatk = {[2] = 75, [6] = 85}, spdef = 50, spe = 45, spec = 50}
d[40] = d.wigglytuff
d.zubat = {hp = 40, atk = 45, def = 35, spatk = 30, spdef = 40, spe = 55, spec = 40}
d[41] = d.zubat
d.golbat = {hp = 75, atk = 80, def = 70, spatk = 65, spdef = 75, spe = 90, spec = 75}
d[42] = d.golbat
d.oddish = {hp = 45, atk = 50, def = 55, spatk = 75, spdef = 65, spe = 30, spec = 75}
d[43] = d.oddish
d.gloom = {hp = 60, atk = 65, def = 70, spatk = 85, spdef = 75, spe = 40, spec = 85}
d[44] = d.gloom
d.vileplume = {hp = 75, atk = 80, def = 85, spatk = {[2] = 100, [6] = 110}, spdef = 90, spe = 50, spec = 100}
d[45] = d.vileplume
d.paras = {hp = 35, atk = 70, def = 55, spatk = 45, spdef = 55, spe = 25, spec = 55}
d[46] = d.paras
d.parasect = {hp = 60, atk = 95, def = 80, spatk = 60, spdef = 80, spe = 30, spec = 80}
d[47] = d.parasect
d.venonat = {hp = 60, atk = 55, def = 50, spatk = 40, spdef = 55, spe = 45, spec = 40}
d[48] = d.venonat
d.venomoth = {hp = 70, atk = 65, def = 60, spatk = 90, spdef = 75, spe = 90, spec = 90}
d[49] = d.venomoth
d.diglett = {hp = 10, atk = 55, def = 25, spatk = 35, spdef = 45, spe = 95, spec = 45}
d[50] = d.diglett
d.dugtrio = {hp = 35, atk = {[1] = 80, [7] = 100}, def = 50, spatk = 50, spdef = 70, spe = 120, spec = 70}
d[51] = d.dugtrio
d.meowth = {hp = 40, atk = 45, def = 35, spatk = 40, spdef = 40, spe = 90, spec = 40}
d[52] = d.meowth
d.persian = {hp = 65, atk = 70, def = 60, spatk = 65, spdef = 65, spe = 115, spec = 65}
d[53] = d.persian
d.psyduck = {hp = 50, atk = 52, def = 48, spatk = 65, spdef = 50, spe = 55, spec = 50}
d[54] = d.psyduck
d.golduck = {hp = 80, atk = 82, def = 78, spatk = 95, spdef = 80, spe = 85, spec = 80}
d[55] = d.golduck
d.mankey = {hp = 40, atk = 80, def = 35, spatk = 35, spdef = 45, spe = 70, spec = 35}
d[56] = d.mankey
d.primeape = {hp = 65, atk = 105, def = 60, spatk = 60, spdef = 70, spe = 95, spec = 60}
d[57] = d.primeape
d.growlithe = {hp = 55, atk = 70, def = 45, spatk = 70, spdef = 50, spe = 60, spec = 50}
d[58] = d.growlithe
d.arcanine = {hp = 90, atk = 110, def = 80, spatk = 100, spdef = 80, spe = 95, spec = 80}
d[59] = d.arcanine
d.poliwag = {hp = 40, atk = 50, def = 40, spatk = 40, spdef = 40, spe = 90, spec = 40}
d[60] = d.poliwag
d.poliwhirl = {hp = 65, atk = 65, def = 65, spatk = 50, spdef = 50, spe = 90, spec = 50}
d[61] = d.poliwhirl
d.poliwrath = {hp = 90, atk = {[1] = 85, [6] = 95}, def = 95, spatk = 70, spdef = 90, spe = 70, spec = 70}
d[62] = d.poliwrath
d.abra = {hp = 25, atk = 20, def = 15, spatk = 105, spdef = 55, spe = 90, spec = 105}
d[63] = d.abra
d.kadabra = {hp = 40, atk = 35, def = 30, spatk = 120, spdef = 70, spe = 105, spec = 120}
d[64] = d.kadabra
d.alakazam = {hp = 55, atk = 50, def = 45, spatk = 135, spdef = {[2] = 85, [6] = 95}, spe = 120, spec = 135}
d[65] = d.alakazam
d.machop = {hp = 70, atk = 80, def = 50, spatk = 35, spdef = 35, spe = 35, spec = 35}
d[66] = d.machop
d.machoke = {hp = 80, atk = 100, def = 70, spatk = 50, spdef = 60, spe = 45, spec = 50}
d[67] = d.machoke
d.machamp = {hp = 90, atk = 130, def = 80, spatk = 65, spdef = 85, spe = 55, spec = 65}
d[68] = d.machamp
d.bellsprout = {hp = 50, atk = 75, def = 35, spatk = 70, spdef = 30, spe = 40, spec = 70}
d[69] = d.bellsprout
d.weepinbell = {hp = 65, atk = 90, def = 50, spatk = 85, spdef = 45, spe = 55, spec = 85}
d[70] = d.weepinbell
d.victreebel = {hp = 80, atk = 105, def = 65, spatk = 100, spdef = {[2] = 60, [6] = 70}, spe = 70, spec = 100}
d[71] = d.victreebel
d.tentacool = {hp = 40, atk = 40, def = 35, spatk = 50, spdef = 100, spe = 70, spec = 100}
d[72] = d.tentacool
d.tentacruel = {hp = 80, atk = 70, def = 65, spatk = 80, spdef = 120, spe = 100, spec = 120}
d[73] = d.tentacruel
d.geodude = {hp = 40, atk = 80, def = 100, spatk = 30, spdef = 30, spe = 20, spec = 30}
d[74] = d.geodude
d.graveler = {hp = 55, atk = 95, def = 115, spatk = 45, spdef = 45, spe = 35, spec = 45}
d[75] = d.graveler
d.golem = {hp = 80, atk = {[1] = 110, [6] = 120}, def = 130, spatk = 55, spdef = 65, spe = 45, spec = 55}
d[76] = d.golem
d.ponyta = {hp = 50, atk = 85, def = 55, spatk = 65, spdef = 65, spe = 90, spec = 65}
d[77] = d.ponyta
d.rapidash = {hp = 65, atk = 100, def = 70, spatk = 80, spdef = 80, spe = 105, spec = 80}
d[78] = d.rapidash
d.slowpoke = {hp = 90, atk = 65, def = 65, spatk = 40, spdef = 40, spe = 15, spec = 40}
d[79] = d.slowpoke
d.slowbro = {hp = 95, atk = 75, def = 110, spatk = 100, spdef = 80, spe = 30, spec = 80}
d[80] = d.slowbro
d.magnemite = {hp = 25, atk = 35, def = 70, spatk = 95, spdef = 55, spe = 45, spec = 95}
d[81] = d.magnemite
d.magneton = {hp = 50, atk = 60, def = 95, spatk = 120, spdef = 70, spe = 70, spec = 120}
d[82] = d.magneton
d["farfetch'd"] = {hp = 52, atk = {[1] = 65, [7] = 90}, def = 55, spatk = 58, spdef = 62, spe = 60, spec = 58}
d[83] = d["farfetch'd"]
d.doduo = {hp = 35, atk = 85, def = 45, spatk = 35, spdef = 35, spe = 75, spec = 35}
d[84] = d.doduo
d.dodrio = {hp = 60, atk = 110, def = 70, spatk = 60, spdef = 60, spe = {[1] = 100, [7] = 110}, spec = 60}
d[85] = d.dodrio
d.seel = {hp = 65, atk = 45, def = 55, spatk = 45, spdef = 70, spe = 45, spec = 70}
d[86] = d.seel
d.dewgong = {hp = 90, atk = 70, def = 80, spatk = 70, spdef = 95, spe = 70, spec = 95}
d[87] = d.dewgong
d.grimer = {hp = 80, atk = 80, def = 50, spatk = 40, spdef = 50, spe = 25, spec = 40}
d[88] = d.grimer
d.muk = {hp = 105, atk = 105, def = 75, spatk = 65, spdef = 100, spe = 50, spec = 65}
d[89] = d.muk
d.shellder = {hp = 30, atk = 65, def = 100, spatk = 45, spdef = 25, spe = 40, spec = 45}
d[90] = d.shellder
d.cloyster = {hp = 50, atk = 95, def = 180, spatk = 85, spdef = 45, spe = 70, spec = 85}
d[91] = d.cloyster
d.gastly = {hp = 30, atk = 35, def = 30, spatk = 100, spdef = 35, spe = 80, spec = 100}
d[92] = d.gastly
d.haunter = {hp = 45, atk = 50, def = 45, spatk = 115, spdef = 55, spe = 95, spec = 115}
d[93] = d.haunter
d.gengar = {hp = 60, atk = 65, def = 60, spatk = 130, spdef = 75, spe = 110, spec = 130}
d[94] = d.gengar
d.onix = {hp = 35, atk = 45, def = 160, spatk = 30, spdef = 45, spe = 70, spec = 30}
d[95] = d.onix
d.drowzee = {hp = 60, atk = 48, def = 45, spatk = 43, spdef = 90, spe = 42, spec = 90}
d[96] = d.drowzee
d.hypno = {hp = 85, atk = 73, def = 70, spatk = 73, spdef = 115, spe = 67, spec = 115}
d[97] = d.hypno
d.krabby = {hp = 30, atk = 105, def = 90, spatk = 25, spdef = 25, spe = 50, spec = 25}
d[98] = d.krabby
d.kingler = {hp = 55, atk = 130, def = 115, spatk = 50, spdef = 50, spe = 75, spec = 50}
d[99] = d.kingler
d.voltorb = {hp = 40, atk = 30, def = 50, spatk = 55, spdef = 55, spe = 100, spec = 55}
d[100] = d.voltorb
d.electrode = {hp = 60, atk = 50, def = 70, spatk = 80, spdef = 80, spe = {[1] = 140, [7] = 150}, spec = 80}
d[101] = d.electrode
d.exeggcute = {hp = 60, atk = 40, def = 80, spatk = 60, spdef = 45, spe = 40, spec = 60}
d[102] = d.exeggcute
d.exeggutor = {hp = 95, atk = 95, def = 85, spatk = 125, spdef = {[2] = 65, [7] = 75}, spe = 55, spec = 125}
d[103] = d.exeggutor
d.cubone = {hp = 50, atk = 50, def = 95, spatk = 40, spdef = 50, spe = 35, spec = 40}
d[104] = d.cubone
d.marowak = {hp = 60, atk = 80, def = 110, spatk = 50, spdef = 80, spe = 45, spec = 50}
d[105] = d.marowak
d.hitmonlee = {hp = 50, atk = 120, def = 53, spatk = 35, spdef = 110, spe = 87, spec = 35}
d[106] = d.hitmonlee
d.hitmonchan = {hp = 50, atk = 105, def = 79, spatk = 35, spdef = 110, spe = 76, spec = 35}
d[107] = d.hitmonchan
d.lickitung = {hp = 90, atk = 55, def = 75, spatk = 60, spdef = 75, spe = 30, spec = 60}
d[108] = d.lickitung
d.koffing = {hp = 40, atk = 65, def = 95, spatk = 60, spdef = 45, spe = 35, spec = 60}
d[109] = d.koffing
d.weezing = {hp = 65, atk = 90, def = 120, spatk = 85, spdef = 70, spe = 60, spec = 85}
d[110] = d.weezing
d.rhyhorn = {hp = 80, atk = 85, def = 95, spatk = 30, spdef = 30, spe = 25, spec = 30}
d[111] = d.rhyhorn
d.rhydon = {hp = 105, atk = 130, def = 120, spatk = 45, spdef = 45, spe = 40, spec = 45}
d[112] = d.rhydon
d.chansey = {hp = 250, atk = 5, def = 5, spatk = 35, spdef = 105, spe = 50, spec = 105}
d[113] = d.chansey
d.tangela = {hp = 65, atk = 55, def = 115, spatk = 100, spdef = 40, spe = 60, spec = 100}
d[114] = d.tangela
d.kangaskhan = {hp = 105, atk = 95, def = 80, spatk = 40, spdef = 80, spe = 90, spec = 40}
d[115] = d.kangaskhan
d.horsea = {hp = 30, atk = 40, def = 70, spatk = 70, spdef = 25, spe = 60, spec = 70}
d[116] = d.horsea
d.seadra = {hp = 55, atk = 65, def = 95, spatk = 95, spdef = 45, spe = 85, spec = 95}
d[117] = d.seadra
d.goldeen = {hp = 45, atk = 67, def = 60, spatk = 35, spdef = 50, spe = 63, spec = 50}
d[118] = d.goldeen
d.seaking = {hp = 80, atk = 92, def = 65, spatk = 65, spdef = 80, spe = 68, spec = 80}
d[119] = d.seaking
d.staryu = {hp = 30, atk = 45, def = 55, spatk = 70, spdef = 55, spe = 85, spec = 70}
d[120] = d.staryu
d.starmie = {hp = 60, atk = 75, def = 85, spatk = 100, spdef = 85, spe = 115, spec = 100}
d[121] = d.starmie
d['mr. mime'] = {hp = 40, atk = 45, def = 65, spatk = 100, spdef = 120, spe = 90, spec = 100}
d[122] = d['mr. mime']
d.scyther = {hp = 70, atk = 110, def = 80, spatk = 55, spdef = 80, spe = 105, spec = 55}
d[123] = d.scyther
d.jynx = {hp = 65, atk = 50, def = 35, spatk = 115, spdef = 95, spe = 95, spec = 95}
d[124] = d.jynx
d.electabuzz = {hp = 65, atk = 83, def = 57, spatk = 95, spdef = 85, spe = 105, spec = 85}
d[125] = d.electabuzz
d.magmar = {hp = 65, atk = 95, def = 57, spatk = 100, spdef = 85, spe = 93, spec = 85}
d[126] = d.magmar
d.pinsir = {hp = 65, atk = 125, def = 100, spatk = 55, spdef = 70, spe = 85, spec = 55}
d[127] = d.pinsir
d.tauros = {hp = 75, atk = 100, def = 95, spatk = 40, spdef = 70, spe = 110, spec = 70}
d[128] = d.tauros
d.magikarp = {hp = 20, atk = 10, def = 55, spatk = 15, spdef = 20, spe = 80, spec = 20}
d[129] = d.magikarp
d.gyarados = {hp = 95, atk = 125, def = 79, spatk = 60, spdef = 100, spe = 81, spec = 100}
d[130] = d.gyarados
d.lapras = {hp = 130, atk = 85, def = 80, spatk = 85, spdef = 95, spe = 60, spec = 95}
d[131] = d.lapras
d.ditto = {hp = 48, atk = 48, def = 48, spatk = 48, spdef = 48, spe = 48, spec = 48}
d[132] = d.ditto
d.eevee = {hp = 55, atk = 55, def = 50, spatk = 45, spdef = 65, spe = 55, spec = 65}
d[133] = d.eevee
d.vaporeon = {hp = 130, atk = 65, def = 60, spatk = 110, spdef = 95, spe = 65, spec = 110}
d[134] = d.vaporeon
d.jolteon = {hp = 65, atk = 65, def = 60, spatk = 110, spdef = 95, spe = 130, spec = 110}
d[135] = d.jolteon
d.flareon = {hp = 65, atk = 130, def = 60, spatk = 95, spdef = 110, spe = 65, spec = 110}
d[136] = d.flareon
d.porygon = {hp = 65, atk = 60, def = 70, spatk = 85, spdef = 75, spe = 40, spec = 75}
d[137] = d.porygon
d.omanyte = {hp = 35, atk = 40, def = 100, spatk = 90, spdef = 55, spe = 35, spec = 90}
d[138] = d.omanyte
d.omastar = {hp = 70, atk = 60, def = 125, spatk = 115, spdef = 70, spe = 55, spec = 115}
d[139] = d.omastar
d.kabuto = {hp = 30, atk = 80, def = 90, spatk = 55, spdef = 45, spe = 55, spec = 45}
d[140] = d.kabuto
d.kabutops = {hp = 60, atk = 115, def = 105, spatk = 65, spdef = 70, spe = 80, spec = 70}
d[141] = d.kabutops
d.aerodactyl = {hp = 80, atk = 105, def = 65, spatk = 60, spdef = 75, spe = 130, spec = 60}
d[142] = d.aerodactyl
d.snorlax = {hp = 160, atk = 110, def = 65, spatk = 65, spdef = 110, spe = 30, spec = 65}
d[143] = d.snorlax
d.articuno = {hp = 90, atk = 85, def = 100, spatk = 95, spdef = 125, spe = 85, spec = 125}
d[144] = d.articuno
d.zapdos = {hp = 90, atk = 90, def = 85, spatk = 125, spdef = 90, spe = 100, spec = 125}
d[145] = d.zapdos
d.moltres = {hp = 90, atk = 100, def = 90, spatk = 125, spdef = 85, spe = 90, spec = 125}
d[146] = d.moltres
d.dratini = {hp = 41, atk = 64, def = 45, spatk = 50, spdef = 50, spe = 50, spec = 50}
d[147] = d.dratini
d.dragonair = {hp = 61, atk = 84, def = 65, spatk = 70, spdef = 70, spe = 70, spec = 70}
d[148] = d.dragonair
d.dragonite = {hp = 91, atk = 134, def = 95, spatk = 100, spdef = 100, spe = 80, spec = 100}
d[149] = d.dragonite
d.mewtwo = {hp = 106, atk = 110, def = 90, spatk = 154, spdef = 90, spe = 130, spec = 154}
d[150] = d.mewtwo
d.mew = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100, spec = 100}
d[151] = d.mew
d.chikorita = {hp = 45, atk = 49, def = 65, spatk = 49, spdef = 65, spe = 45}
d[152] = d.chikorita
d.bayleef = {hp = 60, atk = 62, def = 80, spatk = 63, spdef = 80, spe = 60}
d[153] = d.bayleef
d.meganium = {hp = 80, atk = 82, def = 100, spatk = 83, spdef = 100, spe = 80}
d[154] = d.meganium
d.cyndaquil = {hp = 39, atk = 52, def = 43, spatk = 60, spdef = 50, spe = 65}
d[155] = d.cyndaquil
d.quilava = {hp = 58, atk = 64, def = 58, spatk = 80, spdef = 65, spe = 80}
d[156] = d.quilava
d.typhlosion = {hp = 78, atk = 84, def = 78, spatk = 109, spdef = 85, spe = 100}
d[157] = d.typhlosion
d.totodile = {hp = 50, atk = 65, def = 64, spatk = 44, spdef = 48, spe = 43}
d[158] = d.totodile
d.croconaw = {hp = 65, atk = 80, def = 80, spatk = 59, spdef = 63, spe = 58}
d[159] = d.croconaw
d.feraligatr = {hp = 85, atk = 105, def = 100, spatk = 79, spdef = 83, spe = 78}
d[160] = d.feraligatr
d.sentret = {hp = 35, atk = 46, def = 34, spatk = 35, spdef = 45, spe = 20}
d[161] = d.sentret
d.furret = {hp = 85, atk = 76, def = 64, spatk = 45, spdef = 55, spe = 90}
d[162] = d.furret
d.hoothoot = {hp = 60, atk = 30, def = 30, spatk = 36, spdef = 56, spe = 50}
d[163] = d.hoothoot
d.noctowl = {hp = 100, atk = 50, def = 50, spatk = {[2] = 76, [7] = 86}, spdef = 96, spe = 70}
d[164] = d.noctowl
d.ledyba = {hp = 40, atk = 20, def = 30, spatk = 40, spdef = 80, spe = 55}
d[165] = d.ledyba
d.ledian = {hp = 55, atk = 35, def = 50, spatk = 55, spdef = 110, spe = 85}
d[166] = d.ledian
d.spinarak = {hp = 40, atk = 60, def = 40, spatk = 40, spdef = 40, spe = 30}
d[167] = d.spinarak
d.ariados = {hp = 70, atk = 90, def = 70, spatk = 60, spdef = {[2] = 60, [7] = 70}, spe = 40}
d[168] = d.ariados
d.crobat = {hp = 85, atk = 90, def = 80, spatk = 70, spdef = 80, spe = 130}
d[169] = d.crobat
d.chinchou = {hp = 75, atk = 38, def = 38, spatk = 56, spdef = 56, spe = 67}
d[170] = d.chinchou
d.lanturn = {hp = 125, atk = 58, def = 58, spatk = 76, spdef = 76, spe = 67}
d[171] = d.lanturn
d.pichu = {hp = 20, atk = 40, def = 15, spatk = 35, spdef = 35, spe = 60}
d[172] = d.pichu
d.cleffa = {hp = 50, atk = 25, def = 28, spatk = 45, spdef = 55, spe = 15}
d[173] = d.cleffa
d.igglybuff = {hp = 90, atk = 30, def = 15, spatk = 40, spdef = 20, spe = 15}
d[174] = d.igglybuff
d.togepi = {hp = 35, atk = 20, def = 65, spatk = 40, spdef = 65, spe = 20}
d[175] = d.togepi
d.togetic = {hp = 55, atk = 40, def = 85, spatk = 80, spdef = 105, spe = 40}
d[176] = d.togetic
d.natu = {hp = 40, atk = 50, def = 45, spatk = 70, spdef = 45, spe = 70}
d[177] = d.natu
d.xatu = {hp = 65, atk = 75, def = 70, spatk = 95, spdef = 70, spe = 95}
d[178] = d.xatu
d.mareep = {hp = 55, atk = 40, def = 40, spatk = 65, spdef = 45, spe = 35}
d[179] = d.mareep
d.flaaffy = {hp = 70, atk = 55, def = 55, spatk = 80, spdef = 60, spe = 45}
d[180] = d.flaaffy
d.ampharos = {hp = 90, atk = 75, def = {[2] = 75, [6] = 85}, spatk = 115, spdef = 90, spe = 55}
d[181] = d.ampharos
d.bellossom = {hp = 75, atk = 80, def = {[2] = 85, [6] = 95}, spatk = 90, spdef = 100, spe = 50}
d[182] = d.bellossom
d.marill = {hp = 70, atk = 20, def = 50, spatk = 20, spdef = 50, spe = 40}
d[183] = d.marill
d.azumarill = {hp = 100, atk = 50, def = 80, spatk = {[2] = 50, [6] = 60}, spdef = 80, spe = 50}
d[184] = d.azumarill
d.sudowoodo = {hp = 70, atk = 100, def = 115, spatk = 30, spdef = 65, spe = 30}
d[185] = d.sudowoodo
d.politoed = {hp = 90, atk = 75, def = 75, spatk = 90, spdef = 100, spe = 70}
d[186] = d.politoed
d.hoppip = {hp = 35, atk = 35, def = 40, spatk = 35, spdef = 55, spe = 50}
d[187] = d.hoppip
d.skiploom = {hp = 55, atk = 45, def = 50, spatk = 45, spdef = 65, spe = 80}
d[188] = d.skiploom
d.jumpluff = {hp = 75, atk = 55, def = 70, spatk = 55, spdef = {[2] = 85, [6] = 95}, spe = 110}
d[189] = d.jumpluff
d.aipom = {hp = 55, atk = 70, def = 55, spatk = 40, spdef = 55, spe = 85}
d[190] = d.aipom
d.sunkern = {hp = 30, atk = 30, def = 30, spatk = 30, spdef = 30, spe = 30}
d[191] = d.sunkern
d.sunflora = {hp = 75, atk = 75, def = 55, spatk = 105, spdef = 85, spe = 30}
d[192] = d.sunflora
d.yanma = {hp = 65, atk = 65, def = 45, spatk = 75, spdef = 45, spe = 95}
d[193] = d.yanma
d.wooper = {hp = 55, atk = 45, def = 45, spatk = 25, spdef = 25, spe = 15}
d[194] = d.wooper
d.quagsire = {hp = 95, atk = 85, def = 85, spatk = 65, spdef = 65, spe = 35}
d[195] = d.quagsire
d.espeon = {hp = 65, atk = 65, def = 60, spatk = 130, spdef = 95, spe = 110}
d[196] = d.espeon
d.umbreon = {hp = 95, atk = 65, def = 110, spatk = 60, spdef = 130, spe = 65}
d[197] = d.umbreon
d.murkrow = {hp = 60, atk = 85, def = 42, spatk = 85, spdef = 42, spe = 91}
d[198] = d.murkrow
d.slowking = {hp = 95, atk = 75, def = 80, spatk = 100, spdef = 110, spe = 30}
d[199] = d.slowking
d.misdreavus = {hp = 60, atk = 60, def = 60, spatk = 85, spdef = 85, spe = 85}
d[200] = d.misdreavus
d.unown = {hp = 48, atk = 72, def = 48, spatk = 72, spdef = 48, spe = 48}
d[201] = d.unown
d.wobbuffet = {hp = 190, atk = 33, def = 58, spatk = 33, spdef = 58, spe = 33}
d[202] = d.wobbuffet
d.girafarig = {hp = 70, atk = 80, def = 65, spatk = 90, spdef = 65, spe = 85}
d[203] = d.girafarig
d.pineco = {hp = 50, atk = 65, def = 90, spatk = 35, spdef = 35, spe = 15}
d[204] = d.pineco
d.forretress = {hp = 75, atk = 90, def = 140, spatk = 60, spdef = 60, spe = 40}
d[205] = d.forretress
d.dunsparce = {hp = 100, atk = 70, def = 70, spatk = 65, spdef = 65, spe = 45}
d[206] = d.dunsparce
d.gligar = {hp = 65, atk = 75, def = 105, spatk = 35, spdef = 65, spe = 85}
d[207] = d.gligar
d.steelix = {hp = 75, atk = 85, def = 200, spatk = 55, spdef = 65, spe = 30}
d[208] = d.steelix
d.snubbull = {hp = 60, atk = 80, def = 50, spatk = 40, spdef = 40, spe = 30}
d[209] = d.snubbull
d.granbull = {hp = 90, atk = 120, def = 75, spatk = 60, spdef = 60, spe = 45}
d[210] = d.granbull
d.qwilfish = {hp = 65, atk = 95, def = {[2] = 75, [7] = 85}, spatk = 55, spdef = 55, spe = 85}
d[211] = d.qwilfish
d.scizor = {hp = 70, atk = 130, def = 100, spatk = 55, spdef = 80, spe = 65}
d[212] = d.scizor
d.shuckle = {hp = 20, atk = 10, def = 230, spatk = 10, spdef = 230, spe = 5}
d[213] = d.shuckle
d.heracross = {hp = 80, atk = 125, def = 75, spatk = 40, spdef = 95, spe = 85}
d[214] = d.heracross
d.sneasel = {hp = 55, atk = 95, def = 55, spatk = 35, spdef = 75, spe = 115}
d[215] = d.sneasel
d.teddiursa = {hp = 60, atk = 80, def = 50, spatk = 50, spdef = 50, spe = 40}
d[216] = d.teddiursa
d.ursaring = {hp = 90, atk = 130, def = 75, spatk = 75, spdef = 75, spe = 55}
d[217] = d.ursaring
d.slugma = {hp = 40, atk = 40, def = 40, spatk = 70, spdef = 40, spe = 20}
d[218] = d.slugma
d.magcargo = {hp = {[2] = 50, [7] = 60}, atk = 50, def = 120, spatk = {[2] = 80, [7] = 90}, spdef = 80, spe = 30}
d[219] = d.magcargo
d.swinub = {hp = 50, atk = 50, def = 40, spatk = 30, spdef = 30, spe = 50}
d[220] = d.swinub
d.piloswine = {hp = 100, atk = 100, def = 80, spatk = 60, spdef = 60, spe = 50}
d[221] = d.piloswine
d.corsola = {hp = {[2] = 55, [7] = 65}, atk = 55, def = {[2] = 85, [7] = 95}, spatk = 65, spdef = {[2] = 85, [7] = 95}, spe = 35}
d[222] = d.corsola
d.remoraid = {hp = 35, atk = 65, def = 35, spatk = 65, spdef = 35, spe = 65}
d[223] = d.remoraid
d.octillery = {hp = 75, atk = 105, def = 75, spatk = 105, spdef = 75, spe = 45}
d[224] = d.octillery
d.delibird = {hp = 45, atk = 55, def = 45, spatk = 65, spdef = 45, spe = 75}
d[225] = d.delibird
d.mantine = {hp = {[2] = 65, [7] = 85}, atk = 40, def = 70, spatk = 80, spdef = 140, spe = 70}
d[226] = d.mantine
d.skarmory = {hp = 65, atk = 80, def = 140, spatk = 40, spdef = 70, spe = 70}
d[227] = d.skarmory
d.houndour = {hp = 45, atk = 60, def = 30, spatk = 80, spdef = 50, spe = 65}
d[228] = d.houndour
d.houndoom = {hp = 75, atk = 90, def = 50, spatk = 110, spdef = 80, spe = 95}
d[229] = d.houndoom
d.kingdra = {hp = 75, atk = 95, def = 95, spatk = 95, spdef = 95, spe = 85}
d[230] = d.kingdra
d.phanpy = {hp = 90, atk = 60, def = 60, spatk = 40, spdef = 40, spe = 40}
d[231] = d.phanpy
d.donphan = {hp = 90, atk = 120, def = 120, spatk = 60, spdef = 60, spe = 50}
d[232] = d.donphan
d.porygon2 = {hp = 85, atk = 80, def = 90, spatk = 105, spdef = 95, spe = 60}
d[233] = d.porygon2
d.stantler = {hp = 73, atk = 95, def = 62, spatk = 85, spdef = 65, spe = 85}
d[234] = d.stantler
d.smeargle = {hp = 55, atk = 20, def = 35, spatk = 20, spdef = 45, spe = 75}
d[235] = d.smeargle
d.tyrogue = {hp = 35, atk = 35, def = 35, spatk = 35, spdef = 35, spe = 35}
d[236] = d.tyrogue
d.hitmontop = {hp = 50, atk = 95, def = 95, spatk = 35, spdef = 110, spe = 70}
d[237] = d.hitmontop
d.smoochum = {hp = 45, atk = 30, def = 15, spatk = 85, spdef = 65, spe = 65}
d[238] = d.smoochum
d.elekid = {hp = 45, atk = 63, def = 37, spatk = 65, spdef = 55, spe = 95}
d[239] = d.elekid
d.magby = {hp = 45, atk = 75, def = 37, spatk = 70, spdef = 55, spe = 83}
d[240] = d.magby
d.miltank = {hp = 95, atk = 80, def = 105, spatk = 40, spdef = 70, spe = 100}
d[241] = d.miltank
d.blissey = {hp = 255, atk = 10, def = 10, spatk = 75, spdef = 135, spe = 55}
d[242] = d.blissey
d.raikou = {hp = 90, atk = 85, def = 75, spatk = 115, spdef = 100, spe = 115}
d[243] = d.raikou
d.entei = {hp = 115, atk = 115, def = 85, spatk = 90, spdef = 75, spe = 100}
d[244] = d.entei
d.suicune = {hp = 100, atk = 75, def = 115, spatk = 90, spdef = 115, spe = 85}
d[245] = d.suicune
d.larvitar = {hp = 50, atk = 64, def = 50, spatk = 45, spdef = 50, spe = 41}
d[246] = d.larvitar
d.pupitar = {hp = 70, atk = 84, def = 70, spatk = 65, spdef = 70, spe = 51}
d[247] = d.pupitar
d.tyranitar = {hp = 100, atk = 134, def = 110, spatk = 95, spdef = 100, spe = 61}
d[248] = d.tyranitar
d.lugia = {hp = 106, atk = 90, def = 130, spatk = 90, spdef = 154, spe = 110}
d[249] = d.lugia
d['ho-oh'] = {hp = 106, atk = 130, def = 90, spatk = 110, spdef = 154, spe = 90}
d[250] = d['ho-oh']
d.celebi = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100}
d[251] = d.celebi
d.treecko = {hp = 40, atk = 45, def = 35, spatk = 65, spdef = 55, spe = 70}
d[252] = d.treecko
d.grovyle = {hp = 50, atk = 65, def = 45, spatk = 85, spdef = 65, spe = 95}
d[253] = d.grovyle
d.sceptile = {hp = 70, atk = 85, def = 65, spatk = 105, spdef = 85, spe = 120}
d[254] = d.sceptile
d.torchic = {hp = 45, atk = 60, def = 40, spatk = 70, spdef = 50, spe = 45}
d[255] = d.torchic
d.combusken = {hp = 60, atk = 85, def = 60, spatk = 85, spdef = 60, spe = 55}
d[256] = d.combusken
d.blaziken = {hp = 80, atk = 120, def = 70, spatk = 110, spdef = 70, spe = 80}
d[257] = d.blaziken
d.mudkip = {hp = 50, atk = 70, def = 50, spatk = 50, spdef = 50, spe = 40}
d[258] = d.mudkip
d.marshtomp = {hp = 70, atk = 85, def = 70, spatk = 60, spdef = 70, spe = 50}
d[259] = d.marshtomp
d.swampert = {hp = 100, atk = 110, def = 90, spatk = 85, spdef = 90, spe = 60}
d[260] = d.swampert
d.poochyena = {hp = 35, atk = 55, def = 35, spatk = 30, spdef = 30, spe = 35}
d[261] = d.poochyena
d.mightyena = {hp = 70, atk = 90, def = 70, spatk = 60, spdef = 60, spe = 70}
d[262] = d.mightyena
d.zigzagoon = {hp = 38, atk = 30, def = 41, spatk = 30, spdef = 41, spe = 60}
d[263] = d.zigzagoon
d.linoone = {hp = 78, atk = 70, def = 61, spatk = 50, spdef = 61, spe = 100}
d[264] = d.linoone
d.wurmple = {hp = 45, atk = 45, def = 35, spatk = 20, spdef = 30, spe = 20}
d[265] = d.wurmple
d.silcoon = {hp = 50, atk = 35, def = 55, spatk = 25, spdef = 25, spe = 15}
d[266] = d.silcoon
d.beautifly = {hp = 60, atk = 70, def = 50, spatk = {[3] = 90, [6] = 100}, spdef = 50, spe = 65}
d[267] = d.beautifly
d.cascoon = {hp = 50, atk = 35, def = 55, spatk = 25, spdef = 25, spe = 15}
d[268] = d.cascoon
d.dustox = {hp = 60, atk = 50, def = 70, spatk = 50, spdef = 90, spe = 65}
d[269] = d.dustox
d.lotad = {hp = 40, atk = 30, def = 30, spatk = 40, spdef = 50, spe = 30}
d[270] = d.lotad
d.lombre = {hp = 60, atk = 50, def = 50, spatk = 60, spdef = 70, spe = 50}
d[271] = d.lombre
d.ludicolo = {hp = 80, atk = 70, def = 70, spatk = 90, spdef = 100, spe = 70}
d[272] = d.ludicolo
d.seedot = {hp = 40, atk = 40, def = 50, spatk = 30, spdef = 30, spe = 30}
d[273] = d.seedot
d.nuzleaf = {hp = 70, atk = 70, def = 40, spatk = 60, spdef = 40, spe = 60}
d[274] = d.nuzleaf
d.shiftry = {hp = 90, atk = 100, def = 60, spatk = 90, spdef = 60, spe = 80}
d[275] = d.shiftry
d.taillow = {hp = 40, atk = 55, def = 30, spatk = 30, spdef = 30, spe = 85}
d[276] = d.taillow
d.swellow = {hp = 60, atk = 85, def = 60, spatk = {[3] = 50, [7] = 75}, spdef = 50, spe = 125}
d[277] = d.swellow
d.wingull = {hp = 40, atk = 30, def = 30, spatk = 55, spdef = 30, spe = 85}
d[278] = d.wingull
d.pelipper = {hp = 60, atk = 50, def = 100, spatk = {[3] = 85, [7] = 95}, spdef = 70, spe = 65}
d[279] = d.pelipper
d.ralts = {hp = 28, atk = 25, def = 25, spatk = 45, spdef = 35, spe = 40}
d[280] = d.ralts
d.kirlia = {hp = 38, atk = 35, def = 35, spatk = 65, spdef = 55, spe = 50}
d[281] = d.kirlia
d.gardevoir = {hp = 68, atk = 65, def = 65, spatk = 125, spdef = 115, spe = 80}
d[282] = d.gardevoir
d.surskit = {hp = 40, atk = 30, def = 32, spatk = 50, spdef = 52, spe = 65}
d[283] = d.surskit
d.masquerain = {hp = 70, atk = 60, def = 62, spatk = {[3] = 80, [7] = 100}, spdef = 82, spe = {[3] = 60, [7] = 80}}
d[284] = d.masquerain
d.shroomish = {hp = 60, atk = 40, def = 60, spatk = 40, spdef = 60, spe = 35}
d[285] = d.shroomish
d.breloom = {hp = 60, atk = 130, def = 80, spatk = 60, spdef = 60, spe = 70}
d[286] = d.breloom
d.slakoth = {hp = 60, atk = 60, def = 60, spatk = 35, spdef = 35, spe = 30}
d[287] = d.slakoth
d.vigoroth = {hp = 80, atk = 80, def = 80, spatk = 55, spdef = 55, spe = 90}
d[288] = d.vigoroth
d.slaking = {hp = 150, atk = 160, def = 100, spatk = 95, spdef = 65, spe = 100}
d[289] = d.slaking
d.nincada = {hp = 31, atk = 45, def = 90, spatk = 30, spdef = 30, spe = 40}
d[290] = d.nincada
d.ninjask = {hp = 61, atk = 90, def = 45, spatk = 50, spdef = 50, spe = 160}
d[291] = d.ninjask
d.shedinja = {hp = 1, atk = 90, def = 45, spatk = 30, spdef = 30, spe = 40}
d[292] = d.shedinja
d.whismur = {hp = 64, atk = 51, def = 23, spatk = 51, spdef = 23, spe = 28}
d[293] = d.whismur
d.loudred = {hp = 84, atk = 71, def = 43, spatk = 71, spdef = 43, spe = 48}
d[294] = d.loudred
d.exploud = {hp = 104, atk = 91, def = 63, spatk = 91, spdef = {[3] = 63, [6] = 73}, spe = 68}
d[295] = d.exploud
d.makuhita = {hp = 72, atk = 60, def = 30, spatk = 20, spdef = 30, spe = 25}
d[296] = d.makuhita
d.hariyama = {hp = 144, atk = 120, def = 60, spatk = 40, spdef = 60, spe = 50}
d[297] = d.hariyama
d.azurill = {hp = 50, atk = 20, def = 40, spatk = 20, spdef = 40, spe = 20}
d[298] = d.azurill
d.nosepass = {hp = 30, atk = 45, def = 135, spatk = 45, spdef = 90, spe = 30}
d[299] = d.nosepass
d.skitty = {hp = 50, atk = 45, def = 45, spatk = 35, spdef = 35, spe = 50}
d[300] = d.skitty
d.delcatty = {hp = 70, atk = 65, def = 65, spatk = 55, spdef = 55, spe = {[3] = 70, [7] = 90}}
d[301] = d.delcatty
d.sableye = {hp = 50, atk = 75, def = 75, spatk = 65, spdef = 65, spe = 50}
d[302] = d.sableye
d.mawile = {hp = 50, atk = 85, def = 85, spatk = 55, spdef = 55, spe = 50}
d[303] = d.mawile
d.aron = {hp = 50, atk = 70, def = 100, spatk = 40, spdef = 40, spe = 30}
d[304] = d.aron
d.lairon = {hp = 60, atk = 90, def = 140, spatk = 50, spdef = 50, spe = 40}
d[305] = d.lairon
d.aggron = {hp = 70, atk = 110, def = 180, spatk = 60, spdef = 60, spe = 50}
d[306] = d.aggron
d.meditite = {hp = 30, atk = 40, def = 55, spatk = 40, spdef = 55, spe = 60}
d[307] = d.meditite
d.medicham = {hp = 60, atk = 60, def = 75, spatk = 60, spdef = 75, spe = 80}
d[308] = d.medicham
d.electrike = {hp = 40, atk = 45, def = 40, spatk = 65, spdef = 40, spe = 65}
d[309] = d.electrike
d.manectric = {hp = 70, atk = 75, def = 60, spatk = 105, spdef = 60, spe = 105}
d[310] = d.manectric
d.plusle = {hp = 60, atk = 50, def = 40, spatk = 85, spdef = 75, spe = 95}
d[311] = d.plusle
d.minun = {hp = 60, atk = 40, def = 50, spatk = 75, spdef = 85, spe = 95}
d[312] = d.minun
d.volbeat = {hp = 65, atk = 73, def = {[3] = 55, [7] = 75}, spatk = 47, spdef = {[3] = 75, [7] = 85}, spe = 85}
d[313] = d.volbeat
d.illumise = {hp = 65, atk = 47, def = {[3] = 55, [7] = 75}, spatk = 73, spdef = {[3] = 75, [7] = 85}, spe = 85}
d[314] = d.illumise
d.roselia = {hp = 50, atk = 60, def = 45, spatk = 100, spdef = 80, spe = 65}
d[315] = d.roselia
d.gulpin = {hp = 70, atk = 43, def = 53, spatk = 43, spdef = 53, spe = 40}
d[316] = d.gulpin
d.swalot = {hp = 100, atk = 73, def = 83, spatk = 73, spdef = 83, spe = 55}
d[317] = d.swalot
d.carvanha = {hp = 45, atk = 90, def = 20, spatk = 65, spdef = 20, spe = 65}
d[318] = d.carvanha
d.sharpedo = {hp = 70, atk = 120, def = 40, spatk = 95, spdef = 40, spe = 95}
d[319] = d.sharpedo
d.wailmer = {hp = 130, atk = 70, def = 35, spatk = 70, spdef = 35, spe = 60}
d[320] = d.wailmer
d.wailord = {hp = 170, atk = 90, def = 45, spatk = 90, spdef = 45, spe = 60}
d[321] = d.wailord
d.numel = {hp = 60, atk = 60, def = 40, spatk = 65, spdef = 45, spe = 35}
d[322] = d.numel
d.camerupt = {hp = 70, atk = 100, def = 70, spatk = 105, spdef = 75, spe = 40}
d[323] = d.camerupt
d.torkoal = {hp = 70, atk = 85, def = 140, spatk = 85, spdef = 70, spe = 20}
d[324] = d.torkoal
d.spoink = {hp = 60, atk = 25, def = 35, spatk = 70, spdef = 80, spe = 60}
d[325] = d.spoink
d.grumpig = {hp = 80, atk = 45, def = 65, spatk = 90, spdef = 110, spe = 80}
d[326] = d.grumpig
d.spinda = {hp = 60, atk = 60, def = 60, spatk = 60, spdef = 60, spe = 60}
d[327] = d.spinda
d.trapinch = {hp = 45, atk = 100, def = 45, spatk = 45, spdef = 45, spe = 10}
d[328] = d.trapinch
d.vibrava = {hp = 50, atk = 70, def = 50, spatk = 50, spdef = 50, spe = 70}
d[329] = d.vibrava
d.flygon = {hp = 80, atk = 100, def = 80, spatk = 80, spdef = 80, spe = 100}
d[330] = d.flygon
d.cacnea = {hp = 50, atk = 85, def = 40, spatk = 85, spdef = 40, spe = 35}
d[331] = d.cacnea
d.cacturne = {hp = 70, atk = 115, def = 60, spatk = 115, spdef = 60, spe = 55}
d[332] = d.cacturne
d.swablu = {hp = 45, atk = 40, def = 60, spatk = 40, spdef = 75, spe = 50}
d[333] = d.swablu
d.altaria = {hp = 75, atk = 70, def = 90, spatk = 70, spdef = 105, spe = 80}
d[334] = d.altaria
d.zangoose = {hp = 73, atk = 115, def = 60, spatk = 60, spdef = 60, spe = 90}
d[335] = d.zangoose
d.seviper = {hp = 73, atk = 100, def = 60, spatk = 100, spdef = 60, spe = 65}
d[336] = d.seviper
d.lunatone = {hp = {[3] = 70, [7] = 90}, atk = 55, def = 65, spatk = 95, spdef = 85, spe = 70}
d[337] = d.lunatone
d.solrock = {hp = {[3] = 70, [7] = 90}, atk = 95, def = 85, spatk = 55, spdef = 65, spe = 70}
d[338] = d.solrock
d.barboach = {hp = 50, atk = 48, def = 43, spatk = 46, spdef = 41, spe = 60}
d[339] = d.barboach
d.whiscash = {hp = 110, atk = 78, def = 73, spatk = 76, spdef = 71, spe = 60}
d[340] = d.whiscash
d.corphish = {hp = 43, atk = 80, def = 65, spatk = 50, spdef = 35, spe = 35}
d[341] = d.corphish
d.crawdaunt = {hp = 63, atk = 120, def = 85, spatk = 90, spdef = 55, spe = 55}
d[342] = d.crawdaunt
d.baltoy = {hp = 40, atk = 40, def = 55, spatk = 40, spdef = 70, spe = 55}
d[343] = d.baltoy
d.claydol = {hp = 60, atk = 70, def = 105, spatk = 70, spdef = 120, spe = 75}
d[344] = d.claydol
d.lileep = {hp = 66, atk = 41, def = 77, spatk = 61, spdef = 87, spe = 23}
d[345] = d.lileep
d.cradily = {hp = 86, atk = 81, def = 97, spatk = 81, spdef = 107, spe = 43}
d[346] = d.cradily
d.anorith = {hp = 45, atk = 95, def = 50, spatk = 40, spdef = 50, spe = 75}
d[347] = d.anorith
d.armaldo = {hp = 75, atk = 125, def = 100, spatk = 70, spdef = 80, spe = 45}
d[348] = d.armaldo
d.feebas = {hp = 20, atk = 15, def = 20, spatk = 10, spdef = 55, spe = 80}
d[349] = d.feebas
d.milotic = {hp = 95, atk = 60, def = 79, spatk = 100, spdef = 125, spe = 81}
d[350] = d.milotic
d.castform = {hp = 70, atk = 70, def = 70, spatk = 70, spdef = 70, spe = 70}
d[351] = d.castform
d.kecleon = {hp = 60, atk = 90, def = 70, spatk = 60, spdef = 120, spe = 40}
d[352] = d.kecleon
d.shuppet = {hp = 44, atk = 75, def = 35, spatk = 63, spdef = 33, spe = 45}
d[353] = d.shuppet
d.banette = {hp = 64, atk = 115, def = 65, spatk = 83, spdef = 63, spe = 65}
d[354] = d.banette
d.duskull = {hp = 20, atk = 40, def = 90, spatk = 30, spdef = 90, spe = 25}
d[355] = d.duskull
d.dusclops = {hp = 40, atk = 70, def = 130, spatk = 60, spdef = 130, spe = 25}
d[356] = d.dusclops
d.tropius = {hp = 99, atk = 68, def = 83, spatk = 72, spdef = 87, spe = 51}
d[357] = d.tropius
d.chimecho = {hp = {[3] = 65, [7] = 75}, atk = 50, def = {[3] = 70, [7] = 80}, spatk = 95, spdef = {[3] = 80, [7] = 90}, spe = 65}
d[358] = d.chimecho
d.absol = {hp = 65, atk = 130, def = 60, spatk = 75, spdef = 60, spe = 75}
d[359] = d.absol
d.wynaut = {hp = 95, atk = 23, def = 48, spatk = 23, spdef = 48, spe = 23}
d[360] = d.wynaut
d.snorunt = {hp = 50, atk = 50, def = 50, spatk = 50, spdef = 50, spe = 50}
d[361] = d.snorunt
d.glalie = {hp = 80, atk = 80, def = 80, spatk = 80, spdef = 80, spe = 80}
d[362] = d.glalie
d.spheal = {hp = 70, atk = 40, def = 50, spatk = 55, spdef = 50, spe = 25}
d[363] = d.spheal
d.sealeo = {hp = 90, atk = 60, def = 70, spatk = 75, spdef = 70, spe = 45}
d[364] = d.sealeo
d.walrein = {hp = 110, atk = 80, def = 90, spatk = 95, spdef = 90, spe = 65}
d[365] = d.walrein
d.clamperl = {hp = 35, atk = 64, def = 85, spatk = 74, spdef = 55, spe = 32}
d[366] = d.clamperl
d.huntail = {hp = 55, atk = 104, def = 105, spatk = 94, spdef = 75, spe = 52}
d[367] = d.huntail
d.gorebyss = {hp = 55, atk = 84, def = 105, spatk = 114, spdef = 75, spe = 52}
d[368] = d.gorebyss
d.relicanth = {hp = 100, atk = 90, def = 130, spatk = 45, spdef = 65, spe = 55}
d[369] = d.relicanth
d.luvdisc = {hp = 43, atk = 30, def = 55, spatk = 40, spdef = 65, spe = 97}
d[370] = d.luvdisc
d.bagon = {hp = 45, atk = 75, def = 60, spatk = 40, spdef = 30, spe = 50}
d[371] = d.bagon
d.shelgon = {hp = 65, atk = 95, def = 100, spatk = 60, spdef = 50, spe = 50}
d[372] = d.shelgon
d.salamence = {hp = 95, atk = 135, def = 80, spatk = 110, spdef = 80, spe = 100}
d[373] = d.salamence
d.beldum = {hp = 40, atk = 55, def = 80, spatk = 35, spdef = 60, spe = 30}
d[374] = d.beldum
d.metang = {hp = 60, atk = 75, def = 100, spatk = 55, spdef = 80, spe = 50}
d[375] = d.metang
d.metagross = {hp = 80, atk = 135, def = 130, spatk = 95, spdef = 90, spe = 70}
d[376] = d.metagross
d.regirock = {hp = 80, atk = 100, def = 200, spatk = 50, spdef = 100, spe = 50}
d[377] = d.regirock
d.regice = {hp = 80, atk = 50, def = 100, spatk = 100, spdef = 200, spe = 50}
d[378] = d.regice
d.registeel = {hp = 80, atk = 75, def = 150, spatk = 75, spdef = 150, spe = 50}
d[379] = d.registeel
d.latias = {hp = 80, atk = 80, def = 90, spatk = 110, spdef = 130, spe = 110}
d[380] = d.latias
d.latios = {hp = 80, atk = 90, def = 80, spatk = 130, spdef = 110, spe = 110}
d[381] = d.latios
d.kyogre = {hp = 100, atk = 100, def = 90, spatk = 150, spdef = 140, spe = 90}
d[382] = d.kyogre
d.groudon = {hp = 100, atk = 150, def = 140, spatk = 100, spdef = 90, spe = 90}
d[383] = d.groudon
d.rayquaza = {hp = 105, atk = 150, def = 90, spatk = 150, spdef = 90, spe = 95}
d[384] = d.rayquaza
d.jirachi = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100}
d[385] = d.jirachi
d.deoxys = {hp = 50, atk = 150, def = 50, spatk = 150, spdef = 50, spe = 150}
d[386] = d.deoxys
d.turtwig = {hp = 55, atk = 68, def = 64, spatk = 45, spdef = 55, spe = 31}
d[387] = d.turtwig
d.grotle = {hp = 75, atk = 89, def = 85, spatk = 55, spdef = 65, spe = 36}
d[388] = d.grotle
d.torterra = {hp = 95, atk = 109, def = 105, spatk = 75, spdef = 85, spe = 56}
d[389] = d.torterra
d.chimchar = {hp = 44, atk = 58, def = 44, spatk = 58, spdef = 44, spe = 61}
d[390] = d.chimchar
d.monferno = {hp = 64, atk = 78, def = 52, spatk = 78, spdef = 52, spe = 81}
d[391] = d.monferno
d.infernape = {hp = 76, atk = 104, def = 71, spatk = 104, spdef = 71, spe = 108}
d[392] = d.infernape
d.piplup = {hp = 53, atk = 51, def = 53, spatk = 61, spdef = 56, spe = 40}
d[393] = d.piplup
d.prinplup = {hp = 64, atk = 66, def = 68, spatk = 81, spdef = 76, spe = 50}
d[394] = d.prinplup
d.empoleon = {hp = 84, atk = 86, def = 88, spatk = 111, spdef = 101, spe = 60}
d[395] = d.empoleon
d.starly = {hp = 40, atk = 55, def = 30, spatk = 30, spdef = 30, spe = 60}
d[396] = d.starly
d.staravia = {hp = 55, atk = 75, def = 50, spatk = 40, spdef = 40, spe = 80}
d[397] = d.staravia
d.staraptor = {hp = 85, atk = 120, def = 70, spatk = 50, spdef = {[4] = 50, [6] = 60}, spe = 100}
d[398] = d.staraptor
d.bidoof = {hp = 59, atk = 45, def = 40, spatk = 35, spdef = 40, spe = 31}
d[399] = d.bidoof
d.bibarel = {hp = 79, atk = 85, def = 60, spatk = 55, spdef = 60, spe = 71}
d[400] = d.bibarel
d.kricketot = {hp = 37, atk = 25, def = 41, spatk = 25, spdef = 41, spe = 25}
d[401] = d.kricketot
d.kricketune = {hp = 77, atk = 85, def = 51, spatk = 55, spdef = 51, spe = 65}
d[402] = d.kricketune
d.shinx = {hp = 45, atk = 65, def = 34, spatk = 40, spdef = 34, spe = 45}
d[403] = d.shinx
d.luxio = {hp = 60, atk = 85, def = 49, spatk = 60, spdef = 49, spe = 60}
d[404] = d.luxio
d.luxray = {hp = 80, atk = 120, def = 79, spatk = 95, spdef = 79, spe = 70}
d[405] = d.luxray
d.budew = {hp = 40, atk = 30, def = 35, spatk = 50, spdef = 70, spe = 55}
d[406] = d.budew
d.roserade = {hp = 60, atk = 70, def = {[4] = 55, [6] = 65}, spatk = 125, spdef = 105, spe = 90}
d[407] = d.roserade
d.cranidos = {hp = 67, atk = 125, def = 40, spatk = 30, spdef = 30, spe = 58}
d[408] = d.cranidos
d.rampardos = {hp = 97, atk = 165, def = 60, spatk = 65, spdef = 50, spe = 58}
d[409] = d.rampardos
d.shieldon = {hp = 30, atk = 42, def = 118, spatk = 42, spdef = 88, spe = 30}
d[410] = d.shieldon
d.bastiodon = {hp = 60, atk = 52, def = 168, spatk = 47, spdef = 138, spe = 30}
d[411] = d.bastiodon
d.burmy = {hp = 40, atk = 29, def = 45, spatk = 29, spdef = 45, spe = 36}
d[412] = d.burmy
d.wormadam = {hp = 60, atk = 59, def = 85, spatk = 79, spdef = 105, spe = 36}
d[413] = d.wormadam
d.mothim = {hp = 70, atk = 94, def = 50, spatk = 94, spdef = 50, spe = 66}
d[414] = d.mothim
d.combee = {hp = 30, atk = 30, def = 42, spatk = 30, spdef = 42, spe = 70}
d[415] = d.combee
d.vespiquen = {hp = 70, atk = 80, def = 102, spatk = 80, spdef = 102, spe = 40}
d[416] = d.vespiquen
d.pachirisu = {hp = 60, atk = 45, def = 70, spatk = 45, spdef = 90, spe = 95}
d[417] = d.pachirisu
d.buizel = {hp = 55, atk = 65, def = 35, spatk = 60, spdef = 30, spe = 85}
d[418] = d.buizel
d.floatzel = {hp = 85, atk = 105, def = 55, spatk = 85, spdef = 50, spe = 115}
d[419] = d.floatzel
d.cherubi = {hp = 45, atk = 35, def = 45, spatk = 62, spdef = 53, spe = 35}
d[420] = d.cherubi
d.cherrim = {hp = 70, atk = 60, def = 70, spatk = 87, spdef = 78, spe = 85}
d[421] = d.cherrim
d.shellos = {hp = 76, atk = 48, def = 48, spatk = 57, spdef = 62, spe = 34}
d[422] = d.shellos
d.gastrodon = {hp = 111, atk = 83, def = 68, spatk = 92, spdef = 82, spe = 39}
d[423] = d.gastrodon
d.ambipom = {hp = 75, atk = 100, def = 66, spatk = 60, spdef = 66, spe = 115}
d[424] = d.ambipom
d.drifloon = {hp = 90, atk = 50, def = 34, spatk = 60, spdef = 44, spe = 70}
d[425] = d.drifloon
d.drifblim = {hp = 150, atk = 80, def = 44, spatk = 90, spdef = 54, spe = 80}
d[426] = d.drifblim
d.buneary = {hp = 55, atk = 66, def = 44, spatk = 44, spdef = 56, spe = 85}
d[427] = d.buneary
d.lopunny = {hp = 65, atk = 76, def = 84, spatk = 54, spdef = 96, spe = 105}
d[428] = d.lopunny
d.mismagius = {hp = 60, atk = 60, def = 60, spatk = 105, spdef = 105, spe = 105}
d[429] = d.mismagius
d.honchkrow = {hp = 100, atk = 125, def = 52, spatk = 105, spdef = 52, spe = 71}
d[430] = d.honchkrow
d.glameow = {hp = 49, atk = 55, def = 42, spatk = 42, spdef = 37, spe = 85}
d[431] = d.glameow
d.purugly = {hp = 71, atk = 82, def = 64, spatk = 64, spdef = 59, spe = 112}
d[432] = d.purugly
d.chingling = {hp = 45, atk = 30, def = 50, spatk = 65, spdef = 50, spe = 45}
d[433] = d.chingling
d.stunky = {hp = 63, atk = 63, def = 47, spatk = 41, spdef = 41, spe = 74}
d[434] = d.stunky
d.skuntank = {hp = 103, atk = 93, def = 67, spatk = 71, spdef = 61, spe = 84}
d[435] = d.skuntank
d.bronzor = {hp = 57, atk = 24, def = 86, spatk = 24, spdef = 86, spe = 23}
d[436] = d.bronzor
d.bronzong = {hp = 67, atk = 89, def = 116, spatk = 79, spdef = 116, spe = 33}
d[437] = d.bronzong
d.bonsly = {hp = 50, atk = 80, def = 95, spatk = 10, spdef = 45, spe = 10}
d[438] = d.bonsly
d['mime jr.'] = {hp = 20, atk = 25, def = 45, spatk = 70, spdef = 90, spe = 60}
d[439] = d['mime jr.']
d.happiny = {hp = 100, atk = 5, def = 5, spatk = 15, spdef = 65, spe = 30}
d[440] = d.happiny
d.chatot = {hp = 76, atk = 65, def = 45, spatk = 92, spdef = 42, spe = 91}
d[441] = d.chatot
d.spiritomb = {hp = 50, atk = 92, def = 108, spatk = 92, spdef = 108, spe = 35}
d[442] = d.spiritomb
d.gible = {hp = 58, atk = 70, def = 45, spatk = 40, spdef = 45, spe = 42}
d[443] = d.gible
d.gabite = {hp = 68, atk = 90, def = 65, spatk = 50, spdef = 55, spe = 82}
d[444] = d.gabite
d.garchomp = {hp = 108, atk = 130, def = 95, spatk = 80, spdef = 85, spe = 102}
d[445] = d.garchomp
d.munchlax = {hp = 135, atk = 85, def = 40, spatk = 40, spdef = 85, spe = 5}
d[446] = d.munchlax
d.riolu = {hp = 40, atk = 70, def = 40, spatk = 35, spdef = 40, spe = 60}
d[447] = d.riolu
d.lucario = {hp = 70, atk = 110, def = 70, spatk = 115, spdef = 70, spe = 90}
d[448] = d.lucario
d.hippopotas = {hp = 68, atk = 72, def = 78, spatk = 38, spdef = 42, spe = 32}
d[449] = d.hippopotas
d.hippowdon = {hp = 108, atk = 112, def = 118, spatk = 68, spdef = 72, spe = 47}
d[450] = d.hippowdon
d.skorupi = {hp = 40, atk = 50, def = 90, spatk = 30, spdef = 55, spe = 65}
d[451] = d.skorupi
d.drapion = {hp = 70, atk = 90, def = 110, spatk = 60, spdef = 75, spe = 95}
d[452] = d.drapion
d.croagunk = {hp = 48, atk = 61, def = 40, spatk = 61, spdef = 40, spe = 50}
d[453] = d.croagunk
d.toxicroak = {hp = 83, atk = 106, def = 65, spatk = 86, spdef = 65, spe = 85}
d[454] = d.toxicroak
d.carnivine = {hp = 74, atk = 100, def = 72, spatk = 90, spdef = 72, spe = 46}
d[455] = d.carnivine
d.finneon = {hp = 49, atk = 49, def = 56, spatk = 49, spdef = 61, spe = 66}
d[456] = d.finneon
d.lumineon = {hp = 69, atk = 69, def = 76, spatk = 69, spdef = 86, spe = 91}
d[457] = d.lumineon
d.mantyke = {hp = 45, atk = 20, def = 50, spatk = 60, spdef = 120, spe = 50}
d[458] = d.mantyke
d.snover = {hp = 60, atk = 62, def = 50, spatk = 62, spdef = 60, spe = 40}
d[459] = d.snover
d.abomasnow = {hp = 90, atk = 92, def = 75, spatk = 92, spdef = 85, spe = 60}
d[460] = d.abomasnow
d.weavile = {hp = 70, atk = 120, def = 65, spatk = 45, spdef = 85, spe = 125}
d[461] = d.weavile
d.magnezone = {hp = 70, atk = 70, def = 115, spatk = 130, spdef = 90, spe = 60}
d[462] = d.magnezone
d.lickilicky = {hp = 110, atk = 85, def = 95, spatk = 80, spdef = 95, spe = 50}
d[463] = d.lickilicky
d.rhyperior = {hp = 115, atk = 140, def = 130, spatk = 55, spdef = 55, spe = 40}
d[464] = d.rhyperior
d.tangrowth = {hp = 100, atk = 100, def = 125, spatk = 110, spdef = 50, spe = 50}
d[465] = d.tangrowth
d.electivire = {hp = 75, atk = 123, def = 67, spatk = 95, spdef = 85, spe = 95}
d[466] = d.electivire
d.magmortar = {hp = 75, atk = 95, def = 67, spatk = 125, spdef = 95, spe = 83}
d[467] = d.magmortar
d.togekiss = {hp = 85, atk = 50, def = 95, spatk = 120, spdef = 115, spe = 80}
d[468] = d.togekiss
d.yanmega = {hp = 86, atk = 76, def = 86, spatk = 116, spdef = 56, spe = 95}
d[469] = d.yanmega
d.leafeon = {hp = 65, atk = 110, def = 130, spatk = 60, spdef = 65, spe = 95}
d[470] = d.leafeon
d.glaceon = {hp = 65, atk = 60, def = 110, spatk = 130, spdef = 95, spe = 65}
d[471] = d.glaceon
d.gliscor = {hp = 75, atk = 95, def = 125, spatk = 45, spdef = 75, spe = 95}
d[472] = d.gliscor
d.mamoswine = {hp = 110, atk = 130, def = 80, spatk = 70, spdef = 60, spe = 80}
d[473] = d.mamoswine
d['porygon-z'] = {hp = 85, atk = 80, def = 70, spatk = 135, spdef = 75, spe = 90}
d[474] = d['porygon-z']
d.gallade = {hp = 68, atk = 125, def = 65, spatk = 65, spdef = 115, spe = 80}
d[475] = d.gallade
d.probopass = {hp = 60, atk = 55, def = 145, spatk = 75, spdef = 150, spe = 40}
d[476] = d.probopass
d.dusknoir = {hp = 45, atk = 100, def = 135, spatk = 65, spdef = 135, spe = 45}
d[477] = d.dusknoir
d.froslass = {hp = 70, atk = 80, def = 70, spatk = 80, spdef = 70, spe = 110}
d[478] = d.froslass
d.rotom = {hp = 50, atk = 50, def = 77, spatk = 95, spdef = 77, spe = 91}
d[479] = d.rotom
d.uxie = {hp = 75, atk = 75, def = 130, spatk = 75, spdef = 130, spe = 95}
d[480] = d.uxie
d.mesprit = {hp = 80, atk = 105, def = 105, spatk = 105, spdef = 105, spe = 80}
d[481] = d.mesprit
d.azelf = {hp = 75, atk = 125, def = 70, spatk = 125, spdef = 70, spe = 115}
d[482] = d.azelf
d.dialga = {hp = 100, atk = 120, def = 120, spatk = 150, spdef = 100, spe = 90}
d[483] = d.dialga
d.palkia = {hp = 90, atk = 120, def = 100, spatk = 150, spdef = 120, spe = 100}
d[484] = d.palkia
d.heatran = {hp = 91, atk = 90, def = 106, spatk = 130, spdef = 106, spe = 77}
d[485] = d.heatran
d.regigigas = {hp = 110, atk = 160, def = 110, spatk = 80, spdef = 110, spe = 100}
d[486] = d.regigigas
d.giratina = {hp = 150, atk = 100, def = 120, spatk = 100, spdef = 120, spe = 90}
d[487] = d.giratina
d.cresselia = {hp = 120, atk = 70, def = 120, spatk = 75, spdef = 130, spe = 85}
d[488] = d.cresselia
d.phione = {hp = 80, atk = 80, def = 80, spatk = 80, spdef = 80, spe = 80}
d[489] = d.phione
d.manaphy = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100}
d[490] = d.manaphy
d.darkrai = {hp = 70, atk = 90, def = 90, spatk = 135, spdef = 90, spe = 125}
d[491] = d.darkrai
d.shaymin = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100}
d[492] = d.shaymin
d.arceus = {hp = 120, atk = 120, def = 120, spatk = 120, spdef = 120, spe = 120}
d[493] = d.arceus
d.victini = {hp = 100, atk = 100, def = 100, spatk = 100, spdef = 100, spe = 100}
d[494] = d.victini
d.snivy = {hp = 45, atk = 45, def = 55, spatk = 45, spdef = 55, spe = 63}
d[495] = d.snivy
d.servine = {hp = 60, atk = 60, def = 75, spatk = 60, spdef = 75, spe = 83}
d[496] = d.servine
d.serperior = {hp = 75, atk = 75, def = 95, spatk = 75, spdef = 95, spe = 113}
d[497] = d.serperior
d.tepig = {hp = 65, atk = 63, def = 45, spatk = 45, spdef = 45, spe = 45}
d[498] = d.tepig
d.pignite = {hp = 90, atk = 93, def = 55, spatk = 70, spdef = 55, spe = 55}
d[499] = d.pignite
d.emboar = {hp = 110, atk = 123, def = 65, spatk = 100, spdef = 65, spe = 65}
d[500] = d.emboar
d.oshawott = {hp = 55, atk = 55, def = 45, spatk = 63, spdef = 45, spe = 45}
d[501] = d.oshawott
d.dewott = {hp = 75, atk = 75, def = 60, spatk = 83, spdef = 60, spe = 60}
d[502] = d.dewott
d.samurott = {hp = 95, atk = 100, def = 85, spatk = 108, spdef = 70, spe = 70}
d[503] = d.samurott
d.patrat = {hp = 45, atk = 55, def = 39, spatk = 35, spdef = 39, spe = 42}
d[504] = d.patrat
d.watchog = {hp = 60, atk = 85, def = 69, spatk = 60, spdef = 69, spe = 77}
d[505] = d.watchog
d.lillipup = {hp = 45, atk = 60, def = 45, spatk = 25, spdef = 45, spe = 55}
d[506] = d.lillipup
d.herdier = {hp = 65, atk = 80, def = 65, spatk = 35, spdef = 65, spe = 60}
d[507] = d.herdier
d.stoutland = {hp = 85, atk = {[5] = 100, [6] = 110}, def = 90, spatk = 45, spdef = 90, spe = 80}
d[508] = d.stoutland
d.purrloin = {hp = 41, atk = 50, def = 37, spatk = 50, spdef = 37, spe = 66}
d[509] = d.purrloin
d.liepard = {hp = 64, atk = 88, def = 50, spatk = 88, spdef = 50, spe = 106}
d[510] = d.liepard
d.pansage = {hp = 50, atk = 53, def = 48, spatk = 53, spdef = 48, spe = 64}
d[511] = d.pansage
d.simisage = {hp = 75, atk = 98, def = 63, spatk = 98, spdef = 63, spe = 101}
d[512] = d.simisage
d.pansear = {hp = 50, atk = 53, def = 48, spatk = 53, spdef = 48, spe = 64}
d[513] = d.pansear
d.simisear = {hp = 75, atk = 98, def = 63, spatk = 98, spdef = 63, spe = 101}
d[514] = d.simisear
d.panpour = {hp = 50, atk = 53, def = 48, spatk = 53, spdef = 48, spe = 64}
d[515] = d.panpour
d.simipour = {hp = 75, atk = 98, def = 63, spatk = 98, spdef = 63, spe = 101}
d[516] = d.simipour
d.munna = {hp = 76, atk = 25, def = 45, spatk = 67, spdef = 55, spe = 24}
d[517] = d.munna
d.musharna = {hp = 116, atk = 55, def = 85, spatk = 107, spdef = 95, spe = 29}
d[518] = d.musharna
d.pidove = {hp = 50, atk = 55, def = 50, spatk = 36, spdef = 30, spe = 43}
d[519] = d.pidove
d.tranquill = {hp = 62, atk = 77, def = 62, spatk = 50, spdef = 42, spe = 65}
d[520] = d.tranquill
d.unfezant = {hp = 80, atk = {[5] = 105, [6] = 115}, def = 80, spatk = 65, spdef = 55, spe = 93}
d[521] = d.unfezant
d.blitzle = {hp = 45, atk = 60, def = 32, spatk = 50, spdef = 32, spe = 76}
d[522] = d.blitzle
d.zebstrika = {hp = 75, atk = 100, def = 63, spatk = 80, spdef = 63, spe = 116}
d[523] = d.zebstrika
d.roggenrola = {hp = 55, atk = 75, def = 85, spatk = 25, spdef = 25, spe = 15}
d[524] = d.roggenrola
d.boldore = {hp = 70, atk = 105, def = 105, spatk = 50, spdef = 40, spe = 20}
d[525] = d.boldore
d.gigalith = {hp = 85, atk = 135, def = 130, spatk = 60, spdef = {[5] = 70, [6] = 80}, spe = 25}
d[526] = d.gigalith
d.woobat = {hp = {[5] = 55, [7] = 65}, atk = 45, def = 43, spatk = 55, spdef = 43, spe = 72}
d[527] = d.woobat
d.swoobat = {hp = 67, atk = 57, def = 55, spatk = 77, spdef = 55, spe = 114}
d[528] = d.swoobat
d.drilbur = {hp = 60, atk = 85, def = 40, spatk = 30, spdef = 45, spe = 68}
d[529] = d.drilbur
d.excadrill = {hp = 110, atk = 135, def = 60, spatk = 50, spdef = 65, spe = 88}
d[530] = d.excadrill
d.audino = {hp = 103, atk = 60, def = 86, spatk = 60, spdef = 86, spe = 50}
d[531] = d.audino
d.timburr = {hp = 75, atk = 80, def = 55, spatk = 25, spdef = 35, spe = 35}
d[532] = d.timburr
d.gurdurr = {hp = 85, atk = 105, def = 85, spatk = 40, spdef = 50, spe = 40}
d[533] = d.gurdurr
d.conkeldurr = {hp = 105, atk = 140, def = 95, spatk = 55, spdef = 65, spe = 45}
d[534] = d.conkeldurr
d.tympole = {hp = 50, atk = 50, def = 40, spatk = 50, spdef = 40, spe = 64}
d[535] = d.tympole
d.palpitoad = {hp = 75, atk = 65, def = 55, spatk = 65, spdef = 55, spe = 69}
d[536] = d.palpitoad
d.seismitoad = {hp = 105, atk = {[5] = 85, [6] = 95}, def = 75, spatk = 85, spdef = 75, spe = 74}
d[537] = d.seismitoad
d.throh = {hp = 120, atk = 100, def = 85, spatk = 30, spdef = 85, spe = 45}
d[538] = d.throh
d.sawk = {hp = 75, atk = 125, def = 75, spatk = 30, spdef = 75, spe = 85}
d[539] = d.sawk
d.sewaddle = {hp = 45, atk = 53, def = 70, spatk = 40, spdef = 60, spe = 42}
d[540] = d.sewaddle
d.swadloon = {hp = 55, atk = 63, def = 90, spatk = 50, spdef = 80, spe = 42}
d[541] = d.swadloon
d.leavanny = {hp = 75, atk = 103, def = 80, spatk = 70, spdef = {[5] = 70, [6] = 80}, spe = 92}
d[542] = d.leavanny
d.venipede = {hp = 30, atk = 45, def = 59, spatk = 30, spdef = 39, spe = 57}
d[543] = d.venipede
d.whirlipede = {hp = 40, atk = 55, def = 99, spatk = 40, spdef = 79, spe = 47}
d[544] = d.whirlipede
d.scolipede = {hp = 60, atk = {[5] = 90, [6] = 100}, def = 89, spatk = 55, spdef = 69, spe = 112}
d[545] = d.scolipede
d.cottonee = {hp = 40, atk = 27, def = 60, spatk = 37, spdef = 50, spe = 66}
d[546] = d.cottonee
d.whimsicott = {hp = 60, atk = 67, def = 85, spatk = 77, spdef = 75, spe = 116}
d[547] = d.whimsicott
d.petilil = {hp = 45, atk = 35, def = 50, spatk = 70, spdef = 50, spe = 30}
d[548] = d.petilil
d.lilligant = {hp = 70, atk = 60, def = 75, spatk = 110, spdef = 75, spe = 90}
d[549] = d.lilligant
d.basculin = {hp = 70, atk = 92, def = 65, spatk = 80, spdef = 55, spe = 98}
d[550] = d.basculin
d.sandile = {hp = 50, atk = 72, def = 35, spatk = 35, spdef = 35, spe = 65}
d[551] = d.sandile
d.krokorok = {hp = 60, atk = 82, def = 45, spatk = 45, spdef = 45, spe = 74}
d[552] = d.krokorok
d.krookodile = {hp = 95, atk = 117, def = {[5] = 70, [6] = 80}, spatk = 65, spdef = 70, spe = 92}
d[553] = d.krookodile
d.darumaka = {hp = 70, atk = 90, def = 45, spatk = 15, spdef = 45, spe = 50}
d[554] = d.darumaka
d.darmanitan = {hp = 105, atk = 140, def = 55, spatk = 30, spdef = 55, spe = 95}
d[555] = d.darmanitan
d.maractus = {hp = 75, atk = 86, def = 67, spatk = 106, spdef = 67, spe = 60}
d[556] = d.maractus
d.dwebble = {hp = 50, atk = 65, def = 85, spatk = 35, spdef = 35, spe = 55}
d[557] = d.dwebble
d.crustle = {hp = 70, atk = {[5] = 95, [7] = 105}, def = 125, spatk = 65, spdef = 75, spe = 45}
d[558] = d.crustle
d.scraggy = {hp = 50, atk = 75, def = 70, spatk = 35, spdef = 70, spe = 48}
d[559] = d.scraggy
d.scrafty = {hp = 65, atk = 90, def = 115, spatk = 45, spdef = 115, spe = 58}
d[560] = d.scrafty
d.sigilyph = {hp = 72, atk = 58, def = 80, spatk = 103, spdef = 80, spe = 97}
d[561] = d.sigilyph
d.yamask = {hp = 38, atk = 30, def = 85, spatk = 55, spdef = 65, spe = 30}
d[562] = d.yamask
d.cofagrigus = {hp = 58, atk = 50, def = 145, spatk = 95, spdef = 105, spe = 30}
d[563] = d.cofagrigus
d.tirtouga = {hp = 54, atk = 78, def = 103, spatk = 53, spdef = 45, spe = 22}
d[564] = d.tirtouga
d.carracosta = {hp = 74, atk = 108, def = 133, spatk = 83, spdef = 65, spe = 32}
d[565] = d.carracosta
d.archen = {hp = 55, atk = 112, def = 45, spatk = 74, spdef = 45, spe = 70}
d[566] = d.archen
d.archeops = {hp = 75, atk = 140, def = 65, spatk = 112, spdef = 65, spe = 110}
d[567] = d.archeops
d.trubbish = {hp = 50, atk = 50, def = 62, spatk = 40, spdef = 62, spe = 65}
d[568] = d.trubbish
d.garbodor = {hp = 80, atk = 95, def = 82, spatk = 60, spdef = 82, spe = 75}
d[569] = d.garbodor
d.zorua = {hp = 40, atk = 65, def = 40, spatk = 80, spdef = 40, spe = 65}
d[570] = d.zorua
d.zoroark = {hp = 60, atk = 105, def = 60, spatk = 120, spdef = 60, spe = 105}
d[571] = d.zoroark
d.minccino = {hp = 55, atk = 50, def = 40, spatk = 40, spdef = 40, spe = 75}
d[572] = d.minccino
d.cinccino = {hp = 75, atk = 95, def = 60, spatk = 65, spdef = 60, spe = 115}
d[573] = d.cinccino
d.gothita = {hp = 45, atk = 30, def = 50, spatk = 55, spdef = 65, spe = 45}
d[574] = d.gothita
d.gothorita = {hp = 60, atk = 45, def = 70, spatk = 75, spdef = 85, spe = 55}
d[575] = d.gothorita
d.gothitelle = {hp = 70, atk = 55, def = 95, spatk = 95, spdef = 110, spe = 65}
d[576] = d.gothitelle
d.solosis = {hp = 45, atk = 30, def = 40, spatk = 105, spdef = 50, spe = 20}
d[577] = d.solosis
d.duosion = {hp = 65, atk = 40, def = 50, spatk = 125, spdef = 60, spe = 30}
d[578] = d.duosion
d.reuniclus = {hp = 110, atk = 65, def = 75, spatk = 125, spdef = 85, spe = 30}
d[579] = d.reuniclus
d.ducklett = {hp = 62, atk = 44, def = 50, spatk = 44, spdef = 50, spe = 55}
d[580] = d.ducklett
d.swanna = {hp = 75, atk = 87, def = 63, spatk = 87, spdef = 63, spe = 98}
d[581] = d.swanna
d.vanillite = {hp = 36, atk = 50, def = 50, spatk = 65, spdef = 60, spe = 44}
d[582] = d.vanillite
d.vanillish = {hp = 51, atk = 65, def = 65, spatk = 80, spdef = 75, spe = 59}
d[583] = d.vanillish
d.vanilluxe = {hp = 71, atk = 95, def = 85, spatk = 110, spdef = 95, spe = 79}
d[584] = d.vanilluxe
d.deerling = {hp = 60, atk = 60, def = 50, spatk = 40, spdef = 50, spe = 75}
d[585] = d.deerling
d.sawsbuck = {hp = 80, atk = 100, def = 70, spatk = 60, spdef = 70, spe = 95}
d[586] = d.sawsbuck
d.emolga = {hp = 55, atk = 75, def = 60, spatk = 75, spdef = 60, spe = 103}
d[587] = d.emolga
d.karrablast = {hp = 50, atk = 75, def = 45, spatk = 40, spdef = 45, spe = 60}
d[588] = d.karrablast
d.escavalier = {hp = 70, atk = 135, def = 105, spatk = 60, spdef = 105, spe = 20}
d[589] = d.escavalier
d.foongus = {hp = 69, atk = 55, def = 45, spatk = 55, spdef = 55, spe = 15}
d[590] = d.foongus
d.amoonguss = {hp = 114, atk = 85, def = 70, spatk = 85, spdef = 80, spe = 30}
d[591] = d.amoonguss
d.frillish = {hp = 55, atk = 40, def = 50, spatk = 65, spdef = 85, spe = 40}
d[592] = d.frillish
d.jellicent = {hp = 100, atk = 60, def = 70, spatk = 85, spdef = 105, spe = 60}
d[593] = d.jellicent
d.alomomola = {hp = 165, atk = 75, def = 80, spatk = 40, spdef = 45, spe = 65}
d[594] = d.alomomola
d.joltik = {hp = 50, atk = 47, def = 50, spatk = 57, spdef = 50, spe = 65}
d[595] = d.joltik
d.galvantula = {hp = 70, atk = 77, def = 60, spatk = 97, spdef = 60, spe = 108}
d[596] = d.galvantula
d.ferroseed = {hp = 44, atk = 50, def = 91, spatk = 24, spdef = 86, spe = 10}
d[597] = d.ferroseed
d.ferrothorn = {hp = 74, atk = 94, def = 131, spatk = 54, spdef = 116, spe = 20}
d[598] = d.ferrothorn
d.klink = {hp = 40, atk = 55, def = 70, spatk = 45, spdef = 60, spe = 30}
d[599] = d.klink
d.klang = {hp = 60, atk = 80, def = 95, spatk = 70, spdef = 85, spe = 50}
d[600] = d.klang
d.klinklang = {hp = 60, atk = 100, def = 115, spatk = 70, spdef = 85, spe = 90}
d[601] = d.klinklang
d.tynamo = {hp = 35, atk = 55, def = 40, spatk = 45, spdef = 40, spe = 60}
d[602] = d.tynamo
d.eelektrik = {hp = 65, atk = 85, def = 70, spatk = 75, spdef = 70, spe = 40}
d[603] = d.eelektrik
d.eelektross = {hp = 85, atk = 115, def = 80, spatk = 105, spdef = 80, spe = 50}
d[604] = d.eelektross
d.elgyem = {hp = 55, atk = 55, def = 55, spatk = 85, spdef = 55, spe = 30}
d[605] = d.elgyem
d.beheeyem = {hp = 75, atk = 75, def = 75, spatk = 125, spdef = 95, spe = 40}
d[606] = d.beheeyem
d.litwick = {hp = 50, atk = 30, def = 55, spatk = 65, spdef = 55, spe = 20}
d[607] = d.litwick
d.lampent = {hp = 60, atk = 40, def = 60, spatk = 95, spdef = 60, spe = 55}
d[608] = d.lampent
d.chandelure = {hp = 60, atk = 55, def = 90, spatk = 145, spdef = 90, spe = 80}
d[609] = d.chandelure
d.axew = {hp = 46, atk = 87, def = 60, spatk = 30, spdef = 40, spe = 57}
d[610] = d.axew
d.fraxure = {hp = 66, atk = 117, def = 70, spatk = 40, spdef = 50, spe = 67}
d[611] = d.fraxure
d.haxorus = {hp = 76, atk = 147, def = 90, spatk = 60, spdef = 70, spe = 97}
d[612] = d.haxorus
d.cubchoo = {hp = 55, atk = 70, def = 40, spatk = 60, spdef = 40, spe = 40}
d[613] = d.cubchoo
d.beartic = {hp = 95, atk = {[5] = 110, [7] = 130}, def = 80, spatk = 70, spdef = 80, spe = 50}
d[614] = d.beartic
d.cryogonal = {hp = {[5] = 70, [7] = 80}, atk = 50, def = {[5] = 30, [7] = 50}, spatk = 95, spdef = 135, spe = 105}
d[615] = d.cryogonal
d.shelmet = {hp = 50, atk = 40, def = 85, spatk = 40, spdef = 65, spe = 25}
d[616] = d.shelmet
d.accelgor = {hp = 80, atk = 70, def = 40, spatk = 100, spdef = 60, spe = 145}
d[617] = d.accelgor
d.stunfisk = {hp = 109, atk = 66, def = 84, spatk = 81, spdef = 99, spe = 32}
d[618] = d.stunfisk
d.mienfoo = {hp = 45, atk = 85, def = 50, spatk = 55, spdef = 50, spe = 65}
d[619] = d.mienfoo
d.mienshao = {hp = 65, atk = 125, def = 60, spatk = 95, spdef = 60, spe = 105}
d[620] = d.mienshao
d.druddigon = {hp = 77, atk = 120, def = 90, spatk = 60, spdef = 90, spe = 48}
d[621] = d.druddigon
d.golett = {hp = 59, atk = 74, def = 50, spatk = 35, spdef = 50, spe = 35}
d[622] = d.golett
d.golurk = {hp = 89, atk = 124, def = 80, spatk = 55, spdef = 80, spe = 55}
d[623] = d.golurk
d.pawniard = {hp = 45, atk = 85, def = 70, spatk = 40, spdef = 40, spe = 60}
d[624] = d.pawniard
d.bisharp = {hp = 65, atk = 125, def = 100, spatk = 60, spdef = 70, spe = 70}
d[625] = d.bisharp
d.bouffalant = {hp = 95, atk = 110, def = 95, spatk = 40, spdef = 95, spe = 55}
d[626] = d.bouffalant
d.rufflet = {hp = 70, atk = 83, def = 50, spatk = 37, spdef = 50, spe = 60}
d[627] = d.rufflet
d.braviary = {hp = 100, atk = 123, def = 75, spatk = 57, spdef = 75, spe = 80}
d[628] = d.braviary
d.vullaby = {hp = 70, atk = 55, def = 75, spatk = 45, spdef = 65, spe = 60}
d[629] = d.vullaby
d.mandibuzz = {hp = 110, atk = 65, def = 105, spatk = 55, spdef = 95, spe = 80}
d[630] = d.mandibuzz
d.heatmor = {hp = 85, atk = 97, def = 66, spatk = 105, spdef = 66, spe = 65}
d[631] = d.heatmor
d.durant = {hp = 58, atk = 109, def = 112, spatk = 48, spdef = 48, spe = 109}
d[632] = d.durant
d.deino = {hp = 52, atk = 65, def = 50, spatk = 45, spdef = 50, spe = 38}
d[633] = d.deino
d.zweilous = {hp = 72, atk = 85, def = 70, spatk = 65, spdef = 70, spe = 58}
d[634] = d.zweilous
d.hydreigon = {hp = 92, atk = 105, def = 90, spatk = 125, spdef = 90, spe = 98}
d[635] = d.hydreigon
d.larvesta = {hp = 55, atk = 85, def = 55, spatk = 50, spdef = 55, spe = 60}
d[636] = d.larvesta
d.volcarona = {hp = 85, atk = 60, def = 65, spatk = 135, spdef = 105, spe = 100}
d[637] = d.volcarona
d.cobalion = {hp = 91, atk = 90, def = 129, spatk = 90, spdef = 72, spe = 108}
d[638] = d.cobalion
d.terrakion = {hp = 91, atk = 129, def = 90, spatk = 72, spdef = 90, spe = 108}
d[639] = d.terrakion
d.virizion = {hp = 91, atk = 90, def = 72, spatk = 90, spdef = 129, spe = 108}
d[640] = d.virizion
d.tornadus = {hp = 79, atk = 115, def = 70, spatk = 125, spdef = 80, spe = 111}
d[641] = d.tornadus
d.thundurus = {hp = 79, atk = 115, def = 70, spatk = 125, spdef = 80, spe = 111}
d[642] = d.thundurus
d.reshiram = {hp = 100, atk = 120, def = 100, spatk = 150, spdef = 120, spe = 90}
d[643] = d.reshiram
d.zekrom = {hp = 100, atk = 150, def = 120, spatk = 120, spdef = 100, spe = 90}
d[644] = d.zekrom
d.landorus = {hp = 89, atk = 125, def = 90, spatk = 115, spdef = 80, spe = 101}
d[645] = d.landorus
d.kyurem = {hp = 125, atk = 130, def = 90, spatk = 130, spdef = 90, spe = 95}
d[646] = d.kyurem
d.keldeo = {hp = 91, atk = 72, def = 90, spatk = 129, spdef = 90, spe = 108}
d[647] = d.keldeo
d.meloetta = {hp = 100, atk = 77, def = 77, spatk = 128, spdef = 128, spe = 90}
d[648] = d.meloetta
d.genesect = {hp = 71, atk = 120, def = 95, spatk = 120, spdef = 95, spe = 99}
d[649] = d.genesect
d.chespin = {hp = 56, atk = 61, def = 65, spatk = 48, spdef = 45, spe = 38}
d[650] = d.chespin
d.quilladin = {hp = 61, atk = 78, def = 95, spatk = 56, spdef = 58, spe = 57}
d[651] = d.quilladin
d.chesnaught = {hp = 88, atk = 107, def = 122, spatk = 74, spdef = 75, spe = 64}
d[652] = d.chesnaught
d.fennekin = {hp = 40, atk = 45, def = 40, spatk = 62, spdef = 60, spe = 60}
d[653] = d.fennekin
d.braixen = {hp = 59, atk = 59, def = 58, spatk = 90, spdef = 70, spe = 73}
d[654] = d.braixen
d.delphox = {hp = 75, atk = 69, def = 72, spatk = 114, spdef = 100, spe = 104}
d[655] = d.delphox
d.froakie = {hp = 41, atk = 56, def = 40, spatk = 62, spdef = 44, spe = 71}
d[656] = d.froakie
d.frogadier = {hp = 54, atk = 63, def = 52, spatk = 83, spdef = 56, spe = 97}
d[657] = d.frogadier
d.greninja = {hp = 72, atk = 95, def = 67, spatk = 103, spdef = 71, spe = 122}
d[658] = d.greninja
d.bunnelby = {hp = 38, atk = 36, def = 38, spatk = 32, spdef = 36, spe = 57}
d[659] = d.bunnelby
d.diggersby = {hp = 85, atk = 56, def = 77, spatk = 50, spdef = 77, spe = 78}
d[660] = d.diggersby
d.fletchling = {hp = 45, atk = 50, def = 43, spatk = 40, spdef = 38, spe = 62}
d[661] = d.fletchling
d.fletchinder = {hp = 62, atk = 73, def = 55, spatk = 56, spdef = 52, spe = 84}
d[662] = d.fletchinder
d.talonflame = {hp = 78, atk = 81, def = 71, spatk = 74, spdef = 69, spe = 126}
d[663] = d.talonflame
d.scatterbug = {hp = 38, atk = 35, def = 40, spatk = 27, spdef = 25, spe = 35}
d[664] = d.scatterbug
d.spewpa = {hp = 45, atk = 22, def = 60, spatk = 27, spdef = 30, spe = 29}
d[665] = d.spewpa
d.vivillon = {hp = 80, atk = 52, def = 50, spatk = 90, spdef = 50, spe = 89}
d[666] = d.vivillon
d.litleo = {hp = 62, atk = 50, def = 58, spatk = 73, spdef = 54, spe = 72}
d[667] = d.litleo
d.pyroar = {hp = 86, atk = 68, def = 72, spatk = 109, spdef = 66, spe = 106}
d[668] = d.pyroar
d['flabébé'] = {hp = 44, atk = 38, def = 39, spatk = 61, spdef = 79, spe = 42}
d[669] = d['flabébé']
d.floette = {hp = 54, atk = 45, def = 47, spatk = 75, spdef = 98, spe = 52}
d[670] = d.floette
d.florges = {hp = 78, atk = 65, def = 68, spatk = 112, spdef = 154, spe = 75}
d[671] = d.florges
d.skiddo = {hp = 66, atk = 65, def = 48, spatk = 62, spdef = 57, spe = 52}
d[672] = d.skiddo
d.gogoat = {hp = 123, atk = 100, def = 62, spatk = 97, spdef = 81, spe = 68}
d[673] = d.gogoat
d.pancham = {hp = 67, atk = 82, def = 62, spatk = 46, spdef = 48, spe = 43}
d[674] = d.pancham
d.pangoro = {hp = 95, atk = 124, def = 78, spatk = 69, spdef = 71, spe = 58}
d[675] = d.pangoro
d.furfrou = {hp = 75, atk = 80, def = 60, spatk = 65, spdef = 90, spe = 102}
d[676] = d.furfrou
d.espurr = {hp = 62, atk = 48, def = 54, spatk = 63, spdef = 60, spe = 68}
d[677] = d.espurr
d.meowstic = {hp = 74, atk = 48, def = 76, spatk = 83, spdef = 81, spe = 104}
d[678] = d.meowstic
d.honedge = {hp = 45, atk = 80, def = 100, spatk = 35, spdef = 37, spe = 28}
d[679] = d.honedge
d.doublade = {hp = 59, atk = 110, def = 150, spatk = 45, spdef = 49, spe = 35}
d[680] = d.doublade
d.aegislash = {hp = 60, atk = 50, def = { [6] = 150, [8] = 140 }, spatk = 50, spdef = { [6] = 150, [8] = 140 }, spe = 60}
d[681] = d.aegislash
d.spritzee = {hp = 78, atk = 52, def = 60, spatk = 63, spdef = 65, spe = 23}
d[682] = d.spritzee
d.aromatisse = {hp = 101, atk = 72, def = 72, spatk = 99, spdef = 89, spe = 29}
d[683] = d.aromatisse
d.swirlix = {hp = 62, atk = 48, def = 66, spatk = 59, spdef = 57, spe = 49}
d[684] = d.swirlix
d.slurpuff = {hp = 82, atk = 80, def = 86, spatk = 85, spdef = 75, spe = 72}
d[685] = d.slurpuff
d.inkay = {hp = 53, atk = 54, def = 53, spatk = 37, spdef = 46, spe = 45}
d[686] = d.inkay
d.malamar = {hp = 86, atk = 92, def = 88, spatk = 68, spdef = 75, spe = 73}
d[687] = d.malamar
d.binacle = {hp = 42, atk = 52, def = 67, spatk = 39, spdef = 56, spe = 50}
d[688] = d.binacle
d.barbaracle = {hp = 72, atk = 105, def = 115, spatk = 54, spdef = 86, spe = 68}
d[689] = d.barbaracle
d.skrelp = {hp = 50, atk = 60, def = 60, spatk = 60, spdef = 60, spe = 30}
d[690] = d.skrelp
d.dragalge = {hp = 65, atk = 75, def = 90, spatk = 97, spdef = 123, spe = 44}
d[691] = d.dragalge
d.clauncher = {hp = 50, atk = 53, def = 62, spatk = 58, spdef = 63, spe = 44}
d[692] = d.clauncher
d.clawitzer = {hp = 71, atk = 73, def = 88, spatk = 120, spdef = 89, spe = 59}
d[693] = d.clawitzer
d.helioptile = {hp = 44, atk = 38, def = 33, spatk = 61, spdef = 43, spe = 70}
d[694] = d.helioptile
d.heliolisk = {hp = 62, atk = 55, def = 52, spatk = 109, spdef = 94, spe = 109}
d[695] = d.heliolisk
d.tyrunt = {hp = 58, atk = 89, def = 77, spatk = 45, spdef = 45, spe = 48}
d[696] = d.tyrunt
d.tyrantrum = {hp = 82, atk = 121, def = 119, spatk = 69, spdef = 59, spe = 71}
d[697] = d.tyrantrum
d.amaura = {hp = 77, atk = 59, def = 50, spatk = 67, spdef = 63, spe = 46}
d[698] = d.amaura
d.aurorus = {hp = 123, atk = 77, def = 72, spatk = 99, spdef = 92, spe = 58}
d[699] = d.aurorus
d.sylveon = {hp = 95, atk = 65, def = 65, spatk = 110, spdef = 130, spe = 60}
d[700] = d.sylveon
d.hawlucha = {hp = 78, atk = 92, def = 75, spatk = 74, spdef = 63, spe = 118}
d[701] = d.hawlucha
d.dedenne = {hp = 67, atk = 58, def = 57, spatk = 81, spdef = 67, spe = 101}
d[702] = d.dedenne
d.carbink = {hp = 50, atk = 50, def = 150, spatk = 50, spdef = 150, spe = 50}
d[703] = d.carbink
d.goomy = {hp = 45, atk = 50, def = 35, spatk = 55, spdef = 75, spe = 40}
d[704] = d.goomy
d.sliggoo = {hp = 68, atk = 75, def = 53, spatk = 83, spdef = 113, spe = 60}
d[705] = d.sliggoo
d.goodra = {hp = 90, atk = 100, def = 70, spatk = 110, spdef = 150, spe = 80}
d[706] = d.goodra
d.klefki = {hp = 57, atk = 80, def = 91, spatk = 80, spdef = 87, spe = 75}
d[707] = d.klefki
d.phantump = {hp = 43, atk = 70, def = 48, spatk = 50, spdef = 60, spe = 38}
d[708] = d.phantump
d.trevenant = {hp = 85, atk = 110, def = 76, spatk = 65, spdef = 82, spe = 56}
d[709] = d.trevenant
d.pumpkaboo = {hp = 49, atk = 66, def = 70, spatk = 44, spdef = 55, spe = 51}
d[710] = d.pumpkaboo
d.gourgeist = {hp = 65, atk = 90, def = 122, spatk = 58, spdef = 75, spe = 84}
d[711] = d.gourgeist
d.bergmite = {hp = 55, atk = 69, def = 85, spatk = 32, spdef = 35, spe = 28}
d[712] = d.bergmite
d.avalugg = {hp = 95, atk = 117, def = 184, spatk = 44, spdef = 46, spe = 28}
d[713] = d.avalugg
d.noibat = {hp = 40, atk = 30, def = 35, spatk = 45, spdef = 40, spe = 55}
d[714] = d.noibat
d.noivern = {hp = 85, atk = 70, def = 80, spatk = 97, spdef = 80, spe = 123}
d[715] = d.noivern
d.xerneas = {hp = 126, atk = 131, def = 95, spatk = 131, spdef = 98, spe = 99}
d[716] = d.xerneas
d.yveltal = {hp = 126, atk = 131, def = 95, spatk = 131, spdef = 98, spe = 99}
d[717] = d.yveltal
d.zygarde = {hp = 108, atk = 100, def = 121, spatk = 81, spdef = 95, spe = 95}
d[718] = d.zygarde
d.diancie = {hp = 50, atk = 100, def = 150, spatk = 100, spdef = 150, spe = 50}
d[719] = d.diancie
d.hoopa = {hp = 80, atk = 110, def = 60, spatk = 150, spdef = 130, spe = 70}
d[720] = d.hoopa
d.volcanion = {hp = 80, atk = 110, def = 120, spatk = 130, spdef = 90, spe = 70}
d[721] = d.volcanion
d.rowlet = {hp = 68, atk = 55, def = 55, spatk = 50, spdef = 50, spe = 42}
d[722] = d.rowlet
d.dartrix = {hp = 78, atk = 75, def = 75, spatk = 70, spdef = 70, spe = 52}
d[723] = d.dartrix
d.decidueye = {hp = 78, atk = 107, def = 75, spatk = 100, spdef = 100, spe = 70}
d[724] = d.decidueye
d.litten = {hp = 45, atk = 65, def = 40, spatk = 60, spdef = 40, spe = 70}
d[725] = d.litten
d.torracat = {hp = 65, atk = 85, def = 50, spatk = 80, spdef = 50, spe = 90}
d[726] = d.torracat
d.incineroar = {hp = 95, atk = 115, def = 90, spatk = 80, spdef = 90, spe = 60}
d[727] = d.incineroar
d.popplio = {hp = 50, atk = 54, def = 54, spatk = 66, spdef = 56, spe = 40}
d[728] = d.popplio
d.brionne = {hp = 60, atk = 69, def = 69, spatk = 91, spdef = 81, spe = 50}
d[729] = d.brionne
d.primarina = {hp = 80, atk = 74, def = 74, spatk = 126, spdef = 116, spe = 60}
d[730] = d.primarina
d.pikipek = {hp = 35, atk = 75, def = 30, spatk = 30, spdef = 30, spe = 65}
d[731] = d.pikipek
d.trumbeak = {hp = 55, atk = 85, def = 50, spatk = 40, spdef = 50, spe = 75}
d[732] = d.trumbeak
d.toucannon = {hp = 80, atk = 120, def = 75, spatk = 75, spdef = 75, spe = 60}
d[733] = d.toucannon
d.yungoos = {hp = 48, atk = 70, def = 30, spatk = 30, spdef = 30, spe = 45}
d[734] = d.yungoos
d.gumshoos = {hp = 88, atk = 110, def = 60, spatk = 55, spdef = 60, spe = 45}
d[735] = d.gumshoos
d.grubbin = {hp = 47, atk = 62, def = 45, spatk = 55, spdef = 45, spe = 46}
d[736] = d.grubbin
d.charjabug = {hp = 57, atk = 82, def = 95, spatk = 55, spdef = 75, spe = 36}
d[737] = d.charjabug
d.vikavolt = {hp = 77, atk = 70, def = 90, spatk = 145, spdef = 75, spe = 43}
d[738] = d.vikavolt
d.crabrawler = {hp = 47, atk = 82, def = 57, spatk = 42, spdef = 47, spe = 63}
d[739] = d.crabrawler
d.crabominable = {hp = 97, atk = 132, def = 77, spatk = 62, spdef = 67, spe = 43}
d[740] = d.crabominable
d.oricorio = {hp = 75, atk = 70, def = 70, spatk = 98, spdef = 70, spe = 93}
d[741] = d.oricorio
d.cutiefly = {hp = 40, atk = 45, def = 40, spatk = 55, spdef = 40, spe = 84}
d[742] = d.cutiefly
d.ribombee = {hp = 60, atk = 55, def = 60, spatk = 95, spdef = 70, spe = 124}
d[743] = d.ribombee
d.rockruff = {hp = 45, atk = 65, def = 40, spatk = 30, spdef = 40, spe = 60}
d[744] = d.rockruff
d.lycanroc = {hp = 75, atk = 115, def = 65, spatk = 55, spdef = 65, spe = 112}
d[745] = d.lycanroc
d.wishiwashi = {hp = 45, atk = 20, def = 20, spatk = 25, spdef = 25, spe = 40}
d[746] = d.wishiwashi
d.mareanie = {hp = 50, atk = 53, def = 62, spatk = 43, spdef = 52, spe = 45}
d[747] = d.mareanie
d.toxapex = {hp = 50, atk = 63, def = 152, spatk = 53, spdef = 142, spe = 35}
d[748] = d.toxapex
d.mudbray = {hp = 70, atk = 100, def = 70, spatk = 45, spdef = 55, spe = 45}
d[749] = d.mudbray
d.mudsdale = {hp = 100, atk = 125, def = 100, spatk = 55, spdef = 85, spe = 35}
d[750] = d.mudsdale
d.dewpider = {hp = 38, atk = 40, def = 52, spatk = 40, spdef = 72, spe = 27}
d[751] = d.dewpider
d.araquanid = {hp = 68, atk = 70, def = 92, spatk = 50, spdef = 132, spe = 42}
d[752] = d.araquanid
d.fomantis = {hp = 40, atk = 55, def = 35, spatk = 50, spdef = 35, spe = 35}
d[753] = d.fomantis
d.lurantis = {hp = 70, atk = 105, def = 90, spatk = 80, spdef = 90, spe = 45}
d[754] = d.lurantis
d.morelull = {hp = 40, atk = 35, def = 55, spatk = 65, spdef = 75, spe = 15}
d[755] = d.morelull
d.shiinotic = {hp = 60, atk = 45, def = 80, spatk = 90, spdef = 100, spe = 30}
d[756] = d.shiinotic
d.salandit = {hp = 48, atk = 44, def = 40, spatk = 71, spdef = 40, spe = 77}
d[757] = d.salandit
d.salazzle = {hp = 68, atk = 64, def = 60, spatk = 111, spdef = 60, spe = 117}
d[758] = d.salazzle
d.stufful = {hp = 70, atk = 75, def = 50, spatk = 45, spdef = 50, spe = 50}
d[759] = d.stufful
d.bewear = {hp = 120, atk = 125, def = 80, spatk = 55, spdef = 60, spe = 60}
d[760] = d.bewear
d.bounsweet = {hp = 42, atk = 30, def = 38, spatk = 30, spdef = 38, spe = 32}
d[761] = d.bounsweet
d.steenee = {hp = 52, atk = 40, def = 48, spatk = 40, spdef = 48, spe = 62}
d[762] = d.steenee
d.tsareena = {hp = 72, atk = 120, def = 98, spatk = 50, spdef = 98, spe = 72}
d[763] = d.tsareena
d.comfey = {hp = 51, atk = 52, def = 90, spatk = 82, spdef = 110, spe = 100}
d[764] = d.comfey
d.oranguru = {hp = 90, atk = 60, def = 80, spatk = 90, spdef = 110, spe = 60}
d[765] = d.oranguru
d.passimian = {hp = 100, atk = 120, def = 90, spatk = 40, spdef = 60, spe = 80}
d[766] = d.passimian
d.wimpod = {hp = 25, atk = 35, def = 40, spatk = 20, spdef = 30, spe = 80}
d[767] = d.wimpod
d.golisopod = {hp = 75, atk = 125, def = 140, spatk = 60, spdef = 90, spe = 40}
d[768] = d.golisopod
d.sandygast = {hp = 55, atk = 55, def = 80, spatk = 70, spdef = 45, spe = 15}
d[769] = d.sandygast
d.palossand = {hp = 85, atk = 75, def = 110, spatk = 100, spdef = 75, spe = 35}
d[770] = d.palossand
d.pyukumuku = {hp = 55, atk = 60, def = 130, spatk = 30, spdef = 130, spe = 5}
d[771] = d.pyukumuku
d['tipo zero'] = {hp = 95, atk = 95, def = 95, spatk = 95, spdef = 95, spe = 59}
d[772] = d['tipo zero']
d.silvally = {hp = 95, atk = 95, def = 95, spatk = 95, spdef = 95, spe = 95}
d[773] = d.silvally
d.minior = {hp = 60, atk = 60, def = 100, spatk = 60, spdef = 100, spe = 60}
d[774] = d.minior
d.komala = {hp = 65, atk = 115, def = 65, spatk = 75, spdef = 95, spe = 65}
d[775] = d.komala
d.turtonator = {hp = 60, atk = 78, def = 135, spatk = 91, spdef = 85, spe = 36}
d[776] = d.turtonator
d.togedemaru = {hp = 65, atk = 98, def = 63, spatk = 40, spdef = 73, spe = 96}
d[777] = d.togedemaru
d.mimikyu = {hp = 55, atk = 90, def = 80, spatk = 50, spdef = 105, spe = 96}
d[778] = d.mimikyu
d.bruxish = {hp = 68, atk = 105, def = 70, spatk = 70, spdef = 70, spe = 92}
d[779] = d.bruxish
d.drampa = {hp = 78, atk = 60, def = 85, spatk = 135, spdef = 91, spe = 36}
d[780] = d.drampa
d.dhelmise = {hp = 70, atk = 131, def = 100, spatk = 86, spdef = 90, spe = 40}
d[781] = d.dhelmise
d['jangmo-o'] = {hp = 45, atk = 55, def = 65, spatk = 45, spdef = 45, spe = 45}
d[782] = d['jangmo-o']
d['hakamo-o'] = {hp = 55, atk = 75, def = 90, spatk = 65, spdef = 70, spe = 65}
d[783] = d['hakamo-o']
d['kommo-o'] = {hp = 75, atk = 110, def = 125, spatk = 100, spdef = 105, spe = 85}
d[784] = d['kommo-o']
d['tapu koko'] = {hp = 70, atk = 115, def = 85, spatk = 95, spdef = 75, spe = 130}
d[785] = d['tapu koko']
d['tapu lele'] = {hp = 70, atk = 85, def = 75, spatk = 130, spdef = 115, spe = 95}
d[786] = d['tapu lele']
d['tapu bulu'] = {hp = 70, atk = 130, def = 115, spatk = 85, spdef = 95, spe = 75}
d[787] = d['tapu bulu']
d['tapu fini'] = {hp = 70, atk = 75, def = 115, spatk = 95, spdef = 130, spe = 85}
d[788] = d['tapu fini']
d.cosmog = {hp = 43, atk = 29, def = 31, spatk = 29, spdef = 31, spe = 37}
d[789] = d.cosmog
d.cosmoem = {hp = 43, atk = 29, def = 131, spatk = 29, spdef = 131, spe = 37}
d[790] = d.cosmoem
d.solgaleo = {hp = 137, atk = 137, def = 107, spatk = 113, spdef = 89, spe = 97}
d[791] = d.solgaleo
d.lunala = {hp = 137, atk = 113, def = 89, spatk = 137, spdef = 107, spe = 97}
d[792] = d.lunala
d.nihilego = {hp = 109, atk = 53, def = 47, spatk = 127, spdef = 131, spe = 103}
d[793] = d.nihilego
d.buzzwole = {hp = 107, atk = 139, def = 139, spatk = 53, spdef = 53, spe = 79}
d[794] = d.buzzwole
d.pheromosa = {hp = 71, atk = 137, def = 37, spatk = 137, spdef = 37, spe = 151}
d[795] = d.pheromosa
d.xurkitree = {hp = 83, atk = 89, def = 71, spatk = 173, spdef = 71, spe = 83}
d[796] = d.xurkitree
d.celesteela = {hp = 97, atk = 101, def = 103, spatk = 107, spdef = 101, spe = 61}
d[797] = d.celesteela
d.kartana = {hp = 59, atk = 181, def = 131, spatk = 59, spdef = 31, spe = 109}
d[798] = d.kartana
d.guzzlord = {hp = 223, atk = 101, def = 53, spatk = 97, spdef = 53, spe = 43}
d[799] = d.guzzlord
d.necrozma = {hp = 97, atk = 107, def = 101, spatk = 127, spdef = 89, spe = 79}
d[800] = d.necrozma
d.magearna = {hp = 80, atk = 95, def = 115, spatk = 130, spdef = 115, spe = 65}
d[801] = d.magearna
d.marshadow = {hp = 90, atk = 125, def = 80, spatk = 90, spdef = 90, spe = 125}
d[802] = d.marshadow
d.poipole = {hp = 67, atk = 73, def = 67, spatk = 73, spdef = 67, spe = 73}
d[803] = d.poipole
d.naganadel = {hp = 73, atk = 73, def = 73, spatk = 127, spdef = 73, spe = 121}
d[804] = d.naganadel
d.stakataka = {hp = 61, atk = 131, def = 211, spatk = 53, spdef = 101, spe = 13}
d[805] = d.stakataka
d.blacephalon = {hp = 53, atk = 127, def = 53, spatk = 151, spdef = 79, spe = 107}
d[806] = d.blacephalon
d.zeraora = {hp = 88, atk = 112, def = 75, spatk = 102, spdef = 80, spe = 143}
d[807] = d.zeraora
d.meltan = {hp = 46, atk = 65, def = 65, spatk = 55, spdef = 35, spe = 34}
d[808] = d.meltan
d.melmetal = {hp = 135, atk = 143, def = 143, spatk = 80, spdef = 65, spe = 34}
d[809] = d.melmetal
d.grookey = {hp = 50, atk = 65, def = 50, spatk = 40, spdef = 40, spe = 65}
d[810] = d.grookey
d.thwackey = {hp = 70, atk = 85, def = 70, spatk = 55, spdef = 60, spe = 80}
d[811] = d.thwackey
d.rillaboom = {hp = 100, atk = 125, def = 90, spatk = 60, spdef = 70, spe = 85}
d[812] = d.rillaboom
d.scorbunny = {hp = 50, atk = 71, def = 40, spatk = 40, spdef = 40, spe = 69}
d[813] = d.scorbunny
d.raboot = {hp = 65, atk = 86, def = 60, spatk = 55, spdef = 60, spe = 94}
d[814] = d.raboot
d.cinderace = {hp = 80, atk = 116, def = 75, spatk = 65, spdef = 75, spe = 119}
d[815] = d.cinderace
d.sobble = {hp = 50, atk = 40, def = 40, spatk = 70, spdef = 40, spe = 70}
d[816] = d.sobble
d.drizzile = {hp = 65, atk = 60, def = 55, spatk = 95, spdef = 55, spe = 90}
d[817] = d.drizzile
d.inteleon = {hp = 70, atk = 85, def = 65, spatk = 125, spdef = 65, spe = 120}
d[818] = d.inteleon
d.skwovet = {hp = 70, atk = 55, def = 55, spatk = 35, spdef = 35, spe = 25}
d[819] = d.skwovet
d.greedent = {hp = 120, atk = 95, def = 95, spatk = 55, spdef = 75, spe = 20}
d[820] = d.greedent
d.rookidee = {hp = 38, atk = 47, def = 35, spatk = 33, spdef = 35, spe = 57}
d[821] = d.rookidee
d.corvisquire = {hp = 68, atk = 67, def = 55, spatk = 43, spdef = 55, spe = 77}
d[822] = d.corvisquire
d.corviknight = {hp = 98, atk = 87, def = 105, spatk = 53, spdef = 85, spe = 67}
d[823] = d.corviknight
d.blipbug = {hp = 25, atk = 20, def = 20, spatk = 25, spdef = 45, spe = 45}
d[824] = d.blipbug
d.dottler = {hp = 50, atk = 35, def = 80, spatk = 50, spdef = 90, spe = 30}
d[825] = d.dottler
d.orbeetle = {hp = 60, atk = 45, def = 110, spatk = 80, spdef = 120, spe = 90}
d[826] = d.orbeetle
d.nickit = {hp = 40, atk = 28, def = 28, spatk = 47, spdef = 52, spe = 50}
d[827] = d.nickit
d.thievul = {hp = 70, atk = 58, def = 58, spatk = 87, spdef = 92, spe = 90}
d[828] = d.thievul
d.gossifleur = {hp = 40, atk = 40, def = 60, spatk = 40, spdef = 60, spe = 10}
d[829] = d.gossifleur
d.eldegoss = {hp = 60, atk = 50, def = 90, spatk = 80, spdef = 120, spe = 60}
d[830] = d.eldegoss
d.wooloo = {hp = 42, atk = 40, def = 55, spatk = 40, spdef = 45, spe = 48}
d[831] = d.wooloo
d.dubwool = {hp = 72, atk = 80, def = 100, spatk = 60, spdef = 90, spe = 88}
d[832] = d.dubwool
d.chewtle = {hp = 50, atk = 64, def = 50, spatk = 38, spdef = 38, spe = 44}
d[833] = d.chewtle
d.drednaw = {hp = 90, atk = 115, def = 90, spatk = 48, spdef = 68, spe = 74}
d[834] = d.drednaw
d.yamper = {hp = 59, atk = 45, def = 50, spatk = 40, spdef = 50, spe = 26}
d[835] = d.yamper
d.boltund = {hp = 69, atk = 90, def = 60, spatk = 90, spdef = 60, spe = 121}
d[836] = d.boltund
d.rolycoly = {hp = 30, atk = 40, def = 50, spatk = 40, spdef = 50, spe = 30}
d[837] = d.rolycoly
d.carkol = {hp = 80, atk = 60, def = 90, spatk = 60, spdef = 70, spe = 50}
d[838] = d.carkol
d.coalossal = {hp = 110, atk = 80, def = 120, spatk = 80, spdef = 90, spe = 30}
d[839] = d.coalossal
d.applin = {hp = 40, atk = 40, def = 80, spatk = 40, spdef = 40, spe = 20}
d[840] = d.applin
d.flapple = {hp = 70, atk = 110, def = 80, spatk = 95, spdef = 60, spe = 70}
d[841] = d.flapple
d.appletun = {hp = 110, atk = 85, def = 80, spatk = 100, spdef = 80, spe = 30}
d[842] = d.appletun
d.silicobra = {hp = 52, atk = 57, def = 75, spatk = 35, spdef = 50, spe = 46}
d[843] = d.silicobra
d.sandaconda = {hp = 72, atk = 107, def = 125, spatk = 65, spdef = 70, spe = 71}
d[844] = d.sandaconda
d.cramorant = {hp = 70, atk = 85, def = 55, spatk = 85, spdef = 95, spe = 85}
d[845] = d.cramorant
d.arrokuda = {hp = 41, atk = 63, def = 40, spatk = 40, spdef = 30, spe = 66}
d[846] = d.arrokuda
d.barraskewda = {hp = 61, atk = 123, def = 60, spatk = 60, spdef = 50, spe = 136}
d[847] = d.barraskewda
d.toxel = {hp = 40, atk = 38, def = 35, spatk = 54, spdef = 35, spe = 40}
d[848] = d.toxel
d.toxtricity = {hp = 75, atk = 98, def = 70, spatk = 114, spdef = 70, spe = 75}
d[849] = d.toxtricity
d.sizzlipede = {hp = 50, atk = 65, def = 45, spatk = 50, spdef = 50, spe = 45}
d[850] = d.sizzlipede
d.centiskorch = {hp = 100, atk = 115, def = 65, spatk = 90, spdef = 90, spe = 65}
d[851] = d.centiskorch
d.clobbopus = {hp = 50, atk = 68, def = 60, spatk = 50, spdef = 50, spe = 32}
d[852] = d.clobbopus
d.grapploct = {hp = 80, atk = 118, def = 90, spatk = 70, spdef = 80, spe = 42}
d[853] = d.grapploct
d.sinistea = {hp = 40, atk = 45, def = 45, spatk = 74, spdef = 54, spe = 50}
d[854] = d.sinistea
d.polteageist = {hp = 60, atk = 65, def = 65, spatk = 134, spdef = 114, spe = 70}
d[855] = d.polteageist
d.hatenna = {hp = 42, atk = 30, def = 45, spatk = 56, spdef = 53, spe = 39}
d[856] = d.hatenna
d.hattrem = {hp = 57, atk = 40, def = 65, spatk = 86, spdef = 73, spe = 49}
d[857] = d.hattrem
d.hatterene = {hp = 57, atk = 90, def = 95, spatk = 136, spdef = 103, spe = 29}
d[858] = d.hatterene
d.impidimp = {hp = 45, atk = 45, def = 30, spatk = 55, spdef = 40, spe = 50}
d[859] = d.impidimp
d.morgrem = {hp = 65, atk = 60, def = 45, spatk = 75, spdef = 55, spe = 70}
d[860] = d.morgrem
d.grimmsnarl = {hp = 95, atk = 120, def = 65, spatk = 95, spdef = 75, spe = 60}
d[861] = d.grimmsnarl
d.obstagoon = {hp = 93, atk = 90, def = 101, spatk = 60, spdef = 81, spe = 95}
d[862] = d.obstagoon
d.perrserker = {hp = 70, atk = 110, def = 100, spatk = 50, spdef = 60, spe = 50}
d[863] = d.perrserker
d.cursola = {hp = 60, atk = 95, def = 50, spatk = 145, spdef = 130, spe = 30}
d[864] = d.cursola
d["sirfetch'd"] = {hp = 62, atk = 135, def = 95, spatk = 68, spdef = 82, spe = 65}
d[865] = d["sirfetch'd"]
d["mr. rime"] = {hp = 80, atk = 85, def = 75, spatk = 110, spdef = 100, spe = 70}
d[866] = d["mr. rime"]
d.runerigus = {hp = 58, atk = 95, def = 145, spatk = 50, spdef = 105, spe = 30}
d[867] = d.runerigus
d.milcery = {hp = 45, atk = 40, def = 40, spatk = 50, spdef = 61, spe = 34}
d[868] = d.milcery
d.alcremie = {hp = 65, atk = 60, def = 75, spatk = 110, spdef = 121, spe = 64}
d[869] = d.alcremie
d.falinks = {hp = 65, atk = 100, def = 100, spatk = 70, spdef = 60, spe = 75}
d[870] = d.falinks
d.pincurchin = {hp = 48, atk = 101, def = 95, spatk = 91, spdef = 85, spe = 15}
d[871] = d.pincurchin
d.snom = {hp = 30, atk = 25, def = 35, spatk = 45, spdef = 30, spe = 20}
d[872] = d.snom
d.frosmoth = {hp = 70, atk = 65, def = 60, spatk = 125, spdef = 90, spe = 65}
d[873] = d.frosmoth
d.stonjourner = {hp = 100, atk = 125, def = 135, spatk = 20, spdef = 20, spe = 70}
d[874] = d.stonjourner
d.eiscue = {hp = 75, atk = 80, def = 110, spatk = 65, spdef = 90, spe = 50}
d[875] = d.eiscue
d.indeedee = {hp = 60, atk = 65, def = 55, spatk = 105, spdef = 95, spe = 95}
d[876] = d.indeedee
d.morpeko = {hp = 58, atk = 95, def = 58, spatk = 70, spdef = 58, spe = 97}
d[877] = d.morpeko
d.cufant = {hp = 72, atk = 80, def = 49, spatk = 40, spdef = 49, spe = 40}
d[878] = d.cufant
d.copperajah = {hp = 122, atk = 130, def = 69, spatk = 80, spdef = 69, spe = 30}
d[879] = d.copperajah
d.dracozolt = {hp = 90, atk = 100, def = 90, spatk = 80, spdef = 70, spe = 75}
d[880] = d.dracozolt
d.arctozolt = {hp = 90, atk = 100, def = 90, spatk = 90, spdef = 80, spe = 55}
d[881] = d.arctozolt
d.dracovish = {hp = 90, atk = 90, def = 100, spatk = 70, spdef = 80, spe = 75}
d[882] = d.dracovish
d.arctovish = {hp = 90, atk = 90, def = 100, spatk = 80, spdef = 90, spe = 55}
d[883] = d.arctovish
d.duraludon = {hp = 70, atk = 95, def = 115, spatk = 120, spdef = 50, spe = 85}
d[884] = d.duraludon
d.dreepy = {hp = 28, atk = 60, def = 30, spatk = 40, spdef = 30, spe = 82}
d[885] = d.dreepy
d.drakloak = {hp = 68, atk = 80, def = 50, spatk = 60, spdef = 50, spe = 102}
d[886] = d.drakloak
d.dragapult = {hp = 88, atk = 120, def = 75, spatk = 100, spdef = 75, spe = 142}
d[887] = d.dragapult
d.zacian = {hp = 92, atk = 130, def = 115, spatk = 80, spdef = 115, spe = 138}
d[888] = d.zacian
d.zamazenta = {hp = 92, atk = 130, def = 115, spatk = 80, spdef = 115, spe = 138}
d[889] = d.zamazenta
d.eternatus = {hp = 140, atk = 85, def = 95, spatk = 145, spdef = 95, spe = 130}
d[890] = d.eternatus
d.kubfu = {hp = 60, atk = 90, def = 60, spatk = 53, spdef = 50, spe = 72}
d[891] = d.kubfu
d.urshifu = {hp = 100, atk = 130, def = 100, spatk = 63, spdef = 60, spe = 97}
d[892] = d.urshifu
d.zarude = {hp = 105, atk = 120, def = 105, spatk = 70, spdef = 95, spe = 105}
d[893] = d.zarude
d.regieleki = {hp = 80, atk = 100, def = 50, spatk = 100, spdef = 50, spe = 200}
d[894] = d.regieleki
d.regidrago = {hp = 200, atk = 100, def = 50, spatk = 100, spdef = 50, spe = 80}
d[895] = d.regidrago
d.glastrier = {hp = 100, atk = 145, def = 130, spatk = 65, spdef = 110, spe = 30}
d[896] = d.glastrier
d.spectrier = {hp = 100, atk = 65, def = 60, spatk = 145, spdef = 80, spe = 130}
d[897] = d.spectrier
d.calyrex = {hp = 100, atk = 80, def = 80, spatk = 80, spdef = 80, spe = 80}
d[898] = d.calyrex

-- Alternative forms which actually change stats
d.pikachuCm = {hp = 45, atk = 80, def = 50, spatk = 75, spdef = 60, spe = 120}
d['025Cm'] = d.pikachuCm
d.eeveeCm = {hp = 65, atk = 75, def = 70, spatk = 65, spdef = 85, spe = 75}
d['133Cm'] = d.eeveeCm
d.articunoG = {hp = 90, atk = 85, def = 85, spatk = 125, spdef = 100, spe = 95}
d['144G'] = d.articunoG
d.zapdosG = {hp = 90, atk = 125, def = 90, spatk = 85, spdef = 90, spe = 100}
d['145G'] = d.zapdosG
d.moltresG = {hp = 90, atk = 85, def = 90, spatk = 100, spdef = 125, spe = 90}
d['146G'] = d.moltresG
d.deoxysA = {hp = 50, atk = 180, def = 20, spatk = 180, spdef = 20, spe = 150}
d['386A'] = d.deoxysA
d.deoxysD = {hp = 50, atk = 70, def = 160, spatk = 70, spdef = 160, spe = 90}
d['386D'] = d.deoxysD
d.deoxysV = {hp = 50, atk = 95, def = 90, spatk = 95, spdef = 90, spe = 180}
d['386V'] = d.deoxysV
d.wormadamSa = {hp = 60, atk = 79, def = 105, spatk = 59, spdef = 85, spe = 36}
d['413Sa'] = d.wormadamSa
d.wormadamSc = {hp = 60, atk = 69, def = 95, spatk = 69, spdef = 95, spe = 36}
d['413Sc'] = d.wormadamSc
d.rotomC = {hp = 50, atk = 65, def = 107, spatk = 105, spdef = 107, spe = 86}
d['479C'] = d.rotomC
d.rotomL = {hp = 50, atk = 65, def = 107, spatk = 105, spdef = 107, spe = 86}
d['479L'] = d.rotomL
d.rotomG = {hp = 50, atk = 65, def = 107, spatk = 105, spdef = 107, spe = 86}
d['479G'] = d.rotomG
d.rotomV = {hp = 50, atk = 65, def = 107, spatk = 105, spdef = 107, spe = 86}
d['479V'] = d.rotomV
d.rotomT = {hp = 50, atk = 65, def = 107, spatk = 105, spdef = 107, spe = 86}
d['479T'] = d.rotomT
d.giratinaO = {hp = 150, atk = 120, def = 100, spatk = 120, spdef = 100, spe = 90}
d['487O'] = d.giratinaO
d.shayminC = {hp = 100, atk = 103, def = 75, spatk = 120, spdef = 75, spe = 127}
d['492C'] = d.shayminC
d.darmanitanZ = {hp = 105, atk = 30, def = 105, spatk = 140, spdef = 105, spe = 55}
d['555Z'] = d.darmanitanZ
d.tornadusT = {hp = 79, atk = 100, def = 80, spatk = 110, spdef = 90, spe = 121}
d['641T'] = d.tornadusT
d.thundurusT = {hp = 79, atk = 105, def = 70, spatk = 145, spdef = 80, spe = 101}
d['642T'] = d.thundurusT
d.landorusT = {hp = 89, atk = 145, def = 90, spatk = 105, spdef = 80, spe = 91}
d['645T'] = d.landorusT
d.kyuremN = {hp = 125, atk = 170, def = 100, spatk = 120, spdef = 90, spe = 95}
d['646N'] = d.kyuremN
d.kyuremB = {hp = 125, atk = 120, def = 90, spatk = 170, spdef = 100, spe = 95}
d['646B'] = d.kyuremB
d.meloettaD = {hp = 100, atk = 128, def = 90, spatk = 77, spdef = 77, spe = 128}
d['648D'] = d.meloettaD
d.greninjaA = {hp = 72, atk = 145, def = 67, spatk = 153, spdef = 71, spe = 132}
d['658A'] = d.greninjaA
d.aegislashS = {hp = 60, atk = { [6] = 150, [8] = 140 }, def = 50, spatk = { [6] = 150, [8] = 140 }, spdef = 50, spe = 60}
d['681S'] = d.aegislashS
d.pumpkabooS = {hp = 44, atk = 66, def = 70, spatk = 44, spdef = 55, spe = 56}
d['710S'] = d.pumpkabooS
d.pumpkabooL = {hp = 54, atk = 66, def = 70, spatk = 44, spdef = 55, spe = 46}
d['710L'] = d.pumpkabooL
d.pumpkabooXL = {hp = 59, atk = 66, def = 70, spatk = 44, spdef = 55, spe = 41}
d['710XL'] = d.pumpkabooXL
d.gourgeistS = {hp = 55, atk = 85, def = 122, spatk = 58, spdef = 75, spe = 99}
d['711S'] = d.gourgeistS
d.gourgeistL = {hp = 75, atk = 95, def = 122, spatk = 58, spdef = 75, spe = 69}
d['711L'] = d.gourgeistL
d.gourgeistXL = {hp = 85, atk = 100, def = 122, spatk = 58, spdef = 75, spe = 54}
d['711XL'] = d.gourgeistXL
d.zygardeD = {hp = 54, atk = 100, def = 71, spatk = 61, spdef = 85, spe = 115}
d['718D'] = d.zygardeD
d.zygardeP = {hp = 216, atk = 100, def = 121, spatk = 91, spdef = 95, spe = 85}
d['718P'] = d.zygardeP
d.hoopaL = {hp = 80, atk = 160, def = 60, spatk = 170, spdef = 130, spe = 80}
d['720L'] = d.hoopaL
d.lycanrocN = {hp = 85, atk = 115, def = 75, spatk = 55, spdef = 75, spe = 82}
d['745N'] = d.lycanrocN
d.lycanrocC = {hp = 75, atk = 117, def = 65, spatk = 55, spdef = 65, spe = 110}
d['745C'] = d.lycanrocC
d.wishiwashiB = {hp = 45, atk = 140, def = 130, spatk = 140, spdef = 135, spe = 30}
d['746B'] = d.wishiwashiB
d.miniorR = {hp = 60, atk = 100, def = 60, spatk = 100, spdef = 60, spe = 120}
d['774R'] = d.miniorR
d.necrozmaV = {hp = 97, atk = 157, def = 127, spatk = 113, spdef = 109, spe = 77}
d['800V'] = d.necrozmaV
d.necrozmaA = {hp = 97, atk = 113, def = 109, spatk = 157, spdef = 127, spe = 77}
d['800A'] = d.necrozmaA
d.necrozmaU = {hp = 97, atk = 167, def = 97, spatk = 167, spdef = 97, spe = 129}
d['800U'] = d.necrozmaU
d.eiscueL = {hp = 75, atk = 80, def = 70, spatk = 65, spdef = 50, spe = 130}
d['875L'] = d.eiscueL
d.indeedeeF = {hp = 70, atk = 55, def = 65, spatk = 95, spdef = 105, spe = 85}
d['876F'] = d.indeedeeF
d.zacianR = {hp = 92, atk = 170, def = 115, spatk = 80, spdef = 115, spe = 148}
d['888R'] = d.zacianR
d.zamazentaR = {hp = 92, atk = 130, def = 145, spatk = 80, spdef = 145, spe = 128}
d['889R'] = d.zamazentaR
d.eternatusD = {hp = 255, atk = 115, def = 250, spatk = 125, spdef = 250, spe = 130}
d['890D'] = d.eternatusD
d.calyrexG = {hp = 100, atk = 165, def = 150, spatk = 85, spdef = 130, spe = 50}
d['898G'] = d.calyrexG
d.calyrexS = {hp = 100, atk = 85, def = 80, spatk = 165, spdef = 100, spe = 150}
d['898S'] = d.calyrexS

-- Mega evolutions and Primal reversions
d.venusaurM = {hp = 80, atk = 100, def = 123, spatk = 122, spdef = 120, spe = 80}
d['003M'] = d.venusaurM
d.charizardMX = {hp = 78, atk = 130, def = 111, spatk = 130, spdef = 85, spe = 100}
d['006MX'] = d.charizardMX
d.charizardMY = {hp = 78, atk = 104, def = 78, spatk = 159, spdef = 115, spe = 100}
d['006MY'] = d.charizardMY
d.blastoiseM = {hp = 79, atk = 103, def = 120, spatk = 135, spdef = 115, spe = 78}
d['009M'] = d.blastoiseM
d.beedrillM = {hp = 65, atk = 150, def = 40, spatk = 15, spdef = 80, spe = 145}
d['015M'] = d.beedrillM
d.pidgeotM = {hp = 83, atk = 80, def = 80, spatk = 135, spdef = 80, spe = 121}
d['018M'] = d.pidgeotM
d.alakazamM = {hp = 55, atk = 50, def = 65, spatk = 175, spdef = {[6] = 95, [7] = 105}, spe = 150}
d['065M'] = d.alakazamM
d.slowbroM = {hp = 95, atk = 75, def = 180, spatk = 130, spdef = 80, spe = 30}
d['080M'] = d.slowbroM
d.gengarM = {hp = 60, atk = 65, def = 80, spatk = 170, spdef = 95, spe = 130}
d['094M'] = d.gengarM
d.kangaskhanM = {hp = 105, atk = 125, def = 100, spatk = 60, spdef = 100, spe = 100}
d['115M'] = d.kangaskhanM
d.pinsirM = {hp = 65, atk = 155, def = 120, spatk = 65, spdef = 90, spe = 105}
d['127M'] = d.pinsirM
d.gyaradosM = {hp = 95, atk = 155, def = 109, spatk = 70, spdef = 130, spe = 81}
d['130M'] = d.gyaradosM
d.aerodactylM = {hp = 80, atk = 135, def = 85, spatk = 70, spdef = 95, spe = 150}
d['142M'] = d.aerodactylM
d.mewtwoMX = {hp = 106, atk = 190, def = 100, spatk = 154, spdef = 100, spe = 130}
d['150MX'] = d.mewtwoMX
d.mewtwoMY = {hp = 106, atk = 150, def = 70, spatk = 194, spdef = 120, spe = 140}
d['150MY'] = d.mewtwoMY
d.ampharosM = {hp = 90, atk = 95, def = 105, spatk = 165, spdef = 110, spe = 45}
d['181M'] = d.ampharosM
d.steelixM = {hp = 75, atk = 125, def = 230, spatk = 55, spdef = 95, spe = 30}
d['208M'] = d.steelixM
d.scizorM = {hp = 70, atk = 150, def = 140, spatk = 65, spdef = 100, spe = 75}
d['212M'] = d.scizorM
d.heracrossM = {hp = 80, atk = 185, def = 115, spatk = 40, spdef = 105, spe = 75}
d['214M'] = d.heracrossM
d.houndoomM = {hp = 75, atk = 90, def = 90, spatk = 140, spdef = 90, spe = 115}
d['229M'] = d.houndoomM
d.tyranitarM = {hp = 100, atk = 164, def = 150, spatk = 95, spdef = 120, spe = 71}
d['248M'] = d.tyranitarM
d.sceptileM = {hp = 70, atk = 110, def = 75, spatk = 145, spdef = 85, spe = 145}
d['254M'] = d.sceptileM
d.blazikenM = {hp = 80, atk = 160, def = 80, spatk = 130, spdef = 80, spe = 100}
d['257M'] = d.blazikenM
d.swampertM = {hp = 100, atk = 150, def = 110, spatk = 95, spdef = 110, spe = 70}
d['260M'] = d.swampertM
d.gardevoirM = {hp = 68, atk = 85, def = 65, spatk = 165, spdef = 135, spe = 100}
d['282M'] = d.gardevoirM
d.sableyeM = {hp = 50, atk = 85, def = 125, spatk = 85, spdef = 115, spe = 20}
d['302M'] = d.sableyeM
d.mawileM = {hp = 50, atk = 105, def = 125, spatk = 55, spdef = 95, spe = 50}
d['303M'] = d.mawileM
d.aggronM = {hp = 70, atk = 140, def = 230, spatk = 60, spdef = 80, spe = 50}
d['306M'] = d.aggronM
d.medichamM = {hp = 60, atk = 100, def = 85, spatk = 80, spdef = 85, spe = 100}
d['308M'] = d.medichamM
d.manectricM = {hp = 70, atk = 75, def = 80, spatk = 135, spdef = 80, spe = 135}
d['310M'] = d.manectricM
d.sharpedoM = {hp = 70, atk = 140, def = 70, spatk = 110, spdef = 65, spe = 105}
d['319M'] = d.sharpedoM
d.cameruptM = {hp = 70, atk = 120, def = 100, spatk = 145, spdef = 105, spe = 20}
d['323M'] = d.cameruptM
d.altariaM = {hp = 75, atk = 110, def = 110, spatk = 110, spdef = 105, spe = 80}
d['334M'] = d.altariaM
d.banetteM = {hp = 64, atk = 165, def = 75, spatk = 93, spdef = 83, spe = 75}
d['354M'] = d.banetteM
d.absolM = {hp = 65, atk = 150, def = 60, spatk = 115, spdef = 60, spe = 115}
d['359M'] = d.absolM
d.glalieM = {hp = 80, atk = 120, def = 80, spatk = 120, spdef = 80, spe = 100}
d['362M'] = d.glalieM
d.salamenceM = {hp = 95, atk = 145, def = 130, spatk = 120, spdef = 90, spe = 120}
d['373M'] = d.salamenceM
d.metagrossM = {hp = 80, atk = 145, def = 150, spatk = 105, spdef = 110, spe = 110}
d['376M'] = d.metagrossM
d.latiasM = {hp = 80, atk = 100, def = 120, spatk = 140, spdef = 150, spe = 110}
d['380M'] = d.latiasM
d.latiosM = {hp = 80, atk = 130, def = 100, spatk = 160, spdef = 120, spe = 110}
d['381M'] = d.latiosM
d.rayquazaM = {hp = 105, atk = 180, def = 100, spatk = 180, spdef = 100, spe = 115}
d['384M'] = d.rayquazaM
d.lopunnyM = {hp = 65, atk = 136, def = 94, spatk = 54, spdef = 96, spe = 135}
d['428M'] = d.lopunnyM
d.garchompM = {hp = 108, atk = 170, def = 115, spatk = 120, spdef = 95, spe = 92}
d['445M'] = d.garchompM
d.lucarioM = {hp = 70, atk = 145, def = 88, spatk = 140, spdef = 70, spe = 112}
d['448M'] = d.lucarioM
d.abomasnowM = {hp = 90, atk = 132, def = 105, spatk = 132, spdef = 105, spe = 30}
d['460M'] = d.abomasnowM
d.galladeM = {hp = 68, atk = 165, def = 95, spatk = 65, spdef = 115, spe = 110}
d['475M'] = d.galladeM
d.audinoM = {hp = 103, atk = 60, def = 126, spatk = 80, spdef = 126, spe = 50}
d['531M'] = d.audinoM
d.diancieM = {hp = 50, atk = 160, def = 110, spatk = 160, spdef = 110, spe = 110}
d['719M'] = d.diancieM
d.kyogreA = {hp = 100, atk = 150, def = 90, spatk = 180, spdef = 160, spe = 90}
d['382A'] = d.kyogreA
d.groudonA = {hp = 100, atk = 180, def = 160, spatk = 150, spdef = 90, spe = 90}
d['383A'] = d.groudonA

-- Alolan forms
d.rattataA = {hp = 30, atk = 56, def = 35, spatk = 25, spdef = 35, spe = 72}
d['019A'] = d.rattataA
d.raticateA = {hp = 75, atk = 71, def = 70, spatk = 40, spdef = 80, spe = 77}
d['020A'] = d.raticateA
d.raichuA = {hp = 60, atk = 85, def = 50, spatk = 95, spdef = 85, spe = 110}
d['026A'] = d.raichuA
d.sandshrewA = {hp = 50, atk = 75, def = 90, spatk = 10, spdef = 35, spe = 40}
d['027A'] = d.sandshrewA
d.sandslashA = {hp = 75, atk = 100, def = 120, spatk = 25, spdef = 65, spe = 65}
d['028A'] = d.sandslashA
d.vulpixA = {hp = 38, atk = 41, def = 40, spatk = 50, spdef = 65, spe = 65}
d['037A'] = d.vulpixA
d.ninetalesA = {hp = 73, atk = 67, def = 75, spatk = 81, spdef = 100, spe = 109}
d['038A'] = d.ninetalesA
d.diglettA = {hp = 10, atk = 55, def = 30, spatk = 35, spdef = 45, spe = 90}
d['050A'] = d.diglettA
d.dugtrioA = {hp = 35, atk = 100, def = 60, spatk = 50, spdef = 70, spe = 110}
d['051A'] = d.dugtrioA
d.meowthA = {hp = 40, atk = 35, def = 35, spatk = 50, spdef = 40, spe = 90}
d['052A'] = d.meowthA
d.persianA = {hp = 65, atk = 60, def = 60, spatk = 75, spdef = 65, spe = 115}
d['053A'] = d.persianA
d.geodudeA = {hp = 40, atk = 80, def = 100, spatk = 30, spdef = 30, spe = 20}
d['074A'] = d.geodudeA
d.gravelerA = {hp = 55, atk = 95, def = 115, spatk = 45, spdef = 45, spe = 35}
d['075A'] = d.gravelerA
d.golemA = {hp = 80, atk = 120, def = 130, spatk = 55, spdef = 65, spe = 45}
d['076A'] = d.golemA
d.grimerA = {hp = 80, atk = 80, def = 50, spatk = 40, spdef = 50, spe = 25}
d['088A'] = d.grimerA
d.mukA = {hp = 105, atk = 105, def = 75, spatk = 65, spdef = 100, spe = 50}
d['089A'] = d.mukA
d.exeggutorA = {hp = 95, atk = 105, def = 85, spatk = 125, spdef = 75, spe = 45}
d['103A'] = d.exeggutorA
d.marowakA = {hp = 60, atk = 80, def = 110, spatk = 50, spdef = 80, spe = 45}
d['105A'] = d.marowakA

-- Galarian forms
d.meowthG = {hp = 50, atk = 65, def = 55, spatk = 40, spdef = 40, spe = 40}
d['052G'] = d.meowthG
d.ponytaG = {hp = 50, atk = 85, def = 55, spatk = 65, spdef = 65, spe = 90}
d['077G'] = d.ponytaG
d.rapidashG = {hp = 65, atk = 100, def = 70, spatk = 80, spdef = 80, spe = 105}
d['078G'] = d.rapidashG
d.slowpokeG = {hp = 90, atk = 65, def = 65, spatk = 40, spdef = 40, spe = 15}
d['079G'] = d.slowpokeG
d.slowbroG = {hp = 95, atk = 100, def = 95, spatk = 100, spdef = 70, spe = 30}
d['080G'] = d.slowbroG
d["farfetch'dG"] = {hp = 52, atk = 95, def = 55, spatk = 58, spdef = 62, spe = 55}
d['083G'] = d["farfetch'dG"]
d.weezingG = {hp = 65, atk = 90, def = 120, spatk = 85, spdef = 70, spe = 60}
d['110G'] = d.weezingG
d["mr. mimeG"] = {hp = 50, atk = 65, def = 65, spatk = 90, spdef = 90, spe = 100}
d['122G'] = d['mr. mimeG']
d.corsolaG = {hp = 60, atk = 55, def = 100, spatk = 65, spdef = 100, spe = 30}
d['222G'] = d.corsolaG
d.slowkingG = {hp = 95, atk = 65, def = 80, spatk = 110, spdef = 110, spe = 30}
d['199G'] = d.slowkingG
d.zigzagoonG = {hp = 38, atk = 30, def = 41, spatk = 30, spdef = 41, spe = 60}
d['263G'] = d.zigzagoonG
d.linooneG = {hp = 78, atk = 70, def = 61, spatk = 50, spdef = 61, spe = 100}
d['264G'] = d.linooneG
d.darumakaG = {hp = 70, atk = 90, def = 45, spatk = 15, spdef = 45, spe = 50}
d['554G'] = d.darumakaG
d.darmanitanG = {hp = 105, atk = 140, def = 55, spatk = 30, spdef = 55, spe = 95}
d['555G'] = d.darmanitanG
d.darmanitanGZ = {hp = 105, atk = 160, def = 55, spatk = 30, spdef = 55, spe = 135}
d['555GZ'] = d.darmanitanGZ
d.yamaskG = {hp = 38, atk = 55, def = 85, spatk = 30, spdef = 65, spe = 30}
d['562G'] = d.yamaskG
d.stunfiskG = {hp = 109, atk = 81, def = 99, spatk = 66, spdef = 84, spe = 32}
d['618G'] = d.stunfiskG

-- Other non-useless alternative forms aliases
d['025Cs'], d['025R'], d['025D'] = d.pikachu, d.pikachu, d.pikachu
d['025Cn'], d['025S'], d['025W'] = d.pikachu, d.pikachu, d.pikachu
d.pikachuCs, d.pikachuR, d.pikachuD = d.pikachu, d.pikachu, d.pikachu
d.pikachuCn, d.pikachuS, d.pikachuW = d.pikachu, d.pikachu, d.pikachu
d['351S'], d['351P'], d['351N'] = d.castform, d.castform, d.castform
d.castformS, d.castformP, d.castformN = d.castform, d.castform, d.castform
d['493L'], d['493Vo'], d['493Ve'] = d.arceus, d.arceus, d.arceus
d.arceusL, d.arceusVo, d.arceusVe = d.arceus, d.arceus, d.arceus
d['493T'], d['493R'], d['493C'] = d.arceus, d.arceus, d.arceus
d.arceusT, d.arceusR, d.arceusC = d.arceus, d.arceus, d.arceus
d['493S'], d['493Ai'], d['493Fu'] = d.arceus, d.arceus, d.arceus
d.arceusS, d.arceusAi, d.arceusFu = d.arceus, d.arceus, d.arceus
d['493Aq'], d['493Er'], d['493El'] = d.arceus, d.arceus, d.arceus
d.arceusAq, d.arceusEr, d.arceusEl = d.arceus, d.arceus, d.arceus
d['493P'], d['493G'], d['493D'] = d.arceus, d.arceus, d.arceus
d.arceusP, d.arceusG, d.arceusD = d.arceus, d.arceus, d.arceus
d['493B'], d['493Fo'], d['493Sc'] = d.arceus, d.arceus, d.arceus
d.arceusB, d.arceusFo, d.arceusSc = d.arceus, d.arceus, d.arceus
d['550B'], d.basculinB = d.basculin, d.basculin
d['678F'], d.meowsticF = d.meowstic, d.meowstic
d['741C'], d['741H'], d['741B'] = d.oricorio, d.oricorio, d.oricorio
d.oricorioC, d.oricorioH, d.oricorioB = d.oricorio, d.oricorio, d.oricorio
d['773L'], d['773Vo'], d['773Ve'] = d.silvally, d.silvally, d.silvally
d.silvallyL, d.silvallyVo, d.silvallyVe = d.silvally, d.silvally, d.silvally
d['773T'], d['773R'], d['773C'] = d.silvally, d.silvally, d.silvally
d.silvallyT, d.silvallyR, d.silvallyC = d.silvally, d.silvally, d.silvally
d['773S'], d['773Ai'], d['773Fu'] = d.silvally, d.silvally, d.silvally
d.silvallyS, d.silvallyAi, d.silvallyFu = d.silvally, d.silvally, d.silvally
d['773Aq'], d['773Er'], d['773El'] = d.silvally, d.silvally, d.silvally
d.silvallyAq, d.silvallyEr, d.silvallyEl = d.silvally, d.silvally, d.silvally
d['773P'], d['773G'], d['773D'] = d.silvally, d.silvally, d.silvally
d.silvallyP, d.silvallyG, d.silvallyD = d.silvally, d.silvally, d.silvally
d['773B'], d['773Fo'] = d.silvally, d.silvally
d.silvallyB, d.silvallyFo = d.silvally, d.silvally
-- d.cramorantT = d.cramorant
-- d['845T'] = d.cramorantT
-- d.cramorantI = d.cramorant
-- d['845I'] = d.cramorantI
d.toxtricityB = d.toxtricity
d['849B'] = d.toxtricityB
d.morpekoV = d.morpeko
d['877V'] = d.morpekoV
d.urshifuP, d['892P'] = d.urshifu, d.urshifu

-- Gigamax
d.venusaurGi, d['003Gi'] = d.venusaur, d.venusaur
d.charizardGi, d['006Gi'] = d.charizard, d.charizard
d.blastoiseGi, d['009Gi'] = d.blastoise, d.blastoise
d.butterfreeGi, d['012Gi'] = d.butterfree, d.butterfree
d.pikachuGi, d['025Gi'] = d.pikachu, d.pikachu
d.meowthGi, d['052Gi'] = d.meowth, d.meowth
d.machampGi, d['068Gi'] = d.machamp, d.machamp
d.gengarGi, d['094Gi'] = d.gengar, d.gengar
d.kinglerGi, d['099Gi'] = d.kingler, d.kingler
d.laprasGi, d['131Gi'] = d.lapras, d.lapras
d.eeveeGi, d['133Gi'] = d.eevee, d.eevee
d.snorlaxGi, d['143Gi'] = d.snorlax, d.snorlax
d.garbodorGi, d['569Gi'] = d.garbodor, d.garbodor
d.melmetalGi, d['809Gi'] = d.melmetal, d.melmetal
d.rillaboomGi, d['812Gi'] = d.rillaboom, d.rillaboom
d.cinderaceGi, d['815Gi'] = d.cinderace, d.cinderace
d.inteleonGi, d['818Gi'] = d.inteleon, d.inteleon
d.corviknightGi, d['823Gi'] = d.corviknight, d.corviknight
d.orbeetleGi, d['826Gi'] = d.orbeetle, d.orbeetle
d.drednawGi, d['834Gi'] = d.drednaw, d.drednaw
d.coalossalGi, d['839Gi'] = d.coalossal, d.coalossal
d.flappleGi, d['841Gi'] = d.flapple, d.flapple
d.appletunGi, d['842Gi'] = d.appletun, d.appletun
d.sandacondaGi, d['844Gi'] = d.sandaconda, d.sandaconda
d.toxtricityGi, d['849Gi'] = d.toxtricity, d.toxtricity
d.centiskorchGi, d['851Gi'] = d.centiskorch, d.centiskorch
d.hattereneGi, d['858Gi'] = d.hatterene, d.hatterene
d.grimmsnarlGi, d['861Gi'] = d.grimmsnarl, d.grimmsnarl
d.alcremieGi, d['869Gi'] = d.alcremie, d.alcremie
d.copperajahGi, d['879Gi'] = d.copperajah, d.copperajah
d.duraludonGi, d['884Gi'] = d.duraludon, d.duraludon
d.urshifuGi, d['892Gi'] = d.urshifu, d.urshifu
d.urshifuPGi, d['892PGi'] = d.urshifuP, d.urshifuP

return d
