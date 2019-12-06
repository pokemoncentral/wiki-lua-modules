--[[

This module holds datas for those Pokémon that has both Alt and Useless forms.
When possible, takes datas from the other alternative forms modules.

--]]

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused
local alt = require("AltForms-data")
local useless = require("UselessForms-data")

local function mergeByName(poke)
    local res = {}

    -- Alternative forms names
    -- Table.copy is needed because table.merge doesn't work on
    -- mw.loadDataed tables.
    res.names = table.merge(table.copy(alt[poke].names),
                            table.copy(useless[poke].names))

    -- Alternative forms' links
    res.links = table.merge(table.copy(alt[poke].links),
                            table.copy(useless[poke].links))

    -- Alternative forms' black links
    res.blacklinks = table.merge(table.copy(alt[poke].blacklinks),
                                 table.copy(useless[poke].blacklinks))

    -- Table to map extended names to abbrs
    res.ext = table.merge(table.copy(alt[poke].ext),
                          table.copy(useless[poke].ext))

    -- Oldest game in which each form, included base form, appears.
    res.since = table.merge(table.copy(alt[poke].since),
                            table.copy(useless[poke].since))

    return res
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.charizard = mergeByName("charizard")
t.pikachu = mergeByName("pikachu")
t.meowth = mergeByName("meowth")
t.gengar = mergeByName("gengar")
t.eevee = mergeByName("eevee")
-- The copy is needed to remove metatable that mw.loadData doesn't like
t.minior = table.copy(useless.minior)
t.toxtricity = mergeByName("toxtricity")

-- gamesOrder can't be merged automatically because there's no way to sort
-- abbrs

t.charizard.gamesOrder = {'base', 'MX', 'MY', 'Gi'}
t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W',
    'O', 'H', 'Si', 'U', 'K', 'A', 'Co', 'Cm', 'Gi'}
t.meowth.gamesOrder = {'base', 'A', 'G', 'Gi'}
t.gengar.gamesOrder = {'base', 'M', 'Gi'}
t.eevee.gamesOrder = {'base', 'Cm', 'Gi'}
t.toxtricity.gamesOrder = {'base', 'B', 'Gi'}

-- Only merged when present

t.pikachu['until'] = table.copy(alt.pikachu['until'])
t.eevee['until'] = table.copy(alt.eevee['until'])

-- Aliasing, put here to avoid needless repetitions of previous cycles.

t[6] = t.charizard
t[25] = t.pikachu
t[52] = t.meowth
t[94] = t.gengar
t[133] = t.eevee
t[774] = t.minior
t[849] = t.toxtricity

return t
