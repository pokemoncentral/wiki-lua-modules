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

-- This table contains utility functions dealing with responsive design.
local responsive = {}

--[[

This function transforms up to two boxes in responsive boxes. If only one box
is passed, some styles will be different. In particular, the maximum width is
set ot 70 on mobile, while when both boxes are present their maximum mobile
width is set to 35.

"Responsive boxes" means that they stack on desktops but they are side-by-side
on mobiles. As counter-intuitive as it might sound, it is assumed that the
boxes container is widened to full width on mobiles.

Arguments:
    - box1: A BoxClass instance, as defined in the Box module.
    - box2: A BoxClass instance, as defined in the Box module. Any value
        evaluating to false will trigger the single-box styles for box1.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.

Return:
    - 1: box1 adjusted to be responsive.
    - 2: box2 adjusted to be responsive, if passed. Otherwise, box2 as it is
        given.

--]]
responsive.twoBoxes = function(box1, box2, bp)
    local boxesCount = box2 and 2 or 1

    local classes = {'inline-block-xs', string.interp('min-width-${bp}-${wd}',
        {bp = bp or 'xs', wd = 70 / boxesCount})}
    local styles = {['margin-bottom'] = '0.2ex', ['margin-left'] = '0.2ex',
        ['height'] = 100 / boxesCount .. '%'}

    -- Adding classes and styles to box1.
    box1:addClasses(classes):addStyles(styles)

    -- Adding classes and styles to box2, if defined.
    if box2 then
        box2:addClasses(classes):addStyles(styles)
    end

    return box1, box2
end

--[[

This function transforms up to two table cells in responsive cells. If only
one cell is passed, some styles will be different. In particular, the maximum
width is set ot 70 on mobile, while when both boxes are present their maximum
mobile width is set to 35.

TODO: document that if cell1 and cell2 are equal then it's the same as not
passing cell2

"Responsive cells" means that they stack on desktops but they are side-by-side
on mobiles. As counter-intuitive as it might sound, it is assumed that the two
cells should be on a line on their own on mobiles.

Arguments are passed as a single table, both positionally, by using numeric
keys, and named, by using string keys. Arguments names for named calls are the
ones listed below, while the order for positional calls is the one they are
listed in.

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
    - bp: The breakpont the responsive design is triggered at. Defaults to
        'xs'.

Return:
    - 1: Complete wikicode table-cell containing cell1 adjusted to be
        responsive.
    - 2: Complete wikicode table-cell containing cell2 adjusted to be
        responsive, if passed. Otherwise, cell2 as it is given.

--]]
responsive.twoCells = function(args)
    args.cell1 = args.cell1 or args[1]
    args.cell2 = args.cell2 or args[2]
    args.confs = args.confs or args.pdfs or args[3]
    args.classes = css.parseClasses(args.classes or args[4] or {})
    args.styles = css.parseStyles(args.styles or args[5] or {})
    args.bp = args.bp or args[6]

    local cellsCount = (args.cell2 and args.cell1 ~= args.cell2) and 2 or 1
    local classes, styles = css.classesStyles(args.confs, args.classes,
        args.styles)

    local cell = string.interp('| class="${cls} min-width-${bp}-${wd}" style="${sty}" | ',
        {
            cls = css.printClasses(classes),
            bp = args.bp or 'xs',
            wd = 70 / cellsCount,
            sty = css.printStyles(styles)
        })

    local cell1 = cell .. args.cell1
    if args.cell2 then
        return cell1, cell .. args.cell2
    end
    return cell1
end

--[[

This function returns the wikicode interface for a given lua one.

Unlike Wikilib.stdWikicodeInterface, it does not map the empty string to nil:
in fact, the predefinite styles list of the Box module can be empty, and it is
in such cases that classes and styles are more important. However, with empty
string mapped to nil, classes and styles wouldn't be unpacked and passed to
the lua function, meaning that the box would basically be unstyled.

--]]
local makeWikicodeInterface = function(name, luaFunction)
    return function(frame)
        local p = w.trimAll(table.copy(frame.args), false)

        local name1, name2 = name .. '1', name .. '2'
        local first = table.remove(p, 1) or p[name1]
        local second = table.remove(p, 1) or p[name2]
        local bp, concat = p.bp, (p.concat or ''):lower() == 'yes'

        p[name1], p[name2], p.bp, p.concat = nil, nil, nil, nil

        local firstArgs = table.merge({name = first, first}, p)
        local secondArgs = table.merge({name = second, first}, p)

        return luaFunction(firstArgs, secondArgs, bp, concat)
    end
end

--[[

This function returns the HTML code for two responsive boxes, given two
BoxClass instances. For more information about responsive boxes, read the
comment to responsive.twoBoxes above.

The two boxes can be returned as two separate stirngs or be concatenated
together. If the second box is not passed, only the first one is returned.

Arguments:
    - box1: A BoxClass instance, as defined in the Box module.
    - box2: A BoxClass instance, as defined in the Box module. Any value
        evaluating to false will trigger the single-box styles for box1.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoBoxesLua = function(box1, box2, bp, concat)
    concat = concat or concat == nil

    box1, box2 = responsive.twoBoxes(box1, box2, bp)

    if not box2 then
        return tostring(box1)
    end

    if concat then
        return tostring(box1) .. tostring(box2)
    end
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

This function returns the Wikicode for two responsive cells, given their
content. For more information about responsive cells, read the comment to
responsive.twoCells above. The two cells are concatenated together in one
Wikicode string.

TODO: document that if cell1 and cell2 are equal then it's the same as not
passing cell2

Arguments are passed as a single table, both positionally, by using numeric
keys, and named, by using string keys. Arguments names for named calls are the
ones listed below, while the order for positional calls is the one they are
listed in.

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
    return table.concat(responsive.twoCells(args), ' |')
end
r.two_cells_lua = r.twoCellsLua

--[[

NOTE: Don't worry, the wikicode version is coming. I just forgot about it -_-"

--]]

--[[

Shortcut to return two responsive type boxes. For more information about
responsive boxes, read the comment to responsive.twoBoxes above. The first
type will have single-box styles if the second one is not passed, or it is
equal to the first type. The two boxes can be concatenated or returned as two
strings.

Arguments are passed as a single table, both positionally, by using numeric
keys, and named, by using string keys. Arguments names for named calls are the
ones listed below, while the order for positional calls is the one they are
listed in.

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
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoTypeBoxesLua = function(args)
    --[[
        Table.remove is called twice with index 1 because it is now the
        original second argument. This is due to the first original argument
        being removed by the first call to table.remove
    --]]
    local type1 = args.type1 or table.remove(args, 1)
    local type2 = args.type2 or table.remove(args, 1)
    local bp = args.bp or args[6]
    local concat = args.concat or args[7]

    local hasTwoTypes = type2 and type1 ~= type2

    --[[
        We need to pass in the type as the first argument, rather than as a
        named parameter, because it was removed from `args` a few lines above.
        This shifted all the other possible positional parameters in `args`
        by one position up, which creates an off-by-one offset in the
        positional arguments list. Therefore if we don't add the first
        positional parameter back, we break the positional argument passing
        altogether.
    --]]
    local box1 = box.shortHand.type(table.merge({type1}, args))
    local box2 = type2
    if hasTwoTypes then
        box2 = box.shortHand.type(table.merge({type2}, args))
    end

	return responsive.twoCellsLua(box1, box2, bp, concat)
end
r.two_type_boxes_lua = r.twoTypeBoxesLua

--[[

Shortcut to return two responsive type boxes. For more information about
responsive boxes, read the comment to responsive.twoBoxes above. The first
type will have single-box styles if the second one is not passed, or it is
equal to the first type.

Arguments can be both named or positional (unnamed) Arguments names for named
calls are the ones listed below, while the order for positional calls is the
one they are listed in.

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
    local p = w.trimAll(frame.args, false)
    p.concat = true
    return r.twoTypeBoxes(p)
end

--[[

Shortcut method returning two responsive cells containing two type boxes. For
more information about responsive cells, read the comment to
responsive.twoCells above. The first cell will have single-cell styles if the
second type is not passed, or it is equal to the first one.

Arguments are passed as a single table, both positionally, by using numeric
keys, and named, by using string keys. Arguments names for named calls are the
ones listed below, while the order for positional calls is the one they are
listed in.

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
    local type1 = args.type1 or args[1]
    local type2 = args.type2 or args[2]
    local boxArgs = args.boxArgs or args[3]
    local cellArgs = args.cellArgs or args[4]
    local bp = args.bp or args[5]

    local hasTwoTypes = type2 and type1 ~= type2

    --[[
        We need to pass in the type as the first argument, rather than as a
        named parameter, because it was removed from `args` a few lines above.
        This shifted all the other possible positional parameters in `args`
        by one position up, which creates an off-by-one offset in the
        positional arguments list. Therefore if we don't add the first
        positional parameter back, we break the positional argument passing
        altogether.
    --]]
    local box1 = box.shortHand.type(table.merge({type1}, boxArgs))
    local box2 = type2
    if hasTwoTypes then
        box2 = box.shortHand.type(table.merge({type2}, boxArgs))
    end

    local twoCellArgs = table.merge({
        cell1 = tostring(box1),
        cell2 = tostring(box2),
        bp = bp
    }, cellArgs)
	return responsive.twoBoxesLua(twoCellArgs)
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
more information about responsive cells, read the comment to
responsive.twoCells above. The first cell will have single-cell styles if the
second type is not passed, or it is equal to the first one.

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
    local type1 = frame.args.type1
    local type2 = frame.args.type2
    local bp = frame.args.bp

    local boxArgs = pairsWithPrefixStripped(frame.args, 'box')
    local cellArgs = pairsWithPrefixStripped(frame.args, 'cell')

    return r.twoTypeCellsLua{
        type1 = type1,
        type2 = type2,
        bp = bp,
        boxArgs = boxArgs,
        cellArgs = cellArgs
    }
end
<<<<<<< HEAD

=======
>>>>>>> d7f189c... Sketching twoTypeCells
--[[

Shortcut to return two responsive egg group boxes. For more information about
responsive boxes, read the comment to responsive.twoBoxes above. The first egg
group will have single-box styles if the second one is not passed, or it is
equal to the first one. The two boxes can be concatenated or returned as two
strings.

Arguments:
    - egg1: First egg group. No '(gruppo uova)' suffix is required.
    - type2: Second egg group. No '(gruppo uova)' suffix is required. Any
        value evaluating to false or equal to egg will trigger the single-box
        styles for egg1.
    - pdfs: Table or space-spearated string of predefined configurations names,
        to be used for both cells. Optional, defaults to {}.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoEggBoxesLua = function(egg1, egg2, pdfs, bp, classes, styles, concat)
    local hasTwoEggs = egg2 and egg1 ~= egg2
    egg1 = string.fu(string.trim(egg1))
    egg2 = hasTwoEggs and string.fu(string.trim(egg2))

    local box1 = box.shortHands.egg{egg1, pdfs, classes, styles}
    local box2 = hasTwoEggs and box.shortHands.egg{egg2, pdfs, classes, styles}
	return r.twoBoxesLua(box1, box2, bp, concat)
end
r.two_egg_boxes_lua = r.twoEggBoxesLua

--[[

Shortcut method returning two responsive cells containing two egg group boxes.
For more information about responsive cells, read the comment to
responsive.twoCells above. The first cell will have single-cell styles if the
second type is not passed, or it is equal to the first one.

Arguments:
    - type1: First egg group.
    - type2: Second egg group. Any value evaluating to false or equal to egg1
        will trigger the single-cell styles for the first cell.
    - eggs: Table containing the arguments for eggBoxLua in the Box module,
        other than the egg group. Used for both type1 and type2.
    - cells: Table containing the arguments for twoCellsLua.

--]]
r.eggsTwoCellsLua = function(egg1, egg2, eggs, cells)
    local box1 = box.eggBoxLua(egg1, table.unpack(eggs))
    local box2 = egg2
                 and egg1 ~= egg2
                 and box.eggBoxLua(egg2, table.unpack(eggs))
    return r.twoCellsLua(box1, box2, table.unpack(cells))
end
r.eggs_two_cells_lua = r.eggsTwoCellsLua

return r
