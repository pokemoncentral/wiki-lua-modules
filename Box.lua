--[[

This module contains utility code for boxes: these are a link in a rounded
box, with a left-to-right gradient from the dark shade of a color to the
normal shade of the same color.

Shorthands are provided for boxes that display a type and lists of such boxes.

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
            string.fu(name) .. string.fu(suffix)}

    -- Aliases-dependent names (eg, boxTipoLua)
    if nameAliases then
        luaNames = table.merge(luaNames, table.flatMap(nameAliases,
                function(alias) return {alias .. 'Lua', alias .. '_lua'} end))
        wikicodeNames = table.merge(wikicodeNames. table.flatMap(nameAliases,
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

b.shortHands = {
    type = function(type, pdfs, classes, styles)
        type = string.fu(string.trim(type or 'Sconosciuto'))
        return type, type, type, pdfs, classes, styles, 'FFF'
    end,

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

Wikicode interface to boxLua. Arguments:

- 1: displayed text.
- 2: link target, Defaults to text.
- 3: gradient color, from dark to normal, right-to-left.
- 4: Space-spearated string of predefined configurations names. Optional,
    defaults to no predefined configurations.
- 5: Space-separated list of CSS classes. Optional, defaults to no CSS classes.
- 6: CSS styles, in the format of an HTML style attribute values. Optional,
    defaults to no CSS styles.
- 7: Text color, defaults to #FFFFFF

Example:

{{#invoke | Box | box | erba | erba (gruppo uova) | erba_uova | thin |
    inline-block width-sm-60 | padding: 2ex; margin-top: 0.5ex; | FFFFFF }}

--]]
b.box = makeWikicodeIntreface(b.boxLua)
b.Box = b.box

for name, makeBoxArgs in pairs(b.shortHands) do
    local luaFunction = function(...)
        return b.boxLua(makeBoxArgs(...))
    end
    local wikicodeFunction = makeWikicodeIntreface(luaFunction)

    export(name, 'box', luaFunction, wikicodeFunction)

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

    export(name, 'list', luaList, wikicodeList)
end

--[======[
--[[

Shortcut for creating a type box. Lua interface. Arguments:
- type: The type, defaults to 'Sconosciuto'
- pdfs: Table or space-spearated string of predefined configurations names.
    Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Optional, defaults to {}.
- styles: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.

--]]
b.typeBoxLua = function(type, pdfs, classes, styles)
    type = string.fu(string.trim(type or 'Sconosciuto'))
    return b.boxLua(type, type, type, pdfs, classes, styles, 'FFF')
end
b.type_box_lua = b.typeBoxLua
b.boxTipoLua, b.box_tipo_lua = b.typeBoxLua, b.typeBoxLua

--[[

Wikicode interface for typeBoxLua. Arguments:

- 1: The type. Defaults to 'Sconosciuto'.
- 2: Space-spearated string of predefined configurations names. Optional,
    defaults to no predefined configurations.
- 3: Space-separated list of CSS classes. Optional, defaults to no CSS classes.
- 4: CSS styles, in the format of an HTML style attribute values. Optional,
    defaults to no CSS styles.

Example:

{{#invoke | Box | typeBox | Elettro | thick | inline-block | margin: 3em; }}

--]]
b.typeBox = function(frame)
    local p = w.trimAll(mw.clone(frame.args), false)
    return b.typeBoxLua(unpack(p))
end
b.TypeBox, b.boxTipo, b.BoxTipo = b.typeBox, b.typeBox, b.typeBox

--[[

Shortcut for creating a list of type boxes. Arguments:
- types: The list of types, as a table of strings.
- pdfs: Table or space-spearated string of predefined configurations names.
    Used for every box in the list. Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Used for every box in the list.
    Optional, defaults to {}.

- styles: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.

--]]
b.typeListLua = function(types, pdfs, class, style)
    return table.concat(table.map(types, function(type)
        return b.typeBoxLua(type, pdfs, class, style)
    end))
end
b.type_list_lua = b.typeListLua
b.listTipoLua, b.list_tipo_lua = b.typeListLua, b.typeListLua

--[[

Wikicode interface for typeBoxLua. Arguments:

- 1: The list of types, as a comma-separated list. Spaces are ignored.
- 2: The predefined configuration names, as a space-separated list of string.
    Used for every box. Defaults to no predefined configuration.
- 3: CSS classes, as space-separated list. Used for every box.
    Defaults to no CSS class.
- 4: CSS styles, as an HTML style attribute value. Used for every box.
    Defaults to no CSS styles.

Example:

{{#invoke: Box | typeList | Normale, Acciaio,Terra | tiny | inline-block
        | padding: 2px; }}

--]]
b.typeList = function(frame)
    local p = w.trimAll(mw.clone(frame.args), false)
    local types = mw.text.split(table.remove(p, 1), ',%s*')
    return b.typeListLua(types, unpack(p))
end
b.TypeList, b.listTipo, b.ListTipo = b.typeList, b.typeList, b.typeList

--[[

Shortcut for creating an egg group box. Lua interface. Arguments:
- egg: The egg group, defaults to 'Sconosciuto (gruppo uova)'
- pdfs: Table or space-spearated string of predefined configurations names.
    Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Optional, defaults to {}.
- styles: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.

--]]
b.eggBoxLua = function(egg, pdfs, classes, styles)
    egg = string.fu(string.trim(egg or 'Sconosciuto (gruppo uova)'))
    return b.boxLua(egg, egg .. ' (gruppo uova)', egg .. '_uova', pdfs,
        classes, styles, 'FFF')
end
b.egg_box_lua = b.eggBoxLua

--[[

Wikicode interface for eggBoxLua. Arguments:

- 1: The egg group. Defaults to 'Sconosciuto (gruppo uova)'.
- 2: Space-spearated string of predefined configurations names. Optional,
    defaults to no predefined configurations.
- 3: Space-separated list of CSS classes. Optional, defaults to no CSS classes.
- 4: CSS styles, in the format of an HTML style attribute values. Optional,
    defaults to no CSS styles.

Example:

{{#invoke | Box | eggBox | Erba | thick | inline-block | margin: 3em; }}

--]]
b.eggBox = function(frame)
    local p = w.trimAll(mw.clone(frame.args), false)
    return b.eggBoxLua(unpack(p))
end
b.EggBox = b.eggBox

--]======]
return b
