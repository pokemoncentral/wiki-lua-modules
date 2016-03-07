-- Visto il grande utilizzo, i link neri dei giochi a partire dalle sigle

local gbl = {}

local gcl = require('GamesColorLinks')

-- Cicla sul modulo GamesColorLinks e inserisce, con la stessa chiave,
-- il link nero nel modulo corrente

for k, v in pairs(gcl) do
	gbl[k] = v{args={'000'}}
end

return gbl
