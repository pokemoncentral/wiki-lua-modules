-- "Test cases" for ndex and ndex-list

local ndex = require('Ndex')
local ndexlist = require('Ndex-list')
local nondex = require('test.LoadNondex')
nondex{ types = false }

-- Case tested:
--      Standard
--      Standard
--      Base form (with alternative forms)
--      Alternative form
--      Useless form
print(ndex.list{args={'067 398 487 487O 569Gi', color = 'alola'}})
print(ndex.list{args={'kubfu giratina aegislashS', color = 'unima'}})

-- Pokémon without ndex nor types
print(ndex.list{args={'snorlobello', color = 'hoenn'}})

-- ndex-list: only fourth gen to have a readable list
print(ndexlist.listgen{args={' 4 '}})
-- print(ndexlist.list{})
