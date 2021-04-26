local p = {}

local tab = require('Wikilib-tables')  -- luacheck: no unused
local w = require('Wikilib')
local colorMod = require("Colore-data")
local colorschemeMod = require("Colorscheme-data")

local function _checkCol(col)
	if col <= 0.03928 then
      return col / 12.92
    end
    return ((col + 0.055) / 1.055) ^ 2.4
end

-- given a background hex color, return the most appropriate text color
p.forBg = function(frame)
	local bgColor = frame.args[1]
	
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

-- given a background module color, return the most appropriate text color
p.forModBg = function(frame)
	local args = w.trimAll(frame.args)
	local color = args[1]
	local shade = args[2] or 'normale'
	
	local colorHex = colorMod[color][shade]
	
	return p.forBg{args={colorHex}}
end

-- given two background hex colors, return the most appropriate text color
-- calculated on the midpoint
p.forGradBg = function(frame)
	local args = w.trimAll(frame.args)
	local c1 = args[1]
	local c2 = args[2]
	
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
	
	return p.forBg{args={midpointHex}}
end

-- given two background module colors, return the most appropriate text color
-- calculated on the midpoint
p.forModGradBg = function(frame)
	local args = w.trimAll(frame.args)
	local col1 = args[1]
	local col2 = args[2] or args[1]

	if col1 == col2 then
		return p.forModBg{args={col1}}
		-- return p.forGradBg{args={colorMod[col1]['light'], colorMod[col2]['normale']}}
	else
		return p.forGradBg{args={colorMod[col1]['normale'], colorMod[col2]['normale']}}
	end
end

-- same as above but with colorscheme
p.forModCsGradBg = function(frame)
	local args = w.trimAll(frame.args)
	local col = args[1]
	
	local hex1 = colorschemeMod[col]['light']
	local hex2 = colorschemeMod[col]['dark']
	
	return p.forGradBg{args={hex1, hex2}}
end

return p
