-- Una tabella con tutti i valori del modulo Blackabbrev, per invocazioni interne

local h = {}
local b = require('Blackabbrev')

for a, c in pairs(b) do
    h[a] = c{args={}}
end

return h
