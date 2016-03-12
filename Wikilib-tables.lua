-- Funzioni di libreria per le tabelle

local t = {}

--[[

Ricerca lineare: si passa una table e un valore e
restituisce il suo indice o nil

--]]
table.search = function(tab, value)
    for k, v in pairs(tab) do
	    if v == value then
	        return k
	    end
    end
    -- No explicit return, thus nil
end

table.linearSearch, table.linear_search =
		table.search, table.search
t.search, t.linearSearch, t.linear_search =
		table.search, table.search, table.search

--[[

Ricerca ricorsiva: cerca un valore in una table e
in eventuali subtables. Ritorna una lista di indici,
l'ultimo per l'elemento, i precedenti per le subtables.
Se l'elemento non è presente, ritorna nil

Esempio: t.deep_search({'a', {'b', 'c'}}, 'b') --> 2, 1

--]]
table.deepSearch = function(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
		if type(v) == 'table' then
			--[[
				If the last list element is not nil, value
				has been found, thus returning
			--]]
			local valueKeys = {table.deepSearch(v, value)}
			if valueKeys[#valueKeys] then
				return k, unpack(valueKeys)
			end
		end
	end
	-- No explicit return, thus nil
end

table.deep_search, table.recursiveSearch, table.recursive_search =
		table.deepSearch, table.deepSearch, table.deepSearch
t.deepSearch, t.deep_search, t.recursiveSearch, t.recursive_search =
		table.deepSearch, table.deepSearch, table.deepSearch, table.deepSearch

--[[

Ritorna il numero di elementi di una table,
solo quelli con indici numerici se il secondo
argomento è true o 'num', altrimenti anche
quelli con indice diverso.

--]]
table.getn = function(self, count)
	count = count or 'all'
	local n = 0
	local iterator = nil
	if count == true or tostring(count):lower() == 'num' then
		iterator = ipairs
	else
		iterator = pairs
	end
	for k in iterator(self) do
		n = n + 1
	end
	return n
end

t.getn = table.getn

--[[

Aggiunge elementi ad una table che sono alias di altri elementi della stessa table.
Il primo argomento è la table in questione; il secondo una table contenente le
chiavi degli elementi di cui si vogliono creare gli alias; il terzo una table
di cui ogni elemento è a sua volta una table, che contiene le chiavi degli alias
relativi all'elemento di indice uguale nel secondo argomento.
Esempio di chiamata:
table.tableKeysAlias(t, {'key', 'key1'}, {{'alias', alias1'}, {'alias2', 'alias3'}})
Equivalente con assegnamenti:
t.alias, t.alias1 = t.key, t.key
t.alias2, t.alias3 = t.key1, t.key1

--]]
table.tableKeysAlias = function(tab, source, dest)
	for destGroup, sourceKey in ipairs(source) do
		for k, destKey in ipairs(dest[destGroup]) do
			tab[destKey] = tab[sourceKey]
		end
	end
end

table.table_keys_alias, table.keysAlias, table.keys_alias =
		table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias
t.tableKeysAlias, t.table_keys_alias, t.keysAlias, t.keys_alias =
		table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias

--[[

Applica una funzione ad ogni elemento di una table,
ritornandone un'altra con i risultati aventi la stessa
chiave dell'elemento dato in ingresso alla funzione

La funzione riceve in ingresso un elemento e la sua
chiave, in quest'ordine perché la chiave non è sempre
necessaria e sarebbe fastidioso avere un argomento
placeholder.

--]]
table.map = function(tab, funct)
	local dest = {}
	for key, value in pairs(tab) do
		dest[key] = funct(value, key)
	end
	return dest
end

t.map = table.map

--[[

Indica se due tables sono uguali, nel più
brutale dei possibili significati: stessi
elementi associati alle stesse chiavi.

Per comodità, ritorna true anche se gli
argomenti non sono tables, purché siano
uguali.

--]]
table.equal = function(tab1, tab2)

	--[[
		Si confrontano direttamente gli argomenti se
		uno dei due ha il metamethod __eq o se uno
		dei due non è una table
	--]]
	local mt1 = getmetatable(tab1)
	local mt2 = getmetatable(tab2)
	if mt1 and mt1.__eq or mt2 and mt2.__eq
			or type(tab1) ~= 'table'
			or type(tab2) ~= 'table' then
		return tab1 == tab2
	end
	
	--[[
		Se si hanno due riferimenti alla stessa
		table si evitano molte computazioni inutili
	--]]
	if tab1 == tab2 then
		return true
	end

	--[[
		Se il numero di elementi è diverso le due
		tables non possono essere uguali. Inoltre
		gestisce anche il caso in cui tab1 sia vuota
		e tab2 no, che porterebbe a tornare true
		poiché il loop viene skippato, e quello in
		cui tab1 sia un sottoinsieme di tab2 poiché
		si controllano solo gli indici della prima.
	--]]
	if table.getn(tab1) ~= table.getn(tab2) then
		return false
	end
	
	for key, value in pairs(tab1) do
		--[[
			Stante la type safety di table.equal, è
			più comodo fare così
		--]]
		if not table.equal(value, tab2[key]) then
			return false
		end
	end
	
	return true
end

table.eq = table.equal
t.equal, t.eq = table.qual, table.equal

--[[

Ritorna una table risultato della fusione delle
due passate. Gli indici numerici della seconda
seguiranno quelli della prima; gli altri sono
lasciati invariati, ed in caso di uguaglianza
quelli della seconda sovrascrivono quelli della
prima.

--]]
table.merge = function(tab1, tab2, inPlace)

local mw = require('mw')

	local dest = mw.clone(tab1)
	--[[
		È necessario il doppio ciclo per avere
		le chiavi intere in ordine
	--]]
	for key, value in ipairs(tab2) do
		table.insert(dest, value)
	end
	for key, value in pairs(tab2) do
		if type(key) ~= 'number'
				or key ~= math.floor(key) then
			dest[key] = value
		end
	end
	return dest
end

t.merge = table.merge

--[[

Ritorna una table con i soli elementi che
rispettano la condizione passata. Tale
funzione deve quindi ritornare un booleano,
avendo in ingresso un elemento e la sua
chiave, in quest'ordine perché la chiave
non è sempre necessaria e sarebbe fastidioso
avere un argomento placeholder.

Le chiavi rimangono invariate con la sola
eccezione di quelle numeriche, che sono
rese continue

--]]
table.filter = function(tab, cond)
	local dest = {}
	--[[
		È necessario il doppio ciclo per avere
		le chiavi intere in ordine
	--]]
	for key, value in ipairs(tab) do
		if cond(value, key) then
			table.insert(dest, value)
		end
	end
	for key, value in pairs(tab) do
		if (type(key) ~= 'number'
				or key ~= math.floor(key))
				and cond(value, key) then
			dest[key] = value
		end
	end
	return dest
end

t.filter = table.filter

--[[

Ritorna una table con soli indici numerici
i cui elementi sono le chiavi della table
passata, in ordine non specificato

--]]
table.keys = function(tab)
	local keys = {}
	for key, v in pairs(tab) do
		table.insert(keys, key)
	end
	return keys
end

t.keys = table.keys

--[[

Ritorna una table con gli stessi elementi di
quella passata, ma senza duplicati.

Le chiavi degli elementi mantenuti sono le
prime in ordine lessicografico rispetto alle
chiavi dei grupppi di elementi uguali, con
la sola eccezione di quelle intere che sono
rese contigue.

--]]
table.noDuplicates = function(tab)
	local keys = table.keys(tab)
	
	-- Lexicographically sort
	table.sort(keys, function(a, b)
			local nA , nB = tonumber(a), tonumber(b)
			if nA and nB then
				return nA < nB
			end
			return tostring(a) < tostring(b)
		end)

	local unique = {}
	for k, key in ipairs(keys) do
		local value = tab[key]
		if not table.search(unique, value) then
			if type(key) ~= 'number'
					and math.floor(key) ~= key then
				unique[key] = value
			else
				table.insert(unique, value)
			end
		end
	end
	return unique
end

table.no_duplicates, table.unique =
		table.noDuplicates, table.noDuplicates
t.noDuplicates, t.no_duplicates, t.unique = 
		table.noDuplicates, table.noDuplicates, table.noDuplicates

return t
