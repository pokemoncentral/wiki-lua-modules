--[[

Data module for evolutionary families.

The structure of the module is as following: there's a table for each Pokémon,
containing the "ndex" and possibly other infos. The field "notes" contains a
string that is put above the sprite. The field "evos", if any, should contain an
array of tables of Pokémons that evolves from the Pokémon the table belongs to.
Other fields are used to describe the methods used to evolve into this Pokémon.
The field "method" should be one of the constants evo.methods.*, there may be a
field [evo.methods.THISMETHOD] if required by the method (see details after) and
a field conditions, that is a table indexed by evo.conditions.* with values as
described by the condition itself.

--]]

local mw = require('mw')

local tab = require('Wikilib-tables')  -- luacheck: no unused
local str = require('Wikilib-strings') -- luacheck: no unused
local links = require('Links')
local ms = require('MiniSprite')
local pokes = require("Poké-data")
local altforms = require("AltForms-data")
local useless = require("UselessForms-data")
local sup = require("Sup-data")

local evo = {}

--[[

Those two tables hold evolution methods and conditions common to multiple
evolutionary line. The meaning of each value is self-explanatory. There's a
special value, 'OTHER', that handles anything that is unique to a single line.

Method and condition 'OTHER' should be used ONLY to handle methods/conditions
that occur in AT MOST ONE evolutionary lines. Should that method/condition be
used again in a new evolutionary line, it's best if we add a new constant to
identify it.

Follows a detailed description of the use of each method and condition.

Methods:
	- OTHER: requires [evo.methods.OTHER] to contain the image to be printed.
			Doesn't have any default text but relies on the fact that it may be
			provided via OTHER condition if needed.
	- LEVEL: [evo.methods.LEVEL] may contain the level for evolution, if any,
			otherwise nil, meaning that evolution is possible at any level
			(given that all other conditions are met).
	- HAPPINESS: should be a condition for LEVEL method, but everywhere is
			considered a standalone method. Doesn't have any parameters.
	- STONE: requires [evo.methods.STONE] to be the name of the evostone.
	- TRADE: no parameters.
	- BREED: used in the baby form, showing that it may be breeded from the next
			phase.

--]]
evo.methods = {}
evo.methods.OTHER = 0
evo.methods.LEVEL = 1
evo.methods.HAPPINESS = 2
evo.methods.STONE = 3
evo.methods.TRADE = 4
evo.methods.BREED = 5
evo.methods.UNKNOWN = 6
--[[
Conditions:
	- OTHER: any custom text passed in this condition will be displayed.
	- TIME: time of the day, with first uppercase. Normally either "Giorno" or
			"Notte".
	- ITEM: the name of the item required for evolution, with correct case.
	- LOCATION: the place in which evolution may occur.
	- MOVE: the name of the move that has to be known by the Pokémon, lowercase.
	- GENDER: the gender required, with first uppercase.
	- TRADED_FOR: the ndex of the Pokémon required for the trade (makes sense
				only as a condition with TRADE method).
	- BREEDONLY: this condition specifies that the BREED doesn't imply the
				evolution, thus the second phase doesn't need a method and so.
				Make sense only as a condition with BREED method.

NB: the value false for a condition is reserved for multigen to signal that
that condition disappeared in a later generation

--]]
evo.conditions = {}
evo.conditions.OTHER = 0
evo.conditions.TIME = 1
evo.conditions.ITEM = 2
evo.conditions.LOCATION = 3
evo.conditions.MOVE = 4
evo.conditions.GENDER = 5
evo.conditions.TRADED_FOR = 6
evo.conditions.BREEDONLY = 7
evo.conditions.REGION = 8


evo.bulbasaur = {
	ndex = 1,
	name = 'bulbasaur',

	evos = {
		{
			ndex = 2,
			name = 'ivysaur',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 3,
					name = 'venusaur',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 32,
				}
			}
		}
	}
}
evo.ivysaur, evo.venusaur = evo.bulbasaur, evo.bulbasaur
evo[1], evo[2], evo[3] = evo.bulbasaur, evo.bulbasaur, evo.bulbasaur

evo.charmander = {
	ndex = 4,
	name = 'charmander',

	evos = {
		{
			ndex = 5,
			name = 'charmeleon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 6,
					name = 'charizard',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.charmeleon, evo.charizard = evo.charmander, evo.charmander
evo[4], evo[5], evo[6] = evo.charmander, evo.charmander, evo.charmander

evo.squirtle = {
	ndex = 7,
	name = 'squirtle',

	evos = {
		{
			ndex = 8,
			name = 'wartortle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 9,
					name = 'blastoise',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.wartortle, evo.blastoise = evo.squirtle, evo.squirtle
evo[7], evo[8], evo[9] = evo.squirtle, evo.squirtle, evo.squirtle

evo.caterpie = {
	ndex = 10,
	name = 'caterpie',

	evos = {
		{
			ndex = 11,
			name = 'metapod',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,

			evos = {
				{
					ndex = 12,
					name = 'butterfree',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 10,
				}
			}
		}
	}
}
evo.metapod, evo.butterfree = evo.caterpie, evo.caterpie
evo[10], evo[11], evo[12] = evo.caterpie, evo.caterpie, evo.caterpie

evo.weedle = {
	ndex = 13,
	name = 'weedle',

	evos = {
		{
			ndex = 14,
			name = 'kakuna',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,

			evos = {
				{
					ndex = 15,
					name = 'beedrill',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 10,
				}
			}
		}
	}
}
evo.kakuna, evo.beedrill = evo.weedle, evo.weedle
evo[13], evo[14], evo[15] = evo.weedle, evo.weedle, evo.weedle

evo.pidgey = {
	ndex = 16,
	name = 'pidgey',

	evos = {
		{
			ndex = 17,
			name = 'pidgeotto',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 18,
					name = 'pidgeot',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.pidgeotto, evo.pidgeot = evo.pidgey, evo.pidgey
evo[16], evo[17], evo[18] = evo.pidgey, evo.pidgey, evo.pidgey

evo.rattata = {
	ndex = 19,
	name = 'rattata',

	evos = {
		{
			ndex = 20,
			name = 'raticate',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.raticate = evo.rattata
evo[19], evo[20] = evo.rattata, evo.rattata

evo.spearow = {
	ndex = 21,
	name = 'spearow',

	evos = {
		{
			ndex = 22,
			name = 'fearow',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.fearow = evo.spearow
evo[21], evo[22] = evo.spearow, evo.spearow

evo.ekans = {
	ndex = 23,
	name = 'ekans',

	evos = {
		{
			ndex = 24,
			name = 'arbok',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.arbok = evo.ekans
evo[23], evo[24] = evo.ekans, evo.ekans

evo.pichu = {
	ndex = 172,
	name = 'pichu',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 25,
			name = 'pikachu',
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 26,
					name = 'raichu',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietratuono'
				},
				{
					ndex = '026A',
					name = 'raichuA',
					notes = altforms.raichu.names.A,
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietratuono',
					conditions = { [evo.conditions.REGION] = 'Alola' },
				}
			}
		}
	}
}
evo.pikachu, evo.raichu, evo.raichuA = evo.pichu, evo.pichu, evo.pichu
evo[172], evo[25], evo[26], evo['026A'] =
	evo.pichu, evo.pichu, evo.pichu, evo.pichu

evo.sandshrew = {
	ndex = 27,
	name = 'sandshrew',

	evos = {
		{
			ndex = 28,
			name = 'sandslash',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.sandslash = evo.sandshrew
evo[27], evo[28] = evo.sandshrew, evo.sandshrew

evo["nidoran♀"] = {
	ndex = 29,
	name = 'nidoran♀',

	evos = {
		{
			ndex = 30,
			name = 'nidorina',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 31,
					name = 'nidoqueen',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietralunare',
				}
			}
		}
	}
}
evo.nidorina, evo.nidoqueen = evo["nidoran♀"], evo["nidoran♀"]
evo[29], evo[30], evo[31] = evo["nidoran♀"], evo["nidoran♀"], evo["nidoran♀"]

evo["nidoran♂"] = {
	ndex = 32,
	name = 'nidoran♂',

	evos = {
		{
			ndex = 33,
			name = 'nidorino',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 34,
					name = 'nidoking',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietralunare',
				}
			}
		}
	}
}
evo.nidorino, evo.nidoking = evo["nidoran♂"], evo["nidoran♂"]
evo[32], evo[33], evo[34] = evo["nidoran♂"], evo["nidoran♂"], evo["nidoran♂"]

evo.cleffa = {
	ndex = 173,
	name = 'cleffa',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 35,
			name = 'clefairy',
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 36,
					name = 'clefable',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietralunare'
				}
			}
		}
	}
}
evo.clefairy, evo.clefable = evo.cleffa, evo.cleffa
evo[173], evo[35], evo[36] = evo.cleffa, evo.cleffa, evo.cleffa

evo.vulpix = {
	ndex = 37,
	name = 'vulpix',

	evos = {
		{
			ndex = 38,
			name = 'ninetales',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.ninetales = evo.vulpix
evo[37], evo[38] = evo.vulpix, evo.vulpix

evo.igglybuff = {
	ndex = 174,
	name = 'igglybuff',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 39,
			name = 'jigglypuff',
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 40,
					name = 'wigglytuff',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietralunare',
				}
			}
		}
	}
}
evo.jigglypuff, evo.wigglytuff = evo.igglybuff, evo.igglybuff
evo[174], evo[39], evo[40] = evo.igglybuff, evo.igglybuff, evo.igglybuff

evo.zubat = {
	ndex = 41,
	name = 'zubat',

	evos = {
		{
			ndex = 42,
			name = 'golbat',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,

			evos = {
				{
					ndex = 169,
					name = 'crobat',
					method = evo.methods.HAPPINESS,
				}
			}
		}
	}
}
evo.golbat, evo.crobat = evo.zubat, evo.zubat
evo[41], evo[42], evo[169] = evo.zubat, evo.zubat, evo.zubat

evo.oddish = {
	ndex = 43,
	name = 'oddish',

	evos = {
		{
			ndex = 44,
			name = 'gloom',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 45,
					name = 'vileplume',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrafoglia'
				},
				{
					ndex = 182,
					name = 'bellossom',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrasolare'
				}
			}
		}
	}
}
evo.gloom, evo.vileplume, evo.bellossom = evo.oddish, evo.oddish, evo.oddish
evo[43], evo[44], evo[45], evo[182] =
	evo.oddish, evo.oddish, evo.oddish, evo.oddish

evo.paras = {
	ndex = 46,
	name = 'paras',

	evos = {
		{
			ndex = 47,
			name = 'parasect',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.parasect = evo.paras
evo[46], evo[47] = evo.paras, evo.paras

evo.venonat = {
	ndex = 48,
	name = 'venonat',

	evos = {
		{
			ndex = 49,
			name = 'venomoth',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.venomoth = evo.venonat
evo[48], evo[49] = evo.venonat, evo.venonat

evo.diglett = {
	ndex = 50,
	name = 'diglett',

	evos = {
		{
			ndex = 51,
			name = 'dugtrio',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.dugtrio = evo.diglett
evo[50], evo[51] = evo.diglett, evo.diglett

evo.meowth = {
	ndex = 52,
	name = 'meowth',

	evos = {
		{
			ndex = 53,
			name = 'persian',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.persian = evo.meowth
evo[52], evo[53] = evo.meowth, evo.meowth

evo.psyduck = {
	ndex = 54,
	name = 'psyduck',

	evos = {
		{
			ndex = 55,
			name = 'golduck',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.golduck = evo.psyduck
evo[54], evo[55] = evo.psyduck, evo.psyduck

evo.mankey = {
	ndex = 56,
	name = 'mankey',

	evos = {
		{
			ndex = 57,
			name = 'primeape',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.primeape = evo.mankey
evo[56], evo[57] = evo.mankey, evo.mankey

evo.growlithe = {
	ndex = 58,
	name = 'growlithe',

	evos = {
		{
			ndex = 59,
			name = 'arcanine',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.arcanine = evo.growlithe
evo[58], evo[59] = evo.growlithe, evo.growlithe

evo.poliwag = {
	ndex = 60,
	name = 'poliwag',

	evos = {
		{
			ndex = 61,
			name = 'poliwhirl',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 62,
					name = 'poliwrath',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietraidrica'
				},
				{
					ndex = 186,
					name = 'politoed',
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Roccia di Re' },
				}
			}
		}
	}
}
evo.poliwhirl, evo.poliwrath, evo.politoed = evo.poliwag, evo.poliwag, evo.poliwag
evo[60], evo[61], evo[62], evo[186] =
	evo.poliwag, evo.poliwag, evo.poliwag, evo.poliwag

evo.abra = {
	ndex = 63,
	name = 'abra',

	evos = {
		{
			ndex = 64,
			name = 'kadabra',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 65,
					name = 'alakazam',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Filo dell'unione"),
							"</div>usando un [[Filo dell'unione]]",
						},
					},
				}
			}
		}
	}
}
evo.kadabra, evo.alakazam = evo.abra, evo.abra
evo[63], evo[64], evo[65] = evo.abra, evo.abra, evo.abra

evo.machop = {
	ndex = 66,
	name = 'machop',

	evos = {
		{
			ndex = 67,
			name = 'machoke',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,

			evos = {
				{
					ndex = 68,
					name = 'machamp',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Filo dell'unione"),
							"</div>usando un [[Filo dell'unione]]",
						},
					},
				}
			}
		}
	}
}
evo.machoke, evo.machamp = evo.machop, evo.machop
evo[66], evo[67], evo[68] = evo.machop, evo.machop, evo.machop

evo.bellsprout = {
	ndex = 69,
	name = 'bellsprout',

	evos = {
		{
			ndex = 70,
			name = 'weepinbell',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 71,
					name = 'victreebel',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrafoglia',
				}
			}
		}
	}
}
evo.weepinbell, evo.victreebel = evo.bellsprout, evo.bellsprout
evo[69], evo[70], evo[71] = evo.bellsprout, evo.bellsprout, evo.bellsprout

evo.tentacool = {
	ndex = 72,
	name = 'tentacool',

	evos = {
		{
			ndex = 73,
			name = 'tentacruel',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.tentacruel = evo.tentacool
evo[72], evo[73] = evo.tentacool, evo.tentacool

evo.geodude = {
	ndex = 74,
	name = 'geodude',

	evos = {
		{
			ndex = 75,
			name = 'graveler',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 76,
					name = 'golem',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Filo dell'unione"),
							"</div>usando un [[Filo dell'unione]]",
						},
					},
				}
			}
		}
	}
}
evo.graveler, evo.golem = evo.geodude, evo.geodude
evo[74], evo[75], evo[76] = evo.geodude, evo.geodude, evo.geodude

evo.ponyta = {
	ndex = 77,
	name = 'ponyta',

	evos = {
		{
			ndex = 78,
			name = 'rapidash',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.rapidash = evo.ponyta
evo[77], evo[78] = evo.ponyta, evo.ponyta

evo.slowpoke = {
	ndex = 79,
	name = 'slowpoke',

	evos = {
		{
			ndex = 80,
			name = 'slowbro',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,

		},
		{
			ndex = 199,
			name = 'slowking',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Roccia di Re' }
		}
	}
}
evo.slowbro, evo.slowking = evo.slowpoke, evo.slowpoke
evo[79], evo[80], evo[199] = evo.slowpoke, evo.slowpoke, evo.slowpoke

evo.magnemite = {
	ndex = 81,
	name = 'magnemite',

	evos = {
		{
			ndex = 82,
			name = 'magneton',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 462,
					name = 'magnezone',
					method = evo.methods.LEVEL,
					-- conditions = { [evo.conditions.LOCATION] = 'Campo magnetico speciale' },
					conditions = {
						   [evo.conditions.LOCATION] = 'Campo magnetico speciale',
						   [evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Pietratuono"),
							"</div>usando una [[Pietratuono]]",
						},
					}
				}
			}
		}
	}
}
evo.magneton, evo.magnezone = evo.magnemite, evo.magnemite
evo[81], evo[82], evo[462] = evo.magnemite, evo.magnemite, evo.magnemite

evo["farfetch'd"] = { ndex = 83, name = "farfetch'd" }
evo[83] = evo["farfetch'd"]

evo.doduo = {
	ndex = 84,
	name = 'doduo',

	evos = {
		{
			ndex = 85,
			name = 'dodrio',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.dodrio = evo.doduo
evo[84], evo[85] = evo.doduo, evo.doduo

evo.seel = {
	ndex = 86,
	name = 'seel',

	evos = {
		{
			ndex = 87,
			name = 'dewgong',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.dewgong = evo.seel
evo[86], evo[87] = evo.seel, evo.seel

evo.grimer = {
	ndex = 88,
	name = 'grimer',

	evos = {
		{
			ndex = 89,
			name = 'muk',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.muk = evo.grimer
evo[88], evo[89] = evo.grimer, evo.grimer

evo.shellder = {
	ndex = 90,
	name = 'shellder',

	evos = {
		{
			ndex = 91,
			name = 'cloyster',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.cloyster = evo.shellder
evo[90], evo[91] = evo.shellder, evo.shellder

evo.gastly = {
	ndex = 92,
	name = 'gastly',

	evos = {
		{
			ndex = 93,
			name = 'haunter',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 94,
					name = 'gengar',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Filo dell'unione"),
							"</div>usando un [[Filo dell'unione]]",
						},
					},
				}
			}
		}
	}
}
evo.haunter, evo.gengar = evo.gastly, evo.gastly
evo[92], evo[93], evo[94] = evo.gastly, evo.gastly, evo.gastly

evo.onix = {
	ndex = 95,
	name = 'onix',

	evos = {
		{
			ndex = 208,
			name = 'steelix',
			method = evo.methods.TRADE,
			conditions = {
				[evo.conditions.ITEM] = 'Metalcoperta',
				[evo.conditions.OTHER] = "oppure usando [[Metalcoperta]]" .. sup.LPA,
			},
		}
	}
}
evo.steelix = evo.onix
evo[95], evo[208] = evo.onix, evo.onix

evo.drowzee = {
	ndex = 96,
	name = 'drowzee',

	evos = {
		{
			ndex = 97,
			name = 'hypno',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.hypno = evo.drowzee
evo[96], evo[97] = evo.drowzee, evo.drowzee

evo.krabby = {
	ndex = 98,
	name = 'krabby',

	evos = {
		{
			ndex = 99,
			name = 'kingler',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.kingler = evo.krabby
evo[98], evo[99] = evo.krabby, evo.krabby

evo.voltorb = {
	ndex = 100,
	name = 'voltorb',

	evos = {
		{
			ndex = 101,
			name = 'electrode',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.electrode = evo.voltorb
evo[100], evo[101] = evo.voltorb, evo.voltorb

evo.exeggcute = {
	ndex = 102,
	name = 'exeggcute',

	evos = {
		{
			ndex = 103,
			name = 'exeggutor',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
		},
		{
			ndex = '103A',
			name = 'exeggutorA',
			notes = altforms.exeggutor.names.A,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
			conditions = { [evo.conditions.REGION] = 'Alola' },
		},
	}
}
evo.exeggutor, evo.exeggutorA = evo.exeggcute, evo.exeggcute
evo[102], evo[103], evo['103A'] = evo.exeggcute, evo.exeggcute, evo.exeggcute

evo.cubone = {
	ndex = 104,
	name = 'cubone',

	evos = {
		{
			ndex = 105,
			name = 'marowak',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		},
		{
			ndex = '105A',
			name = 'marowakA',
			notes = altforms.marowak.names.A,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
			conditions = { [evo.conditions.TIME] = 'Notte',
							[evo.conditions.REGION] = 'Alola' },
		}
	}
}
evo.marowak, evo.marowakA = evo.cubone, evo.cubone
evo[104], evo[105], evo['105A'] = evo.cubone, evo.cubone, evo.cubone

evo.tyrogue = {
	ndex = 236,
	name = 'tyrogue',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 106,
			name = 'hitmonlee',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.OTHER] = 'Con [[Attacco]] > [[Difesa]]' }
		},
		{
			ndex = 107,
			name = 'hitmonchan',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.OTHER] = 'Con [[Attacco]] < [[Difesa]]' }
		},
		{
			ndex = 237,
			name = 'hitmontop',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.OTHER] = 'Con [[Attacco]] = [[Difesa]]' }
		}
	}
}
evo.hitmonlee, evo.hitmonchan, evo.hitmontop = evo.tyrogue, evo.tyrogue, evo.tyrogue
evo[236], evo[106], evo[107], evo[237] = evo.tyrogue, evo.tyrogue, evo.tyrogue, evo.tyrogue

evo.lickitung = {
	ndex = 108,
	name = 'lickitung',

	evos = {
		{
			ndex = 463,
			name = 'lickilicky',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Rotolamento' }
		}
	}
}
evo.lickilicky = evo.lickitung
evo[108], evo[463] = evo.lickitung, evo.lickitung

evo.koffing = {
	ndex = 109,
	name = 'koffing',

	evos = {
		{
			ndex = 110,
			name = 'weezing',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		},
		{
			ndex = '110G',
			name = 'weezingG',
			notes = altforms.weezing.names.G,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
			conditions = { [evo.conditions.REGION] = 'Galar' },
		}
	}
}
evo.weezing, evo.weezingG = evo.koffing, evo.koffing
evo[109], evo[110], evo['110G'] = evo.koffing, evo.koffing, evo.koffing

evo.rhyhorn = {
	ndex = 111,
	name = 'rhyhorn',

	evos = {
		{
			ndex = 112,
			name = 'rhydon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,

			evos = {
				{
					ndex = 464,
					name = 'rhyperior',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.ITEM] = 'Copertura',
						[evo.conditions.OTHER] = "oppure usando [[Copertura]]" .. sup.LPA,
					},
				}
			}
		}
	}
}
evo.rhydon, evo.rhyperior = evo.rhyhorn, evo.rhyhorn
evo[111], evo[112], evo[464] = evo.rhyhorn, evo.rhyhorn, evo.rhyhorn

evo.happiny = {
	ndex = 440,
	name = 'happiny',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Fortunaroma'},

	evos = {
		{
			ndex = 113,
			name = 'chansey',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.ITEM] = 'Pietraovale',
			[evo.conditions.TIME] = 'Giorno'},

			evos = {
				{
					ndex = 242,
					name = 'blissey',
					method = evo.methods.HAPPINESS,
				}
			}
		}
	}
}
evo.chansey, evo.blissey = evo.happiny, evo.happiny
evo[440], evo[113], evo[242] = evo.happiny, evo.happiny, evo.happiny

evo.tangela = {
	ndex = 114,
	name = 'tangela',

	evos = {
		{
			ndex = 465,
			name = 'tangrowth',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Forzantica' },
		}
	}
}
evo.tangrowth = evo.tangela
evo[114], evo[465] = evo.tangela, evo.tangela

evo.kangaskhan = { ndex = 115, name = 'kangaskhan' }
evo[115] = evo.kangaskhan

evo.horsea = {
	ndex = 116,
	name = 'horsea',

	evos = {
		{
			ndex = 117,
			name = 'seadra',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 230,
					name = 'kingdra',
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Squama Drago' },
				}
			}
		}
	}
}
evo.seadra, evo.kingdra = evo.horsea, evo.horsea
evo[116], evo[117], evo[230] = evo.horsea, evo.horsea, evo.horsea

evo.goldeen = {
	ndex = 118,
	name = 'goldeen',

	evos = {
		{
			ndex = 119,
			name = 'seaking',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.seaking = evo.goldeen
evo[118], evo[119] = evo.goldeen, evo.goldeen

evo.staryu = {
	ndex = 120,
	name = 'staryu',

	evos = {
		{
			ndex = 121,
			name = 'starmie',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.starmie = evo.staryu
evo[120], evo[121] = evo.staryu, evo.staryu

evo["mime jr."] = {
	ndex = 439,
	name = 'mime jr.',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Bizzoaroma' },

	evos = {
		{
			ndex = 122,
			name = 'mr. mime',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Mimica' },
		},
		{
			ndex = '122G',
			name = "mr. mimeG",
			notes = altforms["mr. mime"].names.G,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Mimica',
				[evo.conditions.REGION] = 'Galar' },

			evos = {
				{
					ndex = 866,
					name = "mr. rime",
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 42,
				}
			}
		},
	}
}
evo["mr. mime"] = evo["mime jr."]
evo[439], evo[122] = evo["mime jr."], evo["mime jr."]
evo["mr. rime"], evo["mr. mimeG"] = evo["mime jr."], evo["mime jr."]
evo['122G'], evo[866] = evo["mr. mimeG"], evo["mr. mimeG"]

evo.scyther = {
	ndex = 123,
	name = 'scyther',

	evos = {
		{
			ndex = 212,
			name = 'scizor',
			method = evo.methods.TRADE,
			conditions = {
				[evo.conditions.ITEM] = 'Metalcoperta',
				[evo.conditions.OTHER] = "oppure usando [[Metalcoperta]]" .. sup.LPA,
			},
		},
		{
			ndex = 900,
			name = 'kleavor',
			method = evo.methods.STONE,
			[evo.methods.STONE] = "Augite nera",
		},
	}
}
evo.scizor, evo.kleavor = evo.scyther, evo.scyther
evo[123], evo[212], evo[900] = evo.scyther, evo.scyther, evo.scyther

evo.smoochum = {
	ndex = 238,
	name = 'smoochum',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 124,
			name = 'jynx',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.jynx = evo.smoochum
evo[238], evo[124] = evo.smoochum, evo.smoochum

evo.elekid = {
	ndex = 239,
	name = 'elekid',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 125,
			name = 'electabuzz',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 466,
					name = 'electivire',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.ITEM] = 'Elettritore',
						[evo.conditions.OTHER] = "oppure usando [[Elettritore]]" .. sup.LPA,
					},
				}
			}
		}
	}
}
evo.electabuzz, evo.electivire = evo.elekid, evo.elekid
evo[239], evo[125], evo[466] = evo.elekid, evo.elekid, evo.elekid

evo.magby = {
	ndex = 240,
	name = 'magby',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 126,
			name = 'magmar',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 467,
					name = 'magmortar',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.ITEM] = 'Magmatore',
						[evo.conditions.OTHER] = "oppure usando [[Magmatore]]" .. sup.LPA,
					},
				}
			}
		}
	}
}
evo.magmar, evo.magmortar = evo.magby, evo.magby
evo[240], evo[126], evo[467] = evo.magby, evo.magby, evo.magby

evo.pinsir = { ndex = 127, name = 'pinsir' }
evo[127] = evo.pinsir

evo.tauros = { ndex = 128, name = 'tauros' }
evo[128] = evo.tauros

evo.magikarp = {
	ndex = 129,
	name = 'magikarp',

	evos = {
		{
			ndex = 130,
			name = 'gyarados',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.gyarados = evo.magikarp
evo[129], evo[130] = evo.magikarp, evo.magikarp

evo.lapras = { ndex = 131, name = 'lapras' }
evo[131] = evo.lapras

evo.ditto = { ndex = 132, name = 'ditto' }
evo[132] = evo.ditto

evo.eevee = {
	ndex = 133,
	name = 'eevee',

	evos = {
		{
			ndex = 134,
			name = 'vaporeon',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		},
		{
			ndex = 135,
			name = 'jolteon',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietratuono',
		},
		{
			ndex = 136,
			name = 'flareon',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		},
		{
			ndex = 196,
			name = 'espeon',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		},
		{
			ndex = 197,
			name = 'umbreon',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' },
		},
		{
			ndex = 470,
			name = 'leafeon',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
			conditions = {
				[evo.conditions.OTHER] = table.concat{
					"oppure<div>",
					links.bag('Mappa città'),
					"</div>[[Livello|aumento di livello]] presso una [[Roccia Muschio]]",
				},
			},
		},
		{
			ndex = 471,
			name = 'glaceon',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
			conditions = {
				[evo.conditions.OTHER] = table.concat{
					"oppure<div>",
					links.bag('Mappa città'),
					"</div>[[Livello|aumento di livello]] presso una [[Roccia Ghiaccio]]",
				},
			},
		},
		{
			ndex = 700,
			name = 'sylveon',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.OTHER] = "Con il [[affetto|legame]] moderatamente alto<div>avendo appreso una mossa di tipo [[Folletto]]</div>" },
		}
	}
}
evo.vaporeon, evo.jolteon, evo.flareon, evo.espeon, evo.umbreon, evo.leafeon, evo.glaceon, evo.sylveon =
	evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee
evo[133], evo[134], evo[135], evo[136], evo[196], evo[197], evo[470], evo[471], evo[700] =
	evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee

evo.porygon = {
	ndex = 137,
	name = 'porygon',

	evos = {
		{
			ndex = 233,
			name = 'porygon2',
			method = evo.methods.TRADE,
			conditions = {
				[evo.conditions.ITEM] = 'Upgrade',
				[evo.conditions.OTHER] = "oppure usando [[Upgrade]]" .. sup.LPA,
			},

			evos = {
				{
					ndex = 474,
					name = 'porygon-z',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.ITEM] = 'Dubbiodisco',
						[evo.conditions.OTHER] = "oppure usando [[Dubbiodisco]]" .. sup.LPA,
					},
				}
			}
		}
	}
}
evo.porygon2, evo["porygon-z"] = evo.porygon, evo.porygon
evo[137], evo[233], evo[474] = evo.porygon, evo.porygon, evo.porygon

evo.omanyte = {
	ndex = 138,
	name = 'omanyte',

	evos = {
		{
			ndex = 139,
			name = 'omastar',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.omastar = evo.omanyte
evo[138], evo[139] = evo.omanyte, evo.omanyte

evo.kabuto = {
	ndex = 140,
	name = 'kabuto',

	evos = {
		{
			ndex = 141,
			name = 'kabutops',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.kabutops = evo.kabuto
evo[140], evo[141] = evo.kabuto, evo.kabuto

evo.aerodactyl = { ndex = 142, name = 'aerodactyl' }
evo[142] = evo.aerodactyl

evo.munchlax = {
	ndex = 446,
	name = 'munchlax',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Gonfioaroma' },

	evos = {
		{
			ndex = 143,
			name = 'snorlax',
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.snorlax = evo.munchlax
evo[446], evo[143] = evo.munchlax, evo.munchlax

evo.articuno = { ndex = 144, name = 'articuno' }
evo[144] = evo.articuno

evo.zapdos = { ndex = 145, name = 'zapdos' }
evo[145] = evo.zapdos

evo.moltres = { ndex = 146, name = 'moltres' }
evo[146] = evo.moltres

evo.dratini = {
	ndex = 147,
	name = 'dratini',

	evos = {
		{
			ndex = 148,
			name = 'dragonair',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 149,
					name = 'dragonite',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 55,
				}
			}
		}
	}
}
evo.dragonair, evo.dragonite = evo.dratini, evo.dratini
evo[147], evo[148], evo[149] = evo.dratini, evo.dratini, evo.dratini

evo.mewtwo = { ndex = 150, name = 'mewtwo' }
evo[150] = evo.mewtwo

evo.mew = { ndex = 151, name = 'mew' }
evo[151] = evo.mew

evo.chikorita = {
	ndex = 152,
	name = 'chikorita',

	evos = {
		{
			ndex = 153,
			name = 'bayleef',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 154,
					name = 'meganium',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 32,
				}
			}
		}
	}
}
evo.bayleef, evo.meganium = evo.chikorita, evo.chikorita
evo[152], evo[153], evo[154] = evo.chikorita, evo.chikorita, evo.chikorita

evo.cyndaquil = {
	ndex = 155,
	name = 'cyndaquil',

	evos = {
		{
			ndex = 156,
			name = 'quilava',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 157,
					name = 'typhlosion',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				},
				{
					ndex = '157H',
					name = 'typhlosionH',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
					conditions = { [evo.conditions.REGION] = 'Hisui' },
				}
			}
		}
	}
}
evo.quilava, evo.typhlosion, evo.typhlosionH = evo.cyndaquil, evo.cyndaquil, evo.cyndaquil
evo[155], evo[156], evo[157], evo['157H'] = evo.cyndaquil, evo.cyndaquil, evo.cyndaquil, evo.cyndaquil

evo.totodile = {
	ndex = 158,
	name = 'totodile',

	evos = {
		{
			ndex = 159,
			name = 'croconaw',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 160,
					name = 'feraligatr',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				}
			}
		}
	}
}
evo.croconaw, evo.feraligatr = evo.totodile, evo.totodile
evo[158], evo[159], evo[160] = evo.totodile, evo.totodile, evo.totodile

evo.sentret = {
	ndex = 161,
	name = 'sentret',

	evos = {
		{
			ndex = 162,
			name = 'furret',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.furret = evo.sentret
evo[161], evo[162] = evo.sentret, evo.sentret

evo.hoothoot = {
	ndex = 163,
	name = 'hoothoot',

	evos = {
		{
			ndex = 164,
			name = 'noctowl',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.noctowl = evo.hoothoot
evo[163], evo[164] = evo.hoothoot, evo.hoothoot

evo.ledyba = {
	ndex = 165,
	name = 'ledyba',

	evos = {
		{
			ndex = 166,
			name = 'ledian',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,
		}
	}
}
evo.ledian = evo.ledyba
evo[165], evo[166] = evo.ledyba, evo.ledyba

evo.spinarak = {
	ndex = 167,
	name = 'spinarak',

	evos = {
		{
			ndex = 168,
			name = 'ariados',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.ariados = evo.spinarak
evo[167], evo[168] = evo.spinarak, evo.spinarak

evo.chinchou = {
	ndex = 170,
	name = 'chinchou',

	evos = {
		{
			ndex = 171,
			name = 'lanturn',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.lanturn = evo.chinchou
evo[170], evo[171] = evo.chinchou, evo.chinchou

evo.togepi = {
	ndex = 175,
	name = 'togepi',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 176,
			name = 'togetic',
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 468,
					name = 'togekiss',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrabrillo',
				}
			}
		}
	}
}
evo.togetic, evo.togekiss = evo.togepi, evo.togepi
evo[175], evo[176], evo[468] = evo.togepi, evo.togepi, evo.togepi

evo.natu = {
	ndex = 177,
	name = 'natu',

	evos = {
		{
			ndex = 178,
			name = 'xatu',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.xatu = evo.natu
evo[177], evo[178] = evo.natu, evo.natu

evo.mareep = {
	ndex = 179,
	name = 'mareep',

	evos = {
		{
			ndex = 180,
			name = 'flaaffy',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,

			evos = {
				{
					ndex = 181,
					name = 'ampharos',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				}
			}
		}
	}
}
evo.flaaffy, evo.ampharos = evo.mareep, evo.mareep
evo[179], evo[180], evo[181] = evo.mareep, evo.mareep, evo.mareep

evo.azurill = {
	ndex = 298,
	name = 'azurill',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Marearoma' },

	evos = {
		{
			ndex = 183,
			name = 'marill',
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 184,
					name = 'azumarill',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 18,
				}
			}
		}
	}
}
evo.marill, evo.azumarill = evo.azurill, evo.azurill
evo[298], evo[183], evo[184] = evo.azurill, evo.azurill, evo.azurill

evo.bonsly = {
	ndex = 438,
	name = 'bonsly',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Roccioaroma' },

	evos = {
		{
			ndex = 185,
			name = 'sudowoodo',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Mimica' },
		}
	}
}
evo.sudowoodo = evo.bonsly
evo[438], evo[185] = evo.bonsly, evo.bonsly

evo.hoppip = {
	ndex = 187,
	name = 'hoppip',

	evos = {
		{
			ndex = 188,
			name = 'skiploom',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 189,
					name = 'jumpluff',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 27,
				}
			}
		}
	}
}
evo.skiploom, evo.jumpluff = evo.hoppip, evo.hoppip
evo[187], evo[188], evo[189] = evo.hoppip, evo.hoppip, evo.hoppip

evo.aipom = {
	ndex = 190,
	name = 'aipom',

	evos = {
		{
			ndex = 424,
			name = 'ambipom',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Doppiosmash' },
		}
	}
}
evo.ambipom = evo.aipom
evo[190], evo[424] = evo.aipom, evo.aipom

evo.sunkern = {
	ndex = 191,
	name = 'sunkern',

	evos = {
		{
			ndex = 192,
			name = 'sunflora',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.sunflora = evo.sunkern
evo[191], evo[192] = evo.sunkern, evo.sunkern

evo.yanma = {
	ndex = 193,
	name = 'yanma',

	evos = {
		{
			ndex = 469,
			name = 'yanmega',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Forzantica' },
		}
	}
}
evo.yanmega = evo.yanma
evo[193], evo[469] = evo.yanma, evo.yanma

evo.wooper = {
	ndex = 194,
	name = 'wooper',

	evos = {
		{
			ndex = 195,
			name = 'quagsire',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.quagsire = evo.wooper
evo[194], evo[195] = evo.wooper, evo.wooper

evo.murkrow = {
	ndex = 198,
	name = 'murkrow',

	evos = {
		{
			ndex = 430,
			name = 'honchkrow',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Neropietra',
		}
	}
}
evo.honchkrow = evo.murkrow
evo[198], evo[430] = evo.murkrow, evo.murkrow

evo.misdreavus = {
	ndex = 200,
	name = 'misdreavus',

	evos = {
		{
			ndex = 429,
			name = 'mismagius',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Neropietra',
		}
	}
}
evo.mismagius = evo.misdreavus
evo[200], evo[429] = evo.misdreavus, evo.misdreavus

evo.unown = { ndex = 201, name = 'unown' }
evo[201] = evo.unown

evo.wynaut = {
	ndex = 360,
	name = 'wynaut',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Distraroma' },

	evos = {
		{
			ndex = 202,
			name = 'wobbuffet',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.wobbuffet = evo.wynaut
evo[360], evo[202] = evo.wynaut, evo.wynaut

evo.girafarig = {
	ndex = 203,
	name = 'girafarig',

	evos = {
		{
			ndex = nil,
			name = 'farigiraf',
			method = evo.methods.UNKNOWN,
		}
	}
}
evo[203] = evo.girafarig

evo.pineco = {
	ndex = 204,
	name = 'pineco',

	evos = {
		{
			ndex = 205,
			name = 'forretress',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.forretress = evo.pineco
evo[204], evo[205] = evo.pineco, evo.pineco

evo.dunsparce = { ndex = 206, name = 'dunsparce' }
evo[206] = evo.dunsparce

evo.gligar = {
	ndex = 207,
	name = 'gligar',

	evos = {
		{
			ndex = 472,
			name = 'gliscor',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.ITEM] = 'Affilodente',
			[evo.conditions.TIME] = 'Notte' },
		}
	}
}
evo.gliscor = evo.gligar
evo[207], evo[472] = evo.gligar, evo.gligar

evo.snubbull = {
	ndex = 209,
	name = 'snubbull',

	evos = {
		{
			ndex = 210,
			name = 'granbull',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 23,
		}
	}
}
evo.granbull = evo.snubbull
evo[209], evo[210] = evo.snubbull, evo.snubbull

evo.qwilfish = { ndex = 211, name = 'qwilfish' }
evo[211] = evo.qwilfish

evo.shuckle = { ndex = 213, name = 'shuckle' }
evo[213] = evo.shuckle

evo.heracross = { ndex = 214, name = 'heracross' }
evo[214] = evo.heracross

evo.sneasel = {
	ndex = 215,
	name = 'sneasel',

	evos = {
		{
			ndex = 461,
			name = 'weavile',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.ITEM] = 'Affilartigli',
			[evo.conditions.TIME] = 'Notte' },
		}
	}
}
evo.weavile = evo.sneasel
evo[215], evo[461] = evo.sneasel, evo.sneasel

evo.teddiursa = {
	ndex = 216,
	name = 'teddiursa',

	evos = {
		{
			ndex = 217,
			name = 'ursaring',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 901,
					name = 'ursaluna',
					method = evo.methods.STONE,
					[evo.methods.STONE] = "Blocco di torba",
					conditions = { [evo.conditions.TIME] = "Luna piena" },
				}
			}
		}
	}
}
evo.ursaring, evo.ursaluna = evo.teddiursa, evo.teddiursa
evo[216], evo[217], evo[901] = evo.teddiursa, evo.teddiursa, evo.teddiursa

evo.slugma = {
	ndex = 218,
	name = 'slugma',

	evos = {
		{
			ndex = 219,
			name = 'magcargo',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.magcargo = evo.slugma
evo[218], evo[219] = evo.slugma, evo.slugma

evo.swinub = {
	ndex = 220,
	name = 'swinub',

	evos = {
		{
			ndex = 221,
			name = 'piloswine',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,

			evos = {
				{
					ndex = 473,
					name = 'mamoswine',
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.MOVE] = 'Forzantica' },
				}
			}
		}
	}
}
evo.piloswine, evo.mamoswine = evo.swinub, evo.swinub
evo[220], evo[221], evo[473] = evo.swinub, evo.swinub, evo.swinub

evo.corsola = { ndex = 222, name = 'corsola' }
evo[222] = evo.corsola

evo.remoraid = {
	ndex = 223,
	name = 'remoraid',

	evos = {
		{
			ndex = 224,
			name = 'octillery',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.octillery = evo.remoraid
evo[223], evo[224] = evo.remoraid, evo.remoraid

evo.delibird = { ndex = 225, name = 'delibird' }
evo[225] = evo.delibird

evo.mantyke = {
	ndex = 458,
	name = 'mantyke',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Ondaroma' },

	evos = {
		{
			ndex = 226,
			name = 'mantine',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.OTHER] = 'Con [[Remoraid]] in [[squadra]]' },
		}
	}
}
evo.mantine = evo.mantyke
evo[458], evo[226] = evo.mantyke, evo.mantyke

evo.skarmory = { ndex = 227, name = 'skarmory' }
evo[227] = evo.skarmory

evo.houndour = {
	ndex = 228,
	name = 'houndour',

	evos = {
		{
			ndex = 229,
			name = 'houndoom',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.houndoom = evo.houndour
evo[228], evo[229] = evo.houndour, evo.houndour

evo.phanpy = {
	ndex = 231,
	name = 'phanpy',

	evos = {
		{
			ndex = 232,
			name = 'donphan',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.donphan = evo.phanpy
evo[231], evo[232] = evo.phanpy, evo.phanpy

evo.stantler = {
	ndex = 234,
	name = 'stantler',

	evos = {
		{
			ndex = 899,
			name = 'wyrdeer',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = "Usando [[Barrierassalto]] 20 volte come [[Tecnica rapida]]",
		}
	}
}
evo.wyrdeer = evo.stantler
evo[234], evo[899] = evo.stantler, evo.stantler

evo.smeargle = { ndex = 235, name = 'smeargle' }
evo[235] = evo.smeargle

evo.miltank = { ndex = 241, name = 'miltank' }
evo[241] = evo.miltank

evo.raikou = { ndex = 243, name = 'raikou' }
evo[243] = evo.raikou

evo.entei = { ndex = 244, name = 'entei' }
evo[244] = evo.entei

evo.suicune = { ndex = 245, name = 'suicune' }
evo[245] = evo.suicune

evo.larvitar = {
	ndex = 246,
	name = 'larvitar',

	evos = {
		{
			ndex = 247,
			name = 'pupitar',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 248,
					name = 'tyranitar',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 55,
				}
			}
		}
	}
}
evo.pupitar, evo.tyranitar = evo.larvitar, evo.larvitar
evo[246], evo[247], evo[248] = evo.larvitar, evo.larvitar, evo.larvitar

evo.lugia = { ndex = 249, name = 'lugia' }
evo[249] = evo.lugia

evo["ho-oh"] = { ndex = 250, name = 'ho-oh' }
evo[250] = evo["ho-oh"]

evo.celebi = { ndex = 251, name = 'celebi' }
evo[251] = evo.celebi

evo.treecko = {
	ndex = 252,
	name = 'treecko',

	evos = {
		{
			ndex = 253,
			name = 'grovyle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 254,
					name = 'sceptile',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.grovyle, evo.sceptile = evo.treecko, evo.treecko
evo[252], evo[253], evo[254] = evo.treecko, evo.treecko, evo.treecko

evo.torchic = {
	ndex = 255,
	name = 'torchic',

	evos = {
		{
			ndex = 256,
			name = 'combusken',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 257,
					name = 'blaziken',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.combusken, evo.blaziken = evo.torchic, evo.torchic
evo[255], evo[256], evo[257] = evo.torchic, evo.torchic, evo.torchic

evo.mudkip = {
	ndex = 258,
	name = 'mudkip',

	evos = {
		{
			ndex = 259,
			name = 'marshtomp',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 260,
					name = 'swampert',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.marshtomp, evo.swampert = evo.mudkip, evo.mudkip
evo[258], evo[259], evo[260] = evo.mudkip, evo.mudkip, evo.mudkip

evo.poochyena = {
	ndex = 261,
	name = 'poochyena',

	evos = {
		{
			ndex = 262,
			name = 'mightyena',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,
		}
	}
}
evo.mightyena = evo.poochyena
evo[261], evo[262] = evo.poochyena, evo.poochyena

evo.zigzagoon = {
	ndex = 263,
	name = 'zigzagoon',

	evos = {
		{
			ndex = 264,
			name = 'linoone',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.linoone = evo.zigzagoon
evo[263], evo[264] = evo.zigzagoon, evo.zigzagoon

evo.wurmple = {
	ndex = 265,
	name = 'wurmple',

	evos = {
		{
			ndex = 266,
			name = 'silcoon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[personalità]]' },

			evos = {
				{
					ndex = 267,
					name = 'beautifly',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 10,
				}
			}
		},
		{
			ndex = 268,
			name = 'cascoon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[personalità]]' },

			evos = {
				{
					ndex = 269,
					name = 'dustox',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 10,
				}
			}
		}
	}
}
evo.silcoon, evo.beautifly, evo.cascoon, evo.dustox = evo.wurmple, evo.wurmple, evo.wurmple, evo.wurmple
evo[265], evo[266], evo[267], evo[268], evo[269] = evo.wurmple, evo.wurmple, evo.wurmple, evo.wurmple, evo.wurmple

evo.lotad = {
	ndex = 270,
	name = 'lotad',

	evos = {
		{
			ndex = 271,
			name = 'lombre',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 272,
					name = 'ludicolo',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietraidrica',
				}
			}
		}
	}
}
evo.lombre, evo.ludicolo = evo.lotad, evo.lotad
evo[270], evo[271], evo[272] = evo.lotad, evo.lotad, evo.lotad

evo.seedot = {
	ndex = 273,
	name = 'seedot',

	evos = {
		{
			ndex = 274,
			name = 'nuzleaf',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 275,
					name = 'shiftry',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrafoglia',
				}
			}
		}
	}
}
evo.nuzleaf, evo.shiftry = evo.seedot, evo.seedot
evo[273], evo[274], evo[275] = evo.seedot, evo.seedot, evo.seedot

evo.taillow = {
	ndex = 276,
	name = 'taillow',

	evos = {
		{
			ndex = 277,
			name = 'swellow',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.swellow = evo.taillow
evo[276], evo[277] = evo.taillow, evo.taillow

evo.wingull = {
	ndex = 278,
	name = 'wingull',

	evos = {
		{
			ndex = 279,
			name = 'pelipper',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.pelipper = evo.wingull
evo[278], evo[279] = evo.wingull, evo.wingull

evo.ralts = {
	ndex = 280,
	name = 'ralts',

	evos = {
		{
			ndex = 281,
			name = 'kirlia',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 282,
					name = 'gardevoir',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				},
				{
					ndex = 475,
					name = 'gallade',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietralbore',
					conditions = { [evo.conditions.GENDER] = 'Maschio' },
				}
			}
		}
	}
}
evo.kirlia, evo.gardevoir, evo.gallade = evo.ralts, evo.ralts, evo.ralts
evo[280], evo[281], evo[282], evo[475] =	evo.ralts, evo.ralts, evo.ralts, evo.ralts

evo.surskit = {
	ndex = 283,
	name = 'surskit',

	evos = {
		{
			ndex = 284,
			name = 'masquerain',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.masquerain = evo.surskit
evo[283], evo[284] = evo.surskit, evo.surskit

evo.shroomish = {
	ndex = 285,
	name = 'shroomish',

	evos = {
		{
			ndex = 286,
			name = 'breloom',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 23,
		}
	}
}
evo.breloom = evo.shroomish
evo[285], evo[286] = evo.shroomish, evo.shroomish

evo.slakoth = {
	ndex = 287,
	name = 'slakoth',

	evos = {
		{
			ndex = 288,
			name = 'vigoroth',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 289,
					name = 'slaking',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.vigoroth, evo.slaking = evo.slakoth, evo.slakoth
evo[287], evo[288], evo[289] = evo.slakoth, evo.slakoth, evo.slakoth

evo.nincada = {
	ndex = 290,
	name = 'nincada',

	evos = {
		{
			ndex = 291,
			name = 'ninjask',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		},
		{
			ndex = 292,
			name = 'shedinja',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = links.bag("Poké Ball"),
			conditions = { [evo.conditions.OTHER] = 'Con spazio in [[squadra]]<div>e almeno una [[Poké Ball]] nella [[Borsa]]</div>' },
		}
	}
}
evo.ninjask, evo.shedinja = evo.nincada, evo.nincada
evo[290], evo[291], evo[292] = evo.nincada, evo.nincada, evo.nincada

evo.whismur = {
	ndex = 293,
	name = 'whismur',

	evos = {
		{
			ndex = 294,
			name = 'loudred',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 295,
					name = 'exploud',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 40,
				}
			}
		}
	}
}
evo.loudred, evo.exploud = evo.whismur, evo.whismur
evo[293], evo[294], evo[295] = evo.whismur, evo.whismur, evo.whismur

evo.makuhita = {
	ndex = 296,
	name = 'makuhita',

	evos = {
		{
			ndex = 297,
			name = 'hariyama',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.hariyama = evo.makuhita
evo[296], evo[297] = evo.makuhita, evo.makuhita

evo.nosepass = {
	ndex = 299,
	name = 'nosepass',

	evos = {
		{
			ndex = 476,
			name = 'probopass',
			method = evo.methods.LEVEL,
			conditions = {
				[evo.conditions.LOCATION] = 'Campo magnetico speciale',
				[evo.conditions.OTHER] = table.concat{
					"oppure<br>",
					links.bag("Pietratuono"),
					"<br>usando una [[Pietratuono]]<br>",
					"oppure facendolo uscire dalla ball alle [[Pendici Corona]]",
				},
			},
		}
	}
}
evo.probopass = evo.nosepass
evo[299], evo[476] = evo.nosepass, evo.nosepass

evo.skitty = {
	ndex = 300,
	name = 'skitty',

	evos = {
		{
			ndex = 301,
			name = 'delcatty',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralunare',
		}
	}
}
evo.delcatty = evo.skitty
evo[300], evo[301] = evo.skitty, evo.skitty

evo.sableye = { ndex = 302, name = 'sableye' }
evo[302] = evo.sableye

evo.mawile = { ndex = 303, name = 'mawile' }
evo[303] = evo.mawile

evo.aron = {
	ndex = 304,
	name = 'aron',

	evos = {
		{
			ndex = 305,
			name = 'lairon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 306,
					name = 'aggron',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 42,
				}
			}
		}
	}
}
evo.lairon, evo.aggron = evo.aron, evo.aron
evo[304], evo[305], evo[306] = evo.aron, evo.aron, evo.aron

evo.meditite = {
	ndex = 307,
	name = 'meditite',

	evos = {
		{
			ndex = 308,
			name = 'medicham',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.medicham = evo.meditite
evo[307], evo[308] = evo.meditite, evo.meditite

evo.electrike = {
	ndex = 309,
	name = 'electrike',

	evos = {
		{
			ndex = 310,
			name = 'manectric',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.manectric = evo.electrike
evo[309], evo[310] = evo.electrike, evo.electrike

evo.plusle = { ndex = 311, name = 'plusle' }
evo[311] = evo.plusle

evo.minun = { ndex = 312, name = 'minun' }
evo[312] = evo.minun

evo.volbeat = { ndex = 313, name = 'volbeat' }
evo[313] = evo.volbeat

evo.illumise = { ndex = 314, name = 'illumise' }
evo[314] = evo.illumise

evo.budew = {
	ndex = 406,
	name = 'budew',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Rosaroma' },

	evos = {
		{
			ndex = 315,
			name = 'roselia',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },

			evos = {
				{
					ndex = 407,
					name = 'roserade',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrabrillo',
				}
			}
		}
	}
}
evo.roselia, evo.roserade = evo.budew, evo.budew
evo[406], evo[315], evo[407] = evo.budew, evo.budew, evo.budew

evo.gulpin = {
	ndex = 316,
	name = 'gulpin',

	evos = {
		{
			ndex = 317,
			name = 'swalot',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.swalot = evo.gulpin
evo[316], evo[317] = evo.gulpin, evo.gulpin

evo.carvanha = {
	ndex = 318,
	name = 'carvanha',

	evos = {
		{
			ndex = 319,
			name = 'sharpedo',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.sharpedo = evo.carvanha
evo[318], evo[319] = evo.carvanha, evo.carvanha

evo.wailmer = {
	ndex = 320,
	name = 'wailmer',

	evos = {
		{
			ndex = 321,
			name = 'wailord',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.wailord = evo.wailmer
evo[320], evo[321] = evo.wailmer, evo.wailmer

evo.numel = {
	ndex = 322,
	name = 'numel',

	evos = {
		{
			ndex = 323,
			name = 'camerupt',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.camerupt = evo.numel
evo[322], evo[323] = evo.numel, evo.numel

evo.torkoal = { ndex = 324, name = 'torkoal' }
evo[324] = evo.torkoal

evo.spoink = {
	ndex = 325,
	name = 'spoink',

	evos = {
		{
			ndex = 326,
			name = 'grumpig',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.grumpig = evo.spoink
evo[325], evo[326] = evo.spoink, evo.spoink

evo.spinda = { ndex = 327, name = 'spinda' }
evo[327] = evo.spinda

evo.trapinch = {
	ndex = 328,
	name = 'trapinch',

	evos = {
		{
			ndex = 329,
			name = 'vibrava',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 330,
					name = 'flygon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 45,
				}
			}
		}
	}
}
evo.vibrava, evo.flygon = evo.trapinch, evo.trapinch
evo[328], evo[329], evo[330] = evo.trapinch, evo.trapinch, evo.trapinch

evo.cacnea = {
	ndex = 331,
	name = 'cacnea',

	evos = {
		{
			ndex = 332,
			name = 'cacturne',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.cacturne = evo.cacnea
evo[331], evo[332] = evo.cacnea, evo.cacnea

evo.swablu = {
	ndex = 333,
	name = 'swablu',

	evos = {
		{
			ndex = 334,
			name = 'altaria',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.altaria = evo.swablu
evo[333], evo[334] = evo.swablu, evo.swablu

evo.zangoose = { ndex = 335, name = 'zangoose' }
evo[335] = evo.zangoose

evo.seviper = { ndex = 336, name = 'seviper' }
evo[336] = evo.seviper

evo.lunatone = { ndex = 337, name = 'lunatone' }
evo[337] = evo.lunatone

evo.solrock = { ndex = 338, name = 'solrock' }
evo[338] = evo.solrock

evo.barboach = {
	ndex = 339,
	name = 'barboach',

	evos = {
		{
			ndex = 340,
			name = 'whiscash',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.whiscash = evo.barboach
evo[339], evo[340] = evo.barboach, evo.barboach

evo.corphish = {
	ndex = 341,
	name = 'corphish',

	evos = {
		{
			ndex = 342,
			name = 'crawdaunt',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.crawdaunt = evo.corphish
evo[341], evo[342] = evo.corphish, evo.corphish

evo.baltoy = {
	ndex = 343,
	name = 'baltoy',

	evos = {
		{
			ndex = 344,
			name = 'claydol',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.claydol = evo.baltoy
evo[343], evo[344] = evo.baltoy, evo.baltoy

evo.lileep = {
	ndex = 345,
	name = 'lileep',

	evos = {
		{
			ndex = 346,
			name = 'cradily',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.cradily = evo.lileep
evo[345], evo[346] = evo.lileep, evo.lileep

evo.anorith = {
	ndex = 347,
	name = 'anorith',

	evos = {
		{
			ndex = 348,
			name = 'armaldo',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.armaldo = evo.anorith
evo[347], evo[348] = evo.anorith, evo.anorith

-- What to do with different evo methods? Answer: we go ignorant!
evo.feebas = {
	ndex = 349,
	name = 'feebas',

	evos = {
		{
			ndex = 350,
			name = 'milotic',
			method = evo.methods.TRADE,
			conditions = {
				[evo.conditions.ITEM] = "Squama Bella",
				[evo.conditions.OTHER] = table.concat{
					"oppure<div>",
					links.bag("Fascia Blu"),
					"</div>[[Livello|Aumento di livello]]<div>con la [[Bellezza (virtù)|virtù Bellezza]] alta</div>",
				},
			}
		}
	}
}
evo.milotic = evo.feebas
evo[349], evo[350] = evo.feebas, evo.feebas

evo.castform = { ndex = 351, name = 'castform' }
evo[351] = evo.castform

evo.kecleon = { ndex = 352, name = 'kecleon' }
evo[352] = evo.kecleon

evo.shuppet = {
	ndex = 353,
	name = 'shuppet',

	evos = {
		{
			ndex = 354,
			name = 'banette',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.banette = evo.shuppet
evo[353], evo[354] = evo.shuppet, evo.shuppet

evo.duskull = {
	ndex = 355,
	name = 'duskull',

	evos = {
		{
			ndex = 356,
			name = 'dusclops',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,

			evos = {
				{
					ndex = 477,
					name = 'dusknoir',
					method = evo.methods.TRADE,
					conditions = {
						[evo.conditions.ITEM] = 'Terrorpanno',
						[evo.conditions.OTHER] = "oppure usando [[Terrorpanno]]" .. sup.LPA,
					},
				}
			}
		}
	}
}
evo.dusclops, evo.dusknoir = evo.duskull, evo.duskull
evo[355], evo[356], evo[477] = evo.duskull, evo.duskull, evo.duskull

evo.tropius = { ndex = 357, name = 'tropius' }
evo[357] = evo.tropius

evo.chingling = {
	ndex = 433,
	name = 'chingling',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Puroaroma' },

	evos = {
		{
			ndex = 358,
			name = 'chimecho',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' }
		}
	}
}
evo.chimecho = evo.chingling
evo[433], evo[358] = evo.chingling, evo.chingling

evo.absol = { ndex = 359, name = 'absol' }
evo[359] = evo.absol

evo.snorunt = {
	ndex = 361,
	name = 'snorunt',

	evos = {
		{
			ndex = 362,
			name = 'glalie',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,
		},
		{
			ndex = 478,
			name = 'froslass',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralbore',
			conditions = { [evo.conditions.GENDER] = 'Femmina' }
		}
	}
}
evo.glalie, evo.froslass = evo.snorunt, evo.snorunt
evo[361], evo[362], evo[478] = evo.snorunt, evo.snorunt, evo.snorunt

evo.spheal = {
	ndex = 363,
	name = 'spheal',

	evos = {
		{
			ndex = 364,
			name = 'sealeo',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 365,
					name = 'walrein',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 44,
				}
			}
		}
	}
}
evo.sealeo, evo.walrein = evo.spheal, evo.spheal
evo[363], evo[364], evo[365] = evo.spheal, evo.spheal, evo.spheal

evo.clamperl = {
	ndex = 366,
	name = 'clamperl',

	evos = {
		{
			ndex = 367,
			name = 'huntail',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Dente Abissi' },
		},
		{
			ndex = 368,
			name = 'gorebyss',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Squamabissi' },
		}
	}
}
evo.huntail, evo.gorebyss = evo.clamperl, evo.clamperl
evo[366], evo[367], evo[368] = evo.clamperl, evo.clamperl, evo.clamperl

evo.relicanth = { ndex = 369, name = 'relicanth' }
evo[369] = evo.relicanth

evo.luvdisc = { ndex = 370, name = 'luvdisc' }
evo[370] = evo.luvdisc

evo.bagon = {
	ndex = 371,
	name = 'bagon',

	evos = {
		{
			ndex = 372,
			name = 'shelgon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 373,
					name = 'salamence',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 50,
				}
			}
		}
	}
}
evo.shelgon, evo.salamence = evo.bagon, evo.bagon
evo[371], evo[372], evo[373] = evo.bagon, evo.bagon, evo.bagon

evo.beldum = {
	ndex = 374,
	name = 'beldum',

	evos = {
		{
			ndex = 375,
			name = 'metang',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 376,
					name = 'metagross',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 45,
				}
			}
		}
	}
}
evo.metang, evo.metagross = evo.beldum, evo.beldum
evo[374], evo[375], evo[376] = evo.beldum, evo.beldum, evo.beldum

evo.regirock = { ndex = 377, name = 'regirock' }
evo[377] = evo.regirock

evo.regice = { ndex = 378, name = 'regice' }
evo[378] = evo.regice

evo.registeel = { ndex = 379, name = 'registeel' }
evo[379] = evo.registeel

evo.latias = { ndex = 380, name = 'latias' }
evo[380] = evo.latias

evo.latios = { ndex = 381, name = 'latios' }
evo[381] = evo.latios

evo.kyogre = { ndex = 382, name = 'kyogre' }
evo[382] = evo.kyogre

evo.groudon = { ndex = 383, name = 'groudon' }
evo[383] = evo.groudon

evo.rayquaza = { ndex = 384, name = 'rayquaza' }
evo[384] = evo.rayquaza

evo.jirachi = { ndex = 385, name = 'jirachi' }
evo[385] = evo.jirachi

evo.deoxys = { ndex = 386, name = 'deoxys' }
evo[386] = evo.deoxys

evo.turtwig = {
	ndex = 387,
	name = 'turtwig',

	evos = {
		{
			ndex = 388,
			name = 'grotle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 389,
					name = 'torterra',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 32,
				}
			}
		}
	}
}
evo.grotle, evo.torterra = evo.turtwig, evo.turtwig
evo[387], evo[388], evo[389] = evo.turtwig, evo.turtwig, evo.turtwig

evo.chimchar = {
	ndex = 390,
	name = 'chimchar',

	evos = {
		{
			ndex = 391,
			name = 'monferno',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 392,
					name = 'infernape',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.monferno, evo.infernape = evo.chimchar, evo.chimchar
evo[390], evo[391], evo[392] = evo.chimchar, evo.chimchar, evo.chimchar

evo.piplup = {
	ndex = 393,
	name = 'piplup',

	evos = {
		{
			ndex = 394,
			name = 'prinplup',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 395,
					name = 'empoleon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.prinplup, evo.empoleon = evo.piplup, evo.piplup
evo[393], evo[394], evo[395] = evo.piplup, evo.piplup, evo.piplup

evo.starly = {
	ndex = 396,
	name = 'starly',

	evos = {
		{
			ndex = 397,
			name = 'staravia',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 398,
					name = 'staraptor',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				}
			}
		}
	}
}
evo.staravia, evo.staraptor = evo.starly, evo.starly
evo[396], evo[397], evo[398] = evo.starly, evo.starly, evo.starly

evo.bidoof = {
	ndex = 399,
	name = 'bidoof',

	evos = {
		{
			ndex = 400,
			name = 'bibarel',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.bibarel = evo.bidoof
evo[399], evo[400] = evo.bidoof, evo.bidoof

evo.kricketot = {
	ndex = 401,
	name = 'kricketot',

	evos = {
		{
			ndex = 402,
			name = 'kricketune',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 10,
		}
	}
}
evo.kricketune = evo.kricketot
evo[401], evo[402] = evo.kricketot, evo.kricketot

evo.shinx = {
	ndex = 403,
	name = 'shinx',

	evos = {
		{
			ndex = 404,
			name = 'luxio',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,

			evos = {
				{
					ndex = 405,
					name = 'luxray',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				}
			}
		}
	}
}
evo.luxio, evo.luxray = evo.shinx, evo.shinx
evo[403], evo[404], evo[405] = evo.shinx, evo.shinx, evo.shinx

evo.cranidos = {
	ndex = 408,
	name = 'cranidos',

	evos = {
		{
			ndex = 409,
			name = 'rampardos',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.rampardos = evo.cranidos
evo[408], evo[409] = evo.cranidos, evo.cranidos

evo.shieldon = {
	ndex = 410,
	name = 'shieldon',

	evos = {
		{
			ndex = 411,
			name = 'bastiodon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.bastiodon = evo.shieldon
evo[410], evo[411] = evo.shieldon, evo.shieldon

evo.burmy = {
	ndex = 412,
	name = 'burmy',
	notes = useless.burmy.names.base,

	evos = {
		{
			ndex = 413,
			name = 'wormadam',
			notes = useless.burmy.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.GENDER] = 'Femmina' },
		},
		{
			ndex = 414,
			name = 'mothim',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.GENDER] = 'Maschio' },
		}
	}
}
evo.wormadam, evo.mothim = evo.burmy, evo.burmy
evo[412], evo[413], evo[414] = evo.burmy, evo.burmy, evo.burmy

evo.combee = {
	ndex = 415,
	name = 'combee',

	evos = {
		{
			ndex = 416,
			name = 'vespiquen',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,
			conditions = { [evo.conditions.GENDER] = 'Femmina' },
		}
	}
}
evo.vespiquen = evo.combee
evo[415], evo[416] = evo.combee, evo.combee

evo.pachirisu = { ndex = 417, name = 'pachirisu' }
evo[417] = evo.pachirisu

evo.buizel = {
	ndex = 418,
	name = 'buizel',

	evos = {
		{
			ndex = 419,
			name = 'floatzel',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.floatzel = evo.buizel
evo[418], evo[419] = evo.buizel, evo.buizel

evo.cherubi = {
	ndex = 420,
	name = 'cherubi',

	evos = {
		{
			ndex = 421,
			name = 'cherrim',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.cherrim = evo.cherubi
evo[420], evo[421] = evo.cherubi, evo.cherubi

evo.shellos = {
	ndex = 422,
	name = 'shellos',
	notes = useless.shellos.names.base,

	evos = {
		{
			ndex = 423,
			name = 'gastrodon',
			notes = useless.shellos.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.gastrodon = evo.shellos
evo[422], evo[423] = evo.shellos, evo.shellos

evo.drifloon = {
	ndex = 425,
	name = 'drifloon',

	evos = {
		{
			ndex = 426,
			name = 'drifblim',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.drifblim = evo.drifloon
evo[425], evo[426] = evo.drifloon, evo.drifloon

evo.buneary = {
	ndex = 427,
	name = 'buneary',

	evos = {
		{
			ndex = 428,
			name = 'lopunny',
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.lopunny = evo.buneary
evo[427], evo[428] = evo.buneary, evo.buneary

evo.glameow = {
	ndex = 431,
	name = 'glameow',

	evos = {
		{
			ndex = 432,
			name = 'purugly',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.purugly = evo.glameow
evo[431], evo[432] = evo.glameow, evo.glameow

evo.stunky = {
	ndex = 434,
	name = 'stunky',

	evos = {
		{
			ndex = 435,
			name = 'skuntank',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.skuntank = evo.stunky
evo[434], evo[435] = evo.stunky, evo.stunky

evo.bronzor = {
	ndex = 436,
	name = 'bronzor',

	evos = {
		{
			ndex = 437,
			name = 'bronzong',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.bronzong = evo.bronzor
evo[436], evo[437] = evo.bronzor, evo.bronzor

evo.chatot = { ndex = 441, name = 'chatot' }
evo[441] = evo.chatot

evo.spiritomb = { ndex = 442, name = 'spiritomb' }
evo[442] = evo.spiritomb

evo.gible = {
	ndex = 443,
	name = 'gible',

	evos = {
		{
			ndex = 444,
			name = 'gabite',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,

			evos = {
				{
					ndex = 445,
					name = 'garchomp',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 48,
				}
			}
		}
	}
}
evo.gabite, evo.garchomp = evo.gible, evo.gible
evo[443], evo[444], evo[445] = evo.gible, evo.gible, evo.gible

evo.riolu = {
	ndex = 447,
	name = 'riolu',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 448,
			name = 'lucario',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.lucario = evo.riolu
evo[447], evo[448] = evo.riolu, evo.riolu

evo.hippopotas = {
	ndex = 449,
	name = 'hippopotas',

	evos = {
		{
			ndex = 450,
			name = 'hippowdon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.hippowdon = evo.hippopotas
evo[449], evo[450] = evo.hippopotas, evo.hippopotas

evo.skorupi = {
	ndex = 451,
	name = 'skorupi',

	evos = {
		{
			ndex = 452,
			name = 'drapion',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.drapion = evo.skorupi
evo[451], evo[452] = evo.skorupi, evo.skorupi

evo.croagunk = {
	ndex = 453,
	name = 'croagunk',

	evos = {
		{
			ndex = 454,
			name = 'toxicroak',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.toxicroak = evo.croagunk
evo[453], evo[454] = evo.croagunk, evo.croagunk

evo.carnivine = { ndex = 455, name = 'carnivine' }
evo[455] = evo.carnivine

evo.finneon = {
	ndex = 456,
	name = 'finneon',

	evos = {
		{
			ndex = 457,
			name = 'lumineon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.lumineon = evo.finneon
evo[456], evo[457] = evo.finneon, evo.finneon

evo.snover = {
	ndex = 459,
	name = 'snover',

	evos = {
		{
			ndex = 460,
			name = 'abomasnow',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.abomasnow = evo.snover
evo[459], evo[460] = evo.snover, evo.snover

evo.rotom = { ndex = 479, name = 'rotom' }
evo[479] = evo.rotom

evo.uxie = { ndex = 480, name = 'uxie' }
evo[480] = evo.uxie

evo.mesprit = { ndex = 481, name = 'mesprit' }
evo[481] = evo.mesprit

evo.azelf = { ndex = 482, name = 'azelf' }
evo[482] = evo.azelf

evo.dialga = { ndex = 483, name = 'dialga' }
evo[483] = evo.dialga

evo.palkia = { ndex = 484, name = 'palkia' }
evo[484] = evo.palkia

evo.heatran = { ndex = 485, name = 'heatran' }
evo[485] = evo.heatran

evo.regigigas = { ndex = 486, name = 'regigigas' }
evo[486] = evo.regigigas

evo.giratina = { ndex = 487, name = 'giratina' }
evo[487] = evo.giratina

evo.cresselia = { ndex = 488, name = 'cresselia' }
evo[488] = evo.cresselia

evo.phione = {
	ndex = 489,
	name = 'phione',
	method = evo.methods.BREED,
	conditions = { [evo.conditions.BREEDONLY] = true },

	evos = {
		{
			ndex = 490,
			name = 'manaphy',
		}
	}
}
evo.manaphy = evo.phione
evo[489], evo[490] = evo.phione, evo.phione

evo.darkrai = { ndex = 491, name = 'darkrai' }
evo[491] = evo.darkrai

evo.shaymin = { ndex = 492, name = 'shaymin' }
evo[492] = evo.shaymin

evo.arceus = { ndex = 493, name = 'arceus' }
evo[493] = evo.arceus

evo.victini = { ndex = 494, name = 'victini' }
evo[494] = evo.victini

evo.snivy = {
	ndex = 495,
	name = 'snivy',

	evos = {
		{
			ndex = 496,
			name = 'servine',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 497,
					name = 'serperior',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.servine, evo.serperior = evo.snivy, evo.snivy
evo[495], evo[496], evo[497] = evo.snivy, evo.snivy, evo.snivy

evo.tepig = {
	ndex = 498,
	name = 'tepig',

	evos = {
		{
			ndex = 499,
			name = 'pignite',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 500,
					name = 'emboar',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.pignite, evo.emboar = evo.tepig, evo.tepig
evo[498], evo[499], evo[500] = evo.tepig, evo.tepig, evo.tepig

evo.oshawott = {
	ndex = 501,
	name = 'oshawott',

	evos = {
		{
			ndex = 502,
			name = 'dewott',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 503,
					name = 'samurott',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				},
				{
					ndex = '503H',
					name = 'samurottH',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
					conditions = { [evo.conditions.REGION] = 'Hisui' },
				}
			}
		}
	}
}
evo.dewott, evo.samurott, evo.samurottH = evo.oshawott, evo.oshawott, evo.oshawott
evo[501], evo[502], evo[503], evo['503H'] = evo.oshawott, evo.oshawott, evo.oshawott, evo.oshawott

evo.patrat = {
	ndex = 504,
	name = 'patrat',

	evos = {
		{
			ndex = 505,
			name = 'watchog',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.watchog = evo.patrat
evo[504], evo[505] = evo.patrat, evo.patrat

evo.lillipup = {
	ndex = 506,
	name = 'lillipup',

	evos = {
		{
			ndex = 507,
			name = 'herdier',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 508,
					name = 'stoutland',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 32,
				}
			}
		}
	}
}
evo.herdier, evo.stoutland = evo.lillipup, evo.lillipup
evo[506], evo[507], evo[508] = evo.lillipup, evo.lillipup, evo.lillipup

evo.purrloin = {
	ndex = 509,
	name = 'purrloin',

	evos = {
		{
			ndex = 510,
			name = 'liepard',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.liepard = evo.purrloin
evo[509], evo[510] = evo.purrloin, evo.purrloin

evo.pansage = {
	ndex = 511,
	name = 'pansage',

	evos = {
		{
			ndex = 512,
			name = 'simisage',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
		}
	}
}
evo.simisage = evo.pansage
evo[511], evo[512] = evo.pansage, evo.pansage

evo.pansear = {
	ndex = 513,
	name = 'pansear',

	evos = {
		{
			ndex = 514,
			name = 'simisear',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.simisear = evo.pansear
evo[513], evo[514] = evo.pansear, evo.pansear

evo.panpour = {
	ndex = 515,
	name = 'panpour',

	evos = {
		{
			ndex = 516,
			name = 'simipour',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.simipour = evo.panpour
evo[515], evo[516] = evo.panpour, evo.panpour

evo.munna = {
	ndex = 517,
	name = 'munna',

	evos = {
		{
			ndex = 518,
			name = 'musharna',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralunare',
		}
	}
}
evo.musharna = evo.munna
evo[517], evo[518] = evo.munna, evo.munna

evo.pidove = {
	ndex = 519,
	name = 'pidove',

	evos = {
		{
			ndex = 520,
			name = 'tranquill',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 521,
					name = 'unfezant',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 32,
				}
			}
		}
	}
}
evo.tranquill, evo.unfezant = evo.pidove, evo.pidove
evo[519], evo[520], evo[521] = evo.pidove, evo.pidove, evo.pidove

evo.blitzle = {
	ndex = 522,
	name = 'blitzle',

	evos = {
		{
			ndex = 523,
			name = 'zebstrika',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.zebstrika = evo.blitzle
evo[522], evo[523] = evo.blitzle, evo.blitzle

evo.roggenrola = {
	ndex = 524,
	name = 'roggenrola',

	evos = {
		{
			ndex = 525,
			name = 'boldore',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 526,
					name = 'gigalith',
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.boldore, evo.gigalith = evo.roggenrola, evo.roggenrola
evo[524], evo[525], evo[526] = evo.roggenrola, evo.roggenrola, evo.roggenrola

evo.woobat = {
	ndex = 527,
	name = 'woobat',

	evos = {
		{
			ndex = 528,
			name = 'swoobat',
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.swoobat = evo.woobat
evo[527], evo[528] = evo.woobat, evo.woobat

evo.drilbur = {
	ndex = 529,
	name = 'drilbur',

	evos = {
		{
			ndex = 530,
			name = 'excadrill',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.excadrill = evo.drilbur
evo[529], evo[530] = evo.drilbur, evo.drilbur

evo.audino = { ndex = 531, name = 'audino' }
evo[531] = evo.audino

evo.timburr = {
	ndex = 532,
	name = 'timburr',

	evos = {
		{
			ndex = 533,
			name = 'gurdurr',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 534,
					name = 'conkeldurr',
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.gurdurr, evo.conkeldurr = evo.timburr, evo.timburr
evo[532], evo[533], evo[534] = evo.timburr, evo.timburr, evo.timburr

evo.tympole = {
	ndex = 535,
	name = 'tympole',

	evos = {
		{
			ndex = 536,
			name = 'palpitoad',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 537,
					name = 'seismitoad',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.palpitoad, evo.seismitoad = evo.tympole, evo.tympole
evo[535], evo[536], evo[537] = evo.tympole, evo.tympole, evo.tympole

evo.throh = { ndex = 538, name = 'throh' }
evo[538] = evo.throh

evo.sawk = { ndex = 539, name = 'sawk' }
evo[539] = evo.sawk

evo.sewaddle = {
	ndex = 540,
	name = 'sewaddle',

	evos = {
		{
			ndex = 541,
			name = 'swadloon',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 542,
					name = 'leavanny',
					method = evo.methods.HAPPINESS,
				}
			}
		}
	}
}
evo.swadloon, evo.leavanny = evo.sewaddle, evo.sewaddle
evo[540], evo[541], evo[542] = evo.sewaddle, evo.sewaddle, evo.sewaddle

evo.venipede = {
	ndex = 543,
	name = 'venipede',

	evos = {
		{
			ndex = 544,
			name = 'whirlipede',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,

			evos = {
				{
					ndex = 545,
					name = 'scolipede',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				}
			}
		}
	}
}
evo.whirlipede, evo.scolipede = evo.venipede, evo.venipede
evo[543], evo[544], evo[545] = evo.venipede, evo.venipede, evo.venipede

evo.cottonee = {
	ndex = 546,
	name = 'cottonee',

	evos = {
		{
			ndex = 547,
			name = 'whimsicott',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.whimsicott = evo.cottonee
evo[546], evo[547] = evo.cottonee, evo.cottonee

evo.petilil = {
	ndex = 548,
	name = 'petilil',

	evos = {
		{
			ndex = 549,
			name = 'lilligant',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		},
		{
			ndex = '549H',
			name = 'lilligantH',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
			conditions = { [evo.conditions.REGION] = 'Hisui' },
		},
	}
}
evo.lilligant, evo.lilligantH = evo.petilil, evo.petilil
evo[548], evo[549], evo['549H'] = evo.petilil, evo.petilil, evo.petilil

evo.basculin = { ndex = 550, name = 'basculin', notes = altforms.basculin.names.base }
evo[550] = evo.basculin

evo.sandile = {
	ndex = 551,
	name = 'sandile',

	evos = {
		{
			ndex = 552,
			name = 'krokorok',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 29,

			evos = {
				{
					ndex = 553,
					name = 'krookodile',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 40,
				}
			}
		}
	}
}
evo.krokorok, evo.krookodile = evo.sandile, evo.sandile
evo[551], evo[552], evo[553] = evo.sandile, evo.sandile, evo.sandile

evo.darumaka = {
	ndex = 554,
	name = 'darumaka',

	evos = {
		{
			ndex = 555,
			name = 'darmanitan',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.darmanitan = evo.darumaka
evo[554], evo[555] = evo.darumaka, evo.darumaka

evo.maractus = { ndex = 556, name = 'maractus' }
evo[556] = evo.maractus

evo.dwebble = {
	ndex = 557,
	name = 'dwebble',

	evos = {
		{
			ndex = 558,
			name = 'crustle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.crustle = evo.dwebble
evo[557], evo[558] = evo.dwebble, evo.dwebble

evo.scraggy = {
	ndex = 559,
	name = 'scraggy',

	evos = {
		{
			ndex = 560,
			name = 'scrafty',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.scrafty = evo.scraggy
evo[559], evo[560] = evo.scraggy, evo.scraggy

evo.sigilyph = { ndex = 561, name = 'sigilyph' }
evo[561] = evo.sigilyph

evo.yamask = {
	ndex = 562,
	name = 'yamask',

	evos = {
		{
			ndex = 563,
			name = 'cofagrigus',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.cofagrigus = evo.yamask
evo[562], evo[563] = evo.yamask, evo.yamask

evo.tirtouga = {
	ndex = 564,
	name = 'tirtouga',

	evos = {
		{
			ndex = 565,
			name = 'carracosta',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.carracosta = evo.tirtouga
evo[564], evo[565] = evo.tirtouga, evo.tirtouga

evo.archen = {
	ndex = 566,
	name = 'archen',

	evos = {
		{
			ndex = 567,
			name = 'archeops',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.archeops = evo.archen
evo[566], evo[567] = evo.archen, evo.archen

evo.trubbish = {
	ndex = 568,
	name = 'trubbish',

	evos = {
		{
			ndex = 569,
			name = 'garbodor',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.garbodor = evo.trubbish
evo[568], evo[569] = evo.trubbish, evo.trubbish

evo.zorua = {
	ndex = 570,
	name = 'zorua',

	evos = {
		{
			ndex = 571,
			name = 'zoroark',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.zoroark = evo.zorua
evo[570], evo[571] = evo.zorua, evo.zorua

evo.minccino = {
	ndex = 572,
	name = 'minccino',

	evos = {
		{
			ndex = 573,
			name = 'cinccino',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrabrillo',
		}
	}
}
evo.cinccino = evo.minccino
evo[572], evo[573] = evo.minccino, evo.minccino

evo.gothita = {
	ndex = 574,
	name = 'gothita',

	evos = {
		{
			ndex = 575,
			name = 'gothorita',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 576,
					name = 'gothitelle',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 41,
				}
			}
		}
	}
}
evo.gothorita, evo.gothitelle = evo.gothita, evo.gothita
evo[574], evo[575], evo[576] = evo.gothita, evo.gothita, evo.gothita

evo.solosis = {
	ndex = 577,
	name = 'solosis',

	evos = {
		{
			ndex = 578,
			name = 'duosion',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 579,
					name = 'reuniclus',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 41,
				}
			}
		}
	}
}
evo.duosion, evo.reuniclus = evo.solosis, evo.solosis
evo[577], evo[578], evo[579] = evo.solosis, evo.solosis, evo.solosis

evo.ducklett = {
	ndex = 580,
	name = 'ducklett',

	evos = {
		{
			ndex = 581,
			name = 'swanna',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.swanna = evo.ducklett
evo[580], evo[581] = evo.ducklett, evo.ducklett

evo.vanillite = {
	ndex = 582,
	name = 'vanillite',

	evos = {
		{
			ndex = 583,
			name = 'vanillish',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 584,
					name = 'vanilluxe',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 47,
				}
			}
		}
	}
}
evo.vanillish, evo.vanilluxe = evo.vanillite, evo.vanillite
evo[582], evo[583], evo[584] = evo.vanillite, evo.vanillite, evo.vanillite

evo.deerling = {
	ndex = 585,
	name = 'deerling',
	notes = useless.deerling.names.base,

	evos = {
		{
			ndex = 586,
			name = 'sawsbuck',
			notes = useless.sawsbuck.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.sawsbuck = evo.deerling
evo[585], evo[586] = evo.deerling, evo.deerling

evo.emolga = { ndex = 587, name = 'emolga' }
evo[587] = evo.emolga

evo.karrablast = {
	ndex = 588,
	name = 'karrablast',

	evos = {
		{
			ndex = 589,
			name = 'escavalier',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.TRADED_FOR] = 616 },
		}
	}
}
evo.escavalier = evo.karrablast
evo[588], evo[589] = evo.karrablast, evo.karrablast

evo.foongus = {
	ndex = 590,
	name = 'foongus',

	evos = {
		{
			ndex = 591,
			name = 'amoonguss',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.amoonguss = evo.foongus
evo[590], evo[591] = evo.foongus, evo.foongus

evo.frillish = {
	ndex = 592,
	name = 'frillish',
	notes = useless.frillish.names.base,

	evos = {
		{
			ndex = 593,
			name = 'jellicent',
			notes = useless.frillish.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.jellicent = evo.frillish
evo[592], evo[593] = evo.frillish, evo.frillish

evo.alomomola = { ndex = 594, name = 'alomomola' }
evo[594] = evo.alomomola

evo.joltik = {
	ndex = 595,
	name = 'joltik',

	evos = {
		{
			ndex = 596,
			name = 'galvantula',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.galvantula = evo.joltik
evo[595], evo[596] = evo.joltik, evo.joltik

evo.ferroseed = {
	ndex = 597,
	name = 'ferroseed',

	evos = {
		{
			ndex = 598,
			name = 'ferrothorn',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.ferrothorn = evo.ferroseed
evo[597], evo[598] = evo.ferroseed, evo.ferroseed

evo.klink = {
	ndex = 599,
	name = 'klink',

	evos = {
		{
			ndex = 600,
			name = 'klang',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,

			evos = {
				{
					ndex = 601,
					name = 'klinklang',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 49,
				}
			}
		}
	}
}
evo.klang, evo.klinklang = evo.klink, evo.klink
evo[599], evo[600], evo[601] = evo.klink, evo.klink, evo.klink

evo.tynamo = {
	ndex = 602,
	name = 'tynamo',

	evos = {
		{
			ndex = 603,
			name = 'eelektrik',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,

			evos = {
				{
					ndex = 604,
					name = 'eelektross',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietratuono',
				}
			}
		}
	}
}
evo.eelektrik, evo.eelektross = evo.tynamo, evo.tynamo
evo[602], evo[603], evo[604] = evo.tynamo, evo.tynamo, evo.tynamo

evo.elgyem = {
	ndex = 605,
	name = 'elgyem',

	evos = {
		{
			ndex = 606,
			name = 'beheeyem',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,
		}
	}
}
evo.beheeyem = evo.elgyem
evo[605], evo[606] = evo.elgyem, evo.elgyem

evo.litwick = {
	ndex = 607,
	name = 'litwick',

	evos = {
		{
			ndex = 608,
			name = 'lampent',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 41,

			evos = {
				{
					ndex = 609,
					name = 'chandelure',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Neropietra',
				}
			}
		}
	}
}
evo.lampent, evo.chandelure = evo.litwick, evo.litwick
evo[607], evo[608], evo[609] = evo.litwick, evo.litwick, evo.litwick

evo.axew = {
	ndex = 610,
	name = 'axew',

	evos = {
		{
			ndex = 611,
			name = 'fraxure',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,

			evos = {
				{
					ndex = 612,
					name = 'haxorus',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 48,
				}
			}
		}
	}
}
evo.fraxure, evo.haxorus = evo.axew, evo.axew
evo[610], evo[611], evo[612] = evo.axew, evo.axew, evo.axew

evo.cubchoo = {
	ndex = 613,
	name = 'cubchoo',

	evos = {
		{
			ndex = 614,
			name = 'beartic',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.beartic = evo.cubchoo
evo[613], evo[614] = evo.cubchoo, evo.cubchoo

evo.cryogonal = { ndex = 615, name = 'cryogonal' }
evo[615] = evo.cryogonal

evo.shelmet = {
	ndex = 616,
	name = 'shelmet',

	evos = {
		{
			ndex = 617,
			name = 'accelgor',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.TRADED_FOR] = 588 },
		}
	}
}
evo.accelgor = evo.shelmet
evo[616], evo[617] = evo.shelmet, evo.shelmet

evo.stunfisk = { ndex = 618, name = 'stunfisk' }
evo[618] = evo.stunfisk

evo.mienfoo = {
	ndex = 619,
	name = 'mienfoo',

	evos = {
		{
			ndex = 620,
			name = 'mienshao',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 50,
		}
	}
}
evo.mienshao = evo.mienfoo
evo[619], evo[620] = evo.mienfoo, evo.mienfoo

evo.druddigon = { ndex = 621, name = 'druddigon' }
evo[621] = evo.druddigon

evo.golett = {
	ndex = 622,
	name = 'golett',

	evos = {
		{
			ndex = 623,
			name = 'golurk',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 43,
		}
	}
}
evo.golurk = evo.golett
evo[622], evo[623] = evo.golett, evo.golett

evo.pawniard = {
	ndex = 624,
	name = 'pawniard',

	evos = {
		{
			ndex = 625,
			name = 'bisharp',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 52,
		}
	}
}
evo.bisharp = evo.pawniard
evo[624], evo[625] = evo.pawniard, evo.pawniard

evo.bouffalant = { ndex = 626, name = 'bouffalant' }
evo[626] = evo.bouffalant

evo.rufflet = {
	ndex = 627,
	name = 'rufflet',

	evos = {
		{
			ndex = 628,
			name = 'braviary',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 54,
		},
		{
			ndex = '628H',
			name = 'braviaryH',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 54,
			conditions = { [evo.conditions.REGION] = 'Hisui' },
		},
	}
}
evo.braviary, evo.braviaryH = evo.rufflet, evo.rufflet
evo[627], evo[628], evo['628H'] = evo.rufflet, evo.rufflet, evo.rufflet

evo.vullaby = {
	ndex = 629,
	name = 'vullaby',

	evos = {
		{
			ndex = 630,
			name = 'mandibuzz',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 54,
		}
	}
}
evo.mandibuzz = evo.vullaby
evo[629], evo[630] = evo.vullaby, evo.vullaby

evo.heatmor = { ndex = 631, name = 'heatmor' }
evo[631] = evo.heatmor

evo.durant = { ndex = 632, name = 'durant' }
evo[632] = evo.durant

evo.deino = {
	ndex = 633,
	name = 'deino',

	evos = {
		{
			ndex = 634,
			name = 'zweilous',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 50,

			evos = {
				{
					ndex = 635,
					name = 'hydreigon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 64,
				}
			}
		}
	}
}
evo.zweilous, evo.hydreigon = evo.deino, evo.deino
evo[633], evo[634], evo[635] = evo.deino, evo.deino, evo.deino

evo.larvesta = {
	ndex = 636,
	name = 'larvesta',

	evos = {
		{
			ndex = 637,
			name = 'volcarona',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 59,
		}
	}
}
evo.volcarona = evo.larvesta
evo[636], evo[637] = evo.larvesta, evo.larvesta

evo.cobalion = { ndex = 638, name = 'cobalion' }
evo[638] = evo.cobalion

evo.terrakion = { ndex = 639, name = 'terrakion' }
evo[639] = evo.terrakion

evo.virizion = { ndex = 640, name = 'virizion' }
evo[640] = evo.virizion

evo.tornadus = { ndex = 641, name = 'tornadus' }
evo[641] = evo.tornadus

evo.thundurus = { ndex = 642, name = 'thundurus' }
evo[642] = evo.thundurus

evo.reshiram = { ndex = 643, name = 'reshiram' }
evo[643] = evo.reshiram

evo.zekrom = { ndex = 644, name = 'zekrom' }
evo[644] = evo.zekrom

evo.landorus = { ndex = 645, name = 'landorus' }
evo[645] = evo.landorus

evo.kyurem = { ndex = 646, name = 'kyurem' }
evo[646] = evo.kyurem

evo.keldeo = { ndex = 647, name = 'keldeo' }
evo[647] = evo.keldeo

evo.meloetta = { ndex = 648, name = 'meloetta' }
evo[648] = evo.meloetta

evo.genesect = { ndex = 649, name = 'genesect' }
evo[649] = evo.genesect

evo.chespin = {
	ndex = 650,
	name = 'chespin',

	evos = {
		{
			ndex = 651,
			name = 'quilladin',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 652,
					name = 'chesnaught',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.quilladin, evo.chesnaught = evo.chespin, evo.chespin
evo[650], evo[651], evo[652] = evo.chespin, evo.chespin, evo.chespin

evo.fennekin = {
	ndex = 653,
	name = 'fennekin',

	evos = {
		{
			ndex = 654,
			name = 'braixen',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 655,
					name = 'delphox',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.braixen, evo.delphox = evo.fennekin, evo.fennekin
evo[653], evo[654], evo[655] = evo.fennekin, evo.fennekin, evo.fennekin

evo.froakie = {
	ndex = 656,
	name = 'froakie',

	evos = {
		{
			ndex = 657,
			name = 'frogadier',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 658,
					name = 'greninja',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.frogadier, evo.greninja = evo.froakie, evo.froakie
evo[656], evo[657], evo[658] = evo.froakie, evo.froakie, evo.froakie

evo.bunnelby = {
	ndex = 659,
	name = 'bunnelby',

	evos = {
		{
			ndex = 660,
			name = 'diggersby',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.diggersby = evo.bunnelby
evo[659], evo[660] = evo.bunnelby, evo.bunnelby

evo.fletchling = {
	ndex = 661,
	name = 'fletchling',

	evos = {
		{
			ndex = 662,
			name = 'fletchinder',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 663,
					name = 'talonflame',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 35,
				}
			}
		}
	}
}
evo.fletchinder, evo.talonflame = evo.fletchling, evo.fletchling
evo[661], evo[662], evo[663] = evo.fletchling, evo.fletchling, evo.fletchling

evo.scatterbug = {
	ndex = 664,
	name = 'scatterbug',

	evos = {
		{
			ndex = 665,
			name = 'spewpa',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 9,

			evos = {
				{
					ndex = 666,
					name = 'vivillon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 12,
				}
			}
		}
	}
}
evo.spewpa, evo.vivillon = evo.scatterbug, evo.scatterbug
evo[664], evo[665], evo[666] = evo.scatterbug, evo.scatterbug, evo.scatterbug

evo.litleo = {
	ndex = 667,
	name = 'litleo',

	evos = {
		{
			ndex = 668,
			name = 'pyroar',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.pyroar = evo.litleo
evo[667], evo[668] = evo.litleo, evo.litleo

evo["flabébé"] = {
	ndex = 669,
	name = 'flabébé',
	notes = useless.floette.names.base,

	evos = {
		{
			ndex = 670,
			name = 'floette',
			notes = useless.floette.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 19,

			evos = {
				{
					ndex = 671,
					name = 'florges',
					notes = useless.floette.names.base,
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrabrillo',
				}
			}
		}
	}
}
evo.floette, evo.florges = evo["flabébé"], evo["flabébé"]
evo[669], evo[670], evo[671] = evo["flabébé"], evo["flabébé"], evo["flabébé"]

evo.skiddo = {
	ndex = 672,
	name = 'skiddo',

	evos = {
		{
			ndex = 673,
			name = 'gogoat',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.gogoat = evo.skiddo
evo[672], evo[673] = evo.skiddo, evo.skiddo

evo.pancham = {
	ndex = 674,
	name = 'pancham',

	evos = {
		{
			ndex = 675,
			name = 'pangoro',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
			conditions = { [evo.conditions.OTHER] = 'Con un Pokémon [[Buio]] in [[squadra]]' },
		}
	}
}
evo.pangoro = evo.pancham
evo[674], evo[675] = evo.pancham, evo.pancham

evo.furfrou = { ndex = 676, name = 'furfrou' }
evo[676] = evo.furfrou

evo.espurr = {
	ndex = 677,
	name = 'espurr',

	evos = {
		{
			ndex = 678,
			name = 'meowstic',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.meowstic = evo.espurr
evo[677], evo[678] = evo.espurr, evo.espurr

evo.honedge = {
	ndex = 679,
	name = 'honedge',

	evos = {
		{
			ndex = 680,
			name = 'doublade',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 681,
					name = 'aegislash',
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Neropietra',
				}
			}
		}
	}
}
evo.doublade, evo.aegislash = evo.honedge, evo.honedge
evo[679], evo[680], evo[681] = evo.honedge, evo.honedge, evo.honedge

evo.spritzee = {
	ndex = 682,
	name = 'spritzee',

	evos = {
		{
			ndex = 683,
			name = 'aromatisse',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Bustina aromi' },
		}
	}
}
evo.aromatisse = evo.spritzee
evo[682], evo[683] = evo.spritzee, evo.spritzee

evo.swirlix = {
	ndex = 684,
	name = 'swirlix',

	evos = {
		{
			ndex = 685,
			name = 'slurpuff',
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Dolcespuma' },
		}
	}
}
evo.slurpuff = evo.swirlix
evo[684], evo[685] = evo.swirlix, evo.swirlix

evo.inkay = {
	ndex = 686,
	name = 'inkay',

	evos = {
		{
			ndex = 687,
			name = 'malamar',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
			conditions = { [evo.conditions.OTHER] = 'Capovolgendo la console' },
		}
	}
}
evo.malamar = evo.inkay
evo[686], evo[687] = evo.inkay, evo.inkay

evo.binacle = {
	ndex = 688,
	name = 'binacle',

	evos = {
		{
			ndex = 689,
			name = 'barbaracle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.barbaracle = evo.binacle
evo[688], evo[689] = evo.binacle, evo.binacle

evo.skrelp = {
	ndex = 690,
	name = 'skrelp',

	evos = {
		{
			ndex = 691,
			name = 'dragalge',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 41,
		}
	}
}
evo.dragalge = evo.skrelp
evo[690], evo[691] = evo.skrelp, evo.skrelp

evo.clauncher = {
	ndex = 692,
	name = 'clauncher',

	evos = {
		{
			ndex = 693,
			name = 'clawitzer',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.clawitzer = evo.clauncher
evo[692], evo[693] = evo.clauncher, evo.clauncher

evo.helioptile = {
	ndex = 694,
	name = 'helioptile',

	evos = {
		{
			ndex = 695,
			name = 'heliolisk',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.heliolisk = evo.helioptile
evo[694], evo[695] = evo.helioptile, evo.helioptile

evo.tyrunt = {
	ndex = 696,
	name = 'tyrunt',

	evos = {
		{
			ndex = 697,
			name = 'tyrantrum',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.tyrantrum = evo.tyrunt
evo[696], evo[697] = evo.tyrunt, evo.tyrunt

evo.amaura = {
	ndex = 698,
	name = 'amaura',

	evos = {
		{
			ndex = 699,
			name = 'aurorus',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
			conditions = { [evo.conditions.TIME] = 'Notte' },
		}
	}
}
evo.aurorus = evo.amaura
evo[698], evo[699] = evo.amaura, evo.amaura

evo.hawlucha = { ndex = 701, name = 'hawlucha' }
evo[701] = evo.hawlucha

evo.dedenne = { ndex = 702, name = 'dedenne' }
evo[702] = evo.dedenne

evo.carbink = { ndex = 703, name = 'carbink' }
evo[703] = evo.carbink

evo.goomy = {
	ndex = 704,
	name = 'goomy',

	evos = {
		{
			ndex = 705,
			name = 'sliggoo',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,

			evos = {
				{
					ndex = 706,
					name = 'goodra',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 50,
					conditions = { [evo.conditions.OTHER] = "Se [[Pioggia battente|piove]] o c'è [[Nebbia (condizione atmosferica)|nebbia]] nell'overworld" },
				}
			}
		},
		{
			ndex = '705H',
			name = 'sliggooH',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
			conditions = { [evo.conditions.REGION] = 'Hisui' },

			evos = {
				{
					ndex = '706H',
					name = 'goodraH',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 50,
					conditions = { [evo.conditions.OTHER] = "Se [[Pioggia battente|piove]] nell'overworld" },
				}
			}
		},
	}
}
evo.sliggoo, evo.goodra = evo.goomy, evo.goomy
evo[704], evo[705], evo[706] = evo.goomy, evo.goomy, evo.goomy
evo.sliggooH, evo.goodraH = evo.goomy, evo.goomy
evo['705H'], evo['706H'] = evo.goomy, evo.goomy

evo.klefki = { ndex = 707, name = 'klefki' }
evo[707] = evo.klefki

evo.phantump = {
	ndex = 708,
	name = 'phantump',

	evos = {
		{
			ndex = 709,
			name = 'trevenant',
			method = evo.methods.TRADE,
		}
	}
}
evo.trevenant = evo.phantump
evo[708], evo[709] = evo.phantump, evo.phantump

evo.pumpkaboo = {
	ndex = 710,
	name = 'pumpkaboo',
	notes = altforms.pumpkaboo.names.base,

	evos = {
		{
			ndex = 711,
			name = 'gourgeist',
			notes = altforms.gourgeist.names.base,
			method = evo.methods.TRADE,
		}
	}
}
evo.gourgeist = evo.pumpkaboo
evo[710], evo[711] = evo.pumpkaboo, evo.pumpkaboo

evo.bergmite = {
	ndex = 712,
	name = 'bergmite',

	evos = {
		{
			ndex = 713,
			name = 'avalugg',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		},
		{
			ndex = '713H',
			name = 'avaluggH',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
			conditions = { [evo.conditions.REGION] = 'Hisui' },
		},
	}
}
evo.avalugg, evo.avaluggH = evo.bergmite, evo.bergmite
evo[712], evo[713], evo['713H'] = evo.bergmite, evo.bergmite, evo.bergmite

evo.noibat = {
	ndex = 714,
	name = 'noibat',

	evos = {
		{
			ndex = 715,
			name = 'noivern',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 48,
		}
	}
}
evo.noivern = evo.noibat
evo[714], evo[715] = evo.noibat, evo.noibat

evo.xerneas = { ndex = 716, name = 'xerneas' }
evo[716] = evo.xerneas

evo.yveltal = { ndex = 717, name = 'yveltal' }
evo[717] = evo.yveltal

evo.zygarde = { ndex = 718, name = 'zygarde' }
evo[718] = evo.zygarde

evo.diancie = { ndex = 719, name = 'diancie' }
evo[719] = evo.diancie

evo.hoopa = { ndex = 720, name = 'hoopa' }
evo[720] = evo.hoopa

evo.volcanion = { ndex = 721, name = 'volcanion' }
evo[721] = evo.volcanion

evo.rowlet = {
	ndex = 722,
	name = 'rowlet',

	evos = {
		{
			ndex = 723,
			name = 'dartrix',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 724,
					name = 'decidueye',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				},
				{
					ndex = '724H',
					name = 'decidueyeH',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
					conditions = { [evo.conditions.REGION] = 'Hisui' },
				},
			}
		}
	}
}
evo.dartrix, evo.decidueye, evo.decidueyeH = evo.rowlet, evo.rowlet, evo.rowlet
evo[722], evo[723], evo[724], evo['724H'] = evo.rowlet, evo.rowlet, evo.rowlet, evo.rowlet

evo.litten = {
	ndex = 725,
	name = 'litten',

	evos = {
		{
			ndex = 726,
			name = 'torracat',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 727,
					name = 'incineroar',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				}
			}
		}
	}
}
evo.torracat, evo.incineroar = evo.litten, evo.litten
evo[725], evo[726], evo[727] = evo.litten, evo.litten, evo.litten

evo.popplio = {
	ndex = 728,
	name = 'popplio',

	evos = {
		{
			ndex = 729,
			name = 'brionne',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 730,
					name = 'primarina',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				}
			}
		}
	}
}
evo.brionne, evo.primarina = evo.popplio, evo.popplio
evo[728], evo[729], evo[730] = evo.popplio, evo.popplio, evo.popplio

evo.pikipek = {
	ndex = 731,
	name = 'pikipek',

	evos = {
		{
			ndex = 732,
			name = 'trumbeak',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 733,
					name = 'toucannon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 28,
				}
			}
		}
	}
}
evo.trumbeak, evo.toucannon = evo.pikipek, evo.pikipek
evo[731], evo[732], evo[733] = evo.pikipek, evo.pikipek, evo.pikipek

evo.yungoos = {
	ndex = 734,
	name = 'yungoos',

	evos = {
		{
			ndex = 735,
			name = 'gumshoos',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.gumshoos = evo.yungoos
evo[734], evo[735] = evo.yungoos, evo.yungoos

evo.grubbin = {
	ndex = 736,
	name = 'grubbin',

	evos = {
		{
			ndex = 737,
			name = 'charjabug',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 738,
					name = 'vikavolt',
					method = evo.methods.LEVEL,
					conditions = {
						   [evo.conditions.LOCATION] = 'Campo magnetico speciale',
						   [evo.conditions.OTHER] = table.concat{
							"oppure<div>",
							links.bag("Pietratuono"),
							"</div>usando una [[Pietratuono]]",
						},
					},
				}
			}
		}
	}
}
evo.charjabug, evo.vikavolt = evo.grubbin, evo.grubbin
evo[736], evo[737], evo[738] = evo.grubbin, evo.grubbin, evo.grubbin

evo.crabrawler = {
	ndex = 739,
	name = 'crabrawler',

	evos = {
		{
			ndex = 740,
			name = 'crabominable',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Monte Lanakila' },
		}
	}
}
evo.crabominable = evo.crabrawler
evo[739], evo[740] = evo.crabrawler, evo.crabrawler

evo.oricorio = { ndex = 741, name = 'oricorio' }
evo[741] = evo.oricorio

evo.cutiefly = {
	ndex = 742,
	name = 'cutiefly',

	evos = {
		{
			ndex = 743,
			name = 'ribombee',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.ribombee = evo.cutiefly
evo[742], evo[743] = evo.cutiefly, evo.cutiefly

evo.rockruff = {
	ndex = 744,
	name = 'rockruff',

	evos = {
		{
			ndex = 745,
			name = 'lycanroc',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = {
                -- [evo.conditions.OTHER] = 'Di [[Tempo|giorno]]',
                [evo.conditions.TIME] = 'Giorno',
            }
		},
		{
			ndex = '745N',
			name = 'lycanrocN',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = {
                -- [evo.conditions.OTHER] = 'Di [[Tempo|notte]]',
                [evo.conditions.TIME] = 'Notte',
            }
		},
		{
			ndex = '745C',
			name = 'lycanrocC',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = {
                -- [evo.conditions.OTHER] = 'Al tramonto se ha [[Mente Locale]]{{#invoke: sup | UsUl}}{{gensup|8|plus=yes}}',
                [evo.conditions.TIME] = 'Tramonto',
                [evo.conditions.OTHER] = 'con [[Mente Locale]]',
            }
		}
	}
}
evo.lycanroc, evo.lycanrocN, evo.lycanrocC =
	evo.rockruff, evo.rockruff, evo.rockruff
evo[744], evo[745], evo['745N'], evo['745C'] =
	evo.rockruff, evo.rockruff, evo.rockruff, evo.rockruff

evo.wishiwashi = { ndex = 746, name = 'wishiwashi' }
evo[746] = evo.wishiwashi

evo.mareanie = {
	ndex = 747,
	name = 'mareanie',

	evos = {
		{
			ndex = 748,
			name = 'toxapex',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.toxapex = evo.mareanie
evo[747], evo[748] = evo.mareanie, evo.mareanie

evo.mudbray = {
	ndex = 749,
	name = 'mudbray',

	evos = {
		{
			ndex = 750,
			name = 'mudsdale',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.mudsdale = evo.mudbray
evo[749], evo[750] = evo.mudbray, evo.mudbray

evo.dewpider = {
	ndex = 751,
	name = 'dewpider',

	evos = {
		{
			ndex = 752,
			name = 'araquanid',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.araquanid = evo.dewpider
evo[751], evo[752] = evo.dewpider, evo.dewpider

evo.fomantis = {
	ndex = 753,
	name = 'fomantis',

	evos = {
		{
			ndex = 754,
			name = 'lurantis',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.lurantis = evo.fomantis
evo[753], evo[754] = evo.fomantis, evo.fomantis

evo.morelull = {
	ndex = 755,
	name = 'morelull',

	evos = {
		{
			ndex = 756,
			name = 'shiinotic',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.shiinotic = evo.morelull
evo[755], evo[756] = evo.morelull, evo.morelull

evo.salandit = {
	ndex = 757,
	name = 'salandit',

	evos = {
		{
			ndex = 758,
			name = 'salazzle',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
			conditions = { [evo.conditions.GENDER] = 'Femmina' },
		}
	}
}
evo.salazzle = evo.salandit
evo[757], evo[758] = evo.salandit, evo.salandit

evo.stufful = {
	ndex = 759,
	name = 'stufful',

	evos = {
		{
			ndex = 760,
			name = 'bewear',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.bewear = evo.stufful
evo[759], evo[760] = evo.stufful, evo.stufful

evo.bounsweet = {
	ndex = 761,
	name = 'bounsweet',

	evos = {
		{
			ndex = 762,
			name = 'steenee',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 763,
					name = 'tsareena',
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.MOVE] = 'Pestone' },
				}
			}
		}
	}
}
evo.steenee, evo.tsareena = evo.bounsweet, evo.bounsweet
evo[761], evo[762], evo[763] = evo.bounsweet, evo.bounsweet, evo.bounsweet

evo.comfey = { ndex = 764, name = 'comfey' }
evo[764] = evo.comfey

evo.oranguru = { ndex = 765, name = 'oranguru' }
evo[765] = evo.oranguru

evo.passimian = { ndex = 766, name = 'passimian' }
evo[766] = evo.passimian

evo.wimpod = {
	ndex = 767,
	name = 'wimpod',

	evos = {
		{
			ndex = 768,
			name = 'golisopod',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.golisopod = evo.wimpod
evo[767], evo[768] = evo.wimpod, evo.wimpod

evo.sandygast = {
	ndex = 769,
	name = 'sandygast',

	evos = {
		{
			ndex = 770,
			name = 'palossand',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,
		}
	}
}
evo.palossand = evo.sandygast
evo[769], evo[770] = evo.sandygast, evo.sandygast

evo.pyukumuku = { ndex = 771, name = 'pyukumuku' }
evo[771] = evo.pyukumuku

evo["tipo zero"] = {
	ndex = 772,
	name = 'tipo zero',

	evos = {
		{
			ndex = 773,
			name = 'silvally',
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.silvally = evo["tipo zero"]
evo[772], evo[773] = evo["tipo zero"], evo["tipo zero"]

evo.minior = { ndex = 774, name = 'minior' }
evo[774] = evo.minior

evo.komala = { ndex = 775, name = 'komala' }
evo[775] = evo.komala

evo.turtonator = { ndex = 776, name = 'turtonator' }
evo[776] = evo.turtonator

evo.togedemaru = { ndex = 777, name = 'togedemaru' }
evo[777] = evo.togedemaru

evo.mimikyu = { ndex = 778, name = 'mimikyu' }
evo[778] = evo.mimikyu

evo.bruxish = { ndex = 779, name = 'bruxish' }
evo[779] = evo.bruxish

evo.drampa = { ndex = 780, name = 'drampa' }
evo[780] = evo.drampa

evo.dhelmise = { ndex = 781, name = 'dhelmise' }
evo[781] = evo.dhelmise

evo["jangmo-o"] = {
	ndex = 782,
	name = 'jangmo-o',

	evos = {
		{
			ndex = 783,
			name = 'hakamo-o',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 784,
					name = 'kommo-o',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 45,
				}
			}
		}
	}
}
evo["hakamo-o"], evo["kommo-o"] = evo["jangmo-o"], evo["jangmo-o"]
evo[782], evo[783], evo[784] = evo["jangmo-o"], evo["jangmo-o"], evo["jangmo-o"]

evo['tapu koko'] = { ndex = 785, name = 'tapu koko' }
evo[785] = evo['tapu koko']

evo['tapu lele'] = { ndex = 786, name = 'tapu lele' }
evo[786] = evo['tapu lele']

evo['tapu bulu'] = { ndex = 787, name = 'tapu bulu' }
evo[787] = evo['tapu bulu']

evo['tapu fini'] = { ndex = 788, name = 'tapu fini' }
evo[788] = evo['tapu fini']

evo.cosmog = {
	ndex = 789,
	name = 'cosmog',

	evos = {
		{
			ndex = 790,
			name = 'cosmoem',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 43,

			evos = {
				{
					ndex = 791,
					name = 'solgaleo',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 53,
					conditions = { [evo.conditions.OTHER] = 'In [[Pokémon Sole e Luna|Sole]], [[Pokémon Ultrasole e Ultraluna|Ultrasole]] e [[Pokémon Spada e Scudo|Spada]]' }
				},
				{
					ndex = 792,
					name = 'lunala',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 53,
					conditions = { [evo.conditions.OTHER] = 'In [[Pokémon Sole e Luna|Luna]], [[Pokémon Ultrasole e Ultraluna|Ultraluna]] e [[Pokémon Spada e Scudo|Scudo]]' }
				}
			}
		}
	}
}
evo.cosmoem, evo.solgaleo, evo.lunala = evo.cosmog, evo.cosmog, evo.cosmog
evo[789], evo[790], evo[791], evo[792] = evo.cosmog, evo.cosmog, evo.cosmog, evo.cosmog

evo.nihilego = { ndex = 793, name = 'nihilego' }
evo[793] = evo.nihilego

evo.buzzwole = { ndex = 794, name = 'buzzwole' }
evo[794] = evo.buzzwole

evo.pheromosa = { ndex = 795, name = 'pheromosa' }
evo[795] = evo.pheromosa

evo.xurkitree = { ndex = 796, name = 'xurkitree' }
evo[796] = evo.xurkitree

evo.celesteela = { ndex = 797, name = 'celesteela' }
evo[797] = evo.celesteela

evo.kartana = { ndex = 798, name = 'kartana' }
evo[798] = evo.kartana

evo.guzzlord = { ndex = 799, name = 'guzzlord' }
evo[799] = evo.guzzlord

evo.necrozma = { ndex = 800, name = 'necrozma' }
evo[800] = evo.necrozma

evo.magearna = { ndex = 801, name = 'magearna' }
evo[801] = evo.magearna

evo.marshadow = { ndex = 802, name = 'marshadow' }
evo[802] = evo.marshadow

evo.poipole = {
	ndex = 803,
	name = 'poipole',

	evos = {
		{
			ndex = 804,
			name = 'naganadel',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Dragopulsar' },
		}
	}
}
evo.naganadel = evo.poipole
evo[803], evo[804] = evo.poipole, evo.poipole

evo.stakataka = { ndex = 805, name = 'stakataka' }
evo[805] = evo.stakataka

evo.blacephalon = { ndex = 806, name = 'blacephalon' }
evo[806] = evo.blacephalon

evo.zeraora = { ndex = 807, name = 'zeraora' }
evo[807] = evo.zeraora

evo.meltan = {
	ndex = 808,
	name = 'meltan',

	evos = {
		{
			ndex = 809,
			name = 'melmetal',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = '<span class="text-small">Con 400 [[Caramelle]] Meltan in [[Pokémon GO]]</span>',
		}
	}
}
evo.melmetal = evo.meltan
evo[808], evo[809] = evo.meltan, evo.meltan

-- Pokémon without an ndex

evo.grookey = {
	ndex = 810,
	name = 'grookey',

	evos = {
		{
			ndex = 811,
			name = 'thwackey',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 812,
					name = 'rillaboom',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 35,
				}
			}
		}
	}
}
evo.thwackey, evo.rillaboom = evo.grookey, evo.grookey
evo[810], evo[811], evo[812] = evo.grookey, evo.grookey, evo.grookey

evo.scorbunny = {
	ndex = 813,
	name = 'scorbunny',

	evos = {
		{
			ndex = 814,
			name = 'raboot',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 815,
					name = 'cinderace',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 35,
				}
			}
		}
	}
}
evo.raboot, evo.cinderace = evo.scorbunny, evo.scorbunny
evo[813], evo[814], evo[815] = evo.scorbunny, evo.scorbunny, evo.scorbunny

evo.sobble = {
	ndex = 816,
	name = 'sobble',

	evos = {
		{
			ndex = 817,
			name = 'drizzile',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 818,
					name = 'inteleon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 35,
				}
			}
		}
	}
}
evo.drizzile, evo.inteleon = evo.sobble, evo.sobble
evo[816], evo[817], evo[818] = evo.sobble, evo.sobble, evo.sobble

evo.skwovet = {
	ndex = 819,
	name = 'skwovet',

	evos = {
		{
			ndex = 820,
			name = 'greedent',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		},
	}
}
evo.greedent = evo.skwovet
evo[819], evo[820] = evo.skwovet, evo.skwovet

evo.rookidee = {
	ndex = 821,
	name = 'rookidee',

	evos = {
		{
			ndex = 822,
			name = 'corvisquire',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 823,
					name = 'corviknight',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 38,
				}
			}
		}
	}
}
evo.corvisquire, evo.corviknight = evo.rookidee, evo.rookidee
evo[821], evo[822], evo[823] = evo.rookidee, evo.rookidee, evo.rookidee

evo.blipbug = {
	ndex = 824,
	name = 'blipbug',

	evos = {
		{
			ndex = 825,
			name = 'dottler',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 10,

			evos = {
				{
					ndex = 826,
					name = 'orbeetle',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				}
			}
		},
	}
}
evo.dottler, evo.orbeetle = evo.blipbug, evo.blipbug
evo[824], evo[825], evo[826] = evo.blipbug, evo.blipbug, evo.blipbug

evo.nickit = {
	ndex = 827,
	name = 'nickit',

	evos = {
		{
			ndex = 828,
			name = 'thievul',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,
		}
	}
}
evo.thievul = evo.nickit
evo[827], evo[828] = evo.nickit, evo.nickit

evo.gossifleur = {
	ndex = 829,
	name = 'gossifleur',

	evos = {
		{
			ndex = 830,
			name = 'eldegoss',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		},
	}
}
evo.eldegoss = evo.gossifleur
evo[829], evo[830] = evo.gossifleur, evo.gossifleur

evo.wooloo = {
	ndex = 831,
	name = 'wooloo',

	evos = {
		{
			ndex = 832,
			name = 'dubwool',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.dubwool = evo.wooloo
evo[831], evo[832] = evo.wooloo,evo.wooloo

evo.chewtle = {
	ndex = 833,
	name = 'chewtle',

	evos = {
		{
			ndex = 834,
			name = 'drednaw',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.drednaw = evo.chewtle
evo[833], evo[834] = evo.chewtle, evo.chewtle

evo.yamper = {
	ndex = 835,
	name = 'yamper',

	evos = {
		{
			ndex = 836,
			name = 'boltund',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.boltund = evo.yamper
evo[835], evo[836] = evo.yamper, evo.yamper

evo.rolycoly = {
	ndex = 837,
	name = 'rolycoly',

	evos = {
		{
			ndex = 838,
			name = 'carkol',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 839,
					name = 'coalossal',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				}
			}
		},
	}
}
evo.carkol, evo.coalossal = evo.rolycoly, evo.rolycoly
evo[837], evo[838], evo[839] = evo.rolycoly, evo.rolycoly, evo.rolycoly

evo.applin = {
	ndex = 840,
	name = 'applin',

	evos = {
		{
			ndex = 841,
			name = 'flapple',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Aspropomo',
		},
		{
			ndex = 842,
			name = 'appletun',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Dolcepomo',
		}
	}
}
evo.flapple, evo.appletun = evo.applin, evo.applin
evo[840], evo[841], evo[842] = evo.applin, evo.applin, evo.applin

evo.silicobra = {
	ndex = 843,
	name = 'silicobra',

	evos = {
		{
			ndex = 844,
			name = 'sandaconda',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.sandaconda = evo.silicobra
evo[843], evo[844] = evo.silicobra, evo.silicobra

evo.cramorant = { ndex = 845, name = 'cramorant' }
evo[845] = evo.cramorant

evo.arrokuda = {
	ndex = 846,
	name = 'arrokuda',

	evos = {
		{
			ndex = 847,
			name = 'barraskewda',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.barraskewda = evo.arrokuda
evo[846], evo[847] = evo.arrokuda, evo.arrokuda

evo.toxel = {
	ndex = 848,
	name = 'toxel',
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 849,
			name = 'toxtricity',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[natura]]' }
		},
		{
			ndex = '849B',
			name = 'toxtricityB',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[natura]]' }
		},
	}
}
evo.toxtricity, evo.toxtricityB = evo.toxel, evo.toxel
evo[848], evo[849], evo['849B'] = evo.toxel, evo.toxel, evo.toxel

evo.sizzlipede = {
	ndex = 850,
	name = 'sizzlipede',

	evos = {
		{
			ndex = 851,
			name = 'centiskorch',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		},
	}
}
evo.centiskorch = evo.sizzlipede
evo[850], evo[851] = evo.sizzlipede, evo.sizzlipede

evo.clobbopus = {
	ndex = 852,
	name = 'clobbopus',

	evos = {
		{
			ndex = 853,
			name = 'grapploct',
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Provocazione' }
		},
	}
}
evo.grapploct = evo.clobbopus
evo[852], evo[853] = evo.clobbopus, evo.clobbopus

evo.sinistea = {
	ndex = 854,
	name = 'sinistea',
	notes = useless.sinistea.names.base,

	evos = {
		{
			ndex = 855,
			name = 'polteageist',
			notes = useless.polteageist.names.base,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Teiera rotta'
		}
	}
}
evo.polteageist = evo.sinistea
evo[854], evo[855] = evo.sinistea, evo.sinistea

evo.hatenna = {
	ndex = 856,
	name = 'hatenna',

	evos = {
		{
			ndex = 857,
			name = 'hattrem',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 858,
					name = 'hatterene',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 42
				}
			}
		}
	}
}
evo.hattrem, evo.hatterene = evo.hatenna, evo.hatenna
evo[856], evo[857], evo[858] = evo.hatenna, evo.hatenna, evo.hatenna

evo.impidimp = {
	ndex = 859,
	name = 'impidimp',

	evos = {
		{
			ndex = 860,
			name = 'morgrem',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 861,
					name = 'grimmsnarl',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 42
				}
			}
		}
	}
}
evo.morgrem, evo.grimmsnarl = evo.impidimp, evo.impidimp
evo[859], evo[860], evo[861] = evo.impidimp, evo.impidimp, evo.impidimp

evo.milcery = {
	ndex = 868,
	name = 'milcery',

	evos = {
		{
			ndex = 869,
			name = 'alcremie',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = table.concat{
				"<div>",
				links.bag("Bonbonfragola"),
				links.bag("Bonboncuore"),
				links.bag("Bonbonbosco"),
				links.bag("Bonbonfoglio"),
				links.bag("Bonbonfiore"),
				links.bag("Bonbonstella"),
				links.bag("Bonbonfiocco"),
				"</div>Facendo una piroetta mentre tiene un [[Bonbon]]",
			},
		}
	}
}
evo.alcremie = evo.milcery
evo[868], evo[869] = evo.milcery, evo.milcery

evo.falinks = { ndex = 870, name = 'falinks' }
evo[870] = evo.falinks

evo.pincurchin = { ndex = 871, name = 'pincurchin' }
evo[871] = evo.pincurchin

evo.snom = {
	ndex = 872,
	name = 'snom',

	evos = {
		{
			ndex = 873,
			name = 'frosmoth',
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' },
		}
	}
}
evo.frosmoth = evo.snom
evo[872], evo[873] = evo.snom, evo.snom

evo.stonjourner = { ndex = 874, name = 'stonjourner' }
evo[874] = evo.stonjourner

evo.eiscue = { ndex = 875, name = 'eiscue' }
evo[875] = evo.eiscue

evo.indeedee = { ndex = 876, name = 'indeedee' }
evo[876] = evo.indeedee

evo.indeedeeF = { ndex = '876F', name = 'indeedeeF' }
evo['876F'] = evo.indeedeeF

evo.morpeko = { ndex = 877, name = 'morpeko' }
evo[877] = evo.morpeko

evo.cufant = {
	ndex = 878,
	name = 'cufant',

	evos = {
		{
			ndex = 879,
			name = 'copperajah',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.copperajah = evo.cufant
evo[878], evo[879] = evo.cufant, evo.cufant

evo.dracozolt = { ndex = 880, name = 'dracozolt' }
evo[880] = evo.dracozolt

evo.arctozolt = { ndex = 881, name = 'arctozolt' }
evo[881] = evo.arctozolt

evo.dracovish = { ndex = 882, name = 'dracovish' }
evo[882] = evo.dracovish

evo.arctovish = { ndex = 883, name = 'arctovish' }
evo[883] = evo.arctovish

evo.duraludon = { ndex = 884, name = 'duraludon' }
evo[884] = evo.duraludon

evo.dreepy = {
	ndex = 885,
	name = 'dreepy',

	evos = {
		{
			ndex = 886,
			name = 'drakloak',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 50,

			evos = {
				{
					ndex = 887,
					name = 'dragapult',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 60,
				}
			}
		}
	}
}
evo.drakloak, evo.dragapult = evo.dreepy, evo.dreepy
evo[885], evo[886], evo[887] = evo.dreepy, evo.dreepy, evo.dreepy

evo.zacian = { ndex = 888, name = 'zacian' }
evo[888] = evo.zacian

evo.zamazenta = { ndex = 889, name = 'zamazenta' }
evo[889] = evo.zamazenta

evo.eternatus = { ndex = 890, name = 'eternatus' }
evo[890] = evo.eternatus

evo.kubfu = {
	ndex = 891,
	name = 'kubfu',

	evos = {
		{
			ndex = 892,
			name = 'urshifu',
            notes = altforms.urshifu.names.base,

			method = evo.methods.OTHER,
			[evo.methods.OTHER] = "Vedendo il [[Torre Buio|Rotolo del Buio]]",
		},
		{
			ndex = '892P',
			name = 'urshifuP',
            notes = altforms.urshifu.names.P,

			method = evo.methods.OTHER,
			[evo.methods.OTHER] = "Vedendo il [[Torre Acqua|Rotolo dell'Acqua]]",
		},
	}
}
evo.urshifu, evo.urshifuP = evo.kubfu, evo.kubfu
evo[891], evo[892], evo['892P'] = evo.kubfu, evo.kubfu, evo.kubfu

evo.zarude =  { ndex = 893, name = 'zarude' }
evo[893] = evo.zarude

evo.regieleki =  { ndex = 894, name = 'regieleki' }
evo[894] = evo.regieleki

evo.regidrago =  { ndex = 895, name = 'regidrago' }
evo[895] = evo.regidrago

evo.glastrier =  { ndex = 896, name = 'glastrier' }
evo[896] = evo.glastrier

evo.spectrier =  { ndex = 897, name = 'spectrier' }
evo[897] = evo.spectrier

evo.calyrex =  { ndex = 898, name = 'calyrex' }
evo[898] = evo.calyrex

evo.enamorus =  { ndex = 905, name = 'enamorus' }
evo[905] = evo.enamorus

-- Alternative forms with evolutions
evo.rattataA = {
	ndex = '019A',
	name = 'rattataA',
	notes = altforms.rattata.names.A,

	evos = {
		{
			ndex = '020A',
			name = 'raticateA',
			notes = altforms.raticate.names.A,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.TIME] = 'Notte' },
		}
	}
}
evo.raticateA = evo.rattataA
evo['019A'], evo['020A'] = evo.rattataA, evo.rattataA

evo.sandshrewA = {
	ndex = '027A',
	name = 'sandshrewA',
	notes = altforms.sandshrew.names.A,

	evos = {
		{
			ndex = '028A',
			name = 'sandslashA',
			notes = altforms.sandslash.names.A,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
		}
	}
}
evo.sandslashA = evo.sandshrewA
evo['027A'], evo['028A'] = evo.sandshrewA, evo.sandshrewA

evo.vulpixA = {
	ndex = '037A',
	name = 'vulpixA',
	notes = altforms.vulpix.names.A,

	evos = {
		{
			ndex = '038A',
			name = 'ninetalesA',
			notes = altforms.ninetales.names.A,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
		}
	}
}
evo.ninetalesA = evo.vulpixA
evo['037A'], evo['038A'] = evo.vulpixA, evo.vulpixA

evo.diglettA = {
	ndex = '050A',
	name = 'diglettA',
	notes = altforms.diglett.names.A,

	evos = {
		{
			ndex = '051A',
			name = 'dugtrioA',
			notes = altforms.dugtrio.names.A,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.dugtrioA = evo.diglettA
evo['050A'], evo['051A'] = evo.diglettA, evo.diglettA

evo.meowthA = {
	ndex = '052A',
	name = 'meowthA',
	notes = altforms.meowth.names.A,

	evos = {
		{
			ndex = '053A',
			name = 'persianA',
			notes = altforms.persian.names.A,
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.persianA = evo.meowthA
evo['052A'], evo['053A'] = evo.meowthA, evo.meowthA

evo.meowthG = {
	ndex = '052G',
	name = 'meowthG',
	notes = altforms.meowth.names.G,

	evos = {
		{
			ndex = 863,
			name = 'perrserker',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.perrserker = evo.meowthG
evo['052G'], evo[863] = evo.meowthG, evo.meowthG

evo.growlitheH = {
	ndex = '058H',
	name = 'growlitheH',

	evos = {
		{
			ndex = '059H',
			name = 'arcanineH',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.arcanineH = evo.growlitheH
evo['058H'], evo['059H'] = evo.growlitheH, evo.growlitheH

evo.geodudeA = {
	ndex = '074A',
	name = 'geodudeA',
	notes = altforms.geodude.names.A,

	evos = {
		{
			ndex = '075A',
			name = 'gravelerA',
			notes = altforms.graveler.names.A,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = '076A',
					name = 'golemA',
					notes = altforms.golem.names.A,
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.gravelerA, evo.golemA = evo.geodudeA, evo.geodudeA
evo['074A'], evo['075A'], evo['076A'] = evo.geodudeA, evo.geodudeA, evo.geodudeA

evo.ponytaG = {
	ndex = '077G',
	name = 'ponytaG',
	notes = altforms.ponyta.names.G,

	evos = {
		{
			ndex = '078G',
			name = 'rapidashG',
			notes = altforms.rapidash.names.G,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.rapidashG = evo.ponytaG
evo['077G'], evo['078G'] = evo.ponytaG, evo.ponytaG

evo.slowpokeG = {
	ndex = '079G',
	name = 'slowpokeG',

	evos = {
		{
			ndex = '080G',
			name = 'slowbroG',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Fascia Galarnoce',

		},
		{
			ndex = '199G',
			name = 'slowkingG',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Corona Galarnoce',
		}
	}
}
evo.slowbroG, evo.slowkingG = evo.slowpokeG, evo.slowpokeG
evo['079G'], evo['080G'], evo['199G'] = evo.slowpokeG, evo.slowpokeG, evo.slowpokeG

evo["farfetch'dG"] = {
	ndex = '083G',
	name = "farfetch'dG",
	notes = altforms["farfetch'd"].names.G,

	evos = {
		{
			ndex = 865,
			name = "sirfetch'd",
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = '<span class="text-small">Ottenendo tre [[brutto colpo|brutti colpi]] nella stessa lotta</span>',
		}
	}
}
evo["sirfetch'd"] = evo["farfetch'dG"]
evo['083G'], evo[865] = evo["farfetch'dG"], evo["farfetch'dG"]

evo.grimerA = {
	ndex = '088A',
	name = 'grimerA',
	notes = altforms.grimer.names.A,

	evos = {
		{
			ndex = '089A',
			name = 'mukA',
			notes = altforms.muk.names.A,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.mukA = evo.grimerA
evo['088A'], evo['089A'] = evo.grimerA, evo.grimerA

evo.voltorbH = {
	ndex = '100H',
	name = 'voltorbH',

	evos = {
		{
			ndex = '101H',
			name = 'electrodeH',
			method = evo.methods.STONE,
			[evo.methods.STONE] = "Pietrafoglia",
		}
	}
}
evo.electrodeH = evo.voltorbH
evo['100H'], evo['101H'] = evo.voltorbH, evo.voltorbH

evo.qwilfishH = {
	ndex = '211H',
	name = 'qwilfishH',
	notes = altforms.qwilfish.names.H,

	evos = {
		{
			ndex = 904,
			name = 'overqwil',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = "Usando [[Mille Fielespine]] 20 volte come [[Tecnica potente]]",
		}
	}
}
evo.overqwil = evo.qwilfishH
evo['211H'], evo[904] = evo.qwilfishH, evo.qwilfishH

evo.sneaselH = {
	ndex = '215H',
	name = 'sneaselH',
	notes = altforms.sneasel.names.H,

	evos = {
		{
			ndex = 903,
			name = 'sneasler',
			method = evo.methods.STONE,
			[evo.methods.STONE] = "Affilartigli",
			conditions = { [evo.conditions.TIME] = 'Giorno' }
		}
	}
}
evo.sneasler = evo.sneaselH
evo['215H'], evo[903] = evo.sneaselH, evo.sneaselH

evo.corsolaG = {
	ndex = '222G',
	name = 'corsolaG',
	notes = altforms.corsola.names.G,

	evos = {
		{
			ndex = 864,
			name = 'cursola',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.cursola = evo.corsolaG
evo['222G'], evo[864] = evo.corsolaG, evo.corsolaG

evo.zigzagoonG = {
	ndex = '263G',
	name = 'zigzagoonG',
	notes = altforms.zigzagoon.names.G,

	evos = {
		{
			ndex = '264G',
			name = 'linooneG',
			notes = altforms.linoone.names.G,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 862,
					name = 'obstagoon',
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 35,
					conditions = { [evo.conditions.TIME] = 'Notte' },
				}
			}
		}
	}
}
evo.linooneG, evo.obstagoon = evo.zigzagoonG, evo.zigzagoonG
evo['263G'], evo['264G'], evo[862] = evo.zigzagoonG, evo.zigzagoonG, evo.zigzagoonG

evo.basculinBi = {
	ndex = '550Bi',
	name = 'basculinBi',
	notes = altforms.basculin.names.Bi,

	evos = {
		{
			ndex = 902,
			name = 'basculegion',
			notes = altforms.basculegion.names.base,
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = [=[<span class="text-small">Avendo subito almeno 294 PS di danni da [[contraccolpo]]</span>]=],
			conditions = { [evo.conditions.GENDER] = 'Maschio' }
		},
		{
			ndex = '902F',
			name = 'basculegionF',
			notes = altforms.basculegion.names.F,
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = [=[<span class="text-small">Avendo subito almeno 294 PS di danni da [[contraccolpo]]</span>]=],
			conditions = { [evo.conditions.GENDER] = 'Femmina' }
		},
	}
}
evo.basculegion, evo.basculegionF = evo.basculinBi, evo.basculinBi
evo['550Bi'], evo[902], evo['902F'] = evo.basculinBi, evo.basculinBi, evo.basculinBi

evo.darumakaG = {
	ndex = '554G',
	name = 'darumakaG',
	notes = altforms.darumaka.names.G,

	evos = {
		{
			ndex = '555G',
			name = 'darmanitanG',
			notes = altforms.darmanitan.names.G,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
		}
	}
}
evo.darmanitanG = evo.darumakaG
evo['554G'], evo['555G'] = evo.darumakaG, evo.darumakaG

evo.yamaskG = {
	ndex = '562G',
	name = 'yamaskG',
	notes = altforms.yamask.names.G,

	evos = {
		{
			ndex = 867,
			name = 'runerigus',
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = [=[
<span class="text-small"><div>Avendo subito almeno 49PS di danni,</div>
<div>passare sotto l'arco di pietra nella [[Conca delle Sabbie]]</div></span>]=],
		}
	}
}
evo.runerigus = evo.yamaskG
evo['562G'], evo[867] = evo.yamaskG, evo.yamaskG

evo.zoruaH = {
	ndex = '570H',
	name = 'zoruaH',

	evos = {
		{
			ndex = '571H',
			name = 'zoroarkH',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
			conditions = { [evo.conditions.REGION] = 'Hisui' },
		}
	}
}
evo.zoroarkH = evo.zoruaH
evo['570H'], evo['571H'] = evo.zoruaH, evo.zoruaH

--[[

Given a Pokémon's tree builds versions for its alternative forms and binds them
with the expected names. Tables are created only for the Pokémon and it's
evolutions, not for it's preevo (actually it takes ndexes from it's traversal
of the tree).

If a node doesn't have the "notes" field it's kept as is, without adding
neither notes nor adding the abbr to the ndex.

--]]
local createAlternativeForm = function(altdata, basetab)
	-- Internal tree map function
	local function mapTree(evotab, func)
		local result = func(mw.clone(evotab))
		if evotab.evos then
			result.evos = table.map(result.evos, function(v)
				return mapTree(v, func)
			end)
		end
		return result
	end

	table.map(altdata.names, function(name, abbr)
		local ndexes = {}
		if abbr == "base" then
			return
		end
		local newtab = mapTree(basetab, function(basenode)
			if basenode.notes then
				table.insert(ndexes, basenode.ndex)
				basenode.ndex = string.tf(basenode.ndex) .. abbr
				basenode.name = tostring(basenode.name) .. abbr
				basenode.notes = name
			end
			return basenode
		end)

		table.map(ndexes, function(ndex)
			evo[string.tf(ndex) .. abbr] = newtab
			evo[pokes[ndex].name:lower() .. abbr] = newtab
		end)
	end)
end

evo.unown = { ndex = 201, name = 'unown' }
evo[201] = evo.unown

evo.basculinB = { ndex = '550B', name = 'basculinB', notes = altforms.basculin.names.B }
evo['550B'] = evo.basculinB

evo.meowsticF = {
	ndex = 677,
	name = 'espurr',

	evos = {
		{
			ndex = "678F",
			name = 'meowsticF',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo["678F"] = evo.meowsticF

evo.sinisteaA = {
	ndex = '854A',
	name = 'sinisteaA',
	notes = useless.sinistea.names["A"],

	evos = {
		{
			ndex = '855A',
			name = 'polteageistA',
			notes = useless.polteageist.names["A"],
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Teiera crepata'
		}
	}
}
evo.polteageistA = evo.sinisteaA
evo['854A'], evo['855A'] = evo.sinisteaA, evo.sinisteaA

createAlternativeForm(useless.burmy, evo.burmy)

createAlternativeForm(useless.shellos, evo.shellos)

createAlternativeForm(altforms.pumpkaboo, evo.pumpkaboo)

createAlternativeForm(useless.deerling, evo.deerling)

createAlternativeForm(useless.frillish, evo.frillish)

createAlternativeForm(useless.floette, evo.floette)

-- Alternative forms without evolutions, here just to avoid burst of the module
-- when indexing them
--[[

Simple function that creates empty tables for all alternative forms but base

--]]
local emptyAlternativeForms = function(altdata, name)
	local ndex = pokes[name].ndex
	table.map(altdata.names, function(_, abbr)
		if abbr == "base" then
			return
		end
		-- Avoid to overwrite an existing table
		if evo[name .. abbr] then
			return
		end
		evo[name .. abbr] = {
			ndex = ndex and (string.tf(ndex) .. abbr) or nil,
			name = name .. abbr
		}
		if ndex then
			evo[string.tf(ndex) .. abbr] = evo[name .. abbr]
		end
	end)
end

-- Given that emptyAlternativeForms can't overwrite an existing table, simply
-- maps over altforms and useless
local nopokes = { 'mega', 'megaxy', 'archeo', 'alola', 'galar', 'gigamax',
				  'hisui', 'paldea' }
for k, v in pairs(altforms) do
	if type(k) == 'string' and not table.search(nopokes, k) then
		emptyAlternativeForms(v, k)
	end
end
for k, v in pairs(useless) do
	if type(k) == 'string' and not table.search(nopokes, k) then
		emptyAlternativeForms(v, k)
	end
end

--[[

Data for Pokémon that can change alternative form: in a subtable to split
them from evolutions.

For each Pokémon there's an array, whose elements are arrays themselves
containing forms that should be put at that stage in the evobox. Anyway,
any form is supposed to be able to change to any other form listed here.

--]]
evo.forms = {}
-- Local variable to avoid to write evo.forms
local efs = evo.forms

--[[
Methods:
	- OTHER: just print the value of [evo.forms.methods.OTHER].
	- NONE: doesn't print anything.
	- ITEM: [evo.forms.methods.ITEM] should contain the name of the item.
--]]
efs.methods = {}
efs.methods.OTHER = 0
efs.methods.NONE = 1
efs.methods.ITEM = 2

efs.castform = {
	{ { ndex = 351, name = 'castform' } },
	{ {
		ndex = '351S',
		name = 'castformS',
		notes = 'Sotto il [[Luce solare intensa|sole]]',
		method = efs.methods.NONE,
	} },
	{ {
		ndex = '351P',
		name = 'castformP',
		notes = 'Sotto la [[Pioggia battente|pioggia]]',
		method = efs.methods.NONE,
	} },
	{ {
		ndex = '351N',
		name = 'castformN',
		notes = 'Sotto la [[Grandine (condizione atmosferica)|grandine]]',
		method = efs.methods.NONE,
	} },
}
efs.castformS, efs.castformP, efs.castformN =
	efs.castform, efs.castform, efs.castform
efs[351], efs['351S'], efs['351P'], efs['351N'] =
	efs.castform, efs.castform, efs.castform, efs.castform

efs.deoxys = {
	{ { ndex = 386, name = 'deoxys' } },
	{ { ndex = '386A', name = 'deoxysA', method = efs.methods.NONE } },
	{ { ndex = '386D', name = 'deoxysD', method = efs.methods.NONE } },
	{ { ndex = '386V', name = 'deoxysV', method = efs.methods.NONE } },
}
efs.deoxysA, efs.deoxysD, efs.deoxysV =
	efs.deoxys, efs.deoxys, efs.deoxys
efs[386], efs['386A'], efs['386D'], efs['386V'] =
	efs.deoxys, efs.deoxys, efs.deoxys, efs.deoxys

efs.rotom = {
	{ { ndex = 479, name = 'rotom' } },
	{ { ndex = '479C', name = 'rotomC', method = efs.methods.NONE } },
	{ { ndex = '479L', name = 'rotomL', method = efs.methods.NONE } },
	{ { ndex = '479G', name = 'rotomG', method = efs.methods.NONE } },
	{ { ndex = '479V', name = 'rotomV', method = efs.methods.NONE } },
	{ { ndex = '479T', name = 'rotomT', method = efs.methods.NONE } },
}
efs.rotomC, efs.rotomL, efs.rotomG, efs.rotomV, efs.rotomT =
	efs.rotom, efs.rotom, efs.rotom, efs.rotom, efs.rotom
efs[479], efs['479C'], efs['479L'], efs['479G'], efs['479V'], efs['479T'] =
	efs.rotom, efs.rotom, efs.rotom, efs.rotom, efs.rotom, efs.rotom

efs.giratina = {
	{ {
		ndex = 487,
		name = 'giratina',
		notes = '[[Mondo Distorto]]<br>oppure<br>tenendo la Grigiosfera',
	} },
	{ {
		ndex = '487O',
		name = 'giratinaO',
		notes = '[[Mondo Pokémon]],<br>senza tenere la Grigiosfera',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Grigiosfera',
	} },
}
efs.giratinaO = efs.giratina
efs[487], efs['487O'] = efs.giratina, efs.giratina

efs.shaymin = {
	{ {
		ndex = 492,
		name = 'shaymin',
		notes = 'Di notte e nel PC',
	} },
	{ {
		ndex = '492C',
		name = 'shayminC',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Gracidea',
	} },
}
efs.shayminC = efs.shaymin
efs[492], efs['492C'] = efs.shaymin, efs.shaymin

-- No notes because right now it isn't used to build evobox
efs.arceus = {
	{ { ndex = 493, name = 'arceus' } },
	{ { ndex = '493L', name = 'arceusL', method = efs.methods.NONE } },
	{ { ndex = '493Vo', name = 'arceusVo', method = efs.methods.NONE } },
	{ { ndex = '493Ve', name = 'arceusVe', method = efs.methods.NONE } },
	{ { ndex = '493T', name = 'arceusT', method = efs.methods.NONE } },
	{ { ndex = '493R', name = 'arceusR', method = efs.methods.NONE } },
	{ { ndex = '493C', name = 'arceusC', method = efs.methods.NONE } },
	{ { ndex = '493S', name = 'arceusS', method = efs.methods.NONE } },
	{ { ndex = '493Ai', name = 'arceusAi', method = efs.methods.NONE } },
	{ { ndex = '493Fu', name = 'arceusFu', method = efs.methods.NONE } },
	{ { ndex = '493Aq', name = 'arceusAq', method = efs.methods.NONE } },
	{ { ndex = '493Er', name = 'arceusEr', method = efs.methods.NONE } },
	{ { ndex = '493El', name = 'arceusEl', method = efs.methods.NONE } },
	{ { ndex = '493P', name = 'arceusP', method = efs.methods.NONE } },
	{ { ndex = '493G', name = 'arceusG', method = efs.methods.NONE } },
	{ { ndex = '493D', name = 'arceusD', method = efs.methods.NONE } },
	{ { ndex = '493B', name = 'arceusB', method = efs.methods.NONE } },
	{ { ndex = '493Fo', name = 'arceusFo', method = efs.methods.NONE } },
}
efs[493] = efs.arceus

efs.darmanitan = {
	{ { ndex = 555, name = 'darmanitan' } },
	{ { ndex = '555Z', name = 'darmanitanZ', method = efs.methods.NONE } },
}
efs.darmanitanZ = efs.darmanitan
efs[555], efs['555Z'] = efs.darmanitan, efs.darmanitan

efs.darmanitanG = {
	{ { ndex = '555G', name = 'darmanitanG' } },
	{ { ndex = '555GZ', name = 'darmanitanGZ', method = efs.methods.NONE } },
}
efs.darmanitanGZ = efs.darmanitanG
efs['555G'], efs['555GZ'] = efs.darmanitanG, efs.darmanitanG

efs.tornadus = {
	{ { ndex = 641, name = 'tornadus' } },
	{ {
		ndex = '641T',
		name = 'tornadusT',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Verispecchio',
	} },
}
efs.tornadusT = efs.tornadus
efs[641], efs['641T'] = efs.tornadus, efs.tornadus

efs.thundurus = {
	{ { ndex = 642, name = 'thundurus' } },
	{ {
		ndex = '642T',
		name = 'thundurusT',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Verispecchio',
	} },
}
efs.thundurusT = efs.thundurus
efs[642], efs['642T'] = efs.thundurus, efs.thundurus

efs.landorus = {
	{ { ndex = 645, name = 'landorus' } },
	{ {
		ndex = '645T',
		name = 'landorusT',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Verispecchio',
	} },
}
efs.landorusT = efs.landorus
efs[645], efs['645T'] = efs.landorus, efs.landorus

efs.kyurem = {
	{ { ndex = '646N', name = 'kyuremN', notes = ms.staticLua{644} .. ' con [[Zekrom]]' } },
	{ {
		ndex = 664,
		name = 'kyurem',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Cuneo DNA',
	} },
	{ {
		ndex = '646B',
		name = 'kyuremB',
		notes = ms.staticLua{643} .. ' con [[Reshiram]]',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Cuneo DNA',
	} },
}
efs.kyuremB, efs.kyuremN = efs.kyurem, efs.kyurem
efs[664], efs['646B'], efs['646N'] = efs.kyurem, efs.kyurem, efs.kyurem

efs.meloetta = {
	{ { ndex = 648, name = 'meloetta' } },
	{ {
		ndex = '648D',
		name = 'meloettaD',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = links.bag('MT Normale') .. '<br>Usando [[Cantoantico]]',
	} },
}
efs.meloettaD = efs.meloetta
efs[648], efs['648D'] = efs.meloetta, efs.meloetta

efs.greninja = {
	{ { ndex = 658, name = 'greninja' } },
	{ {
		ndex = '658A',
		name = 'greninjaA',
		notes = 'Dopo aver mandato KO un Pokémon',
		method = efs.methods.NONE,
	} },
}
efs.greninjaA = efs.greninja
efs[658], efs['658A'] = efs.greninja, efs.greninja

efs.aegislash = {
	{ {
		ndex = 681,
		name = 'aegislash',
		notes = 'Usando [[Scudo Reale]]',
	} },
	{ {
		ndex = '681S',
		name = 'aegislashS',
		notes = 'Usando una mossa non di [[stato]]',
		method = efs.methods.NONE,
	} },
}
efs.aegislashS = efs.aegislash
efs[681], efs['681S'] = efs.aegislash, efs.aegislash

efs.zygarde = {
	{ { ndex = '718D', name = 'zygardeD' } },
	{ {
		ndex = 718,
		name = 'zygarde',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Teca Zygarde',
	} },
	{ {
		ndex = '718P',
		name = 'zygardeP',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Teca Zygarde',
	} },
}
efs.zygardeD, efs.zygardeP = efs.zygarde, efs.zygarde
efs[718], efs['718D'], efs['718P'] = efs.zygarde, efs.zygarde, efs.zygarde

efs.hoopa = {
	{ { ndex = 720, name = 'hoopa', notes = 'Dopo tre giorni o se depositato nel box' } },
	{ {
		ndex = '720L',
		name = 'hoopaL',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Vaso del vincolo',
	} },
}
efs.hoopaL = efs.hoopa
efs[720], efs['720L'] = efs.hoopa, efs.hoopa

efs.oricorio = {
	{ {
		ndex = '741C', name = 'oricorioC',
		notes = links.bag('Nettare Giallo') .. '[[Nettare Giallo]]',
	} },
	{ {
		ndex = '741H', name = 'oricorioH', method = efs.methods.NONE,
		notes = links.bag('Nettare Rosa') .. '[[Nettare Rosa]]',
	} },
	{ {
		ndex = 741, name = 'oricorio', method = efs.methods.NONE,
		notes = links.bag('Nettare Rosso') .. '[[Nettare Rosso]]',
	} },
	{ {
		ndex = '741B', name = 'oricorioB', method = efs.methods.NONE,
		notes = links.bag('Nettare Viola') .. '[[Nettare Viola]]',
	} },
}
efs.oricorioC, efs.oricorioH, efs.oricorioB =
	efs.oricorio, efs.oricorio, efs.oricorio
efs[741], efs['741C'], efs['741H'], efs['741B'] =
	efs.oricorio, efs.oricorio, efs.oricorio, efs.oricorio

efs.wishiwashi = {
	{ { ndex = 746, name = 'wishiwashi' } },
	{ {
		ndex = '746B',
		name = 'wishiwashiB',
		notes = 'Con più di un quarto dei PS a partire dal livello 20',
		method = efs.methods.NONE,
	} },
}
efs.wishiwashiB = efs.wishiwashi
efs[746], efs['746B'] = efs.wishiwashi, efs.wishiwashi

efs.silvally = {
	{ { ndex = 773, name = 'silvally' } },
	{ { ndex = '773L', name = 'silvallyL', method = efs.methods.NONE } },
	{ { ndex = '773Vo', name = 'silvallyVo', method = efs.methods.NONE } },
	{ { ndex = '773Ve', name = 'silvallyVe', method = efs.methods.NONE } },
	{ { ndex = '773T', name = 'silvallyT', method = efs.methods.NONE } },
	{ { ndex = '773R', name = 'silvallyR', method = efs.methods.NONE } },
	{ { ndex = '773C', name = 'silvallyC', method = efs.methods.NONE } },
	{ { ndex = '773S', name = 'silvallyS', method = efs.methods.NONE } },
	{ { ndex = '773Ai', name = 'silvallyAi', method = efs.methods.NONE } },
	{ { ndex = '773Fu', name = 'silvallyFu', method = efs.methods.NONE } },
	{ { ndex = '773Aq', name = 'silvallyAq', method = efs.methods.NONE } },
	{ { ndex = '773Er', name = 'silvallyEr', method = efs.methods.NONE } },
	{ { ndex = '773El', name = 'silvallyEl', method = efs.methods.NONE } },
	{ { ndex = '773P', name = 'silvallyP', method = efs.methods.NONE } },
	{ { ndex = '773G', name = 'silvallyG', method = efs.methods.NONE } },
	{ { ndex = '773D', name = 'silvallyD', method = efs.methods.NONE } },
	{ { ndex = '773B', name = 'silvallyB', method = efs.methods.NONE } },
	{ { ndex = '773Fo', name = 'silvallyFo', method = efs.methods.NONE } },
}

efs.minior = {
	{ { ndex = 774, name = 'minior' } },
	{ {
		ndex = '774R',
		name = 'miniorR',
		notes = 'Con meno di metà dei PS',
		method = efs.methods.NONE,
	} },
}
efs.miniorR = efs.minior
efs[774], efs['774R'] = efs.minior, efs.minior

efs.necrozma = {
	{ { ndex = 800, name = 'necrozma' } },
	{
		{
			ndex = '800V',
			name = 'necrozmaV',
			notes = ms.staticLua{791} .. ' con [[Solgaleo]]',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Necrosolix',
		},
		{
			ndex = '800A',
			name = 'necrozmaA',
			notes = ms.staticLua{792} .. ' con [[Lunala]]',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Necrolunix',
		},
	},
	{ {
		ndex = '800U',
		name = 'necrozmaU',
		method = efs.methods.ITEM,
		[efs.methods.ITEM] = 'Ultranecrozium Z',
	} },
}
efs.necrozmaV, efs.necrozmaA, efs.necrozmaU =
	efs.necrozma, efs.necrozma, efs.necrozma
efs[800], efs['800V'], efs['800A'], efs['800U'] =
	efs.necrozma, efs.necrozma, efs.necrozma, efs.necrozma

efs.cramorant = {
	{ { ndex = 845, name = 'cramorant' } },
	{ {
		ndex = '845T',
		name = 'cramorantT',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
	{ {
		ndex = '845I',
		name = 'cramorantI',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
}
efs.cramorantT, efs.cramorantI = efs.cramorant, efs.cramorant
efs[845], efs['845T'], efs['845I'] = efs.cramorant, efs.cramorant, efs.cramorant

efs.eiscue = {
	{ { ndex = 875, name = 'eiscue' } },
	{ {
		ndex = '875L',
		name = 'eiscueL',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
}
efs.eiscueL = efs.eiscue
efs[875], efs['875L'] = efs.eiscue, efs.eiscue

efs.morpeko = {
	{ { ndex = 877, name = 'morpeko' } },
	{ {
		ndex = '877V',
		name = 'morpekoV',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "Cambia forma ogni turno<br>per l'abilità [[Pancialterna]]",
	} },
}
efs.morpekoV = efs.morpeko
efs[877], efs['877V'] = efs.morpeko, efs.morpeko

efs.zacian = {
	{ { ndex = 888, name = 'zacian' } },
	{ {
		ndex = '888R',
		name = 'zacianR',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
}
efs.zacianR = efs.zacian
efs[888], efs['888R'] = efs.zacian, efs.zacian

efs.zamazenta = {
	{ { ndex = 888, name = 'zamazenta' } },
	{ {
		ndex = '889R',
		name = 'zamazentaR',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
}
efs.zamazentaR = efs.zamazenta
efs[889], efs['889R'] = efs.zamazenta, efs.zamazenta

efs.eternatus = {
	{ { ndex = 890, name = 'eternatus' } },
	{ {
		ndex = '890D',
		name = 'eternatusD',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = "N/D",
	} },
}
efs.eternatusD = efs.eternatus
efs[890], efs['890D'] = efs.eternatus, efs.eternatus

efs.enamorus = {
	{ { ndex = 905, name = 'enamorus' } },
	{ {
		ndex = '905T',
		name = 'enamorusT',
		method = efs.methods.UNKNOWN,
		-- [efs.methods.ITEM] = 'Verispecchio',
	} },
}
efs.enamorusT = efs.enamorus
efs[905], efs['905T'] = efs.enamorus, efs.enamorus

efs.burmy = {
	{ {
		ndex = 412, name = 'burmy',
		notes = 'Dopo aver lottato in un altro luogo',
	} },
	{ {
		ndex = '412Sc', name = 'burmySc', method = efs.methods.NONE,
		notes = 'Dopo aver lottato in un edificio',
	} },
	{ {
		ndex = '412Sa', name = 'burmySa', method = efs.methods.NONE,
		notes = 'Dopo aver lottato in una grotta o su una spiaggia',
	} },
}
efs.burmySc, efs.Sa = efs.burmy, efs.burmy
efs[412], efs['412Sc'], efs['412Sa'] = efs.burmy, efs.burmy, efs.burmy

efs.cherrim = {
	{ { ndex = 421, name = 'cherrim' } },
	{ {
		ndex = '421S',
		name = 'cherrimS',
		notes = 'Sotto il [[Luce solare intensa|sole]]',
		method = efs.methods.NONE,
	} },
}
efs.cherrimS = efs.cherrim
efs[421], efs['421S'] = efs.cherrim, efs.cherrim

efs.keldeo = {
	{ { ndex = 647, name = 'keldeo' } },
	{ {
		ndex = '647R',
		name = 'keldeoR',
		method = efs.methods.OTHER,
		[efs.methods.OTHER] = links.bag('MT Lotta') .. '<br>Imparando [[Spadamistica]]',
	} },
}
efs.keldeoR = efs.keldeo
efs[647], efs['647R'] = efs.keldeo, efs.keldeo

efs.genesect = {
	{ { ndex = 649, name = 'genesect', } },
	{ {
		ndex = '649I', name = 'genesectI', method = efs.methods.NONE,
		notes = 'Tenendo ' .. links.bag('Idromodulo'),
	} },
	{ {
		ndex = '649V', name = 'genesectV', method = efs.methods.NONE,
		notes = 'Tenendo ' .. links.bag('Voltmodulo'),
	} },
	{ {
		ndex = '649P', name = 'genesectP', method = efs.methods.NONE,
		notes = 'Tenendo ' .. links.bag('Piromodulo'),
	} },
	{ {
		ndex = '649G', name = 'genesectG', method = efs.methods.NONE,
		notes = 'Tenendo ' .. links.bag('Gelomodulo'),
	} },
}
efs.genesectI, efs.genesectV, efs.genesectP, efs.genesectG =
	efs.genesect, efs.genesect, efs.genesect, efs.genesect
efs[649], efs['649I'], efs['649V'], efs['649P'], efs['649G'] =
	efs.oricorio, efs.oricorio, efs.oricorio, efs.oricorio, efs.genesect

efs.xerneas = {
	{ { ndex = 716, name = 'xerneas', notes = 'Fuori dalla lotta' } },
	{ {
		ndex = '716A',
		name = 'xerneasA',
		notes = 'In lotta',
		method = efs.methods.NONE,
	} },
}
efs.xerneasA = efs.xerneas
efs[716], efs['716A'] = efs.xerneas, efs.xerneas

efs.mimikyu = {
	{ { ndex = 778, name = 'mimikyu' } },
	{ {
		ndex = '778S',
		name = 'mimikyuS',
		notes = 'Venendo colpito in lotta',
		method = efs.methods.NONE,
	} },
}
efs.mimikyuS = efs.mimikyu
efs[778], efs['778S'] = efs.mimikyu, efs.mimikyu

efs.charizard = {
	{ { ndex = '006MX', name = 'charizardMX' } },
	{
		{
			ndex = 6,
			name = 'charizard',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Charizardite X',
		}
	},
	{
		{
			ndex = '006MY',
			name = 'charizardMY',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Charizardite Y',
		}
	},
}
efs.charizardMX, efs.charizardMY = efs.charizard, efs.charizard
efs[6], efs['006MX'], efs['006MY'] = efs.charizard, efs.charizard, efs.charizard

efs.mewtwo = {
	{ { ndex = '150MX', name = 'mewtwoMX' } },
	{
		{
			ndex = 150,
			name = 'mewtwo',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Mewtwoite X',
		}
	},
	{
		{
			ndex = '150MY',
			name = 'mewtwoMY',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Mewtwoite Y',
		}
	},
}
efs.mewtwoMX, efs.mewtwoMY = efs.mewtwo, efs.mewtwo
efs[150], efs['150MX'], efs['150MY'] = efs.mewtwo, efs.mewtwo, efs.mewtwo

efs.kyogre = {
	{ { ndex = 382, name = 'kyogre' } },
	{
		{
			ndex = '382A',
			name = 'kyogreA',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Gemma blu',
		}
	},
}
efs.kyogreA = efs.kyogre
efs[382], efs['382A'] = efs.kyogre, efs.kyogre

efs.groudon = {
	{ { ndex = 383, name = 'groudon' } },
	{
		{
			ndex = '383A',
			name = 'groudonA',
			method = efs.methods.ITEM,
			[efs.methods.ITEM] = 'Gemma rossa',
		}
	},
}
efs.groudonA = efs.groudon
efs[383], efs['383A'] = efs.groudon, efs.groudon

efs.rayquaza = {
	{ { ndex = 384, name = 'rayquaza' } },
	{
		{
			ndex = '384M',
			name = 'rayquazaM',
			method = efs.methods.NONE,
		}
	},
}
efs.rayquazaM = efs.rayquaza
efs[384], efs['384M'] = efs.rayquaza, efs.rayquaza

local createMega = function(pkmn, ndex, item)
	efs[pkmn] = {
		{ { ndex = ndex, name = pkmn } },
		{
			{
				ndex = string.tf(ndex) .. 'M',
				name = pkmn .. 'M',
				method = efs.methods.ITEM,
				[efs.methods.ITEM] = item,
			}
		},
	}
	efs[pkmn .. 'M'] = efs[pkmn]
	efs[ndex], efs[string.tf(ndex) .. 'M'] = efs[pkmn], efs[pkmn]
end

createMega('venusaur', 3, 'Venusaurite')
createMega('blastoise', 9, 'Blastoisite')
createMega('beedrill', 15, 'Beedrillite')
createMega('pidgeot', 18, 'Pidgeotite')
createMega('alakazam', 65, 'Alakazamite')
createMega('slowbro', 80, 'Slowbroite')
createMega('gengar', 94, 'Gengarite')
createMega('kangaskhan', 115, 'Kangaskhanite')
createMega('pinsir', 127, 'Pinsirite')
createMega('gyarados', 130, 'Gyaradosite')
createMega('aerodactyl', 142, 'Aerodactylite')
createMega('ampharos', 181, 'Ampharosite')
createMega('steelix', 208, 'Steelixite')
createMega('scizor', 212, 'Scizorite')
createMega('heracross', 214, 'Heracrossite')
createMega('houndoom', 229, 'Houndoomite')
createMega('tyranitar', 248, 'Tyranitarite')
createMega('sceptile', 254, 'ceptilite')
createMega('blaziken', 257, 'Blazikenite')
createMega('swampert', 260, 'Swampertite')
createMega('gardevoir', 282, 'Gardevoirite')
createMega('sableye', 302, 'Sableyite')
createMega('mawile', 303, 'Mawilite')
createMega('aggron', 306, 'Aggronite')
createMega('medicham', 308, 'Medichamite')
createMega('manectric', 310, 'Manectricite')
createMega('sharpedo', 319, 'Sharpedite')
createMega('camerupt', 323, 'Cameruptite')
createMega('altaria', 334, 'Altarite')
createMega('banette', 354, 'Banettite')
createMega('absol', 359, 'Absolite')
createMega('glalie', 362, 'Glalite')
createMega('salamence', 373, 'Salamencite')
createMega('metagross', 376, 'Metagrossite')
createMega('latias', 380, 'Latiasite')
createMega('latios', 381, 'Latiosite')
createMega('lopunny', 428, 'Lopunnite')
createMega('garchomp', 445, 'Garchompite')
createMega('lucario', 448, 'Lucarite')
createMega('abomasnow', 460, 'Abomasnowite')
createMega('gallade', 475, 'Galladite')
createMega('audino', 531, 'Audinite')
createMega('diancie', 719, 'Diancite')

return evo
