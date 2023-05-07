-- Una tabella con tutti i valori del modulo Colorabbrev, per invocazioni interne

local h = {}

-- stylua: ignore
local b = require('Colorabbrev')

-- Not using map + filter to avoid creating a new table, as b is huge.
for a, c in pairs(b) do
    --[[
        By our internal conventions, functions beginning with an _ are not
        meant to be called with no arguments, neither to be included in this
        data module
    --]]
    if not a:find("^_+") then
        h[a] = c({ args = {} })
    end
end

return h
