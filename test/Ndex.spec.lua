-- "Test cases" for ndex and ndex-list

local ndex = require('Ndex')
local ndexlist = require('Ndex-list')
local nondex = require('test.LoadNondex')
local render = require('Render')
nondex{ types = false }

-- Cases tested:
--      Standard
--      Standard
--      Base form (with alternative forms)
--      Alternative form
--      Useless form
print(ndex.list{args={'067 398 487 487O 569Gi kubfu giratina aegislashS ', color = 'alola'}})

-- Pokémon without ndex nor types
print(ndex.list{args={'snorlobello', color = 'hoenn'}})

-- ndex-list: only fourth gen to have a readable list
print(ndexlist.listgen{args={' 8 '}})
-- print(ndexlist.list{})

-- manualEntry
print(ndex.header{args={'galar'}})
print(render.entry{args={ 'Ndex.manualEntry',
"[[€urshifu|urshifu|type1=lotta|type2=buio£]]",
"[[€urshifuGi|urshifu|type1=lotta|type2=buio£]]",
"[[€urshifuP|urshifu|type1=lotta|type2=acqua£]]",
"[[€urshifuPGi|urshifu|type1=lotta|type2=acqua£]]",
}})
print('</div>')
