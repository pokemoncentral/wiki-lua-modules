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

Automatically merges alt and useless forms data of a certain Pokémon.
Merges names, links, blacklinks, ext, since and (if needed) until. Doesn't
merge gamesOrder because it can't know how to sort it.

--]]
local function mergeByName(poke)
    local res = {}

    -- Table.copy is needed because table.merge doesn't work on
    -- mw.loadDataed tables.
    res.names = table.merge(table.copy(alt[poke].names),
                            table.copy(useless[poke].names))

    res.links = table.merge(table.copy(alt[poke].links),
                            table.copy(useless[poke].links))

    res.blacklinks = table.merge(table.copy(alt[poke].blacklinks),
                                 table.copy(useless[poke].blacklinks))

    res.plainlinks = table.merge(table.copy(alt[poke].plainlinks),
                                 table.copy(useless[poke].plainlinks))

    res.ext = table.merge(table.copy(alt[poke].ext),
                          table.copy(useless[poke].ext))

    res.since = table.merge(table.copy(alt[poke].since),
                            table.copy(useless[poke].since))

    -- Only merged when present
    if alt[poke]['until'] or useless[poke]['until'] then
        res['until'] = table.merge(table.copy(alt[poke]['until'] or {}),
                                   table.copy(useless[poke]['until'] or {}))
    end

    return res
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = mergeByName("pikachu")
t.alcremie = mergeByName("alcremie")
t.alcremie.names.base = useless.alcremie.names.base
-- The copy is needed to remove metatable that mw.loadData doesn't like
t.minior = table.copy(useless.minior)

-- gamesOrder can't be merged automatically because there's no way to sort
-- abbrs
-- Minor isn't here because the AltForms is a subset of UselesForms

t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W',
    'O', 'H', 'Si', 'U', 'K', 'A', 'Co', 'Cm', 'G', 'Gi'}
t.alcremie.gamesOrder = table.copy(useless.alcremie.gamesOrder)
table.insert(t.alcremie.gamesOrder, "Gi")

-- Aliasing, put here to avoid needless repetitions of previous cycles.

t[25] = t.pikachu
t[774] = t.minior
t[869] = t.alcremie

return t
