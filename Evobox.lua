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
local forms = require("AltForms-data")
local pokes = require("Poké-data")
local moves = require("Move-data")

--[[

Utility strings

--]]

eb.strings = {
    BOX_POKEMON = [=[<div class="text-center" style="margin: 0.5ex;">${notes}
<div class="roundy-full inline-block img-fluid" style="padding: 1ex; background: #fff;"><div class="roundy-full" style="padding: 0.5ex; ${background}">[[File:${ndex}.png|150px]]</div></div>
<div class="small-text" style="padding-top: 0.5ex;">${phase}</div>
<div>
<div>[[${name}|<span style="color: #000;">${name}</span>]]</div>
<div class="small-text hidden-sm">${type1rect}${type2rect}</div>
</div>
</div>]=],

    BOX_ARROW = [=[${img}<div class="text-small inline-block width-xl-100">${evodesc}</div>${info}<div><span class="hidden-md">${desktoparrow}</span><span class="visible-md">${mobilearrow}</span></div>]=],

    SINGLE_ARROW = [=[<div style="margin: 1em 0.5em;">${boxarrow}</div>]=],
    DOUBLE_ARROW = [=[<div class="inline-block-md"><div class="flex-md flex-row flex-nowrap flex-items-center" style="margin: 1em 0;"><div class="width-md-50" style="padding: 1em;">${boxarrow1}</div><div class="width-md-50" style="padding: 1em;">${boxarrow2}</div></div></div>]=],

    ROW_ONE = [=[<div class="vert-middle">${box}</div>]=],
    ROW_TWO = [=[<div class="flex-md flex-row flex-nowrap flex-items-center"><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box1}</div><div class="width-md-50 vert-middle" style="margin: 0 0.5ex; height: 50%;">${box2}</div></div>]=],

    LITTLE_TEXT_NEWLINE = [=[<div class="small-text" >${text}</div>]=],
    LITTLE_TEXT_INLINE = [=[<span class="small-text" >${text}</span>]=]
}

eb.strings.desktoparrows = {
    normal = '&rarr;',
    reverse = '&larr;',
    double = '&harr;'
}

eb.strings.mobilearrows = {
    normal = '&darr;',
    reverse = '&uarr;',
    double = '↕'
}

--[[

Utility function that creates the boxArrow functions in the simplest case, that
is plain interpolation of thetwo parameters

--]]
local boxArrowFunctionGenerator = function(text)
    return function(param1, param2)
        return string.interp(text, {
            param1 = param1,
            param2 = param2
        })
    end
end

--[[

To handle the many evolutionary methods, descriptions and images are stored in
this table of functions. The index is the evotype (lowercase), the content is a
function that takes two parameters and returns the img/description wanted. The
parameters are made so that each parameter of the parent call should be put in
OR in exactly one of the two paramters of this function.

Follows the list of which parameters should be put where.
param1: level, locations list, evolutionary stone, move name, item name, incense
param2: move type, ndex of the other Pokémon involved

--]]
eb.strings.boxArrowImg = {
    livello = boxArrowFunctionGenerator(links.bag('Caramella Rara')),
    felicita = boxArrowFunctionGenerator(links.bag('Calmanella')),
    posizione = boxArrowFunctionGenerator(links.bag('Mappa Città')),
    pietra = boxArrowFunctionGenerator(links.bag('${param1}')),
    mossa = boxArrowFunctionGenerator(links.bag('MT ${param2}')),
    held = boxArrowFunctionGenerator(links.bag('${param1}')),
    scambio = function(param1, param2)
            if param2 then
                return ms.staticLua(param2)
            else
                return links.bag(param1 or 'Blocco Amici')
            end
        end,
    pokemon = function(param1, param2)
            return table.concat{'<div>', ms.staticLua(param2), '</div>'}
        end,
    baby = boxArrowFunctionGenerator(ms.staticLua('Uovo')),
    incenso = boxArrowFunctionGenerator(links.bag('${param1}')),
    breedonly = boxArrowFunctionGenerator(ms.staticLua('132'))
}

eb.strings.boxArrowEvodesc = {
    livello = boxArrowFunctionGenerator('[[Livello|<span style="color: #000;">Livello</span>]] ${param1}'),
    felicita = boxArrowFunctionGenerator('[[Felicità|<span style="color: #000;">Felicità</span>]]'),
    posizione = boxArrowFunctionGenerator('[[Livello|<span style="color: #000;">Aumento di livello</span>]]<br>presso: ${param1}'),
    pietra = boxArrowFunctionGenerator('${param1}'),
    mossa = boxArrowFunctionGenerator('[[Livello|<span style="color: #000;">Aumento di livello</span>]]<br>avendo appreso [[${param1}|<span style="color: #000;">${param1}</span>]]'),
    held = boxArrowFunctionGenerator('[[Livello|<span style="color: #000;">Aumento di livello</span>]]<br>tenendo [[${param1}|<span style="color: #000;">${param1}</span>]]'),
    scambio = function(param1, param2)
            local resultString = '[[Scambio|<span style="color: #000;">Scambio</span>]]'
                if param1 then
                    resultString = table.concat{
                        resultString,
                        '<br>tenendo [[',
                        param1,
                        '|<span style="color: #000;">',
                        param1,
                        '</span>]]'
                    }
                end
                if param2 then
                    resultString = table.concat{
                        resultString,
                        '<br>per [[',
                        pokes[tonumber(param2)].name,
                        '|<span style="color: #000;">',
                        pokes[tonumber(param2)].name,
                        '</span>]]'
                    }
                end
            return resultString
        end,
    pokemon = function(param1, param2)
            return table.concat{
                '[[Livello|<span style="color: #000;">Aumento di livello</span>]]<br>con [[',
                pokes[tonumber(param2)].name,
                '|<span style="color: #000;">',
                pokes[tonumber(param2)].name,
                '</span>]]',
                ' in [[squadra|<span style="color: #000;">squadra</span>]]'
            }
        end,
    baby = boxArrowFunctionGenerator('[[Accoppiamento Pokémon|<span style="color: #000;">Accoppiamento</span>]]'),
    incenso = boxArrowFunctionGenerator('[[Accoppiamento Pokémon|<span style="color: #000;">Accoppiamento</span>]] tenendo [[${param1}]]'),
    breedonly = boxArrowFunctionGenerator('[[Accoppiamento Pokémon|<span style="color: #000;">Accoppiamento</span>]] con [[Ditto|<span style="color: #000;">Ditto</span>]]')
}


--[[

Returns a single Pokémon box, with notes, image, name, evolutionary phase and
types.

The parameters are the Pokémon ndex, the evolutionary phase and the notes.

--]]
eb.BoxPokemonLua = function(ndex, phase, notes)
    --local name, abbr = form.getnameabbr(ndex)
    local poke = pokes[form.nameToDataindex(ndex)]

    return string.interp(eb.strings.BOX_POKEMON, {
        notes = notes and string.interp(eb.strings.LITTLE_TEXT_NEWLINE, {
            text = notes
        }) or '',
        background = css.radialGradLua{ type1 = poke.type1, type2 = poke.type2 },
        ndex = ndex,
        phase = phase or 'Non si evolve',
        name = poke.name,
        type1rect = links.colorType(poke.type1, c[poke.type1].dark),
        type2rect = poke.type2 ~= poke.type1
                    and links.colorType(poke.type2, c[poke.type2].dark)
                    or ''
    })
end


--[[

Returns a single arrow box, with image (if any), evotype brief description and
responsive arrow (that turns at md breakpoint).

Parameters are named because of their number:
    - direction (normal|reverse|double): states the direction of the arrow,
            the default if evotype is 'breedonly' is 'reverse', otherwise is
            'normal'
    - evotype (livello|felicita|posizione|pietra|mossa|held|scambio|pokémon
              |baby|incenso|breedonly): states the evolutionary method
    - evoinfo (string): additional notes, added as small between parenthesis
    - time (string): the time of the day during which evolution can occur
    - gender (string): the gender required in order for evolution to occur
    - level: the level for evolution
    - location: the location where the Pokémon can evolve
    - evostone: the evolutionary stone needed for evolution
    - move: the name of the move required for evolution
    - held: the name of the item required for evolution
    - incense: the name of the incense needed to breed the Pokémon
    - ms: the dex number of the Pokémon needed for evolution

--]]
eb.BoxArrowLua = function(args)
    args.direction = args.direction
                    or (args.evotype == 'breedonly' and 'reverse' or 'normal')
    args.move = args.move and args.move:lower() or nil
    args.location = args.location
        and string.interp('[[${text}|<span style="color: #000;">${text}</span>]]', {
            text = args.location
        })
    local movedata = moves[args.move]
    local param1 = args.level or args.location or args.evostone
                    or (movedata and movedata.name) or args.held or args.incense
    local param2 = (movedata and string.fu(movedata.type)) or args.ms
    local info = table.concat{args.evoinfo or '', args.time or '', args.gender or ''}
    info = info == '' and ''
            or string.interp(eb.strings.LITTLE_TEXT_NEWLINE, {
                text = table.concat{'(', info, ')'}
            })

    return string.interp(eb.strings.BOX_ARROW, {
        img = eb.strings.boxArrowImg[args.evotype](param1, param2),
        evodesc = eb.strings.boxArrowEvodesc[args.evotype](param1, param2),
        info = info,
        desktoparrow = eb.strings.desktoparrows[args.direction],
        mobilearrow = eb.strings.mobilearrows[args.direction]
    })
end

--[[

Returns a single arrow. Parameters are the same as BoxArrowLua

--]]
eb.SingleArrowLua = function(args)
    return string.interp(eb.strings.SINGLE_ARROW, {boxarrow = eb.BoxArrowLua(args)})
end

--[[

Returns a couple of arrow, that is an arrow directed and one reversed, used in
case of baby Pokémon.

Parameters are named because of their number:
    - evotype (livello|felicita|posizione|pietra|mossa|held|scambio|pokémon
              |baby|incenso|breedonly): states the evolutionary method
    - evoinfo (string): additional notes, added as small between parenthesis
    - time (string): the time of the day during which evolution can occur
    - gender (string): the gender required in order for evolution to occur
    - level: the level for evolution
    - location: the location where the Pokémon can evolve
    - evostone: the evolutionary stone needed for evolution
    - move: the name of the move required for evolution
    - held: the name of the item required for evolution
    - incense: the name of the incense needed to breed the Pokémon
    - ms: the dex number of the Pokémon needed for evolution
    - evotype2 (baby|incenso): states the reverse evolutionary method

--]]
eb.DoubleArrowLua = function(args)
    args.direction = 'normal'
    local args2 = {
        evotype = args.evotype2,
        direction = 'reverse',
        incense = args.incense
    }
    return string.interp(eb.strings.DOUBLE_ARROW, {
        boxarrow1 = eb.BoxArrowLua(args),
        boxarrow2 = eb.BoxArrowLua(args2),
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

Adds also 'evotype' .. ending .. 'info' to the result with key 'evoinfo'.

--]]
local argsEndingSubset = function(args, ending)
    local newArgs = {}
    for k, v in pairs(args) do
        if k:match(ending .. '$') then
            newArgs[k:match('(.*)' .. ending .. '$')] = v
        end
    end
    newArgs.evoinfo = args['evotype' .. ending .. 'info']
    return newArgs
end

eb.processInput = {}

--[[

This table holds the list of keys whose values should be mapped to lowercase
in the arguments of Evobox. Not all the keys should be lowered becaus some
arguments are case sensitive.

Some elements of this table are lua patterns. Any key key that matches any of
those patterns should have its value lowered.

--]]
eb.processInput.mapToLower = { 'family', 'evotype%da?', 'move%da?', 'type%d' }

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

Processes an argument, mapping to lowercase those that need it and parsing
evotypes

--]]
eb.processInput.process = function(v, k)
    if type(k) == 'string' and table.any(eb.processInput.mapToLower, function(pattern)
        return string.match(k, pattern)
    end) then
        v = string.lower(v)
    end

    if type(k) == 'string' and k:match('evotype') then
        v = eb.processInput.evotypes[v] or v
    end

    return v
end

--[[

Main Wikicode interface. It takes the same parameters as template:Evobox/2, in
order tu replace it in the pages.

Parameters are named because of their number:
    - pagename or 1: the page name, as returned by {{PAGENAME}}
    - family (nessuna|normale|baby|incenso|breedonly): the kind of family.
        Defaults to 'nessuna', that means no evolutions. 'normale' means an
        evolution without baby or alike, and includes branched evolutions.
        'baby' means there is a baby form, born with normal breed. 'incenso'
        means there is a baby form, born with breeding holding and incense.
        'breedonly' means that there is a Pokémon that can be born by breeding
        but doesn't evolve back in the parent Pokémon (only Phione and Manaphy)
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
    - any parameter paired with evotypeN, but with an "a" appended
    - incense: the incese used to breed the baby form
--]]
eb.Evobox = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    local p = table.map(p, eb.processInput.process)

    local pagename = string.fl(p.pagename or p[1] or mw.title.getCurrentTitle())
    p[1] = nil
    p.family = p.family or 'nessuna'
    local pagepoke = pokes[form.nameToDataindex(pagename)]
            or {name = 'Sconosciuto', ndex = 0, type1 = 'sconosciuto', type2 = 'sconosciuto'}

    local evobox = {}
    table.insert(evobox, string.interp('<div class="text-center"><div class="inline-block-md inline-flex flex-row flex-nowrap flex-items-stretch roundy text-center" style="padding: 0.5em; ${background}>', {
        background = css.horizGradLua{ type1 = pagepoke.type1, type2 = pagepoke.type2 }
    }))

    -- Insert the first Pokémon box
    table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
        box = eb.BoxPokemonLua(p.sprite1, phaseName(1, p.family), p.form1)
    }))

    -- Insert -the death- the first arrow box
    if p.evotype1 then
        -- There is at least one evolution
        local firstArrowArgs = argsEndingSubset(p, '1')
        if p.evotype1a then
            -- There are two phase one evolutions
            table.insert(evobox, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.SingleArrowLua(firstArrowArgs),
                box2 = eb.SingleArrowLua(argsEndingSubset(p, '1a'))
            }))
            table.insert(evobox, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.BoxPokemonLua(p.sprite2, phaseName(2, p.family), p.form2),
                box2 = eb.BoxPokemonLua(p.sprite2a, phaseName(2, p.family), p.form2a),
            }))
        elseif p.family == 'baby' or p.family == 'incenso' then
            -- There is one phase one evolution, but with double arrow
            firstArrowArgs.evotype2 = p.family
            firstArrowArgs.incense = p.incense
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.DoubleArrowLua(firstArrowArgs)
            }))
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.BoxPokemonLua(p.sprite2, phaseName(2, p.family), p.form2)
            }))
        else
            -- There is one phase one evolution, with single arrow
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.SingleArrowLua(firstArrowArgs)
            }))
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.BoxPokemonLua(p.sprite2, phaseName(2, p.family), p.form2)
            }))
        end
    end
    -- This if should be nested inside the previous one, but I'm not doing it
    -- in order to avoid excessive indentation
    if p.evotype2 then
        -- There is at least one phase two evolution
        if p.evotype2a then
            -- There are two phase two evolutions
            table.insert(evobox, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.SingleArrowLua(argsEndingSubset(p, '2')),
                box2 = eb.SingleArrowLua(argsEndingSubset(p, '2a'))
            }))
            table.insert(evobox, string.interp(eb.strings.ROW_TWO, {
                box1 = eb.BoxPokemonLua(p.sprite3, phaseName(3, p.family), p.form3),
                box2 = eb.BoxPokemonLua(p.sprite3a, phaseName(3, p.family), p.form3a),
            }))
        else
            -- At this level there can't be double arrows
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.SingleArrowLua(argsEndingSubset(p, '2'))
            }))
            table.insert(evobox, string.interp(eb.strings.ROW_ONE, {
                box = eb.BoxPokemonLua(p.sprite3, phaseName(3, p.family), p.form3)
            }))
        end
    end

    table.insert(evobox, '</div></div>')

    -- Adds the categories
    if p.evotype2 then
        table.insert(evobox, '[[Categoria:Pokémon appartenenenti a una linea di evoluzione a tre stadi]]')
    elseif p.evotype1 then
        table.insert(evobox, '[[Categoria:Pokémon appartenenenti a una linea di evoluzione a due stadi]]')
    else
        table.insert(evobox, '[[Categoria:Pokémon che non fanno parte di una linea di evoluzione]]')
    end
    if p.evotype1a or p.evotype2a then
        table.insert(evobox, '[[Categoria:Pokémon con evoluzioni diramate]]')
    end

    return table.concat(evobox)
end

eb.evobox = eb.Evobox

return eb
