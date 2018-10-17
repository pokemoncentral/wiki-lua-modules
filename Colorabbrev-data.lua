-- Una tabella con tutti i valori del modulo Colorabbrev, per invocazioni interne

local h = {}
local b = require('Colorabbrev')

for a, c in pairs(b) do
    h[a] = c{args={}}
end

return h
