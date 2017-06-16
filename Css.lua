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

There are two named parameters: type and
type2. If there is type, the gradient uses
this color and the type2 color (if any),
with shade light-normal (with one color)
or normal-normal (with two colors)

--]]
processInput.gradient = function(args)
	-- Lua named parameters
	local p = type(args[1]) == 'table' and args[1] or w.trimAll(args, false)

	-- if p.type then custom behavior
	if p.type then
		p = w.trimAll(p, true)
		p.type2 = p.type2 or p.type
		local monoType = p.type:lower() == p.type2:lower()
		return c[p.type][monoType and 'light' or 'normale'], c[p.type2]['normale']
	end

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

for name, funct in pairs(css) do
	css[string.fu(name)] = funct
end
--print(css.horizGrad{args={'acciaio', 'normale', 'ghiaccio', 'normale', type='Acqua', type2=' '}})
return css
