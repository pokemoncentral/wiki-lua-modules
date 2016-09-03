--[[

Libreria per facilitare la programmazione
a oggetti in lua, che non è nativamente
implementata

--]]
local oop = {}

--[[

I metametodi ereditabili: sono esclusi
__index e __newindex perché usati per
implementare l'oop e l'ereditarietà
stessi

--]]
local metamInherit = {
	__add = true,
	__sub = true,
	__mul = true,
	__div = true,
	__mod = true,
	__pow = true,
	__unm = true,
	__concat = true,
	__len = true,
	__eq = true,
	__lt = true,
	__le = true,
	__call = true,
	__tostring = true,
	__index = false,
	__newindex = false
}

-- Stateless iterator sui metametodi ereditabili
local nextMetamethod = function(tab, key)
	local nextKey, nextValue = key

	repeat
		nextKey, nextValue = next(tab, nextKey)
	until not nextKey or metamInherit[nextKey]
				
	return nextKey, nextValue
end

-- Stateless iterator da usare nei generic for loops
local metamethods = function(tab)
	return nextMetamethod, tab
end

--[[

Crea una classe, chiamabile come costruttore
(come in C++ e Java), supposto che che lo
stesso sia anche presente come metodo statico
.new(). La table ritornata può essere settata
direttamente come metatable delle istanze.

Si può eventualmente ereditare da un'altra
classe passandola come primo parametro, a
patto che sia stata creata con questo stesso
metodo: essa è accessibile tramite la chiave
'super', sia come membro statico che istanza.
Vengono ereditati tutti i metodi e metametodi
tranne __index e __newindex, usati per
implementare oop e ereditarietà stessi.

--]]
oop.makeClass = function(superClass)
	local class = setmetatable({}, {
		__call = function(self, ...)
			return self.new(...)
		end,

		__index = superClass
	})
	class.__index = class

	if superClass then
		class.super = superClass

		--[[
			Probabilmente per l'accesso ai metametodi
			non viene consultato il metamedoto __index,
			quindi vanno inseriti esplicitamente nella
			classe figlia.
		--]]
		for name, impl in metamethods(superClass) do
			class[name] = impl
		end
	end

	return class
end

oop.instanceof = function(instance, class)
	return getmetatable(instance) == class
end

oop.isA, oop.is_a = oop.instanceof, oop.instanceof

return oop
