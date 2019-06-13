--[[

This file adds a Pokémon with missing informations to data modules, in order
to test against it.

The Pokémon is SnorloBello, and has no ndex, but the load function may or may
not load many other informations.

--]]

local pokes = require('Poké-data')
local pokeabils = require('PokéAbil-data')
local eggs = require('PokéEggGroup-data')
local items = require('PokéItems-data')
local stats = require('PokéStats-data')
local evos = require('Evo-data')

--[[

Add SnorloBello to data modules. The only argument is a set of flags:
    - types (default true): SnorloBello has types
    - abil (default false): SnorloBello has an ability
    - eggs (default false): SnorloBello has an egg group
    - stats (default false): SnorloBello has a set of stats

SnorloBello has a name and never has an ndex. Moreover, it doesn't have any
evolution, but may have some types, an ability, an egg group or some stats.

--]]
local function loadSnorloBello(load)
    local name = "SnorloBello"
    local nameidx = name:lower()

    pokes[nameidx] = { name = name }
    if load.types == nil or load.types then
        pokes[nameidx].type1, pokes[nameidx].type2 = "Psico", "Psico"
    end
    pokeabils[nameidx] = { ability1 = '' }
    if load.abil then
        pokeabils[nameidx].ability1 = "Burla"
    end
    if load.eggs then
        eggs[nameidx] = { group1 = "mostro" }
    end
    items[nameidx] = {}
    if load.stats then
        stats[nameidx] = {hp = 45, atk = 49, def = 49, spatk = 65, spdef = 65, spe = 45, spec = 65}
    end
    evos[nameidx] = { ndex = nil, name = nameidx }
end

return loadSnorloBello
