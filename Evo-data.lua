local evo = {}

--[[

Those two tables hold evolution methods and conditions common to multiple
evolutionary line. The meaning of each value is self-explanatory. There's a
special value, 'OTHER', that handles anything that is unique to a single line.

Method and condition 'OTHER' should be used ONLY to handle methods/conditions
that occur in AT MOST ONE evolutionary lines. Should that method/condition be
used again in a new evolutionary line, it's best if we add a new constant to
dentify it.

--]]
evo.methods = {}
evo.methods.OTHER = 0
evo.methods.LEVEL = 1
-- HAPPINESS should be a condition for LEVEL method, but everywhere is
-- considered a standalone method
evo.methods.HAPPINESS = 2
evo.methods.STONE = 3
evo.methods.TRADE = 4
evo.methods.BREED = 5

evo.conditions = {}
evo.conditions.OTHER = 0
evo.conditions.TIME = 3
evo.conditions.ITEM = 4
evo.conditions.LOCATION = 5
evo.conditions.MOVE = 6
evo.conditions.GENDER = 7
evo.conditions.TRADED_FOR = 8
-- evo.conditions.STATS = 6
-- evo.conditions.PARTY = 8
-- evo.conditions.EMPTY_SLOT = 9

-- Bulbasaur, normal evoline
evo[1] = {
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
					[evo.methods.LEVEL] = 32
				}
			}
		}
	}
}

evo[2], evo[3] = evo[1], evo[1]
evo.bulbasaur, evo.ivysaur, evo.venusaur =
		evo[1], evo[1], evo[1]

-- Zubat, happiness evolution
evo[41] = {
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

evo[42], evo[169] = evo[41], evo[41]
evo.zubat, evo.golbat, evo.crobat =
		evo[41], evo[41], evo[41]

-- Oddish, branched evoline and evostones
evo[43] = {
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

evo[44], evo[45], evo[182] = evo[43], evo[43], evo[43]
evo.oddish, evo.gloom, evo.vileplume, evo.bellossom =
		evo[43], evo[43], evo[43], evo[43]

-- Eevee
evo[133] = {
	ndex = 33,

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
			conditions = { [evo.conditions.TIME] = 'Giorno' }
		},
		{
			ndex = 197,
			method = evo.methods.HAPPINESS,
			conditions = { [evo.conditions.TIME] = 'Notte' }
		},
		{
			ndex = 470,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Roccia Muschio' }
		},
		{
			ndex = 471,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.LOCATION] = 'Roccia Ghiaccio' }
		},
		{
			ndex = 700,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.OTHER] = 'con due cuori di {{colore2|000|amicizia}}<div>avendo appreso una mossa di tipo {{colore2|000|Folletto}}</div>' }
		}
	}
}

evo[134], evo[135], evo[136], evo[196], evo[197], evo[470], evo[471], evo[700] =
	evo[133], evo[133], evo[133], evo[133], evo[133], evo[133], evo[133], evo[133]
evo.eevee, evo.vaporeon, evo.jolteon, evo.flareon, evo.espeon, evo.umbreon =
	evo[133], evo[133], evo[133], evo[133], evo[133], evo[133]
evo.leafeon, evo.glaceon, evo.sylveon = evo[133], evo[133], evo[133]

-- Nincada, example of OTHER
evo[290] = {
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
			[evo.methods.OTHER] = '{{bag|Poké Ball}}',
			conditions = { [evo.conditions.OTHER] = 'Con spazio in {{colore2|000|squadra}}<div>e almeno una {{colore2|000|Poké Ball}} nello {{colore2|000|zaino}}</div>' }
		}
	}
}

-- Roselia, breed evoline
evo[406] = {
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
					stone = 'Pietrabrillo'
				}
			}
		}
	}
}

evo[315], evo[407] = evo[406], evo[406]
evo.budew, evo.roselia, evo.roserade =
		evo[406], evo[406], evo[406]

-- Sneasel, level with condition
evo[215] = {
	ndex = 215,

	evos = {
		{
			ndex = 461,
			method = evo.methods.LEVEL,
			conditions = { [evo.conditions.ITEM] = 'Affilodente' }
		}
	}
}

evo[461] = evo[215]
evo.sneasel, evo.weavile = evo[215], evo[215]

-- Snorunt
evo[361] = {
	ndex = 361,

	evos = {
		{
			ndex = 362,
			method = evo.methods.LEVEL,
			[evo.methods.LEVEL] = 21
		},
		{
			ndex = 478,
			method = evo.methods.STONE,
			[evo.methods.STONE] = 'Pietralbore',
			conditions = { [evo.conditions.GENDER] = 'Femmina' }
		}
	}
}

return evo
