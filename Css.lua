--[[

This module holds CSS-generating functions. Its main utility are reducing
calls to Colore module and adding vendor prefixes

--]]

local css = {}

local mw = require('mw')

local str = require('Wikilib-strings') -- luacheck: no unused
local w = require('Wikilib')
local c = require("Colore-data")

-- Holds mappings from standard values to vendor-specific ones
local vendorMappings = {}

-- Gradient function first arguments for vendor prefixes
vendorMappings.gradient = {
	moz = {
		horiz = function() return 'left' end,

		slanted = function(direction)
			return (direction:gsub('^%d+', function(angle)
                    return 450 - angle end)) -- 360 - angle + 90
		end
	},

	webkit = {
		horiz = function() return 'left' end,

        slanted = function(direction)
			return (direction:gsub('^%d+', function(angle)
                    return 450 - angle end)) -- 360 - angle + 90
		end
	}
}

-- All linear gradient function names
vendorMappings.linearGradients = {
	'-moz-linear-gradient',
	'-webkit-linear-gradient',
	'linear-gradient'
}

-- All radial gradient function names
vendorMappings.radialGradients = {
	'-moz-radial-gradient',
	'-ms-radial-gradient',
	'-o-radial-gradient',
	'-webkit-radial-gradient',
	'radial-gradient'
}

-- Holds parsing-related functions
local parser = {}

--[[

Processes wikicode arguments from gradient functions, returning hexes for the
passed colors. Takes a single table holding the proper arguments, that should
be in one of the following formats:

- color name, followed by shade. If the shade is not given, it defaults to
    'normale'.
- color hexadecimal, with or without leading hashtag.
- color stop, either percentage or absolute length.
- 'transparent', with ot without color stop.
- any CSS gradient function first parameter value. Must be first as well.

A convenience syntax can be used with named parameters 'type1' (or 'type')
and 'type2': if type2 exists and it is different from type1, then
type1-normale and type2-normale are returned; otherwise, type1-light and
type1-normale are.

--]]
parser.gradientArgs = function(args)
	-- If a table is passed, then we are facing named parameters
	local p = type(args[1]) == 'table' and args[1] or w.trimAll(args, false)

	-- Named parameters, as described above
	if p.type1 or p.type then
		p = w.emptyStringToNil(p)

		local type1, mod1 = (p.type1 or p.type):match('^(%S+)%s*(.*)$')

		-- Matching against type1 ensures mod1 is not propagated as well
		local type2, mod2 = (p.type2 or type1):match('^(%S+)%s*(.*)$')

		type1 = type1:lower()
		type2 = type2:lower()

		-- Cannot use and/or operator because nil is false
		if mod1 == '' then mod1 = nil end
		if mod2 == '' then mod2 = nil end

		table.insert(p, type1)
		table.insert(p, type1 == type2 and 'light' or 'normale')
		table.insert(p, mod1)
		table.insert(p, type2)
		table.insert(p, 'normale')
		table.insert(p, mod2)

		p.type1, p.type2, p.type = nil, nil, nil

		return parser.gradientArgs(p)
	end

	-- Standard behavior
	local gradArgs, currColor = {}
	for _, param in ipairs(p) do
		param = param == '' and 'normale' or param

		-- Color name with no shade
		if type(currColor) == 'table' and not currColor[param] then
			table.insert(gradArgs, '#' .. currColor.normale)
			currColor = nil
		end

		--[[
			Color name: next parameter should be the shade, so nothing is
            appended to args yet.

			`not currColor` is necesary due to 'normale' being both a color
            and a shade
		--]]
		if not currColor and c[param] then
			currColor = c[param]

		-- Shade. Ready to append color now
		elseif type(currColor) =='table' and currColor[param] then
			table.insert(gradArgs, '#' .. currColor[param])
			currColor = nil

		--[[
			Hexadecimal colors: hashtag is always prefixed due to the regex
            matching only unprefixed hexes. Prefixed ones will match the else
            branch and will be inserted correctly anyway.
		--]]
		elseif not param:find('%X') then
			table.insert(gradArgs, '#' .. param)

		-- Color stop: appending to last args
		elseif string.parseInt(param) then
			gradArgs[#gradArgs] = table.concat{gradArgs[#gradArgs], ' ',
					param}

		-- Trusting the user to enter valid CSS
		else
			table.insert(gradArgs, param)
		end
	end

	if type(currColor) == 'table' then
		table.insert(gradArgs, '#' .. currColor.normale)
	end

	return gradArgs
end

-- Parses an HTML class attribute value into a list of strings
parser.parseClasses = function(classes)
    return type(classes) == 'string' and mw.text.split(classes, ' ') or classes
end

-- Returns an HTML class attribute value from a list of class names
parser.printClasses = function(classes)
    return table.concat(classes, ' ')
end

--[[
    Parses an HTML style attribute value into a table. Keys are CSS property
    names and values their CSS values. Example:
        'margin: 2px 3px'; padding: 3px; color: #22AAEE;' -->
        {margin = '2px 3px', padding = '3px', 'color: #22AAEE'}
--]]
parser.parseStyles = function(stys)
    if type(stys) ~= 'string' then
        return stys
    end

    -- Empty strings break the split in the fold
    stys = table.filter(mw.text.split(stys, ';'), function(stmt)
        return stmt:find('%S') end)

    return table.fold(stys, {}, function(acc, stmt)
        local splits = w.trimAll(mw.text.split(stmt, ':'))
        acc[splits[1]] = splits[2]
        return acc
    end)
end

--[[
    Returns an HTML style attribute value from a table. Keys must be CSS
    property names and values their CSS values. Example:
        {margin = '2px 3px', padding = '3px', 'color: #22AAEE'} -->
        'margin: 2px 3px'; padding: 3px; color: #22AAEE;'
--]]
parser.printStyles = function(stys)
    return table.concat(table.mapToNum(stys, function(value, property)
            return table.concat{property, ': ', value}
        end), '; ') .. ';'
end

-- Holds all css generating functions
local styles = {}

-- Holds all gradient-generating functions
styles.gradient = {}

-- Generates styles for linear gradients
styles.gradient.linear = function(type, dir, colors)

	-- Accumulator table
	local acc = {'background-size: 100%'}

	for _, funct in pairs(vendorMappings.linearGradients) do

		-- Cloning due to later table.insert
		local gradientArgs = mw.clone(colors)

		if type ~= 'vert' then
			local prefix = funct:match('^%-(%a+)%-')
			local direction = prefix
					and vendorMappings.gradient[prefix][type](dir)
					or dir

			table.insert(gradientArgs, 1, direction)
		end

		gradientArgs = table.concat(gradientArgs, ', ')

		table.insert(acc, table.concat{'background-image: ',
			funct, '(', gradientArgs , ')'})
	end

	return table.concat(acc, '; ') .. ';'
end

-- Generates styles for linear gradients
styles.gradient.radial = function(config, colors)
	colors = table.concat(colors, ', ')

	-- Accumulator table
	local acc = {'background-size: 100%'}

	for _, funct in pairs(vendorMappings.radialGradients) do
		table.insert(acc, table.concat{'background-image: ',
			funct, '(', config, ', ', colors, ')'})
	end

	return table.concat(acc, '; ') .. ';'
end

--[[

This function returns classes and styles structured as parseClasses and
parseStyles would. These can be generated by both custom inputs and
predefinite configurations. Arguments:

- predefs: The table predefined configurations are taken from. Predefined
    configuration names are the keys, while values are tables with 'classes'
    and 'styles' keys. These hold classes and styles respectively, and have as
    values the same structures as arseClasses and parseStyles return.
- pdfs: Table or space-spearated string of predefined configurations names.
    Optional, defaults to {}.
- classes: Table/string of CSS classes, in the format parseClasses and
    printClasses produce respectively. Optional, defaults to {}.
- stys: Table/string of CSS styles, in the format parseStyles and
    printStyles produce respectively. Optional, defaults to {}.

--]]
styles.classesStyles = function(predefs, pdfs, classes, stys)
    classes = parser.parseClasses(classes or {})
    stys = parser.parseStyles(stys or {})

    if pdfs then
        pdfs = type(pdfs) == 'string' and mw.text.split(pdfs, ' ') or pdfs
        for _, predef in pairs(pdfs) do
            classes = table.merge(classes, predefs[predef].classes)
            --[[
                stys is the second argument of table.merge so that
                user-supplied styles override predefinite ones
            --]]
            stys = table.merge(predefs[predef].styles, stys)
        end
    end

    return classes, stys
end

-- Generates horizontal linear gradients styles
css.horizGradLua = function(args)
	return styles.gradient.linear('horiz', 'to right', parser.gradientArgs(args))
end
css.horiz_grad_lua = css.horizGradLua

-- Generates vertical linear gradients styles
css.vertGradLua = function(args)
	return styles.gradient.linear('vert', nil, parser.gradientArgs(args))
end
css.vert_grad_lua = css.vertGradLua

-- Generates slanted linear gradients styles
css.slantedGradLua = function(args)
	-- Angle is taken before input processing since it maches an hexadecimal
	local angle = string.trim(table.remove(args, 1))
    angle = tonumber(angle) and angle .. 'deg' or angle

    args = parser.gradientArgs(args)

	return styles.gradient.linear('slanted', angle, args)
end
css.slanted_grad_lua = css.slantedGradLua

-- Generates radial gradients styles
css.radialGradLua = function(args)
	args = parser.gradientArgs(args)
	local first = table.remove(args, 1)

	return styles.gradient.radial(first, args)
end
css.radial_grad_lua = css.radialGradLua

--[[

Wikicode interface to generate
horizontal linear gradients styles

--]]
css['horiz-grad'] = function(frame)
	return css.horizGradLua(mw.clone(frame.args))
end
css.horizGrad, css.horiz_grad = css['horiz-grad'], css['horiz-grad']

--[[

Wikicode interface to generate
vertical linear gradients styles

--]]
css['vert-grad'] = function(frame)
	return css.vertGradLua(mw.clone(frame.args))
end
css.vertGrad, css.vert_grad = css['vert-grad'], css['vert-grad']

--[[

Wikicode interface to generate
slanted linear gradients styles

--]]
css['slanted-grad'] = function(frame)
	return css.slantedGradLua(mw.clone(frame.args))
end
css.slantedGrad, css.slanted_grad =
		css['slanted-grad'], css['slanted-grad']

--[[

Wikicode interface to generate
radial gradients styles

--]]
css['radial-grad'] = function(frame)
	return css.radialGradLua(mw.clone(frame.args))
end
css.radialGrad, css.radial_grad =
		css['radial-grad'], css['radial-grad']

-- Exporting classesStyles to lua only
css.classesStyles = styles.classesStyles
css.classes_styles = css.classesStyles

-- Exporting parseClasses to lua only
css.parseClasses = parser.parseClasses
css.parse_classes = css.parseClasses

-- Exporting parseStyles to lua only
css.parseStyles = parser.parseStyles
css.parse_styles = css.parseStyles

-- Exporting printClasses to lua only
css.printClasses = parser.printClasses
css.print_classes = css.printClasses

-- Exporting printStyles to lua only
css.printStyles = parser.printStyles
css.print_styles = css.printStyles

-- First uppercase aliases
for name, funct in pairs(css) do
	css[string.fu(name)] = funct
end

return css
