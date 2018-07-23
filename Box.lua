--[[

This module contains utility code for boxes: these are a link in a rounded
box, with a left-to-right gradient from the dark shade of a color to the
normal shade of the same color.

Other than this basic styles, the best way to style a box is via predefinite
configurations. For example, 'thick' creates a box with lots of whitespace
above and below the text, while 'tiny' returns a small box, with small text
and little whitespace around it. For more predefinite styles, check the
MANUALE DI STILE INTERMEDIO.

The basic function is called box, and has the following arguments:

- 1: displayed text.
- 2: link target, Defaults to text.
- 3: gradient color, from dark to normal, right-to-left.
- 4: Space-spearated string of predefined configurations names. Optional,
    defaults to no predefined configurations.
- 5: Space-separated list of CSS classes. Optional, defaults to no CSS classes.
- 6: CSS styles, in the format of an HTML style attribute values. Optional,
    defaults to no CSS styles.
- 7: Text color, defaults to #FFFFFF

Example call:

{{#invoke: Box | box | erba | erba (gruppo uova) | erba_uova | thin |
    inline-block width-sm-60 | padding: 2ex; margin-top: 0.5ex; | FFFFFF }}

There is also a number of shorthands, with a rather similar call. They are
listed below:

- TypeBox: a box displaying a type, with its color as background. Arguments:

    - 1: The type. Defaults to 'Sconosciuto'.
    - 2: Space-spearated string of predefined configurations names. Optional,
        defaults to no predefined configurations.
    - 3: Space-separated list of CSS classes. Optional, defaults to no CSS
        classes.
    - 4: CSS styles, in the format of an HTML style attribute values. Optional,
        defaults to no CSS styles.

    Example: {{#invoke: Box | typeBox | Elettro | thick | | margin: 3em; }}

- EggBox: a box displaying an egg grup, in its color as a background. Arguments:

    - 1: The egg group, without ' (gruppo uova)' suffix. Defaults to
        'Sconosciuto (gruppo uova)'.
    - 2: Space-spearated string of predefined configurations names. Optional,
        defaults to no predefined configurations.
    - 3: Space-separated list of CSS classes. Optional, defaults to no CSS
        classes.
    - 4: CSS styles, in the format of an HTML style attribute values. Optional,
        defaults to no CSS styles.

    Example: {{#invoke: Box | eggBox | Erba | | inline-block | margin: 3em; }}

In addition to the single box versions, also multiple box version are provided
for the shorthands. Their name is the same as the shorthand, with 'box'
replaced by 'list'. They are invoked the same way, except that the first
argument is a comma-separated list of types, egg groups, etc. The other
arguemnts are applied to al generated boxes. Some example calls below:

    - typeList: {{#invoke: Box | typeList | Elettro, Terra, Acciaio | |
        inline-block | margin: 3em; }}

        - eggList: {{#invoke: Box | eggList | Acqua 1, Campo, Magico | tiny }}

--]]

local b = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local css = require('Css')
local w = require('Wikilib')

--[[
    This table holds predefined styles configurations for boxes. Names of
    such configurations are the keys, while values are tables with 'classes'
    and 'styles' keys. These hold classes and styles respectively, and have as
    values the same structures as arseClasses and parseStyles return.
--]]
local predefs = {
    thick = {
        classes = {'roundy-5', 'text-center'},
        styles = {['padding'] = '0.5ex'}
    },

    thin = {
        classes = {'roundy-5', 'text-center'},
        styles = {['font-size'] = '90%', ['padding'] = '0 0.5ex'}
    },

    tiny = {
        classes = {'roundy-5', 'text-center', 'text-small'},
        styles = {['padding'] = '0 0.3ex'}
    }
}

--[[

Aliases for auto-generated shorthands.

Every top-level item relates to the shorthand with the same key, defined below
in b.shortHands.

Every alias has two subtables, one for box shorthands and the other one for
the corresponding list shorthand. These can contain an arbitrary number of
elements.

--]]
local aliases = {
    type = {
        box = {'boxTipo', 'box_tipo'},
        list = {'listTipo', 'list_tipo'}
    }
}

--[[

This function exports the given pair of lua-wikicode interface, taking care of
aliasing. Aliases are added for both lua and wikicode intefaces, in the
CamelCase and snake_case flavor for the former and CamelCase only for the
latter.

Arguments:
    - name: the name of the shorthand, as top-level key in aliases.
    - suffix: the second-level key in the aliases table, also used as a suffix
        for the non-alias exports.
    - luaFunction: the lua function to be exported.
    - wikicodeFunction: the wikicode companion of luaFunction.

--]]
local export = function(name, suffix, luaFunction, wikicodeFunction)
    suffix = suffix or 'box'
    local nameAliases = aliases[name] and aliases[name][suffix]

    -- Aliases-independent names (eg. typeBoxLua)
    local luaNames = {table.concat{name, string.fu(suffix), 'Lua'},
            table.concat{name, '_', suffix, '_lua'}}
    local wikicodeNames = {name .. string.fu(suffix),
            string.fu(name .. suffix)}

    -- Aliases-dependent names (eg, boxTipoLua)
    if nameAliases then
        luaNames = table.merge(luaNames, table.flatMap(nameAliases,
                function(alias) return {alias .. 'Lua', alias .. '_lua'} end))
        wikicodeNames = table.merge(wikicodeNames, table.flatMap(nameAliases,
                function(alias) return {alias, string.fu(alias)} end))
    end

    for _, luaName in pairs(luaNames) do
        b[luaName] = luaFunction
    end

    for _, wikicodeName in pairs(wikicodeNames) do
        b[wikicodeName] = wikicodeFunction
    end
end

--[[

This function returns the wikicode interface for a given lua one.

Unlike Wikilib.stdWikicodeInterface, it does not map the empty string to nil:
in fact, the predefinite styles list can be empty, and it is in such cases
that classes and styles are more important. However, with empty string mapped
to nil, classes and styles wouldn't be unpacked and passed to the lua function,
meaning that the box would basically be unstyled.

--]]
local makeWikicodeIntreface = function(luaFunction)
    return function(frame)
        local p = w.trimAll(table.copy(frame.args), false)
        return luaFunction(unpack(p))
    end
end

--[[

Shorthands are wrapper around the main b.boxLua function. Generally, they
derive the arguments to the latter from a smaller set of arguments: for
example, a box displaying a type has the same displayed text, link target and
color, that is the name of the type itself.

In this table, every element is a function that from arbitrary arguments
returns the b.boxLua arguments.

--]]
b.shortHands = {
    --[[
        Box displaying a type. Arguments:
            - type: The type, defaults to 'Sconosciuto'
            - pdfs: Table or space-spearated string of predefined
                configurations names. Optional, defaults to {}.
            - classes: Table/string of CSS classes, in the format parseClasses
                and printClasses produce respectively. Optional, defaults to {}.
            - styles: Table/string of CSS styles, in the format parseStyles and
                printStyles produce respectively. Optional, defaults to {}.
    --]]
    type = function(type, pdfs, classes, styles)
        type = string.fu(string.trim(type or 'Sconosciuto'))
        return type, type, type, pdfs, classes, styles, 'FFF'
    end,

    --[[
        Box displaying anegg group. Arguments:
            - egg: The egg group, without ' (gruppo uova)' suffix. Defaults to
                'Sconosciuto (gruppo uova)'
            - pdfs: Table or space-spearated string of predefined
                configurations names. Optional, defaults to {}.
            - classes: Table/string of CSS classes, in the format parseClasses
                and printClasses produce respectively. Optional, defaults to {}.
            - styles: Table/string of CSS styles, in the format parseStyles and
                printStyles produce respectively. Optional, defaults to {}.
    --]]
    egg = function(egg, pdfs, classes, styles)
        egg = string.fu(string.trim(egg or 'Sconosciuto (gruppo uova)'))
        return egg, egg .. ' (gruppo uova)', egg .. '_uova', pdfs,
            classes, styles, 'FFF'
    end
}

--[[

Main function creating a box. Lua interface. Arguments:

- text: displayed text.
- link: link target, Defaults to text.
- color: gradient color, from dark to normal, right-to-left.
- pdfs: Table or space-spearated string of predefined configurations names.
    Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Optional, defaults to {}.
- styles: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.
- textcolor: Text color, defaults to #FFFFFF

--]]
b.boxLua = function(text, link, color, pdfs, classes, styles, textcolor)
    classes, styles = css.classesStyles(predefs, pdfs, classes, styles)

    return string.interp([=[<div class="${class}" style="${bg}; ${style}">[[${link}|<span style="color:#${tc}">${text}</span>]]</div>]=], {
        class = css.printClasses(classes),
        bg = css.horizGradLua{color, 'dark', color, 'normale'},
        tc = textcolor or 'FFF',
        link = link or text,
        text = text,
        style = css.printStyles(styles)
    })
end
b.box_lua = b.boxLua

--[[

Wikicode interface to boxLua. More info (but you won't likely need it if you
read till here ;) ), in the top comment.

--]]
b.box = makeWikicodeIntreface(b.boxLua)
b.Box = b.box

--[[
    Generating exports for the shorthands: both lua and wikicode interfaces,
    both for list and single boxes.
--]]
for name, makeBoxArgs in pairs(b.shortHands) do

    --[[
        Lua interface: just calls b.boxLua with wathever the shorthand returns,
        given arbitrary arguments.
    --]]
    local luaFunction = function(...)
        return b.boxLua(makeBoxArgs(...))
    end
    local wikicodeFunction = makeWikicodeIntreface(luaFunction)

    -- Exporting single box interfaces
    export(name, 'box', luaFunction, wikicodeFunction)

    --[[
        List-of-boxes lua interface: the first argument is a sequence: from
        each item a box is generted, passing along the resto fo the arguments,
        that are therefore the same for every item in the sequence.

        The sequence can be a table of strings or a comma-separated string.
    --]]
    local luaList = function(items, ...)
        local args = {...}
        if type(items) == 'string' then
            items = items == '' and {} or mw.text.split(items, ',%s*')
        end
        return w.mapAndConcat(items, function(item)
            return luaFunction(item, unpack(args))
        end)
    end
    local wikicodeList = makeWikicodeIntreface(luaList)

    -- Exporting list interfaces
    export(name, 'list', luaList, wikicodeList)
end

return b
