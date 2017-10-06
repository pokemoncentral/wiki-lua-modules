--[[

This module prints a list of all Pokémon
having unique base stat total

--]]

local u = {}

local css = require('Css')
local ms = require('MiniSprite')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local str = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local mg = require('Wikilib-multigen')
local gendata = require("Gens-data")
local pokes = require('Poké-data')

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
local uniqueStatTotal = function(allStats)

    -- Mapping to base stat totals
    local tots = table.map(allStats, function(stats)
            return table.fold(stats, 0,
                    function(a, b) return a + mg.getGenValue(b, gendata.latest) end)
        end, list.pokeNames)

    --[[
        Filtering unique base stat totals only:
        checks if there's not any base stat total
        equal to the current one but of a different
        Pokémon
    --]]
    return table.filter(tots, function(tot, poke)
            return not table.any(tots, function(otherTot, otherPoke)
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
    local this = table.merge(Entry.super.new(name), pokes[name])

    this.total = total

    return setmetatable(this, Entry)
end

--[[

Wikicode for a list entry: shows Pokémon ndex,
mini sprite, name and base stats, plus total
and average.

--]]
Entry.__tostring = function(this)
    return string.interp([=[| class="hidden-xs" style="padding: 0.3ex 0.6ex" | ${ndex}
| style="padding: 0.3ex 0.6ex" | ${ms}
| style="padding: 0.3ex 0.6ex" | [[${name}|<span style="color: #000;">${name}</span>]]${form}
| style="padding: 0.3ex 0.6ex" | '''${total}''']=],
        {
            ndex = string.tf(this.ndex),
            ms = ms.staticLua(string.tf(this.ndex) ..
                    (this.formAbbr == 'base' and ''
                            or this.formAbbr or '')),
            name = this.name,
            form = this.formsData and
                    this.formsData.blacklinks[this.formAbbr]
                    or '',
            total = this.total
        })
end

--[[

Wiki interface function: called with no
argument, returns the list of all Pokémon
having unique base sta total

Example:
{{#invoke: Statlist/unique | statlistUnique }}

--]]
u.statlistUnique = function(frame)
    return list.makeList({
        source = uniqueStatTotal(require('PokéStats-data')),
        makeEntry = Entry,
        header = string.interp([=[{| class="sortable roundy-corners pull-center text-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|-
! class="hidden-xs" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | [[Pokédex Nazionale|<span style="color: #000;">#</span>]]
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | &nbsp;
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | Pokémon
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | Totale]=],
            { bg = css.horizGradLua{type = 'pcwiki'} }),
        footer = '|}'
    })
end

u.StatlistUnique = u.statlistUnique

print(u.statlistUnique())

return u
