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

Since lua5.2 unpack has been moved to table.unpack, this allows migration with
older versions on PCW.

--]]
table.unpack = table.unpack or unpack

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

Deep clones a table. It intentionally doesn't clone the metatables, as that's
the job of mw.clone.

--]]
table.copy = function(value)
    local dest = {}
    for k, v in pairs(value) do
        dest[k] = type(v) == 'table' and table.copy(v) or v
    end
    return dest
end
t.copy = table.copy


--[[

Merges two tables into a new one. Integer indices of the second table will
follow the ones of the first. Other indices overwrite the ones of the first
in case of equality, unless the values are tables in both the source tables:
in this case they are merged recursively.

--]]
table.deepMerge = function(tab1, tab2)
local mw = require('mw')
    -- Better to use mw.clone, so as to keep metatable of items.
    local dest = mw.clone(tab1)

    -- Double loop to keep integer keys sorted
    for _, value in ipairs(tab2) do
        table.insert(dest, value)
    end
    for key, value in table.nonIntPairs(tab2) do
        if dest[key]
                and type(dest[key]) == 'table'
                and type(value) == 'table'
        then
            dest[key] = table.deepMerge(dest[key], value)
        else
            dest[key] = value
        end
    end
    return dest
end
table.deep_merge = table.deepMerge
t.deep_merge, t.deepMerge = table.deepMerge, table.deepMerge


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
                return k, table.unpack(valueKeys)
            end
        end
    end
    -- No explicit return, thus nil
end
table.deep_search = table.deepSearch
t.deepSearch, t.deep_search = table.deepSearch, table.deepSearch

--[[

Returns true if table is empty, that is it has no values.

--]]
table.empty = function(tab)
    --[[
        next() is a stateless iterator, it doesn't modify the table;
        need to compare to nil as false is also a value
    --]]
    return next(tab) == nil
end
t.empty, t.isEmpty, t.is_empty = table.empty, table.empty, table.empty
table.isEmpty, table.is_empty = table.empty, table.empty

--[[

Returns whether two tables are equal: this means same keys mapped to same
values, where same is the == operator. For the sake of conveniente, it returns
true also for non-table arguments, as long as they computer equals.

--]]
table.equal = function(tab1, tab2)
    --[[
        Arguments are compared directly if:
            - One of them has the __eq metamethod
            - One of them is not a table
    --]]
    local mt1 = getmetatable(tab1)
    local mt2 = getmetatable(tab2)
    if mt1 and mt1.__eq or mt2 and mt2.__eq
            or type(tab1) ~= 'table'
            or type(tab2) ~= 'table' then
        return tab1 == tab2
    end

    -- Optimization: references to the same table can be assessed equal here
    if tab1 == tab2 then
        return true
    end

    --[[
        If the two tables have different number of items, they aren't equal.

        Furthermore, it covers the cases in which:
            - tab1 is empty, and the upcoming loop doesn't run at all.
            - tab1 is a subset of tab2, not covered by the loop, since only
                tab1 indices are used.
    --]]
    if table.getn(tab1) ~= table.getn(tab2) then
        return false
    end

    for key, value in pairs(tab1) do
        -- Easerie to compare this way, being table.equal very type-safe
        if not table.equal(value, tab2[key]) then
            return false
        end
    end

    return true
end
table.eq = table.equal
t.equal, t.eq = table.equal, table.equal

--[[

Returns a table containing only the elements that satisfy the passed predicate.
Integer keys are compacted, so that standard library functions will still work:
in fact, they don't get along well with "holes" in integer keys. Other keys are
kept unchanged.

The predicate takes as input an element and its key, in this order: in fact,
the key is often unnecessary, and would just clutter the code in these cases.
It returns a boolean: if this is true, the element is kept, else is discarded.

--]]
table.filter = function(tab, cond)
    local dest = {}

    -- Double loop to keep integer keys sorted and compact
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

Applies a function over all of the elements of a table returned by the passed
iterator. The function is expected to return a list. The lists produced from
the elements are merged together in the same way as table.merge would do. The
iterator defaults to pairs.

The function takes as input an element and its key, in this order: in fact, the
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

The function takes as input an element and its key, in this order: in fact, the
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


-- Returns the input table, but with keys and values swapped.
table.flip = function(tab)
    local flipped = {}
    for key, value in pairs(tab) do
        flipped[value] = key
    end
    return flipped
end
t.flip = table.flip

--[[

Removes one level of nesting in a table-of-tables. Returns a new table.
Non-table elements are left untouched, while subtables are merged in the
returned as they are given by the iterator. The iterator defaults to pairs.

As items are processed in the order they are returned by the iterator, care
should be taken regarding non-integer indices, since their value are overridden
in assignments. For example,

table.flatten({{1, 2, key1 = 5}, {key1 = 9}}, ipairs) --> {1, 2, key1 = 9}
table.flatten({{key1 = 9}, {1, 2, key1 = 5}}, ipairs) --> {1, 2, key1 = 5}

--]]
table.flatten = function(tab, iter)
    iter = iter or pairs

    local dest = {}
    for k, v in iter(tab) do
        if type(v) == 'table' then
            dest = table.merge(dest, v)
        else
            dest[k] = v
        end
    end
    return dest
end
t.flatten = table.flatten


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
If the second argument is 'num' it only counts items having a integer index,
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

Returns a numeric table whose elements are the keys of the passed one, in an
unspecified order.

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

Applies a function to the elements of a table scanned by the passed iterator.
It returls a table holding the results of the function application, bound to
the same keys as the original items. If no iterator is passed, all elements
are scanned.

The function takes as input an element and its key, in this order: in fact, the
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
integer keys in the order the original elements are returned by the iterator.
If no iterator is passed, all elements are scanned.

The function takes as input an element and its key, in this order: in fact, the
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


--[[

Merges two tables into a new one. Integer indices of the second table will
follow the ones of the first; other indices overwrite the ones of the first
in case of equlity.

--]]
table.merge = function(tab1, tab2)
local mw = require('mw')
    -- Better to use mw.clone, so as to keep metatable of items.
    local dest = mw.clone(tab1)

    -- Double loop to keep integer keys sorted
    for _, value in ipairs(tab2) do
        table.insert(dest, value)
    end
    for key, value in table.nonIntPairs(tab2) do
        dest[key] = value
    end
    return dest
end
t.merge = table.merge


-- Stateless iterator to be used in for loops
table.nonIntPairs = function(tab)
    return nextNonInt, tab
end
table.non_int_pairs = t.nonIntPairs
t.nonIntPairs, t.non_int_pairs = table.nonIntPairs, table.nonIntPairs

-- Predicate search. Returns the index of any value satisfying the predicate,
-- nil if no such values exists in the table. The last parameter iter is
-- optional and specifies the iterator to use (pairs is the default). The
-- predicate takes as arguments the value and the key (the order is reversed
-- because often the key isn't needed)
table.find = function(tab, pred, iter)
    iter = iter or pairs
    for k, v in iter(tab) do
        if pred(v, k) then
            return k
        end
    end
    return nil
end

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

Returns the elements of a numeric table whose indices are within the specified
range. The end of the range defaults to the end of the source table.

Negative values count from the end of the table. For example, -1 is the last
element, -2 is the second last and so on.

--]]
table.slice = function(tab, from, to)
    local length = #tab

    to = to or length
    if from < 0 then
        from = length + from + 1      -- + because from is negative
    end
    if to < 0 then
        to = length + to + 1          -- + because to is negative
    end

    local dest = {}
    for k = from, to do
        table.insert(dest, tab[k])
    end
    return dest
end
t.slice = table.slice


--[[

Aliases keys in a single table. Arguments:
    - tab: the source table
    - source: list of keys to be aliased
    - dest: list of tables, in which every element contains the aliases
        to its corresponding one in source.

Example:
table.tableKeysAlias(t, {'key', 'key1'}, {{'alias', alias1'},
    {'alias2', 'alias3'}})
Equivalent with assignments:
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

Returns a table with the same items of the input one, but without duplicates.
The keys of repeated elements that are kept are the first in lexicographic
order, unless they are integer: in this case they are compacted to allow
compatibility with standard library functions.

--]]
table.unique = function(tab)
    --[[
        Check is meant to be used to test uniqueness of values: the most
        efficient implementation is to keep values as indices, so that
        uniqueness can be checked with simple table indexing. The values are
        the indices in the final table, so that they can easily be flipped.

        n is used as incremental integer index, to avoid "holes" in the final
        table.
    --]]
    local check, n = {}, 1

    -- Minor is not used as ipairs returns integer keys in ascending order.
    for _, value in ipairs(tab) do
        if not check[value] then
            check[value] = n
            n = n + 1
        end
    end

    for key, value in table.nonIntPairs(tab) do
        --[[
            If value is not in check, minor returns true, as the second
            argument is nil
        --]]
        if minor(key, check[value]) then
            check[value] = key
        end
    end

    return table.flip(check)
end
t.unique = table.unique


--[[

Returns a numeric table containing the values of the passed table, in the
order they are returned in by the iterator. Such iterator defaults to pairs.

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

Returns a table from two sources. The items of the new table are obtained by
combining the elements with the same index in the two sources. The default
combinator creates a pair, as a table with two elements.

The used indices are those of the first table returned by the iterator. No
other indices will be considered, especially the extra indices of the second
table. The iterator defaults to pairs.

--]]
table.zip = function(tab1, tab2, combinator, iter)
    combinator = combinator or function(a, b) return {a, b} end
    iter = iter or pairs

    local res = {}
    for k, v in iter(tab1) do
        res[k] = combinator(v, tab2[k])
    end
    return res
end
t.zip = table.zip

--[[

Returns a table from a source, grouping elements by a function value. The items
of the new table are tables, each corresponding to a group. Groups are
determined by the return value of a function: the result is used as a key for
the group table, that contains all the elements of the passed table that
returned that value.

The getGroup function takes an element and its key, in this order: in fact, the
key is often unnecessary, and would just clutter the code in these cases.

--]]
table.groupBy = function(tab, getGroup, iter)
    iter = iter or pairs

    local groups = {}
    for _, v in iter(tab) do
        local groupID = getGroup(v)
        if not groups[groupID] then
            groups[groupID] = {}
        end
        table.insert(groups[groupID], v)
    end

    return groups
end
t.groupBy = table.groupBy

return t
