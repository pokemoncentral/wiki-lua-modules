-- "Test cases" for GamesColorLinks

local tab = require("Wikilib-tables")
local gcl = require("GamesColorLinks")

local testSuite = function(games, colors)
    local asOneAbbr = table.concat(games)
    local firstGame = games[1]
    local restGames = tab.slice(games, 2)

    local args = tab.copy(colors)
    local gamesArgs = tab.copy(args)
    gamesArgs.games = table.concat(restGames, " ")
    local gamesArgsSplit = tab.copy(args)
    gamesArgsSplit.games = restGames
    local proxyArgs = tab.copy(args)
    proxyArgs.games = table.concat(games, " ")

    -- Lua test cases

    -- Full abbreviation in function name
    local fullLua = gcl[asOneAbbr .. "Lua"](tab.copy(args))
    print(fullLua, "-----")

    -- Abbreviations in arguments
    local argsLua = gcl[firstGame .. "Lua"](tab.copy(gamesArgs))
    print(argsLua, "-----")

    -- Abbreviations in split arguments
    local splitLua = gcl[firstGame .. "Lua"](tab.copy(gamesArgsSplit))
    print(splitLua, "-----")

    -- Syntax equivalence
    assert(fullLua == argsLua, "syntax mismatch in lua API, full vs args")
    assert(fullLua == splitLua, "syntax mismatch in lua API, full vs split")
    -- No other case needed for transitivity of ==

    -- Wikicode test cases

    -- Full abbreviation in function name
    local fullWikicode = gcl[asOneAbbr]({ args = tab.copy(args) })
    print(fullWikicode, "-----")

    -- Abbreviations in argument
    local argsWikicode = gcl[firstGame]({ args = tab.copy(gamesArgs) })
    print(argsWikicode, "-----")

    -- proxy (all abbrs in games key)
    local proxyWikicode = gcl._abbr({ args = tab.copy(proxyArgs) })
    print(proxyWikicode, "-----")

    -- Syntax equivalence
    assert(fullWikicode == argsWikicode, "syntax mismatch in Wikicode API")
    assert(fullWikicode == proxyWikicode, "syntax mismatch in Wikicode API")
    -- No other case needed for transitivity of ==

    -- Wikicode and lua equivalence
    assert(fullLua == fullWikicode, "Lua and Wikicode API mismatch, full")
    assert(argsLua == argsWikicode, "Lua and Wikicode API mismatch, args")
    assert(splitLua == argsWikicode, "Lua and Wikicode API mismatch, split")

    print("----------------")
end

-- 'e' in last link test cases

local eGames = { "RZ", "S", "ROZA" }

-- Colorless test cases

testSuite(tab.copy(eGames), {})

-- Hexadecimal color test cases

testSuite(tab.copy(eGames), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(eGames), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(eGames), { "zaffiro" })

-- 'e' as last seaprator test cases

local commaGames = { "RZ", "S" }

-- Colorless test cases

testSuite(tab.copy(commaGames), {})

-- Hexadecimal color test cases

testSuite(tab.copy(commaGames), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(commaGames), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(commaGames), { "zaffiro" })

-- Single link with two games test cases

local singlePairGame = { "RZ" }

-- Colorless test cases

testSuite(tab.copy(singlePairGame), {})

-- Hexadecimal color test cases

testSuite(tab.copy(singlePairGame), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(singlePairGame), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(singlePairGame), { "zaffiro" })

-- Single link with one game test cases

local singleGame = { "S" }

-- Colorless test cases

testSuite(tab.copy(singleGame), {})

-- Hexadecimal color test cases

testSuite(tab.copy(singleGame), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(singleGame), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(singleGame), { "zaffiro" })

-- LGPE tests (comma in game's name)

local lgpe = { "LGPE" }

-- Colorless test cases

testSuite(tab.copy(lgpe), {})

-- Hexadecimal color test cases

testSuite(tab.copy(lgpe), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(lgpe), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(lgpe), { "zaffiro" })

-- LGE tests (comma in game's name)

local lge = { "LGE" }

-- Colorless test cases

testSuite(tab.copy(lge), {})

-- Hexadecimal color test cases

testSuite(tab.copy(lge), { "7722AA" })

-- Named color test cases

testSuite(tab.copy(lge), { "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite(tab.copy(lge), { "zaffiro" })
