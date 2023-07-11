local render = require("Render")
local header = require("Movelist-hf")
local entry = require("Movelist-entry")
local mw = require("mw")

-- New render
mw.title.setTitle("Fulmine")
print(header.Levelh({ args = { "Elettro", "1" } }))
-- stylua: ignore
print(render.render{args={'Movelist-entry', 'Level', '//',
"1", "025Co", "no", "no", "no", "26", "22", "20", "B2W2 <- 10", "12", "USUM <- 40", "10", "11", "STAB<-'''", "useless<-yes", "//",
"1", "361", "no", "no", "no", "26", "22", "20", "9000", "forse", "10", "STAB<-'''", "//",
"1", "598", "no", "no", "no", "26", "22", "20", "213", "no", "11", "STAB<-'''", "//",
"1", "125", "no", "no", "no", "50", "49", "48", "no", "cose", "un po'", "//",
"1", "376", "1", "Y<-2", "3", "C<-4", "no", "50", "49", "48", "2", "LGPE<-123", "100", "110", "//",
"1", "466", "no", "no", "no", "50", "49", "48", "no", "no", "no", "//",
-- "1", "065M", "no", "no", "no", "50", "49", "48", "no", "no", "//",
"1", "065", "no", "no", "no", "50", "49", "48", "no", "54", "no", "//",
"1", "720L", "no", "no", "no", "50", "49", "48", "no", "12", "no", "//",
"1", "720", "no", "no", "no", "50", "49", "48", "no", "12", "no", "//",
"1", "398", "no", "no", "", "50", "49", "48", "no", "no", "12", "//",
}})
print(header.levelf({ args = {} }))

mw.title.setTitle("Punizione")
print(header.Breedh({ args = { "Buio", "3" } }))
-- stylua: ignore
print(render.entry{args={'Movelist-entry.breed',
[[€3|198|no|#396##397##398#|PtHGSS=#627##628#|no|#580##581##627##628#|ORAS=no|N/D|#001#|#001#|#001#|STAB='''£]],
[[€3|394|no|no|no|''antani''|N/D|STAB='''£]],
[[€3|731|no|E=''ciao''|no|no|''antani''|N/D|STAB='''£]]}})
print(header.footer({ args = {} }))

mw.title.setTitle("Geloraggio")
-- print(header.TMh{args = {'Ghiaccio', '1', 'MT13', 'no', 'MT13', 'MT13', 'MT13', 'MT13', 'MT13'}})
print(header.autoTMh({ args = { "Geloraggio" } }))
-- stylua: ignore
print(render.entry{args={'Movelist-entry.TM',
"[[€1|116|yes|no|yes|yes|yes|yes|yes|yes£]]",
"[[€1|117|yes|no|yes|yes|yes|yes|yes|yes£]]",
"[[€1|199|no|no|yes|yes|yes|yes|yes|yes£]]",
"[[€1|359|no|no|yes|yes|yes|yes|yes|no£]]",
"[[€1|368|no|no|yes|yes|yes|yes|yes|no£]]",
"[[€1|478|no|no|no|yes|yes|yes|yes|yes|STAB='''£]]",
"[[€1|713|no|no|no|no|no|yes|yes|yes|no|STAB='''£]]"}})
print(header.footer({ args = {} }))

mw.title.setTitle("Dragobolide")
print(header.tutorh({ args = { "Drago", "10" } }))
print(header.tutor4({ args = { "yes", "yes", "yes" } }))
print(header.tutor5({ args = { "yes", "yes" } }))
print(header.tutor6({ args = { "yes", "yes" } }))
print(header.tutor7({ args = { "yes", "yes" } }))
print(header.tutor8({ args = { "yes" } }))
-- stylua: ignore
print(render.entry{args={'Movelist-entry.tutor',
"[[€148|X|X|X|X|yes|yes|yes|yes|yes|yes|yes|no|no|yes|yes|STAB='''£]]",
"[[€487O|X|X|X|X|no|yes|yes|yes|yes|yes|yes|yes|no|yes|yes|STAB='''£]]",
"[[€646N|X|X|X|X|no|no|no|no|yes|yes|yes|yes|no|no|yes|STAB='''£]]",
"[[€715|X|X|X|X|no|no|no|no|no|yes|yes|no|no|yes|yes|STAB='''£]]",
"[[€718|X|X|X|X|no|no|no|no|no|yes|yes|yes|yes|yes|no|STAB='''£]]",
"[[€284|X|X|X|X|no|no|no|no|no|no|yes|yes|no|no|no£]]",}})
print(header.footer({ args = {} }))

mw.title.setTitle("Eterelama")
print(header.Eventh({ args = { "volante" } }))
print(header.div({ args = { "4" } }))
-- stylua: ignore start
print(entry.Event{args={'491', '[[F10|Evento decimo film]]<br>Toys "R" Us e Nintendo World Store<br>Darkrai Alamos europeo<br>Darkrai Alamos australano'}})
print(entry.Event{args={'493', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492C', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'493', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''", allforms = 'yes'}})
print(header.footer({ args = {} }))

mw.title.setTitle("Azione")
print(header.Eventh({ args = { "Normale" } }))
print(header.div({ args = { "4" } }))
print(entry.Event({ args = { "422E", "My Pokémon Ranch", useless = "yes" } }))
print(header.footer({ args = {} }))

mw.title.setTitle("Not a move name")
print(header.Levelh({ args = { "veleno", "6" } }))
-- stylua: ignore
print(render.entry{args={'Movelist-entry.Level',
"[[€6|023|38|38|48|STAB='''|movename=fangobomba£]]",
"[[€6|024|48|48|49|STAB='''|movename=fangobomba£]]",
"[[€6|799|no|1|50|no|movename=fangobomba£]]"}})
print(header.levelf({ args = {} }))
