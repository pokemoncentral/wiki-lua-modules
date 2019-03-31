-- "Test cases" for evobox

local evobox = require('Evobox')

-- ============================ Evobox (automatic) =============================
if true then
	-- Standard
	print(evobox.Evobox{args={'Squirtle'}})
	-- No evos
	print(evobox.Evobox{args={'Tauros'}})
	-- With notes
	print(evobox.Evobox{args={'Burmy'}})
	print(evobox.Evobox{args={'Burmy', form = "Sc"}})
	print(evobox.Evobox{args={'Mothim'}})
	print(evobox.Evobox{args={'Basculin'}})
	print(evobox.Evobox{args={'Basculin', form = "B"}})
	print(evobox.Evobox{args={'Floette'}})
	print(evobox.Evobox{args={'Floette', form = "Bl"}})
	-- Trade
	print(evobox.Evobox{args={'Abra'}})
	-- Happiness
	print(evobox.Evobox{args={'Golbat'}})
	-- Baby Pokémon, happiness
	print(evobox.Evobox{args={'Lucario'}})
	-- Incense, held, time, evostone
	print(evobox.Evobox{args={'Chansey'}})
	-- Incense, move
	print(evobox.Evobox{args={'Sudowoodo'}})
	-- Trade for a specific Pokémon
	print(evobox.Evobox{args={'Escavalier'}})
	-- Held item, time
	print(evobox.Evobox{args={'Gliscor'}})
	-- Location
	print(evobox.Evobox{args={'Magneton'}})
	-- Branched evolution at second level, trade with item, evostone
	print(evobox.Evobox{args={'Poliwag'}})
	-- Branched evolution at first level, evostone, gender
	print(evobox.Evobox{args={'Snorunt'}})
	-- Wurmple, branched at phase one AND two
	print(evobox.Evobox{args={'Wurmple'}})
	-- Dustox, branched at phase one AND two with prune
	print(evobox.Evobox{args={'Dustox'}})
	-- Alolan form
	print(evobox.Evobox{args={'Geodude', form = 'A'}})
	-- Baby, alternative form
	print(evobox.Evobox{args={'Pikachu'}})
	print(evobox.Evobox{args={'Raichu', form = 'A'}})
	-- Methdo OTHER
	print(evobox.Evobox{args={'Meltan'}})
	-- No prune
	print(evobox.Evobox{args={'Exeggutor', prune = 'no'}})
	-- Evoinfo, prune at higher level
	print(evobox.Evobox{args={'Sylveon'}})
	-- More than 2 phase one
	print(evobox.Evobox{args={'Tyrogue'}})
	print(evobox.Evobox{args={'Lycanroc', prune = 'no'}})
	-- Feebas
	print(evobox.Evobox{args={'Feebas'}})
	-- Nincada
	print(evobox.Evobox{args={'Nincada'}})
	-- Eevee
	print(evobox.Evobox{args={'Eevee'}})
	-- Phione
	print(evobox.Evobox{args={'Phione'}})
end

-- ============================ Formbox with parameters ========================
if true then
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

	-- Pokémon without evolutions, two equal types and disptype
	print(evobox.GlitchEvobox{args={'normale',
		name1="Tauros", sprite1='128', ["type1-1"]="normale",
		["type2-1"] = "normale", ["disptype2-1"] = "glitch"
	}})

	-- With notes
	print(evobox.GlitchEvobox{args={
	"acqua", "spettro",
	family='Normale',
	name1='Frillish',sprite1='592',["type1-1"]="acqua", ["type2-1"]="spettro",
	form1='Maschio',
	evotype1='Livello',level1='40',
	name2='Jellicent',sprite2='593',["type1-2"]="acqua", ["type2-2"]="spettro",
	form2='Maschio'
	}})

	-- Evolution by trade
	print(evobox.GlitchEvobox{args={
	"erba", "spettro",
	family='Normale',
	name1='Pumpkaboo', sprite1='710', ["type1-1"]="erba", ["type2-1"]="spettro",
	evotype1='Scambio',
	name2='Gourgeist', sprite2='711', ["type1-2"]="erba", ["type2-2"]="spettro",
	}})

	-- Level, Happiness
	print(evobox.GlitchEvobox{args={
	"veleno", "volante",
	family='Normale',
	name1="Zubat", sprite1='041', ["type1-1"]="veleno", ["type2-1"]="volante",
	evotype1='Livello',	level1='22',
	name2="Golbat", sprite2='042', ["type1-2"]="veleno", ["type2-2"]="volante",
	evotype2='Felicità',
	name3="Crobat", sprite3='169', ["type1-3"]="veleno", ["type2-3"]="volante",
	}})

	-- Glitch, branches of different height
	print(evobox.GlitchEvobox{args={
		"Uccello", "Normale",
		family="Normale",
		sprite1="Missingno RB", name1="File:GlitchName00.png",
		["type1-1"]="Uccello",["type2-1"]="Normale",
		evotype1="Livello",level1="0",
		sprite2="Sprrb115",name2="Kangaskhan", ["type1-2"]="Normale",
		evotype1a="Livello",level1a="128",
		sprite2a="Sprrb035", name2a="Clefairy", ["type1-2a"]="Normale",
		name3="None",
		evotype2a="Pietra", evostone2a="Pietralunare",
		sprite3a="Sprrb036",name3a="Clefable",["type1-3a"]="Normale"
	}})

	print(evobox.GlitchEvobox{args={
		"Uccello", "Normale",
		sprite1="Missingno RB",
		name1="Missingno.",
		forme1="RB",
		loc1="36 numeri d'indice.",
		["type1-1"]="Uccello",
		["type2-1"]="Normale",
		["disptype1-1"]="sconosciuto",
		evotype1="double",
		evoinfo1="&nbsp;",
		name2="Missingno.",
		sprite2="Missingno Y",
		forme2="Giallo",
		loc2="36 numeri d'indice.",
		["type1-2"]="Normale",
		["type2-2"]="999",
		["disptype2-2"]="sconosciuto"
	}})
end
