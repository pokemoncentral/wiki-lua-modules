local p = {}

local str = require('Wikilib-strings') -- luacheck: no unused
local w = require('Wikilib')
local colorMod = require("Colore-data")
local colorschemeMod = require("Colorscheme-data")

local function _checkCol(col)
	if col <= 0.03928 then
      return col / 12.92
    end
    return ((col + 0.055) / 1.055) ^ 2.4
end

-- Given a color name and an optional shade, retrieve the corresponding hex
-- from modulo colore
local function getHexFromMod(color, shade)
	local colorData = colorMod[color]
	assert(colorData, "Unknown color name: " .. color)
	if type(colorData) == "table" then
		return colorData[shade or 'normale']
	else
		return colorData
	end
end

-- Given a background hex color, return the most appropriate text color. Lua
-- interface
p.forBgLua = function(bgColor)
	local bgR = _checkCol(tonumber(bgColor:sub(1, 2), 16) / 255)
	local bgG = _checkCol(tonumber(bgColor:sub(3, 4), 16) / 255)
	local bgB = _checkCol(tonumber(bgColor:sub(5, 6), 16) / 255)

	local L = (0.1426 * bgR) + (0.6152 * bgG) + (0.0512 * bgB)

	if L > 0.24 then
		return 'black-text'
	else
		return 'white-text'
	end
end
-- Given a background hex color, return the most appropriate text color
p.forBg = function(frame)
	return p.forBgLua(string.trim(frame.args[1]))
end

-- Given a background module color, return the most appropriate text color. Lua
-- interface
p.forModBgLua = function(color, shade)
	return p.forBgLua(getHexFromMod(color, shade))
end
-- Given a background module color, return the most appropriate text color
p.forModBg = function(frame)
	local args = w.trimAll(frame.args)
	return p.forModBgLua(args[1], args[2])
end

-- Given two background hex colors, return the most appropriate text color
-- calculated on the midpoint
p.forGradBgLua = function(c1, c2)
	local c1R = tonumber(c1:sub(1, 2), 16)
	local c1G = tonumber(c1:sub(3, 4), 16)
	local c1B = tonumber(c1:sub(5, 6), 16)

	local c2R = tonumber(c2:sub(1, 2), 16)
	local c2G = tonumber(c2:sub(3, 4), 16)
	local c2B = tonumber(c2:sub(5, 6), 16)

	local R = (c1R + c2R) / 2.15
	local G = (c1G + c2G) / 2.10
	local B = (c1B + c2B) / 2.15

	local midpointHex = string.format('%x%x%x', R, G, B)

	return p.forBgLua(midpointHex)
end
-- Given two background hex colors, return the most appropriate text color
-- calculated on the midpoint
p.forGradBg = function(frame)
	local args = w.trimAll(frame.args)
	return p.forGradBgLua(args[1], args[2])
end

-- Given two background module colors, return the most appropriate text color.
-- Lua interface
p.forModGradBgLua = function(col1, col2)
	if (not col2) or (col1 == col2) then
		return p.forModBgLua(col1)
	else
		return p.forGradBgLua(getHexFromMod(col1, "normale"),
							  getHexFromMod(col2, "normale"))
	end
end
-- Given two background module colors, return the most appropriate text color
p.forModGradBg = function(frame)
	local args = w.trimAll(frame.args)
	return p.forModGradBgLua(args[1], args[2] or args[1])
end

-- Given two background colorscheme names, return the most appropriate text
-- color
p.forModCsGradBg = function(frame)
	local args = w.trimAll(frame.args)
	local col = args[1]

	local hex1 = colorschemeMod[col]['light']
	local hex2 = colorschemeMod[col]['dark']

	return p.forGradBgLua(hex1, hex2)
end

return p
