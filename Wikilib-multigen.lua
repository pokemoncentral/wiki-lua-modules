--[[

This module deals with multi-generation
values in data modules.

--]]

local mg = {}

local tab = require('Wikilib-tables')
local gendata = require("Gens-data")

mg.getGenValue = function(data, gen)
    if type(data) ~= 'table' then
        return data
    end

    for k = gen, 1, -1 do
        if data[k] then
            return data[k]
        end
    end
end
mg.getgenvalue, mg.get_gen_value = mg.getGenValue, mg.getGenValue

mg.getGenSpan = function(data, value)

    if value then
        if type(data) ~= 'table' then
            return 1, gendata.latest
        end

        local last, first = gendata.latest

        for gen = 1, gendata.latest do
            if data[gen] == value then
                first = gen
            elseif data[gen] and first then
                last = gen - 1
                break
            end
        end

        return first, last

    else
        if type(data) ~= 'table' then
            return {data = {1, gendata.latest}}
        end

        local spans = {}
        for gen = 1, gendata.latest do
            local value = data[gen]
            if value then
                spans[value] = {mg.genGenSpan(data, value)}
            end
        end
        return spans
    end
end
mg.getgenspan, mg.get_gen_span = mg.getGenSpan, mg.getGenSpan

mg.getGen = function(entry, gen)
    return table.map(entry, function(data)
        return mg.getGenValue(data, gen)
    end)
end
mg.getgen, mg.get_gen = mg.getGen, mg.getGen

mg.getGenSpans = function(entry)
    return table.map(entry, mg.getGenSpan)
end
mg.getgenspans, mg.get_gen_spans = mg.getGenSpans, mg.getGenSpans

return mg
