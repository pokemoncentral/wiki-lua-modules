--[[

This module prints a list of all
Pokémon base statistics

--]]

local s = {}

local css = require('Css')
local ms = require('MiniSprite')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local c = require("Colore-data")
local pokes = require('Poké-data')

--[[

Class representing an entry for the base statistics
list. By subclassing PokeSortableEntry it implements
all the interfaces needed for sortForm, sortNdex
and makeList in Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Constructor: the first argument is an entry from
PokéStats/data and the second one its key. Since
no filtering is needed, it never returns nil.

--]]
Entry.new = function(stats, poke)
    local this = table.merge(Entry.super.new(poke),
        pokes[poke])

    --[[
        Statistics are not merged at top level
        to ease later total stat calculation
    --]]
    this.stats = stats

    return setmetatable(this, Entry)
end

--[[

Wikicode for a list entry: shows Pokémon ndex,
mini sprite, name and base stats, plus total
and average.

--]]
Entry.__tostring = function(this)
    local sum = table.fold(this.stats, 0,
            function(a, b) return a + b end)

    return string.interp([=[| style="padding: 0.3ex 0.8ex;" | ${ndex}
| style="padding: 0.3ex 0.8ex;" | ${ms}
| style="padding: 0.3ex 0.8ex;" | [[${name}|<span style="color: #000;">${name}</span>]]${form}
| style="padding: 0.3ex 0.8ex; background: #${hpColor};" | '''${hp}'''
| style="padding: 0.3ex 0.8ex; background: #${atkColor};" | '''${atk}'''
| style="padding: 0.3ex 0.8ex; background: #${defColor};" | '''${def}'''
| style="padding: 0.3ex 0.8ex; background: #${spatkColor};" | '''${spatk}'''
| style="padding: 0.3ex 0.8ex; background: #${spdefColor};" | '''${spdef}'''
| style="padding: 0.3ex 0.8ex; background: #${speColor};" | '''${spe}'''
| style="padding: 0.3ex 0.8ex; background: #${pcwColor};" | '''${sum}'''
| style="padding: 0.3ex 0.8ex; background: #${pcwColor};" | '''${avg}''']=],
        {
            ndex = string.tf(this.ndex),
            ms = ms.staticLua(string.tf(this.ndex) ..
                    (this.formAbbr == 'base' and ''
                     or this.formAbbr or '')),
            name = this.name,
            form = this.formsData and
                    this.formsData.blacklinks[this.formAbbr]
                    or '',
            hpColor = c.ps.light,
            hp = this.stats.hp,
            atkColor = c.attacco.light,
            atk = this.stats.atk,
            defColor = c.difesa.light,
            def = this.stats.def,
            spatkColor = c.attacco_speciale.light,
            spatk = this.stats.spatk,
            spdefColor = c.difesa_speciale.light,
            spdef = this.stats.spdef,
            speColor = c.velocita.light,
            spe = this.stats.spe,
            pcwColor = c.pcwiki.medium_light,
            sum = sum,
            avg = string.printNumber(sum / 6)
        })
end

-- List header
local header = string.interp([=[{| class="sortable roundy-corners text-center pull-center white-rows" style="border-spacing: 0; padding: 0.6ex; ${bg};"
|-
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color: #000;">#</span>]]
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | &nbsp;
! style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex;" | Pokémon
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${hp};" | [[Statistiche#PS|<span style="color: #FFF;">PS</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${atk};" | [[Statistiche#Attacco|<span style="color: #FFF;">Attacco</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${def};" | [[Statistiche#Difesa|<span style="color: #FFF;">Difesa</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${spatk};" | [[Statistiche#Attacco Speciale|<span style="color: #FFF;">Attacco sp.</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${spdef};" | [[Statistiche#Difesa Speciale|<span style="color: #FFF;">Difesa sp.</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; background-color: #${spe};" | [[Statistiche#Velocità|<span style="color: #FFF;">Velocità</span>]]
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; color: #FFF; background-color: #${pcw};" | Totale
! class="roundytop text-small" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 0.8ex; color: #FFF; background-color: #${pcw};" | Media]=],
    {
        bg = css.horizGradLua{type = 'pcwiki'},
        hp = c.ps.normale,
        atk = c.attacco.normale,
        def = c.difesa.normale,
        spatk = c.attacco_speciale.normale,
        spdef = c.difesa_speciale.normale,
        spe = c.velocita.normale,
        pcw = c.pcwiki.dark
    }
)

--[[

Wiki interface function: called with no
argument, returns the list of all Pokémon
statistics.

Example:
{{#invoke: Statlist | statlist }}

--]]
s.statlist = function(frame)
    return list.makeList({
        source = require('PokéStats-data'),
        makeEntry = Entry,
        iterator = list.pokeNames,
        header = header,
        footer = '|}'
    })
end

s.Statlist = s.statlist

print(s.statlist())

return s
