--[[

This module holds datas for those Pokémon that has both Alt and Useless forms.
When possible, takes datas from the other alternative forms modules.

--]]

local t = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local alt = require("AltForms-data")
local useless = require("UselessForms-data")
-- stylua: ignore end

--[[

Automatically merges alt and useless forms data of a certain Pokémon.
Merges names, links, blacklinks, ext, since and (if needed) until. Doesn't
merge gamesOrder because it can't know how to sort it.

--]]
local function mergeByName(poke)
    local res = {}

    -- Tab.copy is needed because tab.merge doesn't work on mw.loaded tables.
    res.names =
        tab.merge(tab.copy(alt[poke].names), tab.copy(useless[poke].names))

    res.links =
        tab.merge(tab.copy(alt[poke].links), tab.copy(useless[poke].links))

    res.blacklinks = tab.merge(
        tab.copy(alt[poke].blacklinks),
        tab.copy(useless[poke].blacklinks)
    )

    res.plainlinks = tab.merge(
        tab.copy(alt[poke].plainlinks),
        tab.copy(useless[poke].plainlinks)
    )

    res.ext = tab.merge(tab.copy(alt[poke].ext), tab.copy(useless[poke].ext))

    res.since =
        tab.merge(tab.copy(alt[poke].since), tab.copy(useless[poke].since))

    -- Only merged when present
    if alt[poke]["until"] or useless[poke]["until"] then
        res["until"] = tab.merge(
            tab.copy(alt[poke]["until"] or {}),
            tab.copy(useless[poke]["until"] or {})
        )
    end

    return res
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = mergeByName("pikachu")
t.floette = mergeByName("floette")
t.alcremie = mergeByName("alcremie")
t.alcremie.names.base = useless.alcremie.names.base
-- The copy is needed to remove tha metatable that mw.loadData doesn't like
t.minior = tab.copy(useless.minior)

-- gamesOrder can't be merged automatically because there's no way to sort
-- abbrs
-- Minor isn't here because the AltForms is a subset of UselesForms

-- stylua: ignore
t.pikachu.gamesOrder = {
    'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W', 'O', 'H', 'Si', 'U', 'K', 'A',
    'Co', 'Cm', 'G', 'Gi'
}
t.floette.gamesOrder = { "base", "E", "M", "G", "A", "Bl", "Bi" }
t.alcremie.gamesOrder = tab.copy(useless.alcremie.gamesOrder)
table.insert(t.alcremie.gamesOrder, "Gi")

-- Aliasing, put here to avoid needless repetitions of previous cycles.

t[25] = t.pikachu
t[670] = t.floette
t[774] = t.minior
t[869] = t.alcremie

return t
