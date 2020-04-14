--[[

Data module for effort value yield

--]]

local e = {}

e.bulbasaur = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[001] = e.bulbasaur
e.ivysaur = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 1, spe = 0}
e[002] = e.ivysaur
e.venusaur = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 1, spe = 0}
e[003] = e.venusaur
e.charmander = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[004] = e.charmander
e.charmeleon = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[005] = e.charmeleon
e.charizard = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[006] = e.charizard
e.squirtle = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[007] = e.squirtle
e.wartortle = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[008] = e.wartortle
e.blastoise = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[009] = e.blastoise
e.caterpie = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[010] = e.caterpie
e.metapod = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[011] = e.metapod
e.butterfree = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 1, spe = 0}
e[012] = e.butterfree
e.weedle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[013] = e.weedle
e.kakuna = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[014] = e.kakuna
e.beedrill = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 1, spe = 0}
e[015] = e.beedrill
e.pidgey = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[016] = e.pidgey
e.pidgeotto = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[017] = e.pidgeotto
e.pidgeot = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[018] = e.pidgeot
e.rattata = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[019] = e.rattata
e.raticate = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[020] = e.raticate
e.spearow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[021] = e.spearow
e.fearow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[022] = e.fearow
e.ekans = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[023] = e.ekans
e.arbok = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[024] = e.arbok
e.pikachu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[025] = e.pikachu
e.raichu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[026] = e.raichu
e.sandshrew = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[027] = e.sandshrew
e.sandslash = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[028] = e.sandslash
e['nidoran♀'] = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[029] = e['nidoran♀']
e.nidorina = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[030] = e.nidorina
e.nidoqueen = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[031] = e.nidoqueen
e['nidoran♂'] = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[032] = e['nidoran♂']
e.nidorino = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[033] = e.nidorino
e.nidoking = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[034] = e.nidoking
e.clefairy = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[035] = e.clefairy
e.clefable = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[036] = e.clefable
e.vulpix = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[037] = e.vulpix
e.ninetales = {hp = 0, atk = 0, def = 0, spatk = {[3] = 1, [5] = 0}, spdef = 1, spe = {[3] = 0, [5] = 1}}
e[038] = e.ninetales
e.ninetalesA = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e['038A'] = e.ninetalesA
e.jigglypuff = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[039] = e.jigglypuff
e.wigglytuff = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[040] = e.wigglytuff
e.zubat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[041] = e.zubat
e.golbat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[042] = e.golbat
e.oddish = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[043] = e.oddish
e.gloom = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[044] = e.gloom
e.vileplume = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[045] = e.vileplume
e.paras = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[046] = e.paras
e.parasect = {hp = 0, atk = 2, def = 1, spatk = 0, spdef = 0, spe = 0}
e[047] = e.parasect
e.venonat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[048] = e.venonat
e.venomoth = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[049] = e.venomoth
e.diglett = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[050] = e.diglett
e.dugtrio = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[051] = e.dugtrio
e.dugtrioA = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e['051A'] = e.dugtrioA
e.meowth = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[052] = e.meowth
e.persian = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[053] = e.persian
e.psyduck = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[054] = e.psyduck
e.golduck = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[055] = e.golduck
e.mankey = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[056] = e.mankey
e.primeape = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[057] = e.primeape
e.growlithe = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[058] = e.growlithe
e.arcanine = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[059] = e.arcanine
e.poliwag = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[060] = e.poliwag
e.poliwhirl = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[061] = e.poliwhirl
e.poliwrath = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[062] = e.poliwrath
e.abra = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[063] = e.abra
e.kadabra = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[064] = e.kadabra
e.alakazam = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[065] = e.alakazam
e.machop = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[066] = e.machop
e.machoke = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[067] = e.machoke
e.machamp = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[068] = e.machamp
e.bellsprout = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[069] = e.bellsprout
e.weepinbell = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[070] = e.weepinbell
e.victreebel = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[071] = e.victreebel
e.tentacool = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[072] = e.tentacool
e.tentacruel = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[073] = e.tentacruel
e.geodude = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[074] = e.geodude
e.graveler = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[075] = e.graveler
e.golem = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[076] = e.golem
e.ponyta = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[077] = e.ponyta
e.rapidash = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[078] = e.rapidash
e.slowpoke = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[079] = e.slowpoke
e.slowbro = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[080] = e.slowbro
e.magnemite = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[081] = e.magnemite
e.magneton = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[082] = e.magneton
e["farfetch'd"] = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[083] = e["farfetch'd"]
e.doduo = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[084] = e.doduo
e.dodrio = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[085] = e.dodrio
e.seel = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[086] = e.seel
e.dewgong = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[087] = e.dewgong
e.grimer = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[088] = e.grimer
e.muk = {hp = 1, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[089] = e.muk
e.shellder = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[090] = e.shellder
e.cloyster = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[091] = e.cloyster
e.gastly = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[092] = e.gastly
e.haunter = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[093] = e.haunter
e.gengar = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[094] = e.gengar
e.onix = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[095] = e.onix
e.drowzee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[096] = e.drowzee
e.hypno = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[097] = e.hypno
e.krabby = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[098] = e.krabby
e.kingler = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[099] = e.kingler
e.voltorb = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[100] = e.voltorb
e.electrode = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[101] = e.electrode
e.exeggcute = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[102] = e.exeggcute
e.exeggutor = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[103] = e.exeggutor
e.cubone = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[104] = e.cubone
e.marowak = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[105] = e.marowak
e.hitmonlee = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[106] = e.hitmonlee
e.hitmonchan = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[107] = e.hitmonchan
e.lickitung = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[108] = e.lickitung
e.koffing = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[109] = e.koffing
e.weezing = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[110] = e.weezing
e.rhyhorn = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[111] = e.rhyhorn
e.rhydon = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[112] = e.rhydon
e.chansey = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[113] = e.chansey
e.tangela = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[114] = e.tangela
e.kangaskhan = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[115] = e.kangaskhan
e.horsea = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[116] = e.horsea
e.seadra = {hp = 0, atk = 0, def = 1, spatk = 1, spdef = 0, spe = 0}
e[117] = e.seadra
e.goldeen = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[118] = e.goldeen
e.seaking = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[119] = e.seaking
e.staryu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[120] = e.staryu
e.starmie = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[121] = e.starmie
e['mr. mime'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[122] = e['mr. mime']
e.scyther = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[123] = e.scyther
e.jynx = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[124] = e.jynx
e.electabuzz = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[125] = e.electabuzz
e.magmar = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[126] = e.magmar
e.pinsir = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[127] = e.pinsir
e.tauros = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 1}
e[128] = e.tauros
e.magikarp = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[129] = e.magikarp
e.gyarados = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[130] = e.gyarados
e.lapras = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[131] = e.lapras
e.ditto = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[132] = e.ditto
e.eevee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[133] = e.eevee
e.vaporeon = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[134] = e.vaporeon
e.jolteon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[135] = e.jolteon
e.flareon = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[136] = e.flareon
e.porygon = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[137] = e.porygon
e.omanyte = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[138] = e.omanyte
e.omastar = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[139] = e.omastar
e.kabuto = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[140] = e.kabuto
e.kabutops = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[141] = e.kabutops
e.aerodactyl = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[142] = e.aerodactyl
e.snorlax = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[143] = e.snorlax
e.articuno = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[144] = e.articuno
e.zapdos = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[145] = e.zapdos
e.moltres = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[146] = e.moltres
e.dratini = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[147] = e.dratini
e.dragonair = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[148] = e.dragonair
e.dragonite = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[149] = e.dragonite
e.mewtwo = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[150] = e.mewtwo
e.mew = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[151] = e.mew
e.chikorita = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[152] = e.chikorita
e.bayleef = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[153] = e.bayleef
e.meganium = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 2, spe = 0}
e[154] = e.meganium
e.cyndaquil = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[155] = e.cyndaquil
e.quilava = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[156] = e.quilava
e.typhlosion = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[157] = e.typhlosion
e.totodile = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[158] = e.totodile
e.croconaw = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[159] = e.croconaw
e.feraligatr = {hp = 0, atk = 2, def = 1, spatk = 0, spdef = 0, spe = 0}
e[160] = e.feraligatr
e.sentret = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[161] = e.sentret
e.furret = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[162] = e.furret
e.hoothoot = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[163] = e.hoothoot
e.noctowl = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[164] = e.noctowl
e.ledyba = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[165] = e.ledyba
e.ledian = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[166] = e.ledian
e.spinarak = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[167] = e.spinarak
e.ariados = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[168] = e.ariados
e.crobat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[169] = e.crobat
e.chinchou = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[170] = e.chinchou
e.lanturn = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[171] = e.lanturn
e.pichu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[172] = e.pichu
e.cleffa = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[173] = e.cleffa
e.igglybuff = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[174] = e.igglybuff
e.togepi = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[175] = e.togepi
e.togetic = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[176] = e.togetic
e.natu = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[177] = e.natu
e.xatu = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[178] = e.xatu
e.mareep = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[179] = e.mareep
e.flaaffy = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[180] = e.flaaffy
e.ampharos = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[181] = e.ampharos
e.bellossom = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[182] = e.bellossom
e.marill = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[183] = e.marill
e.azumarill = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[184] = e.azumarill
e.sudowoodo = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[185] = e.sudowoodo
e.politoed = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[186] = e.politoed
e.hoppip = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[187] = e.hoppip
e.skiploom = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[188] = e.skiploom
e.jumpluff = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[189] = e.jumpluff
e.aipom = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[190] = e.aipom
e.sunkern = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[191] = e.sunkern
e.sunflora = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[192] = e.sunflora
e.yanma = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[193] = e.yanma
e.wooper = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[194] = e.wooper
e.quagsire = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[195] = e.quagsire
e.espeon = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[196] = e.espeon
e.umbreon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[197] = e.umbreon
e.murkrow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[198] = e.murkrow
e.slowking = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[199] = e.slowking
e.misdreavus = {hp = 0, atk = 0, def = 0, spatk = {[3] = 1, [4] = 0}, spdef = 1, spe = 0}
e[200] = e.misdreavus
e.unown = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[201] = e.unown
e.wobbuffet = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[202] = e.wobbuffet
e.girafarig = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[203] = e.girafarig
e.pineco = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[204] = e.pineco
e.forretress = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[205] = e.forretress
e.dunsparce = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[206] = e.dunsparce
e.gligar = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[207] = e.gligar
e.steelix = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[208] = e.steelix
e.snubbull = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[209] = e.snubbull
e.granbull = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[210] = e.granbull
e.qwilfish = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[211] = e.qwilfish
e.scizor = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[212] = e.scizor
e.shuckle = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[213] = e.shuckle
e.heracross = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[214] = e.heracross
e.sneasel = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[215] = e.sneasel
e.teddiursa = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[216] = e.teddiursa
e.ursaring = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[217] = e.ursaring
e.slugma = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[218] = e.slugma
e.magcargo = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[219] = e.magcargo
e.swinub = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[220] = e.swinub
e.piloswine = {hp = 1, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[221] = e.piloswine
e.corsola = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[222] = e.corsola
e.remoraid = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[223] = e.remoraid
e.octillery = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[224] = e.octillery
e.delibird = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[225] = e.delibird
e.mantine = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[226] = e.mantine
e.skarmory = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[227] = e.skarmory
e.houndour = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[228] = e.houndour
e.houndoom = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[229] = e.houndoom
e.kingdra = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 1, spe = 0}
e[230] = e.kingdra
e.phanpy = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[231] = e.phanpy
e.donphan = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[232] = e.donphan
e.porygon2 = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[233] = e.porygon2
e.stantler = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[234] = e.stantler
e.smeargle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[235] = e.smeargle
e.tyrogue = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[236] = e.tyrogue
e.hitmontop = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[237] = e.hitmontop
e.smoochum = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[238] = e.smoochum
e.elekid = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[239] = e.elekid
e.magby = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[240] = e.magby
e.miltank = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[241] = e.miltank
e.blissey = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[242] = e.blissey
e.raikou = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 2}
e[243] = e.raikou
e.entei = {hp = 1, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[244] = e.entei
e.suicune = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 2, spe = 0}
e[245] = e.suicune
e.larvitar = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[246] = e.larvitar
e.pupitar = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[247] = e.pupitar
e.tyranitar = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[248] = e.tyranitar
e.lugia = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[249] = e.lugia
e['ho-oh'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[250] = e['ho-oh']
e.celebi = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[251] = e.celebi
e.treecko = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[252] = e.treecko
e.grovyle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[253] = e.grovyle
e.sceptile = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[254] = e.sceptile
e.torchic = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[255] = e.torchic
e.combusken = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[256] = e.combusken
e.blaziken = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[257] = e.blaziken
e.mudkip = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[258] = e.mudkip
e.marshtomp = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[259] = e.marshtomp
e.swampert = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[260] = e.swampert
e.poochyena = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[261] = e.poochyena
e.mightyena = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[262] = e.mightyena
e.zigzagoon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[263] = e.zigzagoon
e.linoone = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[264] = e.linoone
e.wurmple = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[265] = e.wurmple
e.silcoon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[266] = e.silcoon
e.beautifly = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[267] = e.beautifly
e.cascoon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[268] = e.cascoon
e.dustox = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[269] = e.dustox
e.lotad = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[270] = e.lotad
e.lombre = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[271] = e.lombre
e.ludicolo = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[272] = e.ludicolo
e.seedot = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[273] = e.seedot
e.nuzleaf = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[274] = e.nuzleaf
e.shiftry = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[275] = e.shiftry
e.taillow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[276] = e.taillow
e.swellow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[277] = e.swellow
e.wingull = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[278] = e.wingull
e.pelipper = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[279] = e.pelipper
e.ralts = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[280] = e.ralts
e.kirlia = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[281] = e.kirlia
e.gardevoir = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[282] = e.gardevoir
e.surskit = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[283] = e.surskit
e.masquerain = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 1, spe = 0}
e[284] = e.masquerain
e.shroomish = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[285] = e.shroomish
e.breloom = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[286] = e.breloom
e.slakoth = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[287] = e.slakoth
e.vigoroth = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[288] = e.vigoroth
e.slaking = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[289] = e.slaking
e.nincada = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[290] = e.nincada
e.ninjask = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[291] = e.ninjask
e.shedinja = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[292] = e.shedinja
e.whismur = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[293] = e.whismur
e.loudred = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[294] = e.loudred
e.exploud = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[295] = e.exploud
e.makuhita = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[296] = e.makuhita
e.hariyama = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[297] = e.hariyama
e.azurill = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[298] = e.azurill
e.nosepass = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[299] = e.nosepass
e.skitty = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[300] = e.skitty
e.delcatty = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[301] = e.delcatty
e.sableye = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[302] = e.sableye
e.mawile = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[303] = e.mawile
e.aron = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[304] = e.aron
e.lairon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[305] = e.lairon
e.aggron = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[306] = e.aggron
e.meditite = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[307] = e.meditite
e.medicham = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[308] = e.medicham
e.electrike = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[309] = e.electrike
e.manectric = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[310] = e.manectric
e.plusle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[311] = e.plusle
e.minun = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[312] = e.minun
e.volbeat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[313] = e.volbeat
e.illumise = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[314] = e.illumise
e.roselia = {hp = 0, atk = 0, def = 0, spatk = {[3] = 1, [4] = 2}, spdef = 0, spe = 0}
e[315] = e.roselia
e.gulpin = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[316] = e.gulpin
e.swalot = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[317] = e.swalot
e.carvanha = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[318] = e.carvanha
e.sharpedo = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[319] = e.sharpedo
e.wailmer = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[320] = e.wailmer
e.wailord = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[321] = e.wailord
e.numel = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[322] = e.numel
e.camerupt = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[323] = e.camerupt
e.torkoal = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[324] = e.torkoal
e.spoink = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[325] = e.spoink
e.grumpig = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[326] = e.grumpig
e.spinda = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[327] = e.spinda
e.trapinch = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[328] = e.trapinch
e.vibrava = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 1}
e[329] = e.vibrava
e.flygon = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 2}
e[330] = e.flygon
e.cacnea = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[331] = e.cacnea
e.cacturne = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[332] = e.cacturne
e.swablu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[333] = e.swablu
e.altaria = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[334] = e.altaria
e.zangoose = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[335] = e.zangoose
e.seviper = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[336] = e.seviper
e.lunatone = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[337] = e.lunatone
e.solrock = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[338] = e.solrock
e.barboach = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[339] = e.barboach
e.whiscash = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[340] = e.whiscash
e.corphish = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[341] = e.corphish
e.crawdaunt = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[342] = e.crawdaunt
e.baltoy = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[343] = e.baltoy
e.claydol = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[344] = e.claydol
e.lileep = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[345] = e.lileep
e.cradily = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[346] = e.cradily
e.anorith = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[347] = e.anorith
e.armaldo = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[348] = e.armaldo
e.feebas = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[349] = e.feebas
e.milotic = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[350] = e.milotic
e.castform = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[351] = e.castform
e.kecleon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[352] = e.kecleon
e.shuppet = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[353] = e.shuppet
e.banette = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[354] = e.banette
e.duskull = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[355] = e.duskull
e.dusclops = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[356] = e.dusclops
e.tropius = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[357] = e.tropius
e.chimecho = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 1, spe = 0}
e[358] = e.chimecho
e.absol = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[359] = e.absol
e.wynaut = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[360] = e.wynaut
e.snorunt = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[361] = e.snorunt
e.glalie = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[362] = e.glalie
e.spheal = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[363] = e.spheal
e.sealeo = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[364] = e.sealeo
e.walrein = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[365] = e.walrein
e.clamperl = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[366] = e.clamperl
e.huntail = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[367] = e.huntail
e.gorebyss = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[368] = e.gorebyss
e.relicanth = {hp = 1, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[369] = e.relicanth
e.luvdisc = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[370] = e.luvdisc
e.bagon = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[371] = e.bagon
e.shelgon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[372] = e.shelgon
e.salamence = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[373] = e.salamence
e.beldum = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[374] = e.beldum
e.metang = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[375] = e.metang
e.metagross = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[376] = e.metagross
e.regirock = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[377] = e.regirock
e.regice = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[378] = e.regice
e.registeel = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 1, spe = 0}
e[379] = e.registeel
e.latias = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[380] = e.latias
e.latios = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[381] = e.latios
e.kyogre = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[382] = e.kyogre
e.groudon = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[383] = e.groudon
e.rayquaza = {hp = 0, atk = 2, def = 0, spatk = 1, spdef = 0, spe = 0}
e[384] = e.rayquaza
e.jirachi = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[385] = e.jirachi
e.deoxys = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 1}
e[386] = e.deoxys
e.deoxysA = {hp = 0, atk = 2, def = 0, spatk = 1, spdef = 0, spe = 0}
e['386A'] = e.deoxysA
e.deoxysD = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 1, spe = 0}
e['386D'] = e.deoxysD
e.deoxysS = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e['386V'] = e.deoxysV
e.turtwig = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[387] = e.turtwig
e.grotle = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[388] = e.grotle
e.torterra = {hp = 0, atk = 2, def = 1, spatk = 0, spdef = 0, spe = 0}
e[389] = e.torterra
e.chimchar = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[390] = e.chimchar
e.monferno = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[391] = e.monferno
e.infernape = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 1}
e[392] = e.infernape
e.piplup = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[393] = e.piplup
e.prinplup = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[394] = e.prinplup
e.empoleon = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[395] = e.empoleon
e.starly = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[396] = e.starly
e.staravia = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[397] = e.staravia
e.staraptor = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[398] = e.staraptor
e.bidoof = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[399] = e.bidoof
e.bibarel = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[400] = e.bibarel
e.kricketot = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[401] = e.kricketot
e.kricketune = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[402] = e.kricketune
e.shinx = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[403] = e.shinx
e.luxio = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[404] = e.luxio
e.luxray = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[405] = e.luxray
e.budew = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[406] = e.budew
e.roserade = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[407] = e.roserade
e.cranidos = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[408] = e.cranidos
e.rampardos = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[409] = e.rampardos
e.shieldon = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[410] = e.shieldon
e.bastiodon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[411] = e.bastiodon
e.burmy = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[412] = e.burmy
e.wormadam = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[413] = e.wormadam
e.wormadamSa = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e['413Sa'] = e.wormadamSa
e.wormadamSc = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e['413Sc'] = e.wormadamSc
e.mothim = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[414] = e.mothim
e.combee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[415] = e.combee
e.vespiquen = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[416] = e.vespiquen
e.pachirisu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[417] = e.pachirisu
e.buizel = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[418] = e.buizel
e.floatzel = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[419] = e.floatzel
e.cherubi = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[420] = e.cherubi
e.cherrim = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[421] = e.cherrim
e.shellos = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[422] = e.shellos
e.gastrodon = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[423] = e.gastrodon
e.ambipom = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[424] = e.ambipom
e.drifloon = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[425] = e.drifloon
e.drifblim = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[426] = e.drifblim
e.buneary = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[427] = e.buneary
e.lopunny = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[428] = e.lopunny
e.mismagius = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 1, spe = 0}
e[429] = e.mismagius
e.honchkrow = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[430] = e.honchkrow
e.glameow = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[431] = e.glameow
e.purugly = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[432] = e.purugly
e.chingling = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[433] = e.chingling
e.stunky = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[434] = e.stunky
e.skuntank = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[435] = e.skuntank
e.bronzor = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[436] = e.bronzor
e.bronzong = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[437] = e.bronzong
e.bonsly = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[438] = e.bonsly
e['mime jr.'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[439] = e['mime jr.']
e.happiny = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[440] = e.happiny
e.chatot = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[441] = e.chatot
e.spiritomb = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[442] = e.spiritomb
e.gible = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[443] = e.gible
e.gabite = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[444] = e.gabite
e.garchomp = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[445] = e.garchomp
e.munchlax = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[446] = e.munchlax
e.riolu = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[447] = e.riolu
e.lucario = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[448] = e.lucario
e.hippopotas = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[449] = e.hippopotas
e.hippowdon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[450] = e.hippowdon
e.skorupi = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[451] = e.skorupi
e.drapion = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[452] = e.drapion
e.croagunk = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[453] = e.croagunk
e.toxicroak = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[454] = e.toxicroak
e.carnivine = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[455] = e.carnivine
e.finneon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[456] = e.finneon
e.lumineon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[457] = e.lumineon
e.mantyke = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[458] = e.mantyke
e.snover = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[459] = e.snover
e.abomasnow = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[460] = e.abomasnow
e.weavile = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 1}
e[461] = e.weavile
e.magnezone = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[462] = e.magnezone
e.lickilicky = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[463] = e.lickilicky
e.rhyperior = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[464] = e.rhyperior
e.tangrowth = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[465] = e.tangrowth
e.electivire = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[466] = e.electivire
e.magmortar = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[467] = e.magmortar
e.togekiss = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 1, spe = 0}
e[468] = e.togekiss
e.yanmega = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[469] = e.yanmega
e.leafeon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[470] = e.leafeon
e.glaceon = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[471] = e.glaceon
e.gliscor = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[472] = e.gliscor
e.mamoswine = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[473] = e.mamoswine
e['porygon-z'] = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[474] = e['porygon-z']
e.gallade = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[475] = e.gallade
e.probopass = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 2, spe = 0}
e[476] = e.probopass
e.dusknoir = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 2, spe = 0}
e[477] = e.dusknoir
e.froslass = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[478] = e.froslass
e.rotom = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[479] = e.rotom
e.uxie = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 1, spe = 0}
e[480] = e.uxie
e.mesprit = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 1, spe = 0}
e[481] = e.mesprit
e.azelf = {hp = 0, atk = 2, def = 0, spatk = 1, spdef = 0, spe = 0}
e[482] = e.azelf
e.dialga = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[483] = e.dialga
e.palkia = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[484] = e.palkia
e.heatran = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[485] = e.heatran
e.regigigas = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[486] = e.regigigas
e.giratina = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[487] = e.giratina
e.cresselia = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[488] = e.cresselia
e.phione = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[489] = e.phione
e.manaphy = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[490] = e.manaphy
e.darkrai = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 1}
e[491] = e.darkrai
e.shaymin = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[492] = e.shaymin
e.shayminC = {hp = {[4] = 3, [5] = 0}, atk = 0, def = 0, spatk = 0, spdef = 0, spe = {[4] = 0, [5] = 3}}
e[492] = e.shayminC
e.arceus = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[493] = e.arceus
e.victini = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[494] = e.victini
e.snivy = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[495] = e.snivy
e.servine = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[496] = e.servine
e.serperior = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[497] = e.serperior
e.tepig = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[498] = e.tepig
e.pignite = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[499] = e.pignite
e.emboar = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[500] = e.emboar
e.oshawott = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[501] = e.oshawott
e.dewott = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[502] = e.dewott
e.samurott = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[503] = e.samurott
e.patrat = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[504] = e.patrat
e.watchog = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0} -- 1 atk in Black and White
e[505] = e.watchog
e.lillipup = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[506] = e.lillipup
e.herdier = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[507] = e.herdier
e.stoutland = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[508] = e.stoutland
e.purrloin = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[509] = e.purrloin
e.liepard = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[510] = e.liepard
e.pansage = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[511] = e.pansage
e.simisage = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[512] = e.simisage
e.pansear = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[513] = e.pansear
e.simisear = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[514] = e.simisear
e.panpour = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[515] = e.panpour
e.simipour = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[516] = e.simipour
e.munna = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[517] = e.munna
e.musharna = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[518] = e.musharna
e.pidove = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[519] = e.pidove
e.tranquill = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[520] = e.tranquill
e.unfezant = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[521] = e.unfezant
e.blitzle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[522] = e.blitzle
e.zebstrika = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[523] = e.zebstrika
e.roggenrola = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[524] = e.roggenrola
e.boldore = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 0}
e[525] = e.boldore
e.gigalith = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[526] = e.gigalith
e.woobat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[527] = e.woobat
e.swoobat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[528] = e.swoobat
e.drilbur = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[529] = e.drilbur
e.excadrill = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[530] = e.excadrill
e.audino = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[531] = e.audino
e.timburr = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[532] = e.timburr
e.gurdurr = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[533] = e.gurdurr
e.conkeldurr = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[534] = e.conkeldurr
e.tympole = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[535] = e.tympole
e.palpitoad = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[536] = e.palpitoad
e.seismitoad = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[537] = e.seismitoad
e.throh = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[538] = e.throh
e.sawk = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[539] = e.sawk
e.sewaddle = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[540] = e.sewaddle
e.swadloon = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[541] = e.swadloon
e.leavanny = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[542] = e.leavanny
e.venipede = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[543] = e.venipede
e.whirlipede = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[544] = e.whirlipede
e.scolipede = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[545] = e.scolipede
e.cottonee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[546] = e.cottonee
e.whimsicott = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[547] = e.whimsicott
e.petilil = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[548] = e.petilil
e.lilligant = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[549] = e.lilligant
e.basculin = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[550] = e.basculin
e.sandile = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[551] = e.sandile
e.krokorok = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[552] = e.krokorok
e.krookodile = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[553] = e.krookodile
e.darumaka = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[554] = e.darumaka
e.darmanitan = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[555] = e.darmanitan
e.darmanitanZ = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e['555Z'] = e.darmanitanZ
e.maractus = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[556] = e.maractus
e.dwebble = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[557] = e.dwebble
e.crustle = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[558] = e.crustle
e.scraggy = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[559] = e.scraggy
e.scrafty = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[560] = e.scrafty
e.sigilyph = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[561] = e.sigilyph
e.yamask = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[562] = e.yamask
e.cofagrigus = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[563] = e.cofagrigus
e.tirtouga = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[564] = e.tirtouga
e.carracosta = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[565] = e.carracosta
e.archen = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[566] = e.archen
e.archeops = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[567] = e.archeops
e.trubbish = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[568] = e.trubbish
e.garbodor = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[569] = e.garbodor
e.zorua = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[570] = e.zorua
e.zoroark = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[571] = e.zoroark
e.minccino = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[572] = e.minccino
e.cinccino = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[573] = e.cinccino
e.gothita = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[574] = e.gothita
e.gothorita = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[575] = e.gothorita
e.gothitelle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[576] = e.gothitelle
e.solosis = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[577] = e.solosis
e.duosion = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[578] = e.duosion
e.reuniclus = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[579] = e.reuniclus
e.ducklett = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[580] = e.ducklett
e.swanna = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[581] = e.swanna
e.vanillite = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[582] = e.vanillite
e.vanillish = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[583] = e.vanillish
e.vanilluxe = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[584] = e.vanilluxe
e.deerling = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[585] = e.deerling
e.sawsbuck = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[586] = e.sawsbuck
e.emolga = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[587] = e.emolga
e.karrablast = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[588] = e.karrablast
e.escavalier = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[589] = e.escavalier
e.foongus = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[590] = e.foongus
e.amoonguss = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[591] = e.amoonguss
e.frillish = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[592] = e.frillish
e.jellicent = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[593] = e.jellicent
e.alomomola = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[594] = e.alomomola
e.joltik = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[595] = e.joltik
e.galvantula = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[596] = e.galvantula
e.ferroseed = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[597] = e.ferroseed
e.ferrothorn = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[598] = e.ferrothorn
e.klink = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[599] = e.klink
e.klang = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[600] = e.klang
e.klinklang = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[601] = e.klinklang
e.tynamo = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[602] = e.tynamo
e.eelektrik = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[603] = e.eelektrik
e.eelektross = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[604] = e.eelektross
e.elgyem = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[605] = e.elgyem
e.beheeyem = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[606] = e.beheeyem
e.litwick = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[607] = e.litwick
e.lampent = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[608] = e.lampent
e.chandelure = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[609] = e.chandelure
e.axew = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[610] = e.axew
e.fraxure = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[611] = e.fraxure
e.haxorus = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[612] = e.haxorus
e.cubchoo = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[613] = e.cubchoo
e.beartic = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[614] = e.beartic
e.cryogonal = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[615] = e.cryogonal
e.shelmet = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[616] = e.shelmet
e.accelgor = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[617] = e.accelgor
e.stunfisk = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[618] = e.stunfisk
e.mienfoo = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[619] = e.mienfoo
e.mienshao = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[620] = e.mienshao
e.druddigon = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[621] = e.druddigon
e.golett = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[622] = e.golett
e.golurk = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[623] = e.golurk
e.pawniard = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[624] = e.pawniard
e.bisharp = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[625] = e.bisharp
e.bouffalant = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[626] = e.bouffalant
e.rufflet = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[627] = e.rufflet
e.braviary = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[628] = e.braviary
e.vullaby = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[629] = e.vullaby
e.mandibuzz = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[630] = e.mandibuzz
e.heatmor = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[631] = e.heatmor
e.durant = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[632] = e.durant
e.deino = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[633] = e.deino
e.zweilous = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[634] = e.zweilous
e.hydreigon = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[635] = e.hydreigon
e.larvesta = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[636] = e.larvesta
e.volcarona = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[637] = e.volcarona
e.cobalion = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[638] = e.cobalion
e.terrakion = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[639] = e.terrakion
e.virizion = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[640] = e.virizion
e.tornadus = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[641] = e.tornadus
e.tornadusT = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e['641T'] = e.tornadusT
e.thundurus = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[642] = e.thundurus
e.thundurusT = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e['642T'] = e.thundurusT
e.reshiram = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[643] = e.reshiram
e.zekrom = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[644] = e.zekrom
e.landorus = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[645] = e.landorus
e.landorusT = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e['645T'] = e.landorusT
e.kyurem = {hp = 1, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e[646] = e.kyurem
e.kyuremB = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e['646B'] = e.kyuremB
e.kyuremN = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e['646N'] = e.kyuremN
e.keldeo = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[647] = e.keldeo
e.meloetta = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 1, spe = 1}
e[648] = e.meloetta
e.meloettaD = {hp = 0, atk = 1, def = 1, spatk = 0, spdef = 0, spe = 1}
e['648D'] = e.meloettaD
e.genesect = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 1}
e[649] = e.genesect
e.chespin = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[650] = e.chespin
e.quilladin = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[651] = e.quilladin
e.chesnaught = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[652] = e.chesnaught
e.fennekin = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[653] = e.fennekin
e.braixen = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[654] = e.braixen
e.delphox = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[655] = e.delphox
e.froakie = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[656] = e.froakie
e.frogadier = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[657] = e.frogadier
e.greninja = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[658] = e.greninja
e.bunnelby = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[659] = e.bunnelby
e.diggersby = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[660] = e.diggersby
e.fletchling = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[661] = e.fletchling
e.fletchinder = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[662] = e.fletchinder
e.talonflame = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[663] = e.talonflame
e.scatterbug = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[664] = e.scatterbug
e.spewpa = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[665] = e.spewpa
e.vivillon = {hp = 1, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[666] = e.vivillon
e.litleo = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[667] = e.litleo
e.pyroar = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[668] = e.pyroar
e['flabébé'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[669] = e['flabébé']
e.floette = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[670] = e.floette
e.florges = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[671] = e.florges
e.skiddo = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[672] = e.skiddo
e.gogoat = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[673] = e.gogoat
e.pancham = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[674] = e.pancham
e.pangoro = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[675] = e.pangoro
e.furfrou = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[676] = e.furfrou
e.espurr = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[677] = e.espurr
e.meowstic = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[678] = e.meowstic
e.honedge = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[679] = e.honedge
e.doublade = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[680] = e.doublade
e.aegislash = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 1, spe = 0}
e[681] = e.aegislash
e.aegislashS = {hp = 0, atk = 2, def = 0, spatk = 1, spdef = 0, spe = 0}
e['681S'] = e.aegislashS
e.spritzee = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[682] = e.spritzee
e.aromatisse = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[683] = e.aromatisse
e.swirlix = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[684] = e.swirlix
e.slurpuff = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[685] = e.slurpuff
e.inkay = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[686] = e.inkay
e.malamar = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[687] = e.malamar
e.binacle = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[688] = e.binacle
e.barbaracle = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[689] = e.barbaracle
e.skrelp = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[690] = e.skrelp
e.dragalge = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[691] = e.dragalge
e.clauncher = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[692] = e.clauncher
e.clawitzer = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[693] = e.clawitzer
e.helioptile = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[694] = e.helioptile
e.heliolisk = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 1}
e[695] = e.heliolisk
e.tyrunt = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[696] = e.tyrunt
e.tyrantrum = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[697] = e.tyrantrum
e.amaura = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[698] = e.amaura
e.aurorus = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[699] = e.aurorus
e.sylveon = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[700] = e.sylveon
e.hawlucha = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[701] = e.hawlucha
e.dedenne = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[702] = e.dedenne
e.carbink = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[703] = e.carbink
e.goomy = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[704] = e.goomy
e.sliggoo = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[705] = e.sliggoo
e.goodra = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[706] = e.goodra
e.klefki = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[707] = e.klefki
e.phantump = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[708] = e.phantump
e.trevenant = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[709] = e.trevenant
e.pumpkaboo = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[710] = e.pumpkaboo
e.gourgeist = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[711] = e.gourgeist
e.bergmite = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[712] = e.bergmite
e.avalugg = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[713] = e.avalugg
e.noibat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[714] = e.noibat
e.noivern = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[715] = e.noivern
e.xerneas = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[716] = e.xerneas
e.yveltal = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[717] = e.yveltal
e.zygarde = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[718] = e.zygarde
e.zygardeD = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e['718D'] = e.zygardeD
e.zygardeP = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e['718P'] = e.zygardeP
e.diancie = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 2, spe = 0}
e[719] = e.diancie
e.hoopa = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[720] = e.hoopa
e.volcanion = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[721] = e.volcanion
e.rowlet = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[722] = e.rowlet
e.dartrix = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[723] = e.dartrix
e.decidueye = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[724] = e.decidueye
e.litten = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[725] = e.litten
e.torracat = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[726] = e.torracat
e.incineroar = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[727] = e.incineroar
e.popplio = {hp = 0, atk = 0, def = 0, spatk = 1, spdef = 0, spe = 0}
e[728] = e.popplio
e.brionne = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[729] = e.brionne
e.primarina = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[730] = e.primarina
e.pikipek = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[731] = e.pikipek
e.trumbeak = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[732] = e.trumbeak
e.toucannon = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[733] = e.toucannon
e.yungoos = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[734] = e.yungoos
e.gumshoos = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[735] = e.gumshoos
e.grubbin = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[736] = e.grubbin
e.charjabug = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[737] = e.charjabug
e.vikavolt = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[738] = e.vikavolt
e.crabrawler = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[739] = e.crabrawler
e.crabominable = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[740] = e.crabominable
e.oricorio = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[741] = e.oricorio
e.cutiefly = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[742] = e.cutiefly
e.ribombee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[743] = e.ribombee
e.rockruff = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[744] = e.rockruff
e.lycanroc = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[745] = e.lycanroc
e.wishiwashi = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[746] = e.wishiwashi
e.mareanie = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[747] = e.mareanie
e.toxapex = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[748] = e.toxapex
e.mudbray = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[749] = e.mudbray
e.mudsdale = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[750] = e.mudsdale
e.dewpider = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[751] = e.dewpider
e.araquanid = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[752] = e.araquanid
e.fomantis = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[753] = e.fomantis
e.lurantis = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[754] = e.lurantis
e.morelull = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 1, spe = 0}
e[755] = e.morelull
e.shiinotic = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[756] = e.shiinotic
e.salandit = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[757] = e.salandit
e.salazzle = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[758] = e.salazzle
e.stufful = {hp = 0, atk = 1, def = 0, spatk = 0, spdef = 0, spe = 0}
e[759] = e.stufful
e.bewear = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[760] = e.bewear
e.bounsweet = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[761] = e.bounsweet
e.steenee = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 2}
e[762] = e.steenee
e.tsareena = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[763] = e.tsareena
e.comfey = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[764] = e.comfey
e.oranguru = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[765] = e.oranguru
e.passimian = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[766] = e.passimian
e.wimpod = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[767] = e.wimpod
e.golisopod = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[768] = e.golisopod
e.sandygast = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[769] = e.sandygast
e.palossand = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[770] = e.palossand
e.pyukumuku = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[771] = e.pyukumuku
e['tipo zero'] = {hp = 2, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[772] = e['tipo zero']
e.silvally = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[773] = e.silvally
e.minior = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[774] = e.minior
e.miniorR = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 0}
e['774R'] = e.miniorR
e.komala = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[775] = e.komala
e.turtonator = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[776] = e.turtonator
e.togedemaru = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[777] = e.togedemaru
e.mimikyu = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 2, spe = 0}
e[778] = e.mimikyu
e.bruxish = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[779] = e.bruxish
e.drampa = {hp = 0, atk = 0, def = 0, spatk = 2, spdef = 0, spe = 0}
e[780] = e.drampa
e.dhelmise = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 0}
e[781] = e.dhelmise
e['jangmo-o'] = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 0, spe = 0}
e[782] = e['jangmo-o']
e['hakamo-o'] = {hp = 0, atk = 0, def = 2, spatk = 0, spdef = 0, spe = 0}
e[783] = e['hakamo-o']
e['kommo-o'] = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[784] = e['kommo-o']
e['tapu koko'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[785] = e['tapu koko']
e['tapu lele'] = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[786] = e['tapu lele']
e['tapu bulu'] = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[787] = e['tapu bulu']
e['tapu fini'] = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[788] = e['tapu fini']
e.cosmog = {hp = 1, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[789] = e.cosmog
e.cosmoem = {hp = 0, atk = 0, def = 1, spatk = 0, spdef = 1, spe = 0}
e[790] = e.cosmoem
e.solgaleo = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[791] = e.solgaleo
e.lunala = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[792] = e.lunala
e.nihilego = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 3, spe = 0}
e[793] = e.nihilego
e.buzzwole = {hp = 0, atk = 1, def = 2, spatk = 0, spdef = 0, spe = 0}
e[794] = e.buzzwole
e.pheromosa = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[795] = e.pheromosa
e.xurkitree = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[796] = e.xurkitree
e.celesteela = {hp = 0, atk = 1, def = 1, spatk = 1, spdef = 0, spe = 0}
e[797] = e.celesteela
e.kartana = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e[798] = e.kartana
e.guzzlord = {hp = 3, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0}
e[799] = e.guzzlord
e.necrozma = {hp = 0, atk = 1, def = 0, spatk = 2, spdef = 0, spe = 0}
e[800] = e.necrozma
e.necrozmaV = {hp = 0, atk = 3, def = 0, spatk = 0, spdef = 0, spe = 0}
e['800V'] = e.necrozmaV
e.necrozmaA = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e['800A'] = e.necrozmaA
e.necrozmaU = {hp = 0, atk = 1, def = 0, spatk = 1, spdef = 0, spe = 1}
e['800U'] = e.necrozmaU
e.magearna = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[801] = e.magearna
e.marshadow = {hp = 0, atk = 2, def = 0, spatk = 0, spdef = 0, spe = 1}
e[802] = e.marshadow
e.poipole = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 1}
e[803] = e.poipole
e.naganadel = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[804] = e.naganadel
e.stakataka = {hp = 0, atk = 0, def = 3, spatk = 0, spdef = 0, spe = 0}
e[805] = e.stakataka
e.blacephalon = {hp = 0, atk = 0, def = 0, spatk = 3, spdef = 0, spe = 0}
e[806] = e.blacephalon
e.zeraora = {hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 3}
e[807] = e.zeraora

-- Mega evolutions and Primal reversions
e.venusaurM, e['003M'] = e.venusaur, e.venusaur
e.charizardMX, e['006MX'] = e.charizard, e.charizard
e.charizardMY, e['006MY'] = e.charizard, e.charizard
e.blastoiseM, e['009M'] = e.blastoise, e.blastoise
e.beedrillM, e['015M'] = e.beedrill, e.beedrill
e.pidgeotM, e['018M'] = e.pidgeot, e.pidgeot
e.alakazamM, e['065M'] = e.alakazam, e.alakazam
e.slowbroM, e['080M'] = e.slowbro, e.slowbro
e.gengarM, e['094M'] = e.gengar, e.gengar
e.kangaskhanM, e['115M'] = e.kangaskhan, e.kangaskhan
e.pinsirM, e['127M'] = e.pinsir, e.pinsir
e.gyaradosM, e['130M'] = e.gyarados, e.gyarados
e.aerodactylM, e['142M'] = e.aerodactyl, e.aerodactyl
e.mewtwoMX, e['150MX'] = e.mewtwo, e.mewtwo
e.mewtwoMY, e['150MY'] = e.mewtwo, e.mewtwo
e.ampharosM, e['181M'] = e.ampharos, e.ampharos
e.steelixM, e['208M'] = e.steelix, e.steelix
e.scizorM, e['212M'] = e.scizor, e.scizor
e.heracrossM, e['214M'] = e.heracross, e.heracross
e.houndoomM, e['229M'] = e.houndoom, e.houndoom
e.tyranitarM, e['248M'] = e.tyranitar, e.tyranitar
e.sceptileM, e['254M'] = e.sceptile, e.sceptile
e.blazikenM, e['257M'] = e.blaziken, e.blaziken
e.swampertM, e['260M'] = e.swampert, e.swampert
e.gardevoirM, e['282M'] = e.gardevoir, e.gardevoir
e.sableyeM, e['302M'] = e.sableye, e.sableye
e.mawileM, e['303M'] = e.mawile, e.mawile
e.aggronM, e['306M'] = e.aggron, e.aggron
e.medichamM, e['308M'] = e.medicham, e.medicham
e.manectricM, e['310M'] = e.manectric, e.manectric
e.sharpedoM, e['319M'] = e.sharpedo, e.sharpedo
e.cameruptM, e['323M'] = e.camerupt, e.camerupt
e.altariaM, e['334M'] = e.altaria, e.altaria
e.banetteM, e['354M'] = e.banette, e.banette
e.absolM, e['359M'] = e.absol, e.absol
e.glalieM, e['362M'] = e.glalie, e.glalie
e.salamenceM, e['373M'] = e.salamence, e.salamence
e.metagrossM, e['376M'] = e.metagross, e.metagross
e.latiasM, e['380M'] = e.latias, e.latias
e.latiosM, e['381M'] = e.latios, e.latios
e.kyogreA, e['382A'] = e.kyogre, e.kyogre
e.groudonA, e['383A'] = e.groudon, e.groudon
e.rayquazaM, e['384M'] = e.rayquaza, e.rayquaza
e.lopunnyM, e['428M'] = e.lopunny, e.lopunny
e.garchompM, e['445M'] = e.garchomp, e.garchomp
e.lucarioM, e['448M'] = e.lucario, e.lucario
e.abomasnowM, e['460M'] = e.abomasnow, e.abomasnow
e.galladeM, e['475M'] = e.gallade, e.gallade
e.audinoM, e['531M'] = e.audino, e.audino
e.diancieM, e['719M'] = e.diancie, e.diancie

-- Alolan forms
e.rattataA, e['019A'] = e.rattata, e.rattata
e.raticateA, e['020A'] = e.raticate, e.raticate
e.raichuA, e['026A'] = e.raichu, e.raichu
e.sandshrewA, e['027A'] = e.sandshrew, e.sandshrew
e.sandslashA, e['028A'] = e.sandslash, e.sandslash
e.vulpixA, e['037A'] = e.vulpix, e.vulpix
e.ninetalesA, e['038A'] = e.ninetales, e.ninetales
e.diglettA, e['050A'] = e.diglett, e.diglett
e.dugtrioA, e['051A'] = e.dugtrio, e.dugtrio
e.meowthA, e['052A'] = e.meowth, e.meowth
e.persianA, e['053A'] = e.persian, e.persian
e.geodudeA, e['074A'] = e.geodude, e.geodude
e.gravelerA, e['075A'] = e.graveler, e.graveler
e.golemA, e['076A'] = e.golem, e.golem
e.grimerA, e['088A'] = e.grimer, e.grimer
e.mukA, e['089A'] = e.muk, e.muk
e.exeggutorA, e['103A'] = e.exeggutor, e.exeggutor
e.marowakA, e['105A'] = e.marowak, e.marowak

-- Other alternative forms
e.pikachuCs, e['025Cs'] = e.pikachu, e.pikachu
e.pikachuR, e['025R'] = e.pikachu, e.pikachu
e.pikachuD, e['025D'] = e.pikachu, e.pikachu
e.pikachuCn, e['25Cn'] = e.pikachu, e.pikachu
e.pikachuS, e['025S'] = e.pikachu, e.pikachu
e.pikachuW, e['025W'] = e.pikachu, e.pikachu
e.pikachuO, e['025O'] = e.pikachu, e.pikachu
e.pikachuH, e['025H'] = e.pikachu, e.pikachu
e.pikachuSi, e['25Si'] = e.pikachu, e.pikachu
e.pikachuU, e['025U'] = e.pikachu, e.pikachu
e.pikachuK, e['025K'] = e.pikachu, e.pikachu
e.pikachuA, e['025A'] = e.pikachu, e.pikachu
e.pikachuCo, e['25Co'] = e.pikachu, e.pikachu
e.pichuS, e['172S'] = e.pichu, e.pichu
e.unownA, e['201A'] = e.unown, e.unown
e.unownB, e['201B'] = e.unown, e.unown
e.unownC, e['201C'] = e.unown, e.unown
e.unownD, e['201D'] = e.unown, e.unown
e.unownE, e['201E'] = e.unown, e.unown
e.unownF, e['201F'] = e.unown, e.unown
e.unownG, e['201G'] = e.unown, e.unown
e.unownH, e['201H'] = e.unown, e.unown
e.unownI, e['201I'] = e.unown, e.unown
e.unownJ, e['201J'] = e.unown, e.unown
e.unownK, e['201K'] = e.unown, e.unown
e.unownL, e['201L'] = e.unown, e.unown
e.unownM, e['201M'] = e.unown, e.unown
e.unownN, e['201N'] = e.unown, e.unown
e.unownO, e['201O'] = e.unown, e.unown
e.unownP, e['201P'] = e.unown, e.unown
e.unownQ, e['201Q'] = e.unown, e.unown
e.unownR, e['201R'] = e.unown, e.unown
e.unownS, e['201S'] = e.unown, e.unown
e.unownT, e['201T'] = e.unown, e.unown
e.unownU, e['201U'] = e.unown, e.unown
e.unownV, e['201V'] = e.unown, e.unown
e.unownW, e['201W'] = e.unown, e.unown
e.unownX, e['201X'] = e.unown, e.unown
e.unownY, e['201Y'] = e.unown, e.unown
e.unownZ, e['201Z'] = e.unown, e.unown
e.unownPE, e['201PE'] = e.unown, e.unown
e.unownPI, e['201PI'] = e.unown, e.unown
e.castformS, e['351S'] = e.castform, e.castform
e.castformP, e['351P'] = e.castform, e.castform
e.castformN, e['351N'] = e.castform, e.castform
e.burmySa, e['412Sa'] = e.burmy, e.burmy
e.burmySc, e['412Sc'] = e.burmy, e.burmy
e.cherrimS, e['421S'] = e.cherrim, e.cherrim
e.shellosE, e['422E'] = e.shellos, e.shellos
e.gastrodonE, e['423E'] = e.gastrodon, e.gastrodon
e.rotomC, e['479C'] = e.rotom, e.rotom
e.rotomL, e['479L'] = e.rotom, e.rotom
e.rotomG, e['479G'] = e.rotom, e.rotom
e.rotomV, e['479V'] = e.rotom, e.rotom
e.rotomT, e['479T'] = e.rotom, e.rotom
e.giratinaO, e['487O'] = e.giratina, e.giratina
e.arceusL, e['493L'] = e.arceus, e.arceus
e.arceusVo, e['493Vo'] = e.arceus, e.arceus
e.arceusVe, e['493Ve'] = e.arceus, e.arceus
e.arceusT, e['493T'] = e.arceus, e.arceus
e.arceusR, e['493R'] = e.arceus, e.arceus
e.arceusAq, e['493Aq'] = e.arceus, e.arceus
e.arceusC, e['493C'] = e.arceus, e.arceus
e.arceusEr, e['493Er'] = e.arceus, e.arceus
e.arceusP, e['493P'] = e.arceus, e.arceus
e.arceusB, e['493B'] = e.arceus, e.arceus
e.arceusS, e['493S'] = e.arceus, e.arceus
e.arceusAi, e['493Ai'] = e.arceus, e.arceus
e.arceusFu, e['493Fu'] = e.arceus, e.arceus
e.arceusD, e['493D'] = e.arceus, e.arceus
e.arceusFo, e['493Fo'] = e.arceus, e.arceus
e.arceusEl, e['493El'] = e.arceus, e.arceus
e.arceusG, e['493G'] = e.arceus, e.arceus
e.unfezantF, e['521F'] = e.unfezant, e.unfezant
e.basculinB, e['550B'] = e.basculin, e.basculin
e.deerlingE, e['585E'] = e.deerling, e.deerling
e.deerlingA, e['585A'] = e.deerling, e.deerling
e.deerlingI, e['585I'] = e.deerling, e.deerling
e.sawsbuckE, e['585E'] = e.sawsbuck, e.sawsbuck
e.sawsbuckA, e['585A'] = e.sawsbuck, e.sawsbuck
e.sawsbuckI, e['585I'] = e.sawsbuck, e.sawsbuck
e.frillishF, e['592F'] = e.frillish, e.frillish
e.jellicentF, e['593F'] = e.jellicent, e.jellicent
e.keldeoR, e['647R'] = e.keldeo, e.keldeo
e.genesectI, e['649I'] = e.genesect, e.genesect
e.genesectV, e['649V'] = e.genesect, e.genesect
e.genesectP, e['649P'] = e.genesect, e.genesect
e.genesectG, e['649G'] = e.genesect, e.genesect
e.greninjaA , e['658A'] = e.greninja, e.greninja
e.vivillonNo, e['666No'] = e.vivillon, e.vivillon
e.vivillonMn, e['666Mn'] = e.vivillon, e.vivillon
e.vivillonC, e['666C'] = e.vivillon, e.vivillon
e.vivillonPr, e['666Pr'] = e.vivillon, e.vivillon
e.vivillonE, e['666E'] = e.vivillon, e.vivillon
e.vivillonGa, e['666Ga'] = e.vivillon, e.vivillon
e.vivillonNe, e['666Ne'] = e.vivillon, e.vivillon
e.vivillonT, e['666T'] = e.vivillon, e.vivillon
e.vivillonMr, e['666Mr'] = e.vivillon, e.vivillon
e.vivillonA, e['666A'] = e.vivillon, e.vivillon
e.vivillonD, e['666D'] = e.vivillon, e.vivillon
e.vivillonSb, e['666Sb'] = e.vivillon, e.vivillon
e.vivillonF, e['666F'] = e.vivillon, e.vivillon
e.vivillonPl, e['666Pl'] = e.vivillon, e.vivillon
e.vivillonSv, e['666Sv'] = e.vivillon, e.vivillon
e.vivillonSo, e['666So'] = e.vivillon, e.vivillon
e.vivillonO, e['666O'] = e.vivillon, e.vivillon
e.vivillonGu, e['666Gu'] = e.vivillon, e.vivillon
e.vivillonPo, e['666Po'] = e.vivillon, e.vivillon
e.vivillonSr, e['666Sr'] = e.vivillon, e.vivillon
e.pyroarF, e['668F'] = e.pyroar, e.pyroar
e['flabébéG'], e['670G'] = e['flabébé'], e['flabébé']
e['flabébéA'], e['670A'] = e['flabébé'], e['flabébé']
e['flabébéBi'], e['670Bi'] = e['flabébé'], e['flabébé']
e['flabébéBl'], e['670Bl'] = e['flabébé'], e['flabébé']
e.floetteG, e['670G'] = e.floette, e.floette
e.floetteA, e['670A'] = e.floette, e.floette
e.floetteBi, e['670Bi'] = e.floette, e.floette
e.floetteBl, e['670Bl'] = e.floette, e.floette
e.florgesG, e['670G'] = e.florges, e.florges
e.florgesA, e['670A'] = e.florges, e.florges
e.florgesBi, e['670Bi'] = e.florges, e.florges
e.florgesBl, e['670Bl'] = e.florges, e.florges
e.furfrouC, e['676C'] = e.furfrou, e.furfrou
e.furfrouSt, e['676St'] = e.furfrou, e.furfrou
e.furfrouD, e['676D'] = e.furfrou, e.furfrou
e.furfrouSi, e['676Si'] = e.furfrou, e.furfrou
e.furfrouGd, e['676Gd'] = e.furfrou, e.furfrou
e.furfrouGu, e['676Gu'] = e.furfrou, e.furfrou
e.furfrouR, e['676R'] = e.furfrou, e.furfrou
e.furfrouK, e['676K'] = e.furfrou, e.furfrou
e.furfrouF, e['676F'] = e.furfrou, e.furfrou
e.meowsticF, e['678F'] = e.meowstic, e.meowstic
e.pumpkabooS, e['710S'] = e.pumpkaboo, e.pumpkaboo
e.pumpkabooL, e['710L'] = e.pumpkaboo, e.pumpkaboo
e.pumpkabooXL, e['710XL'] = e.pumpkaboo, e.pumpkaboo
e.gourgeistS, e['710S'] = e.gourgeist, e.gourgeist
e.gourgeistL, e['710L'] = e.gourgeist, e.gourgeist
e.gourgeistXL, e['710XL'] = e.gourgeist, e.gourgeist
e.xerneasA, e['716A'] = e.xerneas, e.xerneas
e.hoopaL, e['720L'] = e.hoopa, e.hoopa
e.oricorioC, e['741C'] = e.oricorio, e.oricorio
e.oricorioH, e['741H'] = e.oricorio, e.oricorio
e.oricorioB, e['741B'] = e.oricorio, e.oricorio
e.lycanrocN, e['745N'] = e.lycanroc, e.lycanroc
e.lycanrocC, e['745C'] = e.lycanroc, e.lycanroc
e.wishiwashiB, e['746B'] = e.wishiwashi, e.wishiwashi
e.silvallyL, e['773L'] = e.silvally, e.silvally
e.silvallyVo, e['773Vo'] = e.silvally, e.silvally
e.silvallyVe, e['773Ve'] = e.silvally, e.silvally
e.silvallyT, e['773T'] = e.silvally, e.silvally
e.silvallyR, e['773R'] = e.silvally, e.silvally
e.silvallyAq, e['773Aq'] = e.silvally, e.silvally
e.silvallyC, e['773C'] = e.silvally, e.silvally
e.silvallyEr, e['773Er'] = e.silvally, e.silvally
e.silvallyP, e['773P'] = e.silvally, e.silvally
e.silvallyB, e['773B'] = e.silvally, e.silvally
e.silvallyS, e['773S'] = e.silvally, e.silvally
e.silvallyAi, e['773Ai'] = e.silvally, e.silvally
e.silvallyFu, e['773Fu'] = e.silvally, e.silvally
e.silvallyD, e['773D'] = e.silvally, e.silvally
e.silvallyFo, e['773Fo'] = e.silvally, e.silvally
e.silvallyEl, e['773El'] = e.silvally, e.silvally
e.silvallyG, e['773G'] = e.silvally, e.silvally
e.miniorAr, e['774Ar'] = e.miniorR, e.miniorR
e.miniorG, e['774G'] = e.miniorR, e.miniorR
e.miniorVe, e['774Ve'] = e.miniorR, e.miniorR
e.miniorAz, e['774Az'] = e.miniorR, e.miniorR
e.miniorI, e['774I'] = e.miniorR, e.miniorR
e.miniorVi, e['774Vi'] = e.miniorR, e.miniorR
e.mimikyuS, e['778S'] = e.mimikyu, e.mimikyu

return e
