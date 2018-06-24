--[[

This module contains responsive utility code

--]]

local mw = require('mw')

local box = require('Box')
local css = require('Css')
local tab = require('Wikilib-tables')       -- luacheck: no unused

local predefs = {
    ['type-cell'] = {
        styles = 'padding: 1.2ex 0.3ex;'
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

    box1[4] = addClass(box1[4], classes)
    box1[5] = addStyle(box1[5], styles)

    if box2 then
        box2[4] = addClass(box2[4], classes)
        box2[5] = addStyle(box2[5], styles)
    end

    return box1, box2
end

responsive.twoCells = function(cell1, cell2, classes, styles, pdfs)
    local cellsCount = cell2 and 2 or 1
    classes, styles = css.predefs(classes, styles, predefs, pdfs)
    local cell = string.interp('| class="${cls} min-width-xs-${xsWidth}" style="${sty}" | ',
        {
            cls = classes,
            xsWidth = 70 / cellsCount,
            sty = styles
        })

    return cell .. cell1, cell2 and cell .. cell2
end

local r = {}

r.twoBoxesLua = function(box1, box2)
    box1, box2 = responsive.twoBoxes(box1, box2)
    box1 = box.boxLua(unpack(box1))

    if box2 then
        return box1, box2 and box.boxLua(unpack(box2))
    end
    return box1
end

r.two_boxes_lua = r.twoBoxesLua

r.twoCellsLua = function(cell1, cell2, classes, styles, pdfs)
    local cells = {responsive.twoCells(cell1, cell2, classes, styles, pdfs)}
    return table.concat(cells, ' || ')
end

r.two_cells_lua = r.twoCellsLua

r.twoTypeBoxesLua = function(type1, type2, classes, styles, pdfs)
    local hasTwoTypes = type2 and type1 ~= type2
    type1 = string.fu(string.trim(type1 or 'Sconosciuto'))
    type2 = hasTwoTypes and string.fu(string.trim(type2))

    local box1 = {type1, type1, type1, classes, styles, 'FFF', pdfs}
    local box2 = hasTwoTypes and {type2, type2, type2, classes, styles, 'FFF',
        pdfs}
	return r.twoBoxesLua(box1, box2)
end

r.two_type_boxes_lua = r.twoTypeBoxesLua

r.twoTypeCells = function(type1, type2, classes, styles, pdfsTypes, pdfsCells)
    local box1, box2 = r.twoTypeBoxesLua(type1, type2, classes, styles,
        pdfsTypes)
    return r.twoCellsLua(box1, box2, pdfsCells)
end

r.two_type_cells = r.twoTypeCells

return r
