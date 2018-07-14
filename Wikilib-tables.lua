-- luacheck: new_globals table
-- Library table functions

local t = {}


-- Stateless iterator on non-integer keys
local nextNonInt = function(tab, key)
    local nextKey, nextValue = key
    repeat
        nextKey, nextValue = next(tab, nextKey)
    until type(nextKey) ~= 'number' or math.floor(nextKey) ~= nextKey
    return nextKey, nextValue
end
local next_non_int = nextNonInt     -- luacheck: no unused


-- Returns true only if a is lexigographically greater than b
local minor = function(a, b)
    if not b then
        return true
    end

    -- Converting to number for better comparison (eg. '01' and 1)
    local nA, nB = tonumber(a), tonumber(b)
    if nA and nB then
        return nA < nB
    end

    return tostring(a) < tostring(b)
end


--[[

Returns true if all of the elements in the list satisties a predicate.

The predicate function takes the value as the first argument, then the key;
usual key-value order is reversed because the key is often unnecessary, and
having it last leads to nicer syntax in the call site.

TODO: refactoring to use just built-ins

--]]
table.all = function(tab, funct, iter)
     return table.fold(tab, true,
        function(acc, value, key)
            return funct(value, key) and acc
        end, iter)
end

t.all = table.all


--[[

Returns true if at least one of the elements in the list satisties a predicate.

The predicate function takes the value as the first argument, then the key;
usual key-value order is reversed because the key is often unnecessary, and
having it last leads to nicer syntax in the call site.

TODO: refactoring to use just built-ins

--]]
table.any = function(tab, funct, iter)
    return table.fold(tab, false,
        function(acc, value, key)
            return funct(value, key) or acc
        end, iter)
end
t.any = table.any


--[[

Recursive search: looks for a value in a table and possible subtables. Returns
a list of indices, mapping the nesting of tables. This means that the last
index is the one of the element, the second last is the subtable it is found
in, the third last the subtable that contains such table an so on. If the
element is not found, returns nil.

Example:
table.deep_search({'a', {'b', 'c'}}, 'b') --> 2, 1

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
table.deep_search = table.deepSearch
t.deepSearch, t.deep_search = table.deepSearch, table.deepSearch


--[[

Applies a function over all of the elements of a table returned by the passed
iterator. The function is expected to return a list. The lists produced from
the elements are merged together in the same way as table.merge would do. The
iterator defaults to pairs.

The function takes as input an element and its ke, in this order: in fact, the
key is often unnecessary, and would just clutter the code in these cases.

--]]
table.flatMap = function(tab, funct, iter)
    iter = iter or pairs

    local dest = {}
    for k, v in iter(tab) do
        dest = table.merge(dest, funct(v, k))
    end
    return dest
end
table.flat_map = table.flatMap
t.flatMap, t.fat_map = table.flatMap, table.flatMap


--[[

Applies a function over all of the elements of a table returned by the passed
iterator. The function is expected to return a list. The lists produced from
the elements are converted to numeric lists: the order of the elements is
determined by the given iterator. These lists are then concatenated together,
in the order the elements of the initial list are returned by the iterator.

The function takes as input an element and its ke, in this order: in fact, the
key is often unnecessary, and would just clutter the code in these cases.

--]]
table.flatMapToNum = function(tab, funct, iter)
    iter = iter or pairs

    local dest = {}
    for k, v in iter(tab) do
        for _, value in iter(funct(v, k)) do
            table.insert(dest, value)
        end
    end
    return dest
end
table.flat_map_to_num = table.flatMapToNum
t.flatMapToNum, t.flat_map_to_num = table.flatMapToNum, table.flatMapToNum


--[[

Classic fold on lists: applies a binary function to an accumulator and a
value-key pair taken from the list and returns the final result. The iterator
determines the order elements are scanned, and therefore the final result.

The function takes the accumulator as the first argument, then the value and
finally the key; usual key-value order is reversed because the key is often
unnecessary, and having it last leads to nicer syntax in callers.

--]]
table.fold = function(tab, zero, func, iter)
    iter = iter or pairs

    for key, value in iter(tab) do
        zero = func(zero, value, key)
    end

    return zero
end
t.fold = table.fold


--[[

Returns the number of elements in a table. It should only be used when
Scribunto overrides the # operator so that it doesn't work propertly.
If the second argument is 'num' it only counts items having a numeric index,
otherwise it takes all elements in account.

--]]
table.getn = function(self, count)
    count = count or 'all'

    local n = 0
    local iterator = (count == true or tostring(count):lower() == 'num')
    and ipairs or pairs

    for _ in iterator(self) do
        n = n + 1
    end

    return n
end
t.getn = table.getn


--[[

Applies a function to the elements of a table scanned by the passed iterator.
It returls a table holding the results of the function application, bound to
the same keys as the original items. If no iterator is passed, all elements
are scanned.

The function takes as input an element and its ke, in this order: in fact, the
key is often unnecessary, and would just clutter the code in these cases.

--]]
table.map = function(tab, funct, iter)
    iter = iter or pairs

    local dest = {}
    for key, value in iter(tab) do
        dest[key] = funct(value, key)
    end
    return dest
end
t.map = table.map


--[[

Applies a function to the elements of a table scanned by the passed iterator.
It returls a table holding the results of the function application, bound to
numeric keys in the order the original elements are returned by the iterator.
If no iterator is passed, all elements are scanned.

The function takes as input an element and its ke, in this order: in fact, the
key is often unnecessary, and would just clutter the code in these cases.

--]]
table.mapToNum = function(tab, funct, iter)
    iter = iter or pairs

    local dest = {}
    for key, value in iter(tab) do
        table.insert(dest, funct(value, key))
    end
    return dest
end
table.map_to_num = table.mapToNum
t.mapToNum, t.map_to_num = table.mapToNum, table.mapToNum


-- Stateless iterator to be used in for loops
table.nonIntPairs = function(tab)
    return nextNonInt, tab
end
table.non_int_pairs = t.nonIntPairs
t.nonIntPairs, t.non_int_pairs = table.nonIntPairs, table.nonIntPairs


-- Linear search. Returns the index of the passed value if found, else nil.
table.search = function(tab, value)
    for k, v in pairs(tab) do
        if v == value then
            return k
        end
    end
    -- No explicit return, thus nil
end
t.search = table.search





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
        for _, destKey in ipairs(dest[destGroup]) do
            tab[destKey] = tab[sourceKey]
        end
    end
end

table.table_keys_alias, table.keysAlias, table.keys_alias =
        table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias
t.tableKeysAlias, t.table_keys_alias, t.keysAlias, t.keys_alias =
        table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias, table.tableKeysAlias

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
t.equal, t.eq = table.equal, table.equal

--[[

Ritorna una table risultato della fusione delle
due passate. Gli indici numerici della seconda
seguiranno quelli della prima; gli altri sono
lasciati invariati, ed in caso di uguaglianza
quelli della seconda sovrascrivono i valori della
prima.

--]]
table.merge = function(tab1, tab2)

local mw = require('mw')

    local dest = mw.clone(tab1)

    --[[
        È necessario il doppio ciclo per avere
        le chiavi intere in ordine
    --]]
    for _, value in ipairs(tab2) do
        table.insert(dest, value)
    end
    for key, value in table.nonIntPairs(tab2) do
        dest[key] = value
    end
    return dest
end

t.merge = table.merge

--[[

Ritorna una table risultato della fusione delle
due passate. Gli indici numerici della seconda
seguiranno quelli della prima; gli altri sono
lasciati invariati, ed in caso di uguaglianza
quelli della seconda sovrascrivono i valori della
prima. Fanno però eccezione le tables, che sono
fuse a loro volta.

--]]
table.recursiveMerge = function(tab1, tab2)

local mw = require('mw')

    local dest = mw.clone(tab1)
    --[[
        È necessario il doppio ciclo per avere
        le chiavi intere in ordine
    --]]
    for _, value in ipairs(tab2) do
        table.insert(dest, value)
    end
    for key, value in table.nonIntPairs(tab2) do
        if dest[key]
                and type(dest[key]) == 'table'
                and type(value) == 'table'
        then
            dest[key] = table.recursiveMerge(dest[key], value)
        else
            dest[key] = value
        end
    end
    return dest
end

table.recursive_merge = table.recursiveMerge
t.recursive_merge, t.recursive_merge =
        table.recursiveMerge, table.recursiveMerge

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
    for key, value in table.nonIntPairs(tab) do
        if cond(value, key) then
            dest[key] = value
        end
    end
    return dest
end

t.filter = table.filter

--[[

Ritorna una table con chiavi e valori
invertiti rispetto a quella passata.

--]]
table.flip = function(tab)
    local flipped = {}
    for key, value in pairs(tab) do
        flipped[value] = key
    end
    return flipped
end

t.flip = table.flip

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
    local check, n = {}, 1

    --[[
        Il doppio ciclo si rende necessario per
        mantenere l'ordine delle chiavi numeriche.
        La variabile n serve per non avere buchi.
        Non si usa minor poiché le chiavi vengono
        già tornate in ordine crescente da ipairs.
    --]]
    for _, value in ipairs(tab) do
        if not check[value] then
            check[value] = n
            n = n + 1
        end
    end

    for key, value in table.nonIntPairs(tab) do
        if minor(key, check[value]) then
            check[value] = key
        end
    end

    return table.flip(check)
end

table.no_duplicates, table.unique =
        table.noDuplicates, table.noDuplicates
t.noDuplicates, t.no_duplicates, t.unique =
        table.noDuplicates, table.noDuplicates, table.noDuplicates

--[[

Ritorna una table con soli indici numerici
i cui elementi sono le chiavi della table
passata, in ordine non specificato

--]]
table.keys = function(tab)
    local keys = {}
    for key in pairs(tab) do
        table.insert(keys, key)
    end
    return keys
end

t.keys = table.keys

--[[

Returns a numeric table containing the values of the passed table, in the
order they are returned in by the iterator. Such iterator defaults to pairs,
and should return two values, the first being the key and the second the value.

--]]
table.values = function(tab, iter)
    iter = iter or pairs

    local values = {}
    for _, value in iter(tab) do
        table.insert(values, value)
    end
    return values
end

t.values = table.values

--[[

Given a table with numeric indexes,
returns another table containing its
elements in the specified indexes
range. End index defaults to largest
index in the table.

--]]
table.slice = function(tab, from, to)
    to = to or #tab
    return table.filter(tab, function(_, key)
        return key >= from and key <= to
    end, ipairs)
end

t.slice = table.slice

--[[

Deep clones a table. It intentionally doesn't clone the metatables, as that's
the job of mw.clone.

--]]
table.copy = function(value)
    local dest = {}
    for k, v in pairs(value) do
        dest[k] = type(v) == 'table'
            and table.copy(v)
            or v
    end
    return dest
end

t.copy = table.copy
table.cloneLoadData, table.clone_load_data = table.copy, table.copy
t.cloneLoadData, t.clone_load_data = table.copy, table.copy

return t
