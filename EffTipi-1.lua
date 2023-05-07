-- Calcolo efficacia tipi per la prima generazione ad uso esclusivamente interno

local et = {}

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo attaccante, il livello interno il difensore.
-- Ad esempio, normale.fuoco è l'efficacia di un attacco di tipo normale che colpisce un tipo fuoco puro

-- stylua: ignore start
local eff = {}
eff.normale = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 1, roccia = 0.5, spettro = 0, drago = 1}
eff.fuoco = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 2, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 0.5}
eff.acqua = {normale = 1, fuoco = 2, acqua = 0.5, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 2,
    volante = 1, psico = 1, coleottero = 1, roccia = 2, spettro = 1, drago = 0.5}
eff.elettro = {normale = 1, fuoco = 1, acqua = 2, elettro = 0.5, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 0,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 0.5}
eff.erba = {normale = 1, fuoco = 0.5, acqua = 2, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 2,
	volante = 0.5, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 0.5}
eff.ghiaccio = {normale = 1, fuoco = 1, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 0.5, lotta = 1, veleno = 1, terra = 2,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2}
eff.lotta = {normale = 2, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 1, veleno = 0.5, terra = 1,
	volante = 0.5, psico = 0.5, coleottero = 0.5, roccia = 2, spettro = 0, drago = 1}
eff.veleno = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 0.5,
	volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 0.5, drago = 1}
eff.terra = {normale = 1, fuoco = 2, acqua = 1, elettro = 2, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 2, terra = 1,
	volante = 0, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 1}
eff.volante = {normale = 1, fuoco = 1, acqua = 1, elettro = 0.5, erba = 2, ghiaccio = 1, lotta = 2, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 1}
eff.psico = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 2, veleno = 2, terra = 1,
	volante = 1, psico = 0.5, coleottero = 1, roccia = 1, spettro = 1, drago = 1}
eff.coleottero = {normale = 1, fuoco = 0.5, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 0.5, veleno = 2, terra = 1,
	volante = 0.5, psico = 2, coleottero = 1, roccia = 1, spettro = 1, drago = 1}
eff.roccia = {normale = 1, fuoco = 2, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 0.5, veleno = 1, terra = 0.5,
	volante = 2, psico = 1, coleottero = 2, roccia = 1, spettro = 1, drago = 1}
eff.spettro = {normale = 0, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 0, coleottero = 1, roccia = 1, spettro = 2, drago = 1}
eff.drago = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2}
-- stylua: ignore end
eff.coleot = eff.coleottero
for a in pairs(eff) do
    eff[a].coleot = eff[a].coleottero
end

-- Calcola l'efficacia di un attacco (0 - 0.25 - 0.5 - 1 - 2 - 4)
-- si aspetta i nomi dei tipi, tutti in minuscolo

et.efficacia = function(a, d1, d2)
    local e = eff[a][d1]
    if d2 ~= d1 then
        return e * eff[a][d2]
    end
    return e
end

-- Cerca tutti i tipi che soddisfano una condizione data.
-- Il parametro test è una funzione che si aspetta un solo argomento (vedere gli esempi dopo per chiarimenti).

local cerca_tipi = function(test)
    local t = {}
    for k in pairs(eff) do
        if k ~= "coleottero" and test(k) then
            table.insert(t, k)
        end
    end
    return t
end

-- Trova tutti i tipi che attaccando tipo1,tipo2 hanno efficacia eff

et.difesa = function(eff, tipo1, tipo2)
    return cerca_tipi(function(x)
        return et.efficacia(x, tipo1, tipo2) == eff
    end)
end

-- Trova tutti i tipi su cui tipo ha efficacia eff

et.attacco = function(eff, tipo)
    return cerca_tipi(function(x)
        return et.efficacia(tipo, x, x) == eff
    end)
end

--Restituisce i dati di efficacia in attacco del tipo passato

et.data = function(tipo)
    return eff[tipo]
end

return et
