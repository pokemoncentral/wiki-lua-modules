--[[

This module deals with multi-generation
values in data modules.

--]]

local mg = {}

local tab = require('Wikilib-tables')
local gendata = require("Gens-data")

--[[

Returns the value of a property in
an entry for the given generation.

--]]
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

--[[

Returns whether a generation span covers the
whole interval of generations. The span can be
given as two arguments or as a table having
the values as first and second elements.

--]]
mg.isFullGenSpan = function(first, last)
    if type(first) == 'table' then
        first, last = first[1], first[2]
    end

    return first == 1 and last == gendata.latest
end
mg.isfullgenspan, mg.is_full_gen_span = mg.isFullGenSpan, mg.isFullGenSpan

--[[

If value is passed, returns the first and the last
generation for which it is valid in the given entry
property.
Otherwise, it returns a table wich associates every
value in the entry property with its first and last
generation of validity.

--]]
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

--[[

Extracts the value of the given generation for
every multi-generation property of the provided
entry.

--]]
mg.getGen = function(entry, gen)
    gen = gen or gendata.latest
    return table.map(entry, function(data)
        return mg.getGenValue(data, gen)
    end)
end
mg.getgen, mg.get_gen = mg.getGen, mg.getGen

--[[

Returns a table with generations spans of every
property in the entry, including multi-generation
ones, which will have an extra table nesting.

--]]
mg.getGenSpans = function(entry)
    return table.map(entry, mg.getGenSpan)
end
mg.getgenspans, mg.get_gen_spans = mg.getGenSpans, mg.getGenSpans

return mg
