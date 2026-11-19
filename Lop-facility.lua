--[[

Modulo:Lop/facility — una riga delle tabelle "Pokémon degli edifici lotta".

Fa lo stesso lavoro di Template:Lop/facility, ma costruisce la riga in Lua
invece di comporla con ~30 transclusioni annidate. Serve alle pagine lunghe
(gli elenchi dei Pokémon degli edifici lotta), che chiamano il modulo una volta
sola per tabella tramite Modulo:Render:

    {{#invoke: Render | render | Lop/facility | row | //
    |gen <- 8|818|Inteleon|Luminpolvere|Fanghiglia|Acqua|Palla Ombra|Spettro|Staffetta|Normale|Doppioteam|Normale|Timida||||252||252| //
    }}

Così ogni riga costa al parser solo il proprio output (≈3,6 KB) invece di
7,6 KB: il conteggio dei template inclusi non somma più le chiamate annidate
(MSlist, Bag, Stat, Colore2, box, colore, Dexlist).

Parametri, identici a quelli del template: 1 = numero del dex nazionale,
2 = nome del Pokémon, 3 = strumento, 4/6/8/10 = mosse, 5/7/9/11 = tipi delle
mosse, 12 = natura, 13-18 = punti base (PS, Attacco, Difesa, Att. Sp., Dif.
Sp., Velocità), gen = generazione dei minisprite, ab/ab2 = abilità,
stats = "yes" per l'intestazione "Statistiche" al posto di "Punti base".

Il parametro note (presente in alcune pagine) non era letto dal template e
resta ignorato.

--]]

local p = {}

-- stylua: ignore start
local mw = require('mw')

local w = require('Wikilib')
local forms = require('Wikilib-forms')
local ms = require('MiniSprite')
local box = require('Box')
local colore = require('Colore')
-- stylua: ignore end

-- I grassetti del wikitesto: fuori da una stringa per non impazzire con gli apici.
local TQ = "'''"

-- Le forme alternative servono ai link dopo il nome del Pokémon (getLink):
-- si caricano una volta per pagina invece che a ogni riga.
forms.loadUseless(true)

--[[

Ritorna un esadecimale del modulo Colore senza passare dal parser: le funzioni
di Modulo:Colore leggono frame.args[1] come variante ("light", "dark" o niente
per il colore normale), quindi basta un finto frame.

--]]
local function hex(name, variant)
    local f = colore[name]
    if type(f) ~= "function" then
        error("Colore sconosciuto: " .. tostring(name))
    end
    return f({ args = variant and { variant } or {} })
end

-- Un parametro è "vero" per #if quando non è né assente né vuoto.
local function truthy(value)
    return value ~= nil and value ~= ""
end

-- Valore del parametro, con il default solo se il parametro è assente.
local function arg(args, index, default)
    local value = args[index]
    if value == nil then
        return default
    end
    return value
end

--[[

Template:Itemlink, riscritto: lo strumento può essere disambiguato o non
avere pagina propria. Ritorna nil per gli strumenti che Template:Bag non
stampa affatto.

--]]
local itemVoid = {}
for _, name in ipairs({
    "None",
    "none",
    "Baccantivel.",
    "Baccantipar.",
    "Bacca Ghiac.",
    "Bacca Mirac.",
    "Mess.Ritratto",
    "Mess.Eon",
    "Mattoncino",
    "Mess.Musica",
    "Mess.Cielo",
    "Bigl.Uovo",
    "Mess.Surf",
    "GS Ball",
    "Mess. Morph",
    "Genefurioso",
    "Fiocco Pois",
    "Fiocco Rosa",
    "Scatola Normale",
    "Scatola Lusso",
    "Scat.Normale",
    "Scat.Lusso",
    "Messaggio Visione",
    "Messaggio Surf",
    "Messaggio Ritratto",
    "Messaggio Musica",
    "Messaggio Morph",
    "Messaggio Fiore",
    "Messaggio Eon",
    "Messaggio Dolce",
    "Mess.Dolce",
    "Messaggio Cielo",
    "Messaggio Azzurro",
    "Bacca Misteriosa",
    "Bacca Miracolosa",
    "Bacca Menta",
    "Bacca Ghiaccio",
    "Bacca Bruciata",
    "Bacca Bruc.",
    "Bacca Amara",
    "Baccantiveleno",
    "Baccantiparalisi",
    "Bacca Oro",
    "Bacca",
}) do
    itemVoid[name] = true
end

local itemTarget = {
    ["Poké Ball"] = "Poké Ball (strumento)",
    ["Bacca"] = "Bacca (strumento)",
    ["Perla"] = "Perla (strumento)",
    ["Cinturanera"] = "Cinturanera (strumento)",
    ["Rubino"] = "Rubino (strumento)",
    ["Zaffiro"] = "Zaffiro (strumento)",
    ["Detector"] = "Ricerca Strumenti",
    ["Condividi Esp."] = "Condividi Esperienza",
    ["Condiv. Esp."] = "Condividi Esperienza",
    ["Distrib Esp."] = "Condividi Esperienza",
    ["Bici Corsa"] = "Bici da corsa",
    ["Bici Cross"] = "Bici da cross",
    ["Nucleo Zygarde"] = "Cellule e Nuclei di Zygarde",
    ["Cellula Zygarde"] = "Cellule e Nuclei di Zygarde",
}

local function itemLink(item)
    if itemVoid[item] then
        return nil
    end
    local prefix = string.sub(item, 1, 2)
    if prefix == "MT" or prefix == "MN" or prefix == "DT" then
        return prefix
    end
    return itemTarget[item] or item
end

--[[

Cella dello strumento: sprite della Borsa più nome, come
{{bag|…|name=yes|list=yes|breakpoint=md}}.

--]]
local function bagCell(item)
    local target = itemLink(item)
    if target == nil then
        return ""
    end
    return '<div class="flex flex-row flex-nowrap flex-items-center block-md">'
        .. "[[File:"
        .. item
        .. " Sprite Zaino.png|24px|link="
        .. target
        .. "]]"
        .. '<span class="flex-item-fill" style="padding-left: 0.3em;">[['
        .. target
        .. "|"
        .. item
        .. "]]</span></div>"
end

--[[

Cella del Pokémon: minisprite più nome, come {{MSlist|…|gen=…|bp=md}}.

--]]
local function msCell(ndex, name, gen)
    local sprite = ms.staticLua({ ndex = ndex, gen = gen })
    local inner = '<span class="flex-item-fill " style="padding-left: 0.3em;">[['
        .. name
        .. "]]"
    if forms.getlink(ndex) ~= "" then
        inner = inner .. forms.getlink(ndex, "black")
    end
    inner = inner .. "</span>"
    return '<div class="flex flex-row flex-nowrap flex-items-center block-md">'
        .. sprite
        .. inner
        .. "</div>"
end

--[[

Template:Colore2, riscritto: link colorato, con le classi per testo bianco o
nero quando l'esadecimale è FFF o 000.

--]]
local function colore2(hexv, link, text)
    local upper = string.upper(hexv)
    local attribute
    if upper == "FFF" or upper == "FFFFFF" then
        attribute = 'class="white-text"'
    elseif upper == "000" or upper == "000000" then
        attribute = 'class="black-text"'
    else
        attribute = 'style="color:#' .. hexv .. ';"'
    end
    return "[[" .. link .. "|<span " .. attribute .. ">" .. text .. "</span>]]"
end

--[[

Statistiche: parametro, colore, pagina e sigla di ciascuna cella, con il
ripiego di Template:Stat quando il valore non c'è.

--]]
local stats = {
    {
        index = 13,
        color = "ps",
        link = "Statistiche#Punti_Salute",
        label = "PS",
        fallback = "[[Statistiche#Punti Salute|PS]]",
    },
    {
        index = 14,
        color = "attacco",
        link = "Statistiche#Attacco",
        label = "A.",
        fallback = "[[Statistiche#Attacco|A.]]",
    },
    {
        index = 15,
        color = "difesa",
        link = "Statistiche#Difesa",
        label = "D.",
        fallback = "[[Statistiche#Difesa|D.]]",
    },
    {
        index = 16,
        color = "attacco_speciale",
        link = "Statistiche#Attacco_Speciale",
        label = "A.Sp.",
        fallback = "[[Statistiche#Attacco Speciale|A.Sp.]]",
    },
    {
        index = 17,
        color = "difesa_speciale",
        link = "Statistiche#Difesa_Speciale",
        label = "D.Sp.",
        fallback = "[[Statistiche#Difesa Speciale|D.Sp.]]",
    },
    {
        index = 18,
        color = "velocita",
        link = "Statistiche#Velocità",
        label = "V.",
        fallback = "[[Statistiche#Velocità|V.]]",
        plain = true,
    },
}

local function statCell(value, stat)
    if not truthy(value) then
        return "—<br>" .. stat.fallback
    end
    local content
    if stat.plain then
        content = "[[Statistiche#Velocità|V.]]"
    else
        local dark = hex(stat.color, "dark")
        content = colore2(dark, stat.link, stat.label)
    end
    local light = hex(stat.color, "light")
    local dark = hex(stat.color, "dark")
    return '<div class="roundy-5" style="background: #'
        .. light
        .. "; padding: 0.1em; color: #"
        .. dark
        .. ';">'
        .. value
        .. "<br>"
        .. content
        .. "</div>"
end

local DEXLINK = "[[Elenco dei Pokémon secondo il Pokédex Nazionale|#Dex]]"

--[[

Una riga della tabella. Riceve il frame di MediaWiki o quello finto costruito
da Modulo:Render ({args = …}).

--]]
function p.row(frame)
    local args = w.trimAll(mw.clone(frame.args), false)
    local ability = truthy(args.ab)
    local item = args[3]

    local itemOut = truthy(item) and bagCell(item) or "&mdash;"
    local abilityOut = ""
    if ability then
        abilityOut = "\n"
            .. '| class="width-xl-10 width-md-33" style="padding: 0.2em;" | <div class="visible-md">'
            .. TQ
            .. "[[Abilità]]:"
            .. TQ
            .. "</div>[["
            .. (args.ab or "Ferromascella")
            .. "]]"
        if truthy(args.ab2) then
            abilityOut = abilityOut .. "<br>[[" .. args.ab2 .. "]]"
        end
    end

    local function moveCell(index, typeIndex)
        return box.boxLua(
            arg(args, index, "Scontro"),
            arg(args, index, "Scontro"),
            arg(args, typeIndex, "Sconosciuto"),
            "thin"
        )
    end

    local function optionalMove(index, typeIndex)
        if truthy(args[index]) then
            return moveCell(index, typeIndex)
        end
        return "&#8212;"
    end

    local cell = '<div class="width-xl-100 width-md-50 width-xs-100" style="padding: 0.1em;">'
    local lines = {
        '|- class="flex-md flex-row flex-wrap flex-main-center flex-items-center roundy" style="margin-top: 0.3em;"',
        '| class="width-xl-5 width-md-50" style="padding: 0.2em;" data-sort-value="'
            .. (args[1] or "")
            .. '" | <div class="visible-md">'
            .. TQ
            .. DEXLINK
            .. ":"
            .. TQ
            .. "</div>"
            .. arg(args, 1, "000"),
        '| class="width-xl-10 width-md-50" style="padding: 0.2em;" data-sort-value="'
            .. (args[2] or "")
            .. '" | '
            .. msCell(
                arg(args, 1, "000"),
                arg(args, 2, "MissingNo."),
                args.gen
            ),
        '| class="width-xl-15 width-md-'
            .. (ability and "33" or "50")
            .. '" style="padding: 0.2em;" data-sort-value="'
            .. (item or "")
            .. '" | <div class="visible-md">'
            .. TQ
            .. "[[Strumento]]:"
            .. TQ
            .. "</div>"
            .. itemOut
            .. abilityOut,
        '| class="width-xl-10 width-md-'
            .. (ability and "33" or "50")
            .. '" style="padding: 0.2em;" data-sort-value="'
            .. (args[12] or "")
            .. '" | <div class="visible-md">'
            .. TQ
            .. "[[Natura]]:"
            .. TQ
            .. "</div>"
            .. (truthy(args[12]) and args[12] or "&#8212;"),
        '| class="width-xl-20 width-md-100" style="padding: 0.3em;" | <div class="visible-md">'
            .. TQ
            .. "[[Mossa|Mosse]]:"
            .. TQ
            .. "</div>",
        '<div class="flex flex-row flex-wrap flex-items-stretch flex-main-space-between">',
        cell .. moveCell(4, 5) .. "</div>",
        cell .. optionalMove(6, 7) .. "</div>",
        cell .. optionalMove(8, 9) .. "</div>",
        cell .. optionalMove(10, 11) .. "</div>",
        "</div>",
        '| class="width-xl-'
            .. (ability and "30" or "40")
            .. ' width-md-100" style="padding: 0em;" | <div class="visible-md">'
            .. TQ
            .. (args.stats == "yes" and "[[Statistiche]]" or "[[Punti base]]")
            .. ":"
            .. TQ
            .. "</div>",
        '<div class="flex-row-center-stretch flex-wrap" style="margin: 0.2em;">',
    }
    for _, stat in ipairs(stats) do
        lines[#lines + 1] = '<div class="width-xl-15 width-xs-33" style="padding: 0.1em;">'
            .. statCell(args[stat.index], stat)
            .. "</div>"
    end
    lines[#lines + 1] = "</div>"

    return table.concat(lines, "\n")
end

return p
