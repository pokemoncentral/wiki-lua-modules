local oop = {}

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
	__index = false,
	__newindex = false
}

local nextMetamethod = function(tab, key)
	local nextKey, nextValue = key

	repeat
		nextKey, nextValue = next(tab, nextKey)
	until not nextKey or metamInherit[nextKey]
				
	return nextKey, nextValue
end

local metamethods = function(tab)
	return nextMetamethod, tab
end

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
		for name, impl in metamethods(superClass) do
			class[name] = impl
		end
	end

	return class
end

return oop
