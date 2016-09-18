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

--[[

Le abilità che alterano l'efficacia dei tipi:
il primo indice è il nome dell'abilità, il
secondo il tipo alterato e il valore associato
sarà moltiplicato all'efficacia calcolata solo
con i tipi.
Per esempio, all'indice grassospess corrispondono
i due tipi fuoco e ghiaccio, entrambi con valore
0.5, perché l'abilità dimezza l'efficacia di
questi due tipi.
Filtro, Solidroccia e Magidifesa sono trattate a parte.

--]]

local allability = { {}, {}, {}, {}, {} }
allability[3].levitazione = {terra = 0}
allability[3].grassospesso = {fuoco = 0.5, ghiaccio = 0.5}
allability[3].fuocardore = {fuoco = 0}
allability[3].assorbacqua = {acqua = 0}
allability[3].parafulmine = {elettro = 0}
allability[3].assorbivolt = allability[3].parafulmine
allability[4].antifuoco = {fuoco = 0.5}
allability[4].pellearsa = {fuoco = 1.25, acqua = 0}
allability[4].acquascolo = allability[3].assorbacqua
allability[4].elettrorapid = allability[3].parafulmine
allability[5].mangiaerba = {erba = 0}

--[[

Creazione dinamica di una table contenente tutte le
abilità che influenzano l'efficacia tipi, ad oguna
delle quali è associata una table con i tipi da essa
influenzati. Le abilità sono gli indici e i tipi
influenzati gli elementi associati, es: all'indice
pellearsa corrisponde una table contenente i tipi
fuoco e acqua.
Fanno eccezione Magidifesa, Filtro e Solidroccia,
che non hanno tipi associati fissi
La table viene creata dentro loadAbils per contenere
solo le abilità delle generazioni volute

--]]

et.modTypesAbil = {magidifesa = {}, filtro = {}, solidroccia = {}}

--[[

Funzione che carica solo le abilità fino ad una certa
generazione. Da chiamare prima di utilizzare le altre
funzioni del modulo

--]]
local ability = {}
et.loadAbils = function(gen)
	for	g=1,gen,1 do
		for abil, types in pairs(allability[g]) do
			ability[abil] = types
		end
	end

	for abil, types in pairs(ability) do
		et.modTypesAbil[abil] = {}
		for Type, eff in pairs(types) do
			table.insert(et.modTypesAbil[abil], Type)
		end
	end
end

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

--[[

Calcola l'efficacia di un attacco; si aspetta i
nomi dei tipi e dell'abilità, tutti in minuscolo

--]]

et.efficacia = function(atk, def1, def2, abil)

	-- Efficacia base con due tipi

	local e = eff[atk][def1]
	if def2 ~= def1 then
		e = e * eff[atk][def2]
	end

	-- Abilità standard

	if ability[abil] and ability[abil][atk] then
		return e * ability[abil][atk]

	-- Filtro e solidroccia

	elseif e >= 2 and (abil == 'filtro' or abil == 'solidroccia') then
		return e * 0.75

	-- Magidifesa

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
