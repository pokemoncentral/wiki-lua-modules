-- Modulo da usare nel template PokémonInfo per determinare
-- i dex regionali

local rdex = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local dex = require("Dex-data")
local c = require("Colore-data")
local sup = require("Sup-data")

-- Ritorna il dex regionale di un Pokémon nel vecchio
-- dex regionale specificato: nel caso in cui non sia
-- presente, ritorna nil

local getOldDex = function(newDex, oldDexTable)
	for subtract, ndex in ipairs(oldDexTable) do
		if ndex == newDex then
			return nil;
		elseif ndex > newDex then
			return txt.tf(newDex - subtract + 1)
		end
	end
	return txt.tf(newDex - table.getn(oldDexTable))
end

-- Aggiunge un title al primo argomento costituito
-- dal secondo e dal terzo separati da uno spazio

local addtt = function(newDex, oldDex, title)
	return string.interp('<span class="explain" title="${oldDex} ${title}">${newDex}</span>',
		{oldDex = oldDex, title = title, newDex = newDex})
end

-- Inserisce le informazioni relative al vecchio dex
-- regionale: per Sinnoh un sup di platino, per le
-- altre un title

local insOld = {}

insOld.johto = function(newDex, oldDex)
	return addtt(newDex, oldDex, 'nella seconda generazione')
end

insOld.hoenn = function(newDex, oldDex)
	return addtt(newDex, oldDex, 'nella terza generazione')
end

insOld.sinnoh = function(newDex, oldDex)
	return newDex .. sup.Pt
end

insOld.unima = function(newDex, oldDex)
	return addtt(newDex, oldDex, 'in Nero e Bianco')
end

insOld.alola = function(newDex, oldDex)
	return addtt(newDex, oldDex, 'in Sole e Luna')
end

-- Ordina la tabella store: la table è esterna alla
-- funzione così da non essere ricreata ogni volta

local regiongens = {Kanto = 1, Johto = 2, Hoenn = 3, Sinnoh = 4,
	Unima = 5, Kalos = 6, Alola = 7}
local region_sort = function(c, d)
	local a, b = c:match('>(%a+)</span>'), d:match('>(%a+)</span>')
	return regiongens[a] < regiongens[b]
end

-- La funzione che genera le celle per i dex regionali:
-- nello scorrere la tabella fornita dalla search,
-- controlla che il dex non sia tra quelli aggiornati in seguito
-- ed effettua l'inserimento; se ciò non accade, concatena all'ultimo
-- elemento l'asterisco giusto chiamando la funzione olddex.

local dexlist = function(dexes)
	if table.getn(dexes) == 0 then
		return nil
	end
	local store = {}
	local str = [=[<span><div class="small-font">'''[[Elenco Pokémon secondo il Pokédex di ${reg}|<span style="color:#000">${reg}</span>]]'''</div>#${rdex}</span>]=]
	local kalos = [=[<span><div class="small-font">'''[[Elenco Pokémon secondo i Pokédex di Kalos#Pokédex di Kalos ${reg}|<span style="color:#${c}">Kalos</span>]]'''</div>#<span class="explain" title="${reg}">${rdex}</span></span>]=]
	local incl = '<includeonly>[[Categoria:Pokémon originari della regione di ${reg}|${rdex}]]</includeonly>'
	for region, rdex in pairs(dexes) do
		if region:find('kalos') then
			local zone = region:match('kalos(%a+)$')
			table.insert(store, string.interp(kalos, {c = c['kalos' .. zone].normale,
				reg = zone, rdex = rdex}))
		elseif type(rdex) == 'table' then
			local ndex = rdex[1]
			local newDex, oldDex = table.search(dex[region][2], ndex), table.search(dex[region][1], ndex)
			if newDex == oldDex then
				rdex = newDex
			else
				rdex = insOld[region](newDex, oldDex or 'Non disponibile')
			end
			table.insert(store, string.interp(str, {reg = string.fu(region), rdex = rdex}))
		else
			local oldDexTable = dex[region .. 'Added']
			if oldDexTable then
				local oldDex = getOldDex(tonumber(rdex), oldDexTable)
				if oldDex ~= rdex then
					rdex = insOld[region](rdex, oldDex or 'Non disponibile')
				end
			end
			table.insert(store, string.interp(str, {reg = string.fu(region), rdex = rdex}))
		end
	end
	table.sort(store, region_sort)
	for k, v in ipairs(store) do
		store[k] = v
	end
	if #store > 5 then
		table.insert(store, 1 + math.floor(#store / 2), '</div><div class="flex-row-center-around">')
	end
	return table.concat(store)
end

-- Semplicemente cerca tra tutti i dex se si trova il numero di dex
-- nazionale fornito: in caso positivo, lo inserisce come elemento
-- di una table con indice il nome della regione. Se una certa regione
-- ha più dex regionali (es: alola) inserisce come valore una table
-- contenente il numero di dex nazionale

local search = function(ndex)
	local dexes = {}
	for region, regionalDex in pairs(dex) do
		if (type(regionalDex[1]) == 'table') and table.deepSearch(regionalDex, ndex) then
			dexes[region] = {txt.three_figures(ndex)}
		else
			local rdex = table.search(regionalDex, ndex)
			if rdex then
				dexes[region] = txt.three_figures(rdex)
			end
		end
	end
	return dexes
end

--Interfaccia. Riceve un ndex su tre cifre e un tipo, e interpola il colore standard
-- del tipo e la lista dei dex regionali, creata con la funzione dexlist, al box in wikicode

rdex.regionaldex = function(frame)
	local ndex = string.trim(frame.args[1]) or '000'
	return string.interp([=[| colspan="2" | <div>[[Pokédex Regionale|<span style="color:#000;">'''Pokédex Regionali'''</span>]]</div>
<div class="roundy" style="background: #fff; padding-top: 0.5ex; padding-bottom: 0.5ex;">
<div class="flex-row-center-around">${dexlist}</div>
]=],
{
	dexlist = dexlist(search(ndex)) or 'In nessun Pokédex Regionale'
})
end

rdex.Regionaldex, rdex.RegionalDex = rdex.regionaldex, rdex.regionaldex
-- return rdex
print(rdex.regionaldex{args={arg[1]}})
