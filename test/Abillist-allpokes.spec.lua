-- "Test cases" for Abillist-allpokes

local a = require('Abillist-allpokes')

print(a.abillist())

print(a.listgen{args={" 5 "}})

-- Cases tested:
--      Standard
--      Standard
--      Base form (with alternative forms)
--      Alternative form
--      Useless form
print(a.list{args={'abra staraptor goomy giratina giratinaO aegislashS', color = 'paldea'}})
