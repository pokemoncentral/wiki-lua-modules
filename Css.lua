--[[

This module holds CSS-generating functions.
Its main utility are reducing calls to
Colore module and adding vendor prefixes

--]]

local css = {}

local mw = require('mw')

local str = require('Wikilib-strings') -- luacheck: no unused
local w = require('Wikilib')
local c = require("Colore-data")

--[[

Holds mappings from standard values
to vendor-specific ones

--]]
local vendorMappings = {}

--[[

Gradient function first arguments
for vendor prefixes

--]]
vendorMappings.gradient = {
	moz = {
		horiz = function()
			return 'left'
		end,

		slanted = function(direction)
			return (direction:gsub('^%d+',
				function(angle)

					-- 360 - angle + 90
					return 450 - angle
				end))
		end
	},

	webkit = {
		horiz = function()
			return 'left'
		end,

		slanted = function(direction)
			return (direction:gsub('^%d+',
				function(angle)

					-- 360 - angle + 90
					return 450 - angle
				end))
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

-- Holds all kinds of wikicode input processing
local processInput = {}

--[[

Processes wikicode arguments from
gradient functions, returning hexes
for the passed colors. Takes a single
table holding the proper arguments,
that should be in one of the following
formats:

- color name, followed by shade. If
  the shade is not given, it defaults
  to 'normale'
- color hexadecimal, with or without
  leading hashtag
- color stop, either percentage or
  absolute length
- 'transparent', with ot without
  color stop
- any CSS gradient function first
  parameter value. Must be first as
  well

A convenience syntax can be used with
named parameters 'type1' (or 'type')
and 'type2': if type2 exists and it is
different from type1, then type1-normale
and type2-normale are returned; otherwise,
type1-light and type1-normale are.

--]]
processInput.gradient = function(args)

	--[[
		If a table is passed, then
		we are facing named parameters
	--]]
	local p = type(args[1]) == 'table'
			and args[1]
			or w.trimAll(args, false)

	-- Named parameters, as described above
	if p.type1 or p.type then
		p = w.emptyStringToNil(p)

		local type1, mod1 = (p.type1 or p.type)
				:match('^(%S+)%s*(.*)$')

		--[[
			Matching against type1 ensures
			mod1 is no propagated as well
		--]]
		local type2, mod2 = (p.type2 or type1)
				:match('^(%S+)%s*(.*)$')

		type1 = type1:lower()
		type2 = type2:lower()

		-- Cannot use and/or operator because nil is false
		if mod1 == '' then mod1 = nil end
		if mod2 == '' then mod2 = nil end

		table.insert(p, type1)
		table.insert(p, type1 == type2
				and 'light' or 'normale')
		table.insert(p, mod1)
		table.insert(p, type2)
		table.insert(p, 'normale')
		table.insert(p, mod2)

		p.type1, p.type2, p.type = nil, nil, nil

		return processInput.gradient(p)
	end

	-- Standard behavior
	local gradArgs, currColor = {}
	for _, param in ipairs(p) do
		param = param == '' and 'normale' or param

		-- Color name with no shade
		if type(currColor) == 'table'
				and not currColor[param]
		then
			table.insert(gradArgs, '#' .. currColor.normale)
			currColor = nil
		end

		--[[
			Color name: next parameter should
			be the shade, so nothing is appended
			to args now.

			not currColor is necesary due to
			'normale' being both a color and
			a shade
		--]]
		if not currColor and c[param] then
			currColor = c[param]

		-- Shade. Ready to append color now
		elseif type(currColor) =='table'
			and currColor[param]
		then
			table.insert(gradArgs, '#' .. currColor[param])
			currColor = nil

		--[[
			Hexadecimal colors: hashtag is always
			prefixed due to the regex matching
			only unprefixed hexes. Prefixed ones
			will match the else branch and be
			inserted correctly anyway.
		--]]
		elseif not param:find('%X') then
			table.insert(gradArgs, '#' .. param)

		-- Color stop: appending to last args
		elseif string.parseInt(param) then
			gradArgs[#gradArgs] = table.concat{
					gradArgs[#gradArgs],
					' ',
					param
			}

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

-- Holds all css generating functions
local styles = {}

-- Holds all gradient-generating functions
styles.gradient = {}

-- Generates styles for linear gradients
styles.gradient.linear = function(type, dir, colors)

	-- Accumulator table
	local css = {'background-size: 100%'}

	for _, funct in pairs(vendorMappings.linearGradients) do

		-- Cloning due to later table.insert
		local gradientArgs = mw.clone(colors)

		if type ~= 'vert' then
			local prefix = funct:match('^%-(%a+)%-')
			local dir = prefix
					and vendorMappings.gradient[prefix][type](dir)
					or dir

			table.insert(gradientArgs, 1, dir)
		end

		gradientArgs = table.concat(gradientArgs, ', ')

		table.insert(css, table.concat{'background-image: ',
			funct, '(', gradientArgs , ')'})
	end

	return table.concat(css, '; ') .. ';'
end

-- Generates styles for linear gradients
styles.gradient.radial = function(config, colors)
	colors = table.concat(colors, ', ')

	-- Accumulator table
	local css = {'background-size: 100%'}

	for _, funct in pairs(vendorMappings.radialGradients) do
		table.insert(css, table.concat{'background-image: ',
			funct, '(', config, ', ', colors, ')'})
	end

	return table.concat(css, '; ') .. ';'
end

-- Generates horizontal linear gradients styles
css.horizGradLua = function(args)
	return styles.gradient.linear('horiz', 'to right',
			processInput.gradient(args))
end
css.horiz_grad_lua = css.horizGradLua

-- Generates vertical linear gradients styles
css.vertGradLua = function(args)
	return styles.gradient.linear('vert', nil,
			processInput.gradient(args))
end
css.vert_grad_lua = css.vertGradLua

-- Generates slanted linear gradients styles
css.slantedGradLua = function(args)
	-- Angle taken before input processing because an angle is considered as and hexadecimal
	local angle = string.trim(args[1])
	args = processInput.gradient(args)
	table.remove(args, 1)

	return styles.gradient.linear('slanted',
			tonumber(angle) and angle .. 'deg' or angle,
			args
	)
end
css.slanted_grad_lua = css.slantedGradLua

-- Generates radial gradients styles
css.radialGradLua = function(args)
	args = processInput.gradient(args)
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

-- First uppercase aliases
for name, funct in pairs(css) do
	css[string.fu(name)] = funct
end

return css
