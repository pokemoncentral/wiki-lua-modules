--[[

This module holds all complex mathematical
formulas used to work out game values

--]]

local f = {}

--[[--------------------------------------

                Stats

--]]--------------------------------------

f.stats = {}
f.stats[1] = {}
f.stats[3] = {}

-- Returns the HP value in gen I
f.stats[1].hp = function(iv, base, ev, level)
    return math.floor(level / 100 * ((base + iv) * 2
            + math.floor(math.ceil(math.sqrt(ev)) / 4)))
            + level + 10
end
f.stats[1].Hp, f.stats[1].HP = f.stats[1].hp, f.stats[1].hp

-- Returns the value of any other stat in gen I
f.stats[1].anyOther = function(iv, base, ev, level)
    return math.floor(level / 100 * ((base + iv) * 2
            + math.floor(math.ceil(math.sqrt(ev)) / 4)))
            + 5
end
f.stats[1].anyother, f.stats[1].any_other
        = f.stats[1].anyOther, f.stats[1].anyOther

-- Stats calculation is the same in gen I and gen II
f.stats[2] = f.stats[1]

-- Returns the HP value in gen III
f.stats[3].hp = function(iv, base, ev, level)
    return math.floor(level / 100 * (2 * base + iv
            + math.floor(ev / 4))) + level + 10
end
f.stats[3].Hp, f.stats[3].HP = f.stats[3].hp, f.stats[3].hp

-- Returns the value of any other stat in gen III
f.stats[3].anyOther = function(iv, base, ev, level, nature)
    return math.floor(nature * (5 + math.floor(
        level / 100 * (2 * base + iv + math.floor(
            ev / 4)))))
end
f.stats[3].anyother, f.stats[3].any_other
        = f.stats[3].anyOther, f.stats[3].anyOther

-- Stats calculation stays the same since gen III
f.stats[4], f.stats[5], f.stats[6], f.stats[7]
        = f.stats[3], f.stats[3], f.stats[3], f.stats[3]

return f
