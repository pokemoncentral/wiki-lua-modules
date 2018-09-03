--[[

This module holds datas for those Pokémon that has both Alt and Useless forms.
When possible, takes datas from the other alternative forms modules.

--]]

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused
local alt = require("AltForms-data")
local useless = require("UselessForms-data")

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = {}
t.minior = useless.minior

--[[

Alternative forms names. Keys are the abbr.

--]]

t.pikachu.names = table.merge(alt.pikachu.names, useless.pikachu.names)

-- Alternative forms' links

t.pikachu.links = table.merge(alt.pikachu.links, useless.pikachu.links)

-- Alternative forms' black links

t.pikachu.blacklinks = table.merge(
				   			alt.pikachu.blacklinks,
					   		useless.pikachu.blacklinks
					   )

-- Table to map extended names to abbrs

t.pikachu.ext = table.merge(alt.pikachu.ext, useless.pikachu.ext)

--[[

Arrays keeping the order in which alternative forms are listed in the latest
game.

--]]

t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W',
	'O', 'H', 'Si', 'U', 'K', 'A', 'Co'}

--[[

Oldest game in which each form, included base form, appears.

--]]

t.pikachu.since = table.merge(alt.pikachu.since, useless.pikachu.since)

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pikachu['until'] = {Cs = 'roza', R = 'roza', D = 'roza', Cn = 'roza',
	S = 'roza', W = 'roza'}

-- Aliasing, put here to avoid needless repetitions of previous cycles.

t[25] = t.pikachu
t[774] = t.minior

return t
