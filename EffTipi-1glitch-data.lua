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

-- We put et[k] second because we can't mw.clone an mw.loaddata table
etg.normale = tab.merge(standardEff, et.normale)
etg.fuoco = tab.merge(standardEff, et.fuoco)
etg.acqua = tab.merge(standardEff, et.acqua)
etg.elettro = tab.merge(standardEff, et.elettro)
etg.erba = tab.merge(standardEff, et.erba)
etg.ghiaccio = tab.merge(standardEff, et.ghiaccio)
etg.lotta = tab.merge(standardEff, et.lotta)
etg.veleno = tab.merge(standardEff, et.veleno)
etg.terra = tab.merge(standardEff, et.terra)
etg.volante = tab.merge(standardEff, et.volante)
etg.psico = tab.merge(standardEff, et.psico)
etg.coleottero = tab.merge(standardEff, et.coleottero)
etg.roccia = tab.merge(standardEff, et.roccia)
etg.spettro = tab.merge(standardEff, et.spettro)
etg.drago = tab.merge(standardEff, et.drago)
etg.coleot = etg.coleottero

return etg
