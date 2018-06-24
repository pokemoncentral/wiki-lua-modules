--[[

Crea un box tipo o una lista di boxes a partire da uno o
più tipi rispettivamente, ed eventuali classi e styles css

--]]

local b = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local css = require('Css')
local w = require('Wikilib')

local predefs = {
    thick = {
        classes = ' roundy-5 text-center',
        styles = 'padding: 0.5ex 0.3em;'
    },

    thin = {
        classes = ' roundy-5 text-center',
        styles = 'padding: 0 0.5ex;'
    }
}

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

b.boxLua = function(text, link, color, classes, styles, textcolor, pdfs)
    io.stderr:write(styles, '\n')
    classes, styles = css.classesStyles(classes, styles, predefs, pdfs)

    io.stderr:write(styles, '\n')

	return string.interp([=[<div class="text-center roundy${class}" style="${bg}; ${style}">[[${link}|<span style="color:#${tc}">${text}</span>]]</div>]=], {
		class = classes,
		bg = css.horizGradLua{color, 'dark', color, 'normale'},
		tc = textcolor or 'FFF',
		link = link or text,
		text = text,
		style = styles
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
    local p = w.trimAll(mw.clone(frame.args))
	return b.boxLua(unpack(p))
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

b.boxTipoLua = function(tipo, class, style, pdfs)
	tipo = string.fu(string.trim(tipo or 'Sconosciuto'))
	return b.boxLua(tipo, tipo, tipo, class, style, 'FFF', pdfs)
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
        | padding: 2px; }}

--]]

b.boxTipo = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    return b.boxTipoLua(unpack(p))
end

b.BoxTipo = b.boxTipo

-- Crea una lista di boxes

--[[

Chiamata da lua; argomenti
- tab: una table di tipi
- class: stringa di classi css (vedi b.boxLua)
- style: stringa o table per gli styles (vedi b.boxLua)

--]]

b.listTipoLua = function(types, class, style, pdfs)
    return table.concat(table.map(types, function(type)
        return b.boxTipoLua(type, class, style, pdfs)
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
    local p = w.trimAll(mw.clone(frame.args))
    local types = mw.text.split(table.remove(p, 1), ',%s*')
    return b.listTipoLua(types, unpack(p))
end

b.ListTipo = b.listTipo

return b
