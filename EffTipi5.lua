-- Calcolo efficacia tipi per la quinta generazione, ad uso esclusivamente interno

local et = {}

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo attaccante, il livello interno il difensore.
-- Ad esempio, normale.fuoco è l'efficacia di un attacco di tipo normale che colpisce un tipo fuoco puro

local eff = {}
eff.normale = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 1, roccia = 0.5, spettro = 0, drago = 1, buio = 1, acciaio = 0.5}
eff.fuoco = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 2, lotta = 1, veleno = 1, terra = 1,
    volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 0.5, buio = 1, acciaio = 2}
eff.acqua = {normale = 1, fuoco = 2, acqua = 0.5, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 2,
    volante = 1, psico = 1, coleottero = 1, roccia = 2, spettro = 1, drago = 0.5, buio = 1, acciaio = 1}
eff.elettro = {normale = 1, fuoco = 1, acqua = 2, elettro = 0.5, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 1, terra = 0,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 0.5, buio = 1, acciaio = 1}
eff.erba = {normale = 1, fuoco = 0.5, acqua = 2, elettro = 1, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 2,
	volante = 0.5, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 0.5, buio = 1, acciaio = 0.5}
eff.ghiaccio = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 1, erba = 2, ghiaccio = 0.5, lotta = 1, veleno = 1, terra = 2,
	volante = 2, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2, buio = 1, acciaio = 0.5}
eff.lotta = {normale = 2, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 1, veleno = 0.5, terra = 1,
	volante = 0.5, psico = 0.5, coleottero = 0.5, roccia = 2, spettro = 0, drago = 1, buio = 2, acciaio = 2}
eff.veleno = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 1, veleno = 0.5, terra = 0.5,
	volante = 1, psico = 1, coleottero = 1, roccia = 0.5, spettro = 0.5, drago = 1, buio = 1, acciaio = 0}
eff.terra = {normale = 1, fuoco = 2, acqua = 1, elettro = 2, erba = 0.5, ghiaccio = 1, lotta = 1, veleno = 2, terra = 1,
	volante = 0, psico = 1, coleottero = 0.5, roccia = 2, spettro = 1, drago = 1, buio = 1, acciaio = 2}
eff.volante = {normale = 1, fuoco = 1, acqua = 1, elettro = 0.5, erba = 2, ghiaccio = 1, lotta = 2, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 2, roccia = 0.5, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
eff.psico = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 2, veleno = 2, terra = 1,
	volante = 1, psico = 0.5, coleottero = 1, roccia = 1, spettro = 1, drago = 1, buio = 0, acciaio = 0.5}
eff.coleottero = {normale = 1, fuoco = 0.5, acqua = 1, elettro = 1, erba = 2, ghiaccio = 1, lotta = 0.5, veleno = 0.5, terra = 1,
	volante = 0.5, psico = 2, coleottero = 1, roccia = 1, spettro = 0.5, drago = 1, buio = 2, acciaio = 0.5}
eff.roccia = {normale = 1, fuoco = 2, acqua = 1, elettro = 1, erba = 1, ghiaccio = 2, lotta = 0.5, veleno = 1, terra = 0.5,
	volante = 2, psico = 1, coleottero = 2, roccia = 1, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
eff.spettro = {normale = 0, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 2, coleottero = 1, roccia = 1, spettro = 2, drago = 1, buio = 0.5, acciaio = 1}
eff.drago = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 1, roccia = 1, spettro = 1, drago = 2, buio = 1, acciaio = 0.5}
eff.buio = {normale = 1, fuoco = 1, acqua = 1, elettro = 1, erba = 1, ghiaccio = 1, lotta = 0.5, veleno = 1, terra = 1,
	volante = 1, psico = 2, coleottero = 1, roccia = 1, spettro = 2, drago = 1, buio = 0.5, acciaio = 1}
eff.acciaio = {normale = 1, fuoco = 0.5, acqua = 0.5, elettro = 0.5, erba = 1, ghiaccio = 2, lotta = 1, veleno = 1, terra = 1,
	volante = 1, psico = 1, coleottero = 1, roccia = 2, spettro = 1, drago = 1, buio = 1, acciaio = 0.5}
eff.coleot = eff.coleottero
for a in pairs(eff) do
    eff[a].coleot = eff[a].coleottero
end

-- Le abilità che alterano l'efficacia dei tipi.
-- il primo indice è il tipo alterato, il secondo
-- il nome dell'abilità e il terzo il valore da
-- moltiplicare. Filtro, Solidroccia e Magidifesa
-- sono trattate a parte.

local ability = {}
ability.terra = {levitazione = 0}
ability.fuoco = {grassospesso = 0.5, antifuoco = 0.5, fuocardore = 0, pellearsa = 1.25}
ability.acqua = {acquascolo = 0, assorbacqua = 0, pellearsa = 0}
ability.elettro = {parafulmine = 0, elettrorapid = 0, assorbivolt = 0}
ability.erba = {mangiaerba = 0}
ability.ghiaccio = {grassospesso = 0.5}


-- Calcola l'efficacia di un attacco (0 - 0.25 - 0.5 - 1 - 2 - 4)
-- si aspetta i nomi dei tipi, tutti in minuscolo

et.efficacia = function(a, d1, d2, abil)
	local e = eff[a][d1]
	if d2 ~= d1 then
		e = e * eff[a][d2]
	end
	if ability[a] and ability[a][abil] then
		return e * ability[a][abil]
	elseif e >= 2 and (abil == 'filtro' or abil == 'solidroccia') then
		return e * 0.75
	elseif e < 2 and abil == 'magidifesa' then
		return 0 
	end
	return e
end

-- Cerca tutti i tipi che soddisfano una condizione data.
-- Il parametro test è una funzione che si aspetta un solo argomento (vedere gli esempi dopo per chiarimenti).

local cerca_tipi = function(test)
	local t = {}
	for k in pairs(eff) do
		if k ~= 'coleottero' and test(k) then
			table.insert(t,k)
		end
	end
	return t
end

-- Trova tutti i tipi che attaccando tipo1,tipo2 hanno efficacia eff

et.difesa = function(eff, tipo1, tipo2, abil)
	return cerca_tipi(function (x) return et.efficacia(x, tipo1, tipo2, abil) == eff end)
end

-- Trova tutti i tipi su cui tipo ha efficacia eff

et.attacco = function(eff, tipo)
	return cerca_tipi(function (x) return et.efficacia(tipo, x, x, 'Tanfo') == eff end)
end

return et

