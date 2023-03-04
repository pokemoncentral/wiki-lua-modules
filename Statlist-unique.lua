--[[

This module prints a list of all Pokémon
having unique base stat total

--]]

local u = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local css = require('Css')
local ms = require('MiniSprite')
local gamesUtil = require('Wikilib-games')
local genUtil = require('Wikilib-gens')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local statsUtil = require('Wikilib-stats')
local multigen = require('Wikilib-multigen')
local gendata = require("Gens-data")
local pokes = require('Poké-data')
local pokestats = require('PokéStats-data')
-- stylua: ignore end

--[[

Mapreduce part of the module: returns a table
whose keys are Pokémon names and values their
base stat total, filtering only unique base
stat total values.

Even though makeList allows for some form of
filtering, it does not allow conditions to be
based on the whole collection, making a separate
function necessary.

--]]
local uniqueStatTotal = function(allStats, gen)
    local pokesInGen = tab.filter(allStats, function(_, poke)
        return not txt.parseInt(poke) and gamesUtil.isInGen(poke, gen)
    end)

    -- Mapping to base stat totals
    local tots = tab.map(pokesInGen, function(pokeStats)
        return statsUtil.statsSum(statsUtil.getStatsGen(pokeStats, gen))
    end)

    --[[
        Filtering unique base stat totals only:
        checks if there's not any base stat total
        equal to the current one but of a different
        Pokémon
    --]]
    return tab.filter(tots, function(tot, poke)
        return not tab.any(tots, function(otherTot, otherPoke)
            return tot == otherTot and poke ~= otherPoke
        end)
    end)
end

--[[

Class representing an entry for the unique stat total
list. By subclassing PokeSortableEntry it implements
all the interfaces needed for sortForm, sortNdex
and makeList in Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Constructor: the first argument is a base stat total
and the second the name of the Pokémon having it.
Filtering requires checking other entries, and is
therefore not implemented here: hence, this constructor
never returns nil.

--]]
Entry.new = function(total, name)
    local this = tab.merge(Entry.super.new(name), multigen.getGen(pokes[name]))

    this.total = total

    return setmetatable(this, Entry)
end

--[[

Wikicode for a list entry: shows Pokémon ndex,
mini sprite, name and base stats, plus total
and average.

--]]
Entry.__tostring = function(this)
    return txt.interp(
        [=[| class="hidden-xs" style="padding: 0.3ex 0.6ex" | ${ndex}
| style="padding: 0.3ex 0.6ex" | ${ms}
| style="padding: 0.3ex 0.6ex" | [[${name}|<span style="color: #000;">${name}</span>]]${form}
| style="padding: 0.3ex 0.6ex" | '''${total}''']=],
        {
            ndex = genUtil.ndexToString(this.ndex),
            ms = ms.staticLua({
                txt.ff(this.ndex or 0)
                    .. (this.formAbbr == "base" and "" or this.formAbbr or ""),
            }),
            name = this.name,
            form = this.formsData and this.formsData.blacklinks[this.formAbbr]
                or "",
            total = this.total,
        }
    )
end

--[[

Wiki interface function: returns the list
of all Pokémon having unique base stat total
in the provided generation, which defaults
to the latest.

Examples:

Latest generation:
{{#invoke: Statlist/unique | statlistUnique }}

Specific generation:
{{#invoke: Statlist/unique | statlistUnique | 4 }}

--]]
u.statlistUnique = function(frame)
    local gen = tonumber(frame.args[1]) or gendata.latest
    return list.makeList({
        source = uniqueStatTotal(pokestats, gen),
        makeEntry = Entry,
        header = txt.interp(
            [=[{| class="sortable roundy-corners pull-center text-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|-
! class="hidden-xs" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | [[Pokédex Nazionale|<span style="color: #000;">#</span>]]
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | &nbsp;
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | Pokémon
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | Totale]=],
            { bg = css.horizGradLua({ type = "pcwiki" }) }
        ),
    })
end

u.StatlistUnique = u.statlistUnique

return u
