-- Calcolo efficacia tipi per i tipi glitch ad uso esclusivamente interno
-- Non calcola i danni di una mossa di tipo glitch, permette solo di calcolare
-- i danni di un certo tipo di mossa contro un Pokémon con tipi glitch

local et = require('EffTipi1')
local tab = require('Wikilib-tables')

local etg = {}


local standardEff = { Uccello = 1, Glitch = 1, L = 1 }
standardEff['Pokémaniaco'] = 1
standardEff["(Classe dell'ultimo allenatore affrontato)"] = 1
standardEff["' ♀ ♀ ' 2222 37572"] = 1
standardEff['Poké BB'] = 1
standardEff['999'] = 1
standardEff['?'] = 1
standardEff['IIIItoto'] = 1
for key, value in pairs(standardEff) do
	standardEff[string.lower(key)] = value
end

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo attaccante, il livello interno il difensore.
-- Ad esempio, normale.fuoco è l'efficacia di un attacco di tipo normale che colpisce un tipo fuoco puro
-- Contiene anche i tipi glitch

local eff = {}
eff.normale = tab.merge(et.data('normale'), standardEff)
eff.fuoco = tab.merge(et.data('fuoco'), standardEff)
eff.acqua = tab.merge(et.data('acqua'), standardEff)
eff.elettro = tab.merge(et.data('elettro'), standardEff)
eff.erba = tab.merge(et.data('erba'), standardEff)
eff.ghiaccio = tab.merge(et.data('ghiaccio'), standardEff)
eff.lotta = tab.merge(et.data('lotta'), standardEff)
eff.veleno = tab.merge(et.data('veleno'), standardEff)
eff.terra = tab.merge(et.data('terra'), standardEff)
eff.volante = tab.merge(et.data('volante'), standardEff)
eff.psico = tab.merge(et.data('psico'), standardEff)
eff.coleottero = tab.merge(et.data('coleottero'), standardEff)
eff.roccia = tab.merge(et.data('roccia'), standardEff)
eff.spettro = tab.merge(et.data('spettro'), standardEff)
eff.drago = tab.merge(et.data('drago'), standardEff)
eff.coleot = eff.coleottero
for a in pairs(eff) do
    eff[a].coleot = eff[a].coleottero
end

-- Calcola l'efficacia di un attacco (0 - 0.25 - 0.5 - 1 - 2 - 4)
-- si aspetta i nomi dei tipi, tutti in minuscolo (solo i tipi non glitch)

etg.efficacia = function(a, d1, d2)
	local e = eff[a][d1]
	if d2 then -- ~= d1 then            --scommenta se ▶ A ha debolezza 2x a lotta
		 return e * eff[a][d2]
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

etg.difesa = function(eff, tipo1, tipo2)
	return cerca_tipi(function (x) return etg.efficacia(x, tipo1, tipo2) == eff end)
end

-- Trova tutti i tipi su cui tipo ha efficacia eff

etg.attacco = function(eff, tipo)
	return cerca_tipi(function (x) return etg.efficacia(tipo, x, x) == eff end)
end

return etg
