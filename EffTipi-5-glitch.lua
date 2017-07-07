-- Calcolo efficacia tipi per i tipi glitch ad uso esclusivamente interno
-- Non calcola i danni di una mossa di tipo glitch, permette solo di calcolare
-- i danni di un certo tipo di mossa contro un Pokémon con tipi glitch

local mw = require('mw')

local et = require('EffTipi-5')
local tab = require('Wikilib-tables')

local etg = {}

--[[

Glitch
???
B
'l) m) ZM
Normale (glitch)
Grinta
Grazia
Sconosciuto

--]]

local standardEff = { Uccello = 1, B = 1, Grinta = 1, Grazia = 1, Sconosciuto = 1 }
standardEff['???'] = 1
standardEff["'l) m) ZM"] = 1
standardEff["Normale (glitch)"] = 1
local lottaEff, spettroEff = mw.clone(standardEff), mw.clone(standardEff)
lottaEff.Grinta, lottaEff.Grazia = 2, 2
spettroEff.Grinta, spettroEff.Grazia = 0, 0
for key, value in pairs(standardEff) do
	standardEff[string.lower(key)] = value
	lottaEff[string.lower(key)] = lottaEff[key]
	spettroEff[string.lower(key)] = spettroEff[key]
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
eff.veleno = tab.merge(et.data('veleno'), standardEff)
eff.terra = tab.merge(et.data('terra'), standardEff)
eff.volante = tab.merge(et.data('volante'), standardEff)
eff.psico = tab.merge(et.data('psico'), standardEff)
eff.coleottero = tab.merge(et.data('coleottero'), standardEff)
eff.roccia = tab.merge(et.data('roccia'), standardEff)
eff.drago = tab.merge(et.data('drago'), standardEff)
eff.coleot = eff.coleottero
for a in pairs(eff) do
    eff[a].coleot = eff[a].coleottero
end
-- Lotta e Spettro hanno efficacia diversa da 1 su Grazia e Grinta
eff.lotta = tab.merge(et.data('lotta'), lottaEff)
eff.spettro = tab.merge(et.data('spettro'), spettroEff)

--[[

Dato che i glitch non hanno abilità che modificano le efficacie tutta
la parte relativa ad esse viene ignorata

--]]

--[[

Creazione dinamica di una table con i tipi che hanno
immunità, con associati i tipi a cui sono immuni. I
primi sono gli indici, i secondi gli elementi di una
table ad essi associata, es: all'indice spettro
è associata una table contenente i tipi lotta e normale

--]]

et.typesHaveImm = {}
for atk, defs in pairs(eff) do
	for def, eff in pairs(defs) do
		if eff == 0 then
			if type(et.typesHaveImm[def]) ~= 'table' then
				et.typesHaveImm[def] = {}
			end
			table.insert(et.typesHaveImm[def], atk)
		end
	end
end



-- Calcola l'efficacia di un attacco (0 - 0.25 - 0.5 - 1 - 2 - 4)
-- si aspetta i nomi dei tipi, tutti in minuscolo (solo i tipi non glitch)

etg.efficacia = function(a, d1, d2)
	local e = eff[a][d1]
	if d2 ~= d1 then
		 return e * eff[a][d2]
	end
	return e
end

et.efficacia = function(atk, def1, def2)
	-- Efficacia base con due tipi

	local e = eff[atk][def1]
	if def2 ~= def1 then
		e = e * eff[atk][def2]
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

-- Trova tutti i tipi che attaccando tipo1, tipo2 hanno efficacia eff

etg.difesa = function(eff, tipo1, tipo2)
	return cerca_tipi(function (x) return et.efficacia(x, tipo1, tipo2) == eff end)
end

-- Trova tutti i tipi su cui tipo ha efficacia eff

etg.attacco = function(eff, tipo)
	return cerca_tipi(function (x) return et.efficacia(tipo, x, x) == eff end)
end


return etg
