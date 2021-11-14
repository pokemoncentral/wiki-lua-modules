local render = require('Render')
local header = require('Learnlist-hf')
local mw = require('mw')

-- ============================ Gen 8 ============================
mw.title.setTitle("Zacian")
print(header.levelh{args={"Zacian", "folletto", "folletto", "8", "8" }})
print(render.render{args={"Learnlist-entry8", "level", "//",
"Anticipo", "", "", "Inizio", "Inizio", "//",
"Attacco Rapido", "", "", "Inizio", "Inizio", "//",
"Ferrartigli", "''", "", "Inizio", "Inizio", "//",
"Gridodilotta", "", "", "Inizio", "Inizio", "//",
"Morso", "", "", "Inizio", "4", "//",
"Spadasolenne", "", "", "Inizio", "5", "//",
"Lacerazione", "", "", "11", "11", "//",
"Danzaspada", "", "", "22", "33", "//",
"Metaltestata", "''", "", "33", "34", "//",
"Concentrazione", "", "", "44", "5", "//",
"Sgranocchio", "", "", "55", "6", "//",
"Forza Lunare", "'''", "", "66", "7", "//",
"Zuffa", "", "", "77", "8", "//",
"Gigaimpatto", "", "", "88", "88", "//",
"Surf", "", "", "2", "88", "//"}})
print(header.levelf{args={"Zacian", "folletto", "folletto", "8", "8" }})

mw.title.setTitle("Marshadow")
print(header.tmh{args={"Marshadow", "spettro", "lotta", "8", "7" }})
print(render.render{args={"Learnlist-entry8", "tm", "//",
"Fascino", "", "", "MT29", "", "//",
"Velociscambio", "", "", "no", "MT123", "//",
"Scalaroccia", "", "", "", "", "//",
"Lanciafiamme", "", "", "", "", "//"}})
print(header.tmf{args={"Marshadow", "spettro", "lotta", "8", "7" }})


print(header.tutorh{args={"Marshadow", "spettro", "lotta", "8", "7" }})
print(render.entry{args={"Learnlist-entry8.tutor",
"[[€Coaching|||yes|yes£]]",
"[[€Strisciacolpo|||no|yes£]]",
"[[€Poltergeist|no||no|yes£]]",
}})
print(header.tutorf{args={"Marshadow", "spettro", "lotta", "8", "7" }})


mw.title.setTitle("Marshadow")
print(header.preevoh{args={"Marshadow", "spettro", "lotta", "8", "7" }})
print(render.entry{args={"Learnlist-entry8.preevo",
"[[€Auguri||001|E£]]",
}})
print(header.preevof{args={"Marshadow", "spettro", "lotta", "8", "7" }})

if false then
-- ============================ Gen 7- ============================
print(header.levelh{args={'Necrozma', 'Psico', 'Psico', '7', '7'}})
print(render.entry{args={'Learnlist-entry7.level',
"[[€Inizio|Inizio|Confusione||'''£]]",
"[[€Inizio|Inizio|Cristalcolpo||''£]]",
"[[€Inizio|Inizio|Ferrartigli£||'']]",
"[[€Inizio|Inizio|Lucelunare£]]",
"[[€Inizio|Inizio|Mattindoro£]]",
"[[€Inizio|Inizio|Raggioscossa£]]",
"[[€Evo|Evo|Lacerazione£]]",
"[[€13|13|Veicolaforza||'''£]]",
"[[€19|19|Cadutamassi£]]",
"[[€23|23|Nottesferza£]]",
"[[€31|31|Gravità£]]",
"[[€37|37|Psicotaglio||'''£]]",
"[[€43|43|Gemmoforza£]]",
"[[€47|47|Sganciapesi£]]",
"[[€&mdash;|50|Geyser Fotonico||'''£]]",
"[[€53|53|Levitoroccia£]]",
"[[€59|59|Ferroscudo£]]",
"[[€67|67|Strizzata£]]",
"[[€73|73|Prismalaser||'''£]]"}})
print(header.levelf{args={'Necrozma', 'Psico', 'Psico', '7', '7'}})


print(header.tutorh{args={'Necrozma', 'Psico', 'Psico', '7', '7'}})
print(render.entry{args={ 'Learnlist-entry7.tutor',
"[[€Segnoraggio|||no|yes£]]",
"[[€Metaltestata||''|no|yes£]]",
"[[€Geoforza|||no|yes£]]",
"[[€Gravità|||no|yes£]]",
"[[€Magnetascesa|||no|yes£]]",
"[[€Ferroscudo|||no|yes£]]",
"[[€Dragopulsar||''|no|yes£]]",
"[[€Granvoce|||no|yes£]]",
"[[€Russare|||no|yes£]]",
"[[€Privazione|||no|yes£]]",
"[[€Ondacalda|||no|yes£]]",
"[[€Ondashock|||no|yes£]]",
"[[€Oltraggio||''|no|yes£]]",
"[[€Riciclo|||no|yes£]]",
"[[€Levitoroccia|||no|yes£]]",
"[[€Telecinesi|||no|yes£]]",
"[[€Cambiaposto|||no|yes£]]"}})
print(header.tutorf{args={'Necrozma', 'Psico', 'Psico', '7', '7'}})


print(header.tutorh{args={'Rayquaza', 'Drago', 'Volante', '7', '3'}})
print(render.entry{args={ 'Learnlist-entry7.tutor',
"[[€Dragobolide||'''|yes|yes£]]",
"[[€Ascesa del drago||'''|yes|yes£]]",
"[[€Metaltestata|||no|yes£]]",
"[[€Baraonda|||no|yes£]]",
"[[€Geoforza|||no|yes£]]",
"[[€Ventogelato|||no|yes£]]",
"[[€Idrondata|||no|yes£]]",
"[[€Dragopulsar||'''|no|yes£]]",
"[[€Granvoce|||no|yes£]]",
"[[€Codacciaio|||no|yes£]]",
"[[€Legatutto|||no|yes£]]",
"[[€Russare|||no|yes£]]",
"[[€Ventoincoda||'''|no|yes£]]",
"[[€Ondashock|||no|yes£]]",
"[[€Idropulsar|||no|yes£]]",
"[[€Oltraggio||'''|no|yes£]]",
"[[€Scacciabruma||'''|no|yes£]]"}})
print(header.tutorf{args={'Rayquaza', 'Drago', 'Volante', '7', '3'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})
print(render.entry{args={ 'Learnlist-entry7.level',
"[[€Inizio|Inizio|Bollaraggio||'''£]]",
'[[€Inizio|Inizio|Doppiasberla||£]]',
'[[€Inizio|Inizio|Ipnosi||£]]',
"[[€Inizio|4|Ribaltiro||'''£]]",
"[[€Inizio|12|Sottomissione||'''£]]",
"[[€Evo|Evo|Sottomissione||'''£]]",
"[[€32|32|Dinamipugno||'''£]]",
"[[€43|43|Leggimente||£]]",
"[[€53|53|Ribaltiro||'''£]]"}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '6', '1'}})
print(render.entry{args={ 'Learnlist-entry6.level',
[[€Inizio|Inizio|Azione|Normale|Fisico|50|100|35|||Grinta|4|0£]],
[[€3|3|Ruggito|Normale|Stato|&mdash;|100|40|||Grazia|2|0£]],
[[€7|7|Parassiseme|Erba|Stato|&mdash;|90|10|||Acume|1|0£]],
[[€9|9|Frustata|Erba|Fisico|45|100|25||'''|Classe|4|0£]],
[[€13|13|Velenpolvere|Veleno|Stato|&mdash;|75|35|||Acume|3|0£]],
[[€13|13|Sonnifero|Erba|Stato|&mdash;|75|15|||Acume|1|3£]],
[[€15|15|Riduttore|Normale|Fisico|90|85|20|||Grinta|6|0£]],
[[€19|19|Foglielama|Erba|Fisico|55|95|25||'''|Classe|4|0£]],
[[€21|21|Profumino|Normale|Stato|&mdash;|100|20|||Grazia|2|0£]],
[[€25|25|Crescita|Normale|Stato|&mdash;|&mdash;|20|||Bellezza|1|0£]],
[[€27|27|Sdoppiatore|Normale|Fisico|120|100|15|||Grinta|6|0£]],
[[€31|31|Affannoseme|Erba|Stato|&mdash;|100|10|||Acume|2|0£]],
[[€33|33|Sintesi|Erba|Stato|&mdash;|&mdash;|5|||Acume|1|0£]],
[[€37|37|Semebomba|Erba|Fisico|80|100|15||'''|Grinta|4|0£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '6', '1'}})


print(header.levelh{args={'Metagross', 'Acciaio', 'Psico', '6', '3'}})
print(render.entry{args={ 'Learnlist-entry6.level',
[[€Inizio|Inizio|Magnetascesa|Elettro|Stato|&mdash;|&mdash;|10|||Acume|2|0£]],
[[€Inizio|Inizio|Riduttore|Normale|Fisico|90|85|20|||Grinta|6|0£]],
[[€Inizio|Inizio|Ferrartigli|Acciaio|Fisico|50|95|35||'''|Classe|4|0£]],
[[€Inizio|Inizio|Confusione|Psico|Speciale|50|100|25||'''|Acume|4|0£]],
[[€20|20|Confusione|Psico|Speciale|50|100|25||'''|Acume|4|0£]],
[[€20|20|Ferrartigli|Acciaio|Fisico|50|95|35||'''|Classe|4|0£]],
[[€23|23|Inseguimento|Buio|Fisico|40|100|20|||Acume|2|1£]],
[[€32|26|Pugnoscarica|Acciaio|Fisico|40|100|30||'''|Grinta|3|0£]],
[[€26|29|Miracolvista|Psico|Stato|&mdash;|&mdash;|40|||Acume|2|0£]],
[[€29|32|Cozzata Zen|Psico|Fisico|80|90|15||'''|Acume|4|0£]],
[[€35|35|Visotruce|Normale|Stato|&mdash;|100|10|||Grinta|3|0£]],
[[€41|38|Psichico|Psico|Speciale|90|100|10||'''|Acume|4|0£]],
[[€38|41|Agilità|Psico|Stato|&mdash;|&mdash;|30|||Classe|3|0£]],
[[€44|44|Meteorpugno|Acciaio|Fisico|90|90|10||'''|Classe|3|0£]],
[[€45|45|Martelpugno|Lotta|Fisico|100|90|10|||Grinta|6|0£]],
[[€53|52|Ferroscudo|Acciaio|Stato|&mdash;|&mdash;|15|||Grinta|1|0£]],
[[€62|60|Iper Raggio|Normale|Speciale|150|90|5|||Classe|4|4£]]}})
print(header.levelf{args={'Metagross', 'Acciaio', 'Psico', '6', '3'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '5', '1'}})
print(render.entry{args={ 'Learnlist-entry5.level',
[[€Inizio|Inizio|Azione|Normale|Fisico|50|100|35|||Grinta|4|0£]],
[[€Inizio|Inizio|Azione|Normale|Fisico|50|100|35£]],
[[€3|3|Ruggito|Normale|Stato|&mdash;|100|40£]],
[[€7|7|Parassiseme|Erba|Stato|&mdash;|90|10£]],
[[€9|9|Frustata|Erba|Fisico|35|100|15||'''£]],
[[€13|13|Velenpolvere|Veleno|Stato|&mdash;|75|35£]],
[[€13|13|Sonnifero|Erba|Stato|&mdash;|75|15£]],
[[€15|15|Riduttore|Normale|Fisico|90|85|20£]],
[[€19|19|Foglielama|Erba|Fisico|55|95|25||'''£]],
[[€21|21|Profumino|Normale|Stato|&mdash;|100|20£]],
[[€25|25|Crescita|Normale|Stato|&mdash;|&mdash;|40£]],
[[€27|27|Sdoppiatore|Normale|Fisico|120|100|15£]],
[[€31|31|Affannoseme|Erba|Stato|&mdash;|100|10£]],
[[€33|33|Sintesi|Erba|Stato|&mdash;|&mdash;|5£]],
[[€37|37|Semebomba|Erba|Fisico|80|100|15||'''£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '5', '1'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '4', '1'}})
print(render.entry{args={ 'Learnlist-entry4.level',
[[€Inizio|Inizio|Inizio|Azione|Normale|Fisico|35|95|35|Grinta|3£]],
[[€3|3|4|Ruggito|Normale|Stato|&mdash;|100|40|Grazia|2£]],
[[€7|8|8|Parassiseme|Erba|Stato|&mdash;|90|10|Acume|0£]],
[[€9|10|11|Frustata|Erba|Fisico|35|100|15|Classe|3||'''£]],
[[€13|12|13|Velenpolvere|Veleno|Stato|&mdash;|75|35|Acume|2£]],
[[€13|13|13|Sonnifero|Erba|Stato|&mdash;|75|15|Acume|2£]],
[[€15|15|15|Riduttore|Normale|Fisico|90|85|20|Grinta|3£]],
[[€19|19|19|Foglielama|Erba|Fisico|55|95|25|Classe|3||'''£]],
[[€21|21|21|Profumino|Normale|Stato|&mdash;|100|20|Grazia|2£]],
[[€25|25|25|Crescita|Normale|Stato|&mdash;|&mdash;|40|Bellezza|0£]],
[[€27|27|27|Sdoppiatore|Normale|Fisico|120|100|15|Grinta|0£]],
[[€31|31|31|Affannoseme|Erba|Stato|&mdash;|100|10|Bellezza|2£]],
[[€33|33|33|Sintesi|Erba|Stato|&mdash;|&mdash;|5|Acume|0£]],
[[€37|37|37|Semebomba|Erba|Fisico|80|100|15|Acume|3||'''£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '4', '1'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '3', '1'}})
print(render.entry{args={ 'Learnlist-entry3.level',
[[€Start|Azione|Normale|35|95|35|Grinta|4|0£]],
[[€4|Ruggito|Normale|&mdash;|100|40|Grazia|2|0£]],
[[€7|Parassiseme|Erba|&mdash;|90|10|Acume|2|2£]],
[[€10|Frustata|Erba|35|100|10|Classe|4|0||'''£]],
[[€15|Velenpolvere|Veleno|&mdash;|75|35|Acume|3|0£]],
[[€15|Sonnifero|Erba|&mdash;|75|15|Acume|1|3£]],
[[€20|Foglielama|Erba|55|95|25|Classe|3|0||'''£]],
[[€25|Profumino|Normale|&mdash;|100|20|Grazia|1|3£]],
[[€32|Crescita|Normale|&mdash;|&mdash;|40|Bellezza|1|0£]],
[[€39|Sintesi|Erba|&mdash;|&mdash;|5|Acume|1|0£]],
[[€46|Solarraggio|Erba|120|100|10|Classe|4|0||'''£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '3', '1'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '2', '1'}})
print(render.entry{args={ 'Learnlist-entry2.level',
[[€Inizio|Azione|Normale|35|95|35£]],
[[€4|Ruggito|Normale|—|100|40£]],
[[€7|Parassiseme|Erba|—|90|10£]],
[[€10|Frustata|Erba|35|100|10||'''£]],
[[€15|Velenpolvere|Veleno|—|75|35£]],
[[€15|Sonnifero|Erba|—|75|15£]],
[[€20|Foglielama|Erba|55|95|25||'''£]],
[[€25|Profumino|Normale|—|100|20£]],
[[€32|Crescita|Normale|—|—|40£]],
[[€39|Sintesi|Erba|—|—|5£]],
[[€46|Solarraggio|Erba|120|100|10||'''£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '2', '1'}})



print(header.levelh{args={'Bulbasaur', 'Erba', 'Veleno', '1', '1'}})
print(render.entry{args={ 'Learnlist-entry1.level',
[[€Inizio|Azione|Normale|35|95|35£]],
[[€Inizio|Ruggito|Normale|—|100|40£]],
[[€7|Parassiseme|Erba|—|90|10£]],
[[€13|Frustata|Erba|35|100|10||'''£]],
[[€20|Velenpolvere|Veleno|—|75|35£]],
[[€27|Foglielama|Erba|55|95|25||'''£]],
[[€34|Crescita|Normale|—|—|40£]],
[[€41|Sonnifero|Erba|—|75|15£]],
[[€48|Solarraggio|Erba|120|100|10||'''£]]}})
print(header.levelf{args={'Bulbasaur', 'Erba', 'Veleno', '1', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '1', '1'}})
print(render.entry{args={ 'Learnlist-entry1.tm',
[[€MT03|Danzaspada|Normale|—|—|30£]],
[[€MT06|Tossina|Veleno|—|85|10£]],
[[€MT08|Corposcontro|Normale|85|100|15£]],
[[€MT09|Riduttore|Normale|90|85|20£]],
[[€MT10|Sdoppiatore|Normale|100|100|15£]],
[[€MT20|Ira|Normale|20|100|20£]],
[[€MT21|Megassorbimento|Erba|40|100|10||'''£]],
[[€MT22|Solarraggio|Erba|120|100|10||'''£]],
[[€MT31|Mimica|Normale|—|100|10£]],
[[€MT32|Doppioteam|Normale|—|—|15£]],
[[€MT33|Riflesso|Psico|—|—|20£]],
[[€MT34|Pazienza|Normale|—|100|10£]],
[[€MT44|Riposo|Psico|—|—|10£]],
[[€MT50|Sostituto|Normale|—|—|10£]],
[[€MN01|Taglio|Normale|50|95|30£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '1', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '2', '1'}})
print(render.entry{args={ 'Learnlist-entry2.tm',
[[€MT02|Bottintesta|Normale|70|100|15£]],
[[€MT03|Maledizione|???|—|—|10£]],
[[€MT06|Tossina|Veleno|—|85|10£]],
[[€MT10|Introforza|Normale|—|100|15£]],
[[€MT11|Giornodisole|Fuoco|—|—|5£]],
[[€MT12|Profumino|Normale|—|100|20£]],
[[€MT13|Russare|Normale|40|100|15£]],
[[€MT17|Protezione|Normale|—|—|10£]],
[[€MT19|Gigassorbimento|Erba|60|100|5||'''£]],
[[€MT20|Resistenza|Normale|—|—|10£]],
[[€MT21|Frustrazione|Normale|—|100|20£]],
[[€MT22|Solarraggio|Erba|120|100|10||'''£]],
[[€MT27|Ritorno|Normale|—|100|20£]],
[[€MT31|Fangosberla|Terra|20|100|10£]],
[[€MT32|Doppioteam|Normale|—|—|15£]],
[[€MT34|Bullo|Normale|—|90|15£]],
[[€MT35|Sonnolalia|Normale|—|—|10£]],
[[€MT40|Ricciolscudo|Normale|—|—|40£]],
[[€MT44|Riposo|Psico|—|—|10£]],
[[€MT45|Attrazione|Normale|—|100|15£]],
[[€MT49|Tagliofuria|Coleottero|10|95|20£]],
[[€MN01|Taglio|Normale|50|95|30£]],
[[€MN05|Flash|Normale|—|70|20£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '2', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '3', '1'}})
print(render.entry{args={ 'Learnlist-entry3.tm',
[[€MT06|Tossina|Veleno|&mdash;|85|10|Acume|3|0£]],
[[€MT09|Semitraglia|Erba|10|100|30|Classe|2|1||'''£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '3', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '4', '1'}})
print(render.entry{args={ 'Learnlist-entry4.tm',
[[€MT06|Tossina|Veleno|Stato|&mdash;|85|10|Acume|2£]],
[[€MT09|Semitraglia|Erba|Fisico|10|100|30|Classe|2||'''£]],
[[€MT10|Introforza|Normale|Speciale|&mdash;|100|15|Acume|1£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '4', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '5', '1'}})
print(render.entry{args={ 'Learnlist-entry5.tm',
[[€MT06|Tossina|Veleno|Stato|&mdash;|90|10£]],
[[€MT09|Velenoshock|Veleno|Speciale|65|100|10||'''£]],
[[€MT10|Introforza|Normale|Speciale|&mdash;|100|15£]],
[[€MT11|Giornodisole|Fuoco|Stato|&mdash;|&mdash;|5£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '5', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '6', '1'}})
print(render.entry{args={ 'Learnlist-entry6.tm',
[[€MT06|Tossina|Veleno|Stato|&mdash;|90|10|||Acume|3|0£]],
[[€MT09|Velenoshock|Veleno|Speciale|65|100|10||'''|Bellezza|2|0£]],
[[€MT10|Introforza|Normale|Speciale|60|100|15|||Acume|3|0£]],
[[€MT11|Giornodisole|Fuoco|Stato|&mdash;|&mdash;|5|||Bellezza|1|0£]],
[[€MT16|Schermoluce|Psico|Stato|&mdash;|&mdash;|30|||Bellezza|2|0£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '6', '1'}})



print(header.tmh{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})
print(render.entry{args={ 'Learnlist-entry7.tm',
[[€MT01|Cuordileone|£]],
[[€MT06|Tossina|£]],
[[€MT09|Velenoshock||'''£]],
[[€MT10|Introforza|£]],
[[€MT11|Giornodisole|£]],
[[€MT16|Schermoluce|£]],
[[€MT17|Protezione|£]],
[[€MT88|Sonnolalia|£]],
[[€MT90|Sostituto|£]],
[[€MT96|Naturforza|£]],
[[€MT100|Confidenza|£]]}})
print(header.tmf{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '7', '2'}})
print(render.entry{args={ 'Learnlist-entry7.breed',
[[€#079##080##143#|Amnesia|£]],
[[€#546##696##697#|Fascino|£]],
[[€#079##080##199##387##388##389#
#597##598##708##709##712##713#|Maledizione|£]],
[[€#410##411##776#|Resistenza|£]],
[[€#043##044##046##047##114##465#
#187##188##189##191##192##252#
#270##285##315##387##388##389#
#495##496##497##546##556##590#
#591##755##756#|Gigassorbimento||'''|£]],
[[€#191##192##315##459##460#|Meloderba|£]],
[[€#043##044##114##465##407##764#|Campo Erboso|£]],
[[€#114##465##191##192##315##331#
#332##455##459##460##556##590#
#591##597##598##708##709##753#
#754##755##756#|Radicamento|£]],
[[€#071##103##103A##182##192##253#
#254##275##357##387##388##389#
#495##496##497#|Verdebufera||'''|£]],
[[€#152##153##154##182##315##407#
#357##420##421##764#|Fogliamagica||'''|£]],
[[€#270##271##272##273##274##698#
#699#|Naturforza|£]],
[[€#003##043##044##045##182##154#
#192##315##421##556##764#|Petalodanza||'''|£]],
[[€#108##463##114##465##455##598#|Vigorcolpo||'''|£]],
[[€#007##008##009##713#|Capocciata|£]],
[[€#258#|Fango|*|'''|USUL|solo di martedì£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '7', '2'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '6', '2'}})
print(render.entry{args={ 'Learnlist-entry6.breed',
[[€#079##080##143#|Amnesia|Psico|Stato|&mdash;|&mdash;|20|||Grazia|1|0£]],
[[€#546##696##697#|Fascino|Folletto|Stato|&mdash;|100|20|||Grazia|2|1£]],
[[€#079##080##199##387##388##389#
#597##598##708##709##712##713#|Maledizione|Spettro|Stato|&mdash;|&mdash;|10|||Grinta|3|0£]],
[[€#410##411#|Resistenza|Normale|Stato|&mdash;|&mdash;|10|||Grinta|3|0£]],
[[€#043##044##046##047##114##465#
#187##188##189##191##192##252#
#285##315##387##388##389##495#
#496##497##546##556##590##591#|Gigassorbimento|Erba|Speciale|75|100|10||'''|Acume|1|4£]],
[[€#191##192##315##459##460#|Meloderba|Erba|Stato|&mdash;|55|15|||Acume|2|0£]],
[[€#043##044##114##465##407#|Campo Erboso|Erba|Stato|&mdash;|&mdash;|10|||Bellezza|3|0£]],
[[€#114##465##191##192##315##331#
#332##455##459##460##556##590#
#591##597##598##708##709#|Radicamento|Erba|Stato|&mdash;|&mdash;|20|||Acume|1|0£]],
[[€#071##103##182##192##253##254#
#275##357##387##388##389##495#
#496##497#|Verdebufera|Erba|Speciale|130|90|5||'''|Bellezza|6|0£]],
[[€#152##153##154##182##315##407#
#357##420##421#|Fogliamagica|Erba|Speciale|60|&mdash;|20||'''|Bellezza|2|0£]],
[[€#270##271##272##273##274##698#
#699#|Naturforza|Normale|Stato|&mdash;|&mdash;|20|||Bellezza|1|0£]],
[[€#003##043##044##045##154##192#
#315##421##556#|Petalodanza|Erba|Speciale|120|100|10||'''|Bellezza|6|0£]],
[[€#108##463##114##465##455##598#|Vigorcolpo|Erba|Fisico|120|85|10||'''|Grinta|1|0£]],
[[€#007##008##009##713#|Capocciata|Normale|Fisico|130|100|10|||Grinta|3|0£]],
[[€#258#|Fango|Veleno|Speciale|65|100|20|*|'''|Grinta|2|3£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '6', '2'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '5', '2'}})
print(render.entry{args={ 'Learnlist-entry5.breed',
[[€#079##080##199##143#|Amnesia|Psico|Stato|&mdash;|&mdash;|20£]],
[[€#546##547#|Fascino|Normale|Stato|&mdash;|100|20£]],
[[€#079##080##199##387##388##389#<br>#597##598#|Maledizione|Spettro|Stato|&mdash;|&mdash;|10£]],
[[€#410##411#|Resistenza|Normale|Stato|&mdash;|&mdash;|15£]],
[[€#043##044##045##182##187##188#<br>#189##191##192##252##285##286#<br>#315##407##387##388##389##495#<br>#496##497##546##547##556##590#<br>#591#|Gigassorbimento|Erba|Speciale|75|100|10|'''£]],
[[€#191##192##315##407##459##460#|Meloderba|Erba|Stato|&mdash;|55|15£]],
[[€#114##465##191##192##315##407#<br>#331##332##455##459##460##556#<br>#590##591##597##598#|Radicamento|Erba|Stato|&mdash;|&mdash;|20£]],
[[€#071##103##182##192##253##254#<br>#275##357##387##388##389##495#<br>#496##497#|Verdebufera|Erba|Speciale|140|90|5|'''£]],
[[€#152##153##154##182##315##407#<br>#357##420##421#|Fogliamagica|Erba|Speciale|60|&mdash;|20|'''£]],
[[€#270##271##272##273##274##275#|Naturforza|Normale|Stato|&mdash;|&mdash;|20£]],
[[€#003##043##044##045##182##154#<br>#192##315##407##421##556#|Petalodanza|Erba|Speciale|120|100|10|'''£]],
[[€#108##463##114##465##455##598#|Vigorcolpo|Erba|Fisico|120|85|10|'''£]],
[[€#007##008##009#|Capocciata|Normale|Fisico|100|100|15£]],
[[€#258##259##260#|Fango|Veleno|Speciale|65|100|20|'''|*£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '5', '2'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '4', '2'}})
print(render.entry{args={ 'Learnlist-entry4.breed',
[[[€#079##080##143#|Amnesia|Psico|Stato|&mdash;|&mdash;|20|Grazia|0£]],
[[€#285##286#|Fascino|Normale|Stato|&mdash;|100|20|Grazia|2|*£]],
[[€#079##080##199##387##388##389#|Maledizione|???|Stato|&mdash;|&mdash;|10|Grinta|0£]],
[[€#191##192##315##459##460#|Meloderba|Erba|Stato|&mdash;|55|15|Acume|2£]],
[[€#114##465##191##192##315##331#<br>#332##455##459##460#|Radicamento|Erba|Stato|&mdash;|&mdash;|20|Acume|0£]],
[[€#071##103##182##192##253##254#<br>#275##357##387##388##389#|Verdebufera|Erba|Speciale|140|90|5|Grazia|2||'''£]],
[[€#152##153##154##179##180##181#|Schermoluce|Psico|Stato|&mdash;|&mdash;|30|Bellezza|2£]],
[[€#152##153##154##182##315##407#<br>#357##420##421#|Fogliamagica|Erba|Speciale|60|&mdash;|20|Bellezza|2||'''£]],
[[€#270##271##272##273##274#|Naturforza|Normale|Stato|&mdash;|&mdash;|20|Bellezza|2£]],
[[€#003##043##044##045##154##192#<br>#315##421#|Petalodanza|Erba|Speciale|90|100|20|Bellezza|0||'''£]],
[[€#108##463##114##465##455#|Vigorcolpo|Erba|Fisico|120|85|10|Bellezza|3||'''|HGSS£]],
[[€#131##152##153##154#|Salvaguardia|Normale|Stato|&mdash;|&mdash;|25|Bellezza|2£]],
[[€#007##008##009#|Capocciata|Normale|Fisico|100|100|15|Grinta|1£]],
[[€#258##259##260#|Fango|Veleno|Speciale|65|100|20|Grinta|2|*|'''|HGSS£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '4', '2'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '3', '2'}})
print(render.entry{args={ 'Learnlist-entry3.breed',
[[€#033##034##285##286#|Fascino|Normale|&mdash;|100|20|Grazia|2|1|*£]],
[[€#152##153##154##179##180##181#|Schermoluce|Psico|&mdash;|&mdash;|30|Bellezza|1|0}}£]],
[[€#007##008##009#|Capocciata|Normale|100|100|15|Grinta|1|4£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '3', '2'}})



print(header.breedh{args={'Bulbasaur', 'Erba', 'Veleno', '2', '2'}})
print(render.entry{args={ 'Learnlist-entry2.breed',
[[€#152##153#|Schermoluce|Psico|—|—|30£]],
[[€#043##044#|Petalodanza|Erba|90|100|20||'''£]],
[[€#158##159#|Ventagliente|Normale|80|75|10|*£]],
[[€#131##152#|Salvaguardia|Normale|—|—|25£]],
[[€#007##008#|Capocciata|Normale|100|100|15£]]}})
print(header.breedf{args={'Bulbasaur', 'Erba', 'Veleno', '2', '2'}})




print(header.tutorh{args={'Bulbasaur', 'Erba', 'Veleno', '7', '2'}})
print(render.entry{args={ 'Learnlist-entry7.tutor',
[[€Erbapatto||'''|yes£]]}})
print(header.tutorf{args={'Bulbasaur', 'Erba', 'Veleno', '7', '2'}})



print(header.prevoh{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})
print(render.entry{args={ 'Learnlist-entry7.prevo',
[[€001|Bulbasaur|||||Semebomba|'''£]]}})
print(header.prevof{args={'Bulbasaur', 'Erba', 'Veleno', '7', '1'}})



print(header.prevoh{args={'Venusaur', 'Erba', 'Veleno', '7', '1'}})
print(render.entry{args={ 'Learnlist-entry7.prevo',
[[€001|Bulbasaur|||||Semebomba|'''£]]}})
print(header.prevof{args={'Venusaur', 'Erba', 'Veleno', '7', '1'}})



print(header.prevoh{args={'Venusaur', 'Erba', 'Veleno', '4', '1'}})
print(render.entry{args={ 'Learnlist-entry4.prevo',
[[€001|Bulbasaur|||||Semebomba|Erba|Fisico|80|100|15|Acume|3|'''|DP£]]}})
print(header.prevof{args={'Venusaur', 'Erba', 'Veleno', '4', '1'}})



print(header.prevoh{args={'Venusaur', 'Erba', 'Veleno', '5', '1'}})
print(render.entry{args={ 'Learnlist-entry5.prevo',
[[€001|Bulbasaur|||||Semebomba|Erba|Fisico|80|100|15|'''£]],
[[€001|Bulbasaur|e||||Falsofinale|Normale|Fisico|40|100|40£]],
[[€001|Bulbasaur|e||||Palla Clima|Normale|Speciale|50|100|10£]]}})
print(header.prevof{args={'Venusaur', 'Erba', 'Veleno', '5', '1'}})



print(header.prevoh{args={'Venusaur', 'Erba', 'Veleno', '6', '1'}})
print(render.entry{args={ 'Learnlist-entry6.prevo',
[[€001|Bulbasaur|||||Semebomba|Erba|Fisico|80|100|15|'''|Grinta|4|0£]]}})
print(header.prevof{args={'Venusaur', 'Erba', 'Veleno', '6', '1'}})



print(header.prevoh{args={'Swampert', 'Acqua', 'Terra', '3', '3'}})
print(render.entry{args={ 'Learnlist-entry3.prevo',
[[€258|Mudkip|||||Mulinello|Acqua|15|70|15|Bellezza|3|0£]],
[[€258|Mudkip|||||Idropompa|Acqua|120|80|5|Bellezza|4|0£]]}})
print(header.prevof{args={'Swampert', 'Acqua', 'Terra', '3', '3'}})



print(header.eventh{args={'Zygarde', 'Drago', 'Terra', '7', '6'}})
print(render.entry{args={ 'Learnlist-entry7.event',
[[€Nucleo di Zygarde|Dragodanza|£]],
[[€Nucleo di Zygarde|Extrarapido|£]],
[[€Nucleo di Zygarde|Mille Onde||'''£]],
[[€Nucleo di Zygarde|Mille Frecce||'''£]],
[[€Nucleo di Zygarde|Nucleocastigo||'''£]]}})
print(header.eventf{args={'Zygarde', 'Drago', 'Terra', '7', '6'}})



print(header.eventh{args={'Mew', 'Psico', 'Psico', '3', '1'}})
print(render.entry{args={ 'Learnlist-entry3.event',
[[€Pokémon XD|Finta|Buio|60|—|20|Acume|2|0£]],
[[€Pokémon XD|Bruciapelo|Normale|40|100|10|Grazia|2|1£]]}})
print(header.eventf{args={'Mew', 'Psico', 'Psico', '3', '1'}})



print(header.eventh{args={'Arceus', 'Normale', 'Normale', '4', '4'}})
print(render.entry{args={ 'Learnlist-entry4.event',
[[€Toys "R" Us events|Fragortempo|Drago|Speciale|150|90|5|Classe|2||''£]],
[[€ "R" Us events|Fendispazio|Drago|Speciale|100|95|5|Grinta|2||''£]],
[[€ "R" Us events|Oscurotuffo|Spettro|Fisico|120|100|5|Acume|2||''£]]}})
print(header.eventf{args={'Arceus', 'Normale', 'Normale', '4', '4'}})



print(header.eventh{args={'Victini', 'Fuoco', 'Psico', '5', '5'}})
print(render.entry{args={ 'Learnlist-entry5.event',
[[€F14|Generatore V|Fuoco|Fisico|180|95|5||'''£]],
[[€F14|Incrofiamma|Fuoco|Speciale|100|100|5||'''£]],
[[€F14|Incrotuono|Elettro|Fisico|100|100|5||£]],
[[€del Pokémon Center (JAP)|Gelamondo|Ghiaccio|Speciale|65|95|10||£]],
[[€ Pokémon Center (JAP)|Fuocoblu|Fuoco|Speciale|130|85|5||'''£]],
[[€ Pokémon Center (JAP)|Lucesiluro|Elettro|Fisico|130|85|5||£]],
[[€ Pokémon Center (JAP)|Generatore V|Fuoco|Fisico|180|95|5||'''£]]}})
print(header.eventf{args={'Zygarde', 'Drago', 'Terra', '5', '5'}})



print(header.eventh{args={'Celebi', 'Erba', 'Psico', '6', '2'}})
print(render.entry{args={ 'Learnlist-entry6.event',
[[€Celebi Banca Pokémon|Riguardo|Normale|Fisico|40|100|40||||Classe|4|0£]]}})
print(header.eventf{args={'Celebi', 'Erba', 'Psico', '6', '2'}})



print(header.tutorh{args={'Staraptor', 'Normale', 'Volante', '6', '4'}})
print(render.entry{args={ 'Learnlist-entry6.tutor',
[[€Rimonta|Normale|Fisico|&mdash;|100|5|||no|yes|Grinta|2|0£]],
[[€Ondacalda|Fuoco|Speciale|95|90|10|||no|yes|Bellezza|2|2£]],
[[€Aeroattacco|Volante|Fisico|140|90|5||'''|no|yes|Classe|3|0£]],
[[€Russare|Normale|Speciale|50|100|15||'''|no|yes|Grazia|4|0£]],
[[€Ventoincoda|Volante|Stato|&mdash;|&mdash;|15|||no|yes|Classe|3|0£]],
[[€Baraonda|Normale|Speciale|90|100|10||'''|no|yes|Grazia|2|1£]]}})
print(header.tutorf{args={'Staraptor', 'Normale', 'Volante', '6', '4'}})



print(header.tutorh{args={'Bulbasaur', 'erba', 'veleno', '4', '1'}})
print(render.entry{args={ 'Learnlist-entry4.tutor',
[[€Tagliofuria|Coleottero|Fisico|10|95|20|Classe|2|||no|yes|yes£]],
[[€Bottintesta|Normale|Fisico|70|100|15|Grinta|3|||no|no|yes£]],
[[€Privazione|Buio|Fisico|20|100|20|Acume|3|||yes|yes|yes£]],
[[€Fangosberla|Terra|Speciale|20|100|10|Grazia|3|||no|yes|yes£]],
[[€Semebomba|Erba|Fisico|80|100|15|Acume|3||'''|no|yes|yes£]],
[[€Russare|Normale|Speciale|40|100|15|Grazia|3|||no|yes|yes£]],
[[€Millebave|Coleottero|Stato|&mdash;|95|40|Acume|2|||yes|no|yes£]],
[[€Sintesi|Erba|Stato|&mdash;|&mdash;|5|Acume|0|||no|yes|yes£]],
[[€Affannoseme|Erba|Stato|&mdash;|100|10|Bellezza|2|||no|no|yes£]]}})
print(header.tutorf{args={'Bulbasaur', 'erba', 'veleno', '4', '1'}})



print(header.tutorh{args={'Bulbasaur', 'erba', 'veleno', '3', '1'}})
print(render.entry{args={ 'Learnlist-entry3.tutor',
[[€Corposcontro|Normale|85|100|15|Grinta|1|4|||yes|yes|yes£]],
[[€Ricciolscudo|Normale|&mdash;|&mdash;|40|Grazia|2|0|||no|yes|no£]],
[[€Sdoppiatore|Normale|120|100|15|Grinta|6|0|||yes|yes|yes£]],
[[€Resistenza|Normale|&mdash;|&mdash;|10|Grinta|2|0|||no|yes|no£]],
[[€Tagliofuria|Coleottero|10|95|20|Classe|3|0|||no|yes|no£]],
[[€Mimica|Normale|&mdash;|&mdash;|10|Grazia|1|0|||yes|yes|yes£]],
[[€Fangosberla|Terra|20|100|10|Grazia|2|1|||no|yes|no£]],
[[€Sonnolalia|Normale|&mdash;|&mdash;|10|Grazia|3|0|||no|yes|no£]],
[[€Russare|Normale|40|100|15|Grazia|4|0|||no|yes|no£]],
[[€Sostituto|Normale|&mdash;|&mdash;|10|Acume|2|0|||yes|yes|yes£]],
[[€Bullo|Normale|&mdash;|90|15|Grazia|2|0|||no|yes|yes£]],
[[€Danzaspada|Normale|&mdash;|&mdash;|30|Bellezza|1|0|||yes|yes|no£]]}})
print(header.tutorf{args={'Bulbasaur', 'erba', 'veleno', '3', '1'}})



print(header.tutorh{args={'Bulbasaur', 'erba', 'veleno', '2', '1'}})
print(render.entry{args={ 'Learnlist-entry2.tutor',
[[€Corposcontro|Normale|85|100|15|||yes|yes|yes£]],
[[€Ricciolscudo|Normale|&mdash;|&mdash;|40|||no|yes|no£]],
[[€Sdoppiatore|Normale|120|100|15|||yes|yes|yes£]],
[[€Resistenza|Normale|&mdash;|&mdash;|10|||no|yes|no£]],
[[€Tagliofuria|Coleottero|10|95|20|||no|yes|no£]],
[[€Mimica|Normale|&mdash;|&mdash;|10|||yes|yes|yes£]],
[[€Fangosberla|Terra|20|100|10|||no|yes|no£]],
[[€Sonnolalia|Normale|&mdash;|&mdash;|10|||no|yes|no£]],
[[€Russare|Normale|40|100|15|||no|yes|no£]],
[[€Sostituto|Normale|&mdash;|&mdash;|10|||yes|yes|yes£]],
[[€Bullo|Normale|&mdash;|90|15|||no|yes|yes£]],
[[€Danzaspada|Normale|&mdash;|&mdash;|30|||yes|yes|no£]]}})
print(header.tutorf{args={'Bulbasaur', 'erba', 'veleno', '2', '1'}})


print(header.tutorh{args={'Bulbasaur', 'erba', 'veleno', '5', '1'}})
print(render.entry{args={ 'Learnlist-entry5.tutor',
[[€Legatutto|Normale|Fisico|15|85|20|||no|yes£]],
[[€Gigassorbimento|Erba|Speciale|75|100|10||'''|no|yes£]],
[[€Erbapatto|Erba|Speciale|50|100|10||'''|yes|yes£]],
[[€Privazione|Buio|Fisico|20|100|20|||no|yes£]],
[[€Semebomba|Erba|Fisico|80|100|15||'''|no|yes£]],
[[€Sonnolalia|Normale|Stato|&mdash;|&mdash;|10|||no|yes£]],
[[€Russare|Normale|Speciale|40|100|15|||no|yes£]],
[[€Sintesi|Erba|Stato|&mdash;|&mdash;|5|||no|yes£]],
[[€Affannoseme|Erba|Stato|&mdash;|100|10|||no|yes£]]}})
print(header.tutorf{args={'Bulbasaur', 'erba', 'veleno', '5', '1'}})

end
