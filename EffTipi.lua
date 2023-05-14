--[[
Unified interface to compute effectiveness of an attack.

=========================== DEVELOPERS INFORMATIONS ===========================
Internally, there are a bunch of submodules containing data for different
things/generations. We mainly have submodules with tables of effectiveness for
gen 1, 2 and 6, plus a module for abilities. This module requires (mw.loaddata)
them, and uses the right one according to the generation.

--]]

local et = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local et1 = require("EffTipi-1")
local et2 = require("EffTipi-2")
local et6 = require("EffTipi-6")
local eta = require("EffTipi-abils")
-- stylua: ignore end

-- Get the right et for the given gen
local function getEtdata(gen)
    gen = tonumber(gen)
    if gen < 2 then
        return et1
    elseif gen < 6 then
        return et2
    else
        return et6
    end
end

-- Re-exporting modTypesAbil from EffTipi-abils
et.modTypesAbil = eta.modTypesAbil

-- Given a gen and a type, return the list of types to which the given type is
-- immune in the given gen. For instance, given any gen and "spettro", returns
-- a list with "normale" and "lotta" (in an unspecified order).
et.typeImmunesList = function(gen, type)
    local etdata = getEtdata(gen)
    local immunes = tab.filter(etdata, function(effs)
        return effs[type] == 0
    end)
    -- Any iterator is fine as we don't specify the order in the returned list
    return tab.keys(immunes)
end

-- Given gen and type, returns whether it has any immunity in that gen.
et.hasAnyImmunity = function(gen, type)
    local etdata = getEtdata(gen)
    return tab.any(etdata, function(effs)
        return effs[type] == 0
    end)
end

-- Compute the effectivenes, in the form of the multiplier. The first parameter
-- is the generation. Following parameters are, in order, type of the attack,
-- types of the target Pokémon and its ability. Everything should be lowercase.
et.efficacia = function(gen, atk, def1, def2, abil)
    local etdata = getEtdata(gen)

    -- Base effectiveness for two types
    local e = etdata[atk][def1]
    if def2 ~= def1 then
        e = e * etdata[atk][def2]
    end

    -- Ability
    if eta.ability[abil] and eta.ability[abil][atk] then
        return e * eta.ability[abil][atk]
    -- Filtro, Solidroccia and Scudoprisma
    elseif
        e >= 2
        and (abil == "filtro" or abil == "solidroccia" or abil == "scudoprisma")
    then
        return e * 0.75
    -- Magidifesa
    elseif e < 2 and abil == "magidifesa" then
        return 0
    end
    return e
end

-- Look for types satisfying the test, which is a one parameter function.
local function cerca_tipi(gen, test)
    local etdata = getEtdata(gen)
    local t = {}
    for k in pairs(etdata) do
        if k ~= "coleottero" and test(k) then
            table.insert(t, k)
        end
    end
    return t
end

-- Find all types which have effectiveness eff when attacking a Pokémon with
-- the given types and ability
et.difesa = function(gen, eff, tipo1, tipo2, abil)
    return cerca_tipi(gen, function(x)
        return et.efficacia(gen, x, tipo1, tipo2, abil) == eff
    end)
end

-- Trova tutti i tipi su cui tipo ha efficacia eff
-- Find all types against which the given type has effectiveness eff
et.attacco = function(gen, eff, tipo)
    return cerca_tipi(gen, function(x)
        return et.efficacia(gen, tipo, x, x, "nessuna") == eff
    end)
end

-- Returns whether the given ability changes at least one effectiveness of the
-- given type combination.
et.changesEffectiveness = function(gen, abil, types)
    -- I have no idea what this function does, but it works
    local abilMod = et.modTypesAbil[abil]
    local immType1 = et.typeImmunesList(gen, types.type1)
    local immType2 = et.typeImmunesList(gen, types.type2)
    local allImmunities = tab.merge(immType1, immType2)

    -- Ability doesn't modify any types
    if not abilMod then
        return false
    end
    -- The types don't have immunities
    if #allImmunities == 0 then
        return true
    end

    return tab.all(abilMod, function(type)
        return not tab.search(allImmunities, type)
    end)
end

-- Returns whether an ability gives immunity to a certain type. The arguments
-- are the ability and the type.
et.abilityGrantsImm = function(gen, abil, type)
    -- This implementation smells a bit, but handles Magidifesa automatically
    return 0 == et.efficacia(gen, type, "elettro", "elettro", abil)
end

return et
