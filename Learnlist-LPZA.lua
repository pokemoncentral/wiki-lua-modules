--[[

Learnlists for Pokémon Legends: Z-A

]]

local l = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local evolib = require('Wikilib-evos')
local formsLib = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local box = require('Box')
local cc = require('ChooseColor')
local css = require('Css')
local learnlistHf = require('Learnlist-hf')
local render = require('Render')
local moves = require("Move-LPZA-data")
local pokes = require("Poké-data")
-- stylua: ignore end

local ALPHA_MOVE_ICON = "[[File:Icona_Alfa_LPA.png|Pokémon alfa|25px]]"

local worstMistake = function(type)
    return type == "coleot" and "coleottero" or type
end

local processInput = function(frame)
    local p = w.trimAll(frame.args)
    local pokeName = mw.text.decode(table.remove(p, 1)):lower()

    local dataIndex = formsLib.nameToDataindex(pokeName, p.form or "")
    local pokeData = multigen.getGen(pokes[dataIndex])

    local pokeTypes = tab.map({ pokeData.type1, pokeData.type2 }, worstMistake)
    local relatedTypes = tab.map(
        tab.merge(
            evolib.formTypesList(dataIndex, 9),
            evolib.evoTypesList(dataIndex, 9)
        ),
        worstMistake
    )

    return p, pokeData, pokeTypes, relatedTypes
end

local computeSTAB = function(moveData, pokeTypes, relatedTypes)
    if moveData.category == "stato" then
        return ""
    elseif tab.search(pokeTypes, moveData.type) then
        return "'''"
    elseif tab.search(relatedTypes, moveData.type) then
        return "''"
    else
        return ""
    end
end

local rightColumns = function(moveData, pokeTypes, relatedTypes, nameNotes)
    return string.interp(
        [=[
| class="black-text" style="padding: 0.1em 0.3em;" | ${stab}[[${name}]]${stab}${nameNotes}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${type}
| class="height-100" style="padding: 0.8ex 0.3ex;" | ${category}
| style="padding: 0.1em 0.3em;" | ${power}
| style="padding: 0.1em 0.3em;" | ${recharge}
| style="padding: 0.1em 0.3em;" | ${range}]=],
        {
            name = moveData.name,
            stab = computeSTAB(moveData, pokeTypes, relatedTypes),
            nameNotes = nameNotes or "",
            type = box.typeBoxLua(moveData.type, { "thick" }),
            category = box.catBoxLua(moveData.category, { "thick" }),
            power = moveData.power or "&mdash;",
            recharge = moveData.recharge,
            range = moveData.range,
        }
    )
end

local levelEntry = function(level, plusLevel, moveName, pokeTypes, relatedTypes)
    return string.interp(
        [=[
|-
| class="black-text" style="padding: 0.1em 0.3em;" | ${level}
| class="black-text" style="padding: 0.1em 0.3em;" | ${plusLevel}
${rightColumns}]=],
        {
            level = level,
            plusLevel = plusLevel,
            rightColumns = rightColumns(
                moves[moveName:lower()],
                pokeTypes,
                relatedTypes
            ),
        }
    )
end

l.level = function(frame)
    local p, pokeData, pokeTypes, relatedTypes = processInput(frame)
    local entryFunc = function(args)
        local level, plusLevel, moveName = table.unpack(args)
        return levelEntry(level, plusLevel, moveName, pokeTypes, relatedTypes)
    end

    -- TODO: add links to "Tempo di recupero" and "Raggio"
    return string.interp(
        [=[
<div class="text-center">
<div class="roundy inline-block max-width-xl-100" style="${bg} padding: 0.2em;">
<div class="flex-row-center-around flex-wrap big-font" style="padding: 0.5ex;"><span class="big-font ${textcolor}">'''Nona&nbsp;generazione: [[Leggende Pokémon: Z-A|LPZA]]'''</span></div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100 no-border-spacing" style="margin-top: 0; background: transparent;"
|- class="text-center ${textcolor}"
! colspan="2" | [[Livello]]
! rowspan="2" | [[Mossa]]
! rowspan="2" | [[Tipo]]
! rowspan="2" | [[Categoria danno|Cat.]]
! rowspan="2" | [[Potenza]]
! rowspan="2" | '''Tempo di recupero'''
! rowspan="2" | '''Raggio'''
|- class="${textcolor}"
! Imp
! [[File:Icona Mossa più.png|Mossa +|25px]]
${levelMoves}
|}
</div>
<div class="text-left small-font ${textcolor}" style="line-height: 1em; padding: 0 0.5ex 1ex;">
${kindrows}
*Il '''grassetto''' indica una mossa che ha il [[bonus di tipo]] quando viene usata da un ${poke}.
*Il ''corsivo'' indica una mossa che ha il bonus di tipo solo quando viene usata da un'evoluzione o una [[Differenze di forma|forma alternativa]] di ${poke}
</div>
</div>
</div>]=],
        {
            textcolor = cc.forModGradBgLua(pokeData.type1, pokeData.type2),
            bg = css.horizGradLua(pokeData),
            levelMoves = render.renderLua(entryFunc, p),
            kindrows = learnlistHf.rowf("level", 9, pokeData.name),
            poke = pokeData.name,
        }
    )
end
l.Level = l.level

local tmEntry = function(tm, moveName, isAlphaPlus, pokeTypes, relatedTypes)
    local moveData = moves[moveName:lower()]
    return string.interp(
        [=[
|-
| class="black-text" style="padding: 0.1em 0.3em;" | [[File:MT_${type}_VI_Sprite_Zaino.png]] [[${tm}]]
${rightColumns}]=],
        {
            tm = tm,
            type = txt.first_uppercase(moveData.type),
            rightColumns = rightColumns(
                moveData,
                pokeTypes,
                relatedTypes,
                isAlphaPlus and (" " .. ALPHA_MOVE_ICON) or ""
            ),
        }
    )
end

l.tm = function(frame)
    local p, pokeData, pokeTypes, relatedTypes = processInput(frame)
    local entryFunc = function(args)
        local tm, moveName, isAlphaPlus = table.unpack(args)
        return tmEntry(
            tm,
            moveName,
            (isAlphaPlus or "no"):lower() == "yes",
            pokeTypes,
            relatedTypes
        )
    end

    -- TODO: add links to "Tempo di recupero" and "Raggio"
    return string.interp(
        [=[
<div class="text-center">
<div class="roundy inline-block max-width-xl-100" style="${bg} padding: 0.2em;">
<div class="flex-row-center-around flex-wrap big-font" style="padding: 0.5ex;"><span class="big-font ${textcolor}">'''Nona&nbsp;generazione: [[Leggende Pokémon: Z-A|LPZA]]'''</span></div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100 no-border-spacing" style="margin-top: 0; background: transparent;"
|- class="text-center ${textcolor}"
! [[MT]]
! [[Mossa]]
! [[Tipo]]
! [[Categoria danno|Cat.]]
! [[Potenza]]
! '''Tempo di recupero'''
! '''Raggio'''
${levelMoves}
|}
</div>
<div class="text-left small-font ${textcolor}" style="line-height: 1em; padding: 0 0.5ex 1ex;">
${kindrows}
*Il '''grassetto''' indica una mossa che ha il [[bonus di tipo]] quando viene usata da un ${poke}.
*Il ''corsivo'' indica una mossa che ha il bonus di tipo solo quando viene usata da un'evoluzione o una [[Differenze di forma|forma alternativa]] di ${poke}
*Un ${alphaIcon} indica che la mossa può essere già conosciuta da un ${poke} [[Pokémon alfa|alfa]] come [[mossa +]].
</div>
</div>
</div>]=],
        {
            textcolor = cc.forModGradBgLua(pokeData.type1, pokeData.type2),
            bg = css.horizGradLua(pokeData),
            levelMoves = render.renderLua(entryFunc, p),
            kindrows = learnlistHf.rowf("tm", 9, pokeData.name),
            alphaIcon = ALPHA_MOVE_ICON,
            poke = pokeData.name,
        }
    )
end
l.Tm = l.tm

local eventEntry = function(event, moveName, pokeTypes, relatedTypes)
    return string.interp(
        [=[
|-
| style="padding: 0.1em 0.3em;" | ${event}
${rightColumns}]=],
        {
            event = event,
            rightColumns = rightColumns(
                moves[moveName:lower()],
                pokeTypes,
                relatedTypes
            ),
        }
    )
end

l.event = function(frame)
    local p, pokeData, pokeTypes, relatedTypes = processInput(frame)
    local entryFunc = function(args)
        local event, moveName = table.unpack(args)
        return eventEntry(event, moveName, pokeTypes, relatedTypes)
    end

    -- TODO: add links to "Tempo di recupero" and "Raggio"
    return string.interp(
        [=[
<div class="text-center">
<div class="roundy inline-block max-width-xl-100" style="${bg} padding: 0.2em;">
<div class="flex-row-center-around flex-wrap big-font" style="padding: 0.5ex;"><span class="big-font ${textcolor}">'''Nona&nbsp;generazione: [[Leggende Pokémon: Z-A|LPZA]]'''</span></div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100 no-border-spacing" style="margin-top: 0; background: transparent;"
|- class="text-center ${textcolor}"
! Evento
! [[Mossa]]
! [[Tipo]]
! [[Categoria danno|Cat.]]
! [[Potenza]]
! '''Tempo di recupero'''
! '''Raggio'''
${levelMoves}
|}
</div>
<div class="text-left small-font ${textcolor}" style="line-height: 1em; padding: 0 0.5ex 1ex;">
${kindrows}
*Il '''grassetto''' indica una mossa che ha il [[bonus di tipo]] quando viene usata da un ${poke}.
*Il ''corsivo'' indica una mossa che ha il bonus di tipo solo quando viene usata da un'evoluzione o una [[Differenze di forma|forma alternativa]] di ${poke}
</div>
</div>
</div>]=],
        {
            textcolor = cc.forModGradBgLua(pokeData.type1, pokeData.type2),
            bg = css.horizGradLua(pokeData),
            levelMoves = render.renderLua(entryFunc, p),
            kindrows = learnlistHf.rowf("event", 9, pokeData.name),
            poke = pokeData.name,
        }
    )
end
l.Event = l.event

return l
