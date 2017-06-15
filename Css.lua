--[[

This module holds CSS-generating functions.
Its main usefulness are reducing calls to
Colore module and adding vendor prefixes

--]]

local css = {}

local mw = require('mw')

local str = require('Wikilib-strings')
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
local linearGradientsFunctions = {
	'-moz-linear-gradient',
	'-webkit-linear-gradient',
	'linear-gradient'
}


-- Holds all kinds of wikicode input processing
local processInput = {}

--[[

Returns a list of color hexes from
a table of couples: first one is the
color name, second one the shade
(defaulting to normal)

--]]
processInput.parseCouples = function(args)
	local name = table.remove(args, 1)
	local shade = table.remove(args, 1)
	shade = (shade == '' or shade == nil)
			and 'normale'
			or shade

	if #args == 0 then
		return c[name][shade]
	end

	return c[name][shade], processInput.parseCouples(args)
end

--[[

Processes wikicode arguments from
gradient functions, returning the
requested color hexes.

Can take an arbitrary number of
arguments, as long as they are
organized in couples: first the color
name, then the shade (if the shade
is empty it defaults to 'normale').

If the first argument isn't a known
color, all arguments are assumed to
be hexes.

For two-color cases, there are special
rules: empty color name or shade default
to their counterpart of the first color.

--]]
processInput.gradient = function(args)
	local p = w.trimAll(args, false)

	-- Colore/data indexing fails, assuming hexes
	if not c[p[1]] then
		return unpack(p)
	end

	-- Two-color case special rules
	if #p < 5 then
		p = w.emptyStringToNil(p)

		local from = {
			name = p[1],
			shade = p[2] or 'normale'
		}

		local to = {
			name = p[3] or from.name,
			shade = p[4] or from.shade
		}

		return c[from.name][from.shade], c[to.name][to.shade]
	end

	-- Standard behavior
	return processInput.parseCouples(p)
end

-- Holds all css generating functions
local styles = {}

-- Holds all gradient-generating functions
styles.gradient = {}

-- Generates styles for linear gradients
styles.gradient.linear = function(type, dir, ...)

	-- Grouping variadic and adding # to hexes
	local colors = table.map({...}, function(hex)
		return hex:find('#') and hex or '#' .. hex
	end)

	-- Accumulator table
	local css = {'background-size: 100%'}

	for _, funct in pairs(linearGradientsFunctions) do

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

-- Generates horizontal linear gradients styles
css.horizGradLua = function(...)
	return styles.gradient.linear('horiz', 'to right',
			processInput.gradient({...}))
end
css.horiz_grad_lua = css.horizGradLua

-- Generates vertical linear gradients styles
css.vertGradLua = function(...)
	return styles.gradient.linear('vert', nil,
			processInput.gradient({...}))
end
css.vert_grad_lua = css.vertGradLua

-- Generates slanted linear gradients styles
css.slantedGradLua = function(...)
	local args = {...}
	local angle = table.remove(args, 1)

	return styles.gradient.linear('slanted',
			angle .. 'deg',
			processInput.gradient(args))
end
css.slanted_grad_lua = css.slantedGradLua

--[[

Generates horizontal gradients from one or two colors
With one color, create the gradient light-normal
With two different colors, create the gradient normal-normal
With two equal colors, create the gradient light-normal

--]]
css.horizGradTwoColorsLua = function(color1, color2)
	color2 = color2 or color1
	return styles.gradient.linear('horiz', 'to right',
			processInput.gradient({color1, c[color1].normale == c[color2].normale and 'light' or 'normale',
			color2, 'normale'}))
end
css.horiz_grad_lua = css.horizGradLua


--[[

Wikicode interface to generate
horizontal linear gradients styles

--]]
css['horiz-grad'] = function(frame)
	return styles.gradient.linear('horiz', 'to right',
			processInput.gradient(mw.clone(frame.args)))
end
css.horizGrad, css.horiz_grad = css['horiz-grad'], css['horiz-grad']

--[[

Wikicode interface to generate
vertical linear gradients styles

--]]
css['vert-grad'] = function(frame)
	return styles.gradient.linear('vert', nil,
			processInput.gradient(mw.clone(frame.args)))
end
css.vertGrad, css.vert_grad = css['vert-grad'], css['vert-grad']

--[[

Wikicode interface to generate
slanted linear gradients styles

--]]
css['slanted-grad'] = function(frame)
	local p = mw.clone(frame.args)
	local angle = string.trim(table.remove(p, 1))

	return styles.gradient.linear('slanted',
			angle .. 'deg',
			processInput.gradient(p))
end
css.slantedGrad, css.slanted_grad =
		css['slanted-grad'], css['slanted-grad']

--[[

Wikicode interface to generate
horizontal gradients from one or two colors

--]]
css['horiz-grad-two-colors'] = function(frame)
	return horizGradTwoColorsLua(frame.args[1], frame.args[2])
end
css.horizGradTwoColors, css.horiz_grad_two_colors = css['horiz-grad-two-colors'], css['horiz-grad-two-colors']

for name, funct in pairs(css) do
	css[string.fu(name)] = funct
end

return css
