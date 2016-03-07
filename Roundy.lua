-- In questo modulo sono contenuti i vari arrotondamenti per le tabelle

local m = {}
local txt = require('Wikilib-strings')

m.roundyLua = function(radius)
	return string.interp('border-radius: ${r}; -moz-border-radius: ${r}; -webkit-border-radius: ${r}; -khtml-border-radius: ${r}; -icab-border-radius: ${r};', {r = radius or '10px'})
end

m.roundy = function(frame)
    return m.roundyLua(string.trim(frame.args[1] or '10px'))
end

m.tlLua = function(radius)
	return string.interp('border-top-left-radius: ${r}; -moz-border-radius-topleft: ${r}; -webkit-border-top-left-radius: ${r}; -khtml-border-top-left-radius: ${r}; -icab-border-top-left-radius: ${r};', {r = radius or '10px'})
end

m.topleft = function(frame)
    return m.tlLua(string.trim(frame.args[1] or '10px'))
end

m.tl = m.topleft

m.trLua = function(radius)
	return string.interp('border-top-right-radius: ${r}; -moz-border-radius-topright: ${r}; -webkit-border-top-right-radius: ${r}; -khtml-border-top-right-radius: ${r}; -icab-border-top-right-radius: ${r};', {r = radius or '10px'})
end

m.topright = function(frame)
    return m.trLua(string.trim(frame.args[1] or '10px'))
end

m.tr = m.topright

m.blLua = function(radius)
	return string.interp('border-bottom-left-radius: ${r}; -moz-border-radius-bottomleft: ${r}; -webkit-border-bottom-left-radius: ${r}; -khtml-border-bottom-left-radius: ${r}; -icab-border-bottom-left-radius: ${r};', {r = radius or '10px'})
end

m.bottomleft = function(frame)
    return m.blLua(string.trim(frame.args[1] or '10px'))
end

m.bl = m.bottomleft

m.brLua = function(radius)
    return string.interp('border-bottom-right-radius: ${r}; -moz-border-radius-bottomright: ${r}; -webkit-border-bottom-right-radius: ${r}; -khtml-border-bottom-right-radius: ${r}; -icab-border-bottom-right-radius: ${r};', {r = radius or '10px'})
end

m.bottomright = function(frame)
    return m.brLua(string.trim(frame.args[1] or '10px'))
end

m.br = m.bottomright

m.topLua = function(radius)
	return m.tlLua(radius) .. m.trLua(radius)
end

m.top = function(frame)
    return m.topLua(string.trim(frame.args[1] or '10px'))
end

m.bottomLua = function(radius)
	return m.blLua(radius) .. m.brLua(radius)
end

m.bottom = function(frame)
    return m.bottomLua(string.trim(frame.args[1] or '10px'))
end

m.leftLua = function(radius)
	return m.tlLua(radius) .. m.blLua(radius)
end

m.left = function(frame)
    return m.leftLua(string.trim(frame.args[1] or '10px'))
end

m.rightLua = function(radius)
	return m.trLua(radius) .. m.brLua(radius)
end

m.right = function(frame)
    return m.rightLua(string.trim(frame.args[1] or '10px'))
end

return m

