-- "Test cases" for stats

local stats = require('Stats')

-- =========== StatsBox ==============
print(stats.statsBox{args = {
	hp = 255,
	atk = 5,
	def = 10,
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

-- First gen, with spec
print(stats.statsBox{args={
	hp = '33',
	atk = '136',
	def = '0',
	spec = '6',
	spe = '29',
	type1 = 'sconosciuto',
	type2 = 'normale',
	bounds = 'yes',
	gen = '1',
}})

-- =================== TypeAvg =================
print(stats.typeAvg{args = {'Elettro'}})

print(stats.typeAvg{args = {'Fuoco', '4'}})

-- =================== PokeStats ==================

-- Plain
print(stats.PokeStats{args = {'Starly'}})

-- Strange name
print(stats.PokeStats{args = {'Ho-Oh'}})

-- Huge values
print(stats.PokeStats{args = {'Blissey'}})

-- Non-standard stat calculation
print(stats.PokeStats{args = {'Shedinja'}})

-- Form collapse
print(stats.PokeStats{args = {'Arceus'}})

-- Form non collapse
print(stats.PokeStats{args = {'Giratina'}})

-- Speciali
print(stats.PokeStats{args = {'Magikarp'}})

-- Multigen
print(stats.PokeStats{args = {'Aegislash'}})

-- Both form multigen
print(stats.PokeStats{args = {'Alakazam'}})
