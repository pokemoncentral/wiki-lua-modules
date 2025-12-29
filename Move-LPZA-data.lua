-- Data module for moves in LPZA

local m = {}

-- stylua: ignore start
m.cometapugno = { name = "Cometapugno", type = "normale", category = "fisico", power = 18, recharge = 6, range = 99 }
m.giornopaga = { name = "Giornopaga", type = "normale", category = "fisico", power = 40, recharge = 6, range = 17 }
m.fuocopugno = { name = "Fuocopugno", type = "fuoco", category = "fisico", power = 75, recharge = 7, range = 99 }
m.gelopugno = { name = "Gelopugno", type = "ghiaccio", category = "fisico", power = 75, recharge = 7, range = 99 }
m.tuonopugno = { name = "Tuonopugno", type = "elettro", category = "fisico", power = 75, recharge = 7, range = 99 }
m.ventagliente = { name = "Ventagliente", type = "normale", category = "speciale", power = 80, recharge = 12, range = 17 }
m.danzaspada = { name = "Danzaspada", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.raffica = { name = "Raffica", type = "volante", category = "speciale", power = 40, recharge = 6, range = 99 }
m["attacco d'ala"] = { name = "Attacco d'Ala", type = "volante", category = "fisico", power = 60, recharge = 6, range = 99 }
m.turbine = { name = "Turbine", type = "normale", category = "stato", power = nil, recharge = 7, range = 12 }
m.volo = { name = "Volo", type = "volante", category = "fisico", power = 90, recharge = 12, range = 7 }
m.frustata = { name = "Frustata", type = "erba", category = "fisico", power = 45, recharge = 6, range = 99 }
m.bottintesta = { name = "Bottintesta", type = "normale", category = "fisico", power = 70, recharge = 7, range = 99 }
m.azione = { name = "Azione", type = "normale", category = "fisico", power = 40, recharge = 4, range = 99 }
m.corposcontro = { name = "Corposcontro", type = "normale", category = "fisico", power = 85, recharge = 8, range = 99 }
m.riduttore = { name = "Riduttore", type = "normale", category = "fisico", power = 90, recharge = 8, range = 5 }
m.sdoppiatore = { name = "Sdoppiatore", type = "normale", category = "fisico", power = 120, recharge = 10, range = 5 }
m.colpocoda = { name = "Colpocoda", type = "normale", category = "stato", power = nil, recharge = 7, range = 3 }
m.velenospina = { name = "Velenospina", type = "veleno", category = "fisico", power = 15, recharge = 6, range = 12 }
m.missilspillo = { name = "Missilspillo", type = "coleottero", category = "fisico", power = 25, recharge = 6, range = 12 }
m.fulmisguardo = { name = "Fulmisguardo", type = "normale", category = "stato", power = nil, recharge = 6, range = 4 }
m.morso = { name = "Morso", type = "buio", category = "fisico", power = 60, recharge = 6, range = 99 }
m.ruggito = { name = "Ruggito", type = "normale", category = "stato", power = nil, recharge = 6, range = 2 }
m.boato = { name = "Boato", type = "normale", category = "stato", power = nil, recharge = 6, range = 4 }
m.canto = { name = "Canto", type = "normale", category = "stato", power = nil, recharge = 6, range = 1 }
m.supersuono = { name = "Supersuono", type = "normale", category = "stato", power = nil, recharge = 6, range = 2 }
m.braciere = { name = "Braciere", type = "fuoco", category = "speciale", power = 40, recharge = 6, range = 12 }
m.lanciafiamme = { name = "Lanciafiamme", type = "fuoco", category = "speciale", power = 90, recharge = 8, range = 4 }
m.nebbia = { name = "Nebbia", type = "ghiaccio", category = "stato", power = nil, recharge = 10, range = 99 }
m.pistolacqua = { name = "Pistolacqua", type = "acqua", category = "speciale", power = 40, recharge = 6, range = 12 }
m.idropompa = { name = "Idropompa", type = "acqua", category = "speciale", power = 110, recharge = 12, range = 19 }
m.surf = { name = "Surf", type = "acqua", category = "speciale", power = 90, recharge = 8, range = 5 }
m.geloraggio = { name = "Geloraggio", type = "ghiaccio", category = "speciale", power = 90, recharge = 8, range = 19 }
m.bora = { name = "Bora", type = "ghiaccio", category = "speciale", power = 110, recharge = 12, range = 99 }
m.psicoraggio = { name = "Psicoraggio", type = "psico", category = "speciale", power = 65, recharge = 6, range = 19 }
m.bollaraggio = { name = "Bollaraggio", type = "acqua", category = "speciale", power = 65, recharge = 6, range = 5 }
m["iper raggio"] = { name = "Iper Raggio", type = "normale", category = "speciale", power = 150, recharge = 20, range = 19 }
m.beccata = { name = "Beccata", type = "volante", category = "fisico", power = 35, recharge = 6, range = 99 }
m.assorbimento = { name = "Assorbimento", type = "erba", category = "speciale", power = 20, recharge = 7, range = 99 }
m.parassiseme = { name = "Parassiseme", type = "erba", category = "stato", power = nil, recharge = 12, range = 15 }
m.crescita = { name = "Crescita", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.foglielama = { name = "Foglielama", type = "erba", category = "fisico", power = 55, recharge = 6, range = 2 }
m.solarraggio = { name = "Solarraggio", type = "erba", category = "speciale", power = 120, recharge = 12, range = 19 }
m.velenpolvere = { name = "Velenpolvere", type = "veleno", category = "stato", power = nil, recharge = 10, range = 1 }
m.paralizzante = { name = "Paralizzante", type = "erba", category = "stato", power = nil, recharge = 10, range = 1 }
m.sonnifero = { name = "Sonnifero", type = "erba", category = "stato", power = nil, recharge = 10, range = 1 }
m.petalodanza = { name = "Petalodanza", type = "erba", category = "speciale", power = 120, recharge = 10, range = 99 }
m.millebave = { name = "Millebave", type = "coleottero", category = "stato", power = nil, recharge = 9, range = 8 }
m.turbofuoco = { name = "Turbofuoco", type = "fuoco", category = "speciale", power = 35, recharge = 7, range = 99 }
m.tuonoshock = { name = "Tuonoshock", type = "elettro", category = "speciale", power = 40, recharge = 6, range = 99 }
m.fulmine = { name = "Fulmine", type = "elettro", category = "speciale", power = 90, recharge = 8, range = 99 }
m.tuononda = { name = "Tuononda", type = "elettro", category = "stato", power = nil, recharge = 10, range = 2 }
m.tuono = { name = "Tuono", type = "elettro", category = "speciale", power = 110, recharge = 10, range = 99 }
m.sassata = { name = "Sassata", type = "roccia", category = "fisico", power = 50, recharge = 6, range = 99 }
m.terremoto = { name = "Terremoto", type = "terra", category = "fisico", power = 100, recharge = 10, range = 99 }
m.abisso = { name = "Abisso", type = "terra", category = "fisico", power = nil, recharge = 20, range = 7 }
m.fossa = { name = "Fossa", type = "terra", category = "fisico", power = 80, recharge = 12, range = 7 }
m.tossina = { name = "Tossina", type = "veleno", category = "stato", power = nil, recharge = 10, range = 2 }
m.confusione = { name = "Confusione", type = "psico", category = "speciale", power = 50, recharge = 6, range = 99 }
m.psichico = { name = "Psichico", type = "psico", category = "speciale", power = 90, recharge = 8, range = 99 }
m.ipnosi = { name = "Ipnosi", type = "psico", category = "stato", power = nil, recharge = 10, range = 2 }
m["agilità"] = { name = "Agilità", type = "psico", category = "stato", power = nil, recharge = 12, range = 99 }
m["attacco rapido"] = { name = "Attacco Rapido", type = "normale", category = "fisico", power = 40, recharge = 3, range = 6 }
m.teletrasporto = { name = "Teletrasporto", type = "psico", category = "stato", power = nil, recharge = 7, range = 99 }
m.mimica = { name = "Mimica", type = "normale", category = "stato", power = nil, recharge = 6, range = 99 }
m.stridio = { name = "Stridio", type = "normale", category = "stato", power = nil, recharge = 10, range = 4 }
m.doppioteam = { name = "Doppioteam", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.ripresa = { name = "Ripresa", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.rafforzatore = { name = "Rafforzatore", type = "normale", category = "stato", power = nil, recharge = 6, range = 99 }
m["muro di fumo"] = { name = "Muro di Fumo", type = "normale", category = "stato", power = nil, recharge = 10, range = 99 }
m.stordiraggio = { name = "Stordiraggio", type = "spettro", category = "stato", power = nil, recharge = 6, range = 9 }
m.schermoluce = { name = "Schermoluce", type = "psico", category = "stato", power = nil, recharge = 12, range = 99 }
m.nube = { name = "Nube", type = "ghiaccio", category = "stato", power = nil, recharge = 15, range = 99 }
m.riflesso = { name = "Riflesso", type = "psico", category = "stato", power = nil, recharge = 12, range = 99 }
m.focalenergia = { name = "Focalenergia", type = "normale", category = "stato", power = nil, recharge = 10, range = 99 }
m.metronomo = { name = "Metronomo", type = "normale", category = "stato", power = nil, recharge = 4, range = 99 }
m.autodistruzione = { name = "Autodistruzione", type = "normale", category = "fisico", power = 200, recharge = 15, range = 1 }
m.leccata = { name = "Leccata", type = "spettro", category = "fisico", power = 30, recharge = 6, range = 99 }
m.fuocobomba = { name = "Fuocobomba", type = "fuoco", category = "speciale", power = 110, recharge = 10, range = 7 }
m.cascata = { name = "Cascata", type = "acqua", category = "fisico", power = 80, recharge = 8, range = 5 }
m.comete = { name = "Comete", type = "normale", category = "speciale", power = 60, recharge = 5, range = 14 }
m.capocciata = { name = "Capocciata", type = "normale", category = "fisico", power = 130, recharge = 12, range = 5 }
m.amnesia = { name = "Amnesia", type = "psico", category = "stato", power = nil, recharge = 9, range = 99 }
m["sguardo feroce"] = { name = "Sguardo Feroce", type = "normale", category = "stato", power = nil, recharge = 8, range = 2 }
m.mangiasogni = { name = "Mangiasogni", type = "psico", category = "speciale", power = 100, recharge = 7, range = 5 }
m.sanguisuga = { name = "Sanguisuga", type = "coleottero", category = "fisico", power = 80, recharge = 9, range = 99 }
m.aeroattacco = { name = "Aeroattacco", type = "volante", category = "fisico", power = 140, recharge = 10, range = 5 }
m.spora = { name = "Spora", type = "erba", category = "stato", power = nil, recharge = 10, range = 99 }
m.splash = { name = "Splash", type = "normale", category = "stato", power = nil, recharge = 4, range = 99 }
m["scudo acido"] = { name = "Scudo Acido", type = "veleno", category = "stato", power = nil, recharge = 9, range = 99 }
m.esplosione = { name = "Esplosione", type = "normale", category = "fisico", power = 250, recharge = 15, range = 1 }
m.ossomerang = { name = "Ossomerang", type = "terra", category = "fisico", power = 50, recharge = 7, range = 17 }
m.frana = { name = "Frana", type = "roccia", category = "fisico", power = 75, recharge = 7, range = 99 }
m.conversione = { name = "Conversione", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.tripletta = { name = "Tripletta", type = "normale", category = "speciale", power = 80, recharge = 7, range = 12 }
m.superzanna = { name = "Superzanna", type = "normale", category = "fisico", power = nil, recharge = 9, range = 99 }
m.lacerazione = { name = "Lacerazione", type = "normale", category = "fisico", power = 70, recharge = 7, range = 99 }
m.sostituto = { name = "Sostituto", type = "normale", category = "stato", power = nil, recharge = 10, range = 99 }
m.ruotafuoco = { name = "Ruotafuoco", type = "fuoco", category = "fisico", power = 60, recharge = 6, range = 5 }
m.maledizione = { name = "Maledizione", type = "spettro", category = "stato", power = nil, recharge = 15, range = 99 }
m.conversione2 = { name = "Conversione2", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.protezione = { name = "Protezione", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.pugnorapido = { name = "Pugnorapido", type = "lotta", category = "fisico", power = 40, recharge = 3, range = 6 }
m.fangobomba = { name = "Fangobomba", type = "veleno", category = "speciale", power = 90, recharge = 7, range = 25 }
m.punte = { name = "Punte", type = "terra", category = "stato", power = nil, recharge = 7, range = 99 }
m.elettrocannone = { name = "Elettrocannone", type = "elettro", category = "speciale", power = 120, recharge = 15, range = 12 }
m.ultimocanto = { name = "Ultimocanto", type = "normale", category = "stato", power = nil, recharge = 20, range = 1 }
m.ventogelato = { name = "Ventogelato", type = "ghiaccio", category = "speciale", power = 55, recharge = 7, range = 99 }
m.individua = { name = "Individua", type = "lotta", category = "stato", power = nil, recharge = 13, range = 99 }
m.oltraggio = { name = "Oltraggio", type = "drago", category = "fisico", power = 120, recharge = 15, range = 99 }
m.gigassorbimento = { name = "Gigassorbimento", type = "erba", category = "speciale", power = 75, recharge = 9, range = 99 }
m.resistenza = { name = "Resistenza", type = "normale", category = "stato", power = nil, recharge = 12, range = 99 }
m.fascino = { name = "Fascino", type = "folletto", category = "stato", power = nil, recharge = 10, range = 3 }
m.rotolamento = { name = "Rotolamento", type = "roccia", category = "fisico", power = 30, recharge = 6, range = 5 }
m.falsofinale = { name = "Falsofinale", type = "normale", category = "fisico", power = 40, recharge = 6, range = 99 }
m.bullo = { name = "Bullo", type = "normale", category = "stato", power = nil, recharge = 10, range = 99 }
m.scintilla = { name = "Scintilla", type = "elettro", category = "fisico", power = 65, recharge = 6, range = 5 }
m.alacciaio = { name = "Alacciaio", type = "acciaio", category = "fisico", power = 70, recharge = 7, range = 99 }
m.salvaguardia = { name = "Salvaguardia", type = "normale", category = "stato", power = nil, recharge = 12, range = 99 }
m.dinamipugno = { name = "Dinamipugno", type = "lotta", category = "fisico", power = 100, recharge = 12, range = 99 }
m.megacorno = { name = "Megacorno", type = "coleottero", category = "fisico", power = 120, recharge = 10, range = 5 }
m.dragospiro = { name = "Dragospiro", type = "drago", category = "speciale", power = 60, recharge = 6, range = 4 }
m.codacciaio = { name = "Codacciaio", type = "acciaio", category = "fisico", power = 100, recharge = 10, range = 99 }
m.ferrartigli = { name = "Ferrartigli", type = "acciaio", category = "fisico", power = 50, recharge = 6, range = 99 }
m.mattindoro = { name = "Mattindoro", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.sintesi = { name = "Sintesi", type = "erba", category = "stato", power = nil, recharge = 15, range = 99 }
m.lucelunare = { name = "Lucelunare", type = "folletto", category = "stato", power = nil, recharge = 15, range = 99 }
m.tornado = { name = "Tornado", type = "drago", category = "speciale", power = 40, recharge = 6, range = 99 }
m.sgranocchio = { name = "Sgranocchio", type = "buio", category = "fisico", power = 80, recharge = 8, range = 99 }
m.extrarapido = { name = "Extrarapido", type = "normale", category = "fisico", power = 80, recharge = 3, range = 7 }
m.forzantica = { name = "Forzantica", type = "roccia", category = "speciale", power = 60, recharge = 6, range = 99 }
m["palla ombra"] = { name = "Palla Ombra", type = "spettro", category = "speciale", power = 80, recharge = 8, range = 12 }
m.divinazione = { name = "Divinazione", type = "psico", category = "speciale", power = 120, recharge = 10, range = 99 }
m.spaccaroccia = { name = "Spaccaroccia", type = "lotta", category = "fisico", power = 40, recharge = 6, range = 99 }
m.mulinello = { name = "Mulinello", type = "acqua", category = "speciale", power = 35, recharge = 7, range = 99 }
m.bruciapelo = { name = "Bruciapelo", type = "normale", category = "fisico", power = 40, recharge = 3, range = 99 }
m.ondacalda = { name = "Ondacalda", type = "fuoco", category = "speciale", power = 95, recharge = 9, range = 99 }
m.attaccalite = { name = "Attaccalite", type = "buio", category = "stato", power = nil, recharge = 12, range = 99 }
m.fuocofatuo = { name = "Fuocofatuo", type = "fuoco", category = "stato", power = nil, recharge = 10, range = 5 }
m.facciata = { name = "Facciata", type = "normale", category = "fisico", power = 70, recharge = 7, range = 99 }
m.sottocarica = { name = "Sottocarica", type = "elettro", category = "stato", power = nil, recharge = 10, range = 99 }
m.provocazione = { name = "Provocazione", type = "buio", category = "stato", power = nil, recharge = 12, range = 2 }
m.desiderio = { name = "Desiderio", type = "normale", category = "stato", power = nil, recharge = 12, range = 99 }
m.breccia = { name = "Breccia", type = "lotta", category = "fisico", power = 75, recharge = 7, range = 99 }
m.privazione = { name = "Privazione", type = "buio", category = "fisico", power = 65, recharge = 10, range = 99 }
m.abbagliante = { name = "Abbagliante", type = "psico", category = "speciale", power = 70, recharge = 8, range = 7 }
m.foschisfera = { name = "Foschisfera", type = "psico", category = "speciale", power = 70, recharge = 8, range = 14 }
m.danzadipiume = { name = "Danzadipiume", type = "volante", category = "stato", power = nil, recharge = 10, range = 1 }
m.calciardente = { name = "Calciardente", type = "fuoco", category = "fisico", power = 85, recharge = 7, range = 99 }
m.granvoce = { name = "Granvoce", type = "normale", category = "speciale", power = 90, recharge = 8, range = 2 }
m.velenodenti = { name = "Velenodenti", type = "veleno", category = "fisico", power = 50, recharge = 6, range = 99 }
m.incendio = { name = "Incendio", type = "fuoco", category = "speciale", power = 150, recharge = 20, range = 99 }
m.idrocannone = { name = "Idrocannone", type = "acqua", category = "speciale", power = 150, recharge = 20, range = 12 }
m.falselacrime = { name = "Falselacrime", type = "buio", category = "stato", power = nil, recharge = 10, range = 2 }
m.vampata = { name = "Vampata", type = "fuoco", category = "speciale", power = 130, recharge = 10, range = 99 }
m.rocciotomba = { name = "Rocciotomba", type = "roccia", category = "fisico", power = 60, recharge = 10, range = 7 }
m.ventargenteo = { name = "Ventargenteo", type = "coleottero", category = "speciale", power = 60, recharge = 6, range = 99 }
m.ferrostrido = { name = "Ferrostrido", type = "acciaio", category = "stato", power = nil, recharge = 10, range = 4 }
m.pugnodombra = { name = "Pugnodombra", type = "spettro", category = "fisico", power = 60, recharge = 6, range = 99 }
m.sabbiotomba = { name = "Sabbiotomba", type = "terra", category = "fisico", power = 35, recharge = 7, range = 99 }
m.purogelo = { name = "Purogelo", type = "ghiaccio", category = "speciale", power = nil, recharge = 20, range = 1 }
m.fanghiglia = { name = "Fanghiglia", type = "acqua", category = "speciale", power = 90, recharge = 8, range = 5 }
m.semitraglia = { name = "Semitraglia", type = "erba", category = "fisico", power = 25, recharge = 6, range = 12 }
m.aeroassalto = { name = "Aeroassalto", type = "volante", category = "fisico", power = 60, recharge = 9, range = 99 }
m.gelolancia = { name = "Gelolancia", type = "ghiaccio", category = "fisico", power = 25, recharge = 6, range = 12 }
m.ferroscudo = { name = "Ferroscudo", type = "acciaio", category = "stato", power = nil, recharge = 9, range = 99 }
m.dragartigli = { name = "Dragartigli", type = "drago", category = "fisico", power = 80, recharge = 8, range = 99 }
m.radicalbero = { name = "Radicalbero", type = "erba", category = "speciale", power = 150, recharge = 20, range = 99 }
m.granfisico = { name = "Granfisico", type = "lotta", category = "stato", power = nil, recharge = 18, range = 99 }
m.rimbalzo = { name = "Rimbalzo", type = "volante", category = "fisico", power = 85, recharge = 12, range = 5 }
m.colpodifango = { name = "Colpodifango", type = "terra", category = "speciale", power = 55, recharge = 6, range = 15 }
m.locomovolt = { name = "Locomovolt", type = "elettro", category = "fisico", power = 120, recharge = 9, range = 5 }
m.fogliamagica = { name = "Fogliamagica", type = "erba", category = "speciale", power = 60, recharge = 6, range = 14 }
m.calmamente = { name = "Calmamente", type = "psico", category = "stato", power = nil, recharge = 18, range = 99 }
m.fendifoglia = { name = "Fendifoglia", type = "erba", category = "fisico", power = 90, recharge = 8, range = 99 }
m.cadutamassi = { name = "Cadutamassi", type = "roccia", category = "fisico", power = 25, recharge = 6, range = 12 }
m.idropulsar = { name = "Idropulsar", type = "acqua", category = "speciale", power = 60, recharge = 6, range = 6 }
m.retromarcia = { name = "Retromarcia", type = "coleottero", category = "fisico", power = 70, recharge = 12, range = 99 }
m.zuffa = { name = "Zuffa", type = "lotta", category = "fisico", power = 120, recharge = 12, range = 1 }
m.anticura = { name = "Anticura", type = "psico", category = "stato", power = nil, recharge = 12, range = 3 }
m.fielepunte = { name = "Fielepunte", type = "veleno", category = "stato", power = nil, recharge = 7, range = 99 }
m.acquanello = { name = "Acquanello", type = "acqua", category = "stato", power = nil, recharge = 10, range = 99 }
m.fuococarica = { name = "Fuococarica", type = "fuoco", category = "fisico", power = 120, recharge = 8, range = 5 }
m.sferapulsar = { name = "Sferapulsar", type = "lotta", category = "speciale", power = 80, recharge = 8, range = 14 }
m.velenpuntura = { name = "Velenpuntura", type = "veleno", category = "fisico", power = 80, recharge = 8, range = 99 }
m.neropulsar = { name = "Neropulsar", type = "buio", category = "speciale", power = 80, recharge = 8, range = 12 }
m.nottesferza = { name = "Nottesferza", type = "buio", category = "fisico", power = 70, recharge = 7, range = 99 }
m.semebomba = { name = "Semebomba", type = "erba", category = "fisico", power = 80, recharge = 7, range = 3 }
m.eterelama = { name = "Eterelama", type = "volante", category = "speciale", power = 75, recharge = 7, range = 12 }
m["forbice x"] = { name = "Forbice X", type = "coleottero", category = "fisico", power = 80, recharge = 8, range = 99 }
m.ronzio = { name = "Ronzio", type = "coleottero", category = "speciale", power = 90, recharge = 8, range = 6 }
m.dragopulsar = { name = "Dragopulsar", type = "drago", category = "speciale", power = 85, recharge = 8, range = 6 }
m.dragofuria = { name = "Dragofuria", type = "drago", category = "fisico", power = 100, recharge = 12, range = 4 }
m.gemmoforza = { name = "Gemmoforza", type = "roccia", category = "speciale", power = 80, recharge = 8, range = 19 }
m.assorbipugno = { name = "Assorbipugno", type = "lotta", category = "fisico", power = 75, recharge = 7, range = 99 }
m.vuotonda = { name = "Vuotonda", type = "lotta", category = "speciale", power = 40, recharge = 3, range = 99 }
m.focalcolpo = { name = "Focalcolpo", type = "lotta", category = "speciale", power = 120, recharge = 12, range = 12 }
m.energipalla = { name = "Energipalla", type = "erba", category = "speciale", power = 90, recharge = 8, range = 12 }
m.baldeali = { name = "Baldeali", type = "volante", category = "fisico", power = 120, recharge = 10, range = 5 }
m.geoforza = { name = "Geoforza", type = "terra", category = "speciale", power = 90, recharge = 8, range = 99 }
m.gigaimpatto = { name = "Gigaimpatto", type = "normale", category = "fisico", power = 150, recharge = 20, range = 4 }
m.congiura = { name = "Congiura", type = "buio", category = "stato", power = nil, recharge = 15, range = 99 }
m.pugnoscarica = { name = "Pugnoscarica", type = "acciaio", category = "fisico", power = 40, recharge = 3, range = 6 }
m.geloscheggia = { name = "Geloscheggia", type = "ghiaccio", category = "fisico", power = 40, recharge = 3, range = 12 }
m.ombrartigli = { name = "Ombrartigli", type = "spettro", category = "fisico", power = 70, recharge = 7, range = 99 }
m.fulmindenti = { name = "Fulmindenti", type = "elettro", category = "fisico", power = 65, recharge = 6, range = 99 }
m.gelodenti = { name = "Gelodenti", type = "ghiaccio", category = "fisico", power = 65, recharge = 6, range = 99 }
m.rogodenti = { name = "Rogodenti", type = "fuoco", category = "fisico", power = 65, recharge = 6, range = 99 }
m.furtivombra = { name = "Furtivombra", type = "spettro", category = "fisico", power = 40, recharge = 3, range = 6 }
m.psicotaglio = { name = "Psicotaglio", type = "psico", category = "fisico", power = 70, recharge = 7, range = 99 }
m["cozzata zen"] = { name = "Cozzata Zen", type = "psico", category = "fisico", power = 80, recharge = 8, range = 99 }
m.cannonflash = { name = "Cannonflash", type = "acciaio", category = "speciale", power = 80, recharge = 8, range = 12 }
m.dragobolide = { name = "Dragobolide", type = "drago", category = "speciale", power = 130, recharge = 10, range = 99 }
m.scarica = { name = "Scarica", type = "elettro", category = "speciale", power = 80, recharge = 8, range = 99 }
m.lavasbuffo = { name = "Lavasbuffo", type = "fuoco", category = "speciale", power = 80, recharge = 8, range = 99 }
m.verdebufera = { name = "Verdebufera", type = "erba", category = "speciale", power = 130, recharge = 10, range = 6 }
m.vigorcolpo = { name = "Vigorcolpo", type = "erba", category = "fisico", power = 120, recharge = 12, range = 99 }
m.sporcolancio = { name = "Sporcolancio", type = "veleno", category = "fisico", power = 120, recharge = 10, range = 15 }
m.metaltestata = { name = "Metaltestata", type = "acciaio", category = "fisico", power = 80, recharge = 8, range = 99 }
m.bombagnete = { name = "Bombagnete", type = "acciaio", category = "fisico", power = 60, recharge = 8, range = 12 }
m.pietrataglio = { name = "Pietrataglio", type = "roccia", category = "fisico", power = 100, recharge = 10, range = 99 }
m.levitoroccia = { name = "Levitoroccia", type = "roccia", category = "stato", power = nil, recharge = 10, range = 99 }
m.raggioscossa = { name = "Raggioscossa", type = "elettro", category = "speciale", power = 50, recharge = 6, range = 19 }
m.mazzuolegno = { name = "Mazzuolegno", type = "erba", category = "fisico", power = 120, recharge = 10, range = 99 }
m.acquagetto = { name = "Acquagetto", type = "acqua", category = "fisico", power = 40, recharge = 3, range = 6 }
m.zuccata = { name = "Zuccata", type = "roccia", category = "fisico", power = 150, recharge = 10, range = 5 }
m.doppiosmash = { name = "Doppiosmash", type = "normale", category = "fisico", power = 35, recharge = 6, range = 99 }
m.magmaclisma = { name = "Magmaclisma", type = "fuoco", category = "speciale", power = 100, recharge = 12, range = 99 }
m.vuototetro = { name = "Vuototetro", type = "buio", category = "stato", power = nil, recharge = 12, range = 12 }
m.funestovento = { name = "Funestovento", type = "spettro", category = "speciale", power = 60, recharge = 6, range = 99 }
m.psicoshock = { name = "Psicoshock", type = "psico", category = "speciale", power = 80, recharge = 8, range = 99 }
m.tempestretta = { name = "Tempestretta", type = "lotta", category = "fisico", power = 65, recharge = 7, range = 99 }
m.fangonda = { name = "Fangonda", type = "veleno", category = "speciale", power = 95, recharge = 8, range = 99 }
m.pesobomba = { name = "Pesobomba", type = "acciaio", category = "fisico", power = nil, recharge = 10, range = 2 }
m.nitrocarica = { name = "Nitrocarica", type = "fuoco", category = "fisico", power = 50, recharge = 6, range = 5 }
m.calciobasso = { name = "Calciobasso", type = "lotta", category = "fisico", power = 65, recharge = 6, range = 99 }
m.acidobomba = { name = "Acidobomba", type = "veleno", category = "speciale", power = 40, recharge = 7, range = 25 }
m.idrovampata = { name = "Idrovampata", type = "acqua", category = "speciale", power = 80, recharge = 7, range = 19 }
m.ribaltiro = { name = "Ribaltiro", type = "lotta", category = "fisico", power = 60, recharge = 6, range = 99 }
m.invertivolt = { name = "Invertivolt", type = "elettro", category = "speciale", power = 70, recharge = 12, range = 99 }
m.battiterra = { name = "Battiterra", type = "terra", category = "fisico", power = 60, recharge = 6, range = 99 }
m.alitogelido = { name = "Alitogelido", type = "ghiaccio", category = "speciale", power = 65, recharge = 7, range = 12 }
m.cuordileone = { name = "Cuordileone", type = "normale", category = "stato", power = nil, recharge = 15, range = 99 }
m.elettrotela = { name = "Elettrotela", type = "elettro", category = "speciale", power = 55, recharge = 7, range = 2 }
m.sprizzalampo = { name = "Sprizzalampo", type = "elettro", category = "fisico", power = 90, recharge = 8, range = 5 }
m.giravvita = { name = "Giravvita", type = "terra", category = "fisico", power = 80, recharge = 8, range = 5 }
m.doppiocolpo = { name = "Doppiocolpo", type = "drago", category = "fisico", power = 40, recharge = 6, range = 99 }
m.legnicorno = { name = "Legnicorno", type = "erba", category = "fisico", power = 75, recharge = 9, range = 99 }
m.spadasolenne = { name = "Spadasolenne", type = "lotta", category = "fisico", power = 90, recharge = 8, range = 99 }
m.spadasolenne = { name = "Spadasolenne", type = "lotta", category = "fisico", power = 90, recharge = 8, range = 99 }
m.marchiafuoco = { name = "Marchiafuoco", type = "fuoco", category = "fisico", power = nil, recharge = 10, range = 2 }
m.cotonscudo = { name = "Cotonscudo", type = "erba", category = "stato", power = nil, recharge = 10, range = 99 }
m.psicobotta = { name = "Psicobotta", type = "psico", category = "speciale", power = 100, recharge = 9, range = 12 }
m.tifone = { name = "Tifone", type = "volante", category = "speciale", power = 110, recharge = 10, range = 99 }
m.tecnobotto = { name = "Tecnobotto", type = "normale", category = "speciale", power = 120, recharge = 12, range = 12 }
m.cantoantico = { name = "Cantoantico", type = "normale", category = "speciale", power = 75, recharge = 30, range = 7 }
m.spadamistica = { name = "Spadamistica", type = "lotta", category = "speciale", power = 85, recharge = 8, range = 99 }
m.urlorabbia = { name = "Urlorabbia", type = "buio", category = "speciale", power = 55, recharge = 9, range = 99 }
m.scagliagelo = { name = "Scagliagelo", type = "ghiaccio", category = "fisico", power = 85, recharge = 8, range = 99 }
m.schiacciatuffo = { name = "Schiacciatuffo", type = "lotta", category = "fisico", power = 100, recharge = 9, range = 5 }
m["rete vischiosa"] = { name = "Rete Vischiosa", type = "coleottero", category = "stato", power = nil, recharge = 7, range = 3 }
m.spettrotuffo = { name = "Spettrotuffo", type = "spettro", category = "fisico", power = 90, recharge = 12, range = 7 }
m.halloween = { name = "Halloween", type = "spettro", category = "stato", power = nil, recharge = 10, range = 3 }
m.caricaparabola = { name = "Caricaparabola", type = "elettro", category = "speciale", power = 65, recharge = 9, range = 99 }
m.boscomalocchio = { name = "Boscomalocchio", type = "erba", category = "stato", power = nil, recharge = 10, range = 3 }
m.liofilizzazione = { name = "Liofilizzazione", type = "ghiaccio", category = "speciale", power = 70, recharge = 9, range = 99 }
m.incantavoce = { name = "Incantavoce", type = "folletto", category = "speciale", power = 40, recharge = 6, range = 6 }
m.monito = { name = "Monito", type = "buio", category = "stato", power = nil, recharge = 12, range = 2 }
m.sottosopra = { name = "Sottosopra", type = "buio", category = "stato", power = nil, recharge = 10, range = 2 }
m.assorbibacio = { name = "Assorbibacio", type = "folletto", category = "speciale", power = 50, recharge = 7, range = 99 }
m.carineria = { name = "Carineria", type = "folletto", category = "fisico", power = 90, recharge = 8, range = 3 }
m["vento di fata"] = { name = "Vento di Fata", type = "folletto", category = "speciale", power = 40, recharge = 6, range = 99 }
m["forza lunare"] = { name = "Forza Lunare", type = "folletto", category = "speciale", power = 95, recharge = 8, range = 12 }
m.ondaboato = { name = "Ondaboato", type = "normale", category = "speciale", power = 140, recharge = 12, range = 99 }
m["scudo reale"] = { name = "Scudo Reale", type = "acciaio", category = "stato", power = nil, recharge = 15, range = 99 }
m.diamantempesta = { name = "Diamantempesta", type = "roccia", category = "fisico", power = 100, recharge = 10, range = 6 }
m.vaporscoppio = { name = "Vaporscoppio", type = "acqua", category = "speciale", power = 110, recharge = 10, range = 19 }
m.forodimensionale = { name = "Forodimensionale", type = "psico", category = "speciale", power = 80, recharge = 8, range = 7 }
m.acqualame = { name = "Acqualame", type = "acqua", category = "speciale", power = 15, recharge = 3, range = 12 }
m.magifiamma = { name = "Magifiamma", type = "fuoco", category = "speciale", power = 75, recharge = 8, range = 4 }
m.agodifesa = { name = "Agodifesa", type = "erba", category = "stato", power = nil, recharge = 15, range = 99 }
m.elettromistero = { name = "Elettromistero", type = "elettro", category = "stato", power = nil, recharge = 10, range = 3 }
m.geocontrollo = { name = "Geocontrollo", type = "folletto", category = "stato", power = nil, recharge = 30, range = 99 }
m.magibrillio = { name = "Magibrillio", type = "folletto", category = "speciale", power = 80, recharge = 8, range = 99 }
m.elettrococcola = { name = "Elettrococcola", type = "elettro", category = "fisico", power = 20, recharge = 6, range = 99 }
m.assillo = { name = "Assillo", type = "coleottero", category = "speciale", power = 20, recharge = 6, range = 99 }
m.crescipugno = { name = "Crescipugno", type = "lotta", category = "fisico", power = 40, recharge = 10, range = 99 }
m["ali del fato"] = { name = "Ali del Fato", type = "volante", category = "speciale", power = 80, recharge = 12, range = 19 }
m["mille frecce"] = { name = "Mille Frecce", type = "terra", category = "fisico", power = 90, recharge = 10, range = 99 }
m["mille onde"] = { name = "Mille Onde", type = "terra", category = "fisico", power = 90, recharge = 10, range = 99 }
m["forza tellurica"] = { name = "Forza Tellurica", type = "terra", category = "fisico", power = 90, recharge = 8, range = 99 }
m["luce nefasta"] = { name = "Luce Nefasta", type = "folletto", category = "speciale", power = 140, recharge = 15, range = 19 }
m.primopulsar = { name = "Primopulsar", type = "acqua", category = "speciale", power = 110, recharge = 16, range = 19 }
m["spade telluriche"] = { name = "Spade Telluriche", type = "terra", category = "fisico", power = 120, recharge = 16, range = 99 }
m["ascesa del drago"] = { name = "Ascesa del Drago", type = "volante", category = "fisico", power = 120, recharge = 20, range = 7 }
m.urtodimensionale = { name = "Urtodimensionale", type = "buio", category = "fisico", power = 100, recharge = 10, range = 99 }
m.sabbiaccumulo = { name = "Sabbiaccumulo", type = "terra", category = "stato", power = nil, recharge = 15, range = 99 }
m.schermaglia = { name = "Schermaglia", type = "coleottero", category = "fisico", power = 90, recharge = 6, range = 99 }
m.martelgelo = { name = "Martelgelo", type = "ghiaccio", category = "fisico", power = 100, recharge = 10, range = 99 }
m["lama solare"] = { name = "Lama Solare", type = "erba", category = "fisico", power = 125, recharge = 12, range = 5 }
m.fogliame = { name = "Fogliame", type = "erba", category = "fisico", power = 40, recharge = 6, range = 12 }
m.assalto = { name = "Assalto", type = "coleottero", category = "fisico", power = 80, recharge = 9, range = 3 }
m.nucleocastigo = { name = "Nucleocastigo", type = "drago", category = "speciale", power = 100, recharge = 15, range = 19 }
m.vorticolpo = { name = "Vorticolpo", type = "buio", category = "fisico", power = 60, recharge = 6, range = 99 }
m.cannonfiore = { name = "Cannonfiore", type = "folletto", category = "speciale", power = 130, recharge = 10, range = 19 }
m.psicozanna = { name = "Psicozanna", type = "psico", category = "fisico", power = 85, recharge = 8, range = 99 }
m.ossotetro = { name = "Ossotetro", type = "spettro", category = "fisico", power = 85, recharge = 7, range = 99 }
m.idrobreccia = { name = "Idrobreccia", type = "acqua", category = "fisico", power = 85, recharge = 8, range = 99 }
m.ombrafurto = { name = "Ombrafurto", type = "spettro", category = "fisico", power = 90, recharge = 15, range = 7 }
m["pugni plasma"] = { name = "Pugni Plasma", type = "elettro", category = "fisico", power = 100, recharge = 10, range = 99 }
m["pugni corazzati"] = { name = "Pugni Corazzati", type = "acciaio", category = "fisico", power = 60, recharge = 10, range = 99 }
m["spalle al muro"] = { name = "Spalle al Muro", type = "lotta", category = "stato", power = nil, recharge = 60, range = 99 }
m.tentacolock = { name = "Tentacolock", type = "lotta", category = "stato", power = nil, recharge = 12, range = 99 }
m["ruota d'aura"] = { name = "Ruota d'Aura", type = "elettro", category = "fisico", power = 110, recharge = 15, range = 5 }
m.vastoimpatto = { name = "Vastoimpatto", type = "drago", category = "fisico", power = 60, recharge = 9, range = 99 }
m.overdrive = { name = "Overdrive", type = "elettro", category = "speciale", power = 80, recharge = 8, range = 5 }
m.sfolgorassalto = { name = "Sfolgorassalto", type = "lotta", category = "fisico", power = 150, recharge = 20, range = 5 }
m["raggio d'acciaio"] = { name = "Raggio d'Acciaio", type = "acciaio", category = "speciale", power = 140, recharge = 20, range = 12 }
m.squamacolpo = { name = "Squamacolpo", type = "drago", category = "fisico", power = 25, recharge = 6, range = 12 }
m.raggiometeora = { name = "Raggiometeora", type = "roccia", category = "speciale", power = 120, recharge = 12, range = 19 }
m.virata = { name = "Virata", type = "acqua", category = "fisico", power = 60, recharge = 12, range = 99 }
m["triplo axel"] = { name = "Triplo Axel", type = "ghiaccio", category = "fisico", power = 20, recharge = 10, range = 99 }
m["doppia ala"] = { name = "Doppia Ala", type = "volante", category = "fisico", power = 40, recharge = 6, range = 99 }
m.sabbiardente = { name = "Sabbiardente", type = "terra", category = "speciale", power = 70, recharge = 7, range = 7 }
m.rocciascure = { name = "Rocciascure", type = "roccia", category = "fisico", power = 65, recharge = 10, range = 99 }
m["mille fielespine"] = { name = "Mille Fielespine", type = "veleno", category = "fisico", power = 60, recharge = 8, range = 7 }
m["omaggio ai ko"] = { name = "Omaggio ai KO", type = "spettro", category = "fisico", power = 50, recharge = 8, range = 99 }
m["alta cucina"] = { name = "Alta Cucina", type = "drago", category = "fisico", power = 80, recharge = 8, range = 99 }
m["essenza piccante"] = { name = "Essenza Piccante", type = "erba", category = "stato", power = nil, recharge = 12, range = 14 }
m.spadoncarica = { name = "Spadoncarica", type = "drago", category = "fisico", power = 120, recharge = 12, range = 5 }
m["sotto sale"] = { name = "Sotto Sale", type = "roccia", category = "fisico", power = 40, recharge = 8, range = 99 }
m.glitturbine = { name = "Glitturbine", type = "veleno", category = "fisico", power = 30, recharge = 6, range = 99 }
m["corsa all'oro"] = { name = "Corsa all'Oro", type = "acciaio", category = "speciale", power = 120, recharge = 10, range = 7 }
m.tagliacoda = { name = "Tagliacoda", type = "normale", category = "stato", power = nil, recharge = 12, range = 99 }
m.apripista = { name = "Apripista", type = "erba", category = "fisico", power = 50, recharge = 6, range = 5 }
m["doccia fredda"] = { name = "Doccia Fredda", type = "acqua", category = "speciale", power = 50, recharge = 7, range = 25 }
m["pugno furibondo"] = { name = "Pugno Furibondo", type = "spettro", category = "fisico", power = 50, recharge = 8, range = 99 }
m["corazza cannone"] = { name = "Corazza Cannone", type = "fuoco", category = "speciale", power = 120, recharge = 12, range = 12 }
m["lama del rimorso"] = { name = "Lama del Rimorso", type = "fuoco", category = "fisico", power = 90, recharge = 9, range = 99 }
m.granmartello = { name = "Granmartello", type = "acciaio", category = "fisico", power = 160, recharge = 30, range = 99 }
m["tabula laser"] = { name = "Tabula Laser", type = "drago", category = "speciale", power = 100, recharge = 15, range = 19 }
-- stylua: ignore end

return m
