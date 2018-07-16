-- "Test cases" for Abbrlink

local a = require('AbbrLink')

-- Lua test cases

-- Full abbreviation in function name
local fullLua = a.RZSROZALua{'Torre dei Cieli'}
print(fullLua)

-- Abbreviations in arguments
local argsLua = a.RZLua{games = 'S ROZA', 'Torre dei Cieli'}
print(argsLua)

-- Syntax equivalence
assert(fullLua == argsLua, 'syntax mismatch in lua API')

-- Wikicode test cases

-- Full abbreviation in function name
local fullWikicode = a.RZSROZA{args={'Torre dei Cieli'}}
print(fullWikicode)

-- Abbreviations in arguments
local argsWikicode = a.RZ{args={games = 'S ROZA', 'Torre dei Cieli'}}
print(argsWikicode)

-- Syntax equivalence
assert(fullWikicode == argsWikicode, 'syntax mismatch in Wikicode API')

-- Wikicode and lua equivalence
assert(fullLua == fullWikicode, 'Lua and Wikicode API mismatch')
assert(argsLua == argsWikicode, 'Lua and Wikicode API mismatch')
