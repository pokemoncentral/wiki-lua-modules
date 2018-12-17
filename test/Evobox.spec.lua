-- "Test cases" for evobox

local evobox = require('Evobox')

-- ============================= Evobox with parameters ========================
if false then
	-- Something normal first
	print(evobox.Evobox{args={
	'Bulbasaur',
	family='Normale',
	sprite1='001',
	evotype1='Livello',
	level1='16',
	sprite2='002',
	evotype2='Livello',
	level2='32',
	sprite3='003'
	}})

	print(evobox.Evobox{args={
	'Staraptor',
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
	print(evobox.Evobox{args={'Tauros', sprite1='128'}})

	-- With notes
	print(evobox.Evobox{args={
	'Frillish',
	family='Normale',
	sprite1='592',
	form1='Maschio',
	evotype1='Livello',
	level1='40',
	sprite2='593',
	form2='Maschio'
	}})

	-- Evolution by trade
	print(evobox.Evobox{args={
	'Gourgeist',
	family='Normale',
	sprite1='710',
	evotype1='Scambio',
	sprite2='711',
	}})

	-- Level, Happiness
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
	'Lucario',
	family='Baby',
	sprite1='447',
	evotype1='Felicità',
	time1='Giorno',
	sprite2='448',
	}})

	-- Incense, held, time, evostone
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
	'Sudowoodo',
	family='Incenso',
	sprite1='438',
	evotype1='Mossa',
	move1='Mimica',
	incense='Roccioaroma',
	sprite2='185'
	}})

	-- Trade for a specific Pokémon
	print(evobox.Evobox{args={
	'Escavalier',
	family='Normale',
	sprite1='588',
	evotype1='Scambio',
	ms1='616',
	sprite2='589'
	}})

	-- Held item, time
	print(evobox.Evobox{args={
	'Gliscor',
	family='Normale',
	sprite1='207',
	evotype1='Ogg. Tenuto',
	held1='Affilodente',
	time1='Notte',
	sprite2='472'
	}})

	-- Location
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
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
	print(evobox.Evobox{args={
	'Sylveon',
	family='Normale',
	sprite1='133',
	evotype1='Livello',
	level1='qualsiasi',
	evotype1info='con due cuori di {{colore2|000|amicizia}}<br>avendo appreso una mossa di tipo {{colore2|000|Folletto}}',
	sprite2='700'
	}})

	-- More than 2 phase one
	print(evobox.Evobox{args={
	'Rockruff',
	family='Normale',
	sprite1='744',
	evotype1='Livello',
	level1='25',
	time1='Giorno',
	sprite2='745',
	evotype1a='Livello',
	level1a='25',
	time1a='Notte',
	sprite2a='745N',
	evotype1b='Livello',
	level1b='25',
	time1b="con l'abilità [[Mente Locale]]<br>tra le 17:00 e le 17:59{{#invoke:sup|US}} / le 5:00 e le 5:59{{#invoke:sup|Ul}}, ora del 3DS",
	sprite2b='745C',
	}})

	-- Feebas
	print(evobox.Evobox{args={
	'Feebas',
	family='Normale',
	sprite1='349',
	evotype1='Scambio',
	held1='Squama Bella',
	evotype1info='o<br>{{bag|Fascia Blu}}<br>{{colore2|000|Livello|Aumento di livello}}<br>con la {{colore2|000|Bellezza (virtù)|virtù Bellezza}} alta',
	sprite2='350'
	}})

	-- Nincada
	print(evobox.Evobox{args={
	'Nincada',
	family='Normale',
	sprite1='290',
	evotype1='Livello',
	level1='20',
	sprite2='291',
	evotype1a='other',
	evotype1ainfo='{{bag|Poké Ball}}<br>Con spazio in {{colore2|000|squadra}}<br>e almeno una {{colore2|000|Poké Ball}} nello {{colore2|000|zaino}}',
	sprite2a='292'
	}})

	-- Eevee
	print(evobox.Evobox{args={
	'Eevee',
	family='Normale',
	sprite1='133',
	evotype1='Pietra',
	evostone1='Pietraidrica',
	sprite2='134',
	evotype1a='Pietra',
	evostone1a='Pietratuono',
	sprite2a='135',
	evotype1b='Pietra',
	evostone1b='Pietrafocaia',
	sprite2b='136',
	evotype1c='Felicità',
	time1c='Giorno',
	sprite2c='196',
	evotype1d='Felicità',
	time1d='Notte',
	sprite2d='197',
	evotype1e='Posizione',
	location1e='Roccia Muschio',
	sprite2e='470',
	evotype1f='Posizione',
	location1f='Roccia Ghiaccio',
	sprite2f='471',
	evotype1g='Livello',
	level1g='qualsiasi',
	evotype1ginfo='con due cuori di {{colore2|000|amicizia}}<br>avendo appreso una mossa di tipo {{colore2|000|Folletto}}',
	sprite2g='700'
	}})
end

-- ============================= Formbox with parameters ========================
if false then
	-- Something normal
	print(evobox.Formbox{args={
	'Castform',
	sprite1='351',
	loc1='{{colore2|000|condizione atmosferica|Normale}}',
	sprite2='351S',
	loc2='{{colore2|000|condizione atmosferica#Luce solare intensa|Sole}}',
	sprite3='351P',
	loc3='{{colore2|000|condizione atmosferica#Pioggia battente|Pioggia}}',
	sprite4='351N',
	loc4='{{colore2|000|condizione atmosferica#Grandinata|Grandine}}'
	}})

	-- With item
	print(formbox{args={
	'Giratina',
	sprite1='487',
	loc1='{{colore2|000|Mondo Pokémon}},<br>senza tenere la {{colore2|000|Grigiosfera}}',
	item1='Grigiosfera',
	sprite2='487O',
	loc2='{{colore2|000|Mondo Distorto}}<br>o tenendo la {{colore2|000|Grigiosfera}}'
	}})

	-- Megaevo
	print(formbox{args={
	'Aerodactyl',
	sprite1='142',
	item1='Aerodactylite',
	sprite2='142M',
	}})

	-- Branched
	print(formbox{args={
	'Necrozma',
	sprite1='800',
	item1='Necrosolix',
	sprite2='800V',
	loc2='{{#invoke: MiniSprite | static | 791}} con {{colore2|000|Solgaleo}}',
	item1a='Necrolunix',
	sprite2a='800A',
	loc2a='{{#invoke: MiniSprite | static | 792}} con {{colore2|000|Lunala}}',
	item2='Ultranecrozium Z',
	sprite3='800U'
	}})

	-- Rotom (extra large)
	print(formbox{args={
	'Rotom',
	sprite1='479',
	loc1='Normale',
	sprite2='479C',
	loc2='Forno',
	sprite3='479L',
	loc3='Lavatrice',
	sprite4='479G',
	loc4='Frigorifero',
	sprite5='479V',
	loc5='Ventilatore',
	sprite6='479T',
	loc6='Tagliaerba'
	}})
end

-- ============================= Evobox2 (automatic) ========================
if true then
	-- Standard
	-- print(evobox.Evobox2{args={'Staraptor'}})
	-- No evos
	-- print(evobox.Evobox2{args={'Giratina'}})
	-- With notes
	-- print(evobox.Evobox2{args={'Frillish'}})
	-- Trade
	print(evobox.Evobox2{args={'Abra'}})
	-- Happiness
	print(evobox.Evobox2{args={'Golbat'}})
	-- Baby Pokémon, happiness
	-- print(evobox.Evobox2{args={'Lucario'}})
	-- Incense, held, time, evostone
	print(evobox.Evobox2{args={'Chansey'}})
	-- Incense, move
	-- print(evobox.Evobox2{args={'Sudowoodo'}})
	-- Trade for a specific Pokémon
	-- print(evobox.Evobox2{args={'Escavalier'}})
	-- Held item, time
	-- print(evobox.Evobox2{args={'Gliscor'}})
	-- Location
	print(evobox.Evobox2{args={'Magneton'}})
	-- Branched evolution at second level, trade with item, evostone
	print(evobox.Evobox2{args={'Poliwag'}})
	-- Branched evolution at first level, evostone, gender
	-- print(evobox.Evobox2{args={'Snorunt'}})
	-- Wurmple, branched at phase one AND two
	-- print(evobox.Evobox2{args={'Wurmple'}})
	-- Baby, alternate form
	-- print(evobox.Evobox2{args={'RaichuA'}})
	-- Evoinfo, trim at higher level
	print(evobox.Evobox2{args={'Sylveon'}})
	-- More than 2 phase one
	print(evobox.Evobox2{args={'Tyrogue'}})
	-- Feebas
	-- print(evobox.Evobox2{args={'Feebas'}})
	-- Nincada
	-- print(evobox.Evobox2{args={'Nincada'}})
	-- Eevee
	print(evobox.Evobox2{args={'Eevee'}})
end
