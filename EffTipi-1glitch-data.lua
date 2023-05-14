-- Calcolo efficacia tipi per i tipi glitch ad uso esclusivamente interno
-- Non calcola i danni di una mossa di tipo glitch, permette solo di calcolare
-- i danni di un certo tipo di mossa contro un Pokémon con tipi glitch

local etg = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local et = require("EffTipi-1-data")
-- stylua: ignore end

local standardEff = { Uccello = 1, Glitch = 1, L = 1 }
standardEff["Pokémaniaco"] = 1
standardEff["(Classe dell'ultimo allenatore affrontato)"] = 1
standardEff["' ♀ ♀ ' 2222 37572"] = 1
standardEff["Poké BB"] = 1
standardEff["999"] = 1
standardEff["?"] = 1
standardEff["IIIItoto"] = 1
for key, value in pairs(standardEff) do
    standardEff[string.lower(key)] = value
end

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo
-- attaccante, il livello interno il difensore. Visto che non mettiamo i tipi
-- glitch nel DebRes, come tipi attaccanti ci sono solo quelli normali
etg.normale = tab.merge(et.normale, standardEff)
etg.fuoco = tab.merge(et.fuoco, standardEff)
etg.acqua = tab.merge(et.acqua, standardEff)
etg.elettro = tab.merge(et.elettro, standardEff)
etg.erba = tab.merge(et.erba, standardEff)
etg.ghiaccio = tab.merge(et.ghiaccio, standardEff)
etg.lotta = tab.merge(et.lotta, standardEff)
etg.veleno = tab.merge(et.veleno, standardEff)
etg.terra = tab.merge(et.terra, standardEff)
etg.volante = tab.merge(et.volante, standardEff)
etg.psico = tab.merge(et.psico, standardEff)
etg.coleottero = tab.merge(et.coleottero, standardEff)
etg.roccia = tab.merge(et.roccia, standardEff)
etg.spettro = tab.merge(et.spettro, standardEff)
etg.drago = tab.merge(et.drago, standardEff)
etg.coleot = etg.coleottero

return etg
