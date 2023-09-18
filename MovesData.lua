--[[

Module used as a frontend to wikicode for data modules relative to moves.

Each interface function is documented in its own comment, with examples.

--]]

local b = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local multigen = require('Wikilib-multigen')
local moves = require("Move-data")
-- stylua: ignore end

--[[

Returns type given move name.

--]]
b.getType = function(frame)
    return txt.fu(
        multigen.getGenValue(
            moves[txt.trim(frame.args[1]:lower())].type,
            tonumber(frame.args.gen)
        )
    )
end

b.get_type = b.getType

--[[

Returns damage category given move name.

--]]
b.getDamageCategory = function(frame)
    return txt.fu(
        multigen.getGenValue(
            moves[txt.trim(frame.args[1]:lower())].category,
            tonumber(frame.args.gen)
        )
    )
end

b.get_damage_category, b.getCat, b.get_cat =
    b.getDamageCategory, b.getDamageCategory, b.getDamageCategory

--[[

Returns power given move name.

--]]
b.getPower = function(frame)
    return multigen.getGenValue(
        moves[txt.trim(frame.args[1]:lower())].power,
        tonumber(frame.args.gen)
    )
end

b.get_power = b.getPower

--[[

Returns type given move name.

--]]
b.getAccuracy = function(frame)
    return multigen.getGenValue(
        moves[txt.trim(frame.args[1]:lower())].accuracy,
        tonumber(frame.args.gen)
    )
end

b.get_accuracy = b.getAccuracy

--[[

Returns type given move name.

--]]
b.getPP = function(frame)
    return multigen.getGenValue(
        moves[txt.trim(frame.args[1]:lower())].pp,
        tonumber(frame.args.gen)
    )
end

b.get_pp = b.getPP

return b
