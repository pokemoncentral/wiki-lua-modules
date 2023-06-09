-- Calcolo efficacia tipi per i tipi glitch ad uso esclusivamente interno
-- Non calcola i danni di una mossa di tipo glitch, permette solo di calcolare
-- i danni di un certo tipo di mossa contro un Pokémon con tipi glitch

local etg = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local et = require("EffTipi-2-data")
-- stylua: ignore end

--[[

Glitch
???
B
'l) m) ZM (come acciaio)
Normale (glitch)
Grinta (come Normale)
Grazia (come Normale)
Sconosciuto

--]]

local glitchEff = {}
-- stylua: ignore start
glitchEff.normale = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.fuoco = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 2, ["Normale (glitch)"] = 1}
glitchEff.acqua = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 1, ["Normale (glitch)"] = 1}
glitchEff.elettro = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 1, ["Normale (glitch)"] = 1}
glitchEff.erba = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.ghiaccio = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.lotta = {Glitch = 1, Uccello = 1, B = 1, Grinta = 2, Grazia = 2, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 2, ["Normale (glitch)"] = 1}
glitchEff.veleno = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0, ["Normale (glitch)"] = 1}
glitchEff.terra = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 2, ["Normale (glitch)"] = 1}
glitchEff.volante = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.psico = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.coleottero = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.roccia = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.spettro = {Glitch = 1, Uccello = 1, B = 1, Grinta = 0, Grazia = 0, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.drago = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.buio = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
glitchEff.acciaio = {Glitch = 1, Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1, ['???'] = 1, ["'l) m) ZM"] = 0.5, ["Normale (glitch)"] = 1}
-- stylua: ignore end
for _, eff in pairs(glitchEff) do
    for key, value in pairs(eff) do
        eff[string.lower(key)] = value
    end
end

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo
-- attaccante, il livello interno il difensore. Visto che non mettiamo i tipi
-- glitch nel DebRes, come tipi attaccanti ci sono solo quelli normali
for k, v in pairs(glitchEff) do
    -- We put et[k] second because we can't mw.clone an mw.loaddata table
    etg[k] = tab.merge(v, et[k])
end
etg.coleot = etg.coleottero

return etg
