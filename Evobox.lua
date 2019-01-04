--[[

Displays the box containing the evolutionary line of a Pokémon.

Sadly right now we don't have a data module for evolutions, so this module
takes a lot of arguments. It's been introduced only in order to make use of
variables.

--]]

local eb = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local form = require('Wikilib-forms')
local evolib = require('Wikilib-evos')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local links = require('Links')
local ms = require('MiniSprite')
local css = require('Css')
local spr = require('Spr')
local c = require("Colore-data")
local altforms = require("AltForms-data")
local useless = require("UselessForms-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local evodata = require("Evo-data")
local wdata = require("Wikilib-data")

-- ============================= General functions =============================

--[[

Utility strings

--]]

eb.strings = {
    BOX_CONTAINER = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-stretch inline-block-md width-sm-100" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],
    BOX_CONTAINER_UNRESPONSIVE = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-center width-sm-100" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],

    ROW_ONE = [=[<div class="vert-middle">${box1}</div>]=],
    ROW_TWO = [=[<div class="flex-md flex-row flex-nowrap flex-items-center"><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box1}</div><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box2}</div></div>]=],
    ROW_THREE = [=[<div><div class="grid" style="border-collapse: separate; border-spacing: 0.5ex 0;">${boxes}</div></div>]=],

    GRID_ROW = [=[<div><div class="align-middle">${arrow}</div><div class="align-middle">${box}</div></div>]=],

    BOX_POKEMON = [=[<div class="text-center" style="margin: 0.5ex;">${notes}
<div class="roundy-full inline-block img-fluid" style="padding: 1ex; background: #fff;"><div class="roundy-full" style="padding: 0.5ex; ${background}">${spr}</div></div>
<div class="small-text" style="padding-top: 0.5ex;">${phase}</div>
<div>
<div class="black-text">[[${name}|${shownName}]]</div>
<div class="small-text hidden-sm">${type1rect}${type2rect}</div>
</div>
</div>]=],

    BOX_ARROW_INFOLESS = [=[${img}<div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],
    BOX_ARROW_UNRESPONSIVE = [=[${img}<div class="inline-block width-xl-100 black-text">${evodesc}${info}</div><div>${desktoparrow}</div>]=],
    BOX_ARROW = [=[${img}<div class="inline-block width-xl-100 black-text">${evodesc}${info}</div><div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],

    SINGLE_ARROW = [=[<div style="margin: 1em 0.5em;">${boxarrow}</div>]=],
    DOUBLE_ARROW = [=[<div class="inline-block-md"><div class="flex-md flex-row flex-nowrap flex-items-center" style="margin: 1em 0;"><div class="width-md-50" style="padding: 1em;">${boxarrow1}</div><div class="width-md-50" style="padding: 1em;">${boxarrow2}</div></div></div>]=],

    SMALL_TEXT_NEWLINE = [=[<div class="small-text">${text}</div>]=],
}

eb.strings.desktoparrows = {
    normal = '&rarr;',
    fixed = '&rarr;',
    reverse = '&larr;',
    double = '&harr;'
}

eb.strings.mobilearrows = {
    normal = '&darr;',
    fixed = '&rarr;',
    reverse = '&uarr;',
    double = '↕'
}

--[[

Returns a single Pokémon box, with notes, image, name, evolutionary phase and
types. Requires many details.

The parameters are named:
    - notes: (optional) any additional note to be printed above the image
    - type1, type2: the two types of the Pokémon. Both mandatory
    - spr: the full link to the sprite of the Pokémon
    - phase: (optional) the evolutionary phase ("Prima evoluzione", etc...).
            Defaults to "Non si evolve"
    - name: the name of the Pokémon (for the link)
    - shownName: (optional) the name that will be displayed

--]]
eb.boxPokemon = function(args)
    return string.interp(eb.strings.BOX_POKEMON, {
        notes = args.notes and string.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = args.notes
        }) or '',
        background = css.radialGradLua{ type1 = args.type1, type2 = args.type2 },
        spr = args.spr,
        phase = args.phase or "Non si evolve",
        name = args.name,
        shownName = args.shownName or args.name,
        type1rect = links.colorType(args.type1, c[args.type1].dark),
        type2rect = args.type2 ~= args.type1
                    and links.colorType(args.type2, c[args.type2].dark)
                    or ''
    })
end


--[[

The followings are utility functions to create the elements of eb.boxArrow.
The first function takes a parameter and returns a function that interps its
own parameter in the text passed to the generating function, with name "param".
The second is almost the same as the first one, but the text is inserted into a
div.small-text. The third is the nil constant function.

--]]

local methodsFunctionGenerator = function(text)
    return function(param)
        return string.interp(text, { param = param })
    end
end

local smallMethodsFunctionGenerator = function(text)
    text = string.interp(eb.strings.SMALL_TEXT_NEWLINE, { text = text })
    return function(param)
        return string.interp(text, { param = param })
    end
end

local nilConst = function()
    return nil
end

--[[

Those tables contain images and texts related to evomethods. Their elements are
functions that, called with the value of that methods' key (from the data
module) as the only parameter returns the string to insert in the result.

--]]

eb.boxArrow = { img = {}, desc = {} }
eb.boxArrow.img.methods = {
    [evodata.methods.OTHER] = methodsFunctionGenerator(''),
    [evodata.methods.LEVEL] = methodsFunctionGenerator(links.bag('Caramella rara')),
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator(links.bag('Calmanella')),
    [evodata.methods.STONE] = methodsFunctionGenerator(links.bag('${param}')),
    [evodata.methods.TRADE] = methodsFunctionGenerator(links.bag('Blocco Amici')),
    [evodata.methods.BREED] = methodsFunctionGenerator(ms.staticLua('Uovo')),
}
eb.boxArrow.img.conditions = {
    [evodata.conditions.OTHER] = nilConst,
    [evodata.conditions.TIME] = nilConst,
    [evodata.conditions.ITEM] = methodsFunctionGenerator(links.bag('${param}')),
    [evodata.conditions.LOCATION] = methodsFunctionGenerator(links.bag('Mappa città')),
    [evodata.conditions.MOVE] = function(movename)
        -- Takes move name and gets move type for the MT image
        local movedata = moves[movename:lower()]
        return links.bag('MT ' .. string.fu(movedata.type))
    end,
    [evodata.conditions.GENDER] = nilConst,
    [evodata.conditions.TRADED_FOR] = function(ndex)
        return ms.staticLua(ndex)
    end
}

eb.boxArrow.desc.methods = {
    [evodata.methods.OTHER] = methodsFunctionGenerator('${param}'),
    [evodata.methods.LEVEL] = function(level)
        if not level then
            return '[[Livello|Aumento di livello]]'
        end
        return table.concat{ '[[Livello|Livello ', level, ']]' }
    end,
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator('[[Felicità]]'),
    [evodata.methods.STONE] = methodsFunctionGenerator('${param}'),
    [evodata.methods.TRADE] = methodsFunctionGenerator('[[Scambio]]'),
    [evodata.methods.BREED] = methodsFunctionGenerator('[[Accoppiamento Pokémon|Accoppiamento]]'),
}
eb.boxArrow.desc.conditions = {
    [evodata.conditions.OTHER] = smallMethodsFunctionGenerator('${param}'),
    [evodata.conditions.TIME] = smallMethodsFunctionGenerator('(${param})'),
    [evodata.conditions.ITEM] = smallMethodsFunctionGenerator('tenendo [[${param}]]'),
    [evodata.conditions.LOCATION] = smallMethodsFunctionGenerator('presso: [[${param}]]'),
    [evodata.conditions.MOVE] = function(movename)
        return string.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = table.concat{ 'avendo appreso [[', movename, ']]' }
        })
    end,
    [evodata.conditions.GENDER] = smallMethodsFunctionGenerator('(${param})'),
    [evodata.conditions.TRADED_FOR] = function(ndex)
            local name = pokes[tonumber(ndex)].name
            return table.concat{ 'per [[', name, ']]' }
        end,
}


--[[

Returns a single arrow box, with image (if any), evotype brief description and
responsive arrow (that turns at md breakpoint).

The first parameter is the table of evo-data correspondig to the Pokémon this
arrows points to. If method is methods.BREED than the arrow is reversed (so
data should belong to the Pokémon before the arrow). It actually only uses
infos on the method and conditions of evolution.
The second optional parameter is the arrow's direction.

--]]
eb.boxArrowGen = function(data, direction)
    direction = direction
                or (data.method == evodata.methods.BREED
                    and 'reverse'
                    or 'normal'
                )

    -- Only uses the first image found. The actual order is the keys' one
    -- because there souldn't be more than one condition with an img at a time
    local img = table.mapToNum(data.conditions or {}, function(val, condition)
        return eb.boxArrow.img.conditions[condition](val)
    end)
    table.insert(img, eb.boxArrow.img.methods[data.method](data[data.method]))

    local desc = table.mapToNum(data.conditions or {}, function(val, condition)
        return eb.boxArrow.desc.conditions[condition](val)
    end)
    table.insert(desc, 1, eb.boxArrow.desc.methods[data.method](data[data.method]))

    local interpData = {
        img = img[1],
        evodesc = table.concat(desc),
        desktoparrow = eb.strings.desktoparrows[direction],
        mobilearrow = eb.strings.mobilearrows[direction],
        info = ''
    }
    local interpString = eb.strings.BOX_ARROW

    if interpData.evodesc == ''
       and interpData.info == ''
       and interpData.timegender == '' then
        interpString = eb.strings.BOX_ARROW_INFOLESS
    elseif interpData.direction == 'fixed' then
        interpString = eb.strings.BOX_ARROW_UNRESPONSIVE
    end
    return string.interp(interpString, interpData)
end

--[[

Returns a single arrow. Parameter is the same as eb.boxArrowGen

--]]
eb.SingleArrow = function(data, direction)
    return string.interp(eb.strings.SINGLE_ARROW, {
        boxarrow = eb.boxArrowGen(data, direction)
    })
end

--[[

Returns a pair of arrow, that is an arrow directed and one reversed, used in
case of baby Pokémon.

The parameter is the single table of evo-data correspondig to the Pokémon with
method = BREED. The normal arrow use datas of the first evolution.

--]]
eb.DoubleArrow = function(data)
    return string.interp(eb.strings.DOUBLE_ARROW, {
        boxarrow1 = eb.boxArrowGen(data.evos[1]),
        boxarrow2 = eb.boxArrowGen(data),
    })
end

--[[

Returns the right phase name given the position (1, 2 or 3) in the template and
the base phase's tables of evo-data. It actually uses only method, conditions
and the presence of evolutions (NOT their datas).

--]]
eb.phaseName = function(position, baseData)
    if position == 1 then
        if baseData.method == evodata.methods.BREED then
            return 'Forma Baby'
        elseif not baseData.method and baseData.evos then
            return 'Forma Base'
        else
            return 'Non si evolve'
        end
    elseif position == 2 then
        if baseData.conditions and baseData.conditions[evodata.conditions.BREEDONLY] then
            return 'Genitore'
        else
            return 'Prima evoluzione'
        end
    else
        return 'Seconda evoluzione'
    end
end

-- ============================ Automatic interface ============================

--[[

Returns a single Pokémon box, with notes, image, name, evolutionary phase and
types. Requires some info and get others from data modules.

The parameters are the Pokémon ndex, the evolutionary phase (text, not a
number), the notes and the name to be displayed in place of the Pokémon name
(optional, defaults to the Pokémon's name).

--]]
eb.boxPokemonAuto = function(ndex, phase, notes, shownName)
    local poke = multigen.getGen(pokes[form.nameToDataindex(ndex)])
    ndex = type(ndex) == type("") and ndex or string.threeFigures(ndex)

    return eb.boxPokemon{
        notes = notes,
        type1 = poke.type1,
        type2 = poke.type2,
        spr = spr.sprLua(ndex, 'current', 'male'),
        phase = phase,
        name = poke.name,
        shownName = shownName
    }
end

--[[

Prints two rows, one with arrows and the other with Pokémon boxes.

The first parameter is a table, whose elements should be the data tables
corresponding to the evolutions. This table can be the 'evos' field of a lower
phase data table. The second parameter is a number that specify the phase to
print, starting from 1 for base Pokémon (for instance: Iysaur is a phase 2).

If the array 'evos' passed is empty, returns the empty string.

This function only handles standard evolutions, maybe branched. It DOES NOT
handle baby/incense level evolutions with a pair of arrows or odd things
like that.

--]]
eb.makePhaseRows = function(evos, phase)
    local arrows, boxes = {}, {}
    table.map(evos, function(v, k)
        local key = 'box' .. tostring(k)
        arrows[key] = eb.SingleArrow(v)
        boxes[key] = eb.boxPokemonAuto(
            v.ndex,
            eb.phaseName(phase, evodata[v.ndex]),
            v.notes
        )
        return v
    end, ipairs)

    if table.getn(arrows) == 0 then
        return ''
    elseif table.getn(arrows) == 1 then
        return table.concat{
            string.interp(eb.strings.ROW_ONE, arrows),
            string.interp(eb.strings.ROW_ONE, boxes)
        }
    else
        return table.concat{
            string.interp(eb.strings.ROW_TWO, arrows),
            string.interp(eb.strings.ROW_TWO, boxes)
        }
    end
end

--[[

Creates the row for more than 2 evolutions, that doesn't switch to vertical
layout on small screen.

The parameter is an array which elements are the data tables of evolutions.
This parameter may be the evos field of the lower phase.

--]]
eb.makeManyEvosRow = function(evos)
    local rowContent = table.map(evos, function(v)
        return string.interp(eb.strings.GRID_ROW, {
            arrow = eb.SingleArrow(v, 'fixed'),
            box = eb.boxPokemonAuto(
                v.ndex,
                eb.phaseName(2, evodata[v.ndex]),
                v.notes
            )
        })
    end, ipairs)

    return string.interp(eb.strings.ROW_THREE, {
        boxes = table.concat(rowContent)
    })
end

--[[

Main Wikicode interface, but using data module. The first parameter is the
Pokémon's name ({{BASEPAGENAME}}). There's an optional parameter "form" to
specify the form using its abbr.

--]]
eb.Evobox = function(frame)
    local pokename = mw.text.decode(frame.args[1]):trim():lower()
    local abbr = (frame.args.form or ""):trim()
    local pokeData = multigen.getGen(pokes[form.nameToDataindex(pokename .. abbr)])
    local data = evolib.prunedEvotree(abbr == "" and pokeData.ndex or pokeData.ndex .. abbr)

    local evoboxcontent = {}
    local boxContainer = eb.strings.BOX_CONTAINER

    -- Insert the first phase Pokémon box
    table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
        box1 = eb.boxPokemonAuto(data.ndex, eb.phaseName(1, data), data.notes)
    }))

    local phase3evos
    if data.evos then
        -- If there are more than 2 phase one evolutions the module assumes there
        -- aren't higher level evolutions and uses the unresponsive layout
        if #data.evos > 2 then
            boxContainer = eb.strings.BOX_CONTAINER_UNRESPONSIVE
            table.insert(evoboxcontent, eb.makeManyEvosRow(data.evos))
        -- If the family is 'baby' or 'incenso' the second phase should be handled
        -- "by hand", otherwise there's the function that creates the row.
        elseif data.method == evodata.methods.BREED then
            -- There is one phase one evolution, but with double arrow
            table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.DoubleArrow(data)
            }))
            table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.boxPokemonAuto(data.evos[1].ndex, eb.phaseName(2, data), data.evos[1].notes)
            }))
        else
            table.insert(evoboxcontent, eb.makePhaseRows(data.evos, 2))
        end
        phase3evos = table.flatMapToNum(data.evos, function(v)
            return v.evos or {}
        end)
        table.insert(evoboxcontent, eb.makePhaseRows(phase3evos, 3))
    end

    local evobox = {
        string.interp(boxContainer, {
            background = css.horizGradLua{ type1 = pokeData.type1, type2 = pokeData.type2 },
            content = table.concat(evoboxcontent)
        })
    }

    -- Adds the categories
    if phase3evos and #phase3evos > 0 then
        table.insert(evobox, '[[Categoria:Pokémon appartenenti a una linea di evoluzione a tre stadi]]')
    elseif data.evos then
        table.insert(evobox, '[[Categoria:Pokémon appartenenti a una linea di evoluzione a due stadi]]')
    else
        table.insert(evobox, '[[Categoria:Pokémon che non fanno parte di una linea di evoluzione]]')
    end
    if phase3evos and #phase3evos > 1 or (data.evos and #data.evos > 1) then
        table.insert(evobox, '[[Categoria:Pokémon con evoluzioni diramate]]')
    end

    return table.concat(evobox)
end


-- ========================== Non-automatic interface ==========================

eb.processInput = {}

--[[

This table holds the list of keys whose values should be mapped to lowercase
in the arguments of Evobox. Not all the keys should be lowered because some
arguments are case sensitive (eg: moves names).

Elements of this table are lua patterns. Any key that matches any of those
patterns should have its value lowered.

--]]
eb.processInput.mapToLower = { '^family$', '^evotype%d%a?$', '^move%d%a?$',
    '^type%d$' }

-- Processes an argument: maps to lowercase when needed.
eb.processInput.processElement = function(v, k)
    if type(k) == 'string' and table.any(eb.processInput.mapToLower, function(pattern)
        return string.match(k, pattern)
    end) then
        v = string.lower(v)
    end

    return v
end

--[[

Given the frame.args of the module and a suffix, creates a Pokémon box using
informations with that suffix.

In the special case in which the name is "none" it returns an empty string (to
handle branches of different height).

--]]
eb.boxPokemonManual = function(p, suff)
    if p["name" .. suff]:lower() == "none" then
        return ""
    end
    local fakephase = p.family == "normale" and { evos = {} } or {}
    return eb.boxPokemon{
        notes = p["form" .. suff],
        type1 = p["type1-" .. suff],
        type2 = p["type2-" .. suff] or p["type1-" .. suff],
        spr = "[[File:" .. p["sprite" .. suff] .. ".png]]",
        phase = eb.phaseName(tonumber(suff:match("^(%d*)%a")), fakephase),
        name = p["name" .. suff],
    }
end

-- Tables mapping evotype to method for fake evodata building
eb.evotypeToMethod = {
    livello = evodata.methods.LEVEL,
    ['felicità'] = evodata.methods.HAPPINESS,
    posizione = evodata.methods.LEVEL,
    pietra = evodata.methods.STONE,
    mossa = evodata.methods.LEVEL,
    ['strum. tenuto'] = evodata.methods.LEVEL,
    ['ogg. tenuto'] = evodata.methods.LEVEL,
    scambio = evodata.methods.TRADE,
}

--[[

Returns a single arrow given frames.args and a suffix that identifies a subset
of parameters. If evotypeN is nil it returns an empty string (to handle branches
of different height).

Transform the subset of frame.args that ends with a specified suffix in an
evodata table that can be passed to boxArrowGen. If the evotype is unknown the
method defaults to OTHER.

--]]
eb.SingleArrowMaybe = function(p, suff, direction)
    if not p["evotype" .. suff] then
        return ""
    end

    local fakeevo = { conditions = {} }
    fakeevo.method = eb.evotypeToMethod[p["evotype" .. suff]]
                    or evodata.methods.OTHER

    fakeevo[evodata.methods.LEVEL] = p["level" .. suff]
    fakeevo[evodata.methods.STONE] = p["evostone" .. suff]

    fakeevo.conditions[evodata.conditions.LOCATION] = p["location" .. suff]
    fakeevo.conditions[evodata.conditions.MOVE] = p["move" .. suff]
    fakeevo.conditions[evodata.conditions.ITEM] = p["held" .. suff]
    fakeevo.conditions[evodata.conditions.OTHER] = p["evoinfo" .. suff]
    fakeevo.conditions[evodata.conditions.TIME] = p["time" .. suff]
    fakeevo.conditions[evodata.conditions.GENDER] = p["gender" .. suff]

    -- Checks for emptyness
    if next(fakeevo.conditions) == nil then
        fakeevo.conditions = nil
    end

    return eb.SingleArrow(fakeevo, direction)
end

--[[

Prints two rows, one with arrows and the other with Pokémon boxes.
The first parameter is a table that should contain all the values about the
phase, that are the ones about the evolutionary method with numer 'phase' - 1
and the ones about the Pokémons with number 'phase' . In fact, the first
parameter may be the frame.args processed. The second parameter is a number
that specify the phase to print. The phase should be the one of the Pokémon,
non of the evolutionary method.
This function only handles standard evolutions, maybe branched. It DOES NOT
handle baby/incense level evolutions with a couple of arrows or odd things
like that.

--]]
eb.makeGlitchPhaseRows = function(p, phase)
    local result = {}
    local evotypePhase = tostring(phase - 1)
    if p['name' .. phase] or p['name' .. phase .. 'a'] then
        if p['name' .. phase .. 'a'] then
            -- There are two evolutions
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.SingleArrowMaybe(p, evotypePhase),
                box2 = eb.SingleArrowMaybe(p, evotypePhase .. 'a')
            }))
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.boxPokemonManual(p, tostring(phase)),
                box2 = eb.boxPokemonManual(p, tostring(phase) .. "a"),
            }))
        else
            -- There's only one evolution
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.SingleArrowMaybe(p, evotypePhase),
            }))
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.boxPokemonManual(p, tostring(phase)),
            }))
        end
    end

    return table.concat(result)
end

--[[

Main manual Wikicode interface. It takes a lot of arguments to show everything.
It's meant to replace Evobox/2, but it doesn't have the exact same interface,
and some values allowed for that template aren't allowed for this module.

Parameters are named because of their number:
    - 1, 2: types of the Pokémon. Used only for printing, may as well be glitch
		types. 2 is optional, defaults to 1.
    - family (nessuna|normale): the kind of family. Defaults to 'nessuna',
		that means no evolutions. 'normale' means an evolution without baby or
		alike, and includes branched evolutions. Other families (baby, incenso,
		breedonly) are not supported by this module.
	- nameN: the name of the N-th Pokémon. If the value is "none" it will be
		rendered as an empty slot (for instance to show branches of different
		height)
    - spriteN: the ndex of the N-th Pokémon (or form) to display
	- type1-N, type2-N: types of the N-th form
    - formN: notes about the N-th Pokémon, put above the sprite
    - evotypeN (livello|felicità|posizione|pietra|mossa|strum. tenuto|scambio
            |other): the evolutionary method from N-th to (N+1)-th Pokémon.
    - levelN: the level paired with evotypeN
    - locationN: the location paired with evotypeN
    - evostoneN: the evostone paired with evotypeN
    - moveN: the move paired with evotypeN
    - heldN: the held item paired with evotypeN
    - msN: the ndex of the Pokémon paired with evotypeN
    - evoinfoN: notes paired with evotypeN
    - timeN: time of the day paired with evotypeN
    - genderN: gender paired with evotypeN
    - any N-ed parameter, but with a trailing "a" (for instance: 'evotypeNa'):
        the same information of un-a-ed parameter, but for the second N-th
        form (if any)
--]]
eb.GlitchEvobox = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    p = table.map(p, eb.processInput.processElement)

    p.family = p.family or 'nessuna'

    local evoboxcontent = {
        string.interp(eb.strings.ROW_ONE, { box1 = eb.boxPokemonManual(p, "1") })
    }

    table.insert(evoboxcontent, eb.makeGlitchPhaseRows(p, 2))
    table.insert(evoboxcontent, eb.makeGlitchPhaseRows(p, 3))

    return string.interp(eb.strings.BOX_CONTAINER, {
            background = css.horizGradLua{ type1 = p[1], type2 = p[2] or p[2] },
            content = table.concat(evoboxcontent)
        })
end

eb.glitchEvobox, eb.glitchevobox, eb.Glitchevobox =
    eb.GlitchEvobox, eb.GlitchEvobox, eb.GlitchEvobox


-- ============================ Alternative forms box ==========================

--[[

Returns the box of a single Pokémon form given its ndex with abbr. Notes may be
added using the second parameter.

--]]
eb.BoxForm = function(ndex, notes)
    local name, abbr = form.getnameabbr(ndex)
    local altdata = altforms[name] or useless[name]
    local shownname = altdata.names[abbr]
    shownname = shownname == "" and pokes[name].name:fu() or shownname
    return eb.boxPokemonAuto(ndex, '', notes, shownname)
end

--[[

Returns a single form arrow.

Parameters are named to make easier a possible future extension that exploits
the whole interface of the underlying eb.BoxArrow:
    - item: the name of the item required to change form
    - evoinfo: additional notes

--]]
eb.FormArrow = function(args)
    local fakeevo = {
        method = evodata.methods.OTHER,
        [evodata.methods.OTHER] = args.item
                            and table.concat{
                                links.bag(args.item),
                                "<div>",
                                args.item,
                                "</div>",
                            }
                            or "",
    }
    return string.interp(eb.strings.SINGLE_ARROW, {
        boxarrow = eb.boxArrowGen(fakeevo, 'double')
    })
end

--[[

This functions takes the module args and returns a subset of the args, made by
those args whose keys ended with the passed ending. This ending is removed in
the keys of the result.

--]]
eb.argsEndingSubset = function(args, ending)
    local newArgs = {}
    for k, v in pairs(args) do
        if k:match(ending .. '$') then
            newArgs[k:match('(.*)' .. ending .. '$')] = v
        end
    end
    return newArgs
end

--[[

Prints two rows, one with arrows and the other with form boxes.

The first parameter is a table that should contain all the values about the
row, that are the ones about the form change method with numer 'index' - 1
and the ones about the form with number 'index'. In fact, the first parameter
may be the frame.args processed. The second parameter is a number that specify
the row to print. The row should be the one of the form, non of the form change
method.

--]]
eb.makeFormRows = function(p, index)
    local result = {}
    local evotypeIdx = tostring(index - 1)
    if p['sprite' .. tostring(index)] then
        -- There is at least one evolution
        if p['sprite' .. tostring(index) .. 'a'] then
            -- There are two evolutions
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.FormArrow(eb.argsEndingSubset(p, evotypeIdx)),
                box2 = eb.FormArrow(eb.argsEndingSubset(p, evotypeIdx .. 'a'))
            }))
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.BoxForm(
                        p['sprite' .. tostring(index)],
                        p['loc' .. tostring(index)]
                    ),
                box2 = eb.BoxForm(
                        p['sprite' .. tostring(index) .. 'a'],
                        p['loc' .. tostring(index) .. 'a']
                    ),
            }))
        else
            -- There's only one evolution
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.FormArrow(eb.argsEndingSubset(p, evotypeIdx)),
            }))
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box1 = eb.BoxForm(
                        p['sprite' .. tostring(index)],
                        p['loc' .. tostring(index)]
                    )
            }))
        end
    end

    return table.concat(result)
end

--[[

Wikicode interface function to create a box for alternatives forms
transformation methods.

Parameters are named because of their number:
    - 1: the page name, as returned by {{PAGENAME}}. This parameter is used
         only to determine the colors of the background gradient.
    - spriteN: the ndex of the N-th form
    - locN: any additional note for the N-th form
    - itemN: the item needed to change from N-th to (N+1)-th form
    - evoinfoN: any additional info for form change from N-th to (N+1)-th
    - any N-ed parameter, but with an "a" appended (for instance spriteNa): the
      same information, but for the second N-th form (if any)
--]]
eb.Formbox = function(frame)
    local p = w.trimAll(mw.clone(frame.args))

    local pagename = string.fl(p[1] or mw.title.getCurrentTitle().text)
    p[1] = nil
    p.family = p.family or 'nessuna'
    local pagepoke = pokes[form.nameToDataindex(pagename)]
            or {name = 'Sconosciuto', ndex = 0, type1 = 'sconosciuto', type2 = 'sconosciuto'}
    pagepoke = multigen.getGen(pagepoke)

    local formboxcontent = {}

    -- Insert the first phase Pokémon box
    table.insert(formboxcontent, string.interp(eb.strings.ROW_ONE, {
        box1 = eb.BoxForm(p.sprite1, p.loc1)
    }))

    -- Adds any form passed as argument
    local i = 2
    while p['sprite' .. tostring(i)] do
        table.insert(formboxcontent, eb.makeFormRows(p, i))
        i = i + 1
    end

    return string.interp(eb.strings.BOX_CONTAINER, {
        background = css.horizGradLua{ type1 = pagepoke.type1, type2 = pagepoke.type2 },
        content = table.concat(formboxcontent)
    })
end

eb.formbox = eb.Formbox

return eb
