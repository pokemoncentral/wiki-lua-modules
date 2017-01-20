local evo = {}

evo.methods = {}
evo.methods.LEVEL = 0
--[[
	Should be a condition for LEVEL method, but
	it's handled this way nowhere in the wiki
--]]
evo.methods.HAPPINESS = 1
evo.methods.STONE = 2
evo.methods.TRADE = 3
evo.methods.BREED = 4

evo.conditions = {}
evo.conditions.TIME = 1
evo.conditions.ITEM = 2
evo.conditions.LOCATION = 3
evo.conditions.MOVE = 4
evo.conditions.STATS = 5
evo.conditions.SEX = 6
evo.conditions.PARTY = 7
evo.conditions.EMPTY_SLOT = 8
evo.conditions.TRADED_FOR = 9

evo[1] = {
	ndex = 1,

	children = {
		{
			ndex = 2,
			method = evo.methods.LEVEL,
			level = 16,

			children = {
				{
					ndex = 3,
					method = evo.methods.LEVEL,
					level = 32
				}
			}
		}
	}
}

evo[2], evo[3] = evo[1], evo[1]
evo.bulbasaur, evo.ivysaur, evo.venusaur =
		evo[1], evo[1], evo[1]

evo[41] = {
	ndex = 41,

	children = {
		{
			ndex = 42,
			method = evo.methods.LEVEL,
			level = 22

			chidren = {
				{
					ndex = 169,
					method = evo.methods.HAPPINESS
				}
			}
		}
	}
}

evo[42], evo[169] = evo[41], evo[41]
evo.zubat, evo.golbat, evo.crobat =
		evo[41], evo[41], evo[41]

evo[43] = {
	ndex = 43,

	children = {
		{
			ndex = 44,
			method = evo.methods.LEVEL,
			level = 21,

			children = {
				{
					ndex = 45,
					method = evo.methods.STONE
					stone = 'Pietrafoglia'
				},
				{
					ndex = 182,
					method = evo.methods.STONE,
					stone = 'Pietrasolare'
				}
			}
		}
	}
}

evo[44], evo[45], evo[182] = evo[43], evo[43], evo[43]
evo.oddish, evo.gloom, evo.vileplume, evo.bellossom =
		evo[43], evo[43], evo[43], evo[43]

evo[406] = {
	ndex = 406,
	methods = evo.method.BREED,
	conditions = {evo.conditions.ITEM = 'Rosaroma'},

	children = {
		{
			ndex = 315,
			method = evo.methods.HAPPINESS,
			conditions = {evo.conditions.TIME = 'Giorno'},

			children = {
				{
					ndex = 407,
					method = evo.methods.STONE,
					stone = 'Pietrabrillo'
				}
			}
		}
	}
}

evo[315], evo[407] = evo[406], evo[406]
evo.budew, evo.roselia, evo.roserade =
		evo[406], evo[406], evo[406]

evo[215] = {
	ndex = 215,

	children = {
		{
			ndex = 461,
			method = evo.methods.LEVEL,
			conditions = {evo.conditions.ITEM = 'Affilodente'}
		}
	}
}

evo[461] = evo[215]
evo.sneasel, evo.weavile = evo[215], evo[215]

-- Snorunt
evo[361] = {
	ndex = 361,

	children = {
		{
			ndex = 362,
			method = evo.methods.LEVEL,
			level = 21
		},
		{
			ndex = 478,
			method = evo.methods.STONE,
			stone = 'Pietralbore'
			conditions = {evo.conditions.FEMALE}
		}
	}
}

return evo

