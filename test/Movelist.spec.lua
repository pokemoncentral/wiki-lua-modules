local render = require('Render')
local header = require('Movelist-hf')
local entry = require('Movelist-entry')
local ml = require('Movelist')
local mw = require('mw')

print(header.Levelh{args={'Elettro', '1'}})
mw.title.setTitle("Fulmine")
print(render.entry{args={'Movelist.levelTEST',
"[[€025Co|LGPE=10|useless=yes£]]",
"[[€493|LGPE=10|allforms=yes£]]",
"[[€738£]]",
"[[€738|LGPE=10£]]",
"[[€720£]]",}})
mw.title.setTitle("Frustata")
print(render.entry{args={'Movelist.levelTEST',
"[[€001|LGPE=5£]]",
"[[€398£]]",}})
print(header.levelf{args={'Elettro'}})

print(header.Breedh{args = {'Ghiaccio', '2'}})
mw.title.setTitle("Palla Gelo")
print(render.entry{args={'Movelist.breedTEST',
"[[€225£]]",}})
mw.title.setTitle("Bodyguard")
print(render.entry{args={'Movelist.breedTEST',
"[[€075£]]",}})
mw.title.setTitle("Fango")
print(render.entry{args={'Movelist.breedTEST',
"[[€422E|useless=yes£]]",}})
mw.title.setTitle("Punizione")
print(render.entry{args={'Movelist.breedTEST',
"[[€198£]]",}})
print(header.levelf{args={'Ghiaccio'}})

print(header.TMh{args = {'Acqua', '1'}})
mw.title.setTitle("Cuordileone")
print(render.entry{args={'Movelist.tmTEST',
"[[€807£]]",
"[[€019£]]",}})
mw.title.setTitle("Cascata")
print(render.entry{args={'Movelist.tmTEST',
"[[€007|LGPE=yes£]]",}})
mw.title.setTitle("Sub")
print(render.entry{args={'Movelist.tmTEST',
"[[€007|LGPE=yes£]]",}})
mw.title.setTitle("Scacciabruma")
print(render.entry{args={'Movelist.tmTEST',
"[[€398£]]",}})
print(header.footer{args={'Acqua'}})

print(header.tutorh{args = {'veleno'}})
print(header.tutor4{args = {'no', 'yes', 'yes'}})
print(header.tutor5{args = {'no', 'yes'}})
print(header.tutor6{args = {'no', 'yes'}})
print(header.tutor7{args = {'no', 'yes', 'no'}})
mw.title.setTitle("Gastroacido")
print(render.entry{args={'Movelist.tutorTEST',
[[€023£]],
[[€088A£]],
[[€336£]],
[[€455£]],
[[€511£]],
[[€631£]],
[[€804£]]}})
print(header.footer{args={'veleno'}})

print(header.Eventh{args = {'spettro'}})
print(header.div{args={'4'}})
mw.title.setTitle("Oscurotuffo")
print(render.entry{args={'Movelist.eventTEST',
[[€493|Evento dodicesimo film<br>Arceus Michina australiano<br>Toys "R" Us Arceus<br>Arceus Michina europeo£]]}})
print(header.footer{args={'spettro'}})


if false then
mw.title.setTitle("Fulmine")
print(header.Levelh{args={'Elettro', '1'}})
print(render.entry{args={'Movelist-entry.Level',
"[[€1|025Co|no|no|no|26|22|20|B2W2=10|12|USUM=40|STAB='''|useless=yes£]]",
"[[€1|361|no|no|no|26|22|20|9000|STAB='''£]]",
"[[€1|598|no|no|no|26|22|20|213|STAB='''£]]",
"[[€1|377|no|no|no|50|49|48|no£]]",
"[[€1|376|1|Y=2|3|C=4|no|50|49|48|2|LGPE=123£]]",
"[[€1|398|no|no|no|50|49|48|no£]]",
"[[€1|065|no|no|no|50|49|48|no£]]",
"[[€1|065M|no|no|no|50|49|48|no£]]",
"[[€1|720L|no|no|no|50|49|48|no£]]",
"[[€1|720|no|no|no|50|49|48|no£]]",}})
print(header.levelf{args={'Elettro'}})
end
if false then
mw.title.setTitle("Pallagelo")
print(header.Breedh{args = {'Ghiaccio', '3'}})
print(render.entry{args={'Movelist-entry.breed',
[[€3|276|no|#396##397##398#|PtHGSS=#627##628#|no|#580##581##627##628#|ORAS=no|N/D|STAB='''£]],
[[€3|731|no|E=''ciao''|no|no|''antani''|N/D|STAB='''£]],
[[€3|111|no|#024##059##135##209##210##229##232##248##295##309##310##403##404##405##450#|#024##059##135##209##210##229##232##248##295##309##310##403##404##405##450##508#|#024##059##135##209##210##229##232##248##262##295##309##310##403##404##405##450##508#|#024##059##135##209##210##229##232##248##262##295##309##310##403##404##405##450##508#|USUM=#001##002##498#£]]}})
print(header.footer{args={'Ghiaccio'}})


mw.title.setTitle("Geloraggio")
print(header.TMh{args = {'Ghiaccio', '1', 'MT13', 'no', 'MT13', 'MT13', 'MT13', 'MT13', 'MT13'}})
print(render.entry{args={'Movelist-entry.TM',
"[[€1|116|yes|no|yes|yes|yes|yes|yes£]]",
"[[€1|117|yes|no|yes|yes|yes|yes|yes£]]",
"[[€1|199|no|no|yes|yes|yes|yes|yes£]]",
"[[€1|359|no|no|yes|yes|yes|yes|yes£]]",
"[[€1|368|no|no|yes|yes|yes|yes|yes£]]",
"[[€1|478|no|no|no|yes|yes|yes|yes|STAB='''£]]",
"[[€1|713|no|no|no|no|no|yes|yes|yes|STAB='''£]]"}})
print(header.footer{args={'Ghiaccio'}})


mw.title.setTitle("Dragobolide")
print(header.tutorh{args = {'drago', '8'}})
print(header.tutor4{args = {'yes', 'yes', 'yes'}})
print(header.tutor5{args = {'yes', 'yes'}})
print(header.tutor6{args = {'yes', 'yes'}})
print(header.tutor7{args = {'yes', 'yes', 'yes'}})
print(render.entry{args={'Movelist-entry.tutor',
"[[€148|X|X|X|X|yes|yes|yes|yes|yes|yes|yes|no|no|yes|STAB='''£]]",
"[[€487|X|X|X|X|no|yes|yes|yes|yes|yes|yes|yes|no|yes|STAB='''|form=originale£]]",
"[[€646|X|X|X|X|no|no|no|no|yes|yes|yes|yes|no|no|STAB='''|form=nero£]]",
"[[€715|X|X|X|X|no|no|no|no|no|yes|yes|no|no|yes|STAB='''£]]",
"[[€718|X|X|X|X|no|no|no|no|no|yes|yes|yes|yes|yes|STAB='''£]]",
"[[€284|X|X|X|X|no|no|no|no|no|no|yes|yes|no|no£]]",}})
print(header.footer{args={'drago'}})


mw.title.setTitle("Eterelama")
print(header.Eventh{args = {'volante'}})
print(header.div{args={'4'}})
print(entry.Event{args={'491', 'Darkrai', '1', 'Buio', 'Buio', '[[F10|Evento decimo film]]<br>Toys "R" Us e Nintendo World Store<br>Darkrai Alamos europeo<br>Darkrai Alamos australano'}})
print(entry.Event{args={'493', 'Arceus', '1', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492C', 'Shaymin', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'493', 'Arceus', 'Normale', 'Normale', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''", allforms = 'yes'}})
print(header.footer{args={'volante'}})


mw.title.setTitle("Azione")
print(header.Eventh{args = {'Normale'}})
print(header.div{args={'4'}})
print(entry.Event{args={'422E', 'My Pokémon Ranch', useless = 'yes'}})
print(header.footer{args={'Normale'}})
end
