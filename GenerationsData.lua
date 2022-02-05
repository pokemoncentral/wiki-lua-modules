--[[

Module used as a frontend to wikicode for Gens-data module.

Each interface function is documented in its own comment, with examples.

--]]

local b = {}

local mw = require('mw')

local tab = require('Wikilib-tables')      -- luacheck: no unused
local str = require('Wikilib-strings')      -- luacheck: no unused
local css = require('Css')
local gens = require("Gens-data")
local c = require("Colore-data")


--[[

Return the number of the last (current) generation

Ex:
{{#invoke: GenerationsData | getLastGen }}  --> 8

--]]
b.getLastGen = function(frame)
    return gens.latest
end
b.GetLastGen = b.getLastGen

-- Internal function to convert a roman number to arabic. The number should
-- corespond to a generation.
local function roman2arabic(roman)
    return table.find(gens, function(gentab) return gentab.roman == roman end, ipairs)
end

-- Internal function to get the gens-data
local function genTable(gen)
    gen = roman2arabic(gen) or tonumber(gen)
    return gens[gen]
end

--[[

Return the ordinal number of the given generation (either an arabic or roman
number). The result is all lowercase.

Ex: {{#invoke: GenerationsData | getOrdinal | 4 }}    --> quarta
Ex: {{#invoke: GenerationsData | getOrdinal | III }}  --> terza

--]]
b.getOrdinal = function(frame)
    local gen = string.trim(frame.args[1])
    return genTable(gen).ext
end
b.GetOrdinal = b.getOrdinal

--[[

Return the region of the given generation (either an arabic or roman number).
The result is all lowercase.

Ex: {{#invoke: GenerationsData | getRegion | 4 }}    --> sinnoh
Ex: {{#invoke: GenerationsData | getRegion | III }}  --> hoenn

--]]
b.getRegion = function(frame)
    local gen = string.trim(frame.args[1])
    return genTable(gen).region
end
b.GetRegion = b.getRegion

--[[

Return the color of the region of the given generation (either an arabic or
roman number). This function behaves like a color module call: the first
argument is the generation, and the second is an (optional) shade.

Ex: {{#invoke: GenerationsData | getRegionColor | 4 }}           --> 9ECF17
Ex: {{#invoke: GenerationsData | getRegionColor | II | light }}  --> FFB287

--]]
b.getRegionColor = function(frame)
    local gen = string.trim(frame.args[1])
    local region = genTable(gen).region
    local shade = string.trim(frame.args[2] or "normale")
    return c[region][shade]
end
b.GetRegionColor = b.getRegionColor

--[[

Return the gradient of the region of the given generation (either an arabic or
roman number). The first argument is the generation, the second is a function
in module Css to invoke (such as horizGrad).

Ex: {{#invoke: GenerationsData | getRegionGradient | 8 | horizGrad }}
Ex: {{#invoke: GenerationsData | getRegionGradient | V | radialGrad }}

--]]
b.getRegionGradient = function(frame)
    local gen = string.trim(frame.args[1])
    local region = genTable(gen).region
    local func = string.trim(frame.args[2]) .. "Lua"
    return css[func]{ type = region }
end
b.GetRegionGradient = b.getRegionGradient

return b