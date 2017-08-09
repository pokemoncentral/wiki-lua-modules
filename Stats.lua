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
local formulas = require('Wikilib-formulas')
local w = require('Wikilib')
local c = require("Colore-data")
local pokes = require("Poké-data")
local stats = require("PokéStats-data")
local wdata = require("Wikilib-data")

local mw = require('mw')

local statNames = {
    hp = 'PS',
    atk = 'Attacco',
    def = 'Difesa',
    spatk = 'Att. Sp.',
    spdef = 'Dif. Sp.',
    spe = 'Velocità'
}

local statLinks = mw.clone(statNames)
statLinks.spatk = 'Attacco_Speciale'
statLinks.spdef = 'Difesa_Speciale'

local statRow = function(stat, value, isRoundy, computeBounds)
    local bounds = ''
    local roundy = {left = '', right = '',
        boundsLeft = '', boundsRight = ''}

    if isRoundy then
        local edge = isRoundy:sub(1, 1)
        roundy.left = table.concat{'class="roundy', edge, 'l" '}
        roundy.right = table.concat{'class="roundy', edge, 'r" '}

        if computeBounds then
            roundy.boundsLeft = table.concat{'roundy', edge, 'l '}
            roundy.boundsRight = table.concat{'roundy', edge, 'r '}
        end
    end

    if computeBounds then
        local calcStat = stat == 'hp' and formulas.hp or formulas.stat
        bounds = string.interp([=[

| class="hidden-xs" | &nbsp;
| class="${rleft}text-small hidden-xs" style="padding: 0.3ex 0.8ex; background: #${bg};" | ${min50} - ${max50}
| class="${rright}text-small hidden-xs" style="padding: 0.3ex 0.8ex; background: #${bg};" | ${min100} - ${max100}]=],
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

    return string.interp([=[|-
| ${rleft}style="width: 5.5em; padding: 0.3ex 0.8ex; background: #${light};" | [[Statistiche#${link}|<span style="color: #${normale};">${stat}</span>]]
| ${rright}style="padding: 0.3ex 0.8ex; background: #${light};" | ${statBar}${bounds}]=],
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

local boxStats = function(stats, types, computeBounds, totalLink)
    local tot = table.fold(stats, 0, function(a, b)
        return a + b end)

    local interpVal = {
        width = ' width-xl-40 width-md-50 width-sm-60 width-xs-100',
        bg = css.horizGradLua(types),
        rs = '',
        values = '',
        stats = w.mapAndConcat(wdata.statsOrder, '\n',
            function(stat, index)
                local roundy = false
                if index == 1 then
                    roundy = 'top'
                elseif index == table.getn(wdata.statsOrder) then
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
        interpVal.values = [=[

! colspan="3" class="hidden-xs" style="padding: 0.3ex 0.8ex;" | Valori
|-
! class="hidden-xs" style="width: 0.1ex; padding: 0;" | &nbsp;
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv. 50
! class="hidden-xs text-small" style="padding: 0.3ex 0.8ex;" | Lv.100]=]
        interpVal.footer = [=[

| colspan="3" class="hidden-xs" | &nbsp;
|-
| colspan="5" class="hidden-xs text-left text-small" |
* Le statistiche minime sono calcolate con 0 [[PA]], VI pari a 0, e una [[natura]] sfavorevole.
* Le [[statistiche]] massime sono calcolate 252 PA, [[VI]] pari a 31, e una natura favorevole.]=]
    end

    if totalLink then
        interpVal.width = ''
        interpVal.total = string.interp([=[<div class="flex flex-nowrap flex-row flex-main-start flex-items-center">${tot}<span class="text-small" style="margin-left: 2ex;">[[:Categoria:Pokémon con statistiche base totali di ${tot}|<span style="color: initial;">Altri Pokémon con questo totale</span>]]</span></div>]=], {tot = tot})
    end

    return string.interp([=[{| class="roundy pull-center text-center${width}" style="border-spacing: 0 0.3ex; padding: 0.3ex 0.5ex; font-weight: bolder; ${bg};"
! colspan="2" ${rs}style="padding: 0.3ex 0.8ex;" | Statistiche base${values}
${stats}
|-
| style="padding: 0.3ex 0.8ex;" | Totale
| class="text-left" style="padding: 0.3ex 0.8ex 0.3ex 1.8ex;" | ${total}${footer}
|}]=], interpVal)
end

s.statBarLua = function(stat, value)
    return string.interp([=[<div class="roundyright text-left" style="margin-left: 1ex; width: calc(1em + ${width}%); ${bg}; color: #${dark};">'''${val}'''</div>]=],
        {
            width = value / 255 * 100,
            bg = css.horizGradLua{type = stat},
            dark = c[stat].dark,
            val = value
        })
end
s.stat_bar_lua = s.statBarLua

s.statBar = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    return s.statBarLua(p.stat or p[1], p.value or p[2])
end

s.pokeStats = function(frame)
    local poke = string.trim(frame.args[1]):lower()

    return boxStats(stats[poke], pokes[poke], true, true)
end
s.PokeStats = s.pokeStats

print(s.PokeStats{args = {arg[1]}})

return s
