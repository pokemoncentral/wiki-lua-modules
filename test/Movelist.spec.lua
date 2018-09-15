local render = require('Render')
local header = require('Movelist-hf')
local entry = require('Movelist-entry')


print(header.Levelh{args={'Elettro', '4'}})
print(render.entry{args={'Movelist-entry.Level',
"[[€4|025Co|26|22|20|B2W2=10|12|USUM=40|STAB='''|useless=yes£]]",
"[[€4|361|26|22|20|9000|STAB='''£]]",
"[[€4|598|26|22|20|213|STAB='''£]]",
"[[€4|377|50|49|48|no£]]",
"[[€4|376|50|49|48|2£]]",
"[[€4|398|50|49|48|no£]]",
"[[€4|720L|50|49|48|no£]]",
"[[€4|720|50|49|48|no£]]",}})
print(header.levelf{args={'Elettro'}})



print(header.Breedh{args = {'Ghiaccio', '3'}})
print(render.entry{args={'Movelist-entry.breed',
[[€3|276|no|#396##397##398#|PtHGSS=#627##628#|no|#580##581##627##628#|ORAS=no|N/D|STAB='''£]],
[[€3|731|no|E=''ciao''|no|no|''antani''|N/D|STAB='''£]],
[[€3|111|no|#024##059##135##209##210##229##232##248##295##309##310##403##404##405##450#|#024##059##135##209##210##229##232##248##295##309##310##403##404##405##450##508#|#024##059##135##209##210##229##232##248##262##295##309##310##403##404##405##450##508#|#024##059##135##209##210##229##232##248##262##295##309##310##403##404##405##450##508#|USUM=#001##002##498#£]]}})
print(header.footer{args={'Ghiaccio'}})


print(header.TMh{args = {'Ghiaccio', '1', 'MT13', 'no', 'MT13', 'MT13', 'MT13', 'MT13', 'MT13'}})
print(render.entry{args={'Movelist-entry.TM',
"[[€1|116|yes|no|yes|yes|yes|yes|yes£]]",
"[[€1|117|yes|no|yes|yes|yes|yes£]]",
"[[€1|199|no|no|yes|yes|yes|yes£]]",
"[[€1|359|no|no|yes|yes|yes|yes£]]",
"[[€1|368|no|no|yes|yes|yes|yes£]]",
"[[€1|478|no|no|no|yes|yes|yes|STAB='''£]]",
"[[€1|713|no|no|no|no|no|yes|yes|STAB='''£]]"}})
print(header.footer{args={'Ghiaccio'}})



print(header.tutorh{args = {'drago', '8'}})
print(header.tutor4{args = {'yes', 'yes', 'yes'}})
print(header.tutor5{args = {'yes', 'yes'}})
print(header.tutor6{args = {'yes', 'yes'}})
print(header.tutor7{args = {'yes', 'yes'}})
print(render.entry{args={'Movelist-entry.tutor',
"[[€148|X|X|X|X|yes|yes|yes|yes|yes|yes|yes|no|no|STAB='''£]]",
"[[€487|X|X|X|X|no|yes|yes|yes|yes|yes|yes|yes|no|STAB='''|form=originale£]]",
"[[€646|X|X|X|X|no|no|no|no|yes|yes|yes|yes|no|STAB='''|form=nero£]]",
"[[€715|X|X|X|X|no|no|no|no|no|yes|yes|no|no|STAB='''£]]",
"[[€718|X|X|X|X|no|no|no|no|no|yes|yes|yes|yes|STAB='''£]]",
"[[€284|X|X|X|X|no|no|no|no|no|no|yes|yes|no£]]",}})
print(header.footer{args={'drago'}})


print(header.Eventh{args = {'drago'}})
print(header.div{args={'4'}})
print(entry.Event{args={'491', 'Darkrai', '1', 'Buio', 'Buio', '[[F10|Evento decimo film]]<br>Toys "R" Us e Nintendo World Store<br>Darkrai Alamos europeo<br>Darkrai Alamos australano'}})
print(entry.Event{args={'493', 'Arceus', '1', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'492C', 'Shaymin', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''"}})
print(entry.Event{args={'493', 'Arceus', 'Normale', 'Normale', '[[F12|Evento dodicesimo film]]<br>Arceus Michina australano<br>Toys "R" Us Arceus<br>Arceus Michina europeo', "''", allforms = 'yes'}})
print(header.footer{args={'drago'}})



print(header.Eventh{args = {'Normale'}})
print(header.div{args={'4'}})
print(entry.Event{args={'422E', 'My Pokémon Ranch', useless = 'yes'}})
print(header.footer{args={'Normale'}})
