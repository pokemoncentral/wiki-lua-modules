--[[

This module contains responsive utility code

--]]

local box = require('Box')
local css = require('Css')
local tab = require('Wikilib-tables')       -- luacheck: no unused

local r = {}

--[[

This table holds predefined styles configurations. Names of such
configurations are the keys, while values are tables with 'classes' and
'styles' keys. These hold classes and styles respectively, and have as values
the same structures as arseClasses and parseStyles return.

--]]
local predefs = {
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
    - box1: A table containing the arguments to boxLua in Box modules.
    - box2: A table containing the arguments to boxLua in Box modules. Any
        value evaluating to false will trigger the single-box styles for box1.

Return:
    - 1: box1 adjusted to be responsive.
    - 2: box2 adjusted to be responsive, if passed. Otherwise, box2 as it is
        given.

--]]
responsive.twoBoxes = function(box1, box2)
    local boxesCount = box2 and 2 or 1

    local classes = {'inline-block-xs', 'min-width-xs-' .. 70 / boxesCount}
    local styles = {['margin-bottom'] = '0.2ex', ['margin-left'] = '0.2ex',
        ['height'] = 100 / boxesCount .. '%'}

    -- Adding classes and styles to box1.
    box1[5] = table.merge(css.parseClasses(box1[5] or {}), classes)
    box1[6] = table.merge(css.parseStyles(box1[6] or {}), styles)

    -- Adding classes and styles to box2, if defined.
    if box2 then
        box2[5] = table.merge(css.parseClasses(box2[5] or {}), classes)
        box2[6] = table.merge(css.parseStyles(box2[6] or {}), styles)
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
responsive.twoCells = function(cell1, cell2, pdfs, classes, styles)
    local cellsCount = cell2 and 2 or 1
    classes, styles = css.classesStyles(predefs, pdfs, classes, styles)
    local cell = string.interp('| class="${cls} min-width-xs-${xsWidth}" style="${sty}" | ',
        {
            cls = css.printClasses(classes),
            xsWidth = 70 / cellsCount,
            sty = css.printStyles(styles)
        })

    cell1 = cell .. cell1
    if cell2 then
        return cell1, cell .. cell2
    end
    return cell1, cell2
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
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoBoxesLua = function(box1, box2, concat)
    concat = concat or concat == nil

    box1, box2 = responsive.twoBoxes(box1, box2)
    box1 = box.boxLua(unpack(box1))

    if not box2 then
        return box1
    end

    box2 = box.boxLua(unpack(box2))
    if concat then
        return box1 .. box2
    end
    return box1, box2
end
r.two_boxes_lua = r.twoBoxesLua

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
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.

--]]
r.twoCellsLua = function(cell1, cell2, pdfs, classes, styles)
    local cells = {responsive.twoCells(cell1, cell2, pdfs, classes, styles)}
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
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoTypeBoxesLua = function(type1, type2, pdfs, classes, styles, concat)
    local hasTwoTypes = type2 and type1 ~= type2
    type1 = string.fu(string.trim(type1 or 'Sconosciuto'))
    type2 = hasTwoTypes and string.fu(string.trim(type2))

    local box1 = {type1, type1, type1, pdfs, classes, styles, 'FFF'}
    local box2 = hasTwoTypes and {type2, type2, type2, pdfs, classes, styles,
        'FFF'}
	return r.twoBoxesLua(box1, box2, concat)
end
r.two_type_boxes_lua = r.twoTypeBoxesLua

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
    - classes: Table/string of CSS classes, in the format parseClasses and
        printClasses produce respectively. Used for both cells. Optional,
        defaults to {}.
    - styles: Table/string of CSS styles, in the format parseStyles and
        printStyles produce respectively. Used for both cells. Optional,
        defaults to {}.
    - concat: whether the two boxes should be concatenated or they should be
        returned as two seaprate strings. Defaults to true.

--]]
r.twoEggBoxesLua = function(egg1, egg2, pdfs, classes, styles, concat)
    local hasTwoEggs = egg2 and egg1 ~= egg2
    egg1 = string.fu(string.trim(egg1))
    egg2 = hasTwoEggs and string.fu(string.trim(egg2))

    local box1 = {egg1, egg1 .. ' (gruppo uova)', egg1 .. '_uova', pdfs,
        classes, styles, 'FFF'}
    local box2 = hasTwoEggs and {egg2, egg2 .. ' (gruppo uova)',
        egg2 .. '_uova', pdfs, classes, styles, 'FFF'}
	return r.twoBoxesLua(box1, box2, concat)
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
    local box1 = box.typeBoxLua(type1, unpack(types))
    local box2 = type2 and type1 ~= type2 and box.typeBoxLua(type2,
        unpack(types))
    return r.twoCellsLua(box1, box2, unpack(cells))
end
r.two_type_cells_lua = r.twoTypeCellsLua

return r
