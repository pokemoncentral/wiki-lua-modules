-- Data module for moves in LPA

-- TODO: not all moves are introduced in gen 8, but in a sense their LPA
-- version is. What to do?

local t = {}

t["fuocopugno"] = {name = "Fuocopugno", type = "fuoco", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["gelopugno"] = {name = "Gelopugno", type = "ghiaccio", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["tuonopugno"] = {name = "Tuonopugno", type = "elettro", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["danzaspada"] = {name = "Danzaspada", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["raffica"] = {name = "Raffica", type = "volante", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["azione"] = {name = "Azione", type = "normale", category = "fisico", power = 40, accuracy = 100, pp = 30, gen = 8}
t["sdoppiatore"] = {name = "Sdoppiatore", type = "normale", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["velenospina"] = {name = "Velenospina", type = "veleno", category = "fisico", power = 30, accuracy = 100, pp = 20, gen = 8}
t["missilspillo"] = {name = "Missilspillo", type = "coleottero", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["morso"] = {name = "Morso", type = "buio", category = "fisico", power = 60, accuracy = 100, pp = 20, gen = 8}
t["braciere"] = {name = "Braciere", type = "fuoco", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["lanciafiamme"] = {name = "Lanciafiamme", type = "fuoco", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["idropompa"] = {name = "Idropompa", type = "acqua", category = "speciale", power = 100, accuracy = 85, pp = 5, gen = 8}
t["geloraggio"] = {name = "Geloraggio", type = "ghiaccio", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["bora"] = {name = "Bora", type = "ghiaccio", category = "speciale", power = 100, accuracy = 75, pp = 5, gen = 8}
t["iper raggio"] = {name = "Iper Raggio", type = "normale", category = "speciale", power = 120, accuracy = 90, pp = 5, gen = 8}
t["assorbimento"] = {name = "Assorbimento", type = "erba", category = "speciale", power = 30, accuracy = 100, pp = 20, gen = 8}
t["velenpolvere"] = {name = "Velenpolvere", type = "veleno", category = "stato", power = "&mdash;", accuracy = 80, pp = 20, gen = 8}
t["paralizzante"] = {name = "Paralizzante", type = "erba", category = "stato", power = "&mdash;", accuracy = 80, pp = 20, gen = 8}
t["sonnifero"] = {name = "Sonnifero", type = "erba", category = "stato", power = "&mdash;", accuracy = 80, pp = 20, gen = 8}
t["petalodanza"] = {name = "Petalodanza", type = "erba", category = "speciale", power = 90, accuracy = 85, pp = 10, gen = 8}
t["tuonoshock"] = {name = "Tuonoshock", type = "elettro", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["fulmine"] = {name = "Fulmine", type = "elettro", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["tuononda"] = {name = "Tuononda", type = "elettro", category = "stato", power = "&mdash;", accuracy = 90, pp = 20, gen = 8}
t["tuono"] = {name = "Tuono", type = "elettro", category = "speciale", power = 100, accuracy = 75, pp = 5, gen = 8}
t["confusione"] = {name = "Confusione", type = "psico", category = "speciale", power = 50, accuracy = 100, pp = 20, gen = 8}
t["psichico"] = {name = "Psichico", type = "psico", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["ipnosi"] = {name = "Ipnosi", type = "psico", category = "stato", power = "&mdash;", accuracy = 70, pp = 20, gen = 8}
t["attacco rapido"] = {name = "Attacco Rapido", type = "normale", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["teletrasporto"] = {name = "Teletrasporto", type = "psico", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["mimica"] = {name = "Mimica", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["ripresa"] = {name = "Ripresa", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["focalenergia"] = {name = "Focalenergia", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["autodistruzione"] = {name = "Autodistruzione", type = "normale", category = "fisico", power = 150, accuracy = 100, pp = 5, gen = 8}
t["fuocobomba"] = {name = "Fuocobomba", type = "fuoco", category = "speciale", power = 100, accuracy = 85, pp = 5, gen = 8}
t["comete"] = {name = "Comete", type = "normale", category = "speciale", power = 60, accuracy = "&mdash;", pp = 20, gen = 8}
t["covauova"] = {name = "Covauova", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["velenogas"] = {name = "Velenogas", type = "veleno", category = "stato", power = "&mdash;", accuracy = 90, pp = 20, gen = 8}
t["sanguisuga"] = {name = "Sanguisuga", type = "coleottero", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["bolla"] = {name = "Bolla", type = "acqua", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["spora"] = {name = "Spora", type = "erba", category = "stato", power = "&mdash;", accuracy = 100, pp = 10, gen = 8}
t["splash"] = {name = "Splash", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 40, gen = 8}
t["scudo acido"] = {name = "Scudo Acido", type = "veleno", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["riposo"] = {name = "Riposo", type = "psico", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["frana"] = {name = "Frana", type = "roccia", category = "fisico", power = 75, accuracy = 90, pp = 10, gen = 8}
t["tripletta"] = {name = "Tripletta", type = "normale", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["lacerazione"] = {name = "Lacerazione", type = "normale", category = "fisico", power = 70, accuracy = 100, pp = 15, gen = 8}
t["scontro"] = {name = "Scontro", type = "normale", category = "fisico", power = 50, accuracy = "&mdash;", pp = 1, gen = 8}
t["ruotafuoco"] = {name = "Ruotafuoco", type = "fuoco", category = "fisico", power = 60, accuracy = 100, pp = 20, gen = 8}
t["polneve"] = {name = "Polneve", type = "ghiaccio", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["pugnorapido"] = {name = "Pugnorapido", type = "lotta", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["fangobomba"] = {name = "Fangobomba", type = "veleno", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["fangosberla"] = {name = "Fangosberla", type = "terra", category = "speciale", power = 30, accuracy = 100, pp = 20, gen = 8}
t["octazooka"] = {name = "Octazooka", type = "acqua", category = "speciale", power = 65, accuracy = 85, pp = 15, gen = 8}
t["punte"] = {name = "Punte", type = "terra", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["ventogelato"] = {name = "Ventogelato", type = "ghiaccio", category = "speciale", power = 60, accuracy = 95, pp = 20, gen = 8}
t["oltraggio"] = {name = "Oltraggio", type = "drago", category = "fisico", power = 90, accuracy = 85, pp = 10, gen = 8}
t["rotolamento"] = {name = "Rotolamento", type = "roccia", category = "fisico", power = 40, accuracy = 90, pp = 20, gen = 8}
t["falsofinale"] = {name = "Falsofinale", type = "normale", category = "fisico", power = 40, accuracy = 100, pp = 30, gen = 8}
t["scintilla"] = {name = "Scintilla", type = "elettro", category = "fisico", power = 65, accuracy = 100, pp = 20, gen = 8}
t["megacorno"] = {name = "Megacorno", type = "coleottero", category = "fisico", power = 100, accuracy = 85, pp = 5, gen = 8}
t["codacciaio"] = {name = "Codacciaio", type = "acciaio", category = "fisico", power = 100, accuracy = 75, pp = 5, gen = 8}
t["introforza"] = {name = "Introforza", type = "normale", category = "speciale", power = 50, accuracy = 100, pp = 15, gen = 8}
t["tornado"] = {name = "Tornado", type = "drago", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["sgranocchio"] = {name = "Sgranocchio", type = "buio", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["forzantica"] = {name = "Forzantica", type = "roccia", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["palla ombra"] = {name = "Palla Ombra", type = "spettro", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["spaccaroccia"] = {name = "Spaccaroccia", type = "lotta", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["palla gelo"] = {name = "Palla Gelo", type = "ghiaccio", category = "fisico", power = 40, accuracy = 90, pp = 20, gen = 8}
t["sgomento"] = {name = "Sgomento", type = "spettro", category = "fisico", power = 30, accuracy = 100, pp = 25, gen = 8}
t["aerasoio"] = {name = "Aerasoio", type = "volante", category = "speciale", power = 60, accuracy = 95, pp = 15, gen = 8}
t["vampata"] = {name = "Vampata", type = "fuoco", category = "speciale", power = 110, accuracy = 90, pp = 5, gen = 8}
t["ventargenteo"] = {name = "Ventargenteo", type = "coleottero", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["extrasenso"] = {name = "Extrasenso", type = "psico", category = "speciale", power = 70, accuracy = 100, pp = 15, gen = 8}
t["aeroassalto"] = {name = "Aeroassalto", type = "volante", category = "fisico", power = 60, accuracy = "&mdash;", pp = 20, gen = 8}
t["ferroscudo"] = {name = "Ferroscudo", type = "acciaio", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["dragartigli"] = {name = "Dragartigli", type = "drago", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["granfisico"] = {name = "Granfisico", type = "lotta", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["locomovolt"] = {name = "Locomovolt", type = "elettro", category = "fisico", power = 120, accuracy = 100, pp = 5, gen = 8}
t["fogliamagica"] = {name = "Fogliamagica", type = "erba", category = "speciale", power = 60, accuracy = "&mdash;", pp = 20, gen = 8}
t["calmamente"] = {name = "Calmamente", type = "psico", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["fendifoglia"] = {name = "Fendifoglia", type = "erba", category = "fisico", power = 85, accuracy = 100, pp = 10, gen = 8}
t["idropulsar"] = {name = "Idropulsar", type = "acqua", category = "speciale", power = 60, accuracy = "&mdash;", pp = 20, gen = 8}
t["trespolo"] = {name = "Trespolo", type = "volante", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["zuffa"] = {name = "Zuffa", type = "lotta", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["fuococarica"] = {name = "Fuococarica", type = "fuoco", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["forzasfera"] = {name = "Forzasfera", type = "lotta", category = "speciale", power = 80, accuracy = "&mdash;", pp = 10, gen = 8}
t["velenpuntura"] = {name = "Velenpuntura", type = "veleno", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["neropulsar"] = {name = "Neropulsar", type = "buio", category = "speciale", power = 80, accuracy = "&mdash;", pp = 10, gen = 8}
t["nottesferza"] = {name = "Nottesferza", type = "buio", category = "fisico", power = 70, accuracy = 100, pp = 15, gen = 8}
t["idrondata"] = {name = "Idrondata", type = "acqua", category = "fisico", power = 85, accuracy = 90, pp = 10, gen = 8}
t["eterelama"] = {name = "Eterelama", type = "volante", category = "speciale", power = 75, accuracy = 95, pp = 10, gen = 8}
t["forbice x"] = {name = "Forbice X", type = "coleottero", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["ronzio"] = {name = "Ronzio", type = "coleottero", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["dragopulsar"] = {name = "Dragopulsar", type = "drago", category = "speciale", power = 80, accuracy = "&mdash;", pp = 10, gen = 8}
t["gemmoforza"] = {name = "Gemmoforza", type = "roccia", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["assorbipugno"] = {name = "Assorbipugno", type = "lotta", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["energipalla"] = {name = "Energipalla", type = "erba", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["baldeali"] = {name = "Baldeali", type = "volante", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["geoforza"] = {name = "Geoforza", type = "terra", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["gigaimpatto"] = {name = "Gigaimpatto", type = "normale", category = "fisico", power = 120, accuracy = 90, pp = 5, gen = 8}
t["congiura"] = {name = "Congiura", type = "buio", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 20, gen = 8}
t["pugnoscarica"] = {name = "Pugnoscarica", type = "acciaio", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["geloscheggia"] = {name = "Geloscheggia", type = "ghiaccio", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["ombrartigli"] = {name = "Ombrartigli", type = "spettro", category = "fisico", power = 70, accuracy = 100, pp = 15, gen = 8}
t["fulmindenti"] = {name = "Fulmindenti", type = "elettro", category = "fisico", power = 65, accuracy = 95, pp = 15, gen = 8}
t["gelodenti"] = {name = "Gelodenti", type = "ghiaccio", category = "fisico", power = 65, accuracy = 95, pp = 15, gen = 8}
t["rogodenti"] = {name = "Rogodenti", type = "fuoco", category = "fisico", power = 65, accuracy = 95, pp = 15, gen = 8}
t["furtivombra"] = {name = "Furtivombra", type = "spettro", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["pantanobomba"] = {name = "Pantanobomba", type = "terra", category = "speciale", power = 65, accuracy = 85, pp = 15, gen = 8}
t["psicotaglio"] = {name = "Psicotaglio", type = "psico", category = "fisico", power = 70, accuracy = 100, pp = 15, gen = 8}
t["cozzata zen"] = {name = "Cozzata Zen", type = "psico", category = "fisico", power = 80, accuracy = 90, pp = 10, gen = 8}
t["cannonflash"] = {name = "Cannonflash", type = "acciaio", category = "speciale", power = 80, accuracy = 100, pp = 10, gen = 8}
t["dragobolide"] = {name = "Dragobolide", type = "drago", category = "speciale", power = 110, accuracy = 90, pp = 5, gen = 8}
t["verdebufera"] = {name = "Verdebufera", type = "erba", category = "speciale", power = 110, accuracy = 90, pp = 5, gen = 8}
t["velenocroce"] = {name = "Velenocroce", type = "veleno", category = "fisico", power = 70, accuracy = 100, pp = 15, gen = 8}
t["metaltestata"] = {name = "Metaltestata", type = "acciaio", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["pietrataglio"] = {name = "Pietrataglio", type = "roccia", category = "fisico", power = 100, accuracy = 80, pp = 5, gen = 8}
t["levitoroccia"] = {name = "Levitoroccia", type = "roccia", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["giudizio"] = {name = "Giudizio", type = "normale", category = "speciale", power = 100, accuracy = 100, pp = 5, gen = 8}
t["raggioscossa"] = {name = "Raggioscossa", type = "elettro", category = "speciale", power = 50, accuracy = 90, pp = 15, gen = 8}
t["mazzuolegno"] = {name = "Mazzuolegno", type = "erba", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["acquagetto"] = {name = "Acquagetto", type = "acqua", category = "fisico", power = 40, accuracy = 100, pp = 20, gen = 8}
t["zuccata"] = {name = "Zuccata", type = "roccia", category = "fisico", power = 120, accuracy = 80, pp = 5, gen = 8}
t["doppiosmash"] = {name = "Doppiosmash", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["fragortempo"] = {name = "Fragortempo", type = "drago", category = "speciale", power = 120, accuracy = 90, pp = 5, gen = 8}
t["fendispazio"] = {name = "Fendispazio", type = "drago", category = "speciale", power = 90, accuracy = 95, pp = 5, gen = 8}
t["sbriciolmano"] = {name = "Sbriciolmano", type = "normale", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["magmaclisma"] = {name = "Magmaclisma", type = "fuoco", category = "speciale", power = 90, accuracy = 75, pp = 5, gen = 8}
t["vuototetro"] = {name = "Vuototetro", type = "buio", category = "stato", power = "&mdash;", accuracy = 90, pp = 10, gen = 8}
t["infuriaseme"] = {name = "Infuriaseme", type = "erba", category = "speciale", power = 100, accuracy = 85, pp = 5, gen = 8}
t["funestovento"] = {name = "Funestovento", type = "spettro", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["oscurotuffo"] = {name = "Oscurotuffo", type = "spettro", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["velenoshock"] = {name = "Velenoshock", type = "veleno", category = "speciale", power = 65, accuracy = 100, pp = 15, gen = 8}
t["acidobomba"] = {name = "Acidobomba", type = "veleno", category = "speciale", power = 40, accuracy = 100, pp = 20, gen = 8}
t["sciagura"] = {name = "Sciagura", type = "spettro", category = "speciale", power = 65, accuracy = 100, pp = 15, gen = 8}
t["entomoblocco"] = {name = "Entomoblocco", type = "coleottero", category = "speciale", power = 40, accuracy = 100, pp = 20, gen = 8}
t["battiterra"] = {name = "Battiterra", type = "terra", category = "fisico", power = 60, accuracy = 100, pp = 20, gen = 8}
t["sprizzalampo"] = {name = "Sprizzalampo", type = "elettro", category = "fisico", power = 85, accuracy = 100, pp = 10, gen = 8}
t["tifone"] = {name = "Tifone", type = "volante", category = "speciale", power = 100, accuracy = 75, pp = 5, gen = 8}
t["urlorabbia"] = {name = "Urlorabbia", type = "buio", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["scagliagelo"] = {name = "Scagliagelo", type = "ghiaccio", category = "fisico", power = 80, accuracy = 90, pp = 10, gen = 8}
t["assorbibacio"] = {name = "Assorbibacio", type = "folletto", category = "speciale", power = 50, accuracy = 100, pp = 15, gen = 8}
t["carineria"] = {name = "Carineria", type = "folletto", category = "fisico", power = 85, accuracy = 90, pp = 10, gen = 8}
t["vento di fata"] = {name = "Vento di Fata", type = "folletto", category = "speciale", power = 40, accuracy = 100, pp = 25, gen = 8}
t["forza lunare"] = {name = "Forza Lunare", type = "folletto", category = "speciale", power = 85, accuracy = 100, pp = 10, gen = 8}
t["magifiamma"] = {name = "Magifiamma", type = "fuoco", category = "speciale", power = 70, accuracy = 100, pp = 10, gen = 8}
t["magibrillio"] = {name = "Magibrillio", type = "folletto", category = "speciale", power = 75, accuracy = 100, pp = 10, gen = 8}
t["occhioni teneri"] = {name = "Occhioni Teneri", type = "folletto", category = "stato", power = "&mdash;", accuracy = 100, pp = 20, gen = 8}
t["forza equina"] = {name = "Forza Equina", type = "terra", category = "fisico", power = 85, accuracy = 95, pp = 10, gen = 8}
t["fogliame"] = {name = "Fogliame", type = "erba", category = "fisico", power = 40, accuracy = 100, pp = 25, gen = 8}
t["idrobreccia"] = {name = "Idrobreccia", type = "acqua", category = "fisico", power = 80, accuracy = 100, pp = 10, gen = 8}
t["raggio d'acciaio"] = {name = "Raggio d'Acciaio", type = "acciaio", category = "speciale", power = 120, accuracy = 95, pp = 5, gen = 8}
t["artigli fatali"] = {name = "Artigli Fatali", type = "veleno", category = "fisico", power = 60, accuracy = 100, pp = 15, gen = 8}
t["barrierassalto"] = {name = "Barrierassalto", type = "psico", category = "fisico", power = 70, accuracy = 90, pp = 10, gen = 8}
t["scambioforza"] = {name = "Scambioforza", type = "normale", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["rocciascure"] = {name = "Rocciascure", type = "roccia", category = "fisico", power = 65, accuracy = 90, pp = 15, gen = 8}
t["tempesta zefirea"] = {name = "Tempesta Zefirea", type = "folletto", category = "speciale", power = 95, accuracy = 80, pp = 5, gen = 8}
t["forza mistica"] = {name = "Forza Mistica", type = "psico", category = "speciale", power = 70, accuracy = 90, pp = 10, gen = 8}
t["ira furente"] = {name = "Ira Furente", type = "fuoco", category = "fisico", power = 90, accuracy = 85, pp = 10, gen = 8}
t["ondaschianto"] = {name = "Ondaschianto", type = "acqua", category = "fisico", power = 75, accuracy = 100, pp = 10, gen = 8}
t["clorofillaser"] = {name = "Clorofillaser", type = "erba", category = "speciale", power = 120, accuracy = 95, pp = 5, gen = 8}
t["soffio d'iceberg"] = {name = "Soffio d'Iceberg", type = "ghiaccio", category = "fisico", power = 100, accuracy = 85, pp = 5, gen = 8}
t["danzavittoria"] = {name = "Danzavittoria", type = "lotta", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["scontro frontale"] = {name = "Scontro Frontale", type = "terra", category = "fisico", power = 100, accuracy = 100, pp = 5, gen = 8}
t["mille fielespine"] = {name = "Mille Fielespine", type = "veleno", category = "fisico", power = 60, accuracy = 100, pp = 15, gen = 8}
t["ali d'aura"] = {name = "Ali d'Aura", type = "psico", category = "speciale", power = 75, accuracy = 90, pp = 10, gen = 8}
t["livore"] = {name = "Livore", type = "spettro", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["barricata"] = {name = "Barricata", type = "acciaio", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["triplodardo"] = {name = "Triplodardo", type = "lotta", category = "fisico", power = 50, accuracy = 100, pp = 15, gen = 8}
t["corteo spettrale"] = {name = "Corteo Spettrale", type = "spettro", category = "speciale", power = 60, accuracy = 100, pp = 15, gen = 8}
t["lama milleflutti"] = {name = "Lama Milleflutti", type = "buio", category = "fisico", power = 65, accuracy = 90, pp = 15, gen = 8}
t["tempesta boreale"] = {name = "Tempesta Boreale", type = "volante", category = "speciale", power = 95, accuracy = 80, pp = 5, gen = 8}
t["tempesta tonante"] = {name = "Tempesta Tonante", type = "elettro", category = "speciale", power = 95, accuracy = 80, pp = 5, gen = 8}
t["tempesta ardente"] = {name = "Tempesta Ardente", type = "terra", category = "speciale", power = 95, accuracy = 80, pp = 5, gen = 8}
t["invocaluna"] = {name = "Invocaluna", type = "psico", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}
t["baldimpulso"] = {name = "Baldimpulso", type = "psico", category = "stato", power = "&mdash;", accuracy = "&mdash;", pp = 10, gen = 8}

return t
