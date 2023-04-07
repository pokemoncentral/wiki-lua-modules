--[[

This module displays wikicode for anything
related to a set of values for all six statistics.
So far, it can display stats for a single
Pokémon, the average for a single type and
user-supplied values

--]]

local s = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local formUtil = require('Wikilib-forms')
local formulas = require('Wikilib-formulas')
local gamesUtil = require('Wikilib-games')
local genUtil = require('Wikilib-gens')
local list = require('Wikilib-lists')
local mg = require('Wikilib-multigen')
local oop = require('Wikilib-oop')
local statsUtil = require('Wikilib-stats')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local css = require('Css')
local cc = require('ChooseColor')
local alt = require("AltForms-data")
local c = require("Colore-data")
local gendata = require("Gens-data")
local pokes = require('Poké-data')
local stats = require("PokéStats-data")
-- stylua: ignore end

-- Mapping of stat keys to user-interface names
local statNames = {
    hp = "PS",
    atk = "Attacco",
    def = "Difesa",
    spatk = "Att. Sp.",
    spdef = "Dif. Sp.",
    spec = "Speciali",
    spe = "Velocità",
}

-- Mapping of stat keys to URL fragments in 'Statistiche' page
local statLinks = mw.clone(statNames)
statLinks.spatk = "Attacco_Speciale"
statLinks.spdef = "Difesa_Speciale"

-- Long wikicode strings making functions unreadable
local strings = {
    boundsFooter = [=[

* Le [[statistiche]] minime sono calcolate con ${minParams}.
* Le statistiche massime sono calcolate ${maxParams}.]=],

    boxFormWrapper = [[==== ${title} ====
<div class="${collapse}">
${box}
</div>]],

    boxStats = [=[{| class="roundy text-center${align}${width} ${textcolor}" style="border-spacing: 0 0.3ex; padding: 0.3ex 0.5ex; font-weight: bolder; ${bg};"
! colspan="2" ${rs}style="padding: 0.3ex 0.8ex;" | Statistiche base${values}
${stats}
|-
| style="padding: 0.3ex 0.8ex;" | Totale
| class="text-left" style="padding: 0.3ex 0.8ex 0.3ex 1.8ex;" | ${total}${footer}
|}]=],

    catSpecToBoth = "[[Categoria:Pokémon la cui statistica Speciali è diventata sia Attacco Speciale che Difesa Speciale|${display}]]",

    catSpecToSpatk = "[[Categoria:Pokémon la cui statistica Speciali è diventata Attacco Speciale|${display}]]",

    catSpecToSpdef = "[[Categoria:Pokémon la cui statistica Speciali è diventata Difesa Speciale|${display}]]",

    catStatsChanged = "[[Categoria:Pokémon le cui statistiche base sono cambiate in ${gen} generazione|${display}]]",

    catTotal = "[[Categoria:Pokémon con statistiche base totali di ${tot}|${display}]]",

    catStatsEqual = "[[Categoria:Pokémon con lo stesso valore in tutte le statistiche base|${display}]]",

    catUniqueBST = "[[Categoria:Pokémon con statistiche base totali uniche|${display}]]",

    footer = [=[

| colspan="3" class="hidden-xs" | &nbsp;
|-
| colspan="5" class="hidden-xs text-left text-small" style="font-weight: normal;" | ${content}]=],

    headerValues = [=[

! colspan="3" class="min-width-xl-30 hidden-xs" style="padding: 0.3ex 0.8ex;" | Valori
|-
! class="hidden-xs" style="width: 0.1ex; padding: 0;" | &nbsp;
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv. 50
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv. 100]=],

    oldValueFooter = [=[

* La statistica <span style="background: #${stat_color}; padding: 0 0.3ex;">${stat}</span> di questo Pokémon ${when} era pari a '''${old_value}'''.]=],

    singleGenFooter = [=[in [[${gen} generazione]]]=],
    beforeGenFooter = [=[prima della [[${gen} generazione]]]=],
    betweenGenFooter = [=[tra la [[${startGen} generazione|${startGen}]] e la [[${endGen} generazione]]]=],

    listFooter = [=[

* Le statistiche di questo Pokémon sono cambiate nel corso delle generazioni. Tutti i valori sono disponibili [[Elenco Pokémon per statistiche base|qui]]. ]=],

    statBar = [=[<div class="roundyright text-left" style="width: calc(1em + ${width}%); color: #${dark}; ${bg};">'''${val}'''</div>]=],

    statBounds = [=[

| class="hidden-xs" | &nbsp;
| class="${rleft}text-small hidden-xs black-text" style="padding: 0.3ex 0.8ex; white-space: nowrap; background: #${bg};" | ${min50}—${max50}
| class="${rright}text-small hidden-xs black-text" style="padding: 0.3ex 0.8ex; white-space: nowrap; background: #${bg};" | ${min100}—${max100}]=],

    statRow = [=[|-
| ${rleft}style="width: 5.5em; padding: 0.3ex 0.8ex; background: #${light};" | [[Statistiche#${link}|<span style="color: #${normale};">${stat}</span>]]
| ${rright}style="padding: 0.3ex 0.8ex 0.3ex 1.8ex; min-width: 9em; background: #${light};" | ${statBar}${bounds}]=],

    totalLink = [=[<div class="flex flex-nowrap flex-row flex-main-start flex-items-center">${tot}<span class="text-small text-center" style="margin-left: 2ex;">[[:Categoria:Pokémon con statistiche base totali di ${tot}|Altri Pokémon con questo totale]]</span></div>]=],
}

--[[

Returns the statistics-related categories
a Pokémon should have. As usual, the Pokémon
is to be given as the name + abbreviation
string found in data modules.

--]]
local makeCategories = function(poke, tot)
    --[[
        Displaying page in the category with
        the form name.
    --]]
    local baseName, abbr = formUtil.getNameAbbr(poke)
    local catInterp = {
        display = table.concat(
            tab.unique({
                pokes[poke].name,
                alt[baseName] and alt[baseName].names[abbr] or nil,
            }),
            " "
        ),
    }

    -- Closure, as it needs catInterp
    local interpCat = function(catString, interpVal)
        interpVal = interpVal and tab.merge(catInterp, interpVal) or catInterp
        return txt.interp(catString, interpVal)
    end

    local categories = { interpCat(strings.catTotal, { tot = tot }) }

    -- Handling gen II special split, if necessary
    if stats[poke].spec then
        local gen2Stats = mg.getGen(stats[poke], 2)
        if
            gen2Stats.spec == gen2Stats.spatk
            and gen2Stats.spec == gen2Stats.spdef
        then
            table.insert(categories, interpCat(strings.catSpecToBoth))
        elseif gen2Stats.spec == gen2Stats.spatk then
            table.insert(categories, interpCat(strings.catSpecToSpatk))
        elseif gen2Stats.spec == gen2Stats.spdef then
            table.insert(categories, interpCat(strings.catSpecToSpdef))
        end
    end

    --[[
        Handling base stats changes in generations.
        Starting from 6 because since gen II until
        gen V stats were untouched, and we handled
        gen II earlier on.
    --]]
    for gen = 6, gendata.latest do
        local changedInGen = tab.any(stats[poke], function(val)
            return type(val) == "table"
                and multigen.getfirstgen(val) ~= gen
                and val[gen]
        end)
        if changedInGen then
            table.insert(
                categories,
                interpCat(strings.catStatsChanged, { gen = gendata[gen].ext })
            )
            local genTotal =
                statsUtil.statsSum(statsUtil.getStatsGen(stats[poke], gen - 1))
            table.insert(
                categories,
                interpCat(strings.catTotal, { tot = genTotal })
            )
        end
    end

    -- Category for Pokémon with all the base stats equal
    do
        local firstStat = mg.getGenValue(stats[poke].atk)
        local equalFirst = function(val)
            return mg.getGenValue(val) == firstStat
        end
        if tab.all(stats[poke], equalFirst) then
            table.insert(categories, interpCat(strings.catStatsEqual))
        end
    end

    -- Category for Pokémon with unique bst
    do
        local dupe = tab.any(stats, function(data, otherPoke)
            local otherTot =
                statsUtil.statsSum(statsUtil.getStatsGen(data, gendata.latest))
            return not txt.parseInt(otherPoke)
                and poke ~= otherPoke
                and tot == otherTot
        end)
        if not dupe then
            table.insert(categories, interpCat(strings.catUniqueBST))
        end
    end

    return table.concat(categories)
end

--[[

Computes the avreage stats of the Pokémon
whose names are given, for the provided generation.
Names must be the name + abbreviation
combination seen in all data modules.

--]]
local statsAvg = function(pokeNames, gen)
    local avgStats = statsUtil.getStatsGen(
        { hp = 0, atk = 0, def = 0, spatk = 0, spdef = 0, spe = 0, spec = 0 },
        gen
    )

    -- Computing sum for every stat
    avgStats = tab.fold(pokeNames, avgStats, function(avgStats, poke)
        local pokeStats = statsUtil.getStatsGen(stats[poke], gen)
        return tab.map(avgStats, function(stat, statName)
            return stat + pokeStats[statName]
        end)
    end)

    -- Actually computing average
    local pokesCount = tab.getn(pokeNames)
    return tab.map(avgStats, function(stat)
        return stat / pokesCount
    end)
end

--[[

Prints a row of the stats box for a single stat.
It's fed the stat name, its value, the roundyness
and a generation; the latter two default to false.
The meaning of roundyness values is:
    - anything evaluating to false - no roundyness
    - 'top' - cells rounded at one top corner
    - 'bottom' - cells rounded at bottom corners
The interpretation of the generation is:
    - when valid (a number between 1 and `latest`),
        it computest min and max values for the
        stat, using that generation formula.
    - when not valid, (a non-number, or a number
        is less than 1 or more than `latest`),
        nothing is computed

--]]
local statRow = function(stat, value, gen, roundyness)
    local computeBounds = genUtil.isValidGen(gen)

    --[[
        Interpolation values for basic case,
        which means no roundyness and no
        min-max calculation.
    --]]
    local bounds = ""
    local roundy = { left = "", right = "", boundsLeft = "", boundsRight = "" }

    if roundyness then
        local edge = roundyness:sub(1, 1)
        roundy.left = table.concat({ 'class="roundy', edge, 'l" ' })
        roundy.right = table.concat({ 'class="roundy', edge, 'r" ' })

        if computeBounds then
            roundy.boundsLeft = table.concat({ "roundy", edge, "l " })
            roundy.boundsRight = table.concat({ "roundy", edge, "r " })
        end
    end

    if computeBounds then
        local interpVal

        -- Shedinja's HP are not worth to be handled in any other way
        if value == 1 then
            interpVal = {
                rleft = roundy.boundsLeft,
                bg = c[stat].light,
                min50 = 1,
                max50 = 1,
                rright = roundy.boundsRight,
                min100 = 1,
                max100 = 1,
            }

        -- Any normal stat calculation
        else
            local calcStat =
                formulas.stats[gen][stat == "hp" and "hp" or "anyOther"]
            local maxIV, maxEV = statsUtil.ivEvMax(gen)

            --[[
                Natures are ignored for generations before third and for HP
                because the function has one less argument
            --]]
            interpVal = {
                rleft = roundy.boundsLeft,
                bg = c[stat].light,
                min50 = calcStat(0, value, 0, 50, 0.9),
                max50 = calcStat(maxIV, value, maxEV, 50, 1.1),
                rright = roundy.boundsRight,
                min100 = calcStat(0, value, 0, 100, 0.9),
                max100 = calcStat(maxIV, value, maxEV, 100, 1.1),
            }
        end

        bounds = txt.interp(strings.statBounds, interpVal)
    end

    return txt.interp(strings.statRow, {
        rleft = roundy.left,
        light = c[stat].light,
        link = statLinks[stat],
        normale = c[stat].normale,
        stat = statNames[stat],
        rright = roundy.right,
        statBar = s.statBarLua(stat, value),
        bounds = bounds,
    })
end

--[[

Prints all the footer lines needed for a stat changed over time.
It takes the stat name and the stat table (in multigen format).

--]]
local makeStatFooterLines = function(stat, values)
    local footerLines = {}
    local spans = mg.getGenSpan(values)
    for k, v in ipairs(spans) do ---@diagnostic disable-line: param-type-mismatch
        if k < #spans then -- the last value shouldn't be in the footer
            local interpVal = {
                stat_color = c[stat].normale,
                stat = statLinks[stat]:gsub("_", " "),
                old_value = v.val,
            }
            if v.first == v.last then
                -- Single generation span
                interpVal.when = txt.interp(strings.singleGenFooter, {
                    gen = gendata[v.first].ext,
                })
            elseif k == 1 then
                -- The first element has a different text
                interpVal.when = txt.interp(strings.beforeGenFooter, {
                    gen = gendata[v.last + 1].ext,
                })
            else
                interpVal.when = txt.interp(strings.betweenGenFooter, {
                    startGen = gendata[v.first].ext,
                    endGen = gendata[v.last].ext,
                })
            end
            local line = txt.interp(strings.oldValueFooter, interpVal)
            footerLines[k] = line
        end
    end
    return table.concat(footerLines)
end

--[[

This class represents a statistics box for
a single Pokémon. Forms having the same stats
share can a single box, their names appearing
as a label for the box itself.

--]]
local PokeStatBox = oop.makeClass(list.Labelled)

--[[

Class constructor: as per makeFormsLabelledBoxes
specifications, it takes the name of a Pokémon,
with an appended abbreviations for alternative
forms, a form extended name, and a table with the
following key-value pairs:
    - gen: the generation for which statistics
            and min-max values will be worked out.
    - noCats: whether or not stats-related
            categories will be printed.
It will return nil, complying to makeFormsLabelledBoxes,
if no statistics are defined for the Pokémon
or if it is not present in the given generation.

--]]
PokeStatBox.new = function(poke, formExtName, args)
    local gen, noCats = args.gen, args.noCats

    --[[
        Aborting entry: no stats data for the Pokémon
        or Pokémon/form not in generation

        Actually we keep out of gen Pokés/forms because
        they are so few that there isn't really any
        advantage in skipping them
    --]]
    if not stats[poke] then
        -- or not gamesUtil.isInGen(poke, gen) then
        return nil
    end

    local this = PokeStatBox.super.new(formExtName)

    --[[
        Shared boxes have base form types,
        which are retrieved if necessary
        using the base form name.
    --]]
    this.baseFormName = formUtil.getNameAbbr(poke)

    this.gen = gen
    this.listLink = statsUtil.didStatsChange(stats[poke])
    this.poke = not noCats and poke
    this.stats = statsUtil.getStatsGen(stats[poke], gen)
    this.multigenStats = tab.map(stats[poke], function(val, key)
        if key == "spec" then
            -- Handling stats speciali
            return { [1] = val, [2] = 0 }
        end
        return type(val) == "table" and val or nil
    end)

    local pokeData = multigen.getGen(pokes[poke])
    this.types = { type1 = pokeData.type1, type2 = pokeData.type2 }

    return setmetatable(this, PokeStatBox)
end

-- Two equal stat boxes have the same stats
PokeStatBox.__eq = function(a, b)
    return tab.equal(a.stats, b.stats)
end

--[[

Wikicode for Pokémon stat boxes: min-max values
and a link to other Pokémon with the same base
stat total are displayed withing the standard
stats box. If there are any labels, they are
displayed in a heading, and the box is hidden
according to the collapsed status. Statistics
related categories are also printed.

--]]
PokeStatBox.__tostring = function(this)
    local statsTot = statsUtil.statsSum(this.stats)
    local box = s.boxStats({
        stats = this.stats,
        tot = statsTot,
        types = this.types,
        align = "center",
        gen = this.gen,
        totalLink = true,
        listLink = false,
        multigenStats = this.multigenStats,
    }) .. (not this.poke and "" or makeCategories(this.poke, statsTot))

    if not PokeStatBox.super.hasLabel(this) then
        return box
    end

    return txt.interp(strings.boxFormWrapper, {
        title = mw.text.listToText(this.labels),
        collapse = this.collapse or "",
        box = box,
    })
end

--[[

This method adds a form label to the current list.
The superclass overriding is necessary to fetch
base form types, which is the rule for shared boxes.

--]]
PokeStatBox.addLabel = function(this, label)
    PokeStatBox.super.addLabel(this, label)

    local pokeData = multigen.getGen(pokes[this.baseFormName])
    this.types = { type1 = pokeData.type1, type2 = pokeData.type2 }
end

-- Sets the collapsed status
PokeStatBox.setCollapse = function(this, collapse)
    this.collapse = collapse
end

--[[

Prints a statistics box. Arguments are named:
    - stats: table with statistics to be printed,
            in the format as PokéStats/data.
    - tot: base stats total, so as to avoid
            multiple computations. Completely
            optional, if not passed will be
            computed from the passed stats.
    - types: table of type names, in a format
            accepted by css module
    - align: alignemnt of the table. One of
            'center', 'left' or 'right'
    - gen: generation, used for statistics min-max
            values calculation. When a non-number,
            or an invalid generation, nothing is
            computed. Defaults to false.
    - totalLink: if the link to other Pokémon with
            the same base stat total is to be displayed.
            Defaults to false.
    - listLink: if the link to all Pokémon by stats
            list page is to be displayed.
            Defaults to false.
    - multigenStats: table of stats with multigen values for the footer.
            The keys are the stat names, the values the multigen tables

--]]
s.boxStats = function(args)
    local stats, types = args.stats, args.types
    local tot = txt.printNumber(args.tot or statsUtil.statsSum(stats))
    local gen, align = args.gen, args.align
    local totalLink, listLink = args.totalLink, args.listLink
    local multigenStats = args.multigenStats

    local computeBounds = genUtil.isValidGen(gen)

    --[[
        Need to get rid of non-existent stats because no
        holes are allowed when concatenating later on
    --]]
    local statsOrder = statsUtil.statsOrder[gen or (stats.spec and 1 or 2)]
    local statRows = tab.filter(statsOrder, function(stat)
        return stats[stat]
    end)

    --[[
        Interpolation values for basic case,
        which means no min-max calculation
        and no link to other Pokémon with the
        same base stat total displayed.
    --]]
    local interpVal = {
        align = align == "left" and "" or " pull-" .. align,
        width = " width-xl-30 width-md-50 width-sm-60 width-xs-100",
        textcolor = cc.forModGradBgLua(
            types["type1"] or "pcwiki",
            types["type2"] or types["type1"] or "pcwiki"
        ),
        bg = css.horizGradLua(types),
        rs = "",
        values = "",
        stats = w.mapAndConcat(statRows, "\n", function(stat, index)
            local roundy
            if index == 1 then
                roundy = "top"
            elseif index == tab.getn(statRows) then
                roundy = "bottom"
            end

            return statRow(stat, stats[stat], gen, roundy)
        end),
        total = tot,
        footer = "",
    }

    if computeBounds then
        local maxIV, maxEV = statsUtil.ivEvMax(gen)

        interpVal.width = ""
        interpVal.rs = 'rowspan="2" '
        interpVal.values = strings.headerValues
        interpVal.footer = txt.interp(strings.boundsFooter, {
            minParams = mw.text.listToText({
                "0 [[Punti base|PA]]",
                "[[Punti individuali|VI]] pari a 0",
                gen > 2 and "una [[natura]] sfavorevole" or nil,
            }),

            maxParams = mw.text.listToText({
                maxEV .. " PA",
                "VI pari a " .. maxIV,
                gen > 2 and "una natura favorevole" or nil,
            }),
        })
    end

    if totalLink then
        interpVal.width = ""
        interpVal.total = txt.interp(strings.totalLink, { tot = tot })
    end

    if listLink then
        interpVal.footer = interpVal.footer .. strings.listFooter
    end

    if multigenStats then
        multigenStats = tab.map(multigenStats, function(val, key)
            return makeStatFooterLines(key, val)
        end)
        local multigenFooter = {}
        -- Handling stat speciali
        table.insert(multigenFooter, multigenStats.spec)
        for _, stat in ipairs(statsUtil.statsOrder[2]) do
            -- Doesn't insert non multigen stats because their value is nil
            table.insert(multigenFooter, multigenStats[stat])
        end
        interpVal.footer = interpVal.footer .. table.concat(multigenFooter)
    end

    if interpVal.footer ~= "" then
        interpVal.footer =
            txt.interp(strings.footer, { content = interpVal.footer })
    end

    return txt.interp(strings.boxStats, interpVal)
end
s.boxstats, s.box_stats = s.boxStats, s.boxStats

--[[

Returns the wikicode for a statistic bar: it
has the value inside, a gradient as a background
and its width is proportional to the value,
relatively to 255.

--]]
s.statBarLua = function(stat, value)
    return txt.interp(strings.statBar, {
        width = value / 270 * 100,
        bg = css.horizGradLua({ type = stat }),
        dark = c[stat].dark,
        val = txt.printNumber(value),
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
the same base stat total.
Statistics related categories are printed by default,
but they can be turned off by passing 'yes' as a
fourth parameter, or named 'noCat'.
Alternative forms are included by default, although
it is possible to display stats for a single form
only by passing 'yes' as a second argument, or named
'noForms'.
Statistic values are that of the latest generation
by default, unless a third argument, or named 'gen',
is passed with another number.

Examples:

All forms:
{{#invoke: Stats | PokeStats | Rotom }}

IN POKÉMON PAGES ONLY!
{{#invoke: Stats | PokeStats | {{BASEPAGENAME}} }}

Older generations and no category:
{{#invoke: Stats | PokeStats | Gengar | | 5 | yes }}
{{#invoke: Stats | PokeStats | Gengar | gen = 5 | noCat = yes }}


--]]
s.pokeStats = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    local poke = string.lower(mw.text.decode(p[1] or p.poke))
    local noForms = (p[2] or p.noForms or "no"):lower() == "yes"
    local gen = tonumber(p[3] or p.gen) or gendata.latest
    local noCat = (p[4] or p.noCat or "no"):lower() == "yes"
    local boxArgs = { gen = gen, noCats = noCat }

    if noForms then
        return tostring(PokeStatBox.new(poke, nil, boxArgs))
    else
        return list.makeFormsLabelledBoxes({
            name = poke,
            makeBox = PokeStatBox.new,
            boxArgs = boxArgs,
            printBoxes = function(boxes)
                -- No collapse and extra markup for single boxes
                if #boxes == 1 then
                    return tostring(boxes[1])
                end

                --[[
                    All boxes collapsible and all but the
                    first collapsed by default
                --]]
                return w.mapAndConcat(boxes, function(box, key)
                    box:setCollapse(
                        "mw-collapsible" .. (key == 1 and "" or " mw-collapsed")
                    )
                    return tostring(box)
                end, "\n")
            end,
        })
    end
end
s.PokeStats, s["pokéStats"], s["PokéStats"] =
    s.pokeStats, s.pokeStats, s.pokeStats

--[[

Prints the average of the statistics for Pokémon
of a specific type, alternative forms included,
as a statistics box. A generation can be specified,
and the latest one will be used if not. Minimum
and maximum values for each statistic are not
displayed, and neither is the link to other Pokémon
with the same base stat total.

Examples:

{{#invoke: Stats | typeAvg | Elettro }}

IN TYPE PAGES ONLY!
{{#invoke: Stats | typeAvg | {{BASEPAGENAME}} }}

With generation:
{{#invoke Stats | typeAvg | Fuoco | 4 }}

--]]
s.typeAvg = function(frame)
    local type = txt.trim(frame.args[1]):lower()
    local gen = tonumber(txt.trim(frame.args[2])) or gendata.latest

    --[[
        string.find is used instead of plain equality
        because of coleot/coleottero dualism. stats[poke]
        is checked first because it might be that
        statistics data and Pokémon data are not updated
        together consistently.
    --]]
    local typedPokes = tab.keys(tab.filter(pokes, function(data, poke)
        data = multigen.getGen(data)
        return stats[poke]
            and not txt.parseInt(poke)
            and gamesUtil.isInGen(poke, gen)
            and (data.type1:find(type) or data.type2:find(type))
    end))

    return s.boxStats({
        stats = statsAvg(typedPokes, gen),
        types = { type1 = type },
        align = "left",
    })
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
- gen: generation, only meaningful for min
        and max statistic calculation.
        Defaults to the latest one.
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
|gen = 3
|listLink = yes
}}

--]]
s.statsBox = function(frame)
    -- tonumber() is necessary for stats values
    local p = w.trimAndMap(mw.clone(frame.args), true, function(val)
        return tonumber(val) or val
    end)

    local bounds = (p.bounds or "no"):lower() == "yes"
    p.bounds = nil

    p.stats = {
        hp = p.hp,
        atk = p.atk,
        def = p.def,
        spatk = p.spatk,
        spdef = p.spdef,
        spe = p.spe,
        spec = p.spec,
    }
    p.types = {
        type = p.type,
        type1 = p.type1 or p.type,
        type2 = p.type2,
    }
    p.gen = bounds and (p.gen or gendata.latest)
    p.totalLink = (p.totalLink or "no"):lower() == "yes" ---@diagnostic disable-line: param-type-mismatch
    p.listLink = (p.listLink or "no"):lower() == "yes" ---@diagnostic disable-line: param-type-mismatch
    p.align = (p.align or "center")

    return s.boxStats(p)
end
s.StatsBox, s.statsbox = s.statsBox, s.statsBox

return s
