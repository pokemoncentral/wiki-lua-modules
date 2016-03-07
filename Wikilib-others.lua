--[[

Libreria in cui finiscono le funzioni non
altrimenti categorizzabili

--]]

local ot = {}

--[[

Ritorna un numero random compreso tra i due
argomenti, presi come estremo inferiore (primo)
e superiore (secondo) dell'intervallo

--]]

ot.random = function(inf, sup)
	math.randomseed(os.time())
	if inf == nil then
		return math.random()
	elseif sup == nil then
		return math.random(inf)
	end
	return math.random(inf, sup)
end

ot.Random = ot.random

return ot
