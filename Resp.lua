--[[

This module contains responsive utility code

--]]

local box = require('Box')
local css = require('Css')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local w = require('Wikilib')

local r = {}

--[[

This table holds predefined styles configurations. Names of such
configurations are the keys, while values are tables with 'classes' and
'styles' keys. These hold classes and styles respectively, and have as values
the same structures as parseClasses and parseStyles return.

--]]
local predefs = {
    ['one-box-cell'] = {
        classes = {},
        styles = {['height'] = '100%', ['padding'] = '1ex 0.8ex'}
    },

    ['type-cell'] = {
        classes = {},
        styles = {['padding'] = '1.2ex 0.6ex 1.2ex 0'}
    }
}

--[[

This function returns the wikicode interface for a given lua one.

Unlike Wikilib.stdWikicodeInterface, it does not map the empty string to nil:
in fact, the predefinite styles list of the Box module can be empty, and it is
in such cases that classes and styles are more important. However, with empty
string mapped to nil, classes and styles wouldn't be unpacked and passed to
the lua function, meaning that the box would basically be unstyled.

--]]
local makeWikicodeInterface = function(name, luaFunction)
    -- Will need to integrate the comment somewhere in the for loop
end

--[[

This function transforms in-place up to two boxes in responsive boxes, and
returns them after the transformation.

"Responsive boxes" means that they stack on desktops but they are side-by-side
on mobiles. As counter-intuitive as it might sound, it is assumed that the
boxes container is widened to full width on mobiles. On mobile, if only one box
is passed its maximum width is set ot 70, while when both boxes are present
their maximum width is set to 35.

Arguments:
    - box1: A BoxClass instance, as defined in the Box module.
    - box2: A BoxClass instance, as defined in the Box module. Any value
        evaluating to false will trigger the single-box styles for box1.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.

--]]
r.twoBoxesLua = function(box1, box2, bp)
    local boxesCount = box2 and 2 or 1
    local classes = {'inline-block-xs', string.interp('min-width-${bp}-${wd}',
        {bp = bp or 'xs', wd = 70 / boxesCount})}
    local styles = {['margin-bottom'] = '0.2ex', ['margin-left'] = '0.2ex',
        ['height'] = 100 / boxesCount .. '%'}

    -- Adding classes and styles to box1.
    box1:addClasses(classes):addStyles(styles)

    if not box2 then
        return box1
    end

    -- Adding classes and styles to box2, if defined.
    box2:addClasses(classes):addStyles(styles)

    return box1, box2
end
r.two_boxes_lua = r.twoBoxesLua

--[[

NOTE: don't worry, the wikicode version is planned. It will just use the same
classes, styles, confs... for both boxes for the sake of simplicity. I mean,
the fact that in lua you can have them different for the two boxes is more like
a nice-to-have that is also convenient to implement than an actual necessity.

--]]

--[[

This function returns up to responsive table cells as WikiCode strings, given
their content. If only one cell content is passed, or the two contents are
equal, then only one cell is returned.

"Responsive cells" only has effect on mobile contexts. If only one cell content
is passed, or the two contents are equal, the returned cell's maximum width is
set ot 70. On the other hand, when both contents are present, then the cells'
maximum width is set to 35.

Arguments are only named, that means they're passed as a single table by using
string keys. The table is modified in-place, so be sure to copy it before
calling this function if you need it unaltered afterwards. Arguments names are
the ones listed below.

Arguments:
    - cell1: The content of the first cell, as a string.
    - cell2: The content of the second cell, as a string. Any value evaluating
        to false will trigger the single-cell styles for cell1.
    - confs, pdfs: Table or space-spearated string of predefined configurations
    names, to be used for both cells. Optional, defaults to {}.
    - classes: A list of CSS classes to be used for both cells. Any format
        parseClasses takes in is accepted. Optional, defaults to {}.
    - styles: Some CSS styles to be used for both cells. Any format
        parseStyles takes in is accepted. Optional, defaults to {}.
    - bp: The breakpont the responsive design is triggered at. Defaults to 'xs'.

--]]
r.twoCellsLua = function(args)
    args.confs = args.confs or args.pdfs
    args.classes = css.parseClasses(args.classes or {})
    args.styles = css.parseStyles(args.styles or {})
    args.bp = args.bp or 'xs'

    local cellsCount = (args.cell2 and args.cell1 ~= args.cell2) and 2 or 1
    local classes, styles = css.classesStyles(args.confs, args.classes,
        args.styles)

    local cell = string.interp('| class="${cls} min-width-${bp}-${wd}" style="${sty}" | ',
        {
            cls = css.printClasses(classes),
            bp = args.bp,
            wd = 70 / cellsCount,
            sty = css.printStyles(styles)
        })

    local cell1 = cell .. args.cell1
    if args.cell2 then
        return cell1, cell .. args.cell2
    end
    return cell1
end
r.two_cells_lua = r.twoCellsLua

--[[

NOTE: Don't worry, the wikicode version is coming. I just forgot about it -_-"

--]]

for name, makeBoxInstance in pairs(box.shortHands) do
    local luaBoxesFunction = function(args)
        --[[
            It's safe not to remove args[name .. '1'] and args[name .. '2'],
            since both the box shorthands and the BoxClass constructor only
            use their own keys that they know about
        --]]
        local name1, name2 = args[name .. '1'], args[name .. '2']
        local hasTwoNames = name2 and name1 ~= name2

        local box1 = makeBoxInstance(table.merge({[name] = name1}, args))
        local box2 = name2
        if hasTwoNames then
            box2 = makeBoxInstance(table.merge({[name] = name2}, args))
        end

        return r.twoBoxesLua(box1, box2, args.bp)
    end
    local wikicodeBoxesFunction = function(frame)
        return table.concat({luaBoxesFunction(w.trimAll(frame.args, false))})
    end
    export(name, luaBoxesFunction, wikicodeBoxesFunction)

    local luaCellsFunction = function(args)
        args.boxArgs = args.boxArgs or {}
        args.cellArgs = args.cellArgs or {}

        --[[
            It's safe not to remove args[name .. '1'] and args[name .. '2'],
            since both the box shorthands and the BoxClass constructor only
            use their own keys that they know about
        --]]
        local name1, name2 = args[name .. '1'], args[name .. '2']
        local hasTwoNames = name2 and name1 ~= name2

        local box1 = makeBoxInstance(table.merge({[name] = name1},
            args.boxArgs))
        local box2 = name2
        if hasTwoNames then
            box2 = makeBoxInstance(table.merge({[name] = name2}, args.boxArgs))
        end

        local twoCellsArgs = table.merge({
            cell1 = tostring(box1),
            cell2 = tostring(box2),
            bp = args.bp
        }, args.cellArgs)
        return r.twoCellsLua(twoCellsArgs)
    end
    local wikicodeCellsFunction = function(frame)
        local p = w.trimAll(frame.args, false)
        local name1, name2 = p[name .. '1'], p[name .. '2']


        local boxArgs = pairsWithPrefixStripped(p, 'box')
        local cellArgs = pairsWithPrefixStripped(p, 'cell')

        return luaCellsFunction{
            [name .. '1'] = p[name .. '1'],
            [name .. '2'] = p[name .. '2'],
            bp = p.bp,
            boxArgs = boxArgs,
            cellArgs = cellArgs
        }
    end

    export(name, luaCellsFunction, wikicodeCellsFunction)
end

--[[

Shortcut to return two responsive type boxes. For more information about
responsive boxes, read the comment to r.twoBoxesLua above. The first type will
have single-box styles if the second one is not passed, or it is equal to the
first type.

Arguments are only named, that means they're passed as a single table by using
string keys. The table is modified in-place, so be sure to copy it before
calling this function if you need it unaltered afterwards. Arguments names are
the ones listed below.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-box styles for type1.
    - confs, pdfs: Table or space-spearated string of predefined configurations
        names, to be used for both boxes. Optional, defaults to {}.
    - classes: A list of CSS classes to be used for both boxes. Any format
        parseClasses takes in is accepted. Optional, defaults to {}.
    - styles: Some CSS styles to be used for both boxes. Any format
        parseStyles takes in is accepted. Optional, defaults to {}.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.

--]]
r.twoTypeBoxesLua = function(args)
    -- Will need to integrate these comments in the top, maybe with some 'type'
    -- replaced by 'egg' or the like
end
r.two_type_boxes_lua = r.twoTypeBoxesLua

--[[

Shortcut to return two responsive type boxes. For more information about
responsive boxes, read the comment to r.twoBoxesLua above. The first type will
have single-box styles if the second one is not passed, or it is equal to the
first type.

Arguments are only named. The names are the ones listed below.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-box styles for type1.
    - confs, pdfs: Space-spearated list of predefined configurations names,
        to be used for both boxes. Optional, defaults to an empty list.
    - classes: Space-spearated list of CSS classes to be used for both boxes.
        Optional, defaults to an empty list.
    - styles: Some CSS styles to be used for both boxes. Optional, defaults to
        no styles.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.

Example invocations:
    - {{#invoke: Resp | twoTypeBoxes | type1 = Elettro | type2 = Buio |
        confs = thick }}
    - {{#invoke: Resp | twoTypeBoxes | Erba | Lotta | classes = roundy-20 |
        styles = padding: 0.3em 0.5ex }}

--]]
r.twoTypeBoxes = function(frame)
    -- Will need to integrate these comments in the top, maybe with some 'type'
    -- replaced by 'egg' or the like
end

--[[

Shortcut method returning two responsive cells containing two type boxes. For
more information about responsive cells, read the comment to r.twoCellsLua
above. The first cell will have single-cell styles if the second type is not
passed, or it is equal to the first one.

Arguments are only named, that means they're passed as a single table by using
string keys. The table is modified in-place, so be sure to copy it before
calling this function if you need it unaltered afterwards. Arguments names are
the ones listed below.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-cell styles for the first cell.
    - boxArgs: Table containing the arguments to configure the boxes for both
        type1 and type2. Can be anything the BoxClass constructor takes in.
    - cellArgs: Table containing the arguments to configure both the cells. Can
        be any argument `twoCellsLua` takes in, except for the cells content.

--]]
r.twoTypeCellsLua = function(args)
    -- Will need to integrate these comments in the top, maybe with some 'type'
    -- replaced by 'egg' or the like
end

--[[

Returns the subtable whose keys have a given prefix. Such keys will have the
prefix stripped (e.g. {hodAA = 4, hodBB = 0, rikf = 3} --> {aA = 4, bB = 0})

TODO: Proper comments here

--]]
local pairsWithPrefixStripped = function(items, prefix)
    local filtered = table.filter(items, function(_, key)
        return key:find('^' .. prefix) end)
    local pairsWithStrippedKeys = table.map(filtered, function(item, key)
        local strippedKey = string.firstLowercase(key:sub(prefix:len()))
        return {[strippedKey] = item}
    end)

    local res = {}
    for key, value in pairs(pairsWithStrippedKeys) do
        res[key] = value
    end
    return res
end

--[[

Shortcut method returning two responsive cells containing two type boxes. For
more information about responsive cells, read the comment to r.twoCellsLua
above. The first cell will have single-cell styles if the second type is not
passed, or it is equal to the first one.

Arguments are only named. Some of the argument names follow a specific scheme:
- Argument names starting with 'box' are used to configure the two boxes. They
    can end with any of the named arguments accepted by the box function in the
    Box module. For example, 'boxClasses' or 'boxConfs'.
- Argument names starting with 'cell' are used to configure the two cells. They
    can end with any of the named arguments accepted by the twoCells function
    in this module (Resp). For example, 'cellClasses' or 'cellStyles'.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-cell styles for the first cell.
    - box*: Arguments for configuring both the boxes. Read above for more info.
    - cell*: Arguments for configuring both the cells. Read above for more
        information.

Examples:
    {{#invoke: Resp | twoTypeCells | type1 = Elettro | type2 = Lotta |
        boxConfs = thick | cellStyles = padding: 0.3ex }}

--]]
r.twoTypeCells = function(frame)
    -- Will need to integrate these comments in the top, maybe with some 'type'
    -- replaced by 'egg' or the like
end

return r
