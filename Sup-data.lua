-- Una tabella con tutti i valori del modulo Sup, per invocazioni interne

local tab = require('Wikilib-tables')
local sup = require('Sup')

return table.map(sup, function(value)
		return value()
	end)
