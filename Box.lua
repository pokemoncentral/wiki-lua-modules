--[[

This module contains utility code for boxes: these are a link in a rounded
box, with a left-to-right gradient from the dark shade of a color to the
normal shade of the same color.

Other than this basic styles, the best way to style a box is via predefinite
configurations. For example, 'thick' creates a box with lots of whitespace
above and below the text, while 'tiny' returns a small box, with small text
and little whitespace around it. For more predefinite styles, check the
MANUALE DI STILE INTERMEDIO.

The basic function is called box, and has the following arguments. They can all
be passed either with a name or by position. The names are the ones listed
below, while the order is still the one below.

- text: displayed text.
- link: link target, Defaults to text.
- color: gradient color, from dark to normal, right-to-left.
- conf: Space-spearated string of predefined configurations names. Optional,
    defaults to no predefined configurations.
- classes: Space-separated list of CSS classes. Optional, defaults to no CSS
    classes.
- styles: CSS styles, in the format of an HTML style attribute values.
    Optional, defaults to no CSS styles.
- textcolor: Text color, defaults to #FFFFFF

Example calls:

{{#invoke: Box | box | erba | erba (gruppo uova) | erba_uova | thin |
    inline-block width-sm-60 | padding: 2ex; margin-top: 0.5ex; | FFFFFF }}
{{#invoke: Box | box | text = erba | link = erba (gruppo uova) | confs = thin |
        classes = inline-block width-sm-60 | color = erba_uova |
        styles = padding: 2ex; margin-top: 0.5ex; | textcolor = FFFFFF }}

There is also a number of shorthands, with a rather similar call. They are
listed below:

- TypeBox: a box displaying a type, with its color as background. The arguments
    can, again, all be passed either with a name or by position. They are
    listed here:

    - type: The type. Defaults to 'Sconosciuto'.
    - confs: Space-spearated string of predefined configurations names.
        Optional, defaults to no predefined configurations.
    - classes: Space-separated list of CSS classes. Optional, defaults to no
        CSS classes.
    - styles: CSS styles, in the format of an HTML style attribute values.
        Optional, defaults to no CSS styles.

    Examples:
        {{#invoke: Box | typeBox | Elettro | thick | | margin: 3em; }}
        {{#invoke: Box | typeBox | type = Elettro | confs = thick |
            styles = margin: 3em; }}

- EggBox: a box displaying an egg grup, in its color as a background. The
    arguments follow the usual named/positional pattern:

    - egg: The egg group, without ' (gruppo uova)' suffix. Defaults to
        'Sconosciuto (gruppo uova)'.
    - confs: Space-spearated string of predefined configurations names.
        Optional, defaults to no predefined configurations.
    - classes: Space-separated list of CSS classes. Optional, defaults to no
        CSS classes.
    - styles: CSS styles, in the format of an HTML style attribute values.
        Optional, defaults to no CSS styles.

    Examples:
        {{#invoke: Box | eggBox | Erba | | inline-block | margin: 3em; }}
        {{#invoke: Box | eggBox | egg = Erba | classes = inline-block |
            styles = margin: 3em; }}

In addition to the single box versions, also multiple box version are provided
for the shorthands. Their name is the same as the shorthand, with 'box'
replaced by 'list'. They are invoked the same way, except that the first
argument is a comma-separated list of types, egg groups, etc. The list can be
passed as first argument, or as the pluralized version of the single-box
versions (eg, types). The other arguments are applied to all generated boxes.
Some example calls below:

    - typeList: {{#invoke: Box | typeList | Elettro, Terra, Acciaio | |
        inline-block | margin: 3em; }}

    - eggList: {{#invoke: Box | eggList | eggs = Acqua 1, Campo, Magico |
        confs = tiny }}

--]]

local b = {}

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local css = require('Css')
local w = require('Wikilib')

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
local makeWikicodeInterface = function(luaFunction)
    return function(frame)
        local p = w.trimAll(table.copy(frame.args), false)
        return luaFunction(p)
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
        Box displaying a type. Arguments are both named and positional. The
        names are the ones listed below, while the order of the positional
        parameters is the one they are listed in.
            - type: The type, defaults to 'Sconosciuto'
            - confs: Table or space-spearated string of predefined
                configurations names. Optional, defaults to {}.
            - classes: Table/string of CSS classes, in the format parseClasses
                and printClasses produce respectively. Optional, defaults to {}.
            - styles: Table/string of CSS styles, in the format parseStyles and
                printStyles produce respectively. Optional, defaults to {}.
    --]]
    type = function(p)
        local type = p.type or p[1] or 'Sconosciuto'
        local pdfs = p.confs or p[2] or {}
        local classes, styles = p.classes or p[3] or {}, p.styles or p[4] or {}

        --[[
            Need table.copy for Box list functions: they pass the same table
            along to every item, and as tables are passed by reference we need
            a local copy for every item.
        --]]
        classes = table.copy(css.parseClasses(classes))
        table.insert(classes, 1, 'box-' .. type:lower())

        return {
            text = string.fu(type),
            confs = pdfs,
            classes = classes,
            styles = styles
        }
    end,

    --[[
        Box displaying anegg group. Arguments are both named and positional.
        The names are the ones listed below, while the order of the positional
        parameters is the one they are listed in.
            - egg: The egg group, without ' (gruppo uova)' suffix. Defaults to
                'Sconosciuto (gruppo uova)'
            - confs: Table or space-spearated string of predefined
                configurations names. Optional, defaults to {}.
            - classes: Table/string of CSS classes, in the format parseClasses
                and printClasses produce respectively. Optional, defaults to {}.
            - styles: Table/string of CSS styles, in the format parseStyles and
                printStyles produce respectively. Optional, defaults to {}.
    --]]
    egg = function(p)
        local egg = p.egg or p[1] or 'Sconosciuto (gruppo uova)'
        local pdfs, classes = p.confs or p[2] or {}, p.classes or p[3] or {}
        local styles = p.styles or p[4] or {}

        egg = string.fu(string.trim(egg))

        return {
            text = egg,
            link = egg .. ' (gruppo uova)',
            color = egg .. '_uova',
            confs = pdfs,
            classes = classes,
            styles = styles
        }
    end
}

--[[

Main function creating a box. Lua interface. Arguments are both named and
positional. The names are the ones listed below, while the order of the
positional parameters is the one they are listed in.

- text: displayed text.
- link: link target, Defaults to text.
- color: gradient color, from dark to normal, right-to-left.
- confs: Table or space-spearated string of predefined configurations names.
    Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Optional, defaults to {}.
- styles: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.
- textcolor: Text color, defaults to #FFFFFF

--]]
b.boxLua = function(p)
    local text, color = p.text or p[1], p.color or p[3]
    local link = p.link or p[2] or text
    local pdfs, classes = p.confs or p[4] or {}, p.classes or p[5] or {}
    local styles, textcolor = p.styles or p[6], p.textcolor or p[7]

    classes, styles = css.classesStyles(pdfs, classes, styles)

    if color or not table.empty(styles) then
        local bg = color
            and css.horizGradLua{color, 'dark', color, 'normale'}
            or ''

        styles = string.interp(' style="${bg}${style}"', {
            bg = bg,
            style = css.printStyles(styles)
        })
    else
        styles = ''
    end

    if textcolor and textcolor ~= 'FFF' then
        link = string.interp('${link}|<span style="color:#${tc}">${text}</span>', {
            link = link,
            tc = textcolor,
            text = text
        })
    elseif link ~= text then
        link = table.concat{link, '|', text}
    end

    return string.interp([=[<div class="box ${class}"${style}>[[${link}]]</div>]=], {
        class = css.printClasses(classes),
        style = styles,
        link = link
    })
end
b.box_lua = b.boxLua

--[[

Wikicode interface to boxLua. More info (but you won't likely need it if you
read till here ;) ), in the top comment.

--]]
b.box = makeWikicodeInterface(b.boxLua)
b.Box = b.box

--[[
    Generating exports for the shorthands: both lua and wikicode interfaces,
    both for list and single boxes.
--]]
for name, makeBoxArgs in pairs(b.shortHands) do

    --[[
        Lua interface: just calls b.boxLua with wathever the shorthand returns,
        given a single table containing all the (named) arguments.
    --]]
    local luaFunction = function(args)
        return b.boxLua(makeBoxArgs(args))
    end
    local wikicodeFunction = makeWikicodeInterface(luaFunction)

    -- Exporting single box interfaces
    export(name, 'box', luaFunction, wikicodeFunction)

    --[[
        List-of-boxes lua interface. One of the arguments is a sequence: from
        each item a box is generted, passing along the rest of the arguments,
        that are therefore the same for every item in the sequence. The
        sequence argument is the first in positional notation, while with
        named arguments its name is the pluralized name of the shorthand
        (eg. 'eggs').

        The sequence can be a table of strings or a comma-separated string.
    --]]
    local luaList = function(p)
        local itemsKey = name .. 's'
        local items = p[itemsKey] or p[1]

        -- Clearing keys so that p can be reused later
        p[itemsKey] = nil
        p[name] = nil

        if type(items) == 'string' then
            items = items == '' and {} or mw.text.split(items, ',%s*')
        end

        return w.mapAndConcat(items, function(item)
            p[name] = item
            return luaFunction(p)
        end)
    end
    local wikicodeList = makeWikicodeInterface(luaList)

    -- Exporting list interfaces
    export(name, 'list', luaList, wikicodeList)
end

return b
