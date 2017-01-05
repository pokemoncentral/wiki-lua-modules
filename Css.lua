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

-- Prepends a comma to non-empty strings only
local prependComma = function(text)
	return text ~= '' and text .. ', ' or text
end

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
		[''] = '',
		['to right'] = 'left'
	},

	webkit = {
		[''] = '',
		['to right'] = 'left'
	}
}

-- Holds all kinds of wikicode input processing
local processInput = {}

--[[

Processes wikicode arguments from
gradient functions, returning the
requested color hexes.

First and third
arguments are color names, second
and fourth their respective variants.
Empty first variants default to 'normal',
empty second variants default to first ones.

If the first argument isn't a known color
it is assumed that first and second arguments
are hexes

--]]
processInput.gradient = function(args)
	local p = w.trimAll(args, true)

	if not c[p[1]] then
		return p[1], p[2]
	end

	local from = {
		name = p[1],
		variant = string.lower(p[2] or 'normale')
	}

	local to = {
		name = p[3] or from.name,
		variant = string.lower(p[4] or from.variant)
	}

	return c[from.name][from.variant], c[to.name][to.variant]
end

-- Holds all css generating functions
local styles = {}

-- Holds all gradient-generating functions
styles.gradient = {}

-- Generates styles for linear gradients
styles.gradient.linear = function(conf, from, to)
	return string.interp('background-size: 100%; background-image: -moz-linear-gradient(${mozConf}#${from}, #${to}); background-image: -webkit-linear-gradient(${webkitConf}#${from}, #${to}); background-image: linear-gradient(${conf}#${from}, #${to});',
		{
			conf = prependComma(conf),
			mozConf = prependComma(vendorMappings.gradient.moz[conf]),
			webkitConf = prependComma(vendorMappings.gradient.webkit[conf]),
			from = from,
			to = to
		})
end

-- Generates linear gradients styles
css.horizGradLua = function(from, fromVariant, to, toVariant)
	local args = {from, fromVariant, to, toVariant}
	return styles.gradient.linear('to right',
			processInput.gradient(args))
end
css.horiz_grad_lua = css.horizGradLua

--[[

Wikicode interface to generate
horizontal linear gradients styles

--]]
css['horiz-grad'] = function(frame)
	return styles.gradient.linear('to right',
			processInput.gradient(mw.clone(frame.args)))
end
css.horizGrad, css.horiz_grad = css['horiz-grad'], css['horiz-grad']

--[[

Wikicode interface to generate
horizontal linear gradients styles

--]]
css['vert-grad'] = function(frame)
	return styles.gradient.linear('',
			processInput.gradient(mw.clone(frame.args)))
end
css.vertGrad, css.vert_grad = css['vert-grad'], css['vert-grad']

for name, funct in pairs(css) do
	css[string.fu(name)] = funct
end

return css
