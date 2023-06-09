--[[

Modulo dati contenente i valori di efficacia da gen 2 a gen 5.

Il livello esterno è il tipo attaccante, il livello interno il difensore. Ad
esempio, et.normale.fuoco è l'efficacia di un attacco di tipo normale che
colpisce un tipo fuoco puro

--]]

local et = {}

-- stylua: ignore start
et.normale = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 1, roccia = 0.5, spettro = 0, drago = 1, buio = 1, acciaio = 0.5}
et.fuoco = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 2, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 0.5, buio = 1, acciaio = 2}
et.acqua = {normale = 1, fuoco = 2, acqua = 0.5, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 2,
    volante = 1, psico = 1, coleottero = 1, roccia = 2, spettro = 1, drago = 0.5, buio = 1, acciaio = 1}
et.elettro = {normale = 1, fuoco = 1, acqua = 2, elettro = 0.5, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 0,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 0.5, buio = 1, acciaio = 1}
et.erba = {normale = 1, fuoco = 0.5, acqua = 2, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 2,
	volante = 0.5, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 0.5, buio = 1, acciaio = 0.5}
et.ghiaccio = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 0.5, lotta = 1, veleno = 1, terra = 2,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2, buio = 1, acciaio = 0.5}
et.lotta = {normale = 2, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 1, veleno = 0.5, terra = 1,
	volante = 0.5, psico = 0.5, coleottero = 0.5, roccia = 2, spettro = 0, drago = 1, buio = 2, acciaio = 2}
et.veleno = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 0.5,
	volante = 1, psico = 1, coleottero = 1, roccia = 0.5, spettro = 0.5, drago = 1, buio = 1, acciaio = 0}
et.terra = {normale = 1, fuoco = 2, acqua = 1, elettro = 2, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 2, terra = 1,
	volante = 0, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 1, buio = 1, acciaio = 2}
et.volante = {normale = 1, fuoco = 1, acqua = 1, elettro = 0.5, erba = 2, ghiaccio = 1, lotta = 2, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
et.psico = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 2, veleno = 2, terra = 1,
	volante = 1, psico = 0.5, coleottero = 1, roccia = 1, spettro = 1, drago = 1, buio = 0, acciaio = 0.5}
et.coleottero = {normale = 1, fuoco = 0.5, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 0.5, veleno = 0.5, terra = 1,
	volante = 0.5, psico = 2, coleottero = 1, roccia = 1, spettro = 0.5, drago = 1, buio = 2, acciaio = 0.5}
et.roccia = {normale = 1, fuoco = 2, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 0.5, veleno = 1, terra = 0.5,
	volante = 2, psico = 1, coleottero = 2, roccia = 1, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
et.spettro = {normale = 0, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 2, coleottero = 1, roccia = 1, spettro = 2, drago = 1, buio = 0.5, acciaio = 0.5}
et.drago = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2, buio = 1, acciaio = 0.5}
et.buio = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 0.5, veleno = 1, terra = 1,
	volante = 1, psico = 2, coleottero = 1, roccia = 1, spettro = 2, drago = 1, buio = 0.5, acciaio = 0.5}
et.acciaio = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 0.5, erba = 1, ghiaccio = 2, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 1, roccia = 2, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
-- stylua: ignore end
et.coleot = et.coleottero
for a in pairs(et) do
    et[a].coleot = et[a].coleottero
end

return et
