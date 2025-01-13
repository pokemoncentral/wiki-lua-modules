-- Data module for ability effectiveness. In a separate module because they
-- both get updated separately and are shared among generations.

local eta = {}

-- Abilities which alter type effectiveness. The first index is the ability
-- name, the second is the type, the value is the multiplier. For instance,
-- [Grassospesso][fuoco] = 0.5 because that abilty halves the damage dealt by
-- fire moves. Abilities with special effects, such as Filtro and Magidifesa,
-- are handled separately.
eta.ability = {}
eta.ability.levitazione = { terra = 0 }
eta.ability.grassospesso = { fuoco = 0.5, ghiaccio = 0.5 }
eta.ability.antifuoco = { fuoco = 0.5 }
eta.ability.fuocardore = { fuoco = 0 }
eta.ability.pellearsa = { fuoco = 1.25, acqua = 0 }
eta.ability.acquascolo = { acqua = 0 }
eta.ability.assorbacqua = eta.ability.acquascolo
eta.ability.parafulmine = { elettro = 0 }
eta.ability.elettrorapid = eta.ability.parafulmine
eta.ability.assorbivolt = eta.ability.parafulmine
eta.ability.mangiaerba = { erba = 0 }
eta.ability["mare primordiale"] = eta.ability.fuocardore
eta.ability["terra estrema"] = eta.ability.acquascolo
eta.ability["flusso delta"] = { elettro = 0.5, ghiaccio = 0.5, roccia = 0.5 }
eta.ability.bolladacqua = { fuoco = 0.5 }
eta.ability.morbidone = { fuoco = 2 }
eta.ability.bentostato = { fuoco = 0 }
eta.ability["sale purificante"] = { spettro = 0 }
eta.ability.mangiaterra = { terra = 0 }

-- Table holding, for all abilities, which types effectiveness it influences.
-- For instance, at index "pellearsa" there is a list containing "fuoco" and
-- "acqua". As an exception, abilities with special effects (such as Filtro)
-- are in this table with no type associated.
eta.modTypesAbil = {
    magidifesa = {},
    filtro = {},
    solidroccia = {},
    scudoprisma = {},
    teraguscio = {},
}
for abil, types in pairs(eta.ability) do
    eta.modTypesAbil[abil] = {}
    for t, _ in pairs(types) do
        table.insert(eta.modTypesAbil[abil], t)
    end
end

return eta
