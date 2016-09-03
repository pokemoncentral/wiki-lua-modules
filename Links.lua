-- Modulo per le chiamate interne ai template collegamento

local l = {}

local txt = require('Wikilib-strings')
local c = require("Colore-data")

--[[

Template:ColoreTipo

Tipo colorato in campo colorato: il colore
della scritta ha default #FFF, il campo il
colore normale del tipo

--]]
l.colorType = function(type, bgColor, textColor)
	return string.interp('<span style="padding: 0.1ex 0.3em 0.2ex 0.3em; background: #${bg};">[[${type} (tipo)|<span style="color: #${tc};">${type}</span>]]</span>',
		{
			type = string.fu(type),
			bg = bgColor or c[type].normale,
			tc = textColor or 'FFF'
		})
end

l.color_type, l.typeColor, l.type_color = l.colorType, l.colorType, l.colorType

--[[

Template:Coloretipo2

Tipo colorato (preceduto da 'tipo') in campo colorato:
il colore della scritta è di default #fff,
il campo è del colore del tipo

--]]
l.colorType2 = function(type, bgColor, textColor)
	return string.interp('<span style="padding: 0.1ex 0.3em 0.2ex 0.3em; background: #${bgColor}">[[${type} (tipo)|<span style="color: #${tc};">tipo ${type}</span>]]</span>',
		{
			bgColor = bgColor or c[type].normale,
			type = string.fu(type),
			tc = textColor or 'fff'
		})
end

l.color_type2, l.typeColor2, l.type_color2 = l.colorType2, l.colorType2, l.colorType2

--[[

Template:Acolore

Collegamento all'abilità con scritta colorata:
il colore della scritta è di default #000

--]]
l.aColor = function(ability, textColor, name)
	return string.interp('[[${ability} (abilità)|<span style="color:#${tc};">${name}</span>]]',
		{
			ability = ability,
			tc = textColor or '000',
			name = name or string.fu(ability)
		})
end


l.a_color = l.aColor

--[[

Template:catColore

Collegamento alla categoria danno con scritta colorata:
il colore è di default cat_text

--]]
l.catColor = function(category, textColor)
	local cat = string.fu(category) or 'Fisico'
	return string.interp('[[${cat} (categoria danno)|<span style="color: #${tc};">${cat}</span>]]',
		{
			cat = cat,
			tc = textColor or c[cat .. '_text']
		})
end

l.cat_color = l.catColor

return l
