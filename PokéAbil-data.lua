-- Tabella con le abilità dei Pokémon: laddove non vi siano seconda
-- abilità o abilità speciale, tale valore non esiste. Gli indici sono tutti in minuscolo

local t = {}

t.bulbasaur = {ability1 = 'Erbaiuto', abilityd = 'Clorofilla'}
t[1] = t.bulbasaur
t.ivysaur = {ability1 = 'Erbaiuto', abilityd = 'Clorofilla'}
t[2] = t.ivysaur
t.venusaur = {ability1 = 'Erbaiuto', abilityd = 'Clorofilla'}
t[3] = t.venusaur
t.charmander = {ability1 = 'Aiutofuoco', abilityd = 'Solarpotere'}
t[4] = t.charmander
t.charmeleon = {ability1 = 'Aiutofuoco', abilityd = 'Solarpotere'}
t[5] = t.charmeleon
t.charizard = {ability1 = 'Aiutofuoco', abilityd = 'Solarpotere'}
t[6] = t.charizard
t.squirtle = {ability1 = 'Acquaiuto', abilityd = 'Copripioggia'}
t[7] = t.squirtle
t.wartortle = {ability1 = 'Acquaiuto', abilityd = 'Copripioggia'}
t[8] = t.wartortle
t.blastoise = {ability1 = 'Acquaiuto', abilityd = 'Copripioggia'}
t[9] = t.blastoise
t.caterpie = {ability1 = 'Polvoscudo', abilityd = 'Fugafacile'}
t[10] = t.caterpie
t.metapod = {ability1 = 'Muta'}
t[11] = t.metapod
t.butterfree = {ability1 = 'Insettocchi', abilityd = 'Lentifumé'}
t[12] = t.butterfree
t.weedle = {ability1 = 'Polvoscudo', abilityd = 'Fugafacile'}
t[13] = t.weedle
t.kakuna = {ability1 = 'Muta'}
t[14] = t.kakuna
t.beedrill = {ability1 = 'Aiutinsetto', abilityd = 'Cecchino'}
t[15] = t.beedrill
t.pidgey = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [4] = 'Intricopiedi'}, abilityd = 'Pettinfuori'}
t[16] = t.pidgey
t.pidgeotto = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [4] = 'Intricopiedi'}, abilityd = 'Pettinfuori'}
t[17] = t.pidgeotto
t.pidgeot = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [4] = 'Intricopiedi'}, abilityd = 'Pettinfuori'}
t[18] = t.pidgeot
t.rattata = {ability1 = 'Fugafacile', ability2 = 'Dentistretti', abilityd = 'Tuttafretta'}
t[19] = t.rattata
t.raticate = {ability1 = 'Fugafacile', ability2 = 'Dentistretti', abilityd = 'Tuttafretta'}
t[20] = t.raticate
t.spearow = {ability1 = 'Sguardofermo', abilityd = 'Cecchino'}
t[21] = t.spearow
t.fearow = {ability1 = 'Sguardofermo', abilityd = 'Cecchino'}
t[22] = t.fearow
t.ekans = {ability1 = 'Prepotenza', ability2 = 'Muta', abilityd = 'Agitazione'}
t[23] = t.ekans
t.arbok = {ability1 = 'Prepotenza', ability2 = 'Muta', abilityd = 'Agitazione'}
t[24] = t.arbok
t.pichu = {ability1 = 'Statico', abilityd = 'Parafulmine'}
t[172] = t.pichu
t.pikachu = {ability1 = 'Statico', abilityd = 'Parafulmine'}
t[25] = t.pikachu
t.raichu = {ability1 = 'Statico', abilityd = 'Parafulmine'}
t[26] = t.raichu
t.sandshrew = {ability1 = 'Sabbiavelo', abilityd = 'Remasabbia'}
t[27] = t.sandshrew
t.sandslash = {ability1 = 'Sabbiavelo', abilityd = 'Remasabbia'}
t[28] = t.sandslash
t['nidoran♀'] = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Tuttafretta'}
t[29] = t['nidoran♀']
t.nidorina = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Tuttafretta'}
t[30] = t.nidorina
t.nidoqueen = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Forzabruta'}
t[31] = t.nidoqueen
t['nidoran♂'] = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Tuttafretta'}
t[32] = t['nidoran♂']
t.nidorino = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Tuttafretta'}
t[33] = t.nidorino
t.nidoking = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Antagonismo'}, abilityd = 'Forzabruta'}
t[34] = t.nidoking
t.cleffa = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [4] = 'Magicscudo'}, abilityd = 'Amicoscudo'}
t[173] = t.cleffa
t.clefairy = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [4] = 'Magicscudo'}, abilityd = 'Amicoscudo'}
t[35] = t.clefairy
t.clefable = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [4] = 'Magicscudo'}, abilityd = 'Imprudenza'}
t[36] = t.clefable
t.vulpix = {ability1 = 'Fuocardore', abilityd = 'Siccità'}
t[37] = t.vulpix
t.ninetales = {ability1 = 'Fuocardore', abilityd = 'Siccità'}
t[38] = t.ninetales
t.igglybuff = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Amicoscudo'}
t[174] = t.igglybuff
t.jigglypuff = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Amicoscudo'}
t[39] = t.jigglypuff
t.wigglytuff = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Indagine'}
t[40] = t.wigglytuff
t.zubat = {ability1 = 'Forza Interiore', abilityd = 'Intrapasso'}
t[41] = t.zubat
t.golbat = {ability1 = 'Forza Interiore', abilityd = 'Intrapasso'}
t[42] = t.golbat
t.crobat = {ability1 = 'Forza Interiore', abilityd = 'Intrapasso'}
t[169] = t.crobat
t.oddish = {ability1 = 'Clorofilla', abilityd = 'Fugafacile'}
t[43] = t.oddish
t.gloom = {ability1 = 'Clorofilla', abilityd = 'Tanfo'}
t[44] = t.gloom
t.vileplume = {ability1 = 'Clorofilla', abilityd = 'Spargispora'}
t[45] = t.vileplume
t.bellossom = {ability1 = 'Clorofilla', abilityd = 'Curacuore'}
t[182] = t.bellossom
t.paras = {ability1 = 'Spargispora', ability2 = {[3] = 'Nessuna', [4] = 'Pellearsa'}, abilityd = 'Umidità'}
t[46] = t.paras
t.parasect = {ability1 = 'Spargispora', ability2 = {[3] = 'Nessuna', [4] = 'Pellearsa'}, abilityd = 'Umidità'}
t[47] = t.parasect
t.venonat = {ability1 = 'Insettocchi', ability2 = {[3] = 'Nessuna', [4] = 'Lentifumé'}, abilityd = 'Fugafacile'}
t[48] = t.venonat
t.venomoth = {ability1 = 'Polvoscudo', ability2 = {[3] = 'Nessuna', [4] = 'Lentifumé'}, abilityd = 'Splendicute'}
t[49] = t.venomoth
t.diglett = {ability1 = 'Sabbiavelo', ability2 = 'Trappoarena', abilityd = 'Silicoforza'}
t[50] = t.diglett
t.dugtrio = {ability1 = 'Sabbiavelo', ability2 = 'Trappoarena', abilityd = 'Silicoforza'}
t[51] = t.dugtrio
t.meowth = {ability1 = 'Raccolta', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Agitazione'}
t[52] = t.meowth
t.persian = {ability1 = 'Scioltezza', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Agitazione'}
t[53] = t.persian
t.psyduck = {ability1 = 'Umidità', ability2 = 'Antimeteo', abilityd = 'Nuotovelox'}
t[54] = t.psyduck
t.golduck = {ability1 = 'Umidità', ability2 = 'Antimeteo', abilityd = 'Nuotovelox'}
t[55] = t.golduck
t.mankey = {ability1 = 'Spiritovivo', ability2 = {[3] = 'Nessuna', [4] = 'Grancollera'}, abilityd = 'Agonismo'}
t[56] = t.mankey
t.primeape = {ability1 = 'Spiritovivo', ability2 = {[3] = 'Nessuna', [4] = 'Grancollera'}, abilityd = 'Agonismo'}
t[57] = t.primeape
t.growlithe = {ability1 = 'Prepotenza', ability2 = 'Fuocardore', abilityd = 'Giustizia'}
t[58] = t.growlithe
t.arcanine = {ability1 = 'Prepotenza', ability2 = 'Fuocardore', abilityd = 'Giustizia'}
t[59] = t.arcanine
t.poliwag = {ability1 = 'Assorbacqua', ability2 = 'Umidità', abilityd = 'Nuotovelox'}
t[60] = t.poliwag
t.poliwhirl = {ability1 = 'Assorbacqua', ability2 = 'Umidità', abilityd = 'Nuotovelox'}
t[61] = t.poliwhirl
t.poliwrath = {ability1 = 'Assorbacqua', ability2 = 'Umidità', abilityd = 'Nuotovelox'}
t[62] = t.poliwrath
t.politoed = {ability1 = 'Assorbacqua', ability2 = 'Umidità', abilityd = 'Piovischio'}
t[186] = t.politoed
t.abra = {ability1 = 'Sincronismo', ability2 = 'Forza Interiore', abilityd = 'Magicscudo'}
t[63] = t.abra
t.kadabra = {ability1 = 'Sincronismo', ability2 = 'Forza Interiore', abilityd = 'Magicscudo'}
t[64] = t.kadabra
t.alakazam = {ability1 = 'Sincronismo', ability2 = 'Forza Interiore', abilityd = 'Magicscudo'}
t[65] = t.alakazam
t.machop = {ability1 = 'Dentistretti', ability2 = {[3] = 'Nessuna', [4] = 'Nullodifesa'}, abilityd = 'Cuordeciso'}
t[66] = t.machop
t.machoke = {ability1 = 'Dentistretti', ability2 = {[3] = 'Nessuna', [4] = 'Nullodifesa'}, abilityd = 'Cuordeciso'}
t[67] = t.machoke
t.machamp = {ability1 = 'Dentistretti', ability2 = {[3] = 'Nessuna', [4] = 'Nullodifesa'}, abilityd = 'Cuordeciso'}
t[68] = t.machamp
t.bellsprout = {ability1 = 'Clorofilla', abilityd = 'Voracità'}
t[69] = t.bellsprout
t.weepinbell = {ability1 = 'Clorofilla', abilityd = 'Voracità'}
t[70] = t.weepinbell
t.victreebel = {ability1 = 'Clorofilla', abilityd = 'Voracità'}
t[71] = t.victreebel
t.tentacool = {ability1 = 'Corpochiaro', ability2 = 'Melma', abilityd = 'Copripioggia'}
t[72] = t.tentacool
t.tentacruel = {ability1 = 'Corpochiaro', ability2 = 'Melma', abilityd = 'Copripioggia'}
t[73] = t.tentacruel
t.geodude = {ability1 = 'Testadura', ability2 = 'Vigore', abilityd = 'Sabbiavelo'}
t[74] = t.geodude
t.graveler = {ability1 = 'Testadura', ability2 = 'Vigore', abilityd = 'Sabbiavelo'}
t[75] = t.graveler
t.golem = {ability1 = 'Testadura', ability2 = 'Vigore', abilityd = 'Sabbiavelo'}
t[76] = t.golem
t.ponyta = {ability1 = 'Fugafacile', ability2 = 'Fuocardore', abilityd = 'Corpodifuoco'}
t[77] = t.ponyta
t.rapidash = {ability1 = 'Fugafacile', ability2 = 'Fuocardore', abilityd = 'Corpodifuoco'}
t[78] = t.rapidash
t.slowpoke = {ability1 = 'Indifferenza', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t[79] = t.slowpoke
t.slowbro = {ability1 = 'Indifferenza', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t[80] = t.slowbro
t.slowking = {ability1 = 'Indifferenza', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t[199] = t.slowking
t.magnemite = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Ponderazione'}
t[81] = t.magnemite
t.magneton = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Ponderazione'}
t[82] = t.magneton
t.magnezone = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Ponderazione'}
t[462] = t.magnezone
t["farfetch'd"] = {ability1 = 'Sguardofermo', ability2 = 'Forza Interiore', abilityd = 'Agonismo'}
t[83] = t["farfetch'd"]
t.doduo = {ability1 = 'Fugafacile', ability2 = 'Sveglialampo', abilityd = 'Intricopiedi'}
t[84] = t.doduo
t.dodrio = {ability1 = 'Fugafacile', ability2 = 'Sveglialampo', abilityd = 'Intricopiedi'}
t[85] = t.dodrio
t.seel = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Idratazione'}, abilityd = 'Corpogelo'}
t[86] = t.seel
t.dewgong = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Idratazione'}, abilityd = 'Corpogelo'}
t[87] = t.dewgong
t.grimer = {ability1 = 'Tanfo', ability2 = 'Antifurto', abilityd = 'Velentocco'}
t[88] = t.grimer
t.muk = {ability1 = 'Tanfo', ability2 = 'Antifurto', abilityd = 'Velentocco'}
t[89] = t.muk
t.shellder = {ability1 = 'Guscioscudo', ability2 = {[3] = 'Nessuna', [4] = 'Abillegame'}, abilityd = 'Copricapo'}
t[90] = t.shellder
t.cloyster = {ability1 = 'Guscioscudo', ability2 = {[3] = 'Nessuna', [4] = 'Abillegame'}, abilityd = 'Copricapo'}
t[91] = t.cloyster
t.gastly = {ability1 = 'Levitazione'}
t[92] = t.gastly
t.haunter = {ability1 = 'Levitazione'}
t[93] = t.haunter
t.gengar = {ability1 = {[3] = 'Levitazione', [7] = 'Corpofunesto'}}
t[94] = t.gengar
t.onix = {ability1 = 'Testadura', ability2 = 'Vigore', abilityd = 'Sottilguscio'}
t[95] = t.onix
t.steelix = {ability1 = 'Testadura', ability2 = 'Vigore', abilityd = 'Forzabruta'}
t[208] = t.steelix
t.drowzee = {ability1 = 'Insonnia', ability2 = {[3] = 'Nessuna', [4] = 'Premonizione'}, abilityd = 'Forza Interiore'}
t[96] = t.drowzee
t.hypno = {ability1 = 'Insonnia', ability2 = {[3] = 'Nessuna', [4] = 'Premonizione'}, abilityd = 'Forza Interiore'}
t[97] = t.hypno
t.krabby = {ability1 = 'Ipertaglio', ability2 = 'Guscioscudo', abilityd = 'Forzabruta'}
t[98] = t.krabby
t.kingler = {ability1 = 'Ipertaglio', ability2 = 'Guscioscudo', abilityd = 'Forzabruta'}
t[99] = t.kingler
t.voltorb = {ability1 = 'Antisuono', ability2 = 'Statico', abilityd = 'Scoppio'}
t[100] = t.voltorb
t.electrode = {ability1 = 'Antisuono', ability2 = 'Statico', abilityd = 'Scoppio'}
t[101] = t.electrode
t.exeggcute = {ability1 = 'Clorofilla', abilityd = 'Coglibacche'}
t[102] = t.exeggcute
t.exeggutor = {ability1 = 'Clorofilla', abilityd = 'Coglibacche'}
t[103] = t.exeggutor
t.cubone = {ability1 = 'Testadura', ability2 = 'Parafulmine', abilityd = 'Lottascudo'}
t[104] = t.cubone
t.marowak = {ability1 = 'Testadura', ability2 = 'Parafulmine', abilityd = 'Lottascudo'}
t[105] = t.marowak
t.tyrogue = {ability1 = 'Dentistretti', ability2 = {[3] = 'Nessuna', [4] = 'Cuordeciso'}, abilityd = 'Spiritovivo'}
t[236] = t.tyrogue
t.hitmonlee = {ability1 = 'Scioltezza', ability2 = {[3] = 'Nessuna', [4] = 'Temerarietà'}, abilityd = 'Agiltecnica'}
t[106] = t.hitmonlee
t.hitmonchan = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [4] = 'Ferropugno'}, abilityd = 'Forza Interiore'}
t[107] = t.hitmonchan
t.hitmontop = {ability1 = 'Prepotenza', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Cuordeciso'}
t[237] = t.hitmontop
t.lickitung = {ability1 = 'Mente Locale', ability2 = 'Indifferenza', abilityd = 'Antimeteo'}
t[108] = t.lickitung
t.lickilicky = {ability1 = 'Mente Locale', ability2 = 'Indifferenza', abilityd = 'Antimeteo'}
t[463] = t.lickilicky
t.koffing = {ability1 = 'Levitazione', ability2 = {[1] = 'Nessuna', [8] = 'Gas Reagente'}, abilityd = {[1] = 'Nessuna', [8] = 'Tanfo'}}
t[109] = t.koffing
t.weezing = {ability1 = 'Levitazione', ability2 = {[1] = 'Nessuna', [8] = 'Gas Reagente'}, abilityd = {[1] = 'Nessuna', [8] = 'Tanfo'} }
t[110] = t.weezing
t.rhyhorn = {ability1 = 'Parafulmine', ability2 = 'Testadura', abilityd = 'Temerarietà'}
t[111] = t.rhyhorn
t.rhydon = {ability1 = 'Parafulmine', ability2 = 'Testadura', abilityd = 'Temerarietà'}
t[112] = t.rhydon
t.rhyperior = {ability1 = 'Parafulmine', ability2 = 'Solidroccia', abilityd = 'Temerarietà'}
t[464] = t.rhyperior
t.happiny = {ability1 = 'Alternacura', ability2 = 'Leggiadro', abilityd = 'Amicoscudo'}
t[440] = t.happiny
t.chansey = {ability1 = 'Alternacura', ability2 = 'Leggiadro', abilityd = 'Curacuore'}
t[113] = t.chansey
t.blissey = {ability1 = 'Alternacura', ability2 = 'Leggiadro', abilityd = 'Curacuore'}
t[242] = t.blissey
t.tangela = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Fogliamanto'}, abilityd = 'Rigenergia'}
t[114] = t.tangela
t.tangrowth = {ability1 = 'Clorofilla', ability2 = 'Fogliamanto', abilityd = 'Rigenergia'}
t[465] = t.tangrowth
t.kangaskhan = {ability1 = 'Sveglialampo', ability2 = {[3] = 'Nessuna', [4] = 'Nervisaldi'}, abilityd = 'Forza Interiore'}
t[115] = t.kangaskhan
t.horsea = {ability1 = 'Nuotovelox', ability2 = {[3] = 'Nessuna', [4] = 'Cecchino'}, abilityd = 'Umidità'}
t[116] = t.horsea
t.seadra = {ability1 = 'Velenopunto', ability2 = {[3] = 'Nessuna', [4] = 'Cecchino'}, abilityd = 'Umidità'}
t[117] = t.seadra
t.kingdra = {ability1 = 'Nuotovelox', ability2 = {[3] = 'Nessuna', [4] = 'Cecchino'}, abilityd = 'Umidità'}
t[230] = t.kingdra
t.goldeen = {ability1 = 'Nuotovelox', ability2 = 'Idrovelo', abilityd = 'Parafulmine'}
t[118] = t.goldeen
t.seaking = {ability1 = 'Nuotovelox', ability2 = 'Idrovelo', abilityd = 'Parafulmine'}
t[119] = t.seaking
t.staryu = {ability1 = 'Risplendi', ability2 = 'Alternacura', abilityd = 'Ponderazione'}
t[120] = t.staryu
t.starmie = {ability1 = 'Risplendi', ability2 = 'Alternacura', abilityd = 'Ponderazione'}
t[121] = t.starmie
t["mime jr."] = {ability1 = 'Antisuono', ability2 = 'Filtro', abilityd = 'Tecnico'}
t[439] = t["mime jr."]
t["mr. mime"] = {ability1 = 'Antisuono', ability2 = {[3] = 'Nessuna', [4] = 'Filtro'}, abilityd = 'Tecnico'}
t[122] = t["mr. mime"]
t.scyther = {ability1 = 'Aiutinsetto', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Cuordeciso'}
t[123] = t.scyther
t.scizor = {ability1 = 'Aiutinsetto', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Metalleggero'}
t[212] = t.scizor
t.smoochum = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Premonizione'}, abilityd = 'Idratazione'}
t[238] = t.smoochum
t.jynx = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Premonizione'}, abilityd = 'Pellearsa'}
t[124] = t.jynx
t.elekid = {ability1 = 'Statico', abilityd = 'Spiritovivo'}
t[239] = t.elekid
t.electabuzz = {ability1 = 'Statico', abilityd = 'Spiritovivo'}
t[125] = t.electabuzz
t.electivire = {ability1 = 'Elettrorapid', abilityd = 'Spiritovivo'}
t[466] = t.electivire
t.magby = {ability1 = 'Corpodifuoco', abilityd = 'Spiritovivo'}
t[240] = t.magby
t.magmar = {ability1 = 'Corpodifuoco', abilityd = 'Spiritovivo'}
t[126] = t.magmar
t.magmortar = {ability1 = 'Corpodifuoco', abilityd = 'Spiritovivo'}
t[467] = t.magmortar
t.pinsir = {ability1 = 'Ipertaglio', ability2 = {[3] = 'Nessuna', [4] = 'Rompiforma'}, abilityd = 'Arroganza'}
t[127] = t.pinsir
t.tauros = {ability1 = 'Prepotenza', ability2 = {[3] = 'Nessuna', [4] = 'Grancollera'}, abilityd = 'Forzabruta'}
t[128] = t.tauros
t.magikarp = {ability1 = 'Nuotovelox', abilityd = 'Paura'}
t[129] = t.magikarp
t.gyarados = {ability1 = 'Prepotenza', abilityd = 'Arroganza'}
t[130] = t.gyarados
t.lapras = {ability1 = 'Assorbacqua', ability2 = 'Guscioscudo', abilityd = 'Idratazione'}
t[131] = t.lapras
t.ditto = {ability1 = 'Scioltezza', abilityd = 'Sosia'}
t[132] = t.ditto
t.eevee = {ability1 = 'Fugafacile', ability2 = {[3] = 'Nessuna', [4] = 'Adattabilità'}, abilityd = 'Presagio'}
t[133] = t.eevee
t.vaporeon = {ability1 = 'Assorbacqua', abilityd = 'Idratazione'}
t[134] = t.vaporeon
t.jolteon = {ability1 = 'Assorbivolt', abilityd = 'Piedisvelti'}
t[135] = t.jolteon
t.flareon = {ability1 = 'Fuocardore', abilityd = 'Dentistretti'}
t[136] = t.flareon
t.espeon = {ability1 = 'Sincronismo', abilityd = 'Magispecchio'}
t[196] = t.espeon
t.umbreon = {ability1 = 'Sincronismo', abilityd = 'Forza Interiore'}
t[197] = t.umbreon
t.leafeon = {ability1 = 'Fogliamanto', abilityd = 'Clorofilla'}
t[470] = t.leafeon
t.glaceon = {ability1 = 'Mantelneve', abilityd = 'Corpogelo'}
t[471] = t.glaceon
t.porygon = {ability1 = 'Traccia', ability2 = {[3] = 'Nessuna', [4] = 'Download'}, abilityd = 'Ponderazione'}
t[137] = t.porygon
t.porygon2 = {ability1 = 'Traccia', ability2 = {[3] = 'Nessuna', [4] = 'Download'}, abilityd = 'Ponderazione'}
t[233] = t.porygon2
t["porygon-z"] = {ability1 = 'Adattabilità', ability2 = 'Download', abilityd = 'Ponderazione'}
t[474] = t["porygon-z"]
t.omanyte = {ability1 = 'Nuotovelox', ability2 = 'Guscioscudo', abilityd = 'Sottilguscio'}
t[138] = t.omanyte
t.omastar = {ability1 = 'Nuotovelox', ability2 = 'Guscioscudo', abilityd = 'Sottilguscio'}
t[139] = t.omastar
t.kabuto = {ability1 = 'Nuotovelox', ability2 = 'Lottascudo', abilityd = 'Sottilguscio'}
t[140] = t.kabuto
t.kabutops = {ability1 = 'Nuotovelox', ability2 = 'Lottascudo', abilityd = 'Sottilguscio'}
t[141] = t.kabutops
t.aerodactyl = {ability1 = 'Testadura', ability2 = 'Pressione', abilityd = 'Agitazione'}
t[142] = t.aerodactyl
t.munchlax = {ability1 = 'Raccolta', ability2 = 'Grassospesso', abilityd = 'Voracità'}
t[446] = t.munchlax
t.snorlax = {ability1 = 'Immunità', ability2 = 'Grassospesso', abilityd = 'Voracità'}
t[143] = t.snorlax
t.articuno = {ability1 = 'Pressione', abilityd = 'Mantelneve'}
t[144] = t.articuno
t.zapdos = {ability1 = 'Pressione', abilityd = {[5] = 'Parafulmine', [6] = 'Statico'}}
t[145] = t.zapdos
t.moltres = {ability1 = 'Pressione', abilityd = 'Corpodifuoco'}
t[146] = t.moltres
t.dratini = {ability1 = 'Muta', abilityd = 'Pelledura'}
t[147] = t.dratini
t.dragonair = {ability1 = 'Muta', abilityd = 'Pelledura'}
t[148] = t.dragonair
t.dragonite = {ability1 = 'Forza Interiore', abilityd = 'Multisquame'}
t[149] = t.dragonite
t.mewtwo = {ability1 = 'Pressione', abilityd = 'Agitazione'}
t[150] = t.mewtwo
t.mew = {ability1 = 'Sincronismo'}
t[151] = t.mew
t.chikorita = {ability1 = 'Erbaiuto', abilityd = 'Fogliamanto'}
t[152] = t.chikorita
t.bayleef = {ability1 = 'Erbaiuto', abilityd = 'Fogliamanto'}
t[153] = t.bayleef
t.meganium = {ability1 = 'Erbaiuto', abilityd = 'Fogliamanto'}
t[154] = t.meganium
t.cyndaquil = {ability1 = 'Aiutofuoco', abilityd = 'Fuocardore'}
t[155] = t.cyndaquil
t.quilava = {ability1 = 'Aiutofuoco', abilityd = 'Fuocardore'}
t[156] = t.quilava
t.typhlosion = {ability1 = 'Aiutofuoco', abilityd = 'Fuocardore'}
t[157] = t.typhlosion
t.totodile = {ability1 = 'Acquaiuto', abilityd = 'Forzabruta'}
t[158] = t.totodile
t.croconaw = {ability1 = 'Acquaiuto', abilityd = 'Forzabruta'}
t[159] = t.croconaw
t.feraligatr = {ability1 = 'Acquaiuto', abilityd = 'Forzabruta'}
t[160] = t.feraligatr
t.sentret = {ability1 = 'Fugafacile', ability2 = 'Sguardofermo', abilityd = 'Indagine'}
t[161] = t.sentret
t.furret = {ability1 = 'Fugafacile', ability2 = 'Sguardofermo', abilityd = 'Indagine'}
t[162] = t.furret
t.hoothoot = {ability1 = 'Insonnia', ability2 = 'Sguardofermo', abilityd = 'Lentifumé'}
t[163] = t.hoothoot
t.noctowl = {ability1 = 'Insonnia', ability2 = 'Sguardofermo', abilityd = 'Lentifumé'}
t[164] = t.noctowl
t.ledyba = {ability1 = 'Aiutinsetto', ability2 = 'Sveglialampo', abilityd = 'Paura'}
t[165] = t.ledyba
t.ledian = {ability1 = 'Aiutinsetto', ability2 = 'Sveglialampo', abilityd = 'Ferropugno'}
t[166] = t.ledian
t.spinarak = {ability1 = 'Aiutinsetto', ability2 = 'Insonnia', abilityd = 'Cecchino'}
t[167] = t.spinarak
t.ariados = {ability1 = 'Aiutinsetto', ability2 = 'Insonnia', abilityd = 'Cecchino'}
t[168] = t.ariados
t.chinchou = {ability1 = 'Assorbivolt', ability2 = 'Risplendi', abilityd = 'Assorbacqua'}
t[170] = t.chinchou
t.lanturn = {ability1 = 'Assorbivolt', ability2 = 'Risplendi', abilityd = 'Assorbacqua'}
t[171] = t.lanturn
t.togepi = {ability1 = 'Tuttafretta', ability2 = 'Leggiadro', abilityd = 'Supersorte'}
t[175] = t.togepi
t.togetic = {ability1 = 'Tuttafretta', ability2 = 'Leggiadro', abilityd = 'Supersorte'}
t[176] = t.togetic
t.togekiss = {ability1 = 'Tuttafretta', ability2 = 'Leggiadro', abilityd = 'Supersorte'}
t[468] = t.togekiss
t.natu = {ability1 = 'Sincronismo', ability2 = 'Sveglialampo', abilityd = 'Magispecchio'}
t[177] = t.natu
t.xatu = {ability1 = 'Sincronismo', ability2 = 'Sveglialampo', abilityd = 'Magispecchio'}
t[178] = t.xatu
t.mareep = {ability1 = 'Statico', abilityd = 'Più'}
t[179] = t.mareep
t.flaaffy = {ability1 = 'Statico', abilityd = 'Più'}
t[180] = t.flaaffy
t.ampharos = {ability1 = 'Statico', abilityd = 'Più'}
t[181] = t.ampharos
t.azurill = {ability1 = 'Grassospesso', ability2 = 'Macroforza', abilityd = 'Mangiaerba'}
t[298] = t.azurill
t.marill = {ability1 = 'Grassospesso', ability2 = 'Macroforza', abilityd = 'Mangiaerba'}
t[183] = t.marill
t.azumarill = {ability1 = 'Grassospesso', ability2 = 'Macroforza', abilityd = 'Mangiaerba'}
t[184] = t.azumarill
t.bonsly = {ability1 = 'Vigore', ability2 = 'Testadura', abilityd = 'Paura'}
t[438] = t.bonsly
t.sudowoodo = {ability1 = 'Vigore', ability2 = 'Testadura', abilityd = 'Paura'}
t[185] = t.sudowoodo
t.hoppip = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Fogliamanto'}, abilityd = 'Intrapasso'}
t[187] = t.hoppip
t.skiploom = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Fogliamanto'}, abilityd = 'Intrapasso'}
t[188] = t.skiploom
t.jumpluff = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Fogliamanto'}, abilityd = 'Intrapasso'}
t[189] = t.jumpluff
t.aipom = {ability1 = 'Fugafacile', ability2 = 'Raccolta', abilityd = 'Abillegame'}
t[190] = t.aipom
t.ambipom = {ability1 = 'Tecnico', ability2 = 'Raccolta', abilityd = 'Abillegame'}
t[424] = t.ambipom
t.sunkern = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Solarpotere'}, abilityd = 'Sveglialampo'}
t[191] = t.sunkern
t.sunflora = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Solarpotere'}, abilityd = 'Sveglialampo'}
t[192] = t.sunflora
t.yanma = {ability1 = 'Acceleratore', ability2 = 'Insettocchi', abilityd = 'Indagine'}
t[193] = t.yanma
t.yanmega = {ability1 = 'Acceleratore', ability2 = 'Lentifumé', abilityd = 'Indagine'}
t[469] = t.yanmega
t.wooper = {ability1 = 'Umidità', ability2 = 'Assorbacqua', abilityd = 'Imprudenza'}
t[194] = t.wooper
t.quagsire = {ability1 = 'Umidità', ability2 = 'Assorbacqua', abilityd = 'Imprudenza'}
t[195] = t.quagsire
t.murkrow = {ability1 = 'Insonnia', ability2 = {[3] = 'Nessuna', [4] = 'Supersorte'}, abilityd = 'Burla'}
t[198] = t.murkrow
t.honchkrow = {ability1 = 'Insonnia', ability2 = 'Supersorte', abilityd = 'Arroganza'}
t[430] = t.honchkrow
t.misdreavus = {ability1 = 'Levitazione'}
t[200] = t.misdreavus
t.mismagius = {ability1 = 'Levitazione'}
t[429] = t.mismagius
t.unown = {ability1 = 'Levitazione'}
t[201] = t.unown
t.wynaut = {ability1 = 'Pedinombra', abilityd = 'Telepatia'}
t[360] = t.wynaut
t.wobbuffet = {ability1 = 'Pedinombra', abilityd = 'Telepatia'}
t[202] = t.wobbuffet
t.girafarig = {ability1 = 'Forza Interiore', ability2 = 'Sveglialampo', abilityd = 'Mangiaerba'}
t[203] = t.girafarig
t.pineco = {ability1 = 'Vigore', abilityd = 'Copricapo'}
t[204] = t.pineco
t.forretress = {ability1 = 'Vigore', abilityd = 'Copricapo'}
t[205] = t.forretress
t.dunsparce = {ability1 = 'Leggiadro', ability2 = 'Fugafacile', abilityd = 'Paura'}
t[206] = t.dunsparce
t.gligar = {ability1 = 'Ipertaglio', ability2 = 'Sabbiavelo', abilityd = 'Immunità'}
t[207] = t.gligar
t.gliscor = {ability1 = 'Ipertaglio', ability2 = 'Sabbiavelo', abilityd = 'Velencura'}
t[472] = t.gliscor
t.snubbull = {ability1 = 'Prepotenza', ability2 = 'Fugafacile', abilityd = 'Paura'}
t[209] = t.snubbull
t.granbull = {ability1 = 'Prepotenza', ability2 = {[3] = 'Nessuna', [4] = 'Piedisvelti'}, abilityd = 'Paura'}
t[210] = t.granbull
t.qwilfish = {ability1 = 'Velenopunto', ability2 = 'Nuotovelox', abilityd = 'Prepotenza'}
t[211] = t.qwilfish
t.shuckle = {ability1 = 'Vigore', ability2 = {[3] = 'Nessuna', [4] = 'Voracità'}, abilityd = 'Inversione'}
t[213] = t.shuckle
t.heracross = {ability1 = 'Aiutinsetto', ability2 = 'Dentistretti', abilityd = 'Arroganza'}
t[214] = t.heracross
t.sneasel = {ability1 = 'Forza Interiore', ability2 = 'Sguardofermo', abilityd = 'Arraffalesto'}
t[215] = t.sneasel
t.weavile = {ability1 = 'Pressione', abilityd = 'Arraffalesto'}
t[461] = t.weavile
t.teddiursa = {ability1 = 'Raccolta', ability2 = {[3] = 'Nessuna', [4] = 'Piedisvelti'}, abilityd = 'Mielincetta'}
t[216] = t.teddiursa
t.ursaring = {ability1 = 'Dentistretti', ability2 = {[3] = 'Nessuna', [4] = 'Piedisvelti'}, abilityd = 'Agitazione'}
t[217] = t.ursaring
t.slugma = {ability1 = 'Magmascudo', ability2 = 'Corpodifuoco', abilityd = 'Sottilguscio'}
t[218] = t.slugma
t.magcargo = {ability1 = 'Magmascudo', ability2 = 'Corpodifuoco', abilityd = 'Sottilguscio'}
t[219] = t.magcargo
t.swinub = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Mantelneve'}, abilityd = 'Grassospesso'}
t[220] = t.swinub
t.piloswine = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Mantelneve'}, abilityd = 'Grassospesso'}
t[221] = t.piloswine
t.mamoswine = {ability1 = 'Indifferenza', ability2 = 'Mantelneve', abilityd = 'Grassospesso'}
t[473] = t.mamoswine
t.corsola = {ability1 = 'Tuttafretta', ability2 = 'Alternacura', abilityd = 'Rigenergia'}
t[222] = t.corsola
t.remoraid = {ability1 = 'Tuttafretta', ability2 = {[3] = 'Nessuna', [4] = 'Cecchino'}, abilityd = 'Altalena'}
t[223] = t.remoraid
t.octillery = {ability1 = 'Ventose', ability2 = {[3] = 'Nessuna', [4] = 'Cecchino'}, abilityd = 'Altalena'}
t[224] = t.octillery
t.delibird = {ability1 = 'Spiritovivo', ability2 = 'Tuttafretta', abilityd = 'Insonnia'}
t[225] = t.delibird
t.mantyke = {ability1 = 'Nuotovelox', ability2 = 'Assorbacqua', abilityd = 'Idrovelo'}
t[458] = t.mantyke
t.mantine = {ability1 = 'Nuotovelox', ability2 = 'Assorbacqua', abilityd = 'Idrovelo'}
t[226] = t.mantine
t.skarmory = {ability1 = 'Sguardofermo', ability2 = 'Vigore', abilityd = 'Sottilguscio'}
t[227] = t.skarmory
t.houndour = {ability1 = 'Sveglialampo', ability2 = 'Fuocardore', abilityd = 'Agitazione'}
t[228] = t.houndour
t.houndoom = {ability1 = 'Sveglialampo', ability2 = 'Fuocardore', abilityd = 'Agitazione'}
t[229] = t.houndoom
t.phanpy = {ability1 = 'Raccolta', abilityd = 'Sabbiavelo'}
t[231] = t.phanpy
t.donphan = {ability1 = 'Vigore', abilityd = 'Sabbiavelo'}
t[232] = t.donphan
t.stantler = {ability1 = 'Prepotenza', ability2 = {[3] = 'Nessuna', [4] = 'Indagine'}, abilityd = 'Mangiaerba'}
t[234] = t.stantler
t.smeargle = {ability1 = 'Mente Locale', ability2 = {[3] = 'Nessuna', [4] = 'Tecnico'}, abilityd = 'Altalena'}
t[235] = t.smeargle
t.miltank = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Nervisaldi'}, abilityd = 'Mangiaerba'}
t[241] = t.miltank
t.raikou = {ability1 = 'Pressione', abilityd = {[5] = 'Assorbivolt', [7] = 'Forza Interiore'}}
t[243] = t.raikou
t.entei = {ability1 = 'Pressione', abilityd = {[5] = 'Fuocardore', [7] = 'Forza Interiore'}}
t[244] = t.entei
t.suicune = {ability1 = 'Pressione', abilityd = {[5] = 'Assorbacqua', [7] = 'Forza Interiore'}}
t[245] = t.suicune
t.larvitar = {ability1 = 'Dentistretti', abilityd = 'Sabbiavelo'}
t[246] = t.larvitar
t.pupitar = {ability1 = 'Muta'}
t[247] = t.pupitar
t.tyranitar = {ability1 = 'Sabbiafiume', abilityd = 'Agitazione'}
t[248] = t.tyranitar
t.lugia = {ability1 = 'Pressione', abilityd = 'Multisquame'}
t[249] = t.lugia
t["ho-oh"] = {ability1 = 'Pressione', abilityd = 'Rigenergia'}
t[250] = t["ho-oh"]
t.celebi = {ability1 = 'Alternacura'}
t[251] = t.celebi
t.treecko = {ability1 = 'Erbaiuto', abilityd = 'Agiltecnica'}
t[252] = t.treecko
t.grovyle = {ability1 = 'Erbaiuto', abilityd = 'Agiltecnica'}
t[253] = t.grovyle
t.sceptile = {ability1 = 'Erbaiuto', abilityd = 'Agiltecnica'}
t[254] = t.sceptile
t.torchic = {ability1 = 'Aiutofuoco', abilityd = 'Acceleratore'}
t[255] = t.torchic
t.combusken = {ability1 = 'Aiutofuoco', abilityd = 'Acceleratore'}
t[256] = t.combusken
t.blaziken = {ability1 = 'Aiutofuoco', abilityd = 'Acceleratore'}
t[257] = t.blaziken
t.mudkip = {ability1 = 'Acquaiuto', abilityd = 'Umidità'}
t[258] = t.mudkip
t.marshtomp = {ability1 = 'Acquaiuto', abilityd = 'Umidità'}
t[259] = t.marshtomp
t.swampert = {ability1 = 'Acquaiuto', abilityd = 'Umidità'}
t[260] = t.swampert
t.poochyena = {ability1 = 'Fugafacile', ability2 = {[3] = 'Nessuna', [4] = 'Piedisvelti'}, abilityd = 'Paura'}
t[261] = t.poochyena
t.mightyena = {ability1 = 'Prepotenza', ability2 = {[3] = 'Nessuna', [4] = 'Piedisvelti'}, abilityd = 'Arroganza'}
t[262] = t.mightyena
t.zigzagoon = {ability1 = 'Raccolta', ability2 = {[3] = 'Nessuna', [4] = 'Voracità'}, abilityd = 'Piedisvelti'}
t[263] = t.zigzagoon
t.linoone = {ability1 = 'Raccolta', ability2 = {[3] = 'Nessuna', [4] = 'Voracità'}, abilityd = 'Piedisvelti'}
t[264] = t.linoone
t.wurmple = {ability1 = 'Polvoscudo', abilityd = 'Fugafacile'}
t[265] = t.wurmple
t.silcoon = {ability1 = 'Muta'}
t[266] = t.silcoon
t.beautifly = {ability1 = 'Aiutinsetto', abilityd = 'Antagonismo'}
t[267] = t.beautifly
t.cascoon = {ability1 = 'Muta'}
t[268] = t.cascoon
t.dustox = {ability1 = 'Polvoscudo', abilityd = 'Insettocchi'}
t[269] = t.dustox
t.lotad = {ability1 = 'Nuotovelox', ability2 = 'Copripioggia', abilityd = 'Mente Locale'}
t[270] = t.lotad
t.lombre = {ability1 = 'Nuotovelox', ability2 = 'Copripioggia', abilityd = 'Mente Locale'}
t[271] = t.lombre
t.ludicolo = {ability1 = 'Nuotovelox', ability2 = 'Copripioggia', abilityd = 'Mente Locale'}
t[272] = t.ludicolo
t.seedot = {ability1 = 'Clorofilla', ability2 = 'Sveglialampo', abilityd = 'Arraffalesto'}
t[273] = t.seedot
t.nuzleaf = {ability1 = 'Clorofilla', ability2 = 'Sveglialampo', abilityd = 'Arraffalesto'}
t[274] = t.nuzleaf
t.shiftry = {ability1 = 'Clorofilla', ability2 = 'Sveglialampo', abilityd = 'Arraffalesto'}
t[275] = t.shiftry
t.taillow = {ability1 = 'Dentistretti', abilityd = 'Nervisaldi'}
t[276] = t.taillow
t.swellow = {ability1 = 'Dentistretti', abilityd = 'Nervisaldi'}
t[277] = t.swellow
t.wingull = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [7] = 'Idratazione'}, abilityd = 'Copripioggia'}
t[278] = t.wingull
t.pelipper = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [7] = 'Piovischio'}, abilityd = 'Copripioggia'}
t[279] = t.pelipper
t.ralts = {ability1 = 'Sincronismo', ability2 = 'Traccia', abilityd = 'Telepatia'}
t[280] = t.ralts
t.kirlia = {ability1 = 'Sincronismo', ability2 = 'Traccia', abilityd = 'Telepatia'}
t[281] = t.kirlia
t.gardevoir = {ability1 = 'Sincronismo', ability2 = 'Traccia', abilityd = 'Telepatia'}
t[282] = t.gardevoir
t.gallade = {ability1 = 'Cuordeciso', abilityd = 'Giustizia'}
t[475] = t.gallade
t.surskit = {ability1 = 'Nuotovelox', abilityd = 'Copripioggia'}
t[283] = t.surskit
t.masquerain = {ability1 = 'Prepotenza', abilityd = 'Agitazione'}
t[284] = t.masquerain
t.shroomish = {ability1 = 'Spargispora', ability2 = {[3] = 'Nessuna', [4] = 'Velencura'}, abilityd = 'Piedisvelti'}
t[285] = t.shroomish
t.breloom = {ability1 = 'Spargispora', ability2 = {[3] = 'Nessuna', [4] = 'Velencura'}, abilityd = 'Tecnico'}
t[286] = t.breloom
t.slakoth = {ability1 = 'Pigrone'}
t[287] = t.slakoth
t.vigoroth = {ability1 = 'Spiritovivo'}
t[288] = t.vigoroth
t.slaking = {ability1 = 'Pigrone'}
t[289] = t.slaking
t.nincada = {ability1 = 'Insettocchi', abilityd = 'Fugafacile'}
t[290] = t.nincada
t.ninjask = {ability1 = 'Acceleratore', abilityd = 'Intrapasso'}
t[291] = t.ninjask
t.shedinja = {ability1 = 'Magidifesa'}
t[292] = t.shedinja
t.whismur = {ability1 = 'Antisuono', abilityd = 'Paura'}
t[293] = t.whismur
t.loudred = {ability1 = 'Antisuono', abilityd = 'Nervisaldi'}
t[294] = t.loudred
t.exploud = {ability1 = 'Antisuono', abilityd = 'Nervisaldi'}
t[295] = t.exploud
t.makuhita = {ability1 = 'Grassospesso', ability2 = 'Dentistretti', abilityd = 'Forzabruta'}
t[296] = t.makuhita
t.hariyama = {ability1 = 'Grassospesso', ability2 = 'Dentistretti', abilityd = 'Forzabruta'}
t[297] = t.hariyama
t.nosepass = {ability1 = 'Vigore', ability2 = 'Magnetismo', abilityd = 'Silicoforza'}
t[299] = t.nosepass
t.probopass = {ability1 = 'Vigore', ability2 = 'Magnetismo', abilityd = 'Silicoforza'}
t[476] = t.probopass
t.skitty = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [4] = 'Normalità'}, abilityd = 'Splendicute'}
t[300] = t.skitty
t.delcatty = {ability1 = 'Incantevole', ability2 = {[3] = 'Nessuna', [4] = 'Normalità'}, abilityd = 'Splendicute'}
t[301] = t.delcatty
t.sableye = {ability1 = 'Sguardofermo', ability2 = {[3] = 'Nessuna', [4] = 'Rallentatore'}, abilityd = 'Burla'}
t[302] = t.sableye
t.mawile = {ability1 = 'Ipertaglio', ability2 = 'Prepotenza', abilityd = 'Forzabruta'}
t[303] = t.mawile
t.aron = {ability1 = 'Vigore', ability2 = 'Testadura', abilityd = 'Metalpesante'}
t[304] = t.aron
t.lairon = {ability1 = 'Vigore', ability2 = 'Testadura', abilityd = 'Metalpesante'}
t[305] = t.lairon
t.aggron = {ability1 = 'Vigore', ability2 = 'Testadura', abilityd = 'Metalpesante'}
t[306] = t.aggron
t.meditite = {ability1 = 'Forzapura', abilityd = 'Telepatia'}
t[307] = t.meditite
t.medicham = {ability1 = 'Forzapura', abilityd = 'Telepatia'}
t[308] = t.medicham
t.electrike = {ability1 = 'Statico', ability2 = 'Parafulmine', abilityd = 'Meno'}
t[309] = t.electrike
t.manectric = {ability1 = 'Statico', ability2 = 'Parafulmine', abilityd = 'Meno'}
t[310] = t.manectric
t.plusle = {ability1 = 'Più', abilityd = {[5] = 'Nessuna', [6] = 'Parafulmine'}}
t[311] = t.plusle
t.minun = {ability1 = 'Meno', abilityd = {[5] = 'Nessuna', [6] = 'Assorbivolt'}}
t[312] = t.minun
t.volbeat = {ability1 = 'Risplendi', ability2 = 'Aiutinsetto', abilityd = 'Burla'}
t[313] = t.volbeat
t.illumise = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Lentifumé'}, abilityd = 'Burla'}
t[314] = t.illumise
t.budew = {ability1 = 'Alternacura', ability2 = 'Velenopunto', abilityd = 'Fogliamanto'}
t[406] = t.budew
t.roselia = {ability1 = 'Alternacura', ability2 = 'Velenopunto', abilityd = 'Fogliamanto'}
t[315] = t.roselia
t.roserade = {ability1 = 'Alternacura', ability2 = 'Velenopunto', abilityd = 'Tecnico'}
t[407] = t.roserade
t.gulpin = {ability1 = 'Melma', ability2 = 'Antifurto', abilityd = 'Voracità'}
t[316] = t.gulpin
t.swalot = {ability1 = 'Melma', ability2 = 'Antifurto', abilityd = 'Voracità'}
t[317] = t.swalot
t.carvanha = {ability1 = 'Cartavetro', abilityd = 'Acceleratore'}
t[318] = t.carvanha
t.sharpedo = {ability1 = 'Cartavetro', abilityd = 'Acceleratore'}
t[319] = t.sharpedo
t.wailmer = {ability1 = 'Idrovelo', ability2 = 'Indifferenza', abilityd = 'Pressione'}
t[320] = t.wailmer
t.wailord = {ability1 = 'Idrovelo', ability2 = 'Indifferenza', abilityd = 'Pressione'}
t[321] = t.wailord
t.numel = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Disinvoltura'}, abilityd = 'Mente Locale'}
t[322] = t.numel
t.camerupt = {ability1 = 'Magmascudo', ability2 = {[3] = 'Nessuna', [4] = 'Solidroccia'}, abilityd = 'Grancollera'}
t[323] = t.camerupt
t.torkoal = {ability1 = 'Fumochiaro', ability2 = {[3] = 'Nessuna', [7] = 'Siccità'}, abilityd = 'Guscioscudo'}
t[324] = t.torkoal
t.spoink = {ability1 = 'Grassospesso', ability2 = 'Mente Locale', abilityd = 'Voracità'}
t[325] = t.spoink
t.grumpig = {ability1 = 'Grassospesso', ability2 = 'Mente Locale', abilityd = 'Voracità'}
t[326] = t.grumpig
t.spinda = {ability1 = 'Mente Locale', ability2 = {[3] = 'Nessuna', [4] = 'Intricopiedi'}, abilityd = 'Inversione'}
t[327] = t.spinda
t.trapinch = {ability1 = 'Ipertaglio', ability2 = 'Trappoarena', abilityd = 'Forzabruta'}
t[328] = t.trapinch
t.vibrava = {ability1 = 'Levitazione'}
t[329] = t.vibrava
t.flygon = {ability1 = 'Levitazione'}
t[330] = t.flygon
t.cacnea = {ability1 = 'Sabbiavelo', abilityd = 'Assorbacqua'}
t[331] = t.cacnea
t.cacturne = {ability1 = 'Sabbiavelo', abilityd = 'Assorbacqua'}
t[332] = t.cacturne
t.swablu = {ability1 = 'Alternacura', abilityd = 'Antimeteo'}
t[333] = t.swablu
t.altaria = {ability1 = 'Alternacura', abilityd = 'Antimeteo'}
t[334] = t.altaria
t.zangoose = {ability1 = 'Immunità', abilityd = 'Velenimpeto'}
t[335] = t.zangoose
t.seviper = {ability1 = 'Muta', abilityd = 'Intrapasso'}
t[336] = t.seviper
t.lunatone = {ability1 = 'Levitazione'}
t[337] = t.lunatone
t.solrock = {ability1 = 'Levitazione'}
t[338] = t.solrock
t.barboach = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Presagio'}, abilityd = 'Idratazione'}
t[339] = t.barboach
t.whiscash = {ability1 = 'Indifferenza', ability2 = {[3] = 'Nessuna', [4] = 'Presagio'}, abilityd = 'Idratazione'}
t[340] = t.whiscash
t.corphish = {ability1 = 'Ipertaglio', ability2 = 'Guscioscudo', abilityd = 'Adattabilità'}
t[341] = t.corphish
t.crawdaunt = {ability1 = 'Ipertaglio', ability2 = 'Guscioscudo', abilityd = 'Adattabilità'}
t[342] = t.crawdaunt
t.baltoy = {ability1 = 'Levitazione'}
t[343] = t.baltoy
t.claydol = {ability1 = 'Levitazione'}
t[344] = t.claydol
t.lileep = {ability1 = 'Ventose', abilityd = 'Acquascolo'}
t[345] = t.lileep
t.cradily = {ability1 = 'Ventose', abilityd = 'Acquascolo'}
t[346] = t.cradily
t.anorith = {ability1 = 'Lottascudo', abilityd = 'Nuotovelox'}
t[347] = t.anorith
t.armaldo = {ability1 = 'Lottascudo', abilityd = 'Nuotovelox'}
t[348] = t.armaldo
t.feebas = {ability1 = 'Nuotovelox', ability2 = {[3] = 'Nessuna', [6] = 'Indifferenza'}, abilityd = 'Adattabilità'}
t[349] = t.feebas
t.milotic = {ability1 = 'Pelledura', ability2 = {[3] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Incantevole'}
t[350] = t.milotic
t.castform = {ability1 = 'Previsioni'}
t[351] = t.castform
t.kecleon = {ability1 = 'Cambiacolore', abilityd = {[5] = 'Nessuna', [6] = 'Mutatipo'}}
t[352] = t.kecleon
t.shuppet = {ability1 = 'Insonnia', ability2 = {[3] = 'Nessuna', [4] = 'Indagine'}, abilityd = 'Corpofunesto'}
t[353] = t.shuppet
t.banette = {ability1 = 'Insonnia', ability2 = {[3] = 'Nessuna', [4] = 'Indagine'}, abilityd = 'Corpofunesto'}
t[354] = t.banette
t.duskull = {ability1 = 'Levitazione', abilityd = {[5] = 'Nessuna', [6] = 'Indagine'}}
t[355] = t.duskull
t.dusclops = {ability1 = 'Pressione', abilityd = {[5] = 'Nessuna', [6] = 'Indagine'}}
t[356] = t.dusclops
t.dusknoir = {ability1 = 'Pressione', abilityd = {[5] = 'Nessuna', [6] = 'Indagine'}}
t[477] = t.dusknoir
t.tropius = {ability1 = 'Clorofilla', ability2 = {[3] = 'Nessuna', [4] = 'Solarpotere'}, abilityd = 'Coglibacche'}
t[357] = t.tropius
t.chingling = {ability1 = 'Levitazione'}
t[433] = t.chingling
t.chimecho = {ability1 = 'Levitazione'}
t[358] = t.chimecho
t.absol = {ability1 = 'Pressione', ability2 = {[3] = 'Nessuna', [4] = 'Supersorte'}, abilityd = 'Giustizia'}
t[359] = t.absol
t.snorunt = {ability1 = 'Forza Interiore', ability2 = {[3] = 'Nessuna', [4] = 'Corpogelo'}, abilityd = 'Altalena'}
t[361] = t.snorunt
t.glalie = {ability1 = 'Forza Interiore', ability2 = {[3] = 'Nessuna', [4] = 'Corpogelo'}, abilityd = 'Altalena'}
t[362] = t.glalie
t.froslass = {ability1 = 'Mantelneve', abilityd = 'Corpofunesto'}
t[478] = t.froslass
t.spheal = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Corpogelo'}, abilityd = 'Indifferenza'}
t[363] = t.spheal
t.sealeo = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Corpogelo'}, abilityd = 'Indifferenza'}
t[364] = t.sealeo
t.walrein = {ability1 = 'Grassospesso', ability2 = {[3] = 'Nessuna', [4] = 'Corpogelo'}, abilityd = 'Indifferenza'}
t[365] = t.walrein
t.clamperl = {ability1 = 'Guscioscudo', abilityd = 'Paura'}
t[366] = t.clamperl
t.huntail = {ability1 = 'Nuotovelox', abilityd = 'Idrovelo'}
t[367] = t.huntail
t.gorebyss = {ability1 = 'Nuotovelox', abilityd = 'Idratazione'}
t[368] = t.gorebyss
t.relicanth = {ability1 = 'Nuotovelox', ability2 = 'Testadura', abilityd = 'Vigore'}
t[369] = t.relicanth
t.luvdisc = {ability1 = 'Nuotovelox', abilityd = 'Idratazione'}
t[370] = t.luvdisc
t.bagon = {ability1 = 'Testadura', abilityd = 'Forzabruta'}
t[371] = t.bagon
t.shelgon = {ability1 = 'Testadura', abilityd = 'Copricapo'}
t[372] = t.shelgon
t.salamence = {ability1 = 'Prepotenza', abilityd = 'Arroganza'}
t[373] = t.salamence
t.beldum = {ability1 = 'Corpochiaro', abilityd = 'Metalleggero'}
t[374] = t.beldum
t.metang = {ability1 = 'Corpochiaro', abilityd = 'Metalleggero'}
t[375] = t.metang
t.metagross = {ability1 = 'Corpochiaro', abilityd = 'Metalleggero'}
t[376] = t.metagross
t.regirock = {ability1 = 'Corpochiaro', abilityd = 'Vigore'}
t[377] = t.regirock
t.regice = {ability1 = 'Corpochiaro', abilityd = 'Corpogelo'}
t[378] = t.regice
t.registeel = {ability1 = 'Corpochiaro', abilityd = 'Metalleggero'}
t[379] = t.registeel
t.latias = {ability1 = 'Levitazione'}
t[380] = t.latias
t.latios = {ability1 = 'Levitazione'}
t[381] = t.latios
t.kyogre = {ability1 = 'Piovischio'}
t[382] = t.kyogre
t.groudon = {ability1 = 'Siccità'}
t[383] = t.groudon
t.rayquaza = {ability1 = 'Riparo'}
t[384] = t.rayquaza
t.jirachi = {ability1 = 'Leggiadro'}
t[385] = t.jirachi
t.deoxys = {ability1 = 'Pressione'}
t[386] = t.deoxys
t.turtwig = {ability1 = 'Erbaiuto', abilityd = 'Guscioscudo'}
t[387] = t.turtwig
t.grotle = {ability1 = 'Erbaiuto', abilityd = 'Guscioscudo'}
t[388] = t.grotle
t.torterra = {ability1 = 'Erbaiuto', abilityd = 'Guscioscudo'}
t[389] = t.torterra
t.chimchar = {ability1 = 'Aiutofuoco', abilityd = 'Ferropugno'}
t[390] = t.chimchar
t.monferno = {ability1 = 'Aiutofuoco', abilityd = 'Ferropugno'}
t[391] = t.monferno
t.infernape = {ability1 = 'Aiutofuoco', abilityd = 'Ferropugno'}
t[392] = t.infernape
t.piplup = {ability1 = 'Acquaiuto', abilityd = 'Agonismo'}
t[393] = t.piplup
t.prinplup = {ability1 = 'Acquaiuto', abilityd = 'Agonismo'}
t[394] = t.prinplup
t.empoleon = {ability1 = 'Acquaiuto', abilityd = 'Agonismo'}
t[395] = t.empoleon
t.starly = {ability1 = 'Sguardofermo', abilityd = {[5] = 'Nessuna', [6] = 'Temerarietà'}}
t[396] = t.starly
t.staravia = {ability1 = 'Prepotenza', abilityd = 'Temerarietà'}
t[397] = t.staravia
t.staraptor = {ability1 = 'Prepotenza', abilityd = 'Temerarietà'}
t[398] = t.staraptor
t.bidoof = {ability1 = 'Disinvoltura', ability2 = 'Imprudenza', abilityd = 'Altalena'}
t[399] = t.bidoof
t.bibarel = {ability1 = 'Disinvoltura', ability2 = 'Imprudenza', abilityd = 'Altalena'}
t[400] = t.bibarel
t.kricketot = {ability1 = 'Muta', abilityd = 'Fugafacile'}
t[401] = t.kricketot
t.kricketune = {ability1 = 'Aiutinsetto', abilityd = 'Tecnico'}
t[402] = t.kricketune
t.shinx = {ability1 = 'Antagonismo', ability2 = 'Prepotenza', abilityd = 'Dentistretti'}
t[403] = t.shinx
t.luxio = {ability1 = 'Antagonismo', ability2 = 'Prepotenza', abilityd = 'Dentistretti'}
t[404] = t.luxio
t.luxray = {ability1 = 'Antagonismo', ability2 = 'Prepotenza', abilityd = 'Dentistretti'}
t[405] = t.luxray
t.cranidos = {ability1 = 'Rompiforma', abilityd = 'Forzabruta'}
t[408] = t.cranidos
t.rampardos = {ability1 = 'Rompiforma', abilityd = 'Forzabruta'}
t[409] = t.rampardos
t.shieldon = {ability1 = 'Vigore', abilityd = 'Antisuono'}
t[410] = t.shieldon
t.bastiodon = {ability1 = 'Vigore', abilityd = 'Antisuono'}
t[411] = t.bastiodon
t.burmy = {ability1 = 'Muta', abilityd = 'Copricapo'}
t[412] = t.burmy
t.wormadam = {ability1 = 'Presagio', abilityd = 'Copricapo'}
t[413] = t.wormadam
t.mothim = {ability1 = 'Aiutinsetto', abilityd = 'Lentifumé'}
t[414] = t.mothim
t.combee = {ability1 = 'Mielincetta', abilityd = 'Tuttafretta'}
t[415] = t.combee
t.vespiquen = {ability1 = 'Pressione', abilityd = 'Agitazione'}
t[416] = t.vespiquen
t.pachirisu = {ability1 = 'Fugafacile', ability2 = 'Raccolta', abilityd = 'Assorbivolt'}
t[417] = t.pachirisu
t.buizel = {ability1 = 'Nuotovelox', abilityd = 'Idrovelo'}
t[418] = t.buizel
t.floatzel = {ability1 = 'Nuotovelox', abilityd = 'Idrovelo'}
t[419] = t.floatzel
t.cherubi = {ability1 = 'Clorofilla'}
t[420] = t.cherubi
t.cherrim = {ability1 = 'Regalfiore'}
t[421] = t.cherrim
t.shellos = {ability1 = 'Antifurto', ability2 = 'Acquascolo', abilityd = 'Silicoforza'}
t[422] = t.shellos
t.gastrodon = {ability1 = 'Antifurto', ability2 = 'Acquascolo', abilityd = 'Silicoforza'}
t[423] = t.gastrodon
t.drifloon = {ability1 = 'Scoppio', ability2 = 'Agiltecnica', abilityd = 'Bruciaimpeto'}
t[425] = t.drifloon
t.drifblim = {ability1 = 'Scoppio', ability2 = 'Agiltecnica', abilityd = 'Bruciaimpeto'}
t[426] = t.drifblim
t.buneary = {ability1 = 'Fugafacile', ability2 = 'Impaccio', abilityd = 'Scioltezza'}
t[427] = t.buneary
t.lopunny = {ability1 = 'Incantevole', ability2 = 'Impaccio', abilityd = 'Scioltezza'}
t[428] = t.lopunny
t.glameow = {ability1 = 'Scioltezza', ability2 = 'Mente Locale', abilityd = 'Sguardofermo'}
t[431] = t.glameow
t.purugly = {ability1 = 'Grassospesso', ability2 = 'Mente Locale', abilityd = 'Agonismo'}
t[432] = t.purugly
t.stunky = {ability1 = 'Tanfo', ability2 = 'Scoppio', abilityd = 'Sguardofermo'}
t[434] = t.stunky
t.skuntank = {ability1 = 'Tanfo', ability2 = 'Scoppio', abilityd = 'Sguardofermo'}
t[435] = t.skuntank
t.bronzor = {ability1 = 'Levitazione', ability2 = 'Antifuoco', abilityd = 'Metalpesante'}
t[436] = t.bronzor
t.bronzong = {ability1 = 'Levitazione', ability2 = 'Antifuoco', abilityd = 'Metalpesante'}
t[437] = t.bronzong
t.chatot = {ability1 = 'Sguardofermo', ability2 = 'Intricopiedi', abilityd = 'Pettinfuori'}
t[441] = t.chatot
t.spiritomb = {ability1 = 'Pressione', abilityd = 'Intrapasso'}
t[442] = t.spiritomb
t.gible = {ability1 = 'Sabbiavelo', abilityd = 'Cartavetro'}
t[443] = t.gible
t.gabite = {ability1 = 'Sabbiavelo', abilityd = 'Cartavetro'}
t[444] = t.gabite
t.garchomp = {ability1 = 'Sabbiavelo', abilityd = 'Cartavetro'}
t[445] = t.garchomp
t.riolu = {ability1 = 'Cuordeciso', ability2 = 'Forza Interiore', abilityd = 'Burla'}
t[447] = t.riolu
t.lucario = {ability1 = 'Cuordeciso', ability2 = 'Forza Interiore', abilityd = 'Giustizia'}
t[448] = t.lucario
t.hippopotas = {ability1 = 'Sabbiafiume', abilityd = 'Silicoforza'}
t[449] = t.hippopotas
t.hippowdon = {ability1 = 'Sabbiafiume', abilityd = 'Silicoforza'}
t[450] = t.hippowdon
t.skorupi = {ability1 = 'Lottascudo', ability2 = 'Cecchino', abilityd = 'Sguardofermo'}
t[451] = t.skorupi
t.drapion = {ability1 = 'Lottascudo', ability2 = 'Cecchino', abilityd = 'Sguardofermo'}
t[452] = t.drapion
t.croagunk = {ability1 = 'Presagio', ability2 = 'Pellearsa', abilityd = 'Velentocco'}
t[453] = t.croagunk
t.toxicroak = {ability1 = 'Presagio', ability2 = 'Pellearsa', abilityd = 'Velentocco'}
t[454] = t.toxicroak
t.carnivine = {ability1 = 'Levitazione'}
t[455] = t.carnivine
t.finneon = {ability1 = 'Nuotovelox', ability2 = 'Acquascolo', abilityd = 'Idrovelo'}
t[456] = t.finneon
t.lumineon = {ability1 = 'Nuotovelox', ability2 = 'Acquascolo', abilityd = 'Idrovelo'}
t[457] = t.lumineon
t.snover = {ability1 = 'Scendineve', abilityd = 'Antisuono'}
t[459] = t.snover
t.abomasnow = {ability1 = 'Scendineve', abilityd = 'Antisuono'}
t[460] = t.abomasnow
t.rotom = {ability1 = 'Levitazione'}
t[479] = t.rotom
t.uxie = {ability1 = 'Levitazione'}
t[480] = t.uxie
t.mesprit = {ability1 = 'Levitazione'}
t[481] = t.mesprit
t.azelf = {ability1 = 'Levitazione'}
t[482] = t.azelf
t.dialga = {ability1 = 'Pressione', abilityd = 'Telepatia'}
t[483] = t.dialga
t.palkia = {ability1 = 'Pressione', abilityd = 'Telepatia'}
t[484] = t.palkia
t.heatran = {ability1 = 'Fuocardore', abilityd = 'Corpodifuoco'}
t[485] = t.heatran
t.regigigas = {ability1 = 'Lentoinizio'}
t[486] = t.regigigas
t.giratina = {ability1 = 'Pressione', abilityd = 'Telepatia'}
t[487] = t.giratina
t.cresselia = {ability1 = 'Levitazione'}
t[488] = t.cresselia
t.phione = {ability1 = 'Idratazione'}
t[489] = t.phione
t.manaphy = {ability1 = 'Idratazione'}
t[490] = t.manaphy
t.darkrai = {ability1 = 'Sogniamari'}
t[491] = t.darkrai
t.shaymin = {ability1 = 'Alternacura'}
t[492] = t.shaymin
t.arceus = {ability1 = 'Multitipo'}
t[493] = t.arceus
t.victini = {ability1 = 'Vittorstella'}
t[494] = t.victini
t.snivy = {ability1 = 'Erbaiuto', abilityd = 'Inversione'}
t[495] = t.snivy
t.servine = {ability1 = 'Erbaiuto', abilityd = 'Inversione'}
t[496] = t.servine
t.serperior = {ability1 = 'Erbaiuto', abilityd = 'Inversione'}
t[497] = t.serperior
t.tepig = {ability1 = 'Aiutofuoco', abilityd = 'Grassospesso'}
t[498] = t.tepig
t.pignite = {ability1 = 'Aiutofuoco', abilityd = 'Grassospesso'}
t[499] = t.pignite
t.emboar = {ability1 = 'Aiutofuoco', abilityd = 'Temerarietà'}
t[500] = t.emboar
t.oshawott = {ability1 = 'Acquaiuto', abilityd = 'Guscioscudo'}
t[501] = t.oshawott
t.dewott = {ability1 = 'Acquaiuto', abilityd = 'Guscioscudo'}
t[502] = t.dewott
t.samurott = {ability1 = 'Acquaiuto', abilityd = 'Guscioscudo'}
t[503] = t.samurott
t.patrat = {ability1 = 'Fugafacile', ability2 = 'Sguardofermo', abilityd = 'Ponderazione'}
t[504] = t.patrat
t.watchog = {ability1 = 'Risplendi', ability2 = 'Sguardofermo', abilityd = 'Ponderazione'}
t[505] = t.watchog
t.lillipup = {ability1 = 'Spiritovivo', ability2 = 'Raccolta', abilityd = 'Fugafacile'}
t[506] = t.lillipup
t.herdier = {ability1 = 'Prepotenza', ability2 = 'Remasabbia', abilityd = 'Nervisaldi'}
t[507] = t.herdier
t.stoutland = {ability1 = 'Prepotenza', ability2 = 'Remasabbia', abilityd = 'Nervisaldi'}
t[508] = t.stoutland
t.purrloin = {ability1 = 'Scioltezza', ability2 = 'Agiltecnica', abilityd = 'Burla'}
t[509] = t.purrloin
t.liepard = {ability1 = 'Scioltezza', ability2 = 'Agiltecnica', abilityd = 'Burla'}
t[510] = t.liepard
t.pansage = {ability1 = 'Voracità', abilityd = 'Erbaiuto'}
t[511] = t.pansage
t.simisage = {ability1 = 'Voracità', abilityd = 'Erbaiuto'}
t[512] = t.simisage
t.pansear = {ability1 = 'Voracità', abilityd = 'Aiutofuoco'}
t[513] = t.pansear
t.simisear = {ability1 = 'Voracità', abilityd = 'Aiutofuoco'}
t[514] = t.simisear
t.panpour = {ability1 = 'Voracità', abilityd = 'Acquaiuto'}
t[515] = t.panpour
t.simipour = {ability1 = 'Voracità', abilityd = 'Acquaiuto'}
t[516] = t.simipour
t.munna = {ability1 = 'Premonizione', ability2 = 'Sincronismo', abilityd = 'Telepatia'}
t[517] = t.munna
t.musharna = {ability1 = 'Premonizione', ability2 = 'Sincronismo', abilityd = 'Telepatia'}
t[518] = t.musharna
t.pidove = {ability1 = 'Pettinfuori', ability2 = 'Supersorte', abilityd = 'Antagonismo'}
t[519] = t.pidove
t.tranquill = {ability1 = 'Pettinfuori', ability2 = 'Supersorte', abilityd = 'Antagonismo'}
t[520] = t.tranquill
t.unfezant = {ability1 = 'Pettinfuori', ability2 = 'Supersorte', abilityd = 'Antagonismo'}
t[521] = t.unfezant
t.blitzle = {ability1 = 'Parafulmine', ability2 = 'Elettrorapid', abilityd = 'Mangiaerba'}
t[522] = t.blitzle
t.zebstrika = {ability1 = 'Parafulmine', ability2 = 'Elettrorapid', abilityd = 'Mangiaerba'}
t[523] = t.zebstrika
t.roggenrola = {ability1 = 'Vigore', ability2 = {[5] = 'Nessuna', [7] = 'Sottilguscio'}, abilityd = 'Silicoforza'}
t[524] = t.roggenrola
t.boldore = {ability1 = 'Vigore', ability2 = {[5] = 'Nessuna', [7] = 'Sottilguscio'}, abilityd = 'Silicoforza'}
t[525] = t.boldore
t.gigalith = {ability1 = 'Vigore', ability2 = {[5] = 'Nessuna', [7] = 'Sabbiafiume'}, abilityd = 'Silicoforza'}
t[526] = t.gigalith
t.woobat = {ability1 = 'Imprudenza', ability2 = 'Impaccio', abilityd = 'Disinvoltura'}
t[527] = t.woobat
t.swoobat = {ability1 = 'Imprudenza', ability2 = 'Impaccio', abilityd = 'Disinvoltura'}
t[528] = t.swoobat
t.drilbur = {ability1 = 'Remasabbia', ability2 = 'Silicoforza', abilityd = 'Rompiforma'}
t[529] = t.drilbur
t.excadrill = {ability1 = 'Remasabbia', ability2 = 'Silicoforza', abilityd = 'Rompiforma'}
t[530] = t.excadrill
t.audino = {ability1 = 'Curacuore', ability2 = 'Rigenergia', abilityd = 'Impaccio'}
t[531] = t.audino
t.timburr = {ability1 = 'Dentistretti', ability2 = 'Forzabruta', abilityd = 'Ferropugno'}
t[532] = t.timburr
t.gurdurr = {ability1 = 'Dentistretti', ability2 = 'Forzabruta', abilityd = 'Ferropugno'}
t[533] = t.gurdurr
t.conkeldurr = {ability1 = 'Dentistretti', ability2 = 'Forzabruta', abilityd = 'Ferropugno'}
t[534] = t.conkeldurr
t.tympole = {ability1 = 'Nuotovelox', ability2 = 'Idratazione', abilityd = 'Assorbacqua'}
t[535] = t.tympole
t.palpitoad = {ability1 = 'Nuotovelox', ability2 = 'Idratazione', abilityd = 'Assorbacqua'}
t[536] = t.palpitoad
t.seismitoad = {ability1 = 'Nuotovelox', ability2 = 'Velentocco', abilityd = 'Assorbacqua'}
t[537] = t.seismitoad
t.throh = {ability1 = 'Dentistretti', ability2 = 'Forza Interiore', abilityd = 'Rompiforma'}
t[538] = t.throh
t.sawk = {ability1 = 'Vigore', ability2 = 'Forza Interiore', abilityd = 'Rompiforma'}
t[539] = t.sawk
t.sewaddle = {ability1 = 'Aiutinsetto', ability2 = 'Clorofilla', abilityd = 'Copricapo'}
t[540] = t.sewaddle
t.swadloon = {ability1 = 'Fogliamanto', ability2 = 'Clorofilla', abilityd = 'Copricapo'}
t[541] = t.swadloon
t.leavanny = {ability1 = 'Aiutinsetto', ability2 = 'Clorofilla', abilityd = 'Copricapo'}
t[542] = t.leavanny
t.venipede = {ability1 = 'Velenopunto', ability2 = 'Aiutinsetto', abilityd = {[5] = 'Piedisvelti', [6] = 'Acceleratore'}}
t[543] = t.venipede
t.whirlipede = {ability1 = 'Velenopunto', ability2 = 'Aiutinsetto', abilityd = {[5] = 'Piedisvelti', [6] = 'Acceleratore'}}
t[544] = t.whirlipede
t.scolipede = {ability1 = 'Velenopunto', ability2 = 'Aiutinsetto', abilityd = {[5] = 'Piedisvelti', [6] = 'Acceleratore'}}
t[545] = t.scolipede
t.cottonee = {ability1 = 'Burla', ability2 = 'Intrapasso', abilityd = 'Clorofilla'}
t[546] = t.cottonee
t.whimsicott = {ability1 = 'Burla', ability2 = 'Intrapasso', abilityd = 'Clorofilla'}
t[547] = t.whimsicott
t.petilil = {ability1 = 'Clorofilla', ability2 = 'Mente Locale', abilityd = 'Fogliamanto'}
t[548] = t.petilil
t.lilligant = {ability1 = 'Clorofilla', ability2 = 'Mente Locale', abilityd = 'Fogliamanto'}
t[549] = t.lilligant
t.basculin = {ability1 = 'Temerarietà', ability2 = 'Adattabilità', abilityd = 'Rompiforma'}
t[550] = t.basculin
t.sandile = {ability1 = 'Prepotenza', ability2 = 'Arroganza', abilityd = 'Grancollera'}
t[551] = t.sandile
t.krokorok = {ability1 = 'Prepotenza', ability2 = 'Arroganza', abilityd = 'Grancollera'}
t[552] = t.krokorok
t.krookodile = {ability1 = 'Prepotenza', ability2 = 'Arroganza', abilityd = 'Grancollera'}
t[553] = t.krookodile
t.darumaka = {ability1 = 'Tuttafretta', abilityd = 'Forza Interiore'}
t[554] = t.darumaka
t.darmanitan = {ability1 = 'Forzabruta', abilityd = 'Stato Zen'}
t[555] = t.darmanitan
t.maractus = {ability1 = 'Assorbacqua', ability2 = 'Clorofilla', abilityd = 'Acquascolo'}
t[556] = t.maractus
t.dwebble = {ability1 = 'Vigore', ability2 = 'Guscioscudo', abilityd = 'Sottilguscio'}
t[557] = t.dwebble
t.crustle = {ability1 = 'Vigore', ability2 = 'Guscioscudo', abilityd = 'Sottilguscio'}
t[558] = t.crustle
t.scraggy = {ability1 = 'Muta', ability2 = 'Arroganza', abilityd = 'Prepotenza'}
t[559] = t.scraggy
t.scrafty = {ability1 = 'Muta', ability2 = 'Arroganza', abilityd = 'Prepotenza'}
t[560] = t.scrafty
t.sigilyph = {ability1 = 'Splendicute', ability2 = 'Magicscudo', abilityd = 'Lentifumé'}
t[561] = t.sigilyph
t.yamask = {ability1 = 'Mummia'}
t[562] = t.yamask
t.cofagrigus = {ability1 = 'Mummia'}
t[563] = t.cofagrigus
t.tirtouga = {ability1 = 'Solidroccia', ability2 = 'Vigore', abilityd = 'Nuotovelox'}
t[564] = t.tirtouga
t.carracosta = {ability1 = 'Solidroccia', ability2 = 'Vigore', abilityd = 'Nuotovelox'}
t[565] = t.carracosta
t.archen = {ability1 = 'Sconforto'}
t[566] = t.archen
t.archeops = {ability1 = 'Sconforto'}
t[567] = t.archeops
t.trubbish = {ability1 = 'Tanfo', ability2 = 'Antifurto', abilityd = 'Scoppio'}
t[568] = t.trubbish
t.garbodor = {ability1 = 'Tanfo', ability2 = 'Sottilguscio', abilityd = 'Scoppio'}
t[569] = t.garbodor
t.zorua = {ability1 = 'Illusione'}
t[570] = t.zorua
t.zoroark = {ability1 = 'Illusione'}
t[571] = t.zoroark
t.minccino = {ability1 = 'Incantevole', ability2 = 'Tecnico', abilityd = 'Abillegame'}
t[572] = t.minccino
t.cinccino = {ability1 = 'Incantevole', ability2 = 'Tecnico', abilityd = 'Abillegame'}
t[573] = t.cinccino
t.gothita = {ability1 = 'Indagine', ability2 = {[5] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Pedinombra'}
t[574] = t.gothita
t.gothorita = {ability1 = 'Indagine', ability2 = {[5] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Pedinombra'}
t[575] = t.gothorita
t.gothitelle = {ability1 = 'Indagine', ability2 = {[5] = 'Nessuna', [6] = 'Tenacia'}, abilityd = 'Pedinombra'}
t[576] = t.gothitelle
t.solosis = {ability1 = 'Copricapo', ability2 = 'Magicscudo', abilityd = 'Rigenergia'}
t[577] = t.solosis
t.duosion = {ability1 = 'Copricapo', ability2 = 'Magicscudo', abilityd = 'Rigenergia'}
t[578] = t.duosion
t.reuniclus = {ability1 = 'Copricapo', ability2 = 'Magicscudo', abilityd = 'Rigenergia'}
t[579] = t.reuniclus
t.ducklett = {ability1 = 'Sguardofermo', ability2 = 'Pettinfuori', abilityd = 'Idratazione'}
t[580] = t.ducklett
t.swanna = {ability1 = 'Sguardofermo', ability2 = 'Pettinfuori', abilityd = 'Idratazione'}
t[581] = t.swanna
t.vanillite = {ability1 = 'Corpogelo', ability2 = {[5] = 'Nessuna', [7] = 'Mantelneve'}, abilityd = 'Sottilguscio'}
t[582] = t.vanillite
t.vanillish = {ability1 = 'Corpogelo', ability2 = {[5] = 'Nessuna', [7] = 'Mantelneve'}, abilityd = 'Sottilguscio'}
t[583] = t.vanillish
t.vanilluxe = {ability1 = 'Corpogelo', ability2 = {[5] = 'Nessuna', [7] = 'Scendineve'}, abilityd = 'Sottilguscio'}
t[584] = t.vanilluxe
t.deerling = {ability1 = 'Clorofilla', ability2 = 'Mangiaerba', abilityd = 'Leggiadro'}
t[585] = t.deerling
t.sawsbuck = {ability1 = 'Clorofilla', ability2 = 'Mangiaerba', abilityd = 'Leggiadro'}
t[586] = t.sawsbuck
t.emolga = {ability1 = 'Statico', abilityd = 'Elettrorapid'}
t[587] = t.emolga
t.karrablast = {ability1 = 'Aiutinsetto', ability2 = 'Muta', abilityd = 'Nullodifesa'}
t[588] = t.karrablast
t.escavalier = {ability1 = 'Aiutinsetto', ability2 = 'Guscioscudo', abilityd = 'Copricapo'}
t[589] = t.escavalier
t.foongus = {ability1 = 'Spargispora', abilityd = 'Rigenergia'}
t[590] = t.foongus
t.amoonguss = {ability1 = 'Spargispora', abilityd = 'Rigenergia'}
t[591] = t.amoonguss
t.frillish = {ability1 = 'Assorbacqua', ability2 = 'Corpofunesto', abilityd = 'Umidità'}
t[592] = t.frillish
t.jellicent = {ability1 = 'Assorbacqua', ability2 = 'Corpofunesto', abilityd = 'Umidità'}
t[593] = t.jellicent
t.alomomola = {ability1 = 'Curacuore', ability2 = 'Idratazione', abilityd = 'Rigenergia'}
t[594] = t.alomomola
t.joltik = {ability1 = 'Insettocchi', ability2 = 'Agitazione', abilityd = 'Aiutinsetto'}
t[595] = t.joltik
t.galvantula = {ability1 = 'Insettocchi', ability2 = 'Agitazione', abilityd = 'Aiutinsetto'}
t[596] = t.galvantula
t.ferroseed = {ability1 = 'Spineferrate'}
t[597] = t.ferroseed
t.ferrothorn = {ability1 = 'Spineferrate', abilityd = {[5] = 'Nessuna', [6] = 'Presagio'}}
t[598] = t.ferrothorn
t.klink = {ability1 = 'Più', ability2 = 'Meno', abilityd = 'Corpochiaro'}
t[599] = t.klink
t.klang = {ability1 = 'Più', ability2 = 'Meno', abilityd = 'Corpochiaro'}
t[600] = t.klang
t.klinklang = {ability1 = 'Più', ability2 = 'Meno', abilityd = 'Corpochiaro'}
t[601] = t.klinklang
t.tynamo = {ability1 = 'Levitazione'}
t[602] = t.tynamo
t.eelektrik = {ability1 = 'Levitazione'}
t[603] = t.eelektrik
t.eelektross = {ability1 = 'Levitazione'}
t[604] = t.eelektross
t.elgyem = {ability1 = 'Telepatia', ability2 = 'Sincronismo', abilityd = 'Ponderazione'}
t[605] = t.elgyem
t.beheeyem = {ability1 = 'Telepatia', ability2 = 'Sincronismo', abilityd = 'Ponderazione'}
t[606] = t.beheeyem
t.litwick = {ability1 = 'Fuocardore', ability2 = 'Corpodifuoco', abilityd = {[5] = 'Pedinombra', [6] = 'Intrapasso'}}
t[607] = t.litwick
t.lampent = {ability1 = 'Fuocardore', ability2 = 'Corpodifuoco', abilityd = {[5] = 'Pedinombra', [6] = 'Intrapasso'}}
t[608] = t.lampent
t.chandelure = {ability1 = 'Fuocardore', ability2 = 'Corpodifuoco', abilityd = {[5] = 'Pedinombra', [6] = 'Intrapasso'}}
t[609] = t.chandelure
t.axew = {ability1 = 'Antagonismo', ability2 = 'Rompiforma', abilityd = 'Agitazione'}
t[610] = t.axew
t.fraxure = {ability1 = 'Antagonismo', ability2 = 'Rompiforma', abilityd = 'Agitazione'}
t[611] = t.fraxure
t.haxorus = {ability1 = 'Antagonismo', ability2 = 'Rompiforma', abilityd = 'Agitazione'}
t[612] = t.haxorus
t.cubchoo = {ability1 = 'Mantelneve', ability2 = {[5] = 'Nessuna', [7] = 'Spalaneve'}, abilityd = 'Paura'}
t[613] = t.cubchoo
t.beartic = {ability1 = 'Mantelneve', ability2 = {[5] = 'Nessuna', [7] = 'Spalaneve'}, abilityd = 'Nuotovelox'}
t[614] = t.beartic
t.cryogonal = {ability1 = 'Levitazione'}
t[615] = t.cryogonal
t.shelmet = {ability1 = 'Idratazione', ability2 = 'Guscioscudo', abilityd = 'Copricapo'}
t[616] = t.shelmet
t.accelgor = {ability1 = 'Idratazione', ability2 = 'Antifurto', abilityd = 'Agiltecnica'}
t[617] = t.accelgor
t.stunfisk = {ability1 = 'Statico', ability2 = 'Scioltezza', abilityd = 'Sabbiavelo'}
t[618] = t.stunfisk
t.mienfoo = {ability1 = 'Forza Interiore', ability2 = 'Rigenergia', abilityd = 'Temerarietà'}
t[619] = t.mienfoo
t.mienshao = {ability1 = 'Forza Interiore', ability2 = 'Rigenergia', abilityd = 'Temerarietà'}
t[620] = t.mienshao
t.druddigon = {ability1 = 'Cartavetro', ability2 = 'Forzabruta', abilityd = 'Rompiforma'}
t[621] = t.druddigon
t.golett = {ability1 = 'Ferropugno', ability2 = 'Impaccio', abilityd = 'Nullodifesa'}
t[622] = t.golett
t.golurk = {ability1 = 'Ferropugno', ability2 = 'Impaccio', abilityd = 'Nullodifesa'}
t[623] = t.golurk
t.pawniard = {ability1 = 'Agonismo', ability2 = 'Forza Interiore', abilityd = 'Pressione'}
t[624] = t.pawniard
t.bisharp = {ability1 = 'Agonismo', ability2 = 'Forza Interiore', abilityd = 'Pressione'}
t[625] = t.bisharp
t.bouffalant = {ability1 = 'Temerarietà', ability2 = 'Mangiaerba', abilityd = 'Antisuono'}
t[626] = t.bouffalant
t.rufflet = {ability1 = 'Sguardofermo', ability2 = 'Forzabruta', abilityd = 'Tuttafretta'}
t[627] = t.rufflet
t.braviary = {ability1 = 'Sguardofermo', ability2 = 'Forzabruta', abilityd = 'Agonismo'}
t[628] = t.braviary
t.vullaby = {ability1 = 'Pettinfuori', ability2 = 'Copricapo', abilityd = 'Sottilguscio'}
t[629] = t.vullaby
t.mandibuzz = {ability1 = 'Pettinfuori', ability2 = 'Copricapo', abilityd = 'Sottilguscio'}
t[630] = t.mandibuzz
t.heatmor = {ability1 = 'Voracità', ability2 = 'Fuocardore', abilityd = 'Fumochiaro'}
t[631] = t.heatmor
t.durant = {ability1 = 'Aiutinsetto', ability2 = 'Tuttafretta', abilityd = 'Pigrone'}
t[632] = t.durant
t.deino = {ability1 = 'Tuttafretta'}
t[633] = t.deino
t.zweilous = {ability1 = 'Tuttafretta'}
t[634] = t.zweilous
t.hydreigon = {ability1 = 'Levitazione'}
t[635] = t.hydreigon
t.larvesta = {ability1 = 'Corpodifuoco', abilityd = 'Aiutinsetto'}
t[636] = t.larvesta
t.volcarona = {ability1 = 'Corpodifuoco', abilityd = 'Aiutinsetto'}
t[637] = t.volcarona
t.cobalion = {ability1 = 'Giustizia'}
t[638] = t.cobalion
t.terrakion = {ability1 = 'Giustizia'}
t[639] = t.terrakion
t.virizion = {ability1 = 'Giustizia'}
t[640] = t.virizion
t.tornadus = {ability1 = 'Burla', abilityd = 'Agonismo'}
t[641] = t.tornadus
t.thundurus = {ability1 = 'Burla', abilityd = 'Agonismo'}
t[642] = t.thundurus
t.reshiram = {ability1 = 'Piroturbina'}
t[643] = t.reshiram
t.zekrom = {ability1 = 'Teravolt'}
t[644] = t.zekrom
t.landorus = {ability1 = 'Silicoforza', abilityd = 'Forzabruta'}
t[645] = t.landorus
t.kyurem = {ability1 = 'Pressione'}
t[646] = t.kyurem
t.keldeo = {ability1 = 'Giustizia'}
t[647] = t.keldeo
t.meloetta = {ability1 = 'Leggiadro'}
t[648] = t.meloetta
t.genesect = {ability1 = 'Download'}
t[649] = t.genesect
t.chespin = {ability1 = 'Erbaiuto', abilityd = 'Antiproiettile'}
t[650] = t.chespin
t.quilladin = {ability1 = 'Erbaiuto', abilityd = 'Antiproiettile'}
t[651] = t.quilladin
t.chesnaught = {ability1 = 'Erbaiuto', abilityd = 'Antiproiettile'}
t[652] = t.chesnaught
t.fennekin = {ability1 = 'Aiutofuoco', abilityd = 'Prestigiatore'}
t[653] = t.fennekin
t.braixen = {ability1 = 'Aiutofuoco', abilityd = 'Prestigiatore'}
t[654] = t.braixen
t.delphox = {ability1 = 'Aiutofuoco', abilityd = 'Prestigiatore'}
t[655] = t.delphox
t.froakie = {ability1 = 'Acquaiuto', abilityd = 'Mutatipo'}
t[656] = t.froakie
t.frogadier = {ability1 = 'Acquaiuto', abilityd = 'Mutatipo'}
t[657] = t.frogadier
t.greninja = {ability1 = 'Acquaiuto', abilityd = 'Mutatipo', abilitye = 'Morfosintonia'}
t[658] = t.greninja
t.bunnelby = {ability1 = 'Raccolta', ability2 = 'Guancegonfie', abilityd = 'Macroforza'}
t[659] = t.bunnelby
t.diggersby = {ability1 = 'Raccolta', ability2 = 'Guancegonfie', abilityd = 'Macroforza'}
t[660] = t.diggersby
t.fletchling = {ability1 = 'Pettinfuori', abilityd = 'Aliraffica'}
t[661] = t.fletchling
t.fletchinder = {ability1 = 'Corpodifuoco', abilityd = 'Aliraffica'}
t[662] = t.fletchinder
t.talonflame = {ability1 = 'Corpodifuoco', abilityd = 'Aliraffica'}
t[663] = t.talonflame
t.scatterbug = {ability1 = 'Polvoscudo', ability2 = 'Insettocchi', abilityd = 'Amicoscudo'}
t[664] = t.scatterbug
t.spewpa = {ability1 = 'Muta', abilityd = 'Amicoscudo'}
t[665] = t.spewpa
t.vivillon = {ability1 = 'Polvoscudo', ability2 = 'Insettocchi', abilityd = 'Amicoscudo'}
t[666] = t.vivillon
t.litleo = {ability1 = 'Antagonismo', ability2 = 'Agitazione', abilityd = 'Arroganza'}
t[667] = t.litleo
t.pyroar = {ability1 = 'Antagonismo', ability2 = 'Agitazione', abilityd = 'Arroganza'}
t[668] = t.pyroar
t['flabébé'] = {ability1 = 'Fiorvelo', abilityd = 'Simbiosi'}
t[669] = t['flabébé']
t.floette = {ability1 = 'Fiorvelo', abilityd = 'Simbiosi'}
t[670] = t.floette
t.florges = {ability1 = 'Fiorvelo', abilityd = 'Simbiosi'}
t[671] = t.florges
t.skiddo = {ability1 = 'Mangiaerba', abilityd = 'Peloderba'}
t[672] = t.skiddo
t.gogoat = {ability1 = 'Mangiaerba', abilityd = 'Peloderba'}
t[673] = t.gogoat
t.pancham = {ability1 = 'Ferropugno', ability2 = 'Rompiforma', abilityd = 'Nervisaldi'}
t[674] = t.pancham
t.pangoro = {ability1 = 'Ferropugno', ability2 = 'Rompiforma', abilityd = 'Nervisaldi'}
t[675] = t.pangoro
t.furfrou = {ability1 = 'Foltopelo'}
t[676] = t.furfrou
t.espurr = {ability1 = 'Sguardofermo', ability2 = 'Intrapasso', abilityd = 'Mente Locale'}
t[677] = t.espurr
t.meowstic = {ability1 = 'Sguardofermo', ability2 = 'Intrapasso', abilityd = 'Burla'}
t[678] = t.meowstic
t.honedge = {ability1 = 'Nullodifesa'}
t[679] = t.honedge
t.doublade = {ability1 = 'Nullodifesa'}
t[680] = t.doublade
t.aegislash = {ability1 = 'Accendilotta'}
t[681] = t.aegislash
t.spritzee = {ability1 = 'Curacuore', abilityd = 'Aromavelo'}
t[682] = t.spritzee
t.aromatisse = {ability1 = 'Curacuore', abilityd = 'Aromavelo'}
t[683] = t.aromatisse
t.swirlix = {ability1 = 'Dolcevelo', abilityd = 'Agiltecnica'}
t[684] = t.swirlix
t.slurpuff = {ability1 = 'Dolcevelo', abilityd = 'Agiltecnica'}
t[685] = t.slurpuff
t.inkay = {ability1 = 'Inversione', ability2 = 'Ventose', abilityd = 'Intrapasso'}
t[686] = t.inkay
t.malamar = {ability1 = 'Inversione', ability2 = 'Ventose', abilityd = 'Intrapasso'}
t[687] = t.malamar
t.binacle = {ability1 = 'Unghiedure', ability2 = 'Cecchino', abilityd = 'Arraffalesto'}
t[688] = t.binacle
t.barbaracle = {ability1 = 'Unghiedure', ability2 = 'Cecchino', abilityd = 'Arraffalesto'}
t[689] = t.barbaracle
t.skrelp = {ability1 = 'Velenopunto', ability2 = 'Velentocco', abilityd = 'Adattabilità'}
t[690] = t.skrelp
t.dragalge = {ability1 = 'Velenopunto', ability2 = 'Velentocco', abilityd = 'Adattabilità'}
t[691] = t.dragalge
t.clauncher = {ability1 = 'Megalancio'}
t[692] = t.clauncher
t.clawitzer = {ability1 = 'Megalancio'}
t[693] = t.clawitzer
t.helioptile = {ability1 = 'Pellearsa', ability2 = 'Sabbiavelo', abilityd = 'Solarpotere'}
t[694] = t.helioptile
t.heliolisk = {ability1 = 'Pellearsa', ability2 = 'Sabbiavelo', abilityd = 'Solarpotere'}
t[695] = t.heliolisk
t.tyrunt = {ability1 = 'Ferromascella', abilityd = 'Vigore'}
t[696] = t.tyrunt
t.tyrantrum = {ability1 = 'Ferromascella', abilityd = 'Testadura'}
t[697] = t.tyrantrum
t.amaura = {ability1 = 'Pellegelo', abilityd = 'Scendineve'}
t[698] = t.amaura
t.aurorus = {ability1 = 'Pellegelo', abilityd = 'Scendineve'}
t[699] = t.aurorus
t.sylveon = {ability1 = 'Incantevole', abilityd = 'Pellefolletto'}
t[700] = t.sylveon
t.hawlucha = {ability1 = 'Scioltezza', ability2 = 'Agiltecnica', abilityd = 'Rompiforma'}
t[701] = t.hawlucha
t.dedenne = {ability1 = 'Guancegonfie', ability2 = 'Raccolta', abilityd = 'Più'}
t[702] = t.dedenne
t.carbink = {ability1 = 'Corpochiaro', abilityd = 'Vigore'}
t[703] = t.carbink
t.goomy = {ability1 = 'Mangiaerba', ability2 = 'Idratazione', abilityd = 'Viscosità'}
t[704] = t.goomy
t.sliggoo = {ability1 = 'Mangiaerba', ability2 = 'Idratazione', abilityd = 'Viscosità'}
t[705] = t.sliggoo
t.goodra = {ability1 = 'Mangiaerba', ability2 = 'Idratazione', abilityd = 'Viscosità'}
t[706] = t.goodra
t.klefki = {ability1 = 'Burla', abilityd = 'Prestigiatore'}
t[707] = t.klefki
t.phantump = {ability1 = 'Alternacura', ability2 = 'Indagine', abilityd = 'Coglibacche'}
t[708] = t.phantump
t.trevenant = {ability1 = 'Alternacura', ability2 = 'Indagine', abilityd = 'Coglibacche'}
t[709] = t.trevenant
t.pumpkaboo = {ability1 = 'Raccolta', ability2 = 'Indagine', abilityd = 'Insonnia'}
t[710] = t.pumpkaboo
t.gourgeist = {ability1 = 'Raccolta', ability2 = 'Indagine', abilityd = 'Insonnia'}
t[711] = t.gourgeist
t.bergmite = {ability1 = 'Mente Locale', ability2 = 'Corpogelo', abilityd = 'Vigore'}
t[712] = t.bergmite
t.avalugg = {ability1 = 'Mente Locale', ability2 = 'Corpogelo', abilityd = 'Vigore'}
t[713] = t.avalugg
t.noibat = {ability1 = 'Indagine', ability2 = 'Intrapasso', abilityd = 'Telepatia'}
t[714] = t.noibat
t.noivern = {ability1 = 'Indagine', ability2 = 'Intrapasso', abilityd = 'Telepatia'}
t[715] = t.noivern
t.xerneas = {ability1 = 'Aurafolletto'}
t[716] = t.xerneas
t.yveltal = {ability1 = 'Auratetra'}
t[717] = t.yveltal
t.zygarde = {ability1 = 'Frangiaura', abilitye = 'Sciamefusione'}
t[718] = t.zygarde
t.diancie = {ability1 = 'Corpochiaro'}
t[719] = t.diancie
t.hoopa = {ability1 = 'Prestigiatore'}
t[720] = t.hoopa
t.volcanion = {ability1 = 'Assorbacqua'}
t[721] = t.volcanion
t.rowlet = {ability1 = 'Erbaiuto', abilityd = 'Distacco'}
t[722] = t.rowlet
t.dartrix = {ability1 = 'Erbaiuto', abilityd = 'Distacco'}
t[723] = t.dartrix
t.decidueye = {ability1 = 'Erbaiuto', abilityd = 'Distacco'}
t[724] = t.decidueye
t.litten = {ability1 = 'Aiutofuoco', abilityd = 'Prepotenza'}
t[725] = t.litten
t.torracat = {ability1 = 'Aiutofuoco', abilityd = 'Prepotenza'}
t[726] = t.torracat
t.incineroar = {ability1 = 'Aiutofuoco', abilityd = 'Prepotenza'}
t[727] = t.incineroar
t.popplio = {ability1 = 'Acquaiuto', abilityd = 'Idrovoce'}
t[728] = t.popplio
t.brionne = {ability1 = 'Acquaiuto', abilityd = 'Idrovoce'}
t[729] = t.brionne
t.primarina = {ability1 = 'Acquaiuto', abilityd = 'Idrovoce'}
t[730] = t.primarina
t.pikipek = {ability1 = 'Sguardofermo', ability2 = 'Abillegame', abilityd = 'Raccolta'}
t[731] = t.pikipek
t.trumbeak = {ability1 = 'Sguardofermo', ability2 = 'Abillegame', abilityd = 'Raccolta'}
t[732] = t.trumbeak
t.toucannon = {ability1 = 'Sguardofermo', ability2 = 'Abillegame', abilityd = 'Forzabruta'}
t[733] = t.toucannon
t.yungoos = {ability1 = 'Sorveglianza', ability2 = 'Ferromascella', abilityd = 'Adattabilità'}
t[734] = t.yungoos
t.gumshoos = {ability1 = 'Sorveglianza', ability2 = 'Ferromascella', abilityd = 'Adattabilità'}
t[735] = t.gumshoos
t.grubbin = {ability1 = 'Aiutinsetto'}
t[736] = t.grubbin
t.charjabug = {ability1 = 'Batteria'}
t[737] = t.charjabug
t.vikavolt = {ability1 = 'Levitazione'}
t[738] = t.vikavolt
t.crabrawler = {ability1 = 'Ipertaglio', ability2 = 'Ferropugno', abilityd = 'Grancollera'}
t[739] = t.crabrawler
t.crabominable = {ability1 = 'Ipertaglio', ability2 = 'Ferropugno', abilityd = 'Grancollera'}
t[740] = t.crabominable
t.oricorio = {ability1 = 'Sincrodanza'}
t[741] = t.oricorio
t.cutiefly = {ability1 = 'Mielincetta', ability2 = 'Polvoscudo', abilityd = 'Dolcevelo'}
t[742] = t.cutiefly
t.ribombee = {ability1 = 'Mielincetta', ability2 = 'Polvoscudo', abilityd = 'Dolcevelo'}
t[743] = t.ribombee
t.rockruff = {ability1 = 'Sguardofermo', ability2 = 'Spiritovivo', abilityd = 'Cuordeciso', abilitye = 'Mente Locale'}
t[744] = t.rockruff
t.lycanroc = {ability1 = 'Sguardofermo', ability2 = 'Remasabbia', abilityd = 'Cuordeciso'}
t[745] = t.lycanroc
t.wishiwashi = {ability1 = 'Banco'}
t[746] = t.wishiwashi
t.mareanie = {ability1 = 'Spietatezza', ability2 = 'Scioltezza', abilityd = 'Rigenergia'}
t[747] = t.mareanie
t.toxapex = {ability1 = 'Spietatezza', ability2 = 'Scioltezza', abilityd = 'Rigenergia'}
t[748] = t.toxapex
t.mudbray = {ability1 = 'Mente Locale', ability2 = 'Sopportazione', abilityd = 'Forza Interiore'}
t[749] = t.mudbray
t.mudsdale = {ability1 = 'Mente Locale', ability2 = 'Sopportazione', abilityd = 'Forza Interiore'}
t[750] = t.mudsdale
t.dewpider = {ability1 = 'Bolladacqua', abilityd = 'Assorbacqua'}
t[751] = t.dewpider
t.araquanid = {ability1 = 'Bolladacqua', abilityd = 'Assorbacqua'}
t[752] = t.araquanid
t.fomantis = {ability1 = 'Fogliamanto', abilityd = 'Inversione'}
t[753] = t.fomantis
t.lurantis = {ability1 = 'Fogliamanto', abilityd = 'Inversione'}
t[754] = t.lurantis
t.morelull = {ability1 = 'Risplendi', ability2 = 'Spargispora', abilityd = 'Copripioggia'}
t[755] = t.morelull
t.shiinotic = {ability1 = 'Risplendi', ability2 = 'Spargispora', abilityd = 'Copripioggia'}
t[756] = t.shiinotic
t.salandit = {ability1 = 'Corrosione', abilityd = 'Indifferenza'}
t[757] = t.salandit
t.salazzle = {ability1 = 'Corrosione', abilityd = 'Indifferenza'}
t[758] = t.salazzle
t.stufful = {ability1 = 'Morbidone', ability2 = 'Impaccio', abilityd = 'Incantevole'}
t[759] = t.stufful
t.bewear = {ability1 = 'Morbidone', ability2 = 'Impaccio', abilityd = 'Agitazione'}
t[760] = t.bewear
t.bounsweet = {ability1 = 'Fogliamanto', ability2 = 'Indifferenza', abilityd = 'Dolcevelo'}
t[761] = t.bounsweet
t.steenee = {ability1 = 'Fogliamanto', ability2 = 'Indifferenza', abilityd = 'Dolcevelo'}
t[762] = t.steenee
t.tsareena = {ability1 = 'Fogliamanto', ability2 = 'Regalità', abilityd = 'Dolcevelo'}
t[763] = t.tsareena
t.comfey = {ability1 = 'Fiorvelo', ability2 = 'Primacura', abilityd = 'Alternacura'}
t[764] = t.comfey
t.oranguru = {ability1 = 'Forza Interiore', ability2 = 'Telepatia', abilityd = 'Simbiosi'}
t[765] = t.oranguru
t.passimian = {ability1 = 'Ricezione', abilityd = 'Agonismo'}
t[766] = t.passimian
t.wimpod = {ability1 = 'Fuggifuggi'}
t[767] = t.wimpod
t.golisopod = {ability1 = 'Passoindietro'}
t[768] = t.golisopod
t.sandygast = {ability1 = 'Idrorinforzo', abilityd = 'Sabbiavelo'}
t[769] = t.sandygast
t.palossand = {ability1 = 'Idrorinforzo', abilityd = 'Sabbiavelo'}
t[770] = t.palossand
t.pyukumuku = {ability1 = 'Espellinterno', abilityd = 'Imprudenza'}
t[771] = t.pyukumuku
t['tipo zero'] = {ability1 = 'Lottascudo'}
t[772] = t['tipo zero']
t.silvally = {ability1 = 'Sistema Primevo'}
t[773] = t.silvally
t.minior = {ability1 = 'Scudosoglia'}
t[774] = t.minior
t.komala = {ability1 = 'Sonno Assoluto'}
t[775] = t.komala
t.turtonator = {ability1 = 'Guscioscudo'}
t[776] = t.turtonator
t.togedemaru = {ability1 = 'Spineferrate', ability2 = 'Parafulmine', abilityd = 'Vigore'}
t[777] = t.togedemaru
t.mimikyu = {ability1 = 'Fantasmanto'}
t[778] = t.mimikyu
t.bruxish = {ability1 = 'Corposgargiante', ability2 = 'Ferromascella', abilityd = 'Splendicute'}
t[779] = t.bruxish
t.drampa = {ability1 = 'Furore', ability2 = 'Mangiaerba', abilityd = 'Antimeteo'}
t[780] = t.drampa
t.dhelmise = {ability1 = 'Tempracciaio'}
t[781] = t.dhelmise
t['jangmo-o'] = {ability1 = 'Antiproiettile', ability2 = 'Antisuono', abilityd = 'Copricapo'}
t[782] = t['jangmo-o']
t['hakamo-o'] = {ability1 = 'Antiproiettile', ability2 = 'Antisuono', abilityd = 'Copricapo'}
t[783] = t['hakamo-o']
t['kommo-o'] = {ability1 = 'Antiproiettile', ability2 = 'Antisuono', abilityd = 'Copricapo'}
t[784] = t['kommo-o']
t['tapu koko'] = {ability1 = 'Elettrogenesi', abilityd = 'Telepatia'}
t[785] = t['tapu koko']
t['tapu lele'] = {ability1 = 'Psicogenesi', abilityd = 'Telepatia'}
t[786] = t['tapu lele']
t['tapu bulu'] = {ability1 = 'Erbogenesi', abilityd = 'Telepatia'}
t[787] = t['tapu bulu']
t['tapu fini'] = {ability1 = 'Nebbiogenesi', abilityd = 'Telepatia'}
t[788] = t['tapu fini']
t.cosmog = {ability1 = 'Imprudenza'}
t[789] = t.cosmog
t.cosmoem = {ability1 = 'Vigore'}
t[790] = t.cosmoem
t.solgaleo = {ability1 = 'Metalprotezione'}
t[791] = t.solgaleo
t.lunala = {ability1 = 'Spettroguardia'}
t[792] = t.lunala
t.nihilego = {ability1 = 'Ultraboost'}
t[793] = t.nihilego
t.buzzwole = {ability1 = 'Ultraboost'}
t[794] = t.buzzwole
t.pheromosa = {ability1 = 'Ultraboost'}
t[795] = t.pheromosa
t.xurkitree = {ability1 = 'Ultraboost'}
t[796] = t.xurkitree
t.celesteela = {ability1 = 'Ultraboost'}
t[797] = t.celesteela
t.kartana = {ability1 = 'Ultraboost'}
t[798] = t.kartana
t.guzzlord = {ability1 = 'Ultraboost'}
t[799] = t.guzzlord
t.necrozma = {ability1 = 'Scudoprisma'}
t[800] = t.necrozma
t.magearna = {ability1 = 'Cuoreanima'}
t[801] = t.magearna
t.marshadow = {ability1 = 'Tecnico'}
t[802] = t.marshadow
t.poipole = {ability1 = 'Ultraboost'}
t[803] = t.poipole
t.naganadel = {ability1 = 'Ultraboost'}
t[804] = t.naganadel
t.stakataka = {ability1 = 'Ultraboost'}
t[805] = t.stakataka
t.blacephalon = {ability1 = 'Ultraboost'}
t[806] = t.blacephalon
t.zeraora = {ability1 = 'Assorbivolt'}
t[807] = t.zeraora
t.meltan = {ability1 = 'Magnetismo'}
t[808] = t.meltan
t.melmetal = {ability1 = 'Ferropugno'}
t[809] = t.melmetal
t.grookey = {ability1 = 'Erbaiuto', abilityd = 'Erbogenesi'}
t[810] = t.grookey
t.thwackey = {ability1 = 'Erbaiuto', abilityd = 'Erbogenesi'}
t[811] = t.thwackey
t.rillaboom = {ability1 = 'Erbaiuto', abilityd = 'Erbogenesi'}
t[812] = t.rillaboom
t.scorbunny = {ability1 = 'Aiutofuoco', abilityd = 'Libero'}
t[813] = t.scorbunny
t.raboot = {ability1 = 'Aiutofuoco', abilityd = 'Libero'}
t[814] = t.raboot
t.cinderace = {ability1 = 'Aiutofuoco', abilityd = 'Libero'}
t[815] = t.cinderace
t.sobble = {ability1 = 'Acquaiuto', abilityd = 'Cecchino'}
t[816] = t.sobble
t.drizzile = {ability1 = 'Acquaiuto', abilityd = 'Cecchino'}
t[817] = t.drizzile
t.inteleon = {ability1 = 'Acquaiuto', abilityd = 'Cecchino'}
t[818] = t.inteleon
t.skwovet = {ability1 = 'Guancegonfie', abilityd = 'Voracità'}
t[819] = t.skwovet
t.greedent = {ability1 = 'Guancegonfie', abilityd = 'Voracità'}
t[820] = t.greedent
t.rookidee = {ability1 = 'Sguardofermo', ability2 = 'Agitazione', abilityd = 'Pettinfuori'}
t[821] = t.rookidee
t.corvisquire = {ability1 = 'Sguardofermo', ability2 = 'Agitazione', abilityd = 'Pettinfuori'}
t[822] = t.corvisquire
t.corviknight = {ability1 = 'Pressione', ability2 = 'Agitazione', abilityd = 'Blindospecchio'}
t[823] = t.corviknight
t.blipbug = {ability1 = 'Aiutinsetto', ability2 = 'Insettocchi', abilityd = 'Telepatia'}
t[824] = t.blipbug
t.dottler = {ability1 = 'Aiutinsetto', ability2 = 'Insettocchi', abilityd = 'Telepatia'}
t[825] = t.dottler
t.orbeetle = {ability1 = 'Aiutinsetto', ability2 = 'Indagine', abilityd = 'Telepatia'}
t[826] = t.orbeetle
t.nickit = {ability1 = 'Fugafacile', ability2 = 'Agiltecnica', abilityd = 'Sorveglianza'}
t[827] = t.nickit
t.thievul = {ability1 = 'Fugafacile', ability2 = 'Agiltecnica', abilityd = 'Sorveglianza'}
t[828] = t.thievul
t.gossifleur = {ability1 = 'Lanugine', ability2 = 'Rigenergia', abilityd = 'Spargispora'}
t[829] = t.gossifleur
t.eldegoss = {ability1 = 'Lanugine', ability2 = 'Rigenergia', abilityd = 'Spargispora'}
t[830] = t.eldegoss
t.wooloo = {ability1 = 'Morbidone', ability2 = 'Fugafacile', abilityd = 'Antiproiettile'}
t[831] = t.wooloo
t.dubwool = {ability1 = 'Morbidone', ability2 = 'Cuordeciso', abilityd = 'Antiproiettile'}
t[832] = t.dubwool
t.chewtle = {ability1 = 'Ferromascella', ability2 = 'Guscioscudo', abilityd = 'Nuotovelox'}
t[833] = t.chewtle
t.drednaw = {ability1 = 'Ferromascella', ability2 = 'Guscioscudo', abilityd = 'Nuotovelox'}
t[834] = t.drednaw
t.yamper = {ability1 = 'Raccattapalle', abilityd = 'Paura'}
t[835] = t.yamper
t.boltund = {ability1 = 'Ferromascella', abilityd = 'Tenacia'}
t[836] = t.boltund
t.rolycoly = {ability1 = 'Vapormacchina', ability2 = 'Antifuoco', abilityd = 'Fuocardore'}
t[837] = t.rolycoly
t.carkol = {ability1 = 'Vapormacchina', ability2 = 'Corpodifuoco', abilityd = 'Fuocardore'}
t[838] = t.carkol
t.coalossal = {ability1 = 'Vapormacchina', ability2 = 'Corpodifuoco', abilityd = 'Fuocardore'}
t[839] = t.coalossal
t.applin = {ability1 = 'Maturazione', ability2 = 'Voracità', abilityd = 'Antiproiettile'}
t[840] = t.applin
t.flapple = {ability1 = 'Maturazione', ability2 = 'Voracità', abilityd = 'Tuttafretta'}
t[841] = t.flapple
t.appletun = {ability1 = 'Maturazione', ability2 = 'Voracità', abilityd = 'Grassospesso'}
t[842] = t.appletun
t.silicobra = {ability1 = 'Sputasabbia', ability2 = 'Muta', abilityd = 'Sabbiavelo'}
t[843] = t.silicobra
t.sandaconda = {ability1 = 'Sputasabbia', ability2 = 'Muta', abilityd = 'Sabbiavelo'}
t[844] = t.sandaconda
t.cramorant = {ability1 = 'Inghiottimissile'}
t[845] = t.cramorant
t.arrokuda = {ability1 = 'Nuotovelox', abilityd = 'Elicopinna'}
t[846] = t.arrokuda
t.barraskewda = {ability1 = 'Nuotovelox', abilityd = 'Elicopinna'}
t[847] = t.barraskewda
t.toxel = {ability1 = 'Paura', ability2 = 'Statico', abilityd = 'Impaccio'}
t[848] = t.toxel
t.toxtricity = {ability1 = 'Punk Rock', ability2 = 'Più', abilityd = 'Tecnico'}
t[849] = t.toxtricity
t.sizzlipede = {ability1 = 'Fuocardore', ability2 = 'Fumochiaro', abilityd = 'Corpodifuoco'}
t[850] = t.sizzlipede
t.centiskorch = {ability1 = 'Fuocardore', ability2 = 'Fumochiaro', abilityd = 'Corpodifuoco'}
t[851] = t.centiskorch
t.clobbopus = {ability1 = 'Scioltezza', abilityd = 'Tecnico'}
t[852] = t.clobbopus
t.grapploct = {ability1 = 'Scioltezza', abilityd = 'Tecnico'}
t[853] = t.grapploct
t.sinistea = {ability1 = 'Sottilguscio', abilityd = 'Corpofunesto'}
t[854] = t.sinistea
t.polteageist = {ability1 = 'Sottilguscio', abilityd = 'Corpofunesto'}
t[855] = t.polteageist
t.hatenna = {ability1 = 'Curacuore', ability2 = 'Presagio', abilityd = 'Magispecchio'}
t[856] = t.hatenna
t.hattrem = {ability1 = 'Curacuore', ability2 = 'Presagio', abilityd = 'Magispecchio'}
t[857] = t.hattrem
t.hatterene = {ability1 = 'Curacuore', ability2 = 'Presagio', abilityd = 'Magispecchio'}
t[858] = t.hatterene
t.impidimp = {ability1 = 'Burla', ability2 = 'Indagine', abilityd = 'Arraffalesto'}
t[859] = t.impidimp
t.morgrem = {ability1 = 'Burla', ability2 = 'Indagine', abilityd = 'Arraffalesto'}
t[860] = t.morgrem
t.grimmsnarl = {ability1 = 'Burla', ability2 = 'Indagine', abilityd = 'Arraffalesto'}
t[861] = t.grimmsnarl
t.obstagoon = {ability1 = 'Temerarietà', ability2 = 'Dentistretti', abilityd = 'Agonismo'}
t[862] = t.obstagoon
t.perrserker = {ability1 = 'Lottascudo', ability2 = 'Unghiedure', abilityd = 'Spiritoferreo'}
t[863] = t.perrserker
t.cursola = {ability1 = 'Sottilguscio', abilityd = 'Ultimotocco'}
t[864] = t.cursola
t["sirfetch'd"] = {ability1 = 'Cuordeciso', abilityd = 'Nervisaldi'}
t[865] = t["sirfetch'd"]
t["mr. rime"] = {ability1 = 'Intricopiedi', ability2 = 'Annullabarriere', abilityd = 'Corpogelo'}
t[866] = t["mr. rime"]
t.runerigus = {ability1 = 'Anima Errante'}
t[867] = t.runerigus
t.milcery = {ability1 = 'Dolcevelo', abilityd = 'Aromavelo'}
t[868] = t.milcery
t.alcremie = {ability1 = 'Dolcevelo', abilityd = 'Aromavelo'}
t[869] = t.alcremie
t.falinks = {ability1 = 'Lottascudo', abilityd = 'Agonismo'}
t[870] = t.falinks
t.pincurchin = {ability1 = 'Parafulmine', abilityd = 'Elettrogenesi'}
t[871] = t.pincurchin
t.snom = {ability1 = 'Polvoscudo', abilityd = 'Geloscaglie'}
t[872] = t.snom
t.frosmoth = {ability1 = 'Polvoscudo', abilityd = 'Geloscaglie'}
t[873] = t.frosmoth
t.stonjourner = {ability1 = 'Fonte Energetica'}
t[874] = t.stonjourner
t.eiscue = {ability1 = 'Gelofaccia'}
t[875] = t.eiscue
t.indeedee = {ability1 = 'Forza Interiore', ability2 = 'Sincronismo', abilityd = 'Psicogenesi'}
t[876] = t.indeedee
t.morpeko = {ability1 = 'Pancialterna'}
t[877] = t.morpeko
t.cufant = {ability1 = 'Forzabruta', abilityd = 'Metalpesante'}
t[878] = t.cufant
t.copperajah = {ability1 = 'Forzabruta', abilityd = 'Metalpesante'}
t[879] = t.copperajah
t.dracozolt = {ability1 = 'Assorbivolt', ability2 = 'Tuttafretta', abilityd = 'Remasabbia'}
t[880] = t.dracozolt
t.arctozolt = {ability1 = 'Assorbivolt', ability2 = 'Statico', abilityd = 'Spalaneve'}
t[881] = t.arctozolt
t.dracovish = {ability1 = 'Assorbacqua', ability2 = 'Ferromascella', abilityd = 'Remasabbia'}
t[882] = t.dracovish
t.arctovish = {ability1 = 'Assorbacqua', ability2 = 'Corpogelo', abilityd = 'Spalaneve'}
t[883] = t.arctovish
t.duraludon = {ability1 = 'Metalleggero', ability2 = 'Metalpesante', abilityd = 'Volontà di Ferro'}
t[884] = t.duraludon
t.dreepy = {ability1 = 'Corpochiaro', ability2 = 'Intrapasso', abilityd = 'Corpofunesto'}
t[885] = t.dreepy
t.drakloak = {ability1 = 'Corpochiaro', ability2 = 'Intrapasso', abilityd = 'Corpofunesto'}
t[886] = t.drakloak
t.dragapult = {ability1 = 'Corpochiaro', ability2 = 'Intrapasso', abilityd = 'Corpofunesto'}
t[887] = t.dragapult
t.zacian = {ability1 = 'Spada Indomita'}
t[888] = t.zacian
t.zamazenta = {ability1 = 'Scudo Saldo'}
t[889] = t.zamazenta
t.eternatus = {ability1 = 'Pressione'}
t[890] = t.eternatus
t.kubfu = {ability1 = 'Forza Interiore'}
t[891] = t.kubfu
t.urshifu = {ability1 = 'Pugni Invisibili'}
t[892] = t.urshifu
t.zarude = {ability1 = 'Fogliamanto'}
t[893] = t.zarude
t.regieleki = {ability1 = 'Transistor'}
t[894] = t.regieleki
t.regidrago = {ability1 = 'Dragomascelle'}
t[895] = t.regidrago
t.glastrier = {ability1 = 'Nitrito Bianco'}
t[896] = t.glastrier
t.spectrier = {ability1 = 'Nitrito Nero'}
t[897] = t.spectrier
t.calyrex = {ability1 = 'Agitazione'}
t[898] = t.calyrex
t.wyrdeer = {ability1 = 'Sconosciuta'}
-- t.wyrdeer = {ability1 = 'Prepotenza', ability2 = 'Indagine', abilityd = 'Mangiaerba'}
t[899] = t.wyrdeer
t.kleavor = {ability1 = 'Sconosciuta'}
-- t.kleavor = {ability1 = 'Aiutinsetto', ability2 = 'Forzabruta', abilityd = 'Cuordeciso'}
t[900] = t.kleavor
t.ursaluna = {ability1 = 'Sconosciuta'}
-- t.ursaluna = {ability1 = 'Dentistretti', ability2 = 'Antiproiettile', abilityd = 'Agitazione'}
t[901] = t.ursaluna
t.basculegion = {ability1 = 'Sconosciuta'}
-- t.basculegion = {ability1 = 'Paura', ability2 = 'Adattabilità', abilityd = 'Rompiforma'}
t[902] = t.basculegion
t.sneasler = {ability1 = 'Sconosciuta'}
-- t.sneasler = {ability1 = 'Pressione', abilityd = 'Velentocco'}
t[903] = t.sneasler
t.overqwil = {ability1 = 'Sconosciuta'}
-- t.overqwil = {ability1 = 'Velenopunto', ability2 = 'Nuotovelox', abilityd = 'Prepotenza'}
t[904] = t.overqwil
t.enamorus = {ability1 = 'Sconosciuta'}
-- t.enamorus = {ability1 = 'Curacuore', abilityd = 'Inversione'}
t[905] = t.enamorus

t.sprigatito = {ability1 = 'Erbaiuto'}
t.fuecoco = {ability1 = 'Aiutofuoco'}
t.quaxly = {ability1 = 'Acquaiuto'}
t.lechonk = {ability1 = 'Aromavelo', ability2 = 'Voracità'}
t.pawmi = {ability1 = 'Statico', ability2 = 'Alternacura'}
t.smoliv = {ability1 = 'Sveglialampo'}
t.fidough = {ability1 = 'Mente Locale'}
t.grafaiai = {ability1 = 'Agiltecnica', ability2 = 'Velentocco'}
t.cetitan = {ability1 = 'Grassospesso', ability2 = 'Spalaneve'}
t.cyclizar = {ability1 = 'Muta'}
t.klawf = {ability1 = 'Iraguscio', ability2 = 'Guscioscudo'}
t.armarouge = {ability1 = 'Fuocardore'}
t.ceruledge = {ability1 = 'Fuocardore'}
t.koraidon = {ability1 = 'Sconosciuta'}
t.miraidon = {ability1 = 'Sconosciuta'}
t.farigiraf = {ability1 = 'Ruminante', ability2 = 'Codarmatura'}

-- I dati sulle forme alternative che cambiano abilità rispetto alla forma base
-- Sono raggiungibili soltanto tramite il nome, dato che non hanno un ndex proprio
-- Il nome è composto dal nome del Pokémon, seguito dalla sigla della forma alternativa

t.rattataA = {ability1 = 'Voracità', ability2 = 'Tuttafretta', abilityd = 'Grassospesso'}
t['019A'] = t.rattataA
t.raticateA = {ability1 = 'Voracità', ability2 = 'Tuttafretta', abilityd = 'Grassospesso'}
t['020A'] = t.raticateA
t.pikachuCs = {ability1 = 'Parafulmine'}
t['025Cs'] = t.pikachuCs
t.pikachuCm = {ability1 = 'Nessuna'}
t['025Cm'] = t.pikachuCm
t.raichuA = {ability1 = 'Codasurf'}
t['026A'] = t.raichuA
t.sandshrewA = {ability1 = 'Mantelneve', abilityd = 'Spalaneve'}
t['027A'] = t.sandshrewA
t.sandslashA = {ability1 = 'Mantelneve', abilityd = 'Spalaneve'}
t['028A'] = t.sandslashA
t.vulpixA = {ability1 = 'Mantelneve', abilityd = 'Scendineve'}
t['037A'] = t.vulpixA
t.ninetalesA = {ability1 = 'Mantelneve', abilityd = 'Scendineve'}
t['038A'] = t.ninetalesA
t.diglettA = {ability1 = 'Sabbiavelo', ability2 = 'Boccolidoro', abilityd = 'Silicoforza'}
t['050A'] = t.diglettA
t.dugtrioA = {ability1 = 'Sabbiavelo', ability2 = 'Boccolidoro', abilityd = 'Silicoforza'}
t['051A'] = t.dugtrioA
t.meowthA = {ability1 = 'Raccolta', ability2 = 'Tecnico', abilityd = 'Paura'}
t['052A'] = t.meowthA
t.meowthG = {ability1 = 'Raccolta', ability2 = 'Unghiedure', abilityd = 'Agitazione'}
t['052G'] = t.meowthG
t.persianA = {ability1 = 'Foltopelo', ability2 = 'Tecnico', abilityd = 'Paura'}
t['053A'] = t.persianA
t.growlitheH = {ability1 = 'Sconosciuta'}
-- t.growlitheH = {ability1 = 'Prepotenza', ability2 = 'Fuocardore', abilityd = 'Giustizia'}
t['058H'] = t.growlitheH
t.arcanineH = {ability1 = 'Sconosciuta'}
-- t.arcanineH = {ability1 = 'Prepotenza', ability2 = 'Fuocardore', abilityd = 'Giustizia'}
t['059H'] = t.arcanineH
t.geodudeA = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Pellelettro'}
t['074A'] = t.geodudeA
t.gravelerA = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Pellelettro'}
t['075A'] = t.gravelerA
t.golemA = {ability1 = 'Magnetismo', ability2 = 'Vigore', abilityd = 'Pellelettro'}
t['076A'] = t.golemA
t.ponytaG = {ability1 = 'Fugafacile', ability2 = 'Pastelvelo', abilityd = 'Presagio'}
t['077G'] = t.ponytaG
t.rapidashG = {ability1 = 'Fugafacile', ability2 = 'Pastelvelo', abilityd = 'Presagio'}
t['078G'] = t.rapidashG
t.slowpokeG = {ability1 = 'Voracità', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t['079G'] = t.slowpokeG
t.slowbroG = {ability1 = 'Colpolesto', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t['080G'] = t.slowbroG
t["farfetch'dG"] = {ability1 = 'Cuordeciso', abilityd = 'Nervisaldi'}
t['083G'] = t["farfetch'dG"]
t.grimerA = {ability1 = 'Velentocco', ability2 = 'Voracità', abilityd = 'Forza Chimica'}
t['088A'] = t.grimerA
t.mukA = {ability1 = 'Velentocco', ability2 = 'Voracità', abilityd = 'Forza Chimica'}
t['089A'] = t.mukA
t.voltorbH = {ability1 = 'Sconosciuta'}
-- t.voltorbH = {ability1 = 'Antisuono', ability2 = 'Statico', abilityd = 'Scoppio'}
t['100H'] = t.voltorbH
t.electrodeH = {ability1 = 'Sconosciuta'}
-- t.electrodeH = {ability1 = 'Antisuono', ability2 = 'Statico', abilityd = 'Scoppio'}
t['101H'] = t.electrodeH
t.exeggutorA = {ability1 = 'Indagine', abilityd = 'Coglibacche'}
t['103A'] = t.exeggutorA
t.marowakA = {ability1 = 'Corpofunesto', ability2 = 'Parafulmine', abilityd = 'Testadura'}
t['105A'] = t.marowakA
t.weezingG = {ability1 = 'Levitazione', ability2 = 'Gas Reagente', abilityd = 'Nebbiogenesi'}
t['110G'] = t.weezingG
t['mr. mimeG'] = {ability1 = 'Spiritovivo', ability2 = 'Annullabarriere', abilityd = 'Corpogelo'}
t['122G'] = t['mr. mimeG']
t.eeveeCm = {ability1 = 'Nessuna'}
t['133Cm'] = t.eeveeCm
t.articunoG = {ability1 = 'Tenacia'}
t['144G'] = t.articunoG
t.zapdosG = {ability1 = 'Agonismo'}
t['145G'] = t.zapdosG
t.moltresG = {ability1 = 'Furore'}
t['146G'] = t.moltresG
t.typhlosionH = {ability1 = 'Sconosciuta'}
-- t.typhlosionH = {ability1 = 'Aiutofuoco', abilityd = 'Fuocardore'}
t['157H'] = t.typhlosionH
t.wooperP = {ability1 = 'Velenopunto', ability2 = 'Assorbacqua'}
t['194P'] = t.wooperP
t.slowkingG = {ability1 = 'Stranofarmaco', ability2 = 'Mente Locale', abilityd = 'Rigenergia'}
t['199G'] = t.slowkingG
t.qwilfishH = {ability1 = 'Sconosciuta'}
-- t.qwilfishH = {ability1 = 'Velenopunto', ability2 = 'Nuotovelox', abilityd = 'Prepotenza'}
t['211H'] = t.qwilfishH
t.sneaselH = {ability1 = 'Sconosciuta'}
-- t.sneaselH = {ability1 = 'Forza Interiore', ability2 = 'Sguardofermo', abilityd = 'Velentocco'}
t['215H'] = t.sneaselH
t.corsolaG = {ability1 = 'Sottilguscio', abilityd = 'Corpofunesto'}
t['222G'] = t.corsolaG
t.zigzagoonG = {ability1 = 'Raccolta', ability2 = 'Voracità', abilityd = 'Piedisvelti'}
t['263G'] = t.zigzagoonG
t.linooneG = {ability1 = 'Raccolta', ability2 = 'Voracità', abilityd = 'Piedisvelti'}
t['264G'] = t.linooneG
t.giratinaO = {ability1 = 'Levitazione'}
t['487O'] = t.giratinaO
t.shayminC = {ability1 = 'Leggiadro'}
t['492C'] = t.shayminC
t.samurottH = {ability1 = 'Sconosciuta'}
-- t.samurottH = {ability1 = 'Acquaiuto', abilityd = 'Guscioscudo'}
t['503H'] = t.samurottH
t.lilligantH = {ability1 = 'Sconosciuta'}
-- t.lilligantH = {ability1 = 'Clorofilla', ability2 = 'Tuttafretta', abilityd = 'Fogliamanto'}
t['549H'] = t.lilligantH
t.basculinB = {ability1 = 'Testadura', ability2 = 'Adattabilità', abilityd = 'Rompiforma'}
t['550B'] = t.basculinB
t.basculinBi = {ability1 = 'Sconosciuta'}
-- t.basculinBi = {ability1 = 'Paura', ability2 = 'Adattabilità', abilityd = 'Rompiforma'}
t['550Bi'] = t.basculinBi
t.darmanitanZ = {ability1 = 'Stato Zen'}
t['555Z'] = t.darmanitanZ
t.darmanitanG = {ability1 = 'Vigorilla', abilityd = 'Stato Zen'}
t['555G'] = t.darmanitanG
t.darmanitanGZ = {ability1 = 'Stato Zen'}
t['555GZ'] = t.darmanitanGZ
t.yamaskG = {ability1 = 'Anima Errante'}
t['562G'] = t.yamaskG
t.zoruaH = {ability1 = 'Sconosciuta'}
-- t.zoruaH = {ability1 = 'Illusione'}
t['570H'] = t.zoruaH
t.zoroarkH = {ability1 = 'Sconosciuta'}
-- t.zoroarkH = {ability1 = 'Illusione'}
t['571H'] = t.zoroarkH
t.stunfiskG = {ability1 = 'Mimetismo'}
t['618G'] = t.stunfiskG
t.braviaryH = {ability1 = 'Sconosciuta'}
-- t.braviaryH = {ability1 = 'Sguardofermo', ability2 = 'Forzabruta', abilityd = 'Agonismo'}
t['628H'] = t.braviaryH
t.tornadusT = {ability1 = 'Rigenergia'}
t['641T'] = t.tornadusT
t.thundurusT = {ability1 = 'Assorbivolt'}
t['642T'] = t.thundurusT
t.landorusT = {ability1 = 'Prepotenza'}
t['645T'] = t.landorusT
t.kyuremN = {ability1 = 'Teravolt'}
t['646N'] = t.kyuremN
t.kyuremB = {ability1 = 'Piroturbina'}
t['646B'] = t.kyuremB
t.greninjaA = {ability1 = 'Morfosintonia'}
t['658A'] = t.greninjaA
t.meowsticF = {ability1 = 'Sguardofermo', ability2 = 'Intrapasso', abilityd = 'Tenacia'}
t['678F'] = t.meowsticF
t.sliggooH = {ability1 = 'Sconosciuta'}
-- t.sliggooH = {ability1 = 'Mangiaerba', ability2 = 'Copricapo', abilityd = 'Viscosità'}
t['705H'] = t.sliggooH
t.goodraH = {ability1 = 'Sconosciuta'}
-- t.goodraH = {ability1 = 'Mangiaerba', ability2 = 'Copricapo', abilityd = 'Viscosità'}
t['706H'] = t.goodraH
t.avaluggH = {ability1 = 'Sconosciuta'}
-- t.avaluggH = {ability1 = 'Ferromascella', ability2 = 'Corpogelo', abilityd = 'Vigore'}
t['713H'] = t.avaluggH
t.zygardeP = {ability1 = 'Sciamefusione'}
t['718P'] = t.zygardeP
t.decidueyeH = {ability1 = 'Sconosciuta'}
-- t.decidueyeH = {ability1 = 'Erbaiuto', abilityd = 'Distacco'}
t['724H'] = t.decidueyeH
t.lycanrocN = {ability1 = 'Sguardofermo', ability2 = 'Spiritovivo', abilityd = 'Nullodifesa'}
t['745N'] = t.lycanrocN
t.lycanrocC = {ability1 = 'Unghiedure'}
t['745C'] = t.lycanrocC
t.necrozmaU = {ability1 = 'Cerebroforza'}
t['800U'] = t.necrozmaU
-- t.cramorantT, t['845T'], t.cramorantI, t['845I'] =
--     t.cramorant, t.cramorant, t.cramorant, t.cramorant
t.toxtricityB = {ability1 = 'Punk Rock', ability2 = 'Meno', abilityd = 'Tecnico'}
t['849B'] = t.toxtricityB
t.indeedeeF = {ability1 = 'Mente Locale', ability2 = 'Sincronismo', abilityd = 'Psicogenesi'}
t['876F'] = t.indeedeeF
t.calyrexG = {ability1 = 'Sintonia Equina'}
t['898G'] = t.calyrexG
t.calyrexS = {ability1 = 'Sintonia Equina'}
t['898S'] = t.calyrexS
t.enamorusT = {ability1 = 'Sconosciuta'}
-- t.enamorusT = {ability1 = 'Copricapo'}
t['905T'] = t.enamorusT

-- Alias per le altre forme alternative rilevanti

t.pikachuR, t['025R'], t.pikachuD, t['025D'], t.pikachuCn,
    t['025Cn'], t.pikachuS, t['025S'], t.pikachuW, t['025W'] =
    t.pikachuCs, t.pikachuCs, t.pikachuCs, t.pikachuCs, t.pikachuCs, t.pikachuCs,
    t.pikachuCs, t.pikachuCs, t.pikachuCs, t.pikachuCs
t.castformS, t.castformP, t.castformN = t.castform, t.castform, t.castform
t['351S'], t['351P'], t['351N'] = t.castform, t.castform, t.castform
t.deoxysA, t.deoxysD, t.deoxysV = t.deoxys, t.deoxys, t.deoxys
t['386A'], t['386D'], t['386V'] = t.deoxys, t.deoxys, t.deoxys
t['413Sc'], t['413Sa'] = t.wormadam, t.wormadam
t.wormadamSc, t.wormadamSa = t.wormadam, t.wormadam
t.cherrimS, t['421S'] = t.cherrim, t.cherrim
t.rotomC, t.rotomL, t.rotomG = t.rotom, t.rotom,  t.rotom
t.rotomV, t.rotomT = t.rotom, t.rotom
t['479C'], t['479L'], t['479G'] = t.rotom, t.rotom,  t.rotom
t['479V'], t['479T'] = t.rotom, t.rotom
t.dialgaO = { ability1 = 'Sconosciuta'}
t['483O'] = t.dialgaO
t.palkiaO = { ability1 = 'Sconosciuta' }
t['484O'] = t.palkiaO
-- t.dialgaO, t['483O'] = t.dialga, t.dialga
-- t.palkiaO, t['484O'] = t.palkia, t.palkia
t['493L'], t['493Vo'], t['493Ve'] = t.arceus, t.arceus, t.arceus
t.arceusL, t.arceusVo, t.arceusVe = t.arceus, t.arceus, t.arceus
t['493T'], t['493R'], t['493C'] = t.arceus, t.arceus, t.arceus
t.arceusT, t.arceusR, t.arceusC = t.arceus, t.arceus, t.arceus
t['493S'], t['493Ai'], t['493Fu'] = t.arceus, t.arceus, t.arceus
t.arceusS, t.arceusAi, t.arceusFu = t.arceus, t.arceus, t.arceus
t['493Aq'], t['493Er'], t['493El'] = t.arceus, t.arceus, t.arceus
t.arceusAq, t.arceusEr, t.arceusEl = t.arceus, t.arceus, t.arceus
t['493P'], t['493G'], t['493D'] = t.arceus, t.arceus, t.arceus
t.arceusP, t.arceusG, t.arceusD = t.arceus, t.arceus, t.arceus
t['493B'], t['493Fo'], t['493Sc'] = t.arceus, t.arceus, t.arceus
t.arceusB, t.arceusFo, t.arceusSc = t.arceus, t.arceus, t.arceus
t.darumakaG = t.darumaka
t['554G'] = t.darumaka
t.meloettaD = t.meloetta
t['648D'] = t.meloetta
t.aegislashS = t.aegislash
t['681S'] = t.aegislash
t.pumpkabooS, t.pumpkabooL, t.pumpkabooXL = t.pumpkaboo, t.pumpkaboo, t.pumpkaboo
t['710S'], t['710L'], t['710XL'] = t.pumpkaboo, t.pumpkaboo, t.pumpkaboo
t.gourgeistS, t.gourgeistL, t.gourgeistXL = t.gourgeist, t.gourgeist, t.gourgeist
t['711S'], t['711L'], t['711XL'] = t.gourgeist, t.gourgeist, t.gourgeist
t.zygardeD = t.zygarde
t['718D'] = t.zygarde
t.hoopaL = t.hoopa
t['720L'] = t.hoopa
t.oricorioC, t.oricorioH, t.oricorioB = t.oricorio, t.oricorio, t.oricorio
t['741C'], t['741H'], t['741B'] = t.oricorio, t.oricorio, t.oricorio
t.wishiwashiB = t.wishiwashi
t['746B'] = t.wishiwashi
t.silvallyL, t.silvallyVo, t.silvallyVe = t.silvally, t.silvally, t.silvally
t['773L'], t['773Vo'], t['773Ve'] = t.silvally, t.silvally, t.silvally
t.silvallyT, t.silvallyR, t.silvallyC = t.silvally, t.silvally, t.silvally
t['773T'], t['773R'], t['773C'] = t.silvally, t.silvally, t.silvally
t.silvallyS, t.silvallyAi, t.silvallyFu = t.silvally, t.silvally, t.silvally
t['773S'], t['773Ai'], t['773Fu'] = t.silvally, t.silvally, t.silvally
t.silvallyAq, t.silvallyEr, t.silvallyEl = t.silvally, t.silvally, t.silvally
t['773Aq'], t['773Er'], t['773El'] = t.silvally, t.silvally, t.silvally
t.silvallyP, t.silvallyG, t.silvallyD = t.silvally, t.silvally, t.silvally
t['773P'], t['773G'], t['773D'] = t.silvally, t.silvally, t.silvally
t.silvallyB, t.silvallyFo = t.silvally, t.silvally
t['773B'], t['773Fo'] = t.silvally, t.silvally
t.miniorR, t['774R'] = t.minior, t.minior
t.necrozmaV, t.necrozmaA = t.necrozma, t.necrozma
t['800V'], t['800A'] = t.necrozma, t.necrozma
t.eiscueL, t['875L'] = t.eiscue, t.eiscue
t.morpekoV, t['877V'] = t.morpeko, t.morpeko
t.zacianR, t['888R'] = t.zacian, t.zacian
t.zamazentaR, t['889R'] = t.zamazenta, t.zamazenta
t.eternatusD, t['890D'] = t.eternatus, t.eternatus
t.urshifuP, t['892P'] = t.urshifu, t.urshifu
t.basculegionF, t['902F'] = t.basculegion, t.basculegion

-- Gigamax
t.venusaurGi, t['003Gi'] = t.venusaur, t.venusaur
t.charizardGi, t['006Gi'] = t.charizard, t.charizard
t.blastoiseGi, t['009Gi'] = t.blastoise, t.blastoise
t.butterfreeGi, t['012Gi'] = t.butterfree, t.butterfree
t.pikachuGi, t['025Gi'] = t.pikachu, t.pikachu
t.meowthGi, t['052Gi'] = t.meowth, t.meowth
t.machampGi, t['068Gi'] = t.machamp, t.machamp
t.gengarGi = {ability1 = 'Corpofunesto'}
t['094Gi'] = t.gengarGi
t.kinglerGi, t['099Gi'] = t.kingler, t.kingler
t.laprasGi, t['131Gi'] = t.lapras, t.lapras
t.eeveeGi, t['133Gi'] = t.eevee, t.eevee
t.snorlaxGi, t['143Gi'] = t.snorlax, t.snorlax
t.garbodorGi, t['569Gi'] = t.garbodor, t.garbodor
t.melmetalGi, t['809Gi'] = t.melmetal, t.melmetal
t.rillaboomGi, t['812Gi'] = t.rillaboom, t.rillaboom
t.cinderaceGi, t['815Gi'] = t.cinderace, t.cinderace
t.inteleonGi, t['818Gi'] = t.inteleon, t.inteleon
t.corviknightGi, t['823Gi'] = t.corviknight, t.corviknight
t.orbeetleGi, t['826Gi'] = t.orbeetle, t.orbeetle
t.drednawGi, t['834Gi'] = t.drednaw, t.drednaw
t.coalossalGi, t['839Gi'] = t.coalossal, t.coalossal
t.flappleGi, t['841Gi'] = t.flapple, t.flapple
t.appletunGi, t['842Gi'] = t.appletun, t.appletun
t.sandacondaGi, t['844Gi'] = t.sandaconda, t.sandaconda
t.toxtricityGi, t['849Gi'] = t.toxtricity, t.toxtricity
t.centiskorchGi, t['851Gi'] = t.centiskorch, t.centiskorch
t.hattereneGi, t['858Gi'] = t.hatterene, t.hatterene
t.grimmsnarlGi, t['861Gi'] = t.grimmsnarl, t.grimmsnarl
t.alcremieGi, t['869Gi'] = t.alcremie, t.alcremie
t.copperajahGi, t['879Gi'] = t.copperajah, t.copperajah
t.duraludonGi, t['884Gi'] = t.duraludon, t.duraludon
t.urshifuGi = t.urshifu
t.urshifuPGi = t.urshifuP

-- Mega evolutions

t.venusaurM = {ability1 = 'Grassospesso'}
t['003M'] = t.venusaurM
t.charizardMX = {ability1 = 'Unghiedure'}
t['006MX'] = t.charizardMX
t.charizardMY = {ability1 = 'Siccità'}
t['006MY'] = t.charizardMY
t.blastoiseM = {ability1 = 'Megalancio'}
t['009M'] = t.blastoiseM
t.beedrillM = {ability1 = 'Adattabilità'}
t['015M'] = t.beedrillM
t.pidgeotM = {ability1 = 'Nullodifesa'}
t['018M'] = t.pidgeotM
t.alakazamM = {ability1 = 'Traccia'}
t['065M'] = t.alakazamM
t.slowbroM = {ability1 = 'Guscioscudo'}
t['080M'] = t.slowbroM
t.gengarM = {ability1 = 'Pedinombra'}
t['094M'] = t.gengarM
t.kangaskhanM = {ability1 = 'Amorefiliale'}
t['115M'] = t.kangaskhanM
t.pinsirM = {ability1 = 'Pellecielo'}
t['127M'] = t.pinsirM
t.gyaradosM = {ability1 = 'Rompiforma'}
t['130M'] = t.gyaradosM
t.aerodactylM = {ability1 = 'Unghiedure'}
t['142M'] = t.aerodactylM
t.mewtwoMX = {ability1 = 'Cuordeciso'}
t['150MX'] = t.mewtwoMX
t.mewtwoMY = {ability1 = 'Insonnia'}
t['150MY'] = t.mewtwoMY
t.ampharosM = {ability1 = 'Rompiforma'}
t['181M'] = t.ampharosM
t.steelixM = {ability1 = 'Silicoforza'}
t['208M'] = t.steelixM
t.scizorM = {ability1 = 'Tecnico'}
t['212M'] = t.scizorM
t.heracrossM = {ability1 = 'Abillegame'}
t['214M'] = t.heracrossM
t.houndoomM = {ability1 = 'Solarpotere'}
t['229M'] = t.houndoomM
t.tyranitarM = {ability1 = 'Sabbiafiume'}
t['248M'] = t.tyranitarM
t.sceptileM = {ability1 = 'Parafulmine'}
t['254M'] = t.sceptileM
t.blazikenM = {ability1 = 'Acceleratore'}
t['257M'] = t.blazikenM
t.swampertM = {ability1 = 'Nuotovelox'}
t['260M'] = t.swampertM
t.gardevoirM = {ability1 = 'Pellefolletto'}
t['282M'] = t.gardevoirM
t.sableyeM = {ability1 = 'Magispecchio'}
t['302M'] = t.sableyeM
t.mawileM = {ability1 = 'Macroforza'}
t['303M'] = t.mawileM
t.aggronM = {ability1 = 'Filtro'}
t['306M'] = t.aggronM
t.medichamM = {ability1 = 'Forzapura'}
t['308M'] = t.medichamM
t.manectricM = {ability1 = 'Prepotenza'}
t['310M'] = t.manectricM
t.sharpedoM = {ability1 = 'Ferromascella'}
t['319M'] = t.sharpedoM
t.cameruptM = {ability1 = 'Forzabruta'}
t['323M'] = t.cameruptM
t.altariaM = {ability1 = 'Pellefolletto'}
t['334M'] = t.altariaM
t.banetteM = {ability1 = 'Burla'}
t['354M'] = t.banetteM
t.absolM = {ability1 = 'Magispecchio'}
t['359M'] = t.absolM
t.glalieM = {ability1 = 'Pellegelo'}
t['362M'] = t.glalieM
t.salamenceM = {ability1 = 'Pellecielo'}
t['373M'] = t.salamenceM
t.metagrossM = {ability1 = 'Unghiedure'}
t['376M'] = t.metagrossM
t.latiasM = {ability1 = 'Levitazione'}
t['380M'] = t.latiasM
t.latiosM = {ability1 = 'Levitazione'}
t['381M'] = t.latiosM
t.kyogreA = {ability1 = 'Mare Primordiale'}
t['382A'] = t.kyogreA
t.groudonA = {ability1 = 'Terra Estrema'}
t['383A'] = t.groudonA
t.rayquazaM = {ability1 = 'Flusso Delta'}
t['384M'] = t.rayquazaM
t.lopunnyM = {ability1 = 'Nervisaldi'}
t['428M'] = t.lopunnyM
t.garchompM = {ability1 = 'Silicoforza'}
t['445M'] = t.garchompM
t.lucarioM = {ability1 = 'Adattabilità'}
t['448M'] = t.lucarioM
t.abomasnowM = {ability1 = 'Scendineve'}
t['460M'] = t.abomasnowM
t.galladeM = {ability1 = 'Forza Interiore'}
t['475M'] = t.galladeM
t.audinoM = {ability1 = 'Curacuore'}
t['531M'] = t.audinoM
t.diancieM = {ability1 = 'Magispecchio'}
t['719M'] = t.diancieM

return t
