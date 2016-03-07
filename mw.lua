--[[

Implementations of used functions
of mw module.

Source code from

--]]

local tab = require('Wikilib-tables')

local splitByChar = function(str)
	local t = {}
	for index = 1, str:len() do
		table.insert(t, str:sub(index, index))
	end
	return t
end

return {
    text = {
        split = function(str, pattern, plain)
            local t, beg = {}, 1

			do
				local matchBeg, matchEnd = str:find(pattern, beg, plain)
								
				-- Empty string matched, and would do thoughout the string

				if matchBeg and matchBeg - 1 == matchEnd then
					return splitByChar(str)
				end
			end
	
            repeat
				local matchBeg, matchEnd = str:find(pattern, beg, plain)
				
				if matchBeg then
					table.insert(t, str:sub(beg, matchBeg - 1))
					beg = matchEnd + 1
				end
			until not matchBeg
			table.insert(t, str:sub(beg))

			return t
        end,
        
        listToText = function(tab, sep, lastSep)
			if #tab > 1 then
				local last = table.remove(tab)
				return table.concat{table.concat(tab, sep), lastSep, last}
			else
				return table.concat(tab)
			end
		end
    },
    
    clone = function(value)
		return type(value) ~= 'table' and value or
				table.map(value, function(x) return x end)
	end
}
