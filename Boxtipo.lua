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
- tipo: tipo
- class: opzionale (default ''), stringa di classi css,
    viene concatenata a "text-center roundy"
- style: opzionale (default ''), stringa o table che
    descrive le property css da mettere nell'attributo
    style. Esempio:
    {margin = '2px 3px', padding = '3px'} -->
    margin: 2px 3px; padding: 3px

--]]

b.boxLua = function(tipo, class, style)
    tipo = string.trim(tipo or 'Sconosciuto')

    if type(style) == 'table' then
        local acc = {}
        for property, value in pairs(style) do
            table.insert(acc, table.concat{property, ': ', value})
        end
        style = table.concat(acc, '; ') .. ';'
    else
        style = string.trim(style or '')
    end

    return string.interp([=[<div class="text-center roundy${class}" style="${bg};${style}">[[${type} (tipo)|<span style="color:#FFF">${type}</span>]]</div>]=],
{
    class = class or '',
    bg = css.horizGradLua(tipo, 'dark', tipo, 'normale'),
    type = string.firstUppercase(tipo),
    style = style
})
end

b.box_lua = b.boxLua

--[[

Chiamata da wikicode (adapter per lua); argomenti
- 1: tipo,
- 2: opzionale, (default ''), classi css
    (vedi b.boxLua)
- 3: opzionale, (default ''), styles css,
    stringa per ovvi motivi (vedi b.boxLua)

Esempio:
{{#invoke | Boxtipo | box | Elettro | left inline-block
        | padding: 2px; | border = yes}}

--]]

b.box = function(frame)
    return b.boxLua(frame.args[1], frame.args[2],
        frame.args[3])
end

b.Box = b.box

-- Crea una lista di boxes

--[[

Chiamata da lua; argomenti
- tab: una table di tipi
- class: stringa di classi css (vedi b.boxLua)
- style: stringa o table per gli styles (vedi b.boxLua)

--]]

b.listLua = function(tab, class, style)
    return table.concat(table.map(tab, function(type)
        return b.boxLua(type, class, style)
    end))
end

b.list_lua = b.listLua

--[[

Chiamata da wikicode (adapter per lua); argomenti
- 1: elenco di tipi separato da virgole (gli spazi sono ignorati)
- 2: opzionale, (default ''), classi css  (vedi b.box)
- 3: opzionale, (default ''), styles css,
    stringa per ovvi motivi (vedi b.box)
- border: opzionale (default 'no'), yes o no,
    visualizza il bordo
Esempio:

{{#invoke: Boxtipo | list | Normale, Acciaio,Terra | inline-block
        | padding: 2px; | border = yes}}

--]]

b.list = function(frame)
    return b.listLua(mw.text.split(frame.args[1], ',%s*'),
            frame.args[2], frame.args[3])
end

b.List = b.list

return b
