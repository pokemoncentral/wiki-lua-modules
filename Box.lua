--[[

Crea un box tipo o una lista di boxes a partire da uno o
più tipi rispettivamente, ed eventuali classi e styles css

--]]

local b = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local css = require('Css')

--[[

Chiamata da lua; argomenti:
- text: testo visualizzato
- link: link (default uguale a text)
- color: colore del gradiente (da dark a normale)
- class: opzionale (default ''), stringa di classi css,
    viene concatenata a "text-center roundy"
- style: opzionale (default ''), stringa o table che
    descrive le property css da mettere nell'attributo
    style. Esempio:
    {margin = '2px 3px', padding = '3px'} -->
    margin: 2px 3px; padding: 3px
- textcolor: opzionale (default 'FFF'), colore del testo

--]]

b.boxLua = function(text, link, color, class, style, textcolor)
	if type(style) == 'table' then
		local acc = {}
		for property, value in pairs(style) do
			table.insert(acc, table.concat{property, ': ', value})
		end
		style = table.concat(acc, '; ') .. ';'
	else
		style = string.trim(style or '')
	end

	return string.interp([=[<div class="text-center roundy${class}" style="${bg}; ${style}">[[${link}|<span style="color:#${tc}">${text}</span>]]</div>]=], {
		class = class or '',
		bg = css.horizGradLua{color, 'dark', color, 'normale'},
		tc = textcolor or 'FFF',
		link = link or text,
		text = text,
		style = style
	})
end

b.box_lua = b.boxLua

--[[

Chiamata da wikicode (adapter per lua); argomenti
- 1: testo mostrato,
- 2: link del testo (default uguale al testo),
- 3: colore del background,
- 4: opzionale, (default ''), classi css
	(vedi b.boxLua)
- 5: opzionale, (default ''), styles css,
	stringa per ovvi motivi (vedi b.boxLua)
- 6: opzionale (default 'FFF'), colore del testo

--]]

b.box = function(frame)
	return b.boxLua(frame.args[1], frame.args[2],
		frame.args[3], frame.args[4], frame.args[5],
		frame.args[6])
end

b.Box = b.box

--[[

Chiamata da lua; argomenti:
- tipo: tipo
- class: opzionale (default ''), stringa di classi css,
    viene concatenata a "text-center roundy"
- style: opzionale (default ''), stringa o table che
    descrive le property css da mettere nell'attributo
    style. Esempio:
    {margin = '2px 3px', padding = '3px'} -->
    margin: 2px 3px; padding: 3px

--]]

b.boxTipoLua = function(tipo, class, style)
	tipo = string.fu(string.trim(tipo or 'Sconosciuto'))
	return b.boxLua(tipo, tipo .. ' (tipo)', tipo, class, style, 'FFF')
end

b.box_tipo_lua = b.boxTipoLua

--[[

Chiamata da wikicode (adapter per lua); argomenti
- 1: tipo,
- 2: opzionale, (default ''), classi css
    (vedi b.boxLua)
- 3: opzionale, (default ''), styles css,
    stringa per ovvi motivi (vedi b.boxLua)

Esempio:
{{#invoke | Box | boxTipo | Elettro | left inline-block
        | padding: 2px; | border = yes}}

--]]

b.boxTipo = function(frame)
    return b.boxTipoLua(frame.args[1], frame.args[2],
        frame.args[3])
end

b.BoxTipo = b.boxTipo

-- Crea una lista di boxes

--[[

Chiamata da lua; argomenti
- tab: una table di tipi
- class: stringa di classi css (vedi b.boxLua)
- style: stringa o table per gli styles (vedi b.boxLua)

--]]

b.listTipoLua = function(tab, class, style)
    return table.concat(table.map(tab, function(type)
        return b.boxTipoLua(type, class, style)
    end))
end

b.list_tipo_lua = b.listTipoLua

--[[

Chiamata da wikicode (adapter per lua); argomenti
- 1: elenco di tipi separato da virgole (gli spazi sono ignorati)
- 2: opzionale, (default ''), classi css  (vedi b.box)
- 3: opzionale, (default ''), styles css,
    stringa per ovvi motivi (vedi b.box)
- border: opzionale (default 'no'), yes o no,
    visualizza il bordo
Esempio:

{{#invoke: Box | listTipo | Normale, Acciaio,Terra | inline-block
        | padding: 2px; | border = yes}}

--]]

b.listTipo = function(frame)
    return b.listTipoLua(mw.text.split(frame.args[1], ',%s*'),
            frame.args[2], frame.args[3])
end

b.ListTipo = b.listTipo

return b
