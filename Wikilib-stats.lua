--[[

Utility functions and data about statistics.

--]]

local s = {}

local tab = require('Wikilib-tables')
local mg = require('Wikilib-multigen')

-- Statistics order, split by generation
s.statsOrder = {
    [1] = {'hp', 'atk', 'def', 'spec', 'spe'},
    [2] = {'hp', 'atk', 'def', 'spatk', 'spdef', 'spe' }
}
s.statsOrder[3], s.statsOrder[4] = s.statsOrder[2], s.statsOrder[2]
s.statsOrder[5], s.statsOrder[6] = s.statsOrder[2], s.statsOrder[2]
s.statsOrder[7] = s.statsOrder[2]

s.statsorder, s.stats_order = s.statsOrder, s.statsOrder

--[[

Returns whether the statistics value changed
for a single Pokémon troughout the generations.

--]]
s.didStatsChange = function(stats)
    return stats.spec or mg.hasMultiGen(stats)
end
s.didstatchange, s.did_stat_change = s.didStatsChange, s.didStatsChange

--[[

Returns only the values for the provided generation
from a multi-generations statistics entry. It also
takes care of the special gen I statistic.

--]]
s.getStatsGen = function(stats, gen)
    stats = mg.getGen(stats, gen)
    if gen == 1 then
        stats.spatk, stats.spdef = nil, nil
    else
        stats.spec = nil
    end

    return stats
end
s.getstatsgen, s.get_stats_gen = s.getStatsGen, s.getStatsGen

--[[

Returns max value for both IV
and EV for the passed generation.

--]]
s.ivEvMax = function(gen)
    if gen < 3 then
        return 15, 2 ^ 16 - 1
    else
        return 31, 252
    end
end
s.ivevmax, s.iv_ev_max = s.ivEvMax, s.ivEvMax

--[[

Sums all the statistics up. Although
it's just a simple fold, it's tedious
to write it every time.

--]]
s.statsSum = function(stats)
    return table.fold(stats, 0, function(a, b)
        return a + b end)
end
s.statssum, s.stats_sum = s.statsSum, s.statsSum

return s
