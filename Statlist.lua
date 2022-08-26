--[[

This module prints a list of all Pokémon base statistics.

Generation I has a separate table because it has different statistics, while
the other are merged into one.

--]]

local s = {}

local css = require('Css')
local ms = require('MiniSprite')
local gamesUtil = require('Wikilib-games')
local genUtil = require('Wikilib-gens')
local formUtil = require('Wikilib-forms')
local list = require('Wikilib-lists')
local mg = require('Wikilib-multigen')
local oop = require('Wikilib-oop')
local statsUtil = require('Wikilib-stats')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local c = require("Colore-data")
local gendata = require("Gens-data")
local pokes = require('Poké-data')
local stats = require('PokéStats-data')

local mw = require('mw')

--[[

Class representing an entry for the base statistics list. By subclassing
PokeSortableEntry it implements all the interfaces needed for sortForm,
sortNdex and makeList in Wikilib/lists

--]]
s.Entry = oop.makeClass(list.PokeLabelledEntry)

--[[

Returns a stub for the generation span of the statistics sum, which lacks the
end. The starting generation is either the passed one or the latest; the value
itself is computed from those of the passed statistics in such generation.

--]]
s.Entry.makeSumSpan = function(stats, gen)
    gen = gen or gendata.latest
    stats = statsUtil.getStatsGen(stats, gen)

    return {
        val = statsUtil.statsSum(stats),
        first = gen
    }
end

--[[

Returns the generation spans for the statistics sum, starting from the given
generation. First generation is not included.

--]]
s.Entry.makeSum = function(stats, startGen)

    --[[
        If stats have not changed throughout the generations, returning a
        single span beginning and ends in the latest generation.
    --]]
    if not statsUtil.didStatsChange(stats) then
        local sum = s.Entry.makeSumSpan(stats)
        sum.last = gendata.latest
        return {sum}
    end

    -- Skipping first gen
    startGen = math.max(startGen, 2)
    local sums = {s.Entry.makeSumSpan(stats, startGen)}

    for gen = startGen + 1, gendata.latest do

        -- Whether any stat changed in the current gen
        local anyChange = table.any(stats, function(stat)
            return type(stat) == 'table' and stat[gen]
        end)

        if anyChange then
            sums[#sums].last = gen - 1
            table.insert(sums, s.Entry.makeSumSpan(stats, gen))
        end
    end

    sums[#sums].last = gendata.latest
    return sums
end

--[[

Wikicode for a single stat cell: can print both generation spans and single
values

--]]
s.Entry.printStatCell = function(stat, statName)
    local interpData = {bg = c[statName].light}
    if type(stat) == 'number' then
        interpData.val = string.printNumber(stat)
        interpData.latest = stat
    else
        interpData.val = mg.printSpans(stat, string.printNumber)
        interpData.latest = stat[#stat].val
    end
    return string.interp('| style="padding: 0.3ex 0.8ex; font-weight: bolder; background: #${bg};" data-sort-value="${latest}" | ${val}',
        interpData)
end

--[[

Constructor: the first argument is an entry from PokéStats/data; the second one
is its key; the third one is optional, and marks the generation this entry
should display data for: if omitted, all the generation but the first are taken
in account. Therefore, the only filtering performed is to exclude Pokémon and
forms not existing in the passed generation, if any.

--]]
s.Entry.new = function(stats, poke, gen)
    if gen and not gamesUtil.isInGen(poke, gen) then
        return nil
    end

    local this = s.Entry.super.new(poke, pokes[poke].ndex)

    -- No generation means from second onwards
    this.statsOrder = statsUtil.statsOrder[gen or 2]

    -- Statistics are not merged at top level to ease subsequent calculations
    if gen then

        -- No need for generation spans in single-generation case
        this.stats = statsUtil.getStatsGen(stats, gen)
        this.statsSum = statsUtil.statsSum(this.stats)
        this.statsAvg = this.statsSum / table.getn(this.stats)
    else
        local pokeGen = this.formAbbr
            and genUtil.getGen.game(this.formsData.since[this.formAbbr])
            or genUtil.getGen.ndex(this.ndex)
        pokeGen = math.max(pokeGen, 2)
        this.stats = statsUtil.cleanStats(mg.getGenSpans(stats), 2)
        this.statsSum = s.Entry.makeSum(stats, pokeGen)
        local statsCount = table.getn(this.stats)
        this.statsAvg = table.map(this.statsSum, function(span)
            span = mw.clone(span)
            span.val = span.val / statsCount
            return span
        end)
    end

    return setmetatable(this, s.Entry)
end

--[[

Equality operator for entries' merging.

--]]
s.Entry.__eq = function(a, b)
    -- The two entries are equals iff their stats tables are the same
    return table.equal(a.stats, b.stats)
end

--[[

Wikicode for a list entry: shows Pokémon ndex, mini sprite, name and base
stats, plus total and average.

--]]
s.Entry.__tostring = function(this)
    local cells = table.map(this.statsOrder, function(stat)
        return s.Entry.printStatCell(this.stats[stat], stat)
    end, ipairs)
    table.insert(cells, s.Entry.printStatCell(this.statsSum, 'pcwiki'))
    table.insert(cells, s.Entry.printStatCell(this.statsAvg, 'pcwiki'))
    local name = pokes[this.name].name

    local form = ''
    if this.labels[1] and this.labels[1] ~= "" then
        form = this.labels[1] == 'Tutte le forme'
                and '<div class="small-text">Tutte le forme</div>'
                or this.formsData.blacklinks[this.formAbbr]
    end

    return string.interp([=[| style="padding: 0.3ex 0.8ex;" data-sort-value="${sortDex}" | ${ndex}
| style="padding: 0.3ex 0.8ex;" data-sort-value="${sortName}" | ${ms}
| class="black-text" style="padding: 0.3ex 0.8ex;" | [[${name}]]${form}
${statsCells}]=],
        {
            sortDex = this.ndex or '???',
            ndex = this.ndex and string.tf(this.ndex) or '???',
            sortName = formUtil.formSortValue(this.ndex, this.formAbbr, name),
            ms = ms.staticLua{string.tf(this.ndex or 0) ..
                    (this.formAbbr == 'base' and '' or this.formAbbr or '')},
            name = name,
            form = form,
            statsCells = table.concat(cells, '\n')
        })
end

-- Headers
s.headers = {}

-- List header
s.headers.header = string.interp([=[{| class="roundy-corners text-center pull-center white-rows sortable" style="border-spacing: 0; padding: 0.6ex; ${bg};"
|-
! class="black-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|#]]
! colspan="2" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex;" | Pokémon
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${hp};" | [[Statistiche#PS|PS]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${atk};" | [[Statistiche#Attacco|Attacco]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${def};" | [[Statistiche#Difesa|Difesa]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${spatk};" | [[Statistiche#Attacco Speciale|Attacco sp.]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${spdef};" | [[Statistiche#Difesa Speciale|Difesa sp.]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${spe};" | [[Statistiche#Velocità|Velocità]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${pcw};" | Totale
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${pcw};" | Media]=],
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

-- List header
s.headers.firstGenHeader = string.interp([=[{| class="roundy-corners text-center pull-center white-rows sortable" style="border-spacing: 0; padding: 0.6ex; ${bg};"
|-
! class="black-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|#]]
! colspan="2" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex;" | Pokémon
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${hp};" | [[Statistiche#PS|PS]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${atk};" | [[Statistiche#Attacco|Attacco]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${def};" | [[Statistiche#Difesa|Difesa]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${spec};" | [[Statistiche#Speciali|Speciali]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${spe};" | [[Statistiche#Velocità|Velocità]]
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${pcw};" | Totale
! class="roundytop text-small white-text" style="padding-top: 0.8ex; padding-bottom: 0.8ex; padding-left: 1ex; background-color: #${pcw};" | Media]=],
    {
        bg = css.horizGradLua{type = 'pcwiki'},
        hp = c.ps.normale,
        atk = c.attacco.normale,
        def = c.difesa.normale,
        spec = c.speciale.normale,
        spe = c.velocita.normale,
        pcw = c.pcwiki.dark
    }
)

--[[

Wiki interface function: called with no argument, returns the list of all
Pokémon statistics for all generations but the first, which has a separate
table.

Example:
{{#invoke: Statlist | statlist }}

--]]
s.statlist = function(frame)        -- luacheck: no unused
    return table.concat({
        [[===Dalla seconda generazione in poi===]],
        list.makeCollapsedList({
            source = stats,
            makeEntry = s.Entry.new,
            iterator = list.pokeNames,
            header = s.headers.header,
            fullGroupLabel = 'Tutte le forme'
        }),
        [[===Nella prima generazione===]],
        list.makeCollapsedList({
            source = stats,
            makeEntry = s.Entry.new,
            entryArgs = 1,
            iterator = list.pokeNames,
            header = s.headers.firstGenHeader,
            fullGroupLabel = 'Tutte le forme'
        })
    }, '\n')
end

s.Statlist = s.statlist

return s
