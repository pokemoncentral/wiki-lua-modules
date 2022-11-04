-- Tests for multigame

local tab = require('Wikilib-tables')
local mg = require('MultigameNewFunctions')
local pokes = require("Poké-data")
local abils = require("PokéAbil-data")
local stats = require("PokéStats-data")
local dumper = require('static.dumper')

print("############################################")
print(dumper(tab.map(pokes.cleffa, mg.updateDataTable)))
print(dumper(tab.map(abils.cleffa, mg.updateDataTable)))
print(dumper(tab.map(stats.cleffa, mg.updateDataTable)))

print("############################################")

local function temp(game)
    print("   ", game)
    -- Poké-data
    local outdata = mg.getGame(tab.map(pokes.cleffa, mg.updateDataTable), "cleffa", "type", game)
    print(dumper(outdata, "pokes.cleffa"))
    -- PokéAbil-data
    local outdata = mg.getGame(tab.map(abils.cleffa, mg.updateDataTable), "cleffa", "abil", game)
    print(dumper(outdata, "abils.cleffa"))
    -- PokéStats-data
    local outdata = mg.getGame(tab.map(stats.cleffa, mg.updateDataTable), "cleffa", "stat", game)
    print(dumper(outdata, "stats.cleffa"))
end

temp("oa")
temp("pt")
temp("spsc")
temp("dlps")
temp("lpa")