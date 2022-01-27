-- Data module for moves in LPA

-- TODO: this entire module is copied from move-data, and should be updated.
-- Right now, only types are used.

local t = {}

t.botta = {name = 'Botta', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 35, gen = 1}
t.colpokarate = {name = 'Colpokarate', type = {[1] = 'normale', [2] = 'lotta'}, category = 'fisico', power = 50, accuracy = 100, pp = 25, gen = 1}
t.doppiasberla = {name = 'Doppiasberla', type = 'normale', category = 'fisico', power = 15, accuracy = 85, pp = 10, gen = 1}
t.cometapugno = {name = 'Cometapugno', type = 'normale', category = 'fisico', power = 18, accuracy = 85, pp = 15, gen = 1}
t.megapugno = {name = 'Megapugno', type = 'normale', category = 'fisico', power = 80, accuracy = 85, pp = 20, gen = 1}
t.giornopaga = {name = 'Giornopaga', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 20, gen = 1}
t.fuocopugno = {name = 'Fuocopugno', type = 'fuoco', category = 'fisico', power = 75, accuracy = 100, pp = 15, gen = 1}
t.gelopugno = {name = 'Gelopugno', type = 'ghiaccio', category = 'fisico', power = 75, accuracy = 100, pp = 15, gen = 1}
t.tuonopugno = {name = 'Tuonopugno', type = 'elettro', category = 'fisico', power = 75, accuracy = 100, pp = 15, gen = 1}
t.graffio = {name = 'Graffio', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 35, gen = 1}
t.presa = {name = 'Presa', type = 'normale', category = 'fisico', power = 55, accuracy = 100, pp = 30, gen = 1}
t.ghigliottina = {name = 'Ghigliottina', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 1}
t.ventagliente = {name = 'Ventagliente', type = 'normale', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 1}
t.danzaspada = {name = 'Danzaspada', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.taglio = {name = 'Taglio', type = 'normale', category = 'fisico', power = 50, accuracy = 95, pp = 30, gen = 1}
t.raffica = {name = 'Raffica', type = {[1] = 'normale', [2] = 'volante'}, category = 'speciale', power = 40, accuracy = 100, pp = 35, gen = 1}
t["attacco d'ala"] = {name = "Attacco d'Ala", type = 'volante', category = 'fisico', power = 60, accuracy = 100, pp = 35, gen = 1}
t.turbine = {name = 'Turbine', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.volo = {name = 'Volo', type = 'volante', category = 'fisico', power = 90, accuracy = 95, pp = 15, gen = 1}
t.legatutto = {name = 'Legatutto', type = 'normale', category = 'fisico', power = 15, accuracy = 85, pp = 20, gen = 1}
t.schianto = {name = 'Schianto', type = 'normale', category = 'fisico', power = 80, accuracy = 75, pp = 20, gen = 1}
t.frustata = {name = 'Frustata', type = 'erba', category = 'fisico', power = 45, accuracy = 100, pp = 25, gen = 1}
t.pestone = {name = 'Pestone', type = 'normale', category = 'fisico', power = 65, accuracy = 100, pp = 20, gen = 1}
t.doppiocalcio = {name = 'Doppiocalcio', type = 'lotta', category = 'fisico', power = 30, accuracy = 100, pp = 30, gen = 1}
t.megacalcio = {name = 'Megacalcio', type = 'normale', category = 'fisico', power = 120, accuracy = 75, pp = 5, gen = 1}
t.calciosalto = {name = 'Calciosalto', type = 'lotta', category = 'fisico', power = 100, accuracy = 95, pp = 10, gen = 1}
t.calciorullo = {name = 'Calciorullo', type = 'lotta', category = 'fisico', power = 60, accuracy = 85, pp = 15, gen = 1}
t.turbosabbia = {name = 'Turbosabbia', type = {[1] = 'normale', [2] = 'terra'}, category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 1}
t.bottintesta = {name = 'Bottintesta', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 15, gen = 1}
t.incornata = {name = 'Incornata', type = 'normale', category = 'fisico', power = 65, accuracy = 100, pp = 25, gen = 1}
t.furia = {name = 'Furia', type = 'normale', category = 'fisico', power = 15, accuracy = 85, pp = 20, gen = 1}
t.perforcorno = {name = 'Perforcorno', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 1}
t.azione = {name = 'Azione', type = 'normale', category = 'fisico', power = {[1] = 35, [5] = 50, [7] = 40}, accuracy = {[1] = 95, [5] = 100}, pp = 35, gen = 1}
t.corposcontro = {name = 'Corposcontro', type = 'normale', category = 'fisico', power = 85, accuracy = 100, pp = 15, gen = 1}
t.avvolgibotta = {name = 'Avvolgibotta', type = 'normale', category = 'fisico', power = 15, accuracy = 90, pp = 20, gen = 1}
t.riduttore = {name = 'Riduttore', type = 'normale', category = 'fisico', power = 90, accuracy = 85, pp = 20, gen = 1}
t.colpo = {name = 'Colpo', type = 'normale', category = 'fisico', power = 120, accuracy = 100, pp = 10, gen = 1}
t.sdoppiatore = {name = 'Sdoppiatore', type = 'normale', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 1}
t.colpocoda = {name = 'Colpocoda', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 30, gen = 1}
t.velenospina = {name = 'Velenospina', type = 'veleno', category = 'fisico', power = 15, accuracy = 100, pp = 35, gen = 1}
t['doppio ago'] = {name = 'Doppio Ago', type = 'coleottero', category = 'fisico', power = 25, accuracy = 100, pp = 20, gen = 1}
t.missilspillo = {name = 'Missilspillo', type = 'coleottero', category = 'fisico', power = 25, accuracy = 95, pp = 20, gen = 1}
t.fulmisguardo = {name = 'Fulmisguardo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 30, gen = 1}
t.morso = {name = 'Morso', type = {[1] = 'normale', [2] = 'buio'}, category = 'fisico', power = 60, accuracy = 100, pp = 25, gen = 1}
t.ruggito = {name = 'Ruggito', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 40, gen = 1}
t.boato = {name = 'Boato', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.canto = {name = 'Canto', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 55, pp = 15, gen = 1}
t.supersuono = {name = 'Supersuono', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 55, pp = 20, gen = 1}
t.sonicboom = {name = 'Sonicboom', type = 'normale', category = 'speciale', power = '&mdash;', accuracy = 90, pp = 20, gen = 1}
t.inibitore = {name = 'Inibitore', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 1}
t.acido = {name = 'Acido', type = 'veleno', category = 'speciale', power = 40, accuracy = 100, pp = 30, gen = 1}
t.braciere = {name = 'Braciere', type = 'fuoco', category = 'speciale', power = 40, accuracy = 100, pp = 25, gen = 1}
t.lanciafiamme = {name = 'Lanciafiamme', type = 'fuoco', category = 'speciale', power = 90, accuracy = 100, pp = 15, gen = 1}
t.nebbia = {name = 'Nebbia', type = 'ghiaccio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.pistolacqua = {name = 'Pistolacqua', type = 'acqua', category = 'speciale', power = 40, accuracy = 100, pp = 25, gen = 1}
t.idropompa = {name = 'Idropompa', type = 'acqua', category = 'speciale', power = 110, accuracy = 80, pp = 5, gen = 1}
t.surf = {name = 'Surf', type = 'acqua', category = 'speciale', power = 90, accuracy = 100, pp = 15, gen = 1}
t.geloraggio = {name = 'Geloraggio', type = 'ghiaccio', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 1}
t.bora = {name = 'Bora', type = 'ghiaccio', category = 'speciale', power = 110, accuracy = 70, pp = 5, gen = 1}
t.psicoraggio = {name = 'Psicoraggio', type = 'psico', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 1}
t.bollaraggio = {name = 'Bollaraggio', type = 'acqua', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 1}
t.raggiaurora = {name = 'Raggiaurora', type = 'ghiaccio', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 1}
t['iper raggio'] = {name = 'Iper Raggio', type = 'normale', category = 'speciale', power = 150, accuracy = 90, pp = 5, gen = 1}
t.beccata = {name = 'Beccata', type = 'volante', category = 'fisico', power = 35, accuracy = 100, pp = 35, gen = 1}
t.perforbecco = {name = 'Perforbecco', type = 'volante', category = 'fisico', power = 80, accuracy = 100, pp = 20, gen = 1}
t.sottomissione = {name = 'Sottomissione', type = 'lotta', category = 'fisico', power = 80, accuracy = 80, pp = 20, gen = 1}
t['colpo basso'] = {name = 'Colpo Basso', type = 'lotta', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 20, stab = true, gen = 1}
t.contatore = {name = { [1] = 'Contatore', [6] = 'Contrattacco' }, type = 'lotta', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 20, gen = 1}
t.contrattacco = t.contatore
t['movimento sismico'] = {name = 'Movimento Sismico', type = 'lotta', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 20, gen = 1}
t.forza = {name = 'Forza', type = 'normale', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 1}
t.assorbimento = {name = 'Assorbimento', type = 'erba', category = 'speciale', power = 20, accuracy = 100, pp = 25, gen = 1}
t.megassorbimento = {name = 'Megassorbimento', type = 'erba', category = 'speciale', power = 40, accuracy = 100, pp = 15, gen = 1}
t.parassiseme = {name = 'Parassiseme', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 90, pp = 10, gen = 1}
t.crescita = {name = 'Crescita', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.foglielama = {name = 'Foglielama', type = 'erba', category = 'fisico', power = 55, accuracy = 95, pp = 25, gen = 1}
t.solarraggio = {name = 'Solarraggio', type = 'erba', category = 'speciale', power = 120, accuracy = 100, pp = 10, gen = 1}
t.velenpolvere = {name = 'Velenpolvere', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 75, pp = 35, gen = 1}
t.paralizzante = {name = 'Paralizzante', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 75, pp = 30, gen = 1}
t.sonnifero = {name = 'Sonnifero', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 75, pp = 15, gen = 1}
t.petalodanza = {name = 'Petalodanza', type = 'erba', category = 'speciale', power = 120, accuracy = 100, pp = 10, gen = 1}
t.millebave = {name = 'Millebave', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = 95, pp = 40, gen = 1}
t['ira di drago'] = {name = 'Ira di Drago', type = 'drago', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 10, gen = 1}
t.turbofuoco = {name = 'Turbofuoco', type = 'fuoco', category = 'speciale', power = 35, accuracy = 85, pp = 15, gen = 1}
t.tuonoshock = {name = 'Tuonoshock', type = 'elettro', category = 'speciale', power = 40, accuracy = 100, pp = 30, gen = 1}
t.fulmine = {name = 'Fulmine', type = 'elettro', category = 'speciale', power = 90, accuracy = 100, pp = 15, gen = 1}
t.tuononda = {name = 'Tuononda', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = 90, pp = 20, gen = 1}
t.tuono = {name = 'Tuono', type = 'elettro', category = 'speciale', power = 110, accuracy = 70, pp = 10, gen = 1}
t.sassata = {name = 'Sassata', type = 'roccia', category = 'fisico', power = 50, accuracy = 90, pp = 15, gen = 1}
t.terremoto = {name = 'Terremoto', type = 'terra', category = 'fisico', power = 100, accuracy = 100, pp = 10, gen = 1}
t.abisso = {name = 'Abisso', type = 'terra', category = 'fisico', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 1}
t.fossa = {name = 'Fossa', type = 'terra', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 1}
t.tossina = {name = 'Tossina', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 90, pp = 10, gen = 1}
t.confusione = {name = 'Confusione', type = 'psico', category = 'speciale', power = 50, accuracy = 100, pp = 25, gen = 1}
t.psichico = {name = 'Psichico', type = 'psico', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 1}
t.ipnosi = {name = 'Ipnosi', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 60, pp = 20, gen = 1}
t.meditazione = {name = 'Meditazione', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 1}
t['agilità'] = {name = 'Agilità', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t['attacco rapido'] = {name = 'Attacco Rapido', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 30, gen = 1}
t.ira = {name = 'Ira', type = 'normale', category = 'fisico', power = 20, accuracy = 100, pp = 20, gen = 1}
t.teletrasporto = {name = 'Teletrasporto', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t['ombra notturna'] = {name = 'Ombra Notturna', type = 'spettro', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 15, gen = 1}
t.mimica = {name = 'Mimica', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.stridio = {name = 'Stridio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 85, pp = 40, gen = 1}
t.doppioteam = {name = 'Doppioteam', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 1}
t.ripresa = {name = 'Ripresa', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.rafforzatore = {name = 'Rafforzatore', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.minimizzato = {name = 'Minimizzato', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t['muro di fumo'] = {name = 'Muro di Fumo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 1}
t.stordiraggio = {name = 'Stordiraggio', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 1}
t.ritirata = {name = 'Ritirata', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 1}
t.ricciolscudo = {name = 'Ricciolscudo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 1}
t.barriera = {name = 'Barriera', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.schermoluce = {name = 'Schermoluce', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.nube = {name = 'Nube', type = 'ghiaccio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.riflesso = {name = 'Riflesso', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.focalenergia = {name = 'Focalenergia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.pazienza = {name = 'Pazienza', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, gen = 1}
t.metronomo = {name = 'Metronomo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.speculmossa = {name = 'Speculmossa', type = 'volante', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.autodistruzione = {name = 'Autodistruzione', type = 'normale', category = 'fisico', power = 200, accuracy = 100, pp = 5, gen = 1}
t.uovobomba = {name = 'Uovobomba', type = 'normale', category = 'fisico', power = 100, accuracy = 75, pp = 10, gen = 1}
t.leccata = {name = 'Leccata', type = 'spettro', category = 'fisico', power = 30, accuracy = 100, pp = 30, gen = 1}
t.smog = {name = 'Smog', type = 'veleno', category = 'speciale', power = 30, accuracy = 70, pp = 20, gen = 1}
t.fango = {name = 'Fango', type = 'veleno', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 1}
t.ossoclava = {name = 'Ossoclava', type = 'terra', category = 'fisico', power = 65, accuracy = 85, pp = 20, gen = 1}
t.fuocobomba = {name = 'Fuocobomba', type = 'fuoco', category = 'speciale', power = 110, accuracy = 85, pp = 5, gen = 1}
t.cascata = {name = 'Cascata', type = 'acqua', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 1}
t.tenaglia = {name = 'Tenaglia', type = 'acqua', category = 'fisico', power = 35, accuracy = 85, pp = 10, gen = 1}
t.comete = {name = 'Comete', type = 'normale', category = 'speciale', power = 60, accuracy = '&mdash;', pp = 20, gen = 1}
t.capocciata = {name = 'Capocciata', type = 'normale', category = 'fisico', power = 130, accuracy = 100, pp = 10, gen = 1}
t.sparalance = {name = 'Sparalance', type = 'normale', category = 'fisico', power = 20, accuracy = 100, pp = 15, gen = 1}
t.limitazione = {name = 'Limitazione', type = 'normale', category = 'fisico', power = 10, accuracy = 100, pp = 35, gen = 1}
t.amnesia = {name = 'Amnesia', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t['cinèsi'] = {name = 'Cinèsi', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 80, pp = 15, gen = 1}
t.covauova = {name = 'Covauova', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.calcinvolo = {name = 'Calcinvolo', type = 'lotta', category = 'fisico', power = 130, accuracy = 90, pp = 10, gen = 1}
t['sguardo feroce'] = {name = { [1] = 'Bagliore', [6] = 'Sguardo Feroce'}, type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 30, gen = 1}
t.bagliore = t['sguardo feroce']
t.mangiasogni = {name = 'Mangiasogni', type = 'psico', category = 'speciale', power = 100, accuracy = 100, pp = 15, gen = 1}
t.velenogas = {name = 'Velenogas', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 90, pp = 40, gen = 1}
t['attacco pioggia'] = {name = 'Attacco Pioggia', type = 'normale', category = 'fisico', power = 15, accuracy = 85, pp = 20, gen = 1}
t.sanguisuga = {name = 'Sanguisuga', type = 'coleottero', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 1}
t.demonbacio = {name = 'Demonbacio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 75, pp = 10, gen = 1}
t.aeroattacco = {name = 'Aeroattacco', type = 'volante', category = 'fisico', power = 140, accuracy = 90, pp = 5, gen = 1}
t.trasformazione = {name = 'Trasformazione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.bolla = {name = 'Bolla', type = 'acqua', category = 'speciale', power = 40, accuracy = 100, pp = 30, gen = 1}
t.stordipugno = {name = 'Stordipugno', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 10, gen = 1}
t.spora = {name = 'Spora', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 1}
t.flash = {name = 'Flash', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 1}
t.psiconda = {name = 'Psiconda', type = 'psico', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 15, gen = 1}
t.splash = {name = 'Splash', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 1}
t['scudo acido'] = {name = 'Scudo Acido', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 1}
t.martellata = {name = 'Martellata', type = 'acqua', category = 'fisico', power = 100, accuracy = 90, pp = 10, gen = 1}
t.esplosione = {name = 'Esplosione', type = 'normale', category = 'fisico', power = 250, accuracy = 100, pp = 5, gen = 1}
t.sfuriate = {name = 'Sfuriate', type = 'normale', category = 'fisico', power = 18, accuracy = 80, pp = 15, gen = 1}
t.ossomerang = {name = 'Ossomerang', type = 'terra', category = 'fisico', power = 50, accuracy = 90, pp = 10, gen = 1}
t.riposo = {name = 'Riposo', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.frana = {name = 'Frana', type = 'roccia', category = 'fisico', power = 75, accuracy = 90, pp = 10, gen = 1}
t.iperzanna = {name = 'Iperzanna', type = 'normale', category = 'fisico', power = 80, accuracy = 90, pp = 15, gen = 1}
t.affilatore = {name = 'Affilatore', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.conversione = {name = 'Conversione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 1}
t.tripletta = {name = 'Tripletta', type = 'normale', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 1}
t.superzanna = {name = 'Superzanna', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 90, pp = 10, gen = 1}
t.lacerazione = {name = 'Lacerazione', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 1}
t.sostituto = {name = 'Sostituto', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 1}
t.scontro = {name = 'Scontro', type = 'normale', category = 'fisico', power = 50, accuracy = '&mdash;', pp = 1, gen = 1}
t.schizzo = {name = 'Schizzo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 1, gen = 2}
t.triplocalcio = {name = 'Triplocalcio', type = 'lotta', category = 'fisico', power = 10, accuracy = 90, pp = 10, gen = 2}
t.furto = {name = 'Furto', type = 'buio', category = 'fisico', power = { [2] = 40, [6] = 60 }, accuracy = 100, pp = { [2] = 10, [6] = 25 }, gen = 2}
t.ragnatela = {name = 'Ragnatela', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 2}
t.leggimente = {name = 'Leggimente', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 2}
t.incubo = {name = 'Incubo', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 2}
t.ruotafuoco = {name = 'Ruotafuoco', type = 'fuoco', category = 'fisico', power = 60, accuracy = 100, pp = 25, gen = 2}
t.russare = {name = 'Russare', type = 'normale', category = 'speciale', power = 50, accuracy = 100, pp = 15, gen = 2}
t.maledizione = {name = 'Maledizione', type = {[2] = 'sconosciuto', [5] = 'spettro'}, category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.flagello = {name = 'Flagello', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 15, stab = true, gen = 2}
t.conversione2 = {name = 'Conversione2', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 2}
t.aerocolpo = {name = 'Aerocolpo', type = 'volante', category = 'speciale', power = 100, accuracy = 95, pp = 5, gen = 2}
t.cottonspora = {name = 'Cottonspora', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 100, pp = 40, gen = 2}
t.contropiede = {name = 'Contropiede', type = 'lotta', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 15, stab = true, gen = 2}
t.dispetto = {name = 'Dispetto', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 2}
t.polneve = {name = 'Polneve', type = 'ghiaccio', category = 'speciale', power = 40, accuracy = 100, pp = 25, gen = 2}
t.protezione = {name = 'Protezione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.pugnorapido = {name = 'Pugnorapido', type = 'lotta', category = 'fisico', power = 40, accuracy = 100, pp = 30, gen = 2}
t.visotruce = {name = 'Visotruce', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 2}
t.finta = {name = 'Finta', type = 'buio', category = 'fisico', power = 60, accuracy = '&mdash;', pp = 20, gen = 2}
t.dolcebacio = {name = 'Dolcebacio', type = {[2] = 'normale', [6] = 'folletto'}, category = 'stato', power = '&mdash;', accuracy = 75, pp = 10, gen = 2}
t.panciamburo = {name = 'Panciamburo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.fangobomba = {name = 'Fangobomba', type = 'veleno', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 2}
t.fangosberla = {name = 'Fangosberla', type = 'terra', category = 'speciale', power = 20, accuracy = 100, pp = 10, gen = 2}
t.octazooka = {name = 'Octazooka', type = 'acqua', category = 'speciale', power = 65, accuracy = 85, pp = 10, gen = 2}
t.punte = {name = 'Punte', type = 'terra', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 2}
t.falcecannone = {name = 'Falcecannone', type = 'elettro', category = 'speciale', power = 120, accuracy = 50, pp = 5, gen = 2}
t.preveggenza = {name = 'Preveggenza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 40, gen = 2}
t.destinobbligato = {name = 'Destinobbligato', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.ultimocanto = {name = 'Ultimocanto', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.ventogelato = {name = 'Ventogelato', type = 'ghiaccio', category = 'speciale', power = 55, accuracy = 95, pp = 15, gen = 2}
t.individua = {name = 'Individua', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.ossoraffica = {name = 'Ossoraffica', type = 'terra', category = 'fisico', power = 25, accuracy = 90, pp = 10, gen = 2}
t.localizza = {name = 'Localizza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 2}
t.oltraggio = {name = 'Oltraggio', type = 'drago', category = 'fisico', power = 120, accuracy = 100, pp = 10, gen = 2}
t.terrempesta = {name = 'Terrempesta', type = 'roccia', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.gigassorbimento = {name = 'Gigassorbimento', type = 'erba', category = 'speciale', power = 75, accuracy = 100, pp = 10, gen = 2}
t.resistenza = {name = 'Resistenza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.fascino = {name = 'Fascino', type = {[2] = 'normale', [6] = 'folletto'}, category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 2}
t.rotolamento = {name = 'Rotolamento', type = 'roccia', category = 'fisico', power = 30, accuracy = 90, pp = 20, gen = 2}
t.falsofinale = {name = 'Falsofinale', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 40, gen = 2}
t.bullo = {name = 'Bullo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 85, pp = 15, gen = 2}
t.buonlatte = {name = 'Buonlatte', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.scintilla = {name = 'Scintilla', type = 'elettro', category = 'fisico', power = 65, accuracy = 100, pp = 20, gen = 2}
t.tagliofuria = {name = 'Tagliofuria', type = 'coleottero', category = 'fisico', power = 40, accuracy = 95, pp = 20, gen = 2}
t.alacciaio = {name = 'Alacciaio', type = 'acciaio', category = 'fisico', power = 70, accuracy = 90, pp = 25, gen = 2}
t.malosguardo = {name = 'Malosguardo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 2}
t.attrazione = {name = 'Attrazione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 2}
t.sonnolalia = {name = 'Sonnolalia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.rintoccasana = {name = 'Rintoccasana', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.ritorno = {name = 'Ritorno', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 20, stab = true, gen = 2}
t.regalino = {name = 'Regalino', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 90, pp = 15, stab = true, gen = 2}
t.frustrazione = {name = 'Frustrazione', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 20, stab = true, gen = 2}
t.salvaguardia = {name = 'Salvaguardia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 25, gen = 2}
t.malcomune = {name = 'Malcomune', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 2}
t.magifuoco = {name = 'Magifuoco', type = 'fuoco', category = 'fisico', power = 100, accuracy = 95, pp = 5, gen = 2}
t.magnitudo = {name = 'Magnitudo', type = 'terra', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 30, stab = true, gen = 2}
t.dinamipugno = {name = 'Dinamipugno', type = 'lotta', category = 'fisico', power = 100, accuracy = 50, pp = 5, gen = 2}
t.megacorno = {name = 'Megacorno', type = 'coleottero', category = 'fisico', power = 120, accuracy = 85, pp = 10, gen = 2}
t.dragospiro = {name = 'Dragospiro', type = 'drago', category = 'speciale', power = 60, accuracy = 100, pp = 20, gen = 2}
t.staffetta = {name = 'Staffetta', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 2}
t.ripeti = {name = 'Ripeti', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 2}
t.inseguimento = {name = 'Inseguimento', type = 'buio', category = 'fisico', power = 40, accuracy = 100, pp = 20, gen = 2}
t.rapigiro = {name = 'Rapigiro', type = 'normale', category = 'fisico', power = {[2] = 20, [8] = 50}, accuracy = 100, pp = 40, gen = 2}
t.profumino = {name = 'Profumino', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 2}
t.codacciaio = {name = 'Codacciaio', type = 'acciaio', category = 'fisico', power = 100, accuracy = 75, pp = 15, gen = 2}
t.ferrartigli = {name = 'Ferrartigli', type = 'acciaio', category = 'fisico', power = 50, accuracy = 95, pp = 35, gen = 2}
t.vitaltiro = {name = 'Vitaltiro', type = 'lotta', category = 'fisico', power = 70, accuracy = '&mdash;', pp = 10, gen = 2}
t.mattindoro = {name = 'Mattindoro', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.sintesi = {name = 'Sintesi', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.lucelunare = {name = 'Lucelunare', type = {[2] = 'normale', [6] = 'folletto'}, category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.introforza = {name = 'Introforza', type = 'normale', category = 'speciale', power = {[2] = "&mdash;", [6] = 60}, accuracy = 100, pp = 15, gen = 2}
t.incrocolpo = {name = 'Incrocolpo', type = 'lotta', category = 'fisico', power = 100, accuracy = 80, pp = 5, gen = 2}
t.tornado = {name = 'Tornado', type = 'drago', category = 'speciale', power = 40, accuracy = 100, pp = 20, gen = 2}
t.pioggiadanza = {name = 'Pioggiadanza', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.giornodisole = {name = 'Giornodisole', type = 'fuoco', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 2}
t.sgranocchio = {name = 'Sgranocchio', type = 'buio', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 2}
t.specchiovelo = {name = 'Specchiovelo', type = 'psico', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 20, gen = 2}
t['psicamisù'] = {name = 'Psicamisù', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 2}
t.extrarapido = {name = 'Extrarapido', type = 'normale', category = 'fisico', power = 80, accuracy = 100, pp = 5, gen = 2}
t.forzantica = {name = 'Forzantica', type = 'roccia', category = 'speciale', power = 60, accuracy = 100, pp = 5, gen = 2}
t['palla ombra'] = {name = 'Palla Ombra', type = 'spettro', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 2}
t.divinazione = {name = 'Divinazione', type = 'psico', category = 'speciale', power = 120, accuracy = 100, pp = 10, gen = 2}
t.spaccaroccia = {name = 'Spaccaroccia', type = 'lotta', category = 'fisico', power = 40, accuracy = 100, pp = 15, gen = 2}
t.mulinello = {name = 'Mulinello', type = 'acqua', category = 'speciale', power = 35, accuracy = 85, pp = 15, gen = 2}
t.picchiaduro = {name = 'Picchiaduro', type = 'buio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, stab = {[2] = false, [5] = true}, gen = 2}
t.bruciapelo = {name = 'Bruciapelo', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 10, gen = 3}
t.baraonda = {name = 'Baraonda', type = 'normale', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 3}
t.accumulo = {name = 'Accumulo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.sfoghenergia = {name = 'Sfoghenergia', type = 'normale', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 10, stab = true, gen = 3}
t.introenergia = {name = 'Introenergia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 3}
t.ondacalda = {name = 'Ondacalda', type = 'fuoco', category = 'speciale', power = 95, accuracy = 90, pp = 10, gen = 3}
t.grandine = {name = 'Grandine', type = 'ghiaccio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 3}
t.attaccalite = {name = 'Attaccalite', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 3}
t.adulazione = {name = 'Adulazione', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 3}
t.fuocofatuo = {name = 'Fuocofatuo', type = 'fuoco', category = 'stato', power = '&mdash;', accuracy = 85, pp = 15, gen = 3}
t.memento = {name = 'Memento', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.facciata = {name = 'Facciata', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 3}
t.centripugno = {name = 'Centripugno', type = 'lotta', category = 'fisico', power = 150, accuracy = 100, pp = 20, gen = 3}
t.maniereforti = {name = 'Maniereforti', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 10, gen = 3}
t.sonoqui = {name = 'Sonoqui', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.naturforza = {name = 'Naturforza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.sottocarica = {name = 'Sottocarica', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.provocazione = {name = 'Provocazione', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 3}
t.altruismo = {name = 'Altruismo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.raggiro = {name = 'Raggiro', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.giocodiruolo = {name = 'Giocodiruolo', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 3}
t.desiderio = {name = 'Desiderio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 3}
t.assistente = {name = 'Assistente', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.radicamento = {name = 'Radicamento', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.troppoforte = {name = 'Troppoforte', type = 'lotta', category = 'fisico', power = 120, accuracy = 100, pp = 5, gen = 3}
t.magivelo = {name = 'Magivelo', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 3}
t.riciclo = {name = 'Riciclo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.vendetta = {name = 'Vendetta', type = 'lotta', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 3}
t.breccia = {name = 'Breccia', type = 'lotta', category = 'fisico', power = 75, accuracy = 100, pp = 15, gen = 3}
t.sbadiglio = {name = 'Sbadiglio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.privazione = {name = 'Privazione', type = 'buio', category = 'fisico', power = 65, accuracy = 100, pp = 20, gen = 3}
t.rimonta = {name = 'Rimonta', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 5, gen = 3}
t.eruzione = {name = 'Eruzione', type = 'fuoco', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 3}
t.baratto = {name = 'Baratto', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.esclusiva = {name = 'Esclusiva', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.rinfrescata = {name = 'Rinfrescata', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 3}
t.rancore = {name = 'Rancore', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 3}
t.scippo = {name = 'Scippo', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 3}
t.forzasegreta = {name = 'Forzasegreta', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 3}
t.sub = {name = 'Sub', type = 'acqua', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 3}
t.sberletese = {name = 'Sberletese', type = 'lotta', category = 'fisico', power = 15, accuracy = 100, pp = 20, gen = 3}
t.camuffamento = {name = 'Camuffamento', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.codadiluce = {name = 'Codadiluce', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.abbagliante = {name = 'Abbagliante', type = 'psico', category = 'speciale', power = 70, accuracy = 100, pp = 5, gen = 3}
t.foschisfera = {name = 'Foschisfera', type = 'psico', category = 'speciale', power = 70, accuracy = 100, pp = 5, gen = 3}
t.danzadipiume = {name = 'Danzadipiume', type = 'volante', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 3}
t.strampadanza = {name = 'Strampadanza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 3}
t.calciardente = {name = 'Calciardente', type = 'fuoco', category = 'fisico', power = 85, accuracy = 90, pp = 10, gen = 3}
t.fangata = {name = 'Fangata', type = 'terra', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 3}
t['palla gelo'] = {name = 'Palla Gelo', type = 'ghiaccio', category = 'fisico', power = 30, accuracy = 90, pp = 20, gen = 3}
t.pugnospine = {name = 'Pugnospine', type = 'erba', category = 'fisico', power = 60, accuracy = 100, pp = 15, gen = 3}
t.pigro = {name = 'Pigro', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 3}
t.granvoce = {name = 'Granvoce', type = 'normale', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 3}
t.velenodenti = {name = 'Velenodenti', type = 'veleno', category = 'fisico', power = 50, accuracy = 100, pp = 15, gen = 3}
t.tritartigli = {name = 'Tritartigli', type = 'normale', category = 'fisico', power = 75, accuracy = 95, pp = 10, gen = 3}
t.incendio = {name = 'Incendio', type = 'fuoco', category = 'speciale', power = 150, accuracy = 90, pp = 5, gen = 3}
t.idrocannone = {name = 'Idrocannone', type = 'acqua', category = 'speciale', power = 150, accuracy = 90, pp = 5, gen = 3}
t.meteorpugno = {name = 'Meteorpugno', type = 'acciaio', category = 'fisico', power = 90, accuracy = 90, pp = 10, gen = 3}
t.sgomento = {name = 'Sgomento', type = 'spettro', category = 'fisico', power = 30, accuracy = 100, pp = 15, gen = 3}
t['palla clima'] = {name = 'Palla Clima', type = 'normale', category = 'speciale', power = 50, accuracy = 100, pp = 10, gen = 3}
t.aromaterapia = {name = 'Aromaterapia', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 3}
t.falselacrime = {name = 'Falselacrime', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 3}
t.aerasoio = {name = 'Aerasoio', type = 'volante', category = 'speciale', power = 60, accuracy = 95, pp = 25, gen = 3}
t.vampata = {name = 'Vampata', type = 'fuoco', category = 'speciale', power = 130, accuracy = 90, pp = 5, gen = 3}
t.segugio = {name = 'Segugio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 40, gen = 3}
t.rocciotomba = {name = 'Rocciotomba', type = 'roccia', category = 'fisico', power = 60, accuracy = 95, pp = 15, gen = 3}
t.ventargenteo = {name = 'Ventargenteo', type = 'coleottero', category = 'speciale', power = 60, accuracy = 100, pp = 5, gen = 3}
t.ferrostrido = {name = 'Ferrostrido', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = 85, pp = 40, gen = 3}
t.meloderba = {name = 'Meloderba', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 55, pp = 15, gen = 3}
t.solletico = {name = 'Solletico', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 3}
t.cosmoforza = {name = 'Cosmoforza', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.zampillo = {name = 'Zampillo', type = 'acqua', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 3}
t.segnoraggio = {name = 'Segnoraggio', type = 'coleottero', category = 'speciale', power = 75, accuracy = 100, pp = 15, gen = 3}
t.pugnodombra = {name = 'Pugnodombra', type = 'spettro', category = 'fisico', power = 60, accuracy = '&mdash;', pp = 20, gen = 3}
t.extrasenso = {name = 'Extrasenso', type = 'psico', category = 'speciale', power = 80, accuracy = 100, pp = 20, gen = 3}
t.stramontante = {name = 'Stramontante', type = 'lotta', category = 'fisico', power = 85, accuracy = 90, pp = 15, gen = 3}
t.sabbiotomba = {name = 'Sabbiotomba', type = 'terra', category = 'fisico', power = 35, accuracy = 85, pp = 15, gen = 3}
t.purogelo = {name = 'Purogelo', type = 'ghiaccio', category = 'speciale', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 3}
t.fanghiglia = {name = 'Fanghiglia', type = 'acqua', category = 'speciale', power = 90, accuracy = 85, pp = 10, gen = 3}
t.semitraglia = {name = 'Semitraglia', type = 'erba', category = 'fisico', power = 25, accuracy = 100, pp = 30, gen = 3}
t.aeroassalto = {name = 'Aeroassalto', type = 'volante', category = 'fisico', power = 60, accuracy = '&mdash;', pp = 20, gen = 3}
t.gelolancia = {name = 'Gelolancia', type = 'ghiaccio', category = 'fisico', power = 25, accuracy = 100, pp = 30, gen = 3}
t.ferroscudo = {name = 'Ferroscudo', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 3}
t.blocco = {name = 'Blocco', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 3}
t.gridodilotta = {name = 'Gridodilotta', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 3}
t.dragartigli = {name = 'Dragartigli', type = 'drago', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 3}
t.radicalbero = {name = 'Radicalbero', type = 'erba', category = 'speciale', power = 150, accuracy = 90, pp = 5, gen = 3}
t.granfisico = {name = 'Granfisico', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.rimbalzo = {name = 'Rimbalzo', type = 'volante', category = 'fisico', power = 85, accuracy = 85, pp = 5, gen = 3}
t.colpodifango = {name = 'Colpodifango', type = 'terra', category = 'speciale', power = 55, accuracy = 95, pp = 15, gen = 3}
t.velenocoda = {name = 'Velenocoda', type = 'veleno', category = 'fisico', power = 50, accuracy = 100, pp = 25, gen = 3}
t.supplica = {name = 'Supplica', type = 'normale', category = 'fisico', power = 60, accuracy = 100, pp = 25, gen = 3}
t.locomovolt = {name = 'Locomovolt', type = 'elettro', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 3}
t.fogliamagica = {name = 'Fogliamagica', type = 'erba', category = 'speciale', power = 60, accuracy = '&mdash;', pp = 20, gen = 3}
t.docciascudo = {name = 'Docciascudo', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 3}
t.calmamente = {name = 'Calmamente', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.fendifoglia = {name = 'Fendifoglia', type = 'erba', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 3}
t.dragodanza = {name = 'Dragodanza', type = 'drago', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 3}
t.cadutamassi = {name = 'Cadutamassi', type = 'roccia', category = 'fisico', power = 25, accuracy = 90, pp = 10, gen = 3}
t.ondashock = {name = 'Ondashock', type = 'elettro', category = 'speciale', power = 60, accuracy = '&mdash;', pp = 20, gen = 3}
t.idropulsar = {name = 'Idropulsar', type = 'acqua', category = 'speciale', power = 60, accuracy = 100, pp = 20, gen = 3}
t.obbliderio = {name = 'Obbliderio', type = 'acciaio', category = 'speciale', power = 140, accuracy = 100, pp = 5, gen = 3}
t.psicoslancio = {name = 'Psicoslancio', type = 'psico', category = 'speciale', power = 140, accuracy = 90, pp = 5, gen = 3}
t.trespolo = {name = 'Trespolo', type = 'volante', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t['gravità'] = {name = 'Gravità', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 4}
t.miracolvista = {name = 'Miracolvista', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 4}
t.svegliopacca = {name = 'Svegliopacca', type = 'lotta', category = 'fisico', power = 70, accuracy = 100, pp = 10, gen = 4}
t.martelpugno = {name = 'Martelpugno', type = 'lotta', category = 'fisico', power = 100, accuracy = 90, pp = 10, gen = 4}
t.vortexpalla = {name = 'Vortexpalla', type = 'acciaio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 4}
t.curardore = {name = 'Curardore', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.acquadisale = {name = 'Acquadisale', type = 'acqua', category = 'speciale', power = 65, accuracy = 100, pp = 10, gen = 4}
t.dononaturale = {name = 'Dononaturale', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 15, stab = true, gen = 4}
t.fintoattacco = {name = 'Fintoattacco', type = 'normale', category = 'fisico', power = 30, accuracy = 100, pp = 10, gen = 4}
t.spennata = {name = 'Spennata', type = 'volante', category = 'fisico', power = 60, accuracy = 100, pp = 20, gen = 4}
t.ventoincoda = {name = 'Ventoincoda', type = 'volante', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 4}
t.acupressione = {name = 'Acupressione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 4}
t.metalscoppio = {name = 'Metalscoppio', type = 'acciaio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, gen = 4}
t.retromarcia = {name = 'Retromarcia', type = 'coleottero', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 4}
t.zuffa = {name = 'Zuffa', type = 'lotta', category = 'fisico', power = 120, accuracy = 100, pp = 5, gen = 4}
t.rivincita = {name = 'Rivincita', type = 'buio', category = 'fisico', power = 50, accuracy = 100, pp = 10, gen = 4}
t.garanzia = {name = 'Garanzia', type = 'buio', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 4}
t.divieto = {name = 'Divieto', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 4}
t.lancio = {name = 'Lancio', type = 'buio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, stab = true, gen = 4}
t.psicotrasfer = {name = 'Psicotrasfer', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 4}
t.asso = {name = 'Asso', type = 'normale', category = 'speciale', power = '&mdash;', accuracy = '&mdash;', pp = 5, stab = true, gen = 4}
t.anticura = {name = 'Anticura', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 4}
t.strizzata = {name = 'Strizzata', type = 'normale', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 4}
t.ingannoforza = {name = 'Ingannoforza', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.gastroacido = {name = 'Gastroacido', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 4}
t.fortuncanto = {name = 'Fortuncanto', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 4}
t.precedenza = {name = 'Precedenza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.copione = {name = 'Copione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.barattoforza = {name = 'Barattoforza', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.barattoscudo = {name = 'Barattoscudo', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.punizione = {name = 'Punizione', type = 'buio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 4}
t.ultimascelta = {name = 'Ultimascelta', type = 'normale', category = 'fisico', power = 140, accuracy = 100, pp = 5, gen = 4}
t.affannoseme = {name = 'Affannoseme', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 4}
t.sbigoattacco = {name = 'Sbigoattacco', type = 'buio', category = 'fisico', power = 70, accuracy = 100, pp = 5, gen = 4}
t.fielepunte = {name = 'Fielepunte', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.cuorbaratto = {name = 'Cuorbaratto', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.acquanello = {name = 'Acquanello', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.magnetascesa = {name = 'Magnetascesa', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.fuococarica = {name = 'Fuococarica', type = 'fuoco', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 4}
t.palmoforza = {name = 'Palmoforza', type = 'lotta', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 4}
t.forzasfera = {name = 'Forzasfera', type = 'lotta', category = 'speciale', power = 80, accuracy = '&mdash;', pp = 20, gen = 4}
t.lucidatura = {name = 'Lucidatura', type = 'roccia', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.velenpuntura = {name = 'Velenpuntura', type = 'veleno', category = 'fisico', power = 80, accuracy = 100, pp = 20, gen = 4}
t.neropulsar = {name = 'Neropulsar', type = 'buio', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 4}
t.nottesferza = {name = 'Nottesferza', type = 'buio', category = 'fisico', power = 70, accuracy = 100, pp = 15, gen = 4}
t.idrondata = {name = 'Idrondata', type = 'acqua', category = 'fisico', power = 90, accuracy = 90, pp = 10, gen = 4}
t.semebomba = {name = 'Semebomba', type = 'erba', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 4}
t.eterelama = {name = 'Eterelama', type = 'volante', category = 'speciale', power = 75, accuracy = 95, pp = 15, gen = 4}
t['forbice x'] = {name = 'Forbice X', type = 'coleottero', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 4}
t.ronzio = {name = 'Ronzio', type = 'coleottero', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 4}
t.dragopulsar = {name = 'Dragopulsar', type = 'drago', category = 'speciale', power = 85, accuracy = 100, pp = 10, gen = 4}
t.dragofuria = {name = 'Dragofuria', type = 'drago', category = 'fisico', power = 100, accuracy = 75, pp = 10, gen = 4}
t.gemmoforza = {name = 'Gemmoforza', type = 'roccia', category = 'speciale', power = 80, accuracy = 100, pp = 20, gen = 4}
t.assorbipugno = {name = 'Assorbipugno', type = 'lotta', category = 'fisico', power = 75, accuracy = 100, pp = 10, gen = 4}
t.vuotonda = {name = 'Vuotonda', type = 'lotta', category = 'speciale', power = 40, accuracy = 100, pp = 30, gen = 4}
t.focalcolpo = {name = 'Focalcolpo', type = 'lotta', category = 'speciale', power = 120, accuracy = 70, pp = 5, gen = 4}
t.energipalla = {name = 'Energipalla', type = 'erba', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 4}
t.baldeali = {name = 'Baldeali', type = 'volante', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 4}
t.geoforza = {name = 'Geoforza', type = 'terra', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 4}
t.rapidscambio = {name = 'Rapidscambio', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 4}
t.gigaimpatto = {name = 'Gigaimpatto', type = 'normale', category = 'fisico', power = 150, accuracy = 90, pp = 5, gen = 4}
t.congiura = {name = 'Congiura', type = 'buio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.pugnoscarica = {name = 'Pugnoscarica', type = 'acciaio', category = 'fisico', power = 40, accuracy = 100, pp = 30, gen = 4}
t.slavina = {name = 'Slavina', type = 'ghiaccio', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 4}
t.geloscheggia = {name = 'Geloscheggia', type = 'ghiaccio', category = 'fisico', power = 40, accuracy = 100, pp = 30, gen = 4}
t.ombrartigli = {name = 'Ombrartigli', type = 'spettro', category = 'fisico', power = 70, accuracy = 100, pp = 15, gen = 4}
t.fulmindenti = {name = 'Fulmindenti', type = 'elettro', category = 'fisico', power = 65, accuracy = 95, pp = 15, gen = 4}
t.gelodenti = {name = 'Gelodenti', type = 'ghiaccio', category = 'fisico', power = 65, accuracy = 95, pp = 15, gen = 4}
t.rogodenti = {name = 'Rogodenti', type = 'fuoco', category = 'fisico', power = 65, accuracy = 95, pp = 15, gen = 4}
t.furtivombra = {name = 'Furtivombra', type = 'spettro', category = 'fisico', power = 40, accuracy = 100, pp = 30, gen = 4}
t.pantanobomba = {name = 'Pantanobomba', type = 'terra', category = 'speciale', power = 65, accuracy = 85, pp = 10, gen = 4}
t.psicotaglio = {name = 'Psicotaglio', type = 'psico', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 4}
t['cozzata zen'] = {name = 'Cozzata Zen', type = 'psico', category = 'fisico', power = 80, accuracy = 90, pp = 15, gen = 4}
t.cristalcolpo = {name = 'Cristalcolpo', type = 'acciaio', category = 'speciale', power = 65, accuracy = 85, pp = 10, gen = 4}
t.cannonflash = {name = 'Cannonflash', type = 'acciaio', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 4}
t.scalaroccia = {name = 'Scalaroccia', type = 'normale', category = 'fisico', power = 90, accuracy = 85, pp = 20, gen = 4}
t.scacciabruma = {name = 'Scacciabruma', type = 'volante', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 4}
t.distortozona = {name = 'Distortozona', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 4}
t.dragobolide = {name = 'Dragobolide', type = 'drago', category = 'speciale', power = 130, accuracy = 90, pp = 5, gen = 4}
t.scarica = {name = 'Scarica', type = 'elettro', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 4}
t.lavasbuffo = {name = 'Lavasbuffo', type = 'fuoco', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 4}
t.verdebufera = {name = 'Verdebufera', type = 'erba', category = 'speciale', power = 130, accuracy = 90, pp = 5, gen = 4}
t.vigorcolpo = {name = 'Vigorcolpo', type = 'erba', category = 'fisico', power = 120, accuracy = 85, pp = 10, gen = 4}
t.devastomasso = {name = 'Devastomasso', type = 'roccia', category = 'fisico', power = 150, accuracy = 90, pp = 5, gen = 4}
t.velenocroce = {name = 'Velenocroce', type = 'veleno', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 4}
t.sporcolancio = {name = 'Sporcolancio', type = 'veleno', category = 'fisico', power = 120, accuracy = 80, pp = 5, gen = 4}
t.metaltestata = {name = 'Metaltestata', type = 'acciaio', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 4}
t.bombagnete = {name = 'Bombagnete', type = 'acciaio', category = 'fisico', power = 60, accuracy = '&mdash;', pp = 20, gen = 4}
t.pietrataglio = {name = 'Pietrataglio', type = 'roccia', category = 'fisico', power = 100, accuracy = 80, pp = 5, gen = 4}
t.incanto = {name = 'Incanto', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 4}
t.levitoroccia = {name = 'Levitoroccia', type = 'roccia', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 4}
t.laccioerboso = {name = 'Laccioerboso', type = 'erba', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 20, stab = true, gen = 4}
t.schiamazzo = {name = 'Schiamazzo', type = 'volante', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 4}
t.giudizio = {name = 'Giudizio', type = 'normale', category = 'speciale', power = 100, accuracy = 100, pp = 10, gen = 4}
t.coleomorso = {name = 'Coleomorso', type = 'coleottero', category = 'fisico', power = 60, accuracy = 100, pp = 20, gen = 4}
t.raggioscossa = {name = 'Raggioscossa', type = 'elettro', category = 'speciale', power = 50, accuracy = 90, pp = 10, gen = 4}
t.mazzuolegno = {name = 'Mazzuolegno', type = 'erba', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 4}
t.acquagetto = {name = 'Acquagetto', type = 'acqua', category = 'fisico', power = 40, accuracy = 100, pp = 20, gen = 4}
t.comandourto = {name = 'Comandourto', type = 'coleottero', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 4}
t.comandoscudo = {name = 'Comandoscudo', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.comandocura = {name = 'Comandocura', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.zuccata = {name = 'Zuccata', type = 'roccia', category = 'fisico', power = 150, accuracy = 80, pp = 5, gen = 4}
t.doppiosmash = {name = 'Doppiosmash', type = 'normale', category = 'fisico', power = 35, accuracy = 90, pp = 10, gen = 4}
t.fragortempo = {name = 'Fragortempo', type = 'drago', category = 'speciale', power = 150, accuracy = 90, pp = 5, gen = 4}
t.fendispazio = {name = 'Fendispazio', type = 'drago', category = 'speciale', power = 100, accuracy = 95, pp = 5, gen = 4}
t.lunardanza = {name = 'Lunardanza', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 4}
t.sbriciolmano = {name = 'Sbriciolmano', type = 'normale', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 5, stab = true, gen = 4}
t.magmaclisma = {name = 'Magmaclisma', type = 'fuoco', category = 'speciale', power = 100, accuracy = 75, pp = 5, gen = 4}
t.vuototetro = {name = 'Vuototetro', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 50, pp = 10, gen = 4}
t.infuriaseme = {name = 'Infuriaseme', type = 'erba', category = 'speciale', power = 120, accuracy = 85, pp = 5, gen = 4}
t.funestovento = {name = 'Funestovento', type = 'spettro', category = 'speciale', power = 60, accuracy = 100, pp = 5, gen = 4}
t.oscurotuffo = {name = 'Oscurotuffo', type = 'spettro', category = 'fisico', power = 120, accuracy = 100, pp = 5, gen = 4}
t.unghiaguzze = {name = 'Unghiaguzze', type = 'buio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.bodyguard = {name = 'Bodyguard', type = 'roccia', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.paridifesa = {name = 'Paridifesa', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.pariattacco = {name = 'Pariattacco', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.mirabilzona = {name = 'Mirabilzona', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.psicoshock = {name = 'Psicoshock', type = 'psico', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 5}
t.velenoshock = {name = 'Velenoshock', type = 'veleno', category = 'speciale', power = 65, accuracy = 100, pp = 10, gen = 5}
t.sganciapesi = {name = 'Sganciapesi', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.polverabbia = {name = 'Polverabbia', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 5}
t.telecinesi = {name = 'Telecinesi', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.magicozona = {name = 'Magicozona', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.abbattimento = {name = 'Abbattimento', type = 'roccia', category = 'fisico', power = 50, accuracy = 100, pp = 15, gen = 5}
t.tempestretta = {name = 'Tempestretta', type = 'lotta', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 5}
t.pirolancio = {name = 'Pirolancio', type = 'fuoco', category = 'speciale', power = 70, accuracy = 100, pp = 15, gen = 5}
t.fangonda = {name = 'Fangonda', type = 'veleno', category = 'speciale', power = 95, accuracy = 100, pp = 10, gen = 5}
t.eledanza = {name = 'Eledanza', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 5}
t.pesobomba = {name = 'Pesobomba', type = 'acciaio', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, stab = true, gen = 5}
t.sincrumore = {name = 'Sincrumore', type = 'psico', category = 'speciale', power = 120, accuracy = 100, pp = 15, gen = 5}
t.energisfera = {name = 'Energisfera', type = 'elettro', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 10, stab = true, gen = 5}
t.inondazione = {name = 'Inondazione', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 5}
t.nitrocarica = {name = 'Nitrocarica', type = 'fuoco', category = 'fisico', power = 50, accuracy = 100, pp = 20, gen = 5}
t.arrotola = {name = 'Arrotola', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 5}
t.calciobasso = {name = 'Calciobasso', type = 'lotta', category = 'fisico', power = 65, accuracy = 100, pp = 20, gen = 5}
t.acidobomba = {name = 'Acidobomba', type = 'veleno', category = 'speciale', power = 40, accuracy = 100, pp = 20, gen = 5}
t.ripicca = {name = 'Ripicca', type = 'buio', category = 'fisico', power = 95, accuracy = 100, pp = 15, gen = 5}
t.ondisinvolta = {name = 'Ondisinvolta', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 5}
t.saltamicizia = {name = 'Saltamicizia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 5}
t.cortesia = {name = 'Cortesia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.coro = {name = 'Coro', type = 'normale', category = 'speciale', power = 60, accuracy = 100, pp = 15, gen = 5}
t.echeggiavoce = {name = 'Echeggiavoce', type = 'normale', category = 'speciale', power = 40, accuracy = 100, pp = 15, gen = 5}
t.insidia = {name = 'Insidia', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 5}
t.pulifumo = {name = 'Pulifumo', type = 'veleno', category = 'speciale', power = 50, accuracy = '&mdash;', pp = 15, gen = 5}
t.veicolaforza = {name = 'Veicolaforza', type = 'psico', category = 'speciale', power = 20, accuracy = 100, pp = 10, gen = 5}
t.anticipo = {name = 'Anticipo', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.cambiaposto = {name = 'Cambiaposto', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.idrovampata = {name = 'Idrovampata', type = 'acqua', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 5}
t.gettaguscio = {name = 'Gettaguscio', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.ondasana = {name = 'Ondasana', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.sciagura = {name = 'Sciagura', type = 'spettro', category = 'speciale', power = 65, accuracy = 100, pp = 10, gen = 5}
t.cadutalibera = {name = 'Cadutalibera', type = 'volante', category = 'fisico', power = 60, accuracy = 100, pp = 10, gen = 5}
t.cambiomarcia = {name = 'Cambiomarcia', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.ribaltiro = {name = 'Ribaltiro', type = 'lotta', category = 'fisico', power = 60, accuracy = 90, pp = 10, gen = 5}
t.bruciatutto = {name = 'Bruciatutto', type = 'fuoco', category = 'speciale', power = 60, accuracy = 100, pp = 15, gen = 5}
t.spintone = {name = 'Spintone', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 5}
t.acrobazia = {name = 'Acrobazia', type = 'volante', category = 'fisico', power = 55, accuracy = 100, pp = 15, gen = 5}
t.riflettipo = {name = 'Riflettipo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.nemesi = {name = 'Nemesi', type = 'normale', category = 'fisico', power = 70, accuracy = 100, pp = 5, gen = 5}
t.azzardo = {name = 'Azzardo', type = 'lotta', category = 'speciale', power = '&mdash;', accuracy = 100, pp = 5, gen = 5}
t.cediregalo = {name = 'Cediregalo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 5}
t.marchiatura = {name = 'Marchiatura', type = 'fuoco', category = 'speciale', power = 100, accuracy = 50, pp = 5, gen = 5}
t.acquapatto = {name = 'Acquapatto', type = 'acqua', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 5}
t.fiammapatto = {name = 'Fiammapatto', type = 'fuoco', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 5}
t.erbapatto = {name = 'Erbapatto', type = 'erba', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 5}
t.invertivolt = {name = 'Invertivolt', type = 'elettro', category = 'speciale', power = 70, accuracy = 100, pp = 20, gen = 5}
t.entomoblocco = {name = 'Entomoblocco', type = 'coleottero', category = 'speciale', power = 50, accuracy = 100, pp = 20, gen = 5}
t.battiterra = {name = 'Battiterra', type = 'terra', category = 'fisico', power = 60, accuracy = 100, pp = 20, gen = 5}
t.alitogelido = {name = 'Alitogelido', type = 'ghiaccio', category = 'speciale', power = 60, accuracy = 90, pp = 10, gen = 5}
t.codadrago = {name = 'Codadrago', type = 'drago', category = 'fisico', power = 60, accuracy = 90, pp = 10, gen = 5}
t.cuordileone = {name = 'Cuordileone', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 5}
t.elettrotela = {name = 'Elettrotela', type = 'elettro', category = 'speciale', power = 55, accuracy = 95, pp = 15, gen = 5}
t.sprizzalampo = {name = 'Sprizzalampo', type = 'elettro', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 5}
t.giravvita = {name = 'Giravvita', type = 'terra', category = 'fisico', power = 80, accuracy = 95, pp = 10, gen = 5}
t.doppiocolpo = {name = 'Doppiocolpo', type = 'drago', category = 'fisico', power = 40, accuracy = 90, pp = 15, gen = 5}
t.cuorestampo = {name = 'Cuorestampo', type = 'psico', category = 'fisico', power = 60, accuracy = 100, pp = 25, gen = 5}
t.legnicorno = {name = 'Legnicorno', type = 'erba', category = 'fisico', power = 75, accuracy = 100, pp = 10, gen = 5}
t.spadasolenne = {name = 'Spadasolenne', type = 'lotta', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 5}
t.conchilama = {name = 'Conchilama', type = 'acqua', category = 'fisico', power = 75, accuracy = 95, pp = 10, gen = 5}
t.marchiafuoco = {name = 'Marchiafuoco', type = 'fuoco', category = 'fisico', power = '&mdash;', accuracy = 100, pp = 10, stab = true, gen = 5}
t.vorticerba = {name = 'Vorticerba', type = 'erba', category = 'speciale', power = 65, accuracy = 90, pp = 10, gen = 5}
t.rulloduro = {name = 'Rulloduro', type = 'coleottero', category = 'fisico', power = 65, accuracy = 100, pp = 20, gen = 5}
t.cotonscudo = {name = 'Cotonscudo', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 5}
t.urtoscuro = {name = 'Urtoscuro', type = 'buio', category = 'speciale', power = 85, accuracy = 95, pp = 10, gen = 5}
t.psicobotta = {name = 'Psicobotta', type = 'psico', category = 'speciale', power = 100, accuracy = 100, pp = 10, gen = 5}
t.spazzasberla = {name = 'Spazzasberla', type = 'normale', category = 'fisico', power = 25, accuracy = 85, pp = 10, gen = 5}
t.tifone = {name = 'Tifone', type = 'volante', category = 'speciale', power = 110, accuracy = 70, pp = 10, gen = 5}
t.ricciolata = {name = 'Ricciolata', type = 'normale', category = 'fisico', power = 120, accuracy = 100, pp = 15, gen = 5}
t.ingracolpo = {name = 'Ingracolpo', type = 'acciaio', category = 'fisico', power = 50, accuracy = 85, pp = 15, gen = 5}
t.sparafuoco = {name = 'Sparafuoco', type = 'fuoco', category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 5}
t.tecnobotto = {name = 'Tecnobotto', type = 'normale', category = 'speciale', power = 120, accuracy = 100, pp = 5, gen = 5}
t.cantoantico = {name = 'Cantoantico', type = 'normale', category = 'speciale', power = 75, accuracy = 100, pp = 10, gen = 5}
t.spadamistica = {name = 'Spadamistica', type = 'lotta', category = 'speciale', power = 85, accuracy = 100, pp = 10, gen = 5}
t.gelamondo = {name = 'Gelamondo', type = 'ghiaccio', category = 'speciale', power = 65, accuracy = 95, pp = 10, gen = 5}
t.lucesiluro = {name = 'Lucesiluro', type = 'elettro', category = 'fisico', power = 130, accuracy = 85, pp = 5, gen = 5}
t.fuocoblu = {name = 'Fuocoblu', type = 'fuoco', category = 'speciale', power = 130, accuracy = 85, pp = 5, gen = 5}
t.voldifuoco = {name = 'Voldifuoco', type = 'fuoco', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 5}
t.elettrogelo = {name = 'Elettrogelo', type = 'ghiaccio', category = 'fisico', power = 140, accuracy = 90, pp = 5, gen = 5}
t.vampagelida = {name = 'Vampagelida', type = 'ghiaccio', category = 'speciale', power = 140, accuracy = 90, pp = 5, gen = 5}
t.urlorabbia = {name = 'Urlorabbia', type = 'buio', category = 'speciale', power = 55, accuracy = 95, pp = 15, gen = 5}
t.scagliagelo = {name = 'Scagliagelo', type = 'ghiaccio', category = 'fisico', power = 85, accuracy = 90, pp = 10, gen = 5}
t['generatore v'] = {name = 'Generatore V', type = 'fuoco', category = 'fisico', power = 180, accuracy = 95, pp = 5, gen = 5}
t.incrofiamma = {name = 'Incrofiamma', type = 'fuoco', category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 5}
t.incrotuono = {name = 'Incrotuono', type = 'elettro', category = 'fisico', power = 100, accuracy = 100, pp = 5, gen = 5}
t.schiacciatuffo = {name = 'Schiacciatuffo', type = 'lotta', category = 'fisico', power = {[6] = 80, [7] = 100}, accuracy = 95, pp = 10, gen = 6}
t.ribaltappeto = {name = 'Ribaltappeto', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.rutto = {name = 'Rutto', type = 'veleno', category = 'speciale', power = 120, accuracy = 90, pp = 10, gen = 6}
t.aracampo = {name = 'Aracampo', type = 'terra', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t['rete vischiosa'] = {name = 'Rete Vischiosa', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.pungiglione = {name = 'Pungiglione', type = 'coleottero', category = 'fisico', power = 50, accuracy = 100, pp = 25, gen = 6}
t.spettrotuffo = {name = 'Spettrotuffo', type = 'spettro', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 6}
t.halloween = {name = 'Halloween', type = 'spettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.urlo = {name = 'Urlo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 30, gen = 6}
t.pioggiaplasma = {name = 'Pioggiaplasma', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 25, gen = 6}
t.caricaparabola = {name = 'Caricaparabola', type = 'elettro', category = 'speciale', power = 65, accuracy = 100, pp = 20, gen = 6}
t.boscomalocchio = {name = 'Boscomalocchio', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.fiortempesta = {name = 'Fiortempesta', type = 'erba', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 6}
t.liofilizzazione = {name = 'Liofilizzazione', type = 'ghiaccio', category = 'speciale', power = 70, accuracy = 100, pp = 20, gen = 6}
t.incantavoce = {name = 'Incantavoce', type = 'folletto', category = 'speciale', power = 40, accuracy = '&mdash;', pp = 15, gen = 6}
t.monito = {name = 'Monito', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.sottosopra = {name = 'Sottosopra', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.assorbibacio = {name = 'Assorbibacio', type = 'folletto', category = 'speciale', power = 50, accuracy = 100, pp = 10, gen = 6}
t.truccodifesa = {name = 'Truccodifesa', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.fiordifesa = {name = 'Fiordifesa', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t['campo erboso'] = {name = 'Campo Erboso', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t['campo nebbioso'] = {name = 'Campo Nebbioso', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.elettrocontagio = {name = 'Elettrocontagio', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.carineria = {name = 'Carineria', type = 'folletto', category = 'fisico', power = 90, accuracy = 90, pp = 10, gen = 6}
t['vento di fata'] = {name = 'Vento di Fata', type = 'folletto', category = 'speciale', power = 40, accuracy = 100, pp = 30, gen = 6}
t['forza lunare'] = {name = 'Forza Lunare', type = 'folletto', category = 'speciale', power = 95, accuracy = 100, pp = 15, gen = 6}
t.ondaboato = {name = 'Ondaboato', type = 'normale', category = 'speciale', power = 140, accuracy = 100, pp = 10, gen = 6}
t['blocco fatato'] = {name = 'Blocco Fatato', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t['scudo reale'] = {name = 'Scudo Reale', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.simpatia = {name = 'Simpatia', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.confidenza = {name = 'Confidenza', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.diamantempesta = {name = 'Diamantempesta', type = 'roccia', category = 'fisico', power = 100, accuracy = 95, pp = 5, gen = 6}
t.vaporscoppio = {name = 'Vaporscoppio', type = 'acqua', category = 'speciale', power = 110, accuracy = 95, pp = 5, gen = 6}
t.forodimensionale = {name = 'Forodimensionale', type = 'psico', category = 'speciale', power = 80, accuracy = '&mdash;', pp = 5, gen = 6}
t.acqualame = {name = 'Acqualame', type = 'acqua', category = 'speciale', power = 15, accuracy = 100, pp = 20, gen = 6}
t.magifiamma = {name = 'Magifiamma', type = 'fuoco', category = 'speciale', power = 75, accuracy = 100, pp = 10, gen = 6}
t.agodifesa = {name = 'Agodifesa', type = 'erba', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.nebularoma = {name = 'Nebularoma', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.elettromistero = {name = 'Elettromistero', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 6}
t.velenotrappola = {name = 'Velenotrappola', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.pulviscoppio = {name = 'Pulviscoppio', type = 'coleottero', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 6}
t.geocontrollo = {name = 'Geocontrollo', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t['controllo polare'] = {name = 'Controllo Polare', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 6}
t.cuccagna = {name = 'Cuccagna', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 6}
t['campo elettrico'] = {name = 'Campo Elettrico', type = 'elettro', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 6}
t.magibrillio = {name = 'Magibrillio', type = 'folletto', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 6}
t.auguri = {name = 'Auguri', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 6}
t['mano nella mano'] = {name = 'Mano nella Mano', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 40, gen = 6}
t['occhioni teneri'] = {name = 'Occhioni Teneri', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = 100, pp = 30, gen = 6}
t.elettrococcola = {name = 'Elettrococcola', type = 'elettro', category = 'fisico', power = 20, accuracy = 100, pp = 20, gen = 6}
t.riguardo = {name = 'Riguardo', type = 'normale', category = 'fisico', power = 40, accuracy = 100, pp = 40, gen = 6}
t.assillo = {name = 'Assillo', type = 'coleottero', category = 'speciale', power = 20, accuracy = 100, pp = 20, gen = 6}
t.crescipugno = {name = 'Crescipugno', type = 'lotta', category = 'fisico', power = 40, accuracy = 100, pp = 20, gen = 6}
t['ali del fato'] = {name = 'Ali del Fato', type = 'volante', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 6}
t['mille frecce'] = {name = 'Mille Frecce', type = 'terra', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 6}
t['mille onde'] = {name = 'Mille Onde', type = 'terra', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 6}
t['forza tellurica'] = {name = 'Forza Tellurica', type = 'terra', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 6}
t['luce nefasta'] = {name = 'Luce Nefasta', type = 'folletto', category = 'speciale', power = 140, accuracy = 90, pp = 5, gen = 6}
t.primopulsar = {name = 'Primopulsar', type = 'acqua', category = 'speciale', power = 110, accuracy = 85, pp = 10, gen = 6}
t['spade telluriche'] = {name = 'Spade Telluriche', type = 'terra', category = 'fisico', power = 120, accuracy = 85, pp = 10, gen = 6}
t['ascesa del drago'] = {name = 'Ascesa del Drago', type = 'volante', category = 'fisico', power = 120, accuracy = 100, pp = 5, gen = 6}
t.urtodimensionale = {name = 'Urtodimensionale', type = 'buio', category = 'fisico', power = 100, accuracy = '&mdash;', pp = 5, gen = 6}
t.sabbiaccumulo = {name = 'Sabbiaccumulo', type = 'terra', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 7}
t.schermaglia = {name = 'Schermaglia', type = 'coleottero', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 7}
t.fortino = {name = 'Fortino', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 7}
t["cucitura d'ombra"] = {name = "Cucitura d'Ombra", type = 'spettro', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 7}
t.braccioteso = {name = 'Braccioteso', type = 'buio', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 7}
t['canto effimero'] = {name = 'Canto Effimero', type = 'acqua', category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 7}
t.martelgelo = {name = 'Martelgelo', type = 'ghiaccio', category = 'fisico', power = 100, accuracy = 90, pp = 10, gen = 7}
t['cura floreale'] = {name = 'Cura Floreale', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 7}
t['forza equina'] = {name = 'Forza Equina', type = 'terra', category = 'fisico', power = 95, accuracy = 95, pp = 10, gen = 7}
t.assorbiforza = {name = 'Assorbiforza', type = 'erba', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 7}
t['lama solare'] = {name = 'Lama Solare', type = 'erba', category = 'fisico', power = 125, accuracy = 100, pp = 10, gen = 7}
t.fogliame = {name = 'Fogliame', type = 'erba', category = 'fisico', power = 40, accuracy = 100, pp = 40, gen = 7}
t.riflettore = {name = 'Riflettore', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 7}
t.velenotela = {name = 'Velenotela', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 7}
t.concentrazione = {name = 'Concentrazione', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 30, gen = 7}
t['marciainpiù'] = {name = 'Marciainpiù', type = 'acciaio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 7}
t['colpo infernale'] = {name = 'Colpo Infernale', type = 'buio', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 7}
t.sferapolline = {name = 'Sferapolline', type = 'coleottero', category = 'speciale', power = 90, accuracy = 100, pp = 15, gen = 7}
t["colpo d'ancora"] = {name = "Colpo d'Ancora", type = 'acciaio', category = 'fisico', power = 80, accuracy = 100, pp = 20, gen = 7}
t['campo psichico'] = {name = 'Campo Psichico', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 7}
t.assalto = {name = 'Assalto', type = 'coleottero', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 7}
t['frusta di fuoco'] = {name = 'Frusta di Fuoco', type = 'fuoco', category = 'fisico', power = 80, accuracy = 100, pp = 15, gen = 7}
t.tracotanza = {name = 'Tracotanza', type = 'buio', category = 'fisico', power = 20, accuracy = 100, pp = 10, gen = 7}
t['ultima fiamma'] = {name = 'Ultima Fiamma', type = 'fuoco', category = 'speciale', power = 130, accuracy = 100, pp = 5, gen = 7}
t.velociscambio = {name = 'Velociscambio', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 7}
t.sottilcorno = {name = 'Sottilcorno', type = 'acciaio', category = 'fisico', power = 70, accuracy = '&mdash;', pp = 10, gen = 7}
t.purificazione = {name = 'Purificazione', type = 'veleno', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 7}
t.mutadanza = {name = 'Mutadanza', type = 'normale', category = 'speciale', power = 90, accuracy = 100, pp = 15, gen = 7}
t.nucleocastigo = {name = 'Nucleocastigo', type = 'drago', category = 'speciale', power = 100, accuracy = 100, pp = 10, gen = 7}
t.tropicalcio = {name = 'Tropicalcio', type = 'erba', category = 'fisico', power = 70, accuracy = 100, pp = 15, gen = 7}
t.imposizione = {name = 'Imposizione', type = 'psico', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 7}
t.cannonbecco = {name = 'Cannonbecco', type = 'Volante', category = 'fisico', power = 100, accuracy = 100, pp = 15, gen = 7}
t.clamorsquame = {name = 'Clamorsquame', type = 'drago', category = 'speciale', power = 110, accuracy = 100, pp = 5, gen = 7}
t.marteldrago = {name = 'Marteldrago', type = 'drago', category = 'fisico', power = 90, accuracy = 100, pp = 15, gen = 7}
t.vorticolpo = {name = 'Vorticolpo', type = 'buio', category = 'fisico', power = 60, accuracy = 100, pp = 20, gen = 7}
t.velaurora = {name = 'Velaurora', type = 'ghiaccio', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 7}
t.gusciotrappola = {name = 'Gusciotrappola', type = 'fuoco', category = 'speciale', power = 150, accuracy = 100, pp = 5, gen = 7}
t.cannonfiore = {name = 'Cannonfiore', type = 'folletto', category = 'speciale', power = 130, accuracy = 90, pp = 5, gen = 7}
t.psicozanna = {name = 'Psicozanna', type = 'psico', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 7}
t.battipiedi = {name = 'Battipiedi', type = 'terra', category = 'fisico', power = 75, accuracy = 100, pp = 10, gen = 7}
t.ossotetro = {name = 'Ossotetro', type = 'spettro', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 7}
t.rocciarapida = {name = 'Rocciarapida', type = 'roccia', category = 'fisico', power = 40, accuracy = 100, pp = 20, gen = 7}
t.idrobreccia = {name = 'Idrobreccia', type = 'acqua', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 7}
t.prismalaser = {name = 'Prismalaser', type = 'psico', category = 'speciale', power = 160, accuracy = 100, pp = 10, gen = 7}
t.ombrafurto = {name = 'Ombrafurto', type = 'spettro', category = 'fisico', power = 90, accuracy = 100, pp = 10, gen = 7}
t.astrocarica = {name = 'Astrocarica', type = 'acciaio', category = 'fisico', power = 100, accuracy = 100, pp = 5, gen = 7}
t["raggio d'ombra"] = {name = "Raggio d'Ombra", type = 'spettro', category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 7}
t.occhionilucidi = {name = 'Occhionilucidi', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 20, gen = 7}
t.elettropizzico = {name = 'Elettropizzico', type = 'elettro', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 7}
t['ira della natura'] = {name = "Ira della Natura", type = 'folletto', category = 'speciale', power = '&mdash;', accuracy = 90, pp = 10, gen = 7}
t.multiattacco = {name = 'Multiattacco', type = 'normale', category = 'fisico', power = {[7] = 90, [8] = 120}, accuracy = 100, pp = 10, gen = 7}
t['geyser fotonico'] = {name = 'Geyser Fotonico', type = 'psico', category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 7}
t['sbalorditesta'] = {name = 'Sbalorditesta', type = 'fuoco', category = 'speciale', power = 150, accuracy = 100, pp = 5, gen = 7}
t['pugni plasma'] = {name = 'Pugni Plasma', type = 'elettro', category = 'fisico', power = 100, accuracy = 100, pp = 15, gen = 7}
t['pugni corazzati'] = {name = 'Pugni Corazzati', type = 'acciaio', category = 'fisico', power = 60, accuracy = 100, pp = 5, gen = 7}
-- New moves, TODO: check
t.dynabarriera = {name = 'DynaBarriera', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t['cannone dynamax'] = {name = 'Cannone Dynamax', type = 'drago', category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 8}
t.tiromirato = {name = 'Tiromirato', type = 'acqua', category = 'speciale', power = 80, accuracy = 100, pp = 15, gen = 8}
t.morsostretto = {name = 'Morsostretto', type = 'buio', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 8}
t.riempiguance = {name = 'Riempiguance', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t['spalle al muro'] = {name = 'Spalle al Muro', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 5, gen = 8}
t.colpocatrame = {name = 'Colpocatrame', type = 'roccia', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 8}
t.magipolvere = {name = 'Magipolvere', type = 'psico', category = 'stato', power = '&mdash;', accuracy = 100, pp = 20, gen = 8}
t.dragofrecce = {name = 'Dragofrecce', type = 'drago', category = 'fisico', power = 50, accuracy = 100, pp = 10, gen = 8}
t['ora del tè'] = {name = 'Ora del Tè', type = 'normale', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t.tentacolock = {name = 'Tentacolock', type = 'lotta', category = 'stato', power = '&mdash;', accuracy = 100, pp = 15, gen = 8}
t.beccoshock = {name = 'Beccoshock', type = 'elettro', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 8}
t.branchiomorso = {name = 'Branchiomorso', type = 'acqua', category = 'fisico', power = 85, accuracy = 100, pp = 10, gen = 8}
t.cambiocampo = {name = 'Cambiocampo', type = 'normale', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 8}
t.dynafiammata = {name = 'Dynafiammata', type = 'fuoco', category = 'fisico', power = 100, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynainsetto = {name = 'Dynainsetto', type = 'coleottero', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynasaetta = {name = 'Dynasaetta', type = 'elettro', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynattacco = {name = 'Dynattacco', type = 'normale', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynapugno = {name = 'Dynapugno', type = 'lotta', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynavuoto = {name = 'Dynavuoto', type = 'spettro', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynagelo = {name = 'Dynagelo', type = 'ghiaccio', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynacorrosione = {name = 'Dynacorrosione', type = 'veleno', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynaflusso = {name = 'Dynaflusso', type = 'acqua', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynajet = {name = 'Dynajet', type = 'volante', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynafata = {name = 'Dynafata', type = 'folletto', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynadragone = {name = 'Dynadragone', type = 'drago', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynapsiche = {name = 'Dynapsiche', type = 'psico', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynamacigno = {name = 'Dynamacigno', type = 'roccia', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynasisma = {name = 'Dynasisma', type = 'terra', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynatenebre = {name = 'Dynatenebre', type = 'buio', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynaflora = {name = 'Dynaflora', type = 'erba', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dynametallo = {name = 'Dynametallo', type = 'acciaio', category = 'fisico', power = 10, accuracy = '&mdash;', pp = 10, gen = 8}
t.dracofonia = {name = 'Dracofonia', type = 'drago', category = 'stato', power = '&mdash;', accuracy = 100, pp = 5, gen = 8}
t.schiacciacorpo = {name = 'Schiacciacorpo', type = 'lotta', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 8}
t.decorazione = {name = 'Decorazione', type = 'folletto', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 15, gen = 8}
t.tamburattacco = {name = 'Tamburattacco', type = 'erba', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 8}
t.tagliola = {name = 'Tagliola', type = 'erba', category = 'fisico', power = 35, accuracy = 100, pp = 15, gen = 8}
t['palla infuocata'] = {name = 'Palla Infuocata', type = 'fuoco', category = 'fisico', power = 120, accuracy = 90, pp = 5, gen = 8}
t['taglio maestoso'] = {name = 'Taglio Maestoso', type = 'acciaio', category = 'fisico', power = 100, accuracy = 100, pp = 5, gen = 8}
t['colpo maestoso'] = {name = 'Colpo Maestoso', type = 'acciaio', category = 'fisico', power = 100, accuracy = 100, pp = 5, gen = 8}
t["ruota d'aura"] = {name = "Ruota d'Aura", type = 'elettro', category = 'fisico', power = 110, accuracy = 100, pp = 10, gen = 8}
t.vastoimpatto = {name = 'Vastoimpatto', type = 'drago', category = 'fisico', power = 60, accuracy = 100, pp = 15, gen = 8}
t.ramostoccata = {name = 'Ramostoccata', type = 'erba', category = 'fisico', power = 40, accuracy = 100, pp = 40, gen = 8}
t.overdrive = {name = 'Overdrive', type = 'elettro', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 8}
t['acido malico'] = {name = 'Acido Malico', type = 'erba', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 8}
t['forza g'] = {name = 'Forza G', type = 'erba', category = 'fisico', power = 80, accuracy = 100, pp = 10, gen = 8}
t.frantumanima = {name = 'Frantumanima', type = 'folletto', category = 'fisico', power = 75, accuracy = 100, pp = 15, gen = 8}
t['vapore incantato'] = {name = 'Vapore Incantato', type = 'folletto', category = 'speciale', power = 90, accuracy = 95, pp = 10, gen = 8}
t['goccia vitale'] = {name = 'Goccia Vitale', type = 'acqua', category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t.sbarramento = {name = 'Sbarramento', type = 'buio', category = 'stato', power = '&mdash;', accuracy = 100, pp = 10, gen = 8}
t.supplicolpo = {name = 'Supplicolpo', type = 'buio', category = 'fisico', power = 80, accuracy = '&mdash;', pp = 10, gen = 8}
t.sfolgorassalto = {name = 'Sfolgorassalto', type = 'lotta', category = 'fisico', power = 150, accuracy = 100, pp = 5, gen = 8}
t['raggio infinito'] = {name = 'Raggio Infinito', type = 'drago', category = 'speciale', power = 160, accuracy = 90, pp = 5, gen = 8}
t["raggio d'acciaio"] = {name = "Raggio d'Acciaio", type = 'acciaio', category = 'speciale', power = 140, accuracy = 95, pp = 5, gen = 8}
t.vastenergia = {name = "Vastenergia", type = 'psico', category = 'speciale', power = 80, accuracy = 100, pp = 10, gen = 8}
t.ferrorullo = {name = "Ferrorullo", type = "acciaio", category = 'fisico', power = 130, accuracy = 100, pp = 5, gen = 8}
t.squamacolpo = {name = "Squamacolpo", type = "drago", category = 'fisico', power = 25, accuracy = 90, pp = 20, gen = 8}
t.raggiometeora = {name = "Raggiometeora", type = "roccia", category = 'speciale', power = 120, accuracy = 90, pp = 10, gen = 8}
t.armaguscio = {name = "Armaguscio", type = "veleno", category = 'speciale', power = 90, accuracy = 100, pp = 10, gen = 8}
t.nebbioscoppio = {name = "Nebbioscoppio", type = "folletto", category = 'speciale', power = 100, accuracy = 100, pp = 5, gen = 8}
t.erboscivolata = {name = "Erboscivolata", type = "erba", category = 'fisico', power = 70, accuracy = 100, pp = 20, gen = 8}
t.elettroimpennata = {name = "Elettroimpennata", type = "elettro", category = 'speciale', power = 70, accuracy = 100, pp = 20, gen = 8}
t.campopulsar = {name = "Campopulsar", type = "normale", category = 'speciale', power = 50, accuracy = 100, pp = 10, gen = 8}
t.strisciacolpo = {name = "Strisciacolpo", type = "coleottero", category = 'fisico', power = 70, accuracy = 90, pp = 10, gen = 8}
t.fiamminvidia = {name = "Fiamminvidia", type = "fuoco", category = 'speciale', power = 70, accuracy = 100, pp = 5, gen = 8}
t.sfogarabbia = {name = "Sfogarabbia", type = "buio", category = 'fisico', power = 75, accuracy = 100, pp = 5, gen = 8}
t.poltergeist = {name = "Poltergeist", type = "spettro", category = 'fisico', power = 110, accuracy = 90, pp = 5, gen = 8}
t['gas corrosivo'] = {name = "Gas Corrosivo", type = "veleno", category = 'stato', power = '&mdash;', accuracy = 100, pp = 40, gen = 8}
t.coaching = {name = "Coaching", type = "lotta", category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t.virata = {name = "Virata", type = "acqua", category = 'fisico', power = 60, accuracy = 100, pp = 20, gen = 8}
t['triplo axel'] = {name = "Triplo Axel", type = "ghiaccio", category = 'fisico', power = 20, accuracy = 90, pp = 10, gen = 8}
t['doppia ala'] = {name = "Doppia Ala", type = "volante", category = 'fisico', power = 40, accuracy = 90, pp = 10, gen = 8}
t.sabbiardente = {name = "Sabbiardente", type = "terra", category = 'speciale', power = 70, accuracy = 100, pp = 10, gen = 8}
t.giunglacura = {name = "Giunglacura", type = "erba", category = 'stato', power = '&mdash;', accuracy = '&mdash;', pp = 10, gen = 8}
t.pugnotenebra = {name = "Pugnotenebra", type = "buio", category = 'fisico', power = 80, accuracy = 100, pp = 5, gen = 8}
t.idroraffica = {name = "Idroraffica", type = "acqua", category = 'fisico', power = 25, accuracy = 100, pp = 5, gen = 8}
-- Incomplete moves
t.elettrogabbia = {name = "Elettrogabbia", type = "elettro", category = "speciale", power = "80", accuracy = "90", pp = "15", gen = 8}
t.dragoenergia = {name = "Dragoenergia", type = "drago", category = "speciale", power = "&mdash;", accuracy = "100", pp = "5", gen = 8}
t["sguardo gelido"] = {name = "Sguardo Gelido", type = "psico", category = "speciale", power = "90", accuracy = "100", pp = "10", gen = 8}
t["calcio tonante"] = {name = "Calcio Tonante", type = "lotta", category = "fisico", power = "90", accuracy = "100", pp = "10", gen = 8}
t["furia ardente"] = {name = "Furia Ardente", type = "buio", category = "speciale", power = "90", accuracy = "100", pp = "10", gen = 8}
t.inquietantesimo = {name = "Inquietantesimo", type = "psico", category = "speciale", power = "80", accuracy = "100", pp = "5", gen = 8}
t["lancia glaciale"] = {name = "Lancia Glaciale", type = "ghiaccio", category = "fisico", power = "130", accuracy = "100", pp = "5", gen = 8}
t["schegge astrali"] = {name = "Schegge Astrali", type = "spettro", category = "speciale", power = "120", accuracy = "100", pp = "5", gen = 8}

-- Stats here are completely random, just to have them and make the module work
t["artigli fatali"] = {name = "Artigli Fatali", type = "veleno", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["barrierassalto"] = {name = "Barrierassalto", type = "psico", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["scambioforza"] = {name = "Scambioforza", type = "normale", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["rocciascure"] = {name = "Rocciascure", type = "roccia", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["tempesta zefirea"] = {name = "Tempesta Zefirea", type = "folletto", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["forza mistica"] = {name = "Forza Mistica", type = "psico", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["ira furente"] = {name = "Ira Furente", type = "fuoco", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["ondaschianto"] = {name = "Ondaschianto", type = "acqua", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["clorofillaser"] = {name = "Clorofillaser", type = "erba", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["soffio d'iceberg"] = {name = "Soffio d'Iceberg", type = "ghiaccio", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["danzavittoria"] = {name = "Danzavittoria", type = "lotta", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["scontro frontale"] = {name = "Scontro Frontale", type = "terra", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["mille fielespine"] = {name = "Mille Fielespine", type = "veleno", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["ali d'aura"] = {name = "Ali d'Aura", type = "psico", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["livore"] = {name = "Livore", type = "spettro", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["barricata"] = {name = "Barricata", type = "acciaio", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["triplodardo"] = {name = "Triplodardo", type = "lotta", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["corteo spettrale"] = {name = "Corteo Spettrale", type = "spettro", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["lama milleflutti"] = {name = "Lama Milleflutti", type = "buio", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["tempesta boreale"] = {name = "Tempesta Boreale", type = "volante", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["tempesta tonante"] = {name = "Tempesta Tonante", type = "elettro", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["tempesta ardente"] = {name = "Tempesta Ardente", type = "terra", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["invocaluna"] = {name = "Invocaluna", type = "psico", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}
t["baldimpulso"] = {name = "Baldimpulso", type = "psico", category = "fisico", power = "10", accuracy = "100", pp = "10", gen = "8"}

return t
