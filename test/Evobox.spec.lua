-- "Test cases" for debRes

local evobox = require('Evobox').Evobox

-- Somethign normal first
print(evobox{args={
pagename='Bulbasaur',
family='Normale',
sprite1='001',
evotype1='Livello',
level1='16',
sprite2='002',
evotype2='Livello',
level2='32',
sprite3='003'
}})

print(evobox{args={
pagename='Staraptor',
family='Normale',
sprite1='396',
evotype1='Livello',
level1='14',
sprite2='397',
evotype2='Livello',
level2='34',
sprite3='398'
}})

-- Pokémon without evolutions
print(evobox{args={'Tauros', sprite1='128'}})

-- With notes
print(evobox{args={
pagename='Frillish',
family='Normale',
sprite1='592',
form1='Maschio',
evotype1='Livello',
level1='40',
sprite2='593',
form2='Maschio'
}})

-- Evolution by trade
print(evobox{args={
pagename='Gourgeist',
family='Normale',
sprite1='710',
evotype1='Scambio',
sprite2='711',
}})

-- Level, Happiness
print(evobox{args={
'Golbat',
family='Normale',
sprite1='041',
evotype1='Livello',
level1='22',
sprite2='042',
evotype2='Felicità',
sprite3='169'
}})

-- Baby Pokémon, happiness
print(evobox{args={
'Lucario',
family='Baby',
sprite1='447',
evotype1='Felicità',
time1='Giorno',
sprite2='448',
}})

-- Incense, held, time, evostone
print(evobox{args={
'Chansey',
family='Incenso',
sprite1='440',
evotype1='Ogg. Tenuto',
held1='Pietraovale',
time1='Giorno',
incense='Fortunaroma',
sprite2='113',
evotype2='Felicità',
sprite3='242'
}})

-- Incense, move
print(evobox{args={
'Sudowoodo',
family='Incenso',
sprite1='438',
evotype1='Mossa',
move1='Mimica',
incense='Roccioaroma',
sprite2='185'
}})

-- Trade for a specific Pokémon
print(evobox{args={
'Escavalier',
family='Normale',
sprite1='588',
evotype1='Scambio',
ms1='616',
sprite2='589'
}})

-- Held item, time
print(evobox{args={
'Gliscor',
family='Normale',
sprite1='207',
evotype1='Ogg. Tenuto',
held1='Affilodente',
time1='Notte',
sprite2='472'
}})

-- Location
print(evobox{args={
'Magneton',
family='Normale',
sprite1='081',
evotype1='Livello',
level1='30',
sprite2='082',
evotype2='Posizione',
location2='campo magnetico speciale',
sprite3='462'
}})

-- Branched evolution at second level, trade with item, evostone
print(evobox{args={
'Poliwag',
family='Normale',
sprite1='060',
evotype1='Livello',
level1='25',
sprite2='061',
evotype2='Pietra',
evostone2='Pietraidrica',
sprite3='062',
evotype2a='Scambio',
held2a='Roccia di Re',
sprite3a='186'
}})

-- Branched evolution at first level, evostone, gender
print(evobox{args={
'Snorunt',
family='normale',
sprite1='361',
evotype1='Livello',
level1='42',
sprite2='362',
evotype1a='Pietra',
evostone1a='Pietralbore',
gender1a='Femmina',
sprite2a='478'
}})

-- Wurmple, branche ad phase one AND two
print(evobox{args={
'Wurmple',
family='Normale',
sprite1='265',
evotype1='Livello',
level1='7',
sprite2='266',
evotype2='Livello',
level2='10',
sprite3='267',
evotype1a='Livello',
level1a='7',
sprite2a='268',
evotype2a='Livello',
level2a='10',
sprite3a='269',
}})

-- Baby, alternate form
print(evobox{args={
'RaichuA',
family='Baby',
sprite1='172',
evotype1='Felicità',
sprite2='025',
evotype2='Pietra',
evostone2='Pietratuono',
sprite3='026A'
}})

-- Evoinfo
print(evobox{args={
'Sylveon',
family='Normale',
sprite1='133',
evotype1='Livello',
level1='qualsiasi',
evotype1info='+ ♥♥ di {{colore2|000|amicizia}}<br>+ conoscere una mossa di tipo {{colore2|000|Folletto}}',
sprite2='700'
}})

-- Feebas
print(evobox{args={
'Feebas',
family='Normale',
sprite1='349',
evotype1='Scambio',
held1='Squama Bella',
evotype1info='o<br>{{bag|Fascia Blu}}<br>{{colore2|000|Livello|Aumento di livello}}<br>con la {{colore2|000|Bellezza (virtù)|virtù Bellezza}} alta',
sprite2='350'
}})

-- Shedinja
print(evobox{args={
'Ninjask',
family='Normale',
sprite1='290',
evotype1='Livello',
level1='20',
sprite2='291',
evotype1a='other',
evotype1ainfo='{{bag|Poké Ball}}<br>Con spazio in {{colore2|000|squadra}}<br>e almeno una {{colore2|000|Poké Ball}} nello {{colore2|000|zaino}}',
sprite2a='292'
}})