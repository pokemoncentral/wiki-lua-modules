--[[

Utility functions and data about statistics.

--]]

local s = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local mg = require('Wikilib-multigen')
local gendata = require("Gens-data")
-- stylua: ignore end

--[[

Returns a stub for the generation span of the statistics
sum, which lacks the end. The starting generation is either
the passed one or the latest; the value itself is computed
from those of the passed statistics in such generation.

--]]
local makeSumSpan = function(stats, gen)
    gen = gen or gendata.latest

    return {
        val = s.statsSum(s.getStatsGen(stats, gen)),
        first = gen,
    }
end

-- Statistics order, split by generation
s.statsOrder = {
    [1] = { "hp", "atk", "def", "spec", "spe" },
    [2] = { "hp", "atk", "def", "spatk", "spdef", "spe" },
}
s.statsOrder[3], s.statsOrder[4] = s.statsOrder[2], s.statsOrder[2]
s.statsOrder[5], s.statsOrder[6] = s.statsOrder[2], s.statsOrder[2]
s.statsOrder[7], s.statsOrder[8] = s.statsOrder[2], s.statsOrder[2]
s.statsOrder[9] = s.statsOrder[2]

s.statsorder, s.stats_order = s.statsOrder, s.statsOrder

--[[

Removes statistics that don't exist in the passed
generation, eg, gen I special.

--]]
s.cleanStats = function(stats, gen)
    if gen == 1 then
        stats.spatk, stats.spdef = nil, nil
    else
        stats.spec = nil
    end

    return stats
end
s.cleanstats, s.clean_stats = s.cleanStats, s.cleanStats

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
    return s.cleanStats(mg.getGen(stats, gen), gen)
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
    return tab.fold(stats, 0, function(a, b)
        return a + b
    end)
end
s.statssum, s.stats_sum = s.statsSum, s.statsSum

--[[

Returns the generation spans for the statistics sum,
starting from the given generation. First generation
is not included.

--]]
s.spansSum = function(statSpans, startGen)
    --[[
        If stats have not changed throughout the
        generations, returning a single span beginning
        and ends in the latest generation.
    --]]
    if not s.didStatsChange(statSpans) then
        local sum = makeSumSpan(statSpans)
        sum.last = gendata.latest
        return { sum }
    end

    local sums = { makeSumSpan(statSpans, startGen) }

    for gen = startGen + 1, gendata.latest do
        -- Whether any stat changed in the current gen
        local anyChange = tab.any(statSpans, function(stat)
            return type(stat) == "table" and stat[gen]
        end)

        if anyChange then
            sums[#sums].last = gen - 1
            table.insert(sums, makeSumSpan(statSpans, gen))
        end
    end

    sums[#sums].last = gendata.latest
    return sums
end
s.spanssum, s.spans_sum = s.spansSum, s.spansSum

return s
