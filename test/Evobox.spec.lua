-- "Test cases" for evobox

local evobox = require('Evobox')

-- ============================ Formbox with parameters ========================
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
	print(evobox.Formbox{args={
	'Giratina',
	sprite1='487',
	loc1='{{colore2|000|Mondo Pokémon}},<br>senza tenere la {{colore2|000|Grigiosfera}}',
	item1='Grigiosfera',
	sprite2='487O',
	loc2='{{colore2|000|Mondo Distorto}}<br>o tenendo la {{colore2|000|Grigiosfera}}'
	}})

	-- Megaevo
	print(evobox.Formbox{args={
	'Aerodactyl',
	sprite1='142',
	item1='Aerodactylite',
	sprite2='142M',
	}})

	-- Branched
	print(evobox.Formbox{args={
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
	print(evobox.Formbox{args={
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

-- ============================ Evobox (automatic) =============================
if false then
	-- Standard
	-- print(evobox.Evobox{args={'Staraptor'}})
	-- No evos
	-- print(evobox.Evobox{args={'Giratina'}})
	-- With notes
	-- print(evobox.Evobox{args={'Frillish'}})
	-- Trade
	print(evobox.Evobox{args={'Abra'}})
	-- Happiness
	print(evobox.Evobox{args={'Golbat'}})
	-- Baby Pokémon, happiness
	-- print(evobox.Evobox{args={'Lucario'}})
	-- Incense, held, time, evostone
	print(evobox.Evobox{args={'Chansey'}})
	-- Incense, move
	-- print(evobox.Evobox{args={'Sudowoodo'}})
	-- Trade for a specific Pokémon
	-- print(evobox.Evobox{args={'Escavalier'}})
	-- Held item, time
	-- print(evobox.Evobox{args={'Gliscor'}})
	-- Location
	print(evobox.Evobox{args={'Magneton'}})
	-- Branched evolution at second level, trade with item, evostone
	print(evobox.Evobox{args={'Poliwag'}})
	-- Branched evolution at first level, evostone, gender
	-- print(evobox.Evobox{args={'Snorunt'}})
	-- Wurmple, branched at phase one AND two
	-- print(evobox.Evobox{args={'Wurmple'}})
	-- Dustox, branched at phase one AND two with prune
	-- print(evobox.Evobox{args={'Dustox'}})
	-- Baby, alternate form
	-- print(evobox.Evobox{args={'RaichuA'}})
	-- Evoinfo, prune at higher level
	print(evobox.Evobox{args={'Sylveon'}})
	-- More than 2 phase one
	print(evobox.Evobox{args={'Tyrogue'}})
	-- Feebas
	-- print(evobox.Evobox{args={'Feebas'}})
	-- Nincada
	-- print(evobox.Evobox{args={'Nincada'}})
	-- Eevee
	print(evobox.Evobox{args={'Eevee'}})
end


-- ============================ GlitchEvobox (parameters) ======================
if true then
	-- Something normal first
	print(evobox.GlitchEvobox{args={
	'normale', "volante",
	family='Normale',
	name1="Starly", sprite1='396', ["type1-1"]="normale", ["type2-1"]="volante",
	evotype1='Livello', level1='14',
	name2="Staravia", sprite2='397', ["type1-2"]="normale", ["type2-2"]="volante",
	evotype2='Livello', level2='34',
	name3="Staraptor", sprite3='398', ["type1-3"]="normale", ["type2-3"]="volante",
	}})

	-- -- Pokémon without evolutions
	-- print(evobox.GlitchEvobox{args={'Tauros', sprite1='128'}})
    --
	-- -- With notes
	-- print(evobox.GlitchEvobox{args={
	-- 'Frillish',
	-- family='Normale',
	-- sprite1='592',
	-- form1='Maschio',
	-- evotype1='Livello',
	-- level1='40',
	-- sprite2='593',
	-- form2='Maschio'
	-- }})
    --
	-- -- Evolution by trade
	-- print(evobox.GlitchEvobox{args={
	-- 'Gourgeist',
	-- family='Normale',
	-- sprite1='710',
	-- evotype1='Scambio',
	-- sprite2='711',
	-- }})
    --
	-- -- Level, Happiness
	-- print(evobox.GlitchEvobox{args={
	-- 'Golbat',
	-- family='Normale',
	-- sprite1='041',
	-- evotype1='Livello',
	-- level1='22',
	-- sprite2='042',
	-- evotype2='Felicità',
	-- sprite3='169'
	-- }})
    --
	-- -- Baby Pokémon, happiness
	-- print(evobox.GlitchEvobox{args={
	-- 'Lucario',
	-- family='Baby',
	-- sprite1='447',
	-- evotype1='Felicità',
	-- time1='Giorno',
	-- sprite2='448',
	-- }})
    --
	-- -- Incense, held, time, evostone
	-- print(evobox.GlitchEvobox{args={
	-- 'Chansey',
	-- family='Incenso',
	-- sprite1='440',
	-- evotype1='Ogg. Tenuto',
	-- held1='Pietraovale',
	-- time1='Giorno',
	-- incense='Fortunaroma',
	-- sprite2='113',
	-- evotype2='Felicità',
	-- sprite3='242'
	-- }})
    --
	-- -- Incense, move
	-- print(evobox.GlitchEvobox{args={
	-- 'Sudowoodo',
	-- family='Incenso',
	-- sprite1='438',
	-- evotype1='Mossa',
	-- move1='Mimica',
	-- incense='Roccioaroma',
	-- sprite2='185'
	-- }})
    --
	-- -- Trade for a specific Pokémon
	-- print(evobox.GlitchEvobox{args={
	-- 'Escavalier',
	-- family='Normale',
	-- sprite1='588',
	-- evotype1='Scambio',
	-- ms1='616',
	-- sprite2='589'
	-- }})
    --
	-- -- Held item, time
	-- print(evobox.GlitchEvobox{args={
	-- 'Gliscor',
	-- family='Normale',
	-- sprite1='207',
	-- evotype1='Ogg. Tenuto',
	-- held1='Affilodente',
	-- time1='Notte',
	-- sprite2='472'
	-- }})
    --
	-- -- Location
	-- print(evobox.GlitchEvobox{args={
	-- 'Magneton',
	-- family='Normale',
	-- sprite1='081',
	-- evotype1='Livello',
	-- level1='30',
	-- sprite2='082',
	-- evotype2='Posizione',
	-- location2='campo magnetico speciale',
	-- sprite3='462'
	-- }})
    --
	-- -- Branched evolution at second level, trade with item, evostone
	-- print(evobox.GlitchEvobox{args={
	-- 'Poliwag',
	-- family='Normale',
	-- sprite1='060',
	-- evotype1='Livello',
	-- level1='25',
	-- sprite2='061',
	-- evotype2='Pietra',
	-- evostone2='Pietraidrica',
	-- sprite3='062',
	-- evotype2a='Scambio',
	-- held2a='Roccia di Re',
	-- sprite3a='186'
	-- }})
    --
	-- -- Branched evolution at first level, evostone, gender
	-- print(evobox.GlitchEvobox{args={
	-- 'Snorunt',
	-- family='normale',
	-- sprite1='361',
	-- evotype1='Livello',
	-- level1='42',
	-- sprite2='362',
	-- evotype1a='Pietra',
	-- evostone1a='Pietralbore',
	-- gender1a='Femmina',
	-- sprite2a='478'
	-- }})
    --
	-- -- Wurmple, branched at phase one AND two
	-- print(evobox.GlitchEvobox{args={
	-- 'Wurmple',
	-- family='Normale',
	-- sprite1='265',
	-- evotype1='Livello',
	-- level1='7',
	-- sprite2='266',
	-- evotype2='Livello',
	-- level2='10',
	-- sprite3='267',
	-- evotype1a='Livello',
	-- level1a='7',
	-- sprite2a='268',
	-- evotype2a='Livello',
	-- level2a='10',
	-- sprite3a='269',
	-- }})
    --
	-- -- Evoinfo
	-- print(evobox.GlitchEvobox{args={
	-- 'Sylveon',
	-- family='Normale',
	-- sprite1='133',
	-- evotype1='Livello',
	-- level1='qualsiasi',
	-- evotype1info='con due cuori di {{colore2|000|amicizia}}<br>avendo appreso una mossa di tipo {{colore2|000|Folletto}}',
	-- sprite2='700'
	-- }})
    --
	-- -- Feebas
	-- print(evobox.GlitchEvobox{args={
	-- 'Feebas',
	-- family='Normale',
	-- sprite1='349',
	-- evotype1='Scambio',
	-- held1='Squama Bella',
	-- evotype1info='o<br>{{bag|Fascia Blu}}<br>{{colore2|000|Livello|Aumento di livello}}<br>con la {{colore2|000|Bellezza (virtù)|virtù Bellezza}} alta',
	-- sprite2='350'
	-- }})
    --
	-- -- Nincada
	-- print(evobox.GlitchEvobox{args={
	-- 'Nincada',
	-- family='Normale',
	-- sprite1='290',
	-- evotype1='Livello',
	-- level1='20',
	-- sprite2='291',
	-- evotype1a='other',
	-- evotype1ainfo='{{bag|Poké Ball}}<br>Con spazio in {{colore2|000|squadra}}<br>e almeno una {{colore2|000|Poké Ball}} nello {{colore2|000|zaino}}',
	-- sprite2a='292'
	-- }})
end
