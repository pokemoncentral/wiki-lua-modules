--[[

This module is meant to make general utility code available to WikiCode,
mainly by just exporting built-in lua functions via thin wrappers.

--]]

local wc = {}

local w = require('Wikilib')
local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused

--[[

This function repeats a string a certain number of times, with an optional
separator. If the number parameter doesn't contain a number, the empty string
is returned.

Arguments:
    - 1, count: The number of times the string should be repeated.
    - 2, str: The string to be repeated.
    - 3, sep: The separator to be used. Defaults to the empty string.

Examples:

{{#invoke: Wc/Util | rep | 2 | 'SnorloBello' }}
        --> 'SnorloBelloSnorloBello'
{{#invoke: Wc/Util | rep | 2 | 'SnorloBello' | '-' }}
        --> 'SnorloBello-SnorloBello'
{{#invoke: Wc/Util | rep | count = 2 | str = 'SnorloBello' }}
        --> 'SnorloBelloSnorloBello'
{{#invoke: Wc/Util | rep | count = 2 | str = 'SnorloBello' | sep = '-' }}
        --> 'SnorloBello-SnorloBello'
--]]
wc.rep = function(frame)
	local p = w.trimAll(table.copy(frame.args))

    --[[
        str.rep returns the empty string if passed 0. So we use that as
        default for when the first parameter can't be cast to a number.
    --]]
    local count = tonumber(p[1] or p.count) or 0
    local str = p[2] or p.str
    local sep = p[3] or p.sep or ''

    --[[
        str.sub end index is inclusive, so we need the `- 1` there.
        Also, str:sub(1, -1) returns the whole string, so no problem for the
        empty separator.
    --]]
	return (str .. sep):rep(count):sub(1, -sep:len() - 1)
end
wc['repeat'] = wc.rep

-- Automatic first-uppercase aliases generation
for _, name in ipairs(table.keys(wc)) do
    wc[string.fu(name)] = wc[name]
end

return wc
