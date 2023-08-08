--[[

This script computes unused and unique type combinations, based on the data
modules.

Usage:
    lua type-combinations.lua

--]]

-- Add the parent of the directory containing this script to package.path
-- NOTE: this works ONLY if the script is run from cmd, not if it's required
do
    -- Path is the path to the directory containing this script. If this is
    -- run from within the same directory it is empty, hence the check
    local path = arg[0]:match("(.-)[^/]+$")
    if path ~= "" then
        package.path = table.concat({ package.path, ";", path, "/../?.lua" })
    else
        package.path = table.concat({ package.path, ";../?.lua" })
    end
end

local tab = require("Wikilib-tables")
local txt = require("Wikilib-strings")
local pokes = require("Poké-data")
local evolib = require("Wikilib-evos")
local multigen = require("Wikilib-multigen")
local genlib = require("Wikilib-gens")
local wdata = require("Wikilib-data")

-- Input gen
-- local GEN = tonumber(arg[1])

-- Given a type, return its corresponding numeric value (used for types2idx)
local function type2val(t)
    if t == "coleottero" then
        t = "coleot"
    end
    -- This number is at most 3 ^ 17, which fits a 32-bit integer
    return 3 ^ (tab.search(wdata.allTypes, t) - 1)
end

-- Given a pair of types, return a numeric value corresponding to it
local function types2idx(type1, type2)
    -- This number is smaller than 3 ^ 18, which fits a 32-bit integer
    return type2val(type1) + type2val(type2 or type1)
end

-- Given a pair of types, print them (and possibly something else)
local function printCombination(types, extra)
    if not extra then
        extra = ""
    end
    if types[1] == types[2] then
        print(txt.fu(types[1]) .. extra)
    else
        print(table.concat({ txt.fu(types[1]), "/", txt.fu(types[2]), extra }))
    end
end

-- Return true if all the Pokémon in the given table are from the same evo tree
local function oneEvotree(mons)
    if not mons then
        return false
    end
    local firstPoke = string.lower(mons[1].name)
    return tab.all(tab.unique(mons), function(poke)
        return evolib.sameEvoLine(firstPoke, string.lower(poke.name))
    end)
end

-- List all type combinations, mapping the value to the pair
local allCombinations = {}
for _, t1 in ipairs(wdata.allTypes) do
    for _, t2 in ipairs(wdata.allTypes) do
        allCombinations[types2idx(t1, t2)] = { t2, t1 }
    end
end

-- Group Pokémon by type combination
local existing = tab.groupBy(
    tab.filter(pokes, function(p)
        return p.type1 ~= "sconosciuto" and p.type2 ~= "sconosciuto"
    end),
    function(p)
        return types2idx(
            multigen.getGenValue(p.type1),
            multigen.getGenValue(p.type2)
        )
    end
)

-- Unused types: they have an empty group
print("Unused type combinations:")
for idx, comb in pairs(allCombinations) do
    if not existing[idx] then
        printCombination(comb)
    end
end
print()

-- Unique types: all Pokémon in the group are from the same evo tree
print("Unique type combinations:")
for idx, comb in pairs(allCombinations) do
    if oneEvotree(existing[idx]) then
        printCombination(comb, " - " .. existing[idx][1].ndex)
    end
end
print()
