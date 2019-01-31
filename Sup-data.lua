-- Una tabella con tutti i valori del modulo Sup, per invocazioni interne

local h = {}
local sup = require('Sup')

-- Not using map + filter to avoid creating a new table, as b is huge.
for a, s in pairs(sup) do

    --[[
        By our internal conventions, functions beginning with an _ are not
        meant to be called with no arguments, neither to be included in this
        data module
    --]]
    if not a:find('^_+') then
        h[a] = s{args={}}
    end
end

return h
