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
local links = require('Links')
local pokes = require("Poké-data")
local altforms = require("AltForms-data")
local useless = require("UselessForms-data")

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

	evos = {
		{
			ndex = 2,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 3,
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

	evos = {
		{
			ndex = 5,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 6,
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

	evos = {
		{
			ndex = 8,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 9,
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

	evos = {
		{
			ndex = 11,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,

			evos = {
				{
					ndex = 12,
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

	evos = {
		{
			ndex = 14,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,

			evos = {
				{
					ndex = 15,
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

	evos = {
		{
			ndex = 17,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 18,
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

	evos = {
		{
			ndex = 20,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.raticate = evo.rattata
evo[19], evo[20] = evo.rattata, evo.rattata

evo.spearow = {
	ndex = 21,

	evos = {
		{
			ndex = 22,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.fearow = evo.spearow
evo[21], evo[22] = evo.spearow, evo.spearow

evo.ekans = {
	ndex = 23,

	evos = {
		{
			ndex = 24,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.arbok = evo.ekans
evo[23], evo[24] = evo.ekans, evo.ekans

evo.pichu = {
	ndex = 172,

	evos = {
		{
			ndex = 25,
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 26,
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietratuono'
				},
				{
					ndex = '026A',
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

	evos = {
		{
			ndex = 28,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.sandslash = evo.sandshrew
evo[27], evo[28] = evo.sandshrew, evo.sandshrew

evo["nidoran♀"] = {
	ndex = 29,

	evos = {
		{
			ndex = 30,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 31,
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

	evos = {
		{
			ndex = 33,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 34,
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
	methods = evo.methods.BREED,

	evos = {
		{
			ndex = 35,
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 36,
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

	evos = {
		{
			ndex = 38,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.ninetales = evo.vulpix
evo[37], evo[38] = evo.vulpix, evo.vulpix

evo.igglybuff = {
	ndex = 174,
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 39,
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 40,
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

	evos = {
		{
			ndex = 42,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,

			evos = {
				{
					ndex = 169,
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

	evos = {
		{
			ndex = 44,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 45,
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietrafoglia'
				},
				{
					ndex = 182,
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

	evos = {
		{
			ndex = 47,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.parasect = evo.paras
evo[46], evo[47] = evo.paras, evo.paras

evo.venonat = {
	ndex = 48,

	evos = {
		{
			ndex = 49,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.venomoth = evo.venonat
evo[48], evo[49] = evo.venonat, evo.venonat

evo.diglett = {
	ndex = 50,

	evos = {
		{
			ndex = 51,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.dugtrio = evo.diglett
evo[50], evo[51] = evo.diglett, evo.diglett

evo.meowth = {
	ndex = 52,

	evos = {
		{
			ndex = 53,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.persian = evo.meowth
evo[52], evo[53] = evo.meowth, evo.meowth

evo.psyduck = {
	ndex = 54,

	evos = {
		{
			ndex = 55,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.golduck = evo.psyduck
evo[54], evo[55] = evo.psyduck, evo.psyduck

evo.mankey = {
	ndex = 56,

	evos = {
		{
			ndex = 57,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.primeape = evo.mankey
evo[56], evo[57] = evo.mankey, evo.mankey

evo.growlithe = {
	ndex = 58,

	evos = {
		{
			ndex = 59,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.arcanine = evo.growlithe
evo[58], evo[59] = evo.growlithe, evo.growlithe

evo.poliwag = {
	ndex = 60,

	evos = {
		{
			ndex = 61,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 62,
					method = evo.methods.STONE,
					[evo.methods.STONE] = 'Pietraidrica'
				},
				{
					ndex = 186,
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

	evos = {
		{
			ndex = 64,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 65,
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.kadabra, evo.alakazam = evo.abra, evo.abra
evo[63], evo[64], evo[65] = evo.abra, evo.abra, evo.abra

evo.machop = {
	ndex = 66,

	evos = {
		{
			ndex = 67,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,

			evos = {
				{
					ndex = 68,
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.machoke, evo.machamp = evo.machop, evo.machop
evo[66], evo[67], evo[68] = evo.machop, evo.machop, evo.machop

evo.bellsprout = {
	ndex = 69,

	evos = {
		{
			ndex = 70,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 71,
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

	evos = {
		{
			ndex = 73,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.tentacruel = evo.tentacool
evo[72], evo[73] = evo.tentacool, evo.tentacool

evo.geodude = {
	ndex = 74,

	evos = {
		{
			ndex = 75,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 76,
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.graveler, evo.golem = evo.geodude, evo.geodude
evo[74], evo[75], evo[76] = evo.geodude, evo.geodude, evo.geodude

evo.ponyta = {
	ndex = 77,

	evos = {
		{
			ndex = 78,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.rapidash = evo.ponyta
evo[77], evo[78] = evo.ponyta, evo.ponyta

evo.slowpoke = {
	ndex = 79,

	evos = {
		{
			ndex = 80,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

		},
		{
			ndex = 199,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Roccia di Re' }
		}
	}
}
evo.slowbro, evo.slowking = evo.slowpoke, evo.slowpoke
evo[79], evo[80], evo[199] = evo.slowpoke, evo.slowpoke, evo.slowpoke

evo.magnemite = {
	ndex = 81,

	evos = {
		{
			ndex = 82,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 462,
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.LOCATION] = 'Campo magnetico speciale' },
				}
			}
		}
	}
}
evo.magneton, evo.magnezone = evo.magnemite, evo.magnemite
evo[81], evo[82], evo[462] = evo.magnemite, evo.magnemite, evo.magnemite

evo["farfetch'd"] = { ndex = 83 }
evo[83] = evo["farfetch'd"]

evo.doduo = {
	ndex = 84,

	evos = {
		{
			ndex = 85,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.dodrio = evo.doduo
evo[84], evo[85] = evo.doduo, evo.doduo

evo.seel = {
	ndex = 86,

	evos = {
		{
			ndex = 87,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.dewgong = evo.seel
evo[86], evo[87] = evo.seel, evo.seel

evo.grimer = {
	ndex = 88,

	evos = {
		{
			ndex = 89,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.muk = evo.grimer
evo[88], evo[89] = evo.grimer, evo.grimer

evo.shellder = {
	ndex = 90,

	evos = {
		{
			ndex = 91,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.cloyster = evo.shellder
evo[90], evo[91] = evo.shellder, evo.shellder

evo.gastly = {
	ndex = 92,

	evos = {
		{
			ndex = 93,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 94,
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.haunter, evo.gengar = evo.gastly, evo.gastly
evo[92], evo[93], evo[94] = evo.gastly, evo.gastly, evo.gastly

evo.onix = {
	ndex = 95,

	evos = {
		{
			ndex = 208,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Metalcoperta' },
		}
	}
}
evo.steelix = evo.onix
evo[95], evo[208] = evo.onix, evo.onix

evo.drowzee = {
	ndex = 96,

	evos = {
		{
			ndex = 97,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.hypno = evo.drowzee
evo[96], evo[97] = evo.drowzee, evo.drowzee

evo.krabby = {
	ndex = 98,

	evos = {
		{
			ndex = 99,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.kingler = evo.krabby
evo[98], evo[99] = evo.krabby, evo.krabby

evo.voltorb = {
	ndex = 100,

	evos = {
		{
			ndex = 101,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.electrode = evo.voltorb
evo[100], evo[101] = evo.voltorb, evo.voltorb

evo.exeggcute = {
	ndex = 102,

	evos = {
		{
			ndex = 103,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
		},
		{
			ndex = '103A',
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

	evos = {
		{
			ndex = 105,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		},
		{
			ndex = '105A',
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
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 106,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.OTHER] = 'Con [[Attacco]] > [[Difesa]]' }
		},
		{
			ndex = 107,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.OTHER] = 'Con [[Attacco]] < [[Difesa]]' }
		},
		{
			ndex = 237,
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

	evos = {
		{
			ndex = 463,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Rotolamento' }
		}
	}
}
evo.lickilicky = evo.lickitung
evo[108], evo[463] = evo.lickitung, evo.lickitung

evo.koffing = {
	ndex = 109,

	evos = {
		{
			ndex = 110,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.weezing = evo.koffing
evo[109], evo[110] = evo.koffing, evo.koffing

evo.rhyhorn = {
	ndex = 111,

	evos = {
		{
			ndex = 112,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,

			evos = {
				{
					ndex = 464,
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Copertura' },
				}
			}
		}
	}
}
evo.rhydon, evo.rhyperior = evo.rhyhorn, evo.rhyhorn
evo[111], evo[112], evo[464] = evo.rhyhorn, evo.rhyhorn, evo.rhyhorn

evo.happiny = {
	ndex = 440,
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Fortunaroma'},

	evos = {
		{
			ndex = 113,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.ITEM] = 'Pietraovale',
			[evo.conditions.TIME] = 'Giorno'},

			evos = {
				{
					ndex = 242,
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

	evos = {
		{
			ndex = 465,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Forzantica' },
		}
	}
}
evo.tangrowth = evo.tangela
evo[114], evo[465] = evo.tangela, evo.tangela

evo.kangaskhan = { ndex = 115 }
evo[115] = evo.kangaskhan

evo.horsea = {
	ndex = 116,

	evos = {
		{
			ndex = 117,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 230,
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

	evos = {
		{
			ndex = 119,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.seaking = evo.goldeen
evo[118], evo[119] = evo.goldeen, evo.goldeen

evo.staryu = {
	ndex = 120,

	evos = {
		{
			ndex = 121,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.starmie = evo.staryu
evo[120], evo[121] = evo.staryu, evo.staryu

evo["mime jr."] = {
	ndex = 439,
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Bizzoaroma' },

	evos = {
		{
			ndex = 122,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Mimica' },
		}
	}
}
evo["mr. mime"] = evo["mime jr."]
evo[439], evo[122] = evo["mime jr."], evo["mime jr."]

evo.scyther = {
	ndex = 123,

	evos = {
		{
			ndex = 212,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Metalcoperta' },
		}
	}
}
evo.scizor = evo.scyther
evo[123], evo[212] = evo.scyther, evo.scyther

evo.smoochum = {
	ndex = 238,
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 124,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.jynx = evo.smoochum
evo[238], evo[124] = evo.smoochum, evo.smoochum

evo.elekid = {
	ndex = 239,
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 125,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 466,
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Elettritore' },
				}
			}
		}
	}
}
evo.electabuzz, evo.electivire = evo.elekid, evo.elekid
evo[239], evo[125], evo[466] = evo.elekid, evo.elekid, evo.elekid

evo.magby = {
	ndex = 240,
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 126,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 467,
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Magmatore' },
				}
			}
		}
	}
}
evo.magmar, evo.magmortar = evo.magby, evo.magby
evo[240], evo[126], evo[467] = evo.magby, evo.magby, evo.magby

evo.pinsir = { ndex = 127 }
evo[127] = evo.pinsir

evo.tauros = { ndex = 128 }
evo[128] = evo.tauros

evo.magikarp = {
	ndex = 129,

	evos = {
		{
			ndex = 130,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.gyarados = evo.magikarp
evo[129], evo[130] = evo.magikarp, evo.magikarp

evo.lapras = { ndex = 131 }
evo[131] = evo.lapras

evo.ditto = { ndex = 132 }
evo[132] = evo.ditto

evo.eevee = {
	ndex = 133,

	evos = {
		{
			ndex = 134,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		},
		{
			ndex = 135,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietratuono',
		},
		{
			ndex = 136,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		},
		{
			ndex = 196,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		},
		{
			ndex = 197,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' },
		},
		{
			ndex = 470,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Roccia Muschio' },
		},
		{
			ndex = 471,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Roccia Ghiaccio' },
		},
		{
			ndex = 700,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.OTHER] = 'Con due cuori di [[Amicizia]]<div>avendo appreso una mossa di tipo [[Folletto]]</div>' },
		}
	}
}
evo.vaporeon, evo.jolteon, evo.flareon, evo.espeon, evo.umbreon, evo.leafeon, evo.glaceon, evo.sylveon =
	evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee
evo[133], evo[134], evo[135], evo[136], evo[196], evo[197], evo[470], evo[471], evo[700] =
	evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee, evo.eevee

evo.porygon = {
	ndex = 137,

	evos = {
		{
			ndex = 233,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Upgrade' },

			evos = {
				{
					ndex = 474,
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Dubbiodisco' },
				}
			}
		}
	}
}
evo.porygon2, evo["porygon-z"] = evo.porygon, evo.porygon
evo[137], evo[233], evo[474] = evo.porygon, evo.porygon, evo.porygon

evo.omanyte = {
	ndex = 138,

	evos = {
		{
			ndex = 139,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.omastar = evo.omanyte
evo[138], evo[139] = evo.omanyte, evo.omanyte

evo.kabuto = {
	ndex = 140,

	evos = {
		{
			ndex = 141,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.kabutops = evo.kabuto
evo[140], evo[141] = evo.kabuto, evo.kabuto

evo.aerodactyl = { ndex = 142 }
evo[142] = evo.aerodactyl

evo.munchlax = {
	ndex = 446,
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Gonfioaroma' },

	evos = {
		{
			ndex = 143,
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.snorlax = evo.munchlax
evo[446], evo[143] = evo.munchlax, evo.munchlax

evo.articuno = { ndex = 144 }
evo[144] = evo.articuno

evo.zapdos = { ndex = 145 }
evo[145] = evo.zapdos

evo.moltres = { ndex = 146 }
evo[146] = evo.moltres

evo.dratini = {
	ndex = 147,

	evos = {
		{
			ndex = 148,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 149,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 55,
				}
			}
		}
	}
}
evo.dragonair, evo.dragonite = evo.dratini, evo.dratini
evo[147], evo[148], evo[149] = evo.dratini, evo.dratini, evo.dratini

evo.mewtwo = { ndex = 150 }
evo[150] = evo.mewtwo

evo.mew = { ndex = 151 }
evo[151] = evo.mew

evo.chikorita = {
	ndex = 152,

	evos = {
		{
			ndex = 153,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 154,
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

	evos = {
		{
			ndex = 156,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 157,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.quilava, evo.typhlosion = evo.cyndaquil, evo.cyndaquil
evo[155], evo[156], evo[157] = evo.cyndaquil, evo.cyndaquil, evo.cyndaquil

evo.totodile = {
	ndex = 158,

	evos = {
		{
			ndex = 159,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 160,
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

	evos = {
		{
			ndex = 162,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.furret = evo.sentret
evo[161], evo[162] = evo.sentret, evo.sentret

evo.hoothoot = {
	ndex = 163,

	evos = {
		{
			ndex = 164,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.noctowl = evo.hoothoot
evo[163], evo[164] = evo.hoothoot, evo.hoothoot

evo.ledyba = {
	ndex = 165,

	evos = {
		{
			ndex = 166,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,
		}
	}
}
evo.ledian = evo.ledyba
evo[165], evo[166] = evo.ledyba, evo.ledyba

evo.spinarak = {
	ndex = 167,

	evos = {
		{
			ndex = 168,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.ariados = evo.spinarak
evo[167], evo[168] = evo.spinarak, evo.spinarak

evo.chinchou = {
	ndex = 170,

	evos = {
		{
			ndex = 171,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.lanturn = evo.chinchou
evo[170], evo[171] = evo.chinchou, evo.chinchou

evo.togepi = {
	ndex = 175,
	method = evo.methods.BREED,

	evos = {
		{
			ndex = 176,
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 468,
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

	evos = {
		{
			ndex = 178,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.xatu = evo.natu
evo[177], evo[178] = evo.natu, evo.natu

evo.mareep = {
	ndex = 179,

	evos = {
		{
			ndex = 180,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,

			evos = {
				{
					ndex = 181,
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
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Marearoma' },

	evos = {
		{
			ndex = 183,
			method = evo.methods.HAPPINESS,

			evos = {
				{
					ndex = 184,
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

	evos = {
		{
			ndex = 185,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Mimica' },
		}
	}
}
evo.sudowoodo = evo.bonsly
evo[438], evo[185] = evo.bonsly, evo.bonsly

evo.hoppip = {
	ndex = 187,

	evos = {
		{
			ndex = 188,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 189,
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

	evos = {
		{
			ndex = 424,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Doppiosmash' },
		}
	}
}
evo.ambipom = evo.aipom
evo[190], evo[424] = evo.aipom, evo.aipom

evo.sunkern = {
	ndex = 191,

	evos = {
		{
			ndex = 192,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.sunflora = evo.sunkern
evo[191], evo[192] = evo.sunkern, evo.sunkern

evo.yanma = {
	ndex = 193,

	evos = {
		{
			ndex = 469,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Forzantica' },
		}
	}
}
evo.yanmega = evo.yanma
evo[193], evo[469] = evo.yanma, evo.yanma

evo.wooper = {
	ndex = 194,

	evos = {
		{
			ndex = 195,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.quagsire = evo.wooper
evo[194], evo[195] = evo.wooper, evo.wooper

evo.murkrow = {
	ndex = 198,

	evos = {
		{
			ndex = 430,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Neropietra',
		}
	}
}
evo.honchkrow = evo.murkrow
evo[198], evo[430] = evo.murkrow, evo.murkrow

evo.misdreavus = {
	ndex = 200,

	evos = {
		{
			ndex = 429,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Neropietra',
		}
	}
}
evo.mismagius = evo.misdreavus
evo[200], evo[429] = evo.misdreavus, evo.misdreavus

evo.unown = { ndex = 201 }
evo[201] = evo.unown

evo.wynaut = {
	ndex = 360,

	evos = {
		{
			ndex = 202,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.wobbuffet = evo.wynaut
evo[360], evo[202] = evo.wynaut, evo.wynaut

evo.girafarig = { ndex = 203 }
evo[203] = evo.girafarig

evo.pineco = {
	ndex = 204,

	evos = {
		{
			ndex = 205,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.forretress = evo.pineco
evo[204], evo[205] = evo.pineco, evo.pineco

evo.dunsparce = { ndex = 206 }
evo[206] = evo.dunsparce

evo.gligar = {
	ndex = 207,

	evos = {
		{
			ndex = 472,
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

	evos = {
		{
			ndex = 210,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 23,
		}
	}
}
evo.granbull = evo.snubbull
evo[209], evo[210] = evo.snubbull, evo.snubbull

evo.qwilfish = { ndex = 211 }
evo[211] = evo.qwilfish

evo.shuckle = { ndex = 213 }
evo[213] = evo.shuckle

evo.heracross = { ndex = 214 }
evo[214] = evo.heracross

evo.sneasel = {
	ndex = 215,

	evos = {
		{
			ndex = 461,
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

	evos = {
		{
			ndex = 217,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.ursaring = evo.teddiursa
evo[216], evo[217] = evo.teddiursa, evo.teddiursa

evo.slugma = {
	ndex = 218,

	evos = {
		{
			ndex = 219,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.magcargo = evo.slugma
evo[218], evo[219] = evo.slugma, evo.slugma

evo.swinub = {
	ndex = 220,

	evos = {
		{
			ndex = 221,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,

			evos = {
				{
					ndex = 473,
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.MOVE] = 'Forzantica' },
				}
			}
		}
	}
}
evo.piloswine, evo.mamoswine = evo.swinub, evo.swinub
evo[220], evo[221], evo[473] = evo.swinub, evo.swinub, evo.swinub

evo.corsola = { ndex = 222 }
evo[222] = evo.corsola

evo.remoraid = {
	ndex = 223,

	evos = {
		{
			ndex = 224,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.octillery = evo.remoraid
evo[223], evo[224] = evo.remoraid, evo.remoraid

evo.delibird = { ndex = 225 }
evo[225] = evo.delibird

evo.mantyke = {
	ndex = 458,

	evos = {
		{
			ndex = 226,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.OTHER] = 'Con [[Remoraid]] in [[squadra]]' },
		}
	}
}
evo.mantine = evo.mantyke
evo[458], evo[226] = evo.mantyke, evo.mantyke

evo.skarmory = { ndex = 227 }
evo[227] = evo.skarmory

evo.houndour = {
	ndex = 228,

	evos = {
		{
			ndex = 229,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.houndoom = evo.houndour
evo[228], evo[229] = evo.houndour, evo.houndour

evo.phanpy = {
	ndex = 231,

	evos = {
		{
			ndex = 232,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.donphan = evo.phanpy
evo[231], evo[232] = evo.phanpy, evo.phanpy

evo.stantler = { ndex = 234 }
evo[234] = evo.stantler

evo.smeargle = { ndex = 235 }
evo[235] = evo.smeargle

evo.miltank = { ndex = 241 }
evo[241] = evo.miltank

evo.raikou = { ndex = 243 }
evo[243] = evo.raikou

evo.entei = { ndex = 244 }
evo[244] = evo.entei

evo.suicune = { ndex = 245 }
evo[245] = evo.suicune

evo.larvitar = {
	ndex = 246,

	evos = {
		{
			ndex = 247,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 248,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 55,
				}
			}
		}
	}
}
evo.pupitar, evo.tyranitar = evo.larvitar, evo.larvitar
evo[246], evo[247], evo[248] = evo.larvitar, evo.larvitar, evo.larvitar

evo.lugia = { ndex = 249 }
evo[249] = evo.lugia

evo["ho-oh"] = { ndex = 250 }
evo[250] = evo["ho-oh"]

evo.celebi = { ndex = 251 }
evo[251] = evo.celebi

evo.treecko = {
	ndex = 252,

	evos = {
		{
			ndex = 253,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 254,
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

	evos = {
		{
			ndex = 256,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 257,
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

	evos = {
		{
			ndex = 259,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 260,
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

	evos = {
		{
			ndex = 262,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,
		}
	}
}
evo.mightyena = evo.poochyena
evo[261], evo[262] = evo.poochyena, evo.poochyena

evo.zigzagoon = {
	ndex = 263,

	evos = {
		{
			ndex = 264,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.linoone = evo.zigzagoon
evo[263], evo[264] = evo.zigzagoon, evo.zigzagoon

evo.wurmple = {
	ndex = 265,

	evos = {
		{
			ndex = 266,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[personalità]]' },

			evos = {
				{
					ndex = 267,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 10,
				}
			}
		},
		{
			ndex = 268,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 7,
			conditions = { [evo.conditions.OTHER] = 'A seconda della [[personalità]]' },

			evos = {
				{
					ndex = 269,
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

	evos = {
		{
			ndex = 271,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 272,
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

	evos = {
		{
			ndex = 274,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 275,
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

	evos = {
		{
			ndex = 277,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.swellow = evo.taillow
evo[276], evo[277] = evo.taillow, evo.taillow

evo.wingull = {
	ndex = 278,

	evos = {
		{
			ndex = 279,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.pelipper = evo.wingull
evo[278], evo[279] = evo.wingull, evo.wingull

evo.ralts = {
	ndex = 280,

	evos = {
		{
			ndex = 281,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 282,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 30,
				},
				{
					ndex = 475,
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

	evos = {
		{
			ndex = 284,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.masquerain = evo.surskit
evo[283], evo[284] = evo.surskit, evo.surskit

evo.shroomish = {
	ndex = 285,

	evos = {
		{
			ndex = 286,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 23,
		}
	}
}
evo.breloom = evo.shroomish
evo[285], evo[286] = evo.shroomish, evo.shroomish

evo.slakoth = {
	ndex = 287,

	evos = {
		{
			ndex = 288,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 289,
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

	evos = {
		{
			ndex = 291,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		},
		{
			ndex = 292,
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

	evos = {
		{
			ndex = 294,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 295,
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

	evos = {
		{
			ndex = 297,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.hariyama = evo.makuhita
evo[296], evo[297] = evo.makuhita, evo.makuhita

evo.nosepass = {
	ndex = 299,

	evos = {
		{
			ndex = 476,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Campo magnetico speciale' },
		}
	}
}
evo.probopass = evo.nosepass
evo[299], evo[476] = evo.nosepass, evo.nosepass

evo.skitty = {
	ndex = 300,

	evos = {
		{
			ndex = 301,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralunare',
		}
	}
}
evo.delcatty = evo.skitty
evo[300], evo[301] = evo.skitty, evo.skitty

evo.sableye = { ndex = 302 }
evo[302] = evo.sableye

evo.mawile = { ndex = 303 }
evo[303] = evo.mawile

evo.aron = {
	ndex = 304,

	evos = {
		{
			ndex = 305,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 306,
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

	evos = {
		{
			ndex = 308,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.medicham = evo.meditite
evo[307], evo[308] = evo.meditite, evo.meditite

evo.electrike = {
	ndex = 309,

	evos = {
		{
			ndex = 310,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.manectric = evo.electrike
evo[309], evo[310] = evo.electrike, evo.electrike

evo.plusle = { ndex = 311 }
evo[311] = evo.plusle

evo.minun = { ndex = 312 }
evo[312] = evo.minun

evo.volbeat = { ndex = 313 }
evo[313] = evo.volbeat

evo.illumise = { ndex = 314 }
evo[314] = evo.illumise

evo.budew = {
	ndex = 406,
	method = evo.methods.BREED,
	conditions = { [evo.conditions.ITEM] = 'Rosaroma' },

	evos = {
		{
			ndex = 315,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },

			evos = {
				{
					ndex = 407,
					method = evo.methods.STONE,
					stone = 'Pietrabrillo',
				}
			}
		}
	}
}
evo.roselia, evo.roserade = evo.budew, evo.budew
evo[406], evo[315], evo[407] = evo.budew, evo.budew, evo.budew

evo.gulpin = {
	ndex = 316,

	evos = {
		{
			ndex = 317,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.swalot = evo.gulpin
evo[316], evo[317] = evo.gulpin, evo.gulpin

evo.carvanha = {
	ndex = 318,

	evos = {
		{
			ndex = 319,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.sharpedo = evo.carvanha
evo[318], evo[319] = evo.carvanha, evo.carvanha

evo.wailmer = {
	ndex = 320,

	evos = {
		{
			ndex = 321,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.wailord = evo.wailmer
evo[320], evo[321] = evo.wailmer, evo.wailmer

evo.numel = {
	ndex = 322,

	evos = {
		{
			ndex = 323,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.camerupt = evo.numel
evo[322], evo[323] = evo.numel, evo.numel

evo.torkoal = { ndex = 324 }
evo[324] = evo.torkoal

evo.spoink = {
	ndex = 325,

	evos = {
		{
			ndex = 326,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.grumpig = evo.spoink
evo[325], evo[326] = evo.spoink, evo.spoink

evo.spinda = { ndex = 327 }
evo[327] = evo.spinda

evo.trapinch = {
	ndex = 328,

	evos = {
		{
			ndex = 329,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 330,
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

	evos = {
		{
			ndex = 332,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.cacturne = evo.cacnea
evo[331], evo[332] = evo.cacnea, evo.cacnea

evo.swablu = {
	ndex = 333,

	evos = {
		{
			ndex = 334,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.altaria = evo.swablu
evo[333], evo[334] = evo.swablu, evo.swablu

evo.zangoose = { ndex = 335 }
evo[335] = evo.zangoose

evo.seviper = { ndex = 336 }
evo[336] = evo.seviper

evo.lunatone = { ndex = 337 }
evo[337] = evo.lunatone

evo.solrock = { ndex = 338 }
evo[338] = evo.solrock

evo.barboach = {
	ndex = 339,

	evos = {
		{
			ndex = 340,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.whiscash = evo.barboach
evo[339], evo[340] = evo.barboach, evo.barboach

evo.corphish = {
	ndex = 341,

	evos = {
		{
			ndex = 342,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.crawdaunt = evo.corphish
evo[341], evo[342] = evo.corphish, evo.corphish

evo.baltoy = {
	ndex = 343,

	evos = {
		{
			ndex = 344,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.claydol = evo.baltoy
evo[343], evo[344] = evo.baltoy, evo.baltoy

evo.lileep = {
	ndex = 345,

	evos = {
		{
			ndex = 346,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.cradily = evo.lileep
evo[345], evo[346] = evo.lileep, evo.lileep

evo.anorith = {
	ndex = 347,

	evos = {
		{
			ndex = 348,
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

	evos = {
		{
			ndex = 350,
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

evo.castform = { ndex = 351 }
evo[351] = evo.castform

evo.kecleon = { ndex = 352 }
evo[352] = evo.kecleon

evo.shuppet = {
	ndex = 353,

	evos = {
		{
			ndex = 354,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.banette = evo.shuppet
evo[353], evo[354] = evo.shuppet, evo.shuppet

evo.duskull = {
	ndex = 355,

	evos = {
		{
			ndex = 356,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,

			evos = {
				{
					ndex = 477,
					method = evo.methods.TRADE,
					conditions = { [evo.conditions.ITEM] = 'Terrorpanno' },
				}
			}
		}
	}
}
evo.dusclops, evo.dusknoir = evo.duskull, evo.duskull
evo[355], evo[356], evo[477] = evo.duskull, evo.duskull, evo.duskull

evo.tropius = { ndex = 357 }
evo[357] = evo.tropius

evo.chingling = {
	ndex = 433,

	evos = {
		{
			ndex = 358,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' }
		}
	}
}
evo.chimecho = evo.chingling
evo[433], evo[358] = evo.chingling, evo.chingling

evo.absol = { ndex = 359 }
evo[359] = evo.absol

evo.snorunt = {
	ndex = 361,

	evos = {
		{
			ndex = 362,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,
		},
		{
			ndex = 478,
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

	evos = {
		{
			ndex = 364,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 365,
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

	evos = {
		{
			ndex = 367,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Dente Abissi' },
		},
		{
			ndex = 368,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Squamabissi' },
		}
	}
}
evo.huntail, evo.gorebyss = evo.clamperl, evo.clamperl
evo[366], evo[367], evo[368] = evo.clamperl, evo.clamperl, evo.clamperl

evo.relicanth = { ndex = 369 }
evo[369] = evo.relicanth

evo.luvdisc = { ndex = 370 }
evo[370] = evo.luvdisc

evo.bagon = {
	ndex = 371,

	evos = {
		{
			ndex = 372,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,

			evos = {
				{
					ndex = 373,
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

	evos = {
		{
			ndex = 375,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 376,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 45,
				}
			}
		}
	}
}
evo.metang, evo.metagross = evo.beldum, evo.beldum
evo[374], evo[375], evo[376] = evo.beldum, evo.beldum, evo.beldum

evo.regirock = { ndex = 377 }
evo[377] = evo.regirock

evo.regice = { ndex = 378 }
evo[378] = evo.regice

evo.registeel = { ndex = 379 }
evo[379] = evo.registeel

evo.latias = { ndex = 380 }
evo[380] = evo.latias

evo.latios = { ndex = 381 }
evo[381] = evo.latios

evo.kyogre = { ndex = 382 }
evo[382] = evo.kyogre

evo.groudon = { ndex = 383 }
evo[383] = evo.groudon

evo.rayquaza = { ndex = 384 }
evo[384] = evo.rayquaza

evo.jirachi = { ndex = 385 }
evo[385] = evo.jirachi

evo.deoxys = { ndex = 386 }
evo[386] = evo.deoxys

evo.turtwig = {
	ndex = 387,

	evos = {
		{
			ndex = 388,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 389,
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

	evos = {
		{
			ndex = 391,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 392,
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

	evos = {
		{
			ndex = 394,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 395,
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

	evos = {
		{
			ndex = 397,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 398,
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

	evos = {
		{
			ndex = 400,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,
		}
	}
}
evo.bibarel = evo.bidoof
evo[399], evo[400] = evo.bidoof, evo.bidoof

evo.kricketot = {
	ndex = 401,

	evos = {
		{
			ndex = 402,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 10,
		}
	}
}
evo.kricketune = evo.kricketot
evo[401], evo[402] = evo.kricketot, evo.kricketot

evo.shinx = {
	ndex = 403,

	evos = {
		{
			ndex = 404,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 15,

			evos = {
				{
					ndex = 405,
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

	evos = {
		{
			ndex = 409,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.rampardos = evo.cranidos
evo[408], evo[409] = evo.cranidos, evo.cranidos

evo.shieldon = {
	ndex = 410,

	evos = {
		{
			ndex = 411,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.bastiodon = evo.shieldon
evo[410], evo[411] = evo.shieldon, evo.shieldon

evo.burmy = {
	ndex = 412,
	notes = useless.burmy.names.base,

	evos = {
		{
			ndex = 413,
			notes = useless.burmy.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
			conditions = { [evo.conditions.GENDER] = 'Femmina' },
		},
		{
			ndex = 414,
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

	evos = {
		{
			ndex = 416,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,
			conditions = { [evo.conditions.GENDER] = 'Femmina' },
		}
	}
}
evo.vespiquen = evo.combee
evo[415], evo[416] = evo.combee, evo.combee

evo.pachirisu = { ndex = 417 }
evo[417] = evo.pachirisu

evo.buizel = {
	ndex = 418,

	evos = {
		{
			ndex = 419,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.floatzel = evo.buizel
evo[418], evo[419] = evo.buizel, evo.buizel

evo.cherubi = {
	ndex = 420,

	evos = {
		{
			ndex = 421,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.cherrim = evo.cherubi
evo[420], evo[421] = evo.cherubi, evo.cherubi

evo.shellos = {
	ndex = 422,
	notes = useless.shellos.names.base,

	evos = {
		{
			ndex = 423,
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

	evos = {
		{
			ndex = 426,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 28,
		}
	}
}
evo.drifblim = evo.drifloon
evo[425], evo[426] = evo.drifloon, evo.drifloon

evo.buneary = {
	ndex = 427,

	evos = {
		{
			ndex = 428,
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.lopunny = evo.buneary
evo[427], evo[428] = evo.buneary, evo.buneary

evo.glameow = {
	ndex = 431,

	evos = {
		{
			ndex = 432,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.purugly = evo.glameow
evo[431], evo[432] = evo.glameow, evo.glameow

evo.stunky = {
	ndex = 434,

	evos = {
		{
			ndex = 435,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.skuntank = evo.stunky
evo[434], evo[435] = evo.stunky, evo.stunky

evo.bronzor = {
	ndex = 436,

	evos = {
		{
			ndex = 437,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 33,
		}
	}
}
evo.bronzong = evo.bronzor
evo[436], evo[437] = evo.bronzor, evo.bronzor

evo.chatot = { ndex = 441 }
evo[441] = evo.chatot

evo.spiritomb = { ndex = 442 }
evo[442] = evo.spiritomb

evo.gible = {
	ndex = 443,

	evos = {
		{
			ndex = 444,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,

			evos = {
				{
					ndex = 445,
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

	evos = {
		{
			ndex = 448,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.lucario = evo.riolu
evo[447], evo[448] = evo.riolu, evo.riolu

evo.hippopotas = {
	ndex = 449,

	evos = {
		{
			ndex = 450,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.hippowdon = evo.hippopotas
evo[449], evo[450] = evo.hippopotas, evo.hippopotas

evo.skorupi = {
	ndex = 451,

	evos = {
		{
			ndex = 452,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.drapion = evo.skorupi
evo[451], evo[452] = evo.skorupi, evo.skorupi

evo.croagunk = {
	ndex = 453,

	evos = {
		{
			ndex = 454,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.toxicroak = evo.croagunk
evo[453], evo[454] = evo.croagunk, evo.croagunk

evo.carnivine = { ndex = 455 }
evo[455] = evo.carnivine

evo.finneon = {
	ndex = 456,

	evos = {
		{
			ndex = 457,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.lumineon = evo.finneon
evo[456], evo[457] = evo.finneon, evo.finneon

evo.snover = {
	ndex = 459,

	evos = {
		{
			ndex = 460,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.abomasnow = evo.snover
evo[459], evo[460] = evo.snover, evo.snover

evo.rotom = { ndex = 479 }
evo[479] = evo.rotom

evo.uxie = { ndex = 480 }
evo[480] = evo.uxie

evo.mesprit = { ndex = 481 }
evo[481] = evo.mesprit

evo.azelf = { ndex = 482 }
evo[482] = evo.azelf

evo.dialga = { ndex = 483 }
evo[483] = evo.dialga

evo.palkia = { ndex = 484 }
evo[484] = evo.palkia

evo.heatran = { ndex = 485 }
evo[485] = evo.heatran

evo.regigigas = { ndex = 486 }
evo[486] = evo.regigigas

evo.giratina = { ndex = 487 }
evo[487] = evo.giratina

evo.cresselia = { ndex = 488 }
evo[488] = evo.cresselia

evo.phione = {
	ndex = 489,
	method = evo.methods.BREED,
	conditions = { [evo.conditions.BREEDONLY] = true },

	evos = {
		{
			ndex = 490,
		}
	}
}
evo.manaphy = evo.phione
evo[489], evo[490] = evo.phione, evo.phione

evo.darkrai = { ndex = 491 }
evo[491] = evo.darkrai

evo.arceus = { ndex = 493 }
evo[493] = evo.arceus

evo.victini = { ndex = 494 }
evo[494] = evo.victini

evo.snivy = {
	ndex = 495,

	evos = {
		{
			ndex = 496,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 497,
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

	evos = {
		{
			ndex = 499,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 500,
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

	evos = {
		{
			ndex = 502,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 503,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.dewott, evo.samurott = evo.oshawott, evo.oshawott
evo[501], evo[502], evo[503] = evo.oshawott, evo.oshawott, evo.oshawott

evo.patrat = {
	ndex = 504,

	evos = {
		{
			ndex = 505,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.watchog = evo.patrat
evo[504], evo[505] = evo.patrat, evo.patrat

evo.lillipup = {
	ndex = 506,

	evos = {
		{
			ndex = 507,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 508,
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

	evos = {
		{
			ndex = 510,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.liepard = evo.purrloin
evo[509], evo[510] = evo.purrloin, evo.purrloin

evo.pansage = {
	ndex = 511,

	evos = {
		{
			ndex = 512,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafoglia',
		}
	}
}
evo.simisage = evo.pansage
evo[511], evo[512] = evo.pansage, evo.pansage

evo.pansear = {
	ndex = 513,

	evos = {
		{
			ndex = 514,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrafocaia',
		}
	}
}
evo.simisear = evo.pansear
evo[513], evo[514] = evo.pansear, evo.pansear

evo.panpour = {
	ndex = 515,

	evos = {
		{
			ndex = 516,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietraidrica',
		}
	}
}
evo.simipour = evo.panpour
evo[515], evo[516] = evo.panpour, evo.panpour

evo.munna = {
	ndex = 517,

	evos = {
		{
			ndex = 518,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralunare',
		}
	}
}
evo.musharna = evo.munna
evo[517], evo[518] = evo.munna, evo.munna

evo.pidove = {
	ndex = 519,

	evos = {
		{
			ndex = 520,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21,

			evos = {
				{
					ndex = 521,
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

	evos = {
		{
			ndex = 523,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.zebstrika = evo.blitzle
evo[522], evo[523] = evo.blitzle, evo.blitzle

evo.roggenrola = {
	ndex = 524,

	evos = {
		{
			ndex = 525,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 526,
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

	evos = {
		{
			ndex = 528,
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.swoobat = evo.woobat
evo[527], evo[528] = evo.woobat, evo.woobat

evo.drilbur = {
	ndex = 529,

	evos = {
		{
			ndex = 530,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 31,
		}
	}
}
evo.excadrill = evo.drilbur
evo[529], evo[530] = evo.drilbur, evo.drilbur

evo.audino = { ndex = 531 }
evo[531] = evo.audino

evo.timburr = {
	ndex = 532,

	evos = {
		{
			ndex = 533,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 534,
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

	evos = {
		{
			ndex = 536,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = 537,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 36,
				}
			}
		}
	}
}
evo.palpitoad, evo.seismitoad = evo.tympole, evo.tympole
evo[535], evo[536], evo[537] = evo.tympole, evo.tympole, evo.tympole

evo.throh = { ndex = 538 }
evo[538] = evo.throh

evo.sawk = { ndex = 539 }
evo[539] = evo.sawk

evo.sewaddle = {
	ndex = 540,

	evos = {
		{
			ndex = 541,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 542,
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

	evos = {
		{
			ndex = 544,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,

			evos = {
				{
					ndex = 545,
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

	evos = {
		{
			ndex = 547,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.whimsicott = evo.cottonee
evo[546], evo[547] = evo.cottonee, evo.cottonee

evo.petilil = {
	ndex = 548,

	evos = {
		{
			ndex = 549,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.lilligant = evo.petilil
evo[548], evo[549] = evo.petilil, evo.petilil

evo.basculin = { ndex = 550, notes = altforms.basculin.names.base }
evo[550] = evo.basculin

evo.sandile = {
	ndex = 551,

	evos = {
		{
			ndex = 552,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 29,

			evos = {
				{
					ndex = 553,
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

	evos = {
		{
			ndex = 555,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.darmanitan = evo.darumaka
evo[554], evo[555] = evo.darumaka, evo.darumaka

evo.maractus = { ndex = 556 }
evo[556] = evo.maractus

evo.dwebble = {
	ndex = 557,

	evos = {
		{
			ndex = 558,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.crustle = evo.dwebble
evo[557], evo[558] = evo.dwebble, evo.dwebble

evo.scraggy = {
	ndex = 559,

	evos = {
		{
			ndex = 560,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.scrafty = evo.scraggy
evo[559], evo[560] = evo.scraggy, evo.scraggy

evo.sigilyph = { ndex = 561 }
evo[561] = evo.sigilyph

evo.yamask = {
	ndex = 562,

	evos = {
		{
			ndex = 563,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.cofagrigus = evo.yamask
evo[562], evo[563] = evo.yamask, evo.yamask

evo.tirtouga = {
	ndex = 564,

	evos = {
		{
			ndex = 565,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.carracosta = evo.tirtouga
evo[564], evo[565] = evo.tirtouga, evo.tirtouga

evo.archen = {
	ndex = 566,

	evos = {
		{
			ndex = 567,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.archeops = evo.archen
evo[566], evo[567] = evo.archen, evo.archen

evo.trubbish = {
	ndex = 568,

	evos = {
		{
			ndex = 569,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.garbodor = evo.trubbish
evo[568], evo[569] = evo.trubbish, evo.trubbish

evo.zorua = {
	ndex = 570,

	evos = {
		{
			ndex = 571,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.zoroark = evo.zorua
evo[570], evo[571] = evo.zorua, evo.zorua

evo.minccino = {
	ndex = 572,

	evos = {
		{
			ndex = 573,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrabrillo',
		}
	}
}
evo.cinccino = evo.minccino
evo[572], evo[573] = evo.minccino, evo.minccino

evo.gothita = {
	ndex = 574,

	evos = {
		{
			ndex = 575,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 576,
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

	evos = {
		{
			ndex = 578,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,

			evos = {
				{
					ndex = 579,
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

	evos = {
		{
			ndex = 581,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.swanna = evo.ducklett
evo[580], evo[581] = evo.ducklett, evo.ducklett

evo.vanillite = {
	ndex = 582,

	evos = {
		{
			ndex = 583,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 584,
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
	notes = useless.deerling.names.base,

	evos = {
		{
			ndex = 586,
			notes = useless.sawsbuck.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 34,
		}
	}
}
evo.sawsbuck = evo.deerling
evo[585], evo[586] = evo.deerling, evo.deerling

evo.emolga = { ndex = 587 }
evo[587] = evo.emolga

evo.karrablast = {
	ndex = 588,

	evos = {
		{
			ndex = 589,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.TRADED_FOR] = 616 },
		}
	}
}
evo.escavalier = evo.karrablast
evo[588], evo[589] = evo.karrablast, evo.karrablast

evo.foongus = {
	ndex = 590,

	evos = {
		{
			ndex = 591,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.amoonguss = evo.foongus
evo[590], evo[591] = evo.foongus, evo.foongus

evo.frillish = {
	ndex = 592,
	notes = useless.frillish.names.base,

	evos = {
		{
			ndex = 593,
			notes = useless.frillish.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.jellicent = evo.frillish
evo[592], evo[593] = evo.frillish, evo.frillish

evo.alomomola = { ndex = 594 }
evo[594] = evo.alomomola

evo.joltik = {
	ndex = 595,

	evos = {
		{
			ndex = 596,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 36,
		}
	}
}
evo.galvantula = evo.joltik
evo[595], evo[596] = evo.joltik, evo.joltik

evo.ferroseed = {
	ndex = 597,

	evos = {
		{
			ndex = 598,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,
		}
	}
}
evo.ferrothorn = evo.ferroseed
evo[597], evo[598] = evo.ferroseed, evo.ferroseed

evo.klink = {
	ndex = 599,

	evos = {
		{
			ndex = 600,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,

			evos = {
				{
					ndex = 601,
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

	evos = {
		{
			ndex = 603,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,

			evos = {
				{
					ndex = 604,
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

	evos = {
		{
			ndex = 606,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,
		}
	}
}
evo.beheeyem = evo.elgyem
evo[605], evo[606] = evo.elgyem, evo.elgyem

evo.litwick = {
	ndex = 607,

	evos = {
		{
			ndex = 608,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 41,

			evos = {
				{
					ndex = 609,
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

	evos = {
		{
			ndex = 611,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,

			evos = {
				{
					ndex = 612,
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

	evos = {
		{
			ndex = 614,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.beartic = evo.cubchoo
evo[613], evo[614] = evo.cubchoo, evo.cubchoo

evo.cryogonal = { ndex = 615 }
evo[615] = evo.cryogonal

evo.shelmet = {
	ndex = 616,

	evos = {
		{
			ndex = 617,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.TRADED_FOR] = 588 },
		}
	}
}
evo.accelgor = evo.shelmet
evo[616], evo[617] = evo.shelmet, evo.shelmet

evo.stunfisk = { ndex = 618 }
evo[618] = evo.stunfisk

evo.mienfoo = {
	ndex = 619,

	evos = {
		{
			ndex = 620,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 50,
		}
	}
}
evo.mienshao = evo.mienfoo
evo[619], evo[620] = evo.mienfoo, evo.mienfoo

evo.druddigon = { ndex = 621 }
evo[621] = evo.druddigon

evo.golett = {
	ndex = 622,

	evos = {
		{
			ndex = 623,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 43,
		}
	}
}
evo.golurk = evo.golett
evo[622], evo[623] = evo.golett, evo.golett

evo.pawniard = {
	ndex = 624,

	evos = {
		{
			ndex = 625,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 52,
		}
	}
}
evo.bisharp = evo.pawniard
evo[624], evo[625] = evo.pawniard, evo.pawniard

evo.bouffalant = { ndex = 626 }
evo[626] = evo.bouffalant

evo.rufflet = {
	ndex = 627,

	evos = {
		{
			ndex = 628,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 54,
		}
	}
}
evo.braviary = evo.rufflet
evo[627], evo[628] = evo.rufflet, evo.rufflet

evo.vullaby = {
	ndex = 629,

	evos = {
		{
			ndex = 630,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 54,
		}
	}
}
evo.mandibuzz = evo.vullaby
evo[629], evo[630] = evo.vullaby, evo.vullaby

evo.heatmor = { ndex = 631 }
evo[631] = evo.heatmor

evo.durant = { ndex = 632 }
evo[632] = evo.durant

evo.deino = {
	ndex = 633,

	evos = {
		{
			ndex = 634,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 50,

			evos = {
				{
					ndex = 635,
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

	evos = {
		{
			ndex = 637,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 59,
		}
	}
}
evo.volcarona = evo.larvesta
evo[636], evo[637] = evo.larvesta, evo.larvesta

evo.cobalion = { ndex = 638 }
evo[638] = evo.cobalion

evo.terrakion = { ndex = 639 }
evo[639] = evo.terrakion

evo.virizion = { ndex = 640 }
evo[640] = evo.virizion

evo.tornadus = { ndex = 641 }
evo[641] = evo.tornadus

evo.thundurus = { ndex = 642 }
evo[642] = evo.thundurus

evo.reshiram = { ndex = 643 }
evo[643] = evo.reshiram

evo.zekrom = { ndex = 644 }
evo[644] = evo.zekrom

evo.landorus = { ndex = 645 }
evo[645] = evo.landorus

evo.kyurem = { ndex = 646 }
evo[646] = evo.kyurem

evo.keldeo = { ndex = 647 }
evo[647] = evo.keldeo

evo.meloetta = { ndex = 648 }
evo[648] = evo.meloetta

evo.genesect = { ndex = 649 }
evo[649] = evo.genesect

evo.chespin = {
	ndex = 650,

	evos = {
		{
			ndex = 651,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 652,
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

	evos = {
		{
			ndex = 654,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 655,
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

	evos = {
		{
			ndex = 657,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 16,

			evos = {
				{
					ndex = 658,
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

	evos = {
		{
			ndex = 660,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,
		}
	}
}
evo.diggersby = evo.bunnelby
evo[659], evo[660] = evo.bunnelby, evo.bunnelby

evo.fletchling = {
	ndex = 661,

	evos = {
		{
			ndex = 662,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 663,
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

	evos = {
		{
			ndex = 665,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 9,

			evos = {
				{
					ndex = 666,
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

	evos = {
		{
			ndex = 668,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,
		}
	}
}
evo.pyroar = evo.litleo
evo[667], evo[668] = evo.litleo, evo.litleo

evo["flabébé"] = {
	ndex = 669,
	notes = useless.floette.names.base,

	evos = {
		{
			ndex = 670,
			notes = useless.floette.names.base,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 19,

			evos = {
				{
					ndex = 671,
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

	evos = {
		{
			ndex = 673,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
		}
	}
}
evo.gogoat = evo.skiddo
evo[672], evo[673] = evo.skiddo, evo.skiddo

evo.pancham = {
	ndex = 674,

	evos = {
		{
			ndex = 675,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 32,
			conditions = { [evo.conditions.OTHER] = 'Con un Pokémon [[Buio]] in [[squadra]]' },
		}
	}
}
evo.pangoro = evo.pancham
evo[674], evo[675] = evo.pancham, evo.pancham

evo.furfrou = { ndex = 676 }
evo[676] = evo.furfrou

evo.espurr = {
	ndex = 677,

	evos = {
		{
			ndex = 678,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.meowstic = evo.espurr
evo[677], evo[678] = evo.espurr, evo.espurr

evo.honedge = {
	ndex = 679,

	evos = {
		{
			ndex = 680,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 681,
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

	evos = {
		{
			ndex = 683,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Bustina aromi' },
		}
	}
}
evo.aromatisse = evo.spritzee
evo[682], evo[683] = evo.spritzee, evo.spritzee

evo.swirlix = {
	ndex = 684,

	evos = {
		{
			ndex = 685,
			method = evo.methods.TRADE,
			conditions = { [evo.conditions.ITEM] = 'Dolcespuma' },
		}
	}
}
evo.slurpuff = evo.swirlix
evo[684], evo[685] = evo.swirlix, evo.swirlix

evo.inkay = {
	ndex = 686,

	evos = {
		{
			ndex = 687,
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

	evos = {
		{
			ndex = 689,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
		}
	}
}
evo.barbaracle = evo.binacle
evo[688], evo[689] = evo.binacle, evo.binacle

evo.skrelp = {
	ndex = 690,

	evos = {
		{
			ndex = 691,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 41,
		}
	}
}
evo.dragalge = evo.skrelp
evo[690], evo[691] = evo.skrelp, evo.skrelp

evo.clauncher = {
	ndex = 692,

	evos = {
		{
			ndex = 693,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.clawitzer = evo.clauncher
evo[692], evo[693] = evo.clauncher, evo.clauncher

evo.helioptile = {
	ndex = 694,

	evos = {
		{
			ndex = 695,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietrasolare',
		}
	}
}
evo.heliolisk = evo.helioptile
evo[694], evo[695] = evo.helioptile, evo.helioptile

evo.tyrunt = {
	ndex = 696,

	evos = {
		{
			ndex = 697,
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

	evos = {
		{
			ndex = 699,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 39,
			conditions = { [evo.conditions.TIME] = 'Giorno' },
		}
	}
}
evo.aurorus = evo.amaura
evo[698], evo[699] = evo.amaura, evo.amaura

evo.hawlucha = { ndex = 701 }
evo[701] = evo.hawlucha

evo.dedenne = { ndex = 702 }
evo[702] = evo.dedenne

evo.carbink = { ndex = 703 }
evo[703] = evo.carbink

evo.goomy = {
	ndex = 704,

	evos = {
		{
			ndex = 705,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 40,

			evos = {
				{
					ndex = 706,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 50,
					conditions = { [evo.conditions.OTHER] = 'Se [[Condizione atmosferica#Pioggia battente|piove]] nell\'overworld' },
				}
			}
		}
	}
}
evo.sliggoo, evo.goodra = evo.goomy, evo.goomy
evo[704], evo[705], evo[706] = evo.goomy, evo.goomy, evo.goomy

evo.klefki = { ndex = 707 }
evo[707] = evo.klefki

evo.phantump = {
	ndex = 708,

	evos = {
		{
			ndex = 709,
			method = evo.methods.TRADE,
		}
	}
}
evo.trevenant = evo.phantump
evo[708], evo[709] = evo.phantump, evo.phantump

evo.pumpkaboo = {
	ndex = 710,

	evos = {
		{
			ndex = 711,
			method = evo.methods.TRADE,
		}
	}
}
evo.gourgeist = evo.pumpkaboo
evo[710], evo[711] = evo.pumpkaboo, evo.pumpkaboo

evo.bergmite = {
	ndex = 712,

	evos = {
		{
			ndex = 713,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 37,
		}
	}
}
evo.avalugg = evo.bergmite
evo[712], evo[713] = evo.bergmite, evo.bergmite

evo.noibat = {
	ndex = 714,

	evos = {
		{
			ndex = 715,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 48,
		}
	}
}
evo.noivern = evo.noibat
evo[714], evo[715] = evo.noibat, evo.noibat

evo.xerneas = { ndex = 716 }
evo[716] = evo.xerneas

evo.yveltal = { ndex = 717 }
evo[717] = evo.yveltal

evo.zygarde = { ndex = 718 }
evo[718] = evo.zygarde

evo.diancie = { ndex = 719 }
evo[719] = evo.diancie

evo.hoopa = { ndex = 720 }
evo[720] = evo.hoopa

evo.volcanion = { ndex = 721 }
evo[721] = evo.volcanion

evo.rowlet = {
	ndex = 722,

	evos = {
		{
			ndex = 723,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 724,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 34,
				}
			}
		}
	}
}
evo.dartrix, evo.decidueye = evo.rowlet, evo.rowlet
evo[722], evo[723], evo[724] = evo.rowlet, evo.rowlet, evo.rowlet

evo.litten = {
	ndex = 725,

	evos = {
		{
			ndex = 726,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 727,
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

	evos = {
		{
			ndex = 729,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 17,

			evos = {
				{
					ndex = 730,
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

	evos = {
		{
			ndex = 732,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 14,

			evos = {
				{
					ndex = 733,
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

	evos = {
		{
			ndex = 735,
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

	evos = {
		{
			ndex = 737,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 20,

			evos = {
				{
					ndex = 738,
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.LOCATION] = 'Campo magnetico speciale' },
				}
			}
		}
	}
}
evo.charjabug, evo.vikavolt = evo.grubbin, evo.grubbin
evo[736], evo[737], evo[738] = evo.grubbin, evo.grubbin, evo.grubbin

evo.crabrawler = {
	ndex = 739,

	evos = {
		{
			ndex = 740,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Monte Lanakila' },
		}
	}
}
evo.crabominable = evo.crabrawler
evo[739], evo[740] = evo.crabrawler, evo.crabrawler

evo.oricorio = { ndex = 741 }
evo[741] = evo.oricorio

evo.cutiefly = {
	ndex = 742,

	evos = {
		{
			ndex = 743,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
		}
	}
}
evo.ribombee = evo.cutiefly
evo[742], evo[743] = evo.cutiefly, evo.cutiefly

evo.rockruff = {
	ndex = 744,

	evos = {
		{
			ndex = 745,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = { [evo.conditions.OTHER] = 'Di [[Tempo|giorno]] in [[Pokémon Sole e Luna|Sole]] e [[Pokémon Ultrasole e Ultraluna|Ultrasole]]' }
		},
		{
			ndex = '745N',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = { [evo.conditions.OTHER] = 'Di [[Tempo|notte]] in [[Pokémon Sole e Luna|Luna]] e [[Pokémon Ultrasole e Ultraluna|Ultraluna]]' }
		},
		{
			ndex = '745C',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,
			conditions = { [evo.conditions.OTHER] = 'Al tramonto se ha [[Mente Locale]] in [[Pokémon Ultrasole e Ultraluna|Ultrasole e Ultraluna]]' }
		}
	}
}
evo.lycanroc, evo.lycanrocN, evo.lycanrocC =
	evo.rockruff, evo.rockruff, evo.rockruff
evo[744], evo[745], evo['745N'], evo['745C'] =
	evo.rockruff, evo.rockruff, evo.rockruff, evo.rockruff

evo.wishiwashi = { ndex = 746 }
evo[746] = evo.wishiwashi

evo.mareanie = {
	ndex = 747,

	evos = {
		{
			ndex = 748,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.toxapex = evo.mareanie
evo[747], evo[748] = evo.mareanie, evo.mareanie

evo.mudbray = {
	ndex = 749,

	evos = {
		{
			ndex = 750,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.mudsdale = evo.mudbray
evo[749], evo[750] = evo.mudbray, evo.mudbray

evo.dewpider = {
	ndex = 751,

	evos = {
		{
			ndex = 752,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 22,
		}
	}
}
evo.araquanid = evo.dewpider
evo[751], evo[752] = evo.dewpider, evo.dewpider

evo.fomantis = {
	ndex = 753,

	evos = {
		{
			ndex = 754,
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

	evos = {
		{
			ndex = 756,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 24,
		}
	}
}
evo.shiinotic = evo.morelull
evo[755], evo[756] = evo.morelull, evo.morelull

evo.salandit = {
	ndex = 757,

	evos = {
		{
			ndex = 758,
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

	evos = {
		{
			ndex = 760,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 27,
		}
	}
}
evo.bewear = evo.stufful
evo[759], evo[760] = evo.stufful, evo.stufful

evo.bounsweet = {
	ndex = 761,

	evos = {
		{
			ndex = 762,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 18,

			evos = {
				{
					ndex = 763,
					method = evo.methods.LEVEL,
					conditions = { [evo.conditions.MOVE] = 'Pestone' },
				}
			}
		}
	}
}
evo.steenee, evo.tsareena = evo.bounsweet, evo.bounsweet
evo[761], evo[762], evo[763] = evo.bounsweet, evo.bounsweet, evo.bounsweet

evo.comfey = { ndex = 764 }
evo[764] = evo.comfey

evo.oranguru = { ndex = 765 }
evo[765] = evo.oranguru

evo.passimian = { ndex = 766 }
evo[766] = evo.passimian

evo.wimpod = {
	ndex = 767,

	evos = {
		{
			ndex = 768,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 30,
		}
	}
}
evo.golisopod = evo.wimpod
evo[767], evo[768] = evo.wimpod, evo.wimpod

evo.sandygast = {
	ndex = 769,

	evos = {
		{
			ndex = 770,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 42,
		}
	}
}
evo.palossand = evo.sandygast
evo[769], evo[770] = evo.sandygast, evo.sandygast

evo.pyukumuku = { ndex = 771 }
evo[771] = evo.pyukumuku

evo["tipo zero"] = {
	ndex = 772,

	evos = {
		{
			ndex = 773,
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.silvally = evo["tipo zero"]
evo[772], evo[773] = evo["tipo zero"], evo["tipo zero"]

evo.minior = { ndex = 774 }
evo[774] = evo.minior

evo.komala = { ndex = 775 }
evo[775] = evo.komala

evo.turtonator = { ndex = 776 }
evo[776] = evo.turtonator

evo.togedemaru = { ndex = 777 }
evo[777] = evo.togedemaru

evo.mimikyu = { ndex = 778 }
evo[778] = evo.mimikyu

evo.bruxish = { ndex = 779 }
evo[779] = evo.bruxish

evo.drampa = { ndex = 780 }
evo[780] = evo.drampa

evo.dhelmise = { ndex = 781 }
evo[781] = evo.dhelmise

evo["jangmo-o"] = {
	ndex = 782,

	evos = {
		{
			ndex = 783,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 35,

			evos = {
				{
					ndex = 784,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 45,
				}
			}
		}
	}
}
evo["hakamo-o"], evo["kommo-o"] = evo["jangmo-o"], evo["jangmo-o"]
evo[782], evo[783], evo[784] = evo["jangmo-o"], evo["jangmo-o"], evo["jangmo-o"]

evo['tapu koko'] = { ndex = 785 }
evo[785] = evo['tapu koko']

evo['tapu lele'] = { ndex = 786 }
evo[786] = evo['tapu lele']

evo['tapu bulu'] = { ndex = 787 }
evo[787] = evo['tapu bulu']

evo['tapu fini'] = { ndex = 788 }
evo[788] = evo['tapu fini']

evo.cosmog = {
	ndex = 789,

	evos = {
		{
			ndex = 790,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 43,

			evos = {
				{
					ndex = 791,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 53,
					conditions = { [evo.conditions.OTHER] = 'In [[Pokémon Sole e Luna|Sole]] e [[Pokémon Ultrasole e Ultraluna|Ultrasole]]' }
				},
				{
					ndex = 792,
					method = evo.methods.LEVEL,
					[evo.methods.LEVEL] = 53,
					conditions = { [evo.conditions.OTHER] = 'In [[Pokémon Sole e Luna|Luna]] e [[Pokémon Ultrasole e Ultraluna|Ultraluna]]' }
				}
			}
		}
	}
}
evo.cosmoem, evo.solgaleo, evo.lunala = evo.cosmog, evo.cosmog, evo.cosmog
evo[789], evo[790], evo[791], evo[792] = evo.cosmog, evo.cosmog, evo.cosmog, evo.cosmog

evo.nihilego = { ndex = 793 }
evo[793] = evo.nihilego

evo.buzzwole = { ndex = 794 }
evo[794] = evo.buzzwole

evo.pheromosa = { ndex = 795 }
evo[795] = evo.pheromosa

evo.xurkitree = { ndex = 796 }
evo[796] = evo.xurkitree

evo.celesteela = { ndex = 797 }
evo[797] = evo.celesteela

evo.kartana = { ndex = 798 }
evo[798] = evo.kartana

evo.guzzlord = { ndex = 799 }
evo[799] = evo.guzzlord

evo.necrozma = { ndex = 800 }
evo[800] = evo.necrozma

evo.magearna = { ndex = 801 }
evo[801] = evo.magearna

evo.marshadow = { ndex = 802 }
evo[802] = evo.marshadow

evo.poipole = {
	ndex = 803,

	evos = {
		{
			ndex = 804,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.MOVE] = 'Dragopulsar' },
		}
	}
}
evo.naganadel = evo.poipole
evo[803], evo[804] = evo.poipole, evo.poipole

evo.stakataka = { ndex = 805 }
evo[805] = evo.stakataka

evo.blacephalon = { ndex = 806 }
evo[806] = evo.blacephalon

evo.zeraora = { ndex = 807 }
evo[807] = evo.zeraora

evo.meltan = {
	ndex = 808,

	evos = {
		{
			ndex = 809,
			method = evo.methods.OTHER,
			[evo.methods.OTHER] = '<span class="text-small">Con 400 [[Caramelle]] Meltan in [[Pokémon GO]]</span>',
		}
	}
}
evo.melmetal = evo.meltan
evo[808], evo[809] = evo.meltan, evo.meltan

-- Alternative forms
evo.rattataA = {
	ndex = '019A',

	evos = {
		{
			ndex = '020A',
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

	evos = {
		{
			ndex = '028A',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
		}
	}
}
evo.sandslashA = evo.sandshrewA
evo['027A'], evo['028A'] = evo.sandshrewA, evo.sandshrewA

evo.vulpixA = {
	ndex = '037A',

	evos = {
		{
			ndex = '038A',
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietragelo',
		}
	}
}
evo.ninetalesA = evo.vulpixA
evo['037A'], evo['038A'] = evo.vulpixA, evo.vulpixA

evo.diglettA = {
	ndex = '050A',

	evos = {
		{
			ndex = '051A',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 26,
		}
	}
}
evo.dugtrioA = evo.diglettA
evo['050A'], evo['051A'] = evo.diglettA, evo.diglettA

evo.meowthA = {
	ndex = '052A',

	evos = {
		{
			ndex = '053A',
			method = evo.methods.HAPPINESS,
		}
	}
}
evo.persianA = evo.meowthA
evo['052A'], evo['053A'] = evo.meowthA, evo.meowthA

evo.geodudeA = {
	ndex = '074A',

	evos = {
		{
			ndex = '075A',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 25,

			evos = {
				{
					ndex = '076A',
					method = evo.methods.TRADE,
				}
			}
		}
	}
}
evo.gravelerA, evo.golemA = evo.geodudeA, evo.geodudeA
evo['074A'], evo['075A'], evo['076A'] = evo.geodudeA, evo.geodudeA, evo.geodudeA

evo.grimerA = {
	ndex = '088A',

	evos = {
		{
			ndex = '089A',
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 38,
		}
	}
}
evo.mukA = evo.grimerA
evo['088A'], evo['089A'] = evo.grimerA, evo.grimerA

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
				basenode.ndex = tostring(basenode.ndex) .. abbr
				basenode.notes = name
			end
			return basenode
		end)

		table.map(ndexes, function(ndex)
			evo[tostring(ndex) .. abbr] = newtab
			evo[pokes[ndex].name .. abbr] = newtab
		end)
	end)
end

evo.unown = { ndex = 201 }
evo[201] = evo.unown

createAlternativeForm(useless.burmy, evo.burmy)

createAlternativeForm(useless.shellos, evo.shellos)

createAlternativeForm(altforms.basculin, evo.basculin)

createAlternativeForm(useless.deerling, evo.deerling)

createAlternativeForm(useless.frillish, evo.frillish)

createAlternativeForm(useless.floette, evo.floette)

return evo
