-- Modulo per le chiamate interne ai template collegamento

local l = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local c = require("Colore-data")
-- stylua: ignore end

--[[

Template:ColoreTipo

Tipo colorato in campo colorato: il colore
della scritta ha default #FFF, il campo il
colore normale del tipo

--]]
l.colorType = function(type, bgColor, textColor)
    return txt.interp(
        '<span style="padding: 0.1ex 0.3em 0.2ex 0.3em; background: #${bg};">[[${type}|<span style="color: #${tc};">${type}</span>]]</span>',
        {
            type = txt.fu(type),
            bg = bgColor or c[type].normale,
            tc = textColor or "FFF",
        }
    )
end

l.color_type, l.typeColor, l.type_color = l.colorType, l.colorType, l.colorType

--[[

Template:Coloretipo2

Tipo colorato (preceduto da 'tipo') in campo colorato:
il colore della scritta è di default #fff,
il campo è del colore del tipo

--]]
l.colorType2 = function(type, bgColor, textColor)
    return txt.interp(
        '<span style="padding: 0.1ex 0.3em 0.2ex 0.3em; background: #${bgColor}">[[${type}|<span style="color: #${tc};">tipo ${type}</span>]]</span>',
        {
            bgColor = bgColor or c[type].normale,
            type = txt.fu(type),
            tc = textColor or "fff",
        }
    )
end

l.color_type2, l.typeColor2, l.type_color2 =
    l.colorType2, l.colorType2, l.colorType2

--[[

Template:Acolore

Collegamento all'abilità con scritta colorata:
il colore della scritta è di default #000

--]]
l.aColor = function(ability, textColor, name)
    return txt.interp(
        '[[${ability}|<span style="color:#${tc};">${name}</span>]]',
        {
            ability = ability,
            tc = textColor or "000",
            name = name or txt.fu(ability),
        }
    )
end

l.a_color = l.aColor

--[[

Template:catColore

Collegamento alla categoria danno con scritta colorata:
il colore è di default cat_text

--]]
l.catColor = function(category, textColor)
    local cat = txt.fu(category) or "Fisico"
    return txt.interp(
        '[[${cat} (categoria danno)|<span style="color: #${tc};">${cat}</span>]]',
        {
            cat = cat,
            tc = textColor or c[cat .. "_text"],
        }
    )
end

l.cat_color = l.catColor

--[[

Template:Bag

Returns the sprite of an item with a link to its page. The item name is case
sensitive because the module can't handle something like 'Fune di Fuga'.

The second parameter is for all optional named arguments. Done this way because
they are (potentially) many, all optional and each one may be there
independently of the others.

--]]
local NOSPRITEITEMS = {
    "Genefurioso",
    "Fiocco Pois",
    "Messaggio Visione",
    "Messaggio Surf",
    "Messaggio Ritratto",
    "Messaggio Musica",
    "Messaggio Morph",
    "Messaggio Fiore",
    "Messaggio Eon",
    "Messaggio Dolce",
    "Messaggio Cielo",
    "Messaggio Azzurro",
    "Bacca Misteriosa",
    "Bacca Miracolosa",
    "Bacca Menta",
    "Bacca Ghiaccio",
    "Bacca Bruciata",
    "Bacca Amara",
    "Baccantiveleno",
    "Baccantiparalisi",
    "Bacca Oro",
    "Bacca",
}

l.bag = function(item, args)
    args = args or {}
    if tab.search(NOSPRITEITEMS, item) then
        return ""
    else
        return txt.interp(
            "[[File:${item} Sprite Zaino.png|${size}|${item}|link=${link}]]",
            {
                item = item,
                link = args.link
                    or (item == "Perla" and "Perla (strumento)" or item),
                size = "24px",
            }
        )
    end
end

--[[

Template:tt

Not very useful, but you don't know if the future will bring another change.
Used to add a tooltip to a text

--]]
l.tt = function(text, title)
    return table.concat({
        '<span class="explain tooltips" title="',
        title,
        '">',
        text,
        "</span>",
    })
end

return l
