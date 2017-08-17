--[[

This module holds all complex mathematical
formulas used to work out game values

--]]

local f = {}

-- Returns the HP value
f.hp = function(iv, base, ev, level)
    return math.floor(level / 100 * (2 * base + iv
            + math.floor(ev / 4))) + level + 10
end
f.Hp, f.HP = f.hp, f.hp

-- Returns the value of any stat other than HP
f.stat = function(iv, base, ev, level, nature)
    return math.floor(nature * (5 + math.floor(
        level / 100 * (2 * base + iv + math.floor(
            ev / 4)))))
end
f.Stat = f.stat

return f
