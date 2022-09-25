-- Modulo per il template Bag

local b = {}

local tab = require('Wikilib-tables')
local w = require('Wikilib')

--[[

Table per gli strumenti che, non essendo
presenti dalla terza generazione in poi,
non hanno uno sprite zaino

--]]

local noImageItems = {'genefurioso', 'fiocco pois', 'messaggio visione',
	'messaggio surf', 'messaggio ritratto', 'messaggio musica',
	'messaggio morph', 'messaggio fiore', 'messaggio eon', 'messaggio dolce',
	'messaggio cielo', 'messaggio azzurro', 'bacca misteriosa',
	'bacca miracolosa', 'bacca menta', 'bacca ghiaccio', 'bacca bruciata',
	'bacca amara', 'baccantiveleno', 'baccantiparalisi', 'bacca oro', 'bacca'
}

-- Link agli sprite zaino, chiamata da lua

b.bagLua = function(item, md)
	return table.search(noImageItems, item:lower()) and '' or
		w.interp('[[File:${item} Sprite Zaino${md}.png|${item}|link=${item}]]',
		{item = item, md = md and 'MD' or ''})
end

b.bag_lua = b.bagLua

-- Link agli sprite zaino, chiamata wikicode (adapter per lua)

b.bag = function(frame)
	local p = w.trimAll(frame.args)
	p.md = string.lower(p.md or p.Md or p.MD or p.mD or '')
	return b.bagLua(p[1], p.md == 'yes')
end

b.Bag = b.bag

return b
