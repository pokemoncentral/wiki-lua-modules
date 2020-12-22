--[[

This module deals with multi-generation
values in data modules.

--]]

local mg = {}

local tab = require('Wikilib-tables')  -- luacheck: no unused
local txt = require('Wikilib-strings') -- luacheck: no unused
local w = require('Wikilib')
local gendata = require("Gens-data")

--[[

Returns the value of a property in an entry for the given generation. The
generation defaults to the latest.

--]]
mg.getGenValue = function(data, gen)
    gen = gen or gendata.latest
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
Otherwise, it returns an array having a table for
every value with the following structure:
    - val: the value itself
    - first: the first generation the value is valid.
    - last: the last generation the value is valid.
The array is ordered by first generation.

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
            return {{
                val = data,
                first = 1,
                last = gendata.latest
            }}
        end

        local spans = {}
        for gen = 1, gendata.latest do
            local value = data[gen]
            if value then
                local first, last = mg.getGenSpan(data, value)
                table.insert(spans, {
                    val = value,
                    first = first,
                    last = last
                })
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

    --[[
        Passing mg.getGenSpan directly to table.map
        yelds wrong results, since it is always passed
        the key in the table as the second argument.
    --]]
    return table.map(entry, function(data)
        return mg.getGenSpan(data) end)
end
mg.getgenspans, mg.get_gen_spans = mg.getGenSpans, mg.getGenSpans

--[[

Returns whether the given entry has a
multi-generation proerty.

--]]
mg.hasMultiGen = function(entry)
    return table.any(entry, function(data)
        return type(data) == 'table' end)
end
mg.hasmultigen, mg.has_multi_gen = mg.hasMultiGen, mg.hasMultiGen

--[[

Prints a table of generation spans in the most
common way, that is every value on one line, with
relative first and last generation as superscripts.
The second argument is a function that returns a
string given the value, and defaults to tostring.
If there is only one span, no superscripts are
generated. When first and last generation are the
same, only one number is displayed.

--]]
mg.printSpans = function(spans, printVal)
    printVal = printVal or tostring
    if #spans == 1 then
        return printVal(spans[1].val)
    end

    return w.mapAndConcat(spans,
        function(data)
            local first = gendata[data.first].roman
            local bounds
            if data.last ~= data.first and data.last == gendata.latest then
                bounds = gendata[data.first].roman .. '+'
            else
                local last = gendata[data.last].roman
                bounds = table.concat(table.unique{first, last}, '-')
            end
            return string.interp('<div>${val}<sup style="padding-left: 0.3em;">${bounds}</sup></div>',
                {
                    val = printVal(data.val),
                    bounds = bounds,
                })
        end)
end
mg.printspans, mg.print_spans = mg.printSpans, mg.printSpans

return mg
