-- "Test cases" for GamesColorLinks

local tab = require('Wikilib-tables')       -- luacheck: no unused
local gcl = require('GamesColorLinks')

local testSuite = function(games, colors)
    local allAbbrs = table.concat(games)
    local firstAbbr = table.remove(games, 1)

    local args = table.copy(colors)
    local gamesArgs = table.copy(args)
    gamesArgs.games = table.concat(games, ' ')
    local gamesArgsSplit = table.copy(args)
    gamesArgsSplit.games = games

    -- Lua test cases

    -- Full abbreviation in function name
    local fullLua = gcl[allAbbrs .. 'Lua'](table.copy(args))
    print(fullLua)

    -- Abbreviations in arguments
    local argsLua = gcl[firstAbbr .. 'Lua'](table.copy(gamesArgs))
    print(argsLua)

    -- Abbreviations in split arguments
    local splitLua = gcl[firstAbbr .. 'Lua'](table.copy(gamesArgsSplit))
    print(splitLua)

    -- Syntax equivalence
    assert(fullLua == argsLua, 'syntax mismatch in lua API, full vs args')
    assert(fullLua == splitLua, 'syntax mismatch in lua API, full vs split')
    assert(argsLua == splitLua, 'syntax mismatch in lua API, args vs split')

    -- Wikicode test cases

    -- Full abbreviation in function name
    local fullWikicode = gcl[allAbbrs]{args=table.copy(args)}
    print(fullWikicode)

    -- Abbreviations in argument
    local argsWikicode = gcl[firstAbbr]{args=table.copy(gamesArgs)}
    print(argsWikicode)

    -- Syntax equivalence
    assert(fullWikicode == argsWikicode, 'syntax mismatch in Wikicode API')

    -- Wikicode and lua equivalence
    assert(fullLua == fullWikicode, 'Lua and Wikicode API mismatch, full')
    assert(argsLua == argsWikicode, 'Lua and Wikicode API mismatch, args')
    assert(splitLua == argsWikicode, 'Lua and Wikicode API mismatch, split')
end

-- 'e' in last link test cases

local eGames = {'RZ', 'S', 'ROZA'}

-- Colorless test cases

testSuite(table.copy(eGames), {})

-- Hexadecimal color test cases

testSuite(table.copy(eGames), {'7722AA'})

-- Named color test cases

testSuite(table.copy(eGames), {'zaffiro', 'dark'})

-- Named color shadeless test cases

testSuite(table.copy(eGames), {'zaffiro'})

-- 'e' as last seaprator test cases

local commaGames = {'RZ', 'S'}

-- Colorless test cases

testSuite(table.copy(commaGames), {})

-- Hexadecimal color test cases

testSuite(table.copy(commaGames), {'7722AA'})

-- Named color test cases

testSuite(table.copy(commaGames), {'zaffiro', 'dark'})

-- Named color shadeless test cases

testSuite(table.copy(commaGames), {'zaffiro'})
