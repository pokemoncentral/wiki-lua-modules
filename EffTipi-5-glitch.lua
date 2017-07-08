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
'l) m) ZM (come acciaio)
Normale (glitch)
Grinta (come Normale)
Grazia (come Normale)
Sconosciuto

--]]

local glitchEff = {}
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
for t, eff in pairs(glitchEff) do
	for key, value in pairs(eff) do
		eff[string.lower(key)] = value
	end
end

-- Tabella contenente i valori di efficacia. Il livello esterno è il tipo attaccante, il livello interno il difensore.
-- Ad esempio, normale.fuoco è l'efficacia di un attacco di tipo normale che colpisce un tipo fuoco puro
-- Contiene anche i tipi glitch

local eff = {}
for k, v in pairs(glitchEff) do
	eff[k] = tab.merge(et.data(k), v)
end
--[[
eff.normale = tab.merge(et.data('normale'), glitchEff.normale)
eff.fuoco = tab.merge(et.data('fuoco'), glitchEff.fuoco)
eff.acqua = tab.merge(et.data('acqua'), glitchEff.acqua)
eff.elettro = tab.merge(et.data('elettro'), glitchEff.elettro)
eff.erba = tab.merge(et.data('erba'), glitchEff.erba)
eff.ghiaccio = tab.merge(et.data('ghiaccio'), glitchEff.ghiaccio)
eff.veleno = tab.merge(et.data('veleno'), glitchEff.veleno)
eff.terra = tab.merge(et.data('terra'), glitchEff.terra)
eff.volante = tab.merge(et.data('volante'), glitchEff.volante)
eff.psico = tab.merge(et.data('psico'), glitchEff.psico)
eff.coleottero = tab.merge(et.data('coleottero'), glitchEff.coleottero)
eff.roccia = tab.merge(et.data('roccia'), glitchEff.roccia)
eff.drago = tab.merge(et.data('drago'), glitchEff.drago)
eff.buio = tab.merge(et.data('buio'), glitchEff.buio)
eff.acciaio = tab.merge(et.data('acciaio'), glitchEff.acciaio)
eff.lotta = tab.merge(et.data('lotta'), glitchEff.lotta)
eff.spettro = tab.merge(et.data('spettro'), glitchEff.spettro)
--]]
eff.coleot = eff.coleottero
for a in pairs(eff) do
    eff[a].coleot = eff[a].coleottero
end

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
