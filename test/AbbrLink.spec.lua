-- "Test cases" for Abbrlink

local tab = require("Wikilib-tables")
local a = require("AbbrLink")

local testSuite = function(color)
    local args = tab.merge({ "Torre dei Cieli" }, color)
    local gamesArgs = tab.copy(args)
    gamesArgs.games = "S ROZA"
    local gamesArgsSplit = tab.copy(args)
    gamesArgsSplit.games = { "S", "ROZA" }
    local proxyArgs = tab.copy(args)
    proxyArgs.games = "RZ S ROZA"

    -- Lua test cases

    -- Full abbreviation in function name
    local fullLua = a.RZSROZALua(tab.copy(args))
    print(fullLua)

    -- Abbreviations in arguments
    local argsLua = a.RZLua(tab.copy(gamesArgs))
    print(argsLua)

    -- Abbreviations in split arguments
    local splitLua = a.RZLua(tab.copy(gamesArgsSplit))
    print(splitLua)

    -- Syntax equivalence
    assert(fullLua == argsLua, "syntax mismatch in lua API, full vs args")
    assert(fullLua == splitLua, "syntax mismatch in lua API, full vs split")
    -- No other case needed for transitivity of ==

    -- Wikicode test cases

    -- Full abbreviation in function name
    local fullWikicode = a.RZSROZA({ args = tab.copy(args) })
    print(fullWikicode)

    -- Abbreviations in argument
    local argsWikicode = a.RZ({ args = tab.copy(gamesArgs) })
    print(argsWikicode)

    -- proxy (all abbrs in games key)
    local proxyWikicode = a._abbr({ args = tab.copy(proxyArgs) })
    print(proxyWikicode)

    -- Syntax equivalence
    assert(
        fullWikicode == argsWikicode,
        "syntax mismatch in Wikicode API, full vs args"
    )
    assert(
        fullWikicode == proxyWikicode,
        "syntax mismatch in Wikicode API, full vs proxy"
    )
    -- No other case needed for transitivity of ==

    -- Wikicode and lua equivalence
    assert(fullLua == fullWikicode, "Lua and Wikicode API mismatch, full")
    assert(argsLua == argsWikicode, "Lua and Wikicode API mismatch, args")
end

-- Colorless test cases

testSuite({})

-- Hexadecimal color test cases

testSuite({ "7722AA" })

-- Named color test cases

testSuite({ "zaffiro", "dark" })

-- Named color shadeless test cases

testSuite({ "zaffiro" })
