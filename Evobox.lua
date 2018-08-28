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
local w = require('Wikilib')
local links = require('Links')
local ms = require('MiniSprite')
local css = require('Css')
local c = require("Colore-data")
local altforms = require("AltForms-data")
local useless = require("UselessForms-data")
local pokes = require("Poké-data")
local moves = require("Move-data")
local evodata = require("Evo-data")
local wdata = require("Wikilib-data")

--[[

Utility strings

--]]

eb.strings = {
    BOX_CONTAINER = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-stretch inline-block-md width-sm-100" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],
    BOX_CONTAINER_UNRESPONSIVE = [=[<div class="text-center"><div class="roundy inline-flex flex-row flex-nowrap flex-items-center width-sm-100" style="padding: 0.5em; ${background}">${content}</div></div><br style="clear: both;">]=],

    ROW_ONE = [=[<div class="vert-middle">${box}</div>]=],
    ROW_TWO = [=[<div class="flex-md flex-row flex-nowrap flex-items-center"><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box1}</div><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box2}</div></div>]=],
    ROW_THREE = [=[<div><div class="grid" style="border-collapse: separate; border-spacing: 0.5ex 0;">${boxes}</div></div>]=],

    GRID_ROW = [=[<div><div class="align-middle">${arrow}</div><div class="align-middle">${pokebox}</div></div>]=],

    BOX_POKEMON = [=[<div class="text-center" style="margin: 0.5ex;">${notes}
<div class="roundy-full inline-block img-fluid" style="padding: 1ex; background: #fff;"><div class="roundy-full" style="padding: 0.5ex; ${background}">[[File:${ndex}.png|150px]]</div></div>
<div class="small-text" style="padding-top: 0.5ex;">${phase}</div>
<div>
<div>[[${name}|<span style="color: #000;">${shownName}</span>]]</div>
<div class="small-text hidden-sm">${type1rect}${type2rect}</div>
</div>
</div>]=],

    BOX_ARROW_INFOLESS = [=[${img}<div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],
    BOX_ARROW_UNRESPONSIVE = [=[${img}<div class="inline-block width-xl-100">${evodesc}${info}</div><div>${desktoparrow}</div>]=],
    BOX_ARROW = [=[${img}<div class="inline-block width-xl-100">${evodesc}${info}</div><div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],

    SINGLE_ARROW = [=[<div style="margin: 1em 0.5em;">${boxarrow}</div>]=],
    DOUBLE_ARROW = [=[<div class="inline-block-md"><div class="flex-md flex-row flex-nowrap flex-items-center" style="margin: 1em 0;"><div class="width-md-50" style="padding: 1em;">${boxarrow1}</div><div class="width-md-50" style="padding: 1em;">${boxarrow2}</div></div></div>]=],

    SMALL_TEXT_NEWLINE = [=[<div class="small-text" >${text}</div>]=],
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
types.

The parameters are the Pokémon ndex, the evolutionary phase, the notes and the
name to be displayed in place of the Pokémon name (optional, defaults to the
Pokémon's name).

--]]
eb.BoxPokemon = function(ndex, phase, notes, shownName)
    local poke = pokes[form.nameToDataindex(ndex)]

    return string.interp(eb.strings.BOX_POKEMON, {
        notes = notes and string.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = notes
        }) or '',
        background = css.radialGradLua{ type1 = poke.type1, type2 = poke.type2 },
        ndex = ndex,
        phase = phase or 'Non si evolve',
        name = poke.name,
        shownName = shownName or poke.name,
        type1rect = links.colorType(poke.type1, c[poke.type1].dark),
        type2rect = poke.type2 ~= poke.type1
                    and links.colorType(poke.type2, c[poke.type2].dark)
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
    [evodata.methods.LEVEL] = methodsFunctionGenerator(links.bag('Caramella Rara')),
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator(links.bag('Calmanella')),
    [evodata.methods.STONE] = methodsFunctionGenerator(links.bag('${param}')),
    [evodata.methods.TRADE] = methodsFunctionGenerator(links.bag('Blocco Amici')),
    [evodata.methods.BREED] = methodsFunctionGenerator(ms.staticLua('Uovo')),
}
eb.boxArrow.img.conditions = {
    [evodata.conditions.OTHER] = nilConst,
    [evodata.conditions.TIME] = nilConst,
    [evodata.conditions.ITEM] = methodsFunctionGenerator(links.bag('${param}')),
    [evodata.conditions.LOCATION] = methodsFunctionGenerator(links.bag('Mappa Città')),
    [evodata.conditions.MOVE] = function(movename)
        -- Takes move name and gets move type for the MT image
        local movedata = moves[movename]
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
            return '[[Livello|<span style="color: #000;">Aumento di livello</span>]]'
        end
        return table.concat{
            '[[Livello|<span style="color: #000;">Livello ',
            level,
            '</span>]]'
        }
    end,
    [evodata.methods.HAPPINESS] = methodsFunctionGenerator('[[Felicità|<span style="color: #000;">Felicità</span>]]'),
    [evodata.methods.STONE] = methodsFunctionGenerator('${param}'),
    [evodata.methods.TRADE] = methodsFunctionGenerator(links.bag('Blocco Amici')),
    [evodata.methods.BREED] = methodsFunctionGenerator('[[Accoppiamento Pokémon|<span style="color: #000;">Accoppiamento</span>]]'),
}
eb.boxArrow.desc.conditions = {
    [evodata.conditions.OTHER] = smallMethodsFunctionGenerator('${param}'),
    [evodata.conditions.TIME] = smallMethodsFunctionGenerator('(${param})'),
    [evodata.conditions.ITEM] = smallMethodsFunctionGenerator('tenendo [[${param}|<span style="color: #000;">${param}</span>]]'),
    [evodata.conditions.LOCATION] = smallMethodsFunctionGenerator('presso [[${param}|<span style="color: #000;">${param}</span>]]'),
    [evodata.conditions.MOVE] = function(movename)
        -- Takes move name (lowercase) and get the real name from data module
        -- (because case in names is unpredictable)
        local movedata = moves[movename]
        return string.interp(eb.strings.SMALL_TEXT_NEWLINE, {
            text = table.concat{
                'avendo appreso [[',
                string.fu(movedata.name),
                '|<span style="color: #000;">',
                string.fu(movedata.name),
                '</span>]]'
            }
        })
    end,
    [evodata.conditions.GENDER] = smallMethodsFunctionGenerator('(${param})'),
    [evodata.conditions.TRADED_FOR] = function(ndex)
            local name = pokes[tonumber(ndex)].name
            return table.concat{
                'per [[',
                name,
                '|<span style="color: #000;">',
                name,
                '</span>]]'
            }
        end,
}


--[[

Returns a single arrow box, with image (if any), evotype brief description and
responsive arrow (that turns at md breakpoint).

The only parameter is the table of evo-data correspondig to the Pokémon this
arrows points to. If method is methods.BREED than the arrow is reversed (so
data should belong to the Pokémon before the arrow).

--]]
eb.BoxArrow = function(data)
    local direction = data.method == evodata.methods.BREED
                      and 'reverse'
                      or 'normal'

    -- Only uses the first image found. The actual order is the keys' one
    -- because there souldn't be more than one condition with and img at a time
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

Returns a single arrow. Parameters are the same as BoxArrowLua

--]]
eb.SingleArrow = function(args)
    return string.interp(eb.strings.SINGLE_ARROW, {boxarrow = eb.BoxArrow(args)})
end

--[[

Returns a couple of arrow, that is an arrow directed and one reversed, used in
case of baby Pokémon.

Parameters are named because of their number:
    - evotype (livello|felicita|posizione|pietra|mossa|held|scambio|pokémon
              |baby|incenso|breedonly): states the evolutionary method
    - evoinfo: additional notes, added as small between parenthesis
    - time: the time of the day during which evolution can occur
    - gender: the gender required in order for evolution to occur
    - level: the level for evolution
    - location: the location where the Pokémon can evolve
    - evostone: the evolutionary stone needed for evolution
    - move: the name of the move required for evolution
    - held: the name of the item required for evolution
    - incense: the name of the incense needed to breed the Pokémon
    - ms: the dex number of the Pokémon needed for evolution
    - evotype2 (baby|incenso): states the reverse evolutionary method

--]]
eb.DoubleArrow = function(args)
    args.direction = 'normal'
    local args2 = {
        evotype = args.evotype2,
        direction = 'reverse',
        incense = args.incense
    }
    return string.interp(eb.strings.DOUBLE_ARROW, {
        boxarrow1 = eb.BoxArrow(args),
        boxarrow2 = eb.BoxArrow(args2),
    })
end

--[[

Returns the right phase name given the position (1, 2 or 3) in the template and
the family type.

--]]
local phaseName = function(position, family)
    family = family:lower()
    if position == 1 then
        if family == 'baby' or family == 'incenso' then
            return 'Forma Baby'
        elseif family == 'normale' then
            return 'Forma Base'
        else
            return 'Non si evolve'
        end
    elseif position == 2 then
        if family == 'breedonly' then
            return 'Genitore'
        else
            return 'Prima evoluzione'
        end
    else
        return 'Seconda evoluzione'
    end
end

--[[

This functions takes the module args and returns a subset of the args, made by
those args whose keys ended with the passed ending. This ending is removed in
the keys of the result.

--]]
local argsEndingSubset = function(args, ending)
    local newArgs = {}
    for k, v in pairs(args) do
        if k:match(ending .. '$') then
            newArgs[k:match('(.*)' .. ending .. '$')] = v
        end
    end
    return newArgs
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
handle baby/incense level evolutions with a couple of arrows or strange things
like that.

--]]
eb.makePhaseRows = function(p, phase)
    local result = {}
    local evotypePhase = tostring(phase - 1)
    if p['evotype' .. evotypePhase] then
        -- There is at least one evolution
        if p['evotype' .. evotypePhase .. 'a'] then
            -- There are two evolutions
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.SingleArrow(argsEndingSubset(p, evotypePhase)),
                box2 = eb.SingleArrow(argsEndingSubset(p, evotypePhase .. 'a'))
            }))
            table.insert(result, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.BoxPokemon(
                        p['sprite' .. tostring(phase)],
                        phaseName(phase, p.family),
                        p['form' .. tostring(phase)]
                    ),
                box2 = eb.BoxPokemon(
                        p['sprite' .. tostring(phase) .. 'a'],
                        phaseName(phase, p.family),
                        p['form' .. tostring(phase) .. 'a']
                    ),
            }))
        else
            -- There's only one evolution
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box = eb.SingleArrow(argsEndingSubset(p, evotypePhase)),
            }))
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box = eb.BoxPokemon(
                        p['sprite' .. tostring(phase)],
                        phaseName(phase, p.family),
                        p['form' .. tostring(phase)]
                    )
            }))
        end
    end

    return table.concat(result)
end

--[[

Creates the row for more than 2 evolutions, that doesn't switch to vertical
layout on small screen.

The first parameter is a table that should contain all the values about the
phases, that are the ones about the evolutionary method and the ones about the
Pokémons. In fact, the first parameter may be the frame.args processed.

--]]
eb.makeManyEvosRow = function(p)
    local rowContent = {}
    -- Creates the alphabet, starting with empty string
    local letters = { '' }
    for ascii = 97, 122 do
        table.insert(letters, string.char(ascii))
    end

    rowContent = table.map(letters, function(letter)
        if p['sprite2' .. letter] then
            local arrowArgs = argsEndingSubset(p, '1' .. letter)
            arrowArgs.direction = 'fixed'
            return string.interp(eb.strings.GRID_ROW, {
                arrow = eb.SingleArrow(arrowArgs),
                pokebox = eb.BoxPokemon(
                        p['sprite2' .. letter],
                        phaseName(2, 'normale'),
                        p['form2' .. letter]
                    )
            })
        else
            return ''
        end
    end)

    return string.interp(eb.strings.ROW_THREE, {
        boxes = table.concat(rowContent)
    })
end


eb.processInput = {}

--[[

This table holds the list of keys whose values should be mapped to lowercase
in the arguments of Evobox. Not all the keys should be lowered because some
arguments are case sensitive.

Some elements of this table are lua patterns. Any key key that matches any of
those patterns should have its value lowered.

--]]
eb.processInput.mapToLower = { 'family', 'evotype%d%a?', 'move%d%a?', 'type%d' }

--[[

This table holds mapping from lowercase external value of evotypes parameters
and internal value.

--]]
eb.processInput.evotypes = {
    ['felicità'] = 'felicita',
    ['strum. tenuto'] = 'held',
    ['ogg. tenuto'] = 'held',
    ['pokémon'] = 'pokemon'
}

--[[

Processes an argument: maps to lowercase when needed and parses evotypes.

--]]
eb.processInput.processElement = function(v, k)
    if type(k) == 'string' and table.any(eb.processInput.mapToLower, function(pattern)
        return string.match(k, '^' .. pattern .. '$')
    end) then
        v = string.lower(v)
    end

    if type(k) == 'string' and k:match('evotype') then
        v = eb.processInput.evotypes[v] or v
    end

    return v
end

--[[

Processes the entire arguments table: moves keys 'evotypeNinfo' to 'evoinfoN'.
This function modifies the table in place, and returns a reference to the table
itself.

--]]
eb.processInput.processTable = function(args)
    for k, v in pairs(args) do
        local num = type(k) == 'string' and string.match(k, 'evotype(%d%a?)info')
        if num then
            args['evoinfo' .. num] = v
        end
    end
    return args
end

--[[

Main Wikicode interface. It takes the same parameters as template:Evobox/2, in
order tu replace it in the pages.

Parameters are named because of their number:
    - 1: the page name, as returned by {{PAGENAME}}
    - family (nessuna|normale|baby|incenso|breedonly): the kind of family.
        Defaults to 'nessuna', that means no evolutions. 'normale' means an
        evolution without baby or alike, and includes branched evolutions.
        'baby' means there is a baby form, born with normal breed. 'incenso'
        means there is a baby form, born with breeding holding and incense.
        'breedonly' means that there is a Pokémon that can be born by breeding
        but doesn't evolve back in the parent Pokémon (only Phione and Manaphy)
    - incense: the incese used to breed the baby form
    - spriteN: the ndex of the N-th Pokémon (or form) to display
    - formN: notes about the N-th Pokémon, put above the sprite
    - evotypeN: the evolutionary method from N-th to (N+1)-th Pokémon
    - levelN: the level paired with evotypeN
    - locationN: the location paired with evotypeN
    - evostoneN: the evostone paired with evotypeN
    - moveN: the move paired with evotypeN
    - heldN: the held item paired with evotypeN
    - msN: the ndex of the Pokémon paired with evotypeN
    - evotypeNinfo: notes paired with evotypeN
    - timeN: time of the day paired with evotypeN
    - genderN: gender paired with evotypeN
    - evotypeNa: the evolutionary method from N-th to the second (N+1)-th
        Pokémon, if any
    - any N-ed parameter, but with a trailing "a" (for instance: 'evotypeNa'):
        the same information of un-a-ed parameter, but for the second N-th
        form (if any)
    - any parameter paired with N = 1, but with a trailing letter. Following
        alphabetical order, those parameters specify details of other first
        evolutions (if any). It is possible not to use all the letters
        sequentially (for instance: only sprite1, sprite1c and sprite1e) but I
        STRONGLY ADVISE NOT TO.
--]]
eb.Evobox = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    p = eb.processInput.processTable(table.map(p, eb.processInput.processElement))

    local pagename = string.fl(p[1] or mw.title.getCurrentTitle())
    p[1] = nil
    p.family = p.family or 'nessuna'
    local pagepoke = pokes[form.nameToDataindex(pagename)]
            or pokes[pagename:lower()]
            or {name = 'Sconosciuto', ndex = 0, type1 = 'sconosciuto', type2 = 'sconosciuto'}

    local evoboxcontent = {}
    local boxContainer = eb.strings.BOX_CONTAINER

    -- Insert the first phase Pokémon box
    table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
        box = eb.BoxPokemon(p.sprite1, phaseName(1, p.family), p.form1)
    }))

    -- If there are more than 2 phase one evolutions the module assumes there
    -- aren't higher level evolutions and uses the unresponsive layout
    if p.sprite2b then
        boxContainer = eb.strings.BOX_CONTAINER_UNRESPONSIVE
        table.insert(evoboxcontent, eb.makeManyEvosRow(p))
    -- If the family is 'baby' or 'incenso' the second phase shouldbe handled
    -- "by hand", otherwise there's the function that creates the row.
    elseif p.family == 'baby' or p.family == 'incenso' then
        -- There is one phase one evolution, but with double arrow
        local firstArrowArgs = argsEndingSubset(p, '1')
        firstArrowArgs.evotype2 = p.family
        firstArrowArgs.incense = p.incense
        table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
            box = eb.DoubleArrow(firstArrowArgs)
        }))
        table.insert(evoboxcontent, string.interp(eb.strings.ROW_ONE, {
            box = eb.BoxPokemon(p.sprite2, phaseName(2, p.family), p.form2)
        }))
    else
        table.insert(evoboxcontent, eb.makePhaseRows(p, 2))
    end
    table.insert(evoboxcontent, eb.makePhaseRows(p, 3))

    local evobox = {
        string.interp(boxContainer, {
            background = css.horizGradLua{ type1 = pagepoke.type1, type2 = pagepoke.type2 },
            content = table.concat(evoboxcontent)
        })
    }

    -- Adds the categories
    if p.evotype2 then
        table.insert(evobox, '[[Categoria:Pokémon appartenenti a una linea di evoluzione a tre stadi]]')
    elseif p.evotype1 then
        table.insert(evobox, '[[Categoria:Pokémon appartenenti a una linea di evoluzione a due stadi]]')
    else
        table.insert(evobox, '[[Categoria:Pokémon che non fanno parte di una linea di evoluzione]]')
    end
    if p.evotype1a or p.evotype2a then
        table.insert(evobox, '[[Categoria:Pokémon con evoluzioni diramate]]')
    end

    return table.concat(evobox)
end

eb.evobox = eb.Evobox



-- ============================== Alternate forms box =========================

--[[

Returns the box of a single Pokémon form given its ndex with abbr. Notes may be
added using the second parameter.

--]]
eb.BoxForm = function(ndex, notes)
    local name, abbr = form.getnameabbr(ndex)
    local altdata = altforms[name] or useless[name]
    return eb.BoxPokemon(ndex, '', notes, altdata.names[abbr])
end

--[[

Returns a single form arrow.

Parameters are named to make easier a possible future extension that exploits
the whole interface of the underlying eb.BoxArrow:
    - item: the name of the item required to change form
    - evoinfo: additional notes

--]]
eb.FormArrow = function(args)
    args.evotype = args.item and 'formitem' or 'other'
    args.held = args.item
    args.direction = 'double'
    return string.interp(eb.strings.SINGLE_ARROW, {boxarrow = eb.BoxArrow(args)})
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
                box1 = eb.FormArrow(argsEndingSubset(p, evotypeIdx)),
                box2 = eb.FormArrow(argsEndingSubset(p, evotypeIdx .. 'a'))
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
                box = eb.FormArrow(argsEndingSubset(p, evotypeIdx)),
            }))
            table.insert(result, string.interp(eb.strings.ROW_ONE, {
                box = eb.BoxForm(
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

    local pagename = string.fl(p[1] or mw.title.getCurrentTitle())
    p[1] = nil
    p.family = p.family or 'nessuna'
    local pagepoke = pokes[form.nameToDataindex(pagename)]
            or {name = 'Sconosciuto', ndex = 0, type1 = 'sconosciuto', type2 = 'sconosciuto'}

    local formboxcontent = {}

    -- Insert the first phase Pokémon box
    table.insert(formboxcontent, string.interp(eb.strings.ROW_ONE, {
        box = eb.BoxForm(p.sprite1, p.loc1)
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
