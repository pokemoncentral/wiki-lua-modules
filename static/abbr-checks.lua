--[[

This script checks some invariants we want to keep on alt forms abbr. It also
checks that some assumptions we make on Pokémon names hold (which we can't
control, but at least we know if we're fucked).

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

local formlib = require("Wikilib-forms")
local pokes = require("Poké-data")
local altforms = require("AltForms-data")
local uselessforms = require("UselessForms-data")

local allforms = formlib.allFormsData()

-- Return a list of pairs (abbr, name) for all abbrs in the provided data module
local function getAllAbbrs(data)
    local res = {}
    for k, v in pairs(data) do
        if k ~= "formgroups" then
            assert(v.names, "Key " .. k .. " does't have the names table")
            for abbr, _ in pairs(v.names) do
                table.insert({ res, k }, abbr)
            end
        end
    end
    return res
end

-- A form abbr should be made only of letters, and the first must be uppercase
local function isWellFormedAbbr(abbr)
    return string.match(abbr, "^%u%a*$") and true or false
end

-- We run all our checks on all three data "modules"
for _, data in ipairs({ altforms, uselessforms, allforms }) do
    local allAbbrs = getAllAbbrs(data)
    for abbr in pairs(allAbbrs) do
        assert(
            isWellFormedAbbr(abbr[1]),
            table.concat({
                "The abbr ",
                abbr[1],
                " for ",
                abbr[2],
                " is not well-formed.",
            })
        )
    end
end

-- Checks on Pokémon names
for _, poke in pairs(pokes) do
    -- We want to distinguish between names, ndexes and ndexes with abbrs
    assert(
        not string.match(poke.name, "^%d+%u%a*"),
        table.concat({
            "The name ",
            poke.name,
            " starts with a number followed by an abbr.",
        })
    )
    assert(
        not string.match(poke.name, "^%d+$"),
        table.concat({
            "The name ",
            poke.name,
            " is a number. If this is not an error, condolences.",
        })
    )
end

print("All checks succesfull!")
