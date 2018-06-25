--[[

This module contains responsive utility code

--]]

local box = require('Box')
local css = require('Css')
local tab = require('Wikilib-tables')       -- luacheck: no unused

local predefs = {
    ['type-cell'] = {
        styles = 'padding: 1.2ex 0.6ex 1.2ex 0;'
    }
}

local addClass = function(src, item)
    if not src then
        return item
    end

    if type(src) == 'table' then
        table.insert(src, item)
        return src
    end

    return table.concat{src, ' ', item}
end

local addStyle = function(src, item)
    if not src then
        return item
    end

    local isSrcTable = type(src) == 'table'
    local isItemTable = type(item) == 'table'

    if isSrcTable then
        if isItemTable then
            return table.merge(src, item)
        end
        table.insert(src, item)
        return table.concat(src, '; ') .. ';'
    end
    if isItemTable then
        table.insert(item, 1, src)
        return table.concat(item, '; ') .. ';'
    end
    return table.concat{src, '; ', item, ';'}
end

local responsive = {}

responsive.twoBoxes = function(box1, box2)
    local boxesCount = box2 and 2 or 1

    local classes = ' inline-block min-width-xl-100 min-width-xs-' ..
        70 / boxesCount
    local styles = table.concat{'margin-bottom: 0.2ex; margin-left: 0.2ex; height: ',
        100 / boxesCount, '%;'}

    box1[5] = addClass(box1[5], classes)
    box1[6] = addStyle(box1[6], styles)

    if box2 then
        box2[5] = addClass(box2[5], classes)
        box2[6] = addStyle(box2[6], styles)
    end

    return box1, box2
end

responsive.twoCells = function(cell1, cell2, pdfs, classes, styles)
    local cellsCount = cell2 and 2 or 1
    classes, styles = css.classesStyles(predefs, pdfs, classes, styles)
    local cell = string.interp('| class="${cls} min-width-xs-${xsWidth}" style="${sty}" | ',
        {
            cls = classes,
            xsWidth = 70 / cellsCount,
            sty = styles
        })

    if cell2 then
        return cell .. cell1, cell .. cell2
    end
    return cell .. cell1
end

local r = {}

r.twoBoxesLua = function(box1, box2, concat)
    concat = concat or concat == nil
    box1, box2 = responsive.twoBoxes(box1, box2)
    box1 = box.boxLua(unpack(box1))

    if box2 then
        box2 = box.boxLua(unpack(box2))
        if concat then
            return table.concat{box1, box2}
        end
        return box1, box2
    end
    return box1
end

r.two_boxes_lua = r.twoBoxesLua

r.twoCellsLua = function(cell1, cell2, pdfs, classes, styles)
    local cells = {responsive.twoCells(cell1, cell2, pdfs, classes, styles)}
    return table.concat(cells, ' |')
end

r.two_cells_lua = r.twoCellsLua

r.twoTypeBoxesLua = function(type1, type2, pdfs, classes, styles, concat)
    local hasTwoTypes = type1 ~= type2
    type1 = string.fu(string.trim(type1 or 'Sconosciuto'))
    type2 = hasTwoTypes and string.fu(string.trim(type2))

    local box1 = {type1, type1, type1, pdfs, classes, styles, 'FFF'}
    local box2 = hasTwoTypes and {type2, type2, type2, pdfs, classes, styles,
        'FFF'}
	return r.twoBoxesLua(box1, box2, concat)
end

r.two_type_boxes_lua = r.twoTypeBoxesLua

r.twoEggBoxesLua = function(egg1, egg2, pdfs, classes, styles, concat)
    local hasTwoEggs = egg1 ~= egg2
    egg1 = string.fu(string.trim(egg1))
    egg2 = hasTwoEggs and string.fu(string.trim(egg2))

    local box1 = {egg1, egg1 .. ' (gruppo uova)', egg1 .. '_uova', pdfs,
        classes, styles, 'FFF'}
    local box2 = hasTwoEggs and {egg2, egg2 .. ' (gruppo uova)',
        egg2 .. '_uova', pdfs, classes, styles, 'FFF'}
	return r.twoBoxesLua(box1, box2, concat)
end

r.two_egg_boxes_lua = r.twoEggBoxesLua

r.twoTypeCellsLua = function(type1, type2, types, cells)
    local box1 = box.boxTipoLua(type1, unpack(types))
    local box2 = type1 ~= type2 and box.boxTipoLua(type2, unpack(types))
    return r.twoCellsLua(box1, box2, unpack(cells))
end

r.two_type_cells_lua = r.twoTypeCellsLua

return r
