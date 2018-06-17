-- "Test cases" for stats

local stats = require('Stats')

-- =========== StatsBox ==============
print(stats.statsBox{args = {
	hp = 200,
	atk = 40,
	def = 80,
	spatk = 93,
	spdef = 135,
	spe = 63,
	type1 = 'elettro',
	type2 = 'fuoco',
	bounds = 'yes',
	gen = 2,
	listLink = 'yes'
}})

print(stats.statsBox{args = {
	hp = '50',
	atk = '220',
	def = '210',
	spatk = '90',
	spdef = '21',
	spe = '120',
	type = 'acciaio',
	totalLink = 'yes',
	align = 'left',
}})

-- =================== TypeAvg =================
print(stats.typeAvg{args = {'Elettro'}})

print(stats.typeAvg{args = {'Fuoco', '4'}})

-- =================== PokeStats ==================

-- Plain
print(stats.PokeStats{args = {'Starly'}})

-- Strange name
print(stats.PokeStats{args = {'Ho-Oh'}})

-- Form collapse
print(stats.PokeStats{args = {'Arceus'}})

-- Form non collapse
print(stats.PokeStats{args = {'Giratina'}})

-- Speciali
print(stats.PokeStats{args = {'Magikarp'}})

-- Multigen
print(stats.PokeStats{args = {'Staraptor'}})

-- Both form multigen
print(stats.PokeStats{args = {'Alakazam'}})
