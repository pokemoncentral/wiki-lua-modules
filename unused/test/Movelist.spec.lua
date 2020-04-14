local render = require('Render')
local header = require('Movelist-hf')
local ml = require('Movelist')
local mw = require('mw')

-- ================================ Level =================================
print(header.Levelh{args={'Elettro', '1'}})
mw.title.setTitle("Fulmine")
print(render.entry{args={'Movelist.levelentry',
"[[€025Co|LGPE=10|useless=yes£]]",
"[[€493|LGPE=10|allforms=yes|STAB=''£]]",
"[[€738£]]",
"[[€738|LGPE=10£]]",
"[[€720£]]",}})
mw.title.setTitle("Frustata")
print(render.entry{args={'Movelist.levelentry',
"[[€001|LGPE=5£]]",
"[[€398£]]",}})
mw.title.setTitle("Botta")
print(ml.levelentry{args={"035"}})
mw.title.setTitle("Morso")
print(render.entry{args={'Movelist.levelentry',
"[[€052|LGPE=5£]]",
"[[€052A£]]",}})
print(header.levelf{args={}})

print(header.Levelh{args={'Buio', '2'}})
mw.title.setTitle("Picchiaduro")
print(ml.levelentry{args={"215"}})
print(header.levelf{args={'Elettro'}})

-- ================================ Breed =================================
print(header.Breedh{args = {'Veleno', '2'}})
mw.title.setTitle("Fango")
print(render.entry{args={'Movelist.breedentry',
"[[€422E|useless=yes£]]",}})
print(header.breedf{args={}})

print(header.Breedh{args = {'Ghiaccio', '3'}})
mw.title.setTitle("Palla Gelo")
print(render.entry{args={'Movelist.breedentry',
"[[€225£]]",}})
print(header.breedf{args={}})

print(header.Breedh{args = {'Buio', '4'}})
mw.title.setTitle("Punizione")
print(render.entry{args={'Movelist.breedentry',
"[[€198£]]",}})
print(header.breedf{args={}})

print(header.Breedh{args = {'Roccia', '5'}})
mw.title.setTitle("Bodyguard")
print(render.entry{args={'Movelist.breedentry',
"[[€075£]]",}})
print(header.breedf{args={}})

-- ================================== Tm ==================================
mw.title.setTitle("Cuordileone")
print(ml.TMh{args = {}})
print(render.entry{args={'Movelist.tmentry',
"[[€807£]]",
"[[€019£]]",}})
print(header.footer{args={}})
mw.title.setTitle("Cascata")
print(ml.TMh{args = {}})
print(render.entry{args={'Movelist.tmentry',
"[[€007|LGPE=yes£]]",}})
print(header.footer{args={}})
mw.title.setTitle("Sub")
print(ml.TMh{args = {}})
print(render.entry{args={'Movelist.tmentry',
"[[€007£]]",}})
print(header.footer{args={}})
mw.title.setTitle("Scacciabruma")
print(ml.TMh{args = {}})
print(render.entry{args={'Movelist.tmentry',
"[[€398£]]",}})
print(header.footer{args={}})

-- ================================ Tutor =================================
print(ml.tutorhlua("gastroacido"))
mw.title.setTitle("Gastroacido")
print(render.entry{args={'Movelist.tutorentry',
[[€023£]],
[[€088A£]],
[[€336£]],
[[€455£]],
[[€511£]],
[[€631£]],
[[€804£]]}})
print(header.footer{args={'veleno'}})

print(ml.tutorhlua("raggio d'acciaio"))
mw.title.setTitle("Raggio d'Acciaio")
print(render.entry{args={'Movelist.tutorentry',
[[€823£]],
[[€600£]],
[[€052G£]]}})
print(header.footer{args={'veleno'}})

-- ================================ Event =================================
print(header.Eventh{args = {'normale'}})
print(header.div{args={'4'}})
mw.title.setTitle("Azione")
print(render.entry{args={'Movelist.evententry',
[[€493|Evento dodicesimo film<br>Arceus Michina australiano<br>Toys "R" Us Arceus<br>Arceus Michina europeo£]]}})
mw.title.setTitle("Idropompa")
print(render.entry{args={'Movelist.evententry',
[[€479|Cambio di forma£]]}})
print(header.footer{args={}})
