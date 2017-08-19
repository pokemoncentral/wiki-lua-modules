--[[

This module displays wikicode for anything
related to a set of values for al six statistics.
So far, it can display stats for a single
Pokémon, the average for a single type and
user-supplied values

--]]

local s = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local css = require('Css')
local formUtil = require('Wikilib-forms')
local formulas = require('Wikilib-formulas')
local list = require('Wikilib-lists')
local mg = require('Wikilib-multigen')
local oop = require('Wikilib-oop')
local w = require('Wikilib')
local c = require("Colore-data")
local gendata = require("Gens-data")
local pokes = require('Poké-data')
local stats = require("PokéStats-data")
local wdata = require("Wikilib-data")

local mw = require('mw')

-- Mapping of stat keys to user-interface names
local statNames = {
    hp = 'PS',
    atk = 'Attacco',
    def = 'Difesa',
    spatk = 'Att. Sp.',
    spdef = 'Dif. Sp.',
    spec = 'Speciali',
    spe = 'Velocità'
}

-- Mapping of stat keys to URL fragments in 'Statistiche' page
local statLinks = mw.clone(statNames)
statLinks.spatk = 'Attacco_Speciale'
statLinks.spdef = 'Difesa_Speciale'

-- Long wikicode strings making functions unreadable
local strings = {
    statBounds = [=[

| class="hidden-xs" | &nbsp;
| class="${rleft}text-small hidden-xs" style="padding: 0.3ex 0.8ex; background: #${bg};" | ${min50} - ${max50}
| class="${rright}text-small hidden-xs" style="padding: 0.3ex 0.8ex; background: #${bg};" | ${min100} - ${max100}]=],

    statRow = [=[|-
| ${rleft}style="width: 5.5em; padding: 0.3ex 0.8ex; background: #${light};" | [[Statistiche#${link}|<span style="color: #${normale};">${stat}</span>]]
| ${rright}style="padding: 0.3ex 0.8ex; background: #${light};" | ${statBar}${bounds}]=],

    headerValues = [=[

! colspan="3" class="width-xl-30 hidden-xs" style="padding: 0.3ex 0.8ex;" | Valori
|-
! class="hidden-xs" style="width: 0.1ex; padding: 0;" | &nbsp;
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv. 50
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv.100]=],

    boundsFooter = [=[

* Le statistiche minime sono calcolate con 0 [[PA]], VI pari a 0, e una [[natura]] sfavorevole.
* Le [[statistiche]] massime sono calcolate 252 PA, [[VI]] pari a 31, e una natura favorevole.]=],

    footer = [=[

| colspan="3" class="hidden-xs" | &nbsp;
|-
| colspan="5" class="hidden-xs text-left text-small" style="font-weight: normal;" | ${content}
]=],

    totalLink = [=[<div class="flex flex-nowrap flex-row flex-main-start flex-items-center">${tot}<span class="text-small text-center" style="margin-left: 2ex;">[[:Categoria:Pokémon con statistiche base totali di ${tot}|<span style="color: initial;">Altri Pokémon con questo totale</span>]]</span></div>]=],

    boxStats = [=[{| class="roundy text-center${align}${width}" style="border-spacing: 0 0.3ex; padding: 0.3ex 0.5ex; font-weight: bolder; ${bg};"
! colspan="2" ${rs}style="padding: 0.3ex 0.8ex;" | Statistiche base${values}
${stats}
|-
| style="padding: 0.3ex 0.8ex;" | Totale
| class="text-left" style="padding: 0.3ex 0.8ex 0.3ex 1.8ex;" | ${total}${footer}
|}]=],

    statBar = [=[<div class="roundyright text-left" style="margin-left: 1ex; width: calc(1em + ${width}%); ${bg}; color: #${dark};">'''${val}'''</div>]=],

    boxFormWrapper = [[==== ${title} ====
<div class="${collapse}">
${box}
</div>]],

    listFooter = [=[

* Le statistiche di questo Pokémon sono cambiati nel corso delle generazioni. Tutti i valori sono disponibili [[Elenco Pokémon per statistiche base|qui]]. ]=]
}

--[[

Computes the avreage stats of the Pokémon
whose names are given. Names must be the
name + abbreviation combination seen in
all data modules.

--]]
local statsAvg = function(pokeNames)
    local avgStats = {hp = 0, atk = 0, def = 0,
        spatk = 0, spdef = 0, spe = 0}

    -- Computing sum for every stat
    avgStats = table.fold(pokeNames, avgStats, function(avgStats, poke)
        local pokeStats = stats[poke]
        return table.map(avgStats, function(stat, statName)
            return stat + pokeStats[statName]
        end)
    end)

    -- Actually computing average
    local pokesCount = table.getn(pokeNames)
    return table.map(avgStats, function(stat)
        return stat / pokesCount
    end)
end

--[[

Prints a row of the stats box for a single stat.
It's fed the stat name, its value, the roundyness
and whether to computer max and min values for the
stat. The roundyness can be: anything evaluating
o false, in which case the row will have no roundyness;
'top', which will make cells rounded at one top corner;
'bottom', which will round cells bottom corners.

--]]
local statRow = function(stat, value, roundyness, computeBounds)

    --[[
        Interpolation values for basic case,
        which means no roundyness and no
        min-max calculation.
    --]]
    local bounds = ''
    local roundy = {left = '', right = '',
        boundsLeft = '', boundsRight = ''}

    if roundyness then
        local edge = roundyness:sub(1, 1)
        roundy.left = table.concat{'class="roundy', edge, 'l" '}
        roundy.right = table.concat{'class="roundy', edge, 'r" '}

        if computeBounds then
            roundy.boundsLeft = table.concat{'roundy', edge, 'l '}
            roundy.boundsRight = table.concat{'roundy', edge, 'r '}
        end
    end

    if computeBounds then
        local calcStat = stat == 'hp' and formulas.hp or formulas.stat
        bounds = string.interp(strings.statBounds,
            {
                rleft = roundy.boundsLeft,
                bg = c[stat].light,
                min50 = calcStat(0, value, 0, 50, 0.9),
                max50 = calcStat(31, value, 252, 50, 1.1),
                rright = roundy.boundsRight,
                min100 = calcStat(0, value, 0, 100, 0.9),
                max100 = calcStat(31, value, 252, 100, 1.1),
            })
    end

    return string.interp(strings.statRow,
        {
            rleft = roundy.left,
            light = c[stat].light,
            link = statLinks[stat],
            normale = c[stat].normale,
            stat = statNames[stat],
            rright = roundy.right,
            statBar = s.statBarLua(stat, value),
            bounds = bounds
        })
end

--[[

Prints a statistics box. Arguments are named:
    - stats: table with statistics to be printed,
            in the format as PokéStats/data
    - types: table of type names, in a format
            accepted by css module
    - align: alignemnt of the table. One of
            'center', 'left' or 'right'
    - bounds: whether min-max values for statistics
            are to be computed. Defaults to false.
    - totalLink: if the link to other Pokémon with
            the same base stat total is to be displayed.
            Defaults to false.
    - listLink: if the link to all Pokémon by stats
            list page is to be displayed.
            Defaults to false.

--]]
local boxStats = function(args)
    local stats, types = args.stats, args.types
    local align, computeBounds = args.align, args.bounds
    local totalLink, listLink = args.totalLink, args.listLink

    local tot = string.printNumber(table.fold(stats, 0, function(a, b)
        return a + b end))

    --[[
        Need to get rid of non-existent stats because no
        holes are allowed when concatenating later on
    --]]
    local statRows = table.filter(wdata.statsOrder,
        function(stat) return stats[stat] end)

    --[[
        Interpolation values for basic case,
        which means no min-max calculation
        and no link to other Pokémon with the
        same base stat total displayed.
    --]]
    local interpVal = {
        align = align == 'left' and '' or ' pull-' .. align,
        width = ' width-xl-30 width-md-50 width-sm-60 width-xs-100',
        bg = css.horizGradLua(types),
        rs = '',
        values = '',
        stats = w.mapAndConcat(statRows, '\n',
            function(stat, index)
                local roundy = false
                if index == 1 then
                    roundy = 'top'
                elseif index == table.getn(statRows) then
                    roundy = 'bottom'
                end

                return statRow(stat, stats[stat], roundy, computeBounds)
            end),
        total = tot,
        footer = ''
    }

    if computeBounds then
        interpVal.width = ''
        interpVal.rs = 'rowspan="2" '
        interpVal.values = strings.headerValues
        interpVal.footer = strings.boundsFooter
    end

    if totalLink then
        interpVal.width = ''
        interpVal.total = string.interp(strings.totalLink,
            {tot = tot})
    end

    if listLink then
        interpVal.footer = interpVal.footer .. strings.listFooter
    end

    if interpVal.footer ~= '' then
        interpVal.footer = string.interp(strings.footer,
            {content = interpVal.footer})
    end

    return string.interp(strings.boxStats, interpVal)
end

--[[

This class represents a statistics box for
a single Pokémon. Forms having the same stats
share can a single box, their names appearing
as a label for the box itself.

--]]
local PokeStatBox = oop.makeClass(list.Labelled)

PokeStatBox.getStats = function(poke, gen)
    local pokeStats = mg.getGen(stats[poke], gen)
    if gen == 1 then
        pokeStats.spatk = nil
        pokeStats.spdef = nil
    else
        pokeStats.spec = nil
    end

    local hasPrevGen = stats[poke].spec
            or table.any(stats[poke], function(stat)
                return type(stat) == 'table' end)

    return pokeStats, hasPrevGen
end

--[[

Class constructor: as per makeFormsLabelledBoxes
specifications, it takes the name of a Pokémon,
with an appended abbreviations for alternative
forms, and a form extended name.

--]]
PokeStatBox.new = function(poke, formExtName, gen)
    -- If the Pokémon's data isn't in PokéStats-data the entry should be nil
    if not stats[poke] then
        return nil
    end

    local this = PokeStatBox.super.new(formExtName)

    --[[
        Shared boxes have base form types,
        which are retrieved if necessary
        using the base form name.
    --]]
    this.baseFormName = formUtil.getNameAbbr(poke)

    this.stats, this.listLink = PokeStatBox.getStats(poke, gen)
    local pokeData = pokes[poke]
    this.types = {type1 = pokeData.type1, type2 = pokeData.type2}

    return setmetatable(this, PokeStatBox)
end

-- Two equal stat boxes have the same stats
PokeStatBox.__eq = function(a, b)
    return table.equal(a.stats, b.stats)
end

--[[

Wikicode for Pokémon stat boxes: min-max values
and a link to other Pokémon with the same base
stat total are displayed withing the standard
stats box. If there are any labels, they are
displayed in a heading, and the box is hidden
according to the collapsed status.

--]]
PokeStatBox.__tostring = function(this)
    local box = boxStats{
        stats = this.stats,
        types = this.types,
        align = 'center',
        bounds = true,
        totalLink = true,
        listLink = this.listLink
    }

    if #this.labels < 1 then
        return box
    end

    return string.interp(strings.boxFormWrapper,
        {
            title = mw.text.listToText(this.labels, ', ', ' e '),
            collapse = this.collapse or '',
            box = box
        })
end

--[[

This method adds a form label to the current list.
The superclass overriding is necessary to fetch
base form types, which is the rule for shared boxes.

--]]
PokeStatBox.addLabel = function(this, label)
    PokeStatBox.super.addLabel(this, label)

    local pokeData = pokes[this.baseFormName]
    this.types = {type1 = pokeData.type1, type2 = pokeData.type2}
end

-- Sets the collapsed status
PokeStatBox.setCollapse = function(this, collapse)
    this.collapse = collapse
end

--[[

Returns the wikicode for a statistic bar: it
has the value inside, a gradient as a background
and its width is proportional to the value,
relatively to 255.

--]]
s.statBarLua = function(stat, value)
    return string.interp(strings.statBar,
        {
            width = value / 255 * 100,
            bg = css.horizGradLua{type = stat},
            dark = c[stat].dark,
            val = string.printNumber(value)
        })
end
s.stat_bar_lua = s.statBarLua

--[[

Returns the wikicode for a statistic bar: it
has the value inside, a gradient as a background
and its width is proportional to the value,
relatively to 255. The first argument, or the
named stat, is the statistic name, while the second
one, or the one with key value, is its value.

Examples:

{{#invoke Stats | statBar | ps | 120 }}
{{#invoke Stats | statBar | stat = ps | value = 120 }}

--]]
s.statBar = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    return s.statBarLua(p.stat or p[1], p.value or p[2])
end
s.StatBar, s.statbar = s.statBar, s.statBar

--[[

Prints statistics box for a single Pokémon.
Minimin and maximum values for each statistic are
displayed, as well as a link to other Pokémon with
the same base stat total. Alternative forms are
included by default, although it is possible to
display stats for a single form only by passing
'yes' as a second argument, or named 'noForms'.
Statistic values are that of the latest generation
by default, unless a third argument, or named 'gen',
is passed with another number.

Examples:

All forms:
{{#invoke: Stats | PokeStats | Rotom }}

IN POKÉMON PAGES ONLY!
{{#invoke: Stats | PokeStats | {{BASEPAGENAME}} }}

Single form:
{{#invoke: Stats | PokeStats | BlastoiseM | yes }}

Older generations:
{{#invoke: Stats | PokeStats | Gengar | | 5 }}
{{#invoke: Stats | PokeStats | Gengar | gen = 5 }}

--]]
s.pokeStats = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    local poke = string.firstLowercase(p[1] or p.poke)
    local noForms = (p[2] or p.noForms or 'no'):lower() == 'yes'
    local gen = tonumber(p[3] or p.gen) or gendata.latest

    if noForms then
        local stats, hasPrevGen = PokeStatBox.getStats(poke, gen)
        return boxStats{
            stats = stats,
            types = pokes[poke],
            align = 'center',
            bounds = true,
            totalLink = true,
            listLink = hasPrevGen
        }
    else
        return list.makeFormsLabelledBoxes{
            name = poke,
            makeBox = PokeStatBox.new,
            boxArgs = gen,
            printBoxes = function(boxes)

                -- No collapse and extra markup for single boxes
                if #boxes == 1 then
                    return tostring(boxes[1])
                end

                --[[
                    All boxes collapsable and all but the
                    first collapsed by default
                --]]
                return w.mapAndConcat(boxes, function(box, key)
                    box:setCollapse('mw-collapsible' ..
                            (key == 1 and '' or ' mw-collapsed'))
                    return tostring(box)
                end, '\n')
            end
        }
    end
end
s.PokeStats, s['pokéStats'], s['PokéStats'] =
    s.pokeStats, s.pokeStats, s.pokeStats

--[[

Prints the average of the statistics for Pokémon
of a specific type, alternative forms included,
as a statistics box. Minimin and maximum values
for each statistic are not displayed, and neither
is the link to other Pokémon with the same base
stat total.

Examples:

{{#invoke: Stats | typeAvg | Elettro (tipo) }}

IN TYPES PAGES ONLY!
{{#invoke: Stats | typeAvg | {{BASEPAGENAME}} }}

--]]
s.typeAvg = function(frame)
    local type = string.trim(frame.args[1])
        :match('^(%a+) %(tipo%)$'):lower()

    --[[
        string.find is used instead of plain equality
        because of coleot/coleottero dualism. stats[poke]
        is checked first because it might be that
        statistics data and Pokémon data are not updated
        together consistently.
    --]]
    local typedPokes = table.keys(table.filter(pokes, function(poke, key)
        return stats[key]
            and not string.parseInt(key)
            and (poke.type1:find(type) or poke.type2:find(type))
    end))

    return boxStats{
        stats = statsAvg(typedPokes),
        types = {type = type},
        align = 'left'
    }
end
s.TypeAvg, s.typeavg = s.typeAvg, s.typeavg

--[[

Prints out a statistics box given
everything necessary as a parameter:

- hp: HP base stat value
- atk: Attack base stat value
- def: Defense base stat value
- spatk: Special Attack base stat value
- spdef: Special Defense base stat value
- spe: Speed base stat value
= spec: Special stat value, gen 1 only
- type: Primary or only type used for
        background gradient.
- type1: Primary type used for background
        gradient. Defaults to 'type' parameter.
- type2: Secondary type used for background
        gradient.
- bounds: yes/no flag telling whether to
        work out min and max values.
        Defaults to no.
- totalLink: yes/no flag telling whether to
        display the link for other Pokémon
        with the same base sta total.
        Defaults to no.
- listLink: yes/no flag telling whether to
        display the link to all Pokémon
        stats list. Defaults to no.
- align: alignment of the box stat. One of
        'left', 'center', ir 'right'.
        Defaults to 'center'.

Examples:
{{#invoke: Stats | statsBox
|hp = 50
|atk = 220
|def = 210
|spatk = 90
|spdef = 21
|spe = 120
|type = acciaio
|totalLink = yes
|align = left
}}

{{#invoke: Stats | statsBox
|hp = 200
|atk = 40
|def = 80
|spatk = 93
|spdef = 135
|spe = 63
|type1 = elettro
|type2 = fuoco
|bounds = yes
|listLink = yes
}}

--]]
s.statsBox = function(frame)

    -- tonumber() is necessary for stats values
    local p = w.trimAndMap(mw.clone(frame.args), true,
        function(val) return tonumber(val) or val end)

    -- Defaults and boolean conversions
    p.type1 = p.type1 or p.type
    p.bounds = (p.bounds or 'no'):lower() == 'yes'
    p.totalLink = (p.totalLink or 'no'):lower() == 'yes'
    p.listLink = (p.listLink or 'no'):lower() == 'yes'
    p.align = (p.align or 'center')

    --[[
        Base stat total is computed with a fold,
        thus no extra keys are allowed for stats
    --]]
    p.stats = {
        hp = p.hp,
        atk = p.atk,
        def = p.def,
        spatk = p.spatk,
        spdef = p.spdef,
        spe = p.spe,
        spec = p.spec
    }

    return boxStats(p)
end
s.StatsBox, s.statsbox = s.statsBox, s.statsBox

print(s[table.remove(arg, 1)]{args = arg})

return s
