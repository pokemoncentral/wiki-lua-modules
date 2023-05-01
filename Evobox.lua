--[[

Displays the box containing the evolutionary line of a Pokémon.

This module exposes three WikiCode interfaces. The main one is Evobox, that is
automatic and meant to be used in Pokémon pages. It's called with

{{#invoke: Evobox | Evobox | {{BASEPAGENAME}} }}

The other two interfaces are Formbox and GlitchEvobox. The former creates the
box of form changes, with double arrows. The third is a manual call that
requires parameters for anything, mainly intended to be used in glitch's pages
because we lack a data module for glitches evolutions (and we don't plan to
create one).

--]]

local eb = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local form = require('Wikilib-forms')
local evolib = require('Wikilib-evos')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local links = require('Links')
local ms = require('MiniSprite')
local css = require('Css')
local cc = require('ChooseColor')
local spr = require('Spr')
local c = require("Colore-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local evodata = require("Evo-data")
-- stylua: ignore end
form.loadUseless(true)
local bothforms = form.allFormsData()

-- ============================= General functions =============================

--[[

Utility strings

--]]

eb.strings = {
    BOX_CONTAINER = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-stretch inline-block-md width-sm-100 ${textcolor}" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],
    BOX_CONTAINER_UNRESPONSIVE = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-center width-sm-100 ${textcolor}" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],

    ROW_ONE = [=[<div class="vert-middle">${box1}</div>]=],
    ROW_TWO = [=[<div class="flex-md flex-row flex-nowrap flex-items-center"><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box1}</div><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box2}</div></div>]=],
    ROW_THREE = [=[<div><div class="grid" style="border-collapse: separate; border-spacing: 0.5ex 0;">${boxes}</div></div>]=],

    GRID_ROW = [=[<div><div class="align-middle">${arrow}</div><div class="align-middle">${box}</div></div>]=],

    BOX_POKEMON = [=[<div class="text-center" style="margin: 0.5ex;">${notes}
<div class="roundy-full inline-block img-fluid white-bg" style="padding: 1ex;"><div class="roundy-full" style="padding: 0.5ex; ${background}">${spr}</div></div>
<div class="small-text" style="padding-top: 0.5ex;">${phase}</div>
<div>
<div>[[${name}|${shownName}]]</div>
<div class="small-text hidden-sm">${type1rect}${type2rect}</div>
</div>
</div>]=],

    BOX_ARROW_INFOLESS = [=[${img}<div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],
    BOX_ARROW_UNRESPONSIVE = [=[${img}<div class="inline-block width-xl-100">${evodesc}${info}</div><div>${desktoparrow}</div>]=],
    BOX_ARROW = [=[${img}<div class="inline-block width-xl-100">${evodesc}${info}</div><div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],

    SINGLE_ARROW = [=[<div style="margin: 1em 0.5em;">${boxarrow}</div>]=],
    DOUBLE_ARROW = [=[<div class="inline-block-md"><div class="flex-md flex-row flex-nowrap flex-items-center" style="margin: 1em 0;"><div class="width-md-50" style="padding: 1em;">${boxarrow1}</div><div class="width-md-50" style="padding: 1em;">${boxarrow2}</div></div></div>]=],
    TRIPLE_ARROW = [=[<div class="flex-md flex-row flex-nowrap flex-items-center"><div class="width-md-30" style="padding: 0.5em; height: 25%;">${boxarrow1}</div><div class="width-md-40 vert-middle" style="height: 50%;"><div>${boxarrow2}</div></div><div class="width-md-30" style="padding: 0.5em; height: 25%;">${boxarrow3}</div></div>]=],

    SMALL_TEXT_NEWLINE = [=[<div class="small-text">${text}</div>]=],

    CAT_TRE_PHASES = "[[Categoria:Pokémon appartenenti a una linea di evoluzione a tre stadi]]",
    CAT_TWO_PHASES = "[[Categoria:Pokémon appartenenti a una linea di evoluzione a due stadi]]",
    CAT_ONE_PHASE = "[[Categoria:Pokémon che non fanno parte di una linea di evoluzione]]",
    CAT_BRANCHED_PHASES = "[[Categoria:Pokémon con evoluzioni ramificate]]",
}

eb.strings.desktoparrows = {
    normal = "&rarr;",
    fixed = "&rarr;",
    reverse = "&larr;",
    double = "&harr;",
}

eb.strings.mobilearrows = {
    normal = "&darr;",
    fixed = "&rarr;",
    reverse = "&uarr;",
    double = "↕",
}

-- this should be constant
eb.emptybox = {}

--[[

Returns a single Pokémon box, with notes, image, name, evolutionary phase and
types. Requires many details.

The parameters are named:
    - notes: (optional) any additional note to be printed above the image
    - type1, type2: the two types of the Pokémon. Both mandatory
    - disptype1, disptype2 (optionals): colors for the background of the two
            type boxes. Defaults to type1/type2
    - spr: the full link to the sprite of the Pokémon
    - phase: (optional) the evolutionary phase ("Prima evoluzione", etc...).
            Defaults to "Non si evolve"
    - name: the name of the Pokémon (for the link)
    - shownName: (optional) the name that will be displayed

--]]
eb.boxPokemon = function(args)
    return txt.interp(eb.strings.BOX_POKEMON, {
        notes = args.notes and txt.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = args.notes,
        }) or "",
        background = css.radialGradLua({
            type1 = args.type1,
            type2 = args.type2,
        }),
        spr = args.spr,
        phase = args.phase or "Non si evolve",
        name = args.name,
        shownName = args.shownName or args.name,
        type1rect = links.colorType(
            args.type1,
            c[args.disptype1 or args.type1].dark
        ),
        type2rect = args.disptype2 and links.colorType(
            args.type2,
            c[args.disptype2].dark
        ) or (args.type2 ~= args.type1 and links.colorType(
            args.type2,
            c[args.type2].dark
        ) or ""),
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
        return txt.interp(text, { param = param })
    end
end

local smallMethodsFunctionGenerator = function(text)
    text = txt.interp(eb.strings.SMALL_TEXT_NEWLINE, { text = text })
    return function(param)
        return txt.interp(text, { param = param })
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
    [evodata.methods.OTHER] = methodsFunctionGenerator(""),
    [evodata.methods.LEVEL] = methodsFunctionGenerator(
        links.bag("Caramella rara")
    ),
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator(
        links.bag("Calmanella")
    ),
    [evodata.methods.STONE] = methodsFunctionGenerator(links.bag("${param}")),
    [evodata.methods.TRADE] = methodsFunctionGenerator(
        links.bag("Blocco Amici")
    ),
    [evodata.methods.BREED] = methodsFunctionGenerator(
        ms.staticLua({ "Uovo" })
    ),
    [evodata.methods.UNKNOWN] = methodsFunctionGenerator(""),
}
eb.boxArrow.img.conditions = {
    [evodata.conditions.OTHER] = nilConst,
    [evodata.conditions.TIME] = nilConst,
    [evodata.conditions.ITEM] = methodsFunctionGenerator(links.bag("${param}")),
    [evodata.conditions.LOCATION] = methodsFunctionGenerator(
        links.bag("Mappa città")
    ),
    [evodata.conditions.MOVE] = function(movename)
        -- Takes move name and gets move type for the MT image
        local movetype = multigen.getGenValue(moves[movename:lower()].type)
        return links.bag("MT " .. txt.fu(movetype), { link = "MT" })
    end,
    [evodata.conditions.GENDER] = nilConst,
    [evodata.conditions.TRADED_FOR] = function(ndex)
        return ms.staticLua({ ndex })
    end,
    [evodata.conditions.BREEDONLY] = methodsFunctionGenerator(
        ms.staticLua({ "132" })
    ),
    [evodata.conditions.REGION] = nilConst,
}

eb.boxArrow.desc.methods = {
    [evodata.methods.OTHER] = methodsFunctionGenerator("${param}"),
    [evodata.methods.LEVEL] = function(level)
        if not level then
            return "[[Livello|Aumento di livello]]"
        end
        return table.concat({ "[[Livello|Livello ", level, "]]" })
    end,
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator(
        "[[Affetto|Legame]]"
    ),
    [evodata.methods.STONE] = methodsFunctionGenerator("${param}"),
    [evodata.methods.TRADE] = methodsFunctionGenerator("[[Scambio]]"),
    [evodata.methods.BREED] = methodsFunctionGenerator(
        "[[Accoppiamento Pokémon|Accoppiamento]]"
    ),
    [evodata.methods.UNKNOWN] = methodsFunctionGenerator("Sconosciuto"),
}
eb.boxArrow.desc.conditions = {
    [evodata.conditions.OTHER] = smallMethodsFunctionGenerator("${param}"),
    [evodata.conditions.TIME] = smallMethodsFunctionGenerator("(${param})"),
    [evodata.conditions.ITEM] = smallMethodsFunctionGenerator(
        "tenendo [[${param}]]"
    ),
    [evodata.conditions.LOCATION] = smallMethodsFunctionGenerator(
        "presso: [[${param}]]"
    ),
    [evodata.conditions.MOVE] = function(movename)
        return txt.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = table.concat({ "avendo appreso [[", movename, "]]" }),
        })
    end,
    [evodata.conditions.GENDER] = smallMethodsFunctionGenerator("(${param})"),
    [evodata.conditions.TRADED_FOR] = function(ndex)
        local name = pokes[tonumber(ndex)].name
        return table.concat({ " per [[", name, "]]" })
    end,
    [evodata.conditions.BREEDONLY] = methodsFunctionGenerator(" con [[Ditto]]"),
    [evodata.conditions.REGION] = smallMethodsFunctionGenerator(
        "nella regione di [[${param}]]"
    ),
}

--[[

Returns a single arrow box, with image (if any), evotype brief description and
responsive arrow (that turns at md breakpoint).

The first parameter is the table of evo-data correspondig to the Pokémon this
arrows points to. If method is methods.BREED than the arrow is reversed (so
data should belong to the Pokémon before the arrow). It actually only uses
infos on the method and conditions of evolution.
The second optional parameter is the arrow's direction.

TODO: doesn't work with FormBox and GlitchEvobox

--]]
eb.boxArrowGen = function(data, direction)
    if not data.ndex and not data.name then
        return ""
    end
    direction = direction
        or (data.method == evodata.methods.BREED and "reverse" or "normal")

    -- Only uses the first image found. The actual order is the keys' one
    -- because there souldn't be more than one condition with an img at a time
    local img = tab.mapToNum(data.conditions or {}, function(val, condition)
        return eb.boxArrow.img.conditions[condition](val)
    end)
    table.insert(img, eb.boxArrow.img.methods[data.method](data[data.method]))

    local desc = tab.mapToNum(data.conditions or {}, function(val, condition)
        return eb.boxArrow.desc.conditions[condition](val)
    end)
    table.insert(
        desc,
        1,
        eb.boxArrow.desc.methods[data.method](data[data.method])
    )

    local interpData = {
        img = img[1],
        evodesc = table.concat(desc),
        desktoparrow = eb.strings.desktoparrows[direction],
        mobilearrow = eb.strings.mobilearrows[direction],
        info = "",
    }
    local interpString = eb.strings.BOX_ARROW

    if
        interpData.evodesc == ""
        and interpData.info == ""
        and interpData.timegender == ""
    then
        interpString = eb.strings.BOX_ARROW_INFOLESS
    elseif interpData.direction == "fixed" then
        interpString = eb.strings.BOX_ARROW_UNRESPONSIVE
    end
    return txt.interp(interpString, interpData)
end

--[[

Returns a single arrow. Parameter is the same as eb.boxArrowGen

--]]
eb.SingleArrow = function(data, direction)
    return txt.interp(eb.strings.SINGLE_ARROW, {
        boxarrow = eb.boxArrowGen(data, direction),
    })
end

--[[

Returns a pair of arrows, that is an arrow directed and one reversed, used in
case of baby Pokémon.

The parameter is the single table of evo-data correspondig to the Pokémon with
method = BREED (ie: the baby phase). The directed arrow use datas of the first
evolution.

--]]
eb.DoubleArrow = function(data)
    return txt.interp(eb.strings.DOUBLE_ARROW, {
        boxarrow1 = eb.boxArrowGen(data.evos[1]),
        boxarrow2 = eb.boxArrowGen(data),
    })
end

--[[

Returns a triple of arrows, that is two arrows directed and one reversed in
between, used in case of baby Pokémon with two evolutions.

The parameter is the single table of evo-data correspondig to the Pokémon with
method = BREED (ie: the baby phase). The two directed arrows use datas of the
evolutions.

--]]
eb.TripleArrow = function(data)
    return txt.interp(eb.strings.TRIPLE_ARROW, {
        boxarrow1 = eb.boxArrowGen(data.evos[1]),
        boxarrow2 = eb.boxArrowGen(data),
        boxarrow3 = eb.boxArrowGen(data.evos[2]),
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
            if
                baseData.conditions
                and baseData.conditions[evodata.conditions.BREEDONLY]
            then
                return "Non si evolve"
            else
                return "Forma Baby"
            end
        elseif not baseData.method and baseData.evos then
            return "Forma Base"
        else
            return "Non si evolve"
        end
    elseif position == 2 then
        if
            baseData.conditions
            and baseData.conditions[evodata.conditions.BREEDONLY]
        then
            return "Genitore"
        else
            return "Prima evoluzione"
        end
    else
        return "Seconda evoluzione"
    end
end

-- ============================ Automatic interface ============================

--[[

Returns a single Pokémon box, with notes, image, name, evolutionary phase and
types. Requires some info and get others from data modules.

Parameters are named:
    - ndex: the Pokémon ndex or name
    - abbr: the abbr of the form
    - phase: the evolutionary phase (text, not a number)
    - notes: addition notes
    - displayname (optional): the name to be displayed in place of the Pokémon
      name (defaults to the Pokémon's name).

--]]
eb.boxPokemonAuto = function(args)
    if not args.ndex then
        return ""
    end
    local ndex, abbr = form.getndexabbr(args.ndex, args.abbr)
    local poke = multigen.getGen(pokes[form.nameToDataindex(ndex, abbr)])
    local sprndex = (type(ndex) == "string" and ndex or txt.ff(ndex))
        .. form.toemptyabbr(abbr)

    return eb.boxPokemon({
        notes = args.notes,
        type1 = poke.type1 or "sconosciuto",
        type2 = poke.type2 or "sconosciuto",
        spr = spr.sprLua(sprndex, "current", "male", "150px"),
        phase = args.phase,
        name = poke.name,
        shownName = args.displayname,
    })
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
    for k, v in ipairs(evos) do
        local key = "box" .. tostring(k)
        arrows[key] = eb.SingleArrow(v)
        boxes[key] = eb.boxPokemonAuto({
            ndex = v.ndex or v.name,
            phase = eb.phaseName(phase, evodata[v.name]),
            notes = v.notes,
        })
    end

    if tab.getn(arrows) == 0 then
        return ""
    elseif tab.getn(arrows) == 1 then
        return table.concat({
            txt.interp(eb.strings.ROW_ONE, arrows),
            txt.interp(eb.strings.ROW_ONE, boxes),
        })
    else
        return table.concat({
            txt.interp(eb.strings.ROW_TWO, arrows),
            txt.interp(eb.strings.ROW_TWO, boxes),
        })
    end
end

--[[

Creates the row for more than 2 evolutions, that doesn't switch to vertical
layout on small screen.

The parameter is an array which elements are the data tables of evolutions.
This parameter may be the evos field of the lower phase.

--]]
eb.makeManyEvosRow = function(evos)
    local rowContent = tab.map(evos, function(v)
        return txt.interp(eb.strings.GRID_ROW, {
            arrow = eb.SingleArrow(v, "fixed"),
            box = eb.boxPokemonAuto({
                ndex = v.ndex or v.name,
                phase = eb.phaseName(2, evodata[v.name]),
                notes = v.notes,
            }),
        })
    end, ipairs)

    return txt.interp(eb.strings.ROW_THREE, {
        boxes = table.concat(rowContent),
    })
end

--[[

Prints two rows, one with arrows and the other with Pokémon boxes, when the
base for is a baby, so it should add the backward arrow for breeding.

The parameter is the table of the base form (ie: the baby Pokémon).

--]]
eb.makeBreedRow = function(data)
    if data.conditions and data.conditions[evodata.conditions.BREEDONLY] then
        -- Breedonly (aka Phione)
        return table.concat({
            txt.interp(eb.strings.ROW_ONE, {
                box1 = eb.SingleArrow(data),
            }),
            txt.interp(eb.strings.ROW_ONE, {
                box1 = eb.boxPokemonAuto({
                    ndex = data.evos[1].ndex or data.evos[1].name,
                    phase = eb.phaseName(2, data),
                    notes = data.evos[1].notes,
                }),
            }),
        })
    elseif tab.getn(data.evos) > 1 then
        -- More than one phase one, even with breed
        return table.concat({
            eb.TripleArrow(data),
            txt.interp(eb.strings.ROW_TWO, {
                box1 = eb.boxPokemonAuto({
                    ndex = data.evos[1].ndex or data.evos[1].name,
                    phase = eb.phaseName(2, data),
                    notes = data.evos[1].notes,
                }),
                box2 = eb.boxPokemonAuto({
                    ndex = data.evos[2].ndex or data.evos[2].name,
                    phase = eb.phaseName(2, data),
                    notes = data.evos[2].notes,
                }),
            }),
        })
    else
        -- There is one phase one evolution, but with double arrow
        return table.concat({
            txt.interp(eb.strings.ROW_ONE, {
                box1 = eb.DoubleArrow(data),
            }),
            txt.interp(eb.strings.ROW_ONE, {
                box1 = eb.boxPokemonAuto({
                    ndex = data.evos[1].ndex or data.evos[1].name,
                    phase = eb.phaseName(2, data),
                    notes = data.evos[1].notes,
                }),
            }),
        })
    end
end

--[[

Main Wikicode interface, but using data module. The first parameter is the
Pokémon's name ({{BASEPAGENAME}}). There are some optional parameters:
    - form: the abbr of the form of which create the box
    - prune: if "no" then doesn't prune the evo-tree
    - cat: if "no" then doesn't add categories

--]]
eb.Evobox = function(frame)
    local p = w.trimAll(frame.args)
    local pokename = mw.text.decode(p[1]):lower()
    local abbr = p.form or ""
    local pokeData =
        multigen.getGen(pokes[form.nameToDataindex(pokename, abbr)])
    local nameabbr = abbr == "" and pokename or pokename .. abbr

    local data
    if p.prune == "no" then
        data = evodata[nameabbr]
    else
        data = evolib.prunedEvotree(nameabbr)
    end
    assert(data)

    local evoboxcontent = {}
    local boxContainer = eb.strings.BOX_CONTAINER

    -- Insert the first phase Pokémon box
    table.insert(
        evoboxcontent,
        txt.interp(eb.strings.ROW_ONE, {
            box1 = eb.boxPokemonAuto({
                ndex = data.ndex or data.name,
                phase = eb.phaseName(1, data),
                notes = data.notes,
            }),
        })
    )

    local phase3evos
    if data.evos then
        -- If there are more than 2 phase one evolutions the module assumes there
        -- aren't higher level evolutions and uses the unresponsive layout
        if tab.getn(data.evos, "num") > 2 then
            boxContainer = eb.strings.BOX_CONTAINER_UNRESPONSIVE
            table.insert(evoboxcontent, eb.makeManyEvosRow(data.evos))
        -- If the base form is a baby (ie: method == BREED) it should add
        -- the arrow, otherwise we can handle it with the standard function
        elseif data.method == evodata.methods.BREED then
            table.insert(evoboxcontent, eb.makeBreedRow(data))
        else
            table.insert(evoboxcontent, eb.makePhaseRows(data.evos, 2))
        end
        phase3evos = tab.flatMapToNum(data.evos, function(v)
            return v.evos or { eb.emptybox }
        end)
        if
            tab.any(phase3evos, function(v)
                return v ~= eb.emptybox
            end)
        then
            table.insert(evoboxcontent, eb.makePhaseRows(phase3evos, 3))
        end
    end

    local evobox = {
        txt.interp(boxContainer, {
            textcolor = cc.forModGradBgLua(
                pokeData.type1 or "sconosciuto",
                pokeData.type2 or "sconosciuto"
            ),
            background = css.horizGradLua({
                type1 = pokeData.type1 or "sconosciuto",
                type2 = pokeData.type2 or "sconosciuto",
            }),
            content = table.concat(evoboxcontent),
        }),
    }

    -- Adds categories
    phase3evos = phase3evos
            and tab.filter(phase3evos, function(v)
                return v ~= eb.emptybox
            end)
        or {}
    if
        p.cat ~= "no"
        and not (
            data.conditions
            and data.conditions[evodata.conditions.BREEDONLY]
        )
    then
        if tab.getn(phase3evos, "num") > 0 then
            table.insert(evobox, eb.strings.CAT_TRE_PHASES)
        elseif data.evos then
            table.insert(evobox, eb.strings.CAT_TWO_PHASES)
        else
            table.insert(evobox, eb.strings.CAT_ONE_PHASE)
        end
        if
            tab.getn(phase3evos, "num") > 1
            or (data.evos and tab.getn(data.evos, "num") > 1)
        then
            table.insert(evobox, eb.strings.CAT_BRANCHED_PHASES)
        end
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
eb.processInput.mapToLower =
    { "^family$", "^evotype%d%a?$", "^move%d%a?$", "^type%d$" }

-- Processes an argument: maps to lowercase when needed.
eb.processInput.processElement = function(v, k)
    if
        type(k) == "string"
        and tab.any(eb.processInput.mapToLower, function(pattern)
            return string.match(k, pattern)
        end)
    then
        v = string.lower(v)
    end

    return v
end

--[[

Given the frame.args of the module and a suffix, creates a Pokémon box using
informations with that suffix.

In the special case in which the name is "none" it returns an empty string (to
handle branches of different height).

If there's a parameter ["forme" .. suff] uses it in place of the phase name.

--]]
eb.boxPokemonManual = function(p, suff)
    if p["name" .. suff]:lower() == "none" then
        return ""
    end
    local fakephase = p.family == "normale" and { evos = {} } or {}
    return eb.boxPokemon({
        notes = p["loc" .. suff],
        type1 = p["type1-" .. suff],
        disptype1 = p["disptype1-" .. suff],
        type2 = p["type2-" .. suff] or p["type1-" .. suff],
        disptype2 = p["disptype2-" .. suff],
        spr = "[[File:" .. p["sprite" .. suff] .. ".png|150px]]",
        phase = p["forme" .. suff]
            or eb.phaseName(tonumber(suff:match("^(%d*)%a?")), fakephase),
        name = p["name" .. suff],
        shownName = p["displayname" .. suff],
    })
end

-- Tables mapping evotype to method for fake evodata building
eb.evotypeToMethod = {
    livello = evodata.methods.LEVEL,
    ["affetto"] = evodata.methods.HAPPINESS,
    posizione = evodata.methods.LEVEL,
    pietra = evodata.methods.STONE,
    mossa = evodata.methods.LEVEL,
    ["strum. tenuto"] = evodata.methods.LEVEL,
    ["ogg. tenuto"] = evodata.methods.LEVEL,
    scambio = evodata.methods.TRADE,
    other = evodata.methods.OTHER,
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

    if p["evotype" .. suff] == "double" then
        p["evotype" .. suff] = "other"
        direction = "double"
    end

    local fakeevo = { ndex = 000, conditions = {} }
    fakeevo.method = eb.evotypeToMethod[p["evotype" .. suff]]
        or evodata.methods.OTHER

    fakeevo[evodata.methods.LEVEL] = p["level" .. suff]
    fakeevo[evodata.methods.STONE] = p["evostone" .. suff]
    fakeevo[evodata.methods.OTHER] = p["evoinfo" .. suff]

    fakeevo.conditions[evodata.conditions.LOCATION] = p["location" .. suff]
    fakeevo.conditions[evodata.conditions.MOVE] = p["move" .. suff]
    fakeevo.conditions[evodata.conditions.ITEM] = p["held" .. suff]
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
    if p["name" .. phase] or p["name" .. phase .. "a"] then
        if p["name" .. phase .. "a"] then
            -- There are two evolutions
            table.insert(
                result,
                txt.interp(eb.strings.ROW_TWO, {
                    box1 = eb.SingleArrowMaybe(p, evotypePhase),
                    box2 = eb.SingleArrowMaybe(p, evotypePhase .. "a"),
                })
            )
            table.insert(
                result,
                txt.interp(eb.strings.ROW_TWO, {
                    box1 = eb.boxPokemonManual(p, tostring(phase)),
                    box2 = eb.boxPokemonManual(p, tostring(phase) .. "a"),
                })
            )
        else
            -- There's only one evolution
            table.insert(
                result,
                txt.interp(eb.strings.ROW_ONE, {
                    box1 = eb.SingleArrowMaybe(p, evotypePhase),
                })
            )
            table.insert(
                result,
                txt.interp(eb.strings.ROW_ONE, {
                    box1 = eb.boxPokemonManual(p, tostring(phase)),
                })
            )
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
    - displaynameN: if given, it used instead of nameN in the display (not in
        the link)
    - spriteN: the ndex of the N-th Pokémon (or form) to display
    - type1-N, type2-N: types of the N-th form
    - disptype1/2-N: color for the box of the type. Forces the second type to
        be displayed even if it's equal to the first one
    - locN: notes about the N-th Pokémon, put above the sprite
    - formeN: name of the form, put in place of the phase below the sprite
    - evotypeN (livello|affetto|posizione|pietra|mossa|strum. tenuto|scambio
            |other|double): the evolutionary method from N-th to (N+1)-th
            Pokémon. Values have the same meaning as in evo-data. The value
            "double" (not present in evo-data) is like "other" but with a
            double arrow.
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
    p = tab.map(p, eb.processInput.processElement)

    p.family = p.family and p.family:lower() or "nessuna"

    local evoboxcontent = {
        txt.interp(eb.strings.ROW_ONE, { box1 = eb.boxPokemonManual(p, "1") }),
    }

    table.insert(evoboxcontent, eb.makeGlitchPhaseRows(p, 2))
    table.insert(evoboxcontent, eb.makeGlitchPhaseRows(p, 3))
    table.insert(evoboxcontent, eb.makeGlitchPhaseRows(p, 4))

    return txt.interp(eb.strings.BOX_CONTAINER, {
        textcolor = cc.forModGradBgLua(p[1], p[2] or p[1]),
        background = css.horizGradLua({ type1 = p[1], type2 = p[2] or p[1] }),
        content = table.concat(evoboxcontent),
    })
end

eb.glitchEvobox, eb.glitchevobox, eb.Glitchevobox =
    eb.GlitchEvobox, eb.GlitchEvobox, eb.GlitchEvobox

-- ============================ Alternative forms box ==========================

--[[

Returns the box of a single Pokémon form given its ndex with abbr. Notes may be
added using the second parameter. The shown name can also be specified with the
third, defaulting to the data modules value.

--]]
eb.BoxForm = function(ndex, notes, shownname)
    local name, abbr = form.getndexabbr(ndex)
    local altdata = bothforms[name]
    shownname = shownname
        or altdata.names[abbr] == "" and txt.fu(pokes[name].name)
    return eb.boxPokemonAuto({
        ndex = name,
        abbr = abbr,
        phase = "",
        notes = notes,
        displayname = shownname,
    })
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
        ndex = 000,
        method = evodata.methods.OTHER,
        [evodata.methods.OTHER] = args.item and table.concat({
            links.bag(args.item),
            "<div>",
            args.item,
            "</div>",
        }) or "",
    }
    return txt.interp(eb.strings.SINGLE_ARROW, {
        boxarrow = eb.boxArrowGen(fakeevo, "double"),
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
        if k:match(ending .. "$") then
            newArgs[k:match("(.*)" .. ending .. "$")] = v
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
    if p["sprite" .. tostring(index)] then
        -- There is at least one evolution
        if p["sprite" .. tostring(index) .. "a"] then
            -- There are two evolutions
            table.insert(
                result,
                txt.interp(eb.strings.ROW_TWO, {
                    box1 = eb.FormArrow(eb.argsEndingSubset(p, evotypeIdx)),
                    box2 = eb.FormArrow(
                        eb.argsEndingSubset(p, evotypeIdx .. "a")
                    ),
                })
            )
            table.insert(
                result,
                txt.interp(eb.strings.ROW_TWO, {
                    box1 = eb.BoxForm(
                        p["sprite" .. tostring(index)],
                        p["loc" .. tostring(index)],
                        p["name" .. tostring(index)]
                    ),
                    box2 = eb.BoxForm(
                        p["sprite" .. tostring(index) .. "a"],
                        p["loc" .. tostring(index) .. "a"],
                        p["name" .. tostring(index) .. "a"]
                    ),
                })
            )
        else
            -- There's only one evolution
            table.insert(
                result,
                txt.interp(eb.strings.ROW_ONE, {
                    box1 = eb.FormArrow(eb.argsEndingSubset(p, evotypeIdx)),
                })
            )
            table.insert(
                result,
                txt.interp(eb.strings.ROW_ONE, {
                    box1 = eb.BoxForm(
                        p["sprite" .. tostring(index)],
                        p["loc" .. tostring(index)],
                        p["name" .. tostring(index)]
                    ),
                })
            )
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
    - form: the abbr of the form (since it can't be included in the name)
    - spriteN: the ndex of the N-th form
    - nameN: the name of the N-th form (printed instead of the default got
         from data modules)
    - locN: any additional note for the N-th form
    - itemN: the item needed to change from N-th to (N+1)-th form
    - evoinfoN: any additional info for form change from N-th to (N+1)-th
    - any N-ed parameter, but with an "a" appended (for instance spriteNa): the
      same information, but for the second N-th form (if any)
--]]
eb.Formbox = function(frame)
    local p = w.trimAll(mw.clone(frame.args))

    local pagename = txt.fl(p[1] or mw.title.getCurrentTitle().text)
    p[1] = nil
    p.family = p.family or "nessuna"
    local pagepoke = pokes[form.nameToDataindex(pagename, p.form)]
        or {
            name = "Sconosciuto",
            ndex = 0,
            type1 = "sconosciuto",
            type2 = "sconosciuto",
        }
    pagepoke = multigen.getGen(pagepoke)

    local formboxcontent = {}

    -- Insert the first phase Pokémon box
    table.insert(
        formboxcontent,
        txt.interp(eb.strings.ROW_ONE, {
            box1 = eb.BoxForm(p.sprite1, p.loc1, p.name1),
        })
    )

    -- Adds any form passed as argument
    local i = 2
    while p["sprite" .. tostring(i)] do
        table.insert(formboxcontent, eb.makeFormRows(p, i))
        i = i + 1
    end

    return txt.interp(eb.strings.BOX_CONTAINER, {
        textcolor = cc.forModGradBgLua(pagepoke.type1, pagepoke.type2),
        background = css.horizGradLua({
            type1 = pagepoke.type1,
            type2 = pagepoke.type2,
        }),
        content = table.concat(formboxcontent),
    })
end

eb.formbox = eb.Formbox

return eb
