--[[

Implementations of used functions
of mw module.

Source code from

--]]

local tab = require('Wikilib-tables')  -- luacheck: no unused

local splitByChar = function(str)
	local t = {}
	for index = 1, str:len() do
		table.insert(t, str:sub(index, index))
	end
	return t
end

local htmlencode_map = {
	['>'] = '&gt;',
	['<'] = '&lt;',
	['&'] = '&amp;',
	['"'] = '&quot;',
	["'"] = '&#039;',
	['\194\160'] = '&nbsp;',
}
local htmldecode_map = table.flip(htmlencode_map)

-- Title to return for a page. Can be changed for testing
local pagetitle = "mw"

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
			sep = sep or ', '
			lastSep = lastSep or ' e '

			if #tab > 1 then
				local last = table.remove(tab)
				return table.concat{table.concat(tab, sep), lastSep, last}
			else
				return table.concat(tab)
			end
		end,

		encode = function(s)
			local charset = table.keys(htmlencode_map)
			table.insert(charset, 1, '[')
			table.insert(charset, ']')
			return (s:gsub(table.concat(charset), function(decoded)
				if not htmlencode_map[decoded] then
					local encoded = string.format('&#%d;',
							encoded:byte())
					htmlencode_map[decoded] = encoded
					htmldecode_map[encoded] = decoded
				end
				return htmlencode_map[decoded]
			end))
		end,

		decode = function(s)
			return (s:gsub('(&(#?x?)([a-zA-Z0-9]+);)',
					function(encoded, flg, name)
				if not htmldecode_map[encoded] then
					local decoded = nil
					if flg == '#' then
						decoded = tonumber( name, 10 )
					elseif flg == '#x' then
						decoded = tonumber( name, 16 )
					end
					if decoded and decoded <= 0x10ffff then
						decoded = decoded:char()
						if decoded then
							htmldecode_map[encoded] = decoded
							htmlencode_map[decoded] = encoded
						end
					end
				end
				return htmldecode_map[encoded]
			end))
		end
    },

    clone = function(value)
		return type(value) ~= 'table' and value or
				table.map(value, function(x) return x end)
	end,

	title = {
		getCurrentTitle = function()
			return {
				text = pagetitle,
				rootText = pagetitle:gsub("^([^/]*)/.*$","%1"),
				baseText = pagetitle:gsub("^(.*)/[^/]*$","%1"),
				subpageText = pagetitle:gsub("^.*/([^/]*)$","%1"),
				isSubpage = pagetitle:find("/") and true or false,
			}
		end,
		-- Testing functions: changes the title returned by getCurrentTitle
		setTitle = function(title)
			pagetitle = title
		end,
	},
}
