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

"Responsive cells" means that they stack on desktops but they are side-by-side
on mobiles. As counter-intuitive as it might sound, it is assumed that the two
cells should be on a line on their own on mobiles.

Arguments:
    - cell1: The content of the first cell, as a string.
    - cell2: The content of the second cell, as a string. Any value evaluating
        to false will trigger the single-cell styles for cell1.
    - pdfs: Table or space-spearated string of predefined configurations names,
        to be used for both cells. Optional, defaults to {}.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.

Return:
    - 1: Complete wikicode table-cell containing cell1 adjusted to be
        responsive.
    - 2: Complete wikicode table-cell containing cell2 adjusted to be
        responsive, if passed. Otherwise, cell2 as it is given.

--]]
responsive.twoCells = function(cell1, cell2, pdfs, bp, classes, styles)
    local cellsCount = cell2 and 2 or 1
    classes, styles = css.classesStyles(predefs, pdfs, classes, styles)
    local cell = string.interp('| class="${cls} min-width-${bp}-${wd}" style="${sty}" | ',
        {
            cls = css.printClasses(classes),
            bp = bp or 'xs',
            wd = 70 / cellsCount,
            sty = css.printStyles(styles)
        })

    cell1 = cell .. cell1
    if cell2 then
        return cell1, cell .. cell2
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

This function returns the HTML code for two responsive boxe, given their
respective arguments passed as tables. For more information about responsive
boxes, read the comment to responsive.twoBoxes above.

The two boxes can be returned as two separate stirngs or be concatenated
together. If the second box is not passed, only the first one is returned.

Arguments:
    - box1: A table containing the arguments to boxLua in Box modules.
    - box2: A table containing the arguments to boxLua in Box modules.
        Any value evaluating to false will trigger the single-box styles
        for box1.
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

-- NOTE: no intentional wikicode interface. Really too complex to be worth it,
-- there's no way to group parameters for a single box.

--[[

This function returns the Wikicode for two responsive cells, given their
content. For more information about responsive cells, read the comment to
responsive.twoCells above. The two cells are concatenated together in one
Wikicode string.

Arguments:
    - cell1: The content of the first cell, as a string.
    - cell2: The content of the second cell, as a string. Any value evaluating
        to false will trigger the single-cell styles for cell1.
    - pdfs: Table or space-spearated string of predefined configurations names,
        to be used for both cells. Optional, defaults to {}.
    - bp: The breakpont the responsive design is triggered at. Defaults to xs.
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.

--]]
r.twoCellsLua = function(cell1, cell2, pdfs, bp, classes, styles)
    local cells = {responsive.twoCells(cell1, cell2, pdfs, bp,
        classes, styles)}
    return table.concat(cells, ' |')
end
r.two_cells_lua = r.twoCellsLua

--[[

Shortcut to return two responsive type boxes. For more information about
responsive boxes, read the comment to responsive.twoBoxes above. The first
type will have single-box styles if the second one is not passed, or it is
equal to the first type. The two boxes can be concatenated or returned as two
strings.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-box styles for type1.
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
r.twoTypeBoxesLua = function(args)
    local type1 = args.type1 or table.remove(args, 1)
    local type2 = args.type2 or table.remove(args, 1)
    local bp = args.bp or args[6]
    local concat = args.concat or args[7]

    local hasTwoTypes = type2 and type1 ~= type2

    local box1 = box.shortHand.type(table.merge({type1}, args))
    local box2 = type2
    if hasTwoTypes then
        box2 = box.shortHand.type(table.merge({type2}, args))
    end

	return responsive.twoBoxesLua(box1, box2, bp, concat)
end
r.two_type_boxes_lua = r.twoTypeBoxesLua


r.twoTypeBoxes = function(frame)
    local p = w.trimAll(frame.args, false)
    p.concat = true
    return r.twoTypeBoxes(p)
end

r.twoTypeCellsLua = function(args)
    local type1 = args.type1 or args[1]
    local type2 = args.type2 or args[2]
    local boxArgs = args.boxArgs or args[3]
    local cellArgs = args.cellArgs or args[4]
    local bp = args.bp or args[5]

    local hasTwoTypes = type2 and type1 ~= type2

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

Shortcut method returning two responsive cells containing two type boxes. For
more information about responsive cells, read the comment to
responsive.twoCells above. The first cell will have single-cell styles if the
second type is not passed, or it is equal to the first one.

Arguments:
    - type1: First type.
    - type2: Second type. Any value evaluating to false or equal to type1
        will trigger the single-cell styles for the first cell.
    - types: Table containing the arguments for typeBoxLua in the Box module,
        other than the type. Used for both type1 and type2.
    - cells: Table containing the arguments for twoCellsLua.

--]]
r.twoTypeCellsLua = function(type1, type2, types, cells)
    local box1 = box.typeBoxLua(type1, table.unpack(types))
    local box2 = type2
                 and type1 ~= type2
                 and box.typeBoxLua(type2, table.unpack(types))
    return r.twoCellsLua(box1, box2, table.unpack(cells))
end
r.two_type_cells_lua = r.twoTypeCellsLua

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
