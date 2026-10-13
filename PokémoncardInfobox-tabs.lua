-- Blocco immagine dell'infobox delle carte del GCC Pocket.
-- Con una sola immagine restituisce il riquadro singolo, come Template:Infobox/image;
-- con più immagini genera un gruppo di tab (vedi Template:Tabs e MediaWiki:Common.css).
-- Chiamata dal Template:PokémoncardInfobox:
-- {{#invoke: PokémoncardInfobox/tabs | main | bordercolor = ... | bordercolor2 = ... | size = ... }}
-- Con bordercolor2 diverso da bordercolor il bordo delle etichette è sfumato
-- fra i due colori (carte a doppio tipo).
--
-- Le immagini sono image/caption e reprintN/recaptionN (N da 1 a 30).
-- Per ciascuna, setN e cardnoN (N = 0 per image) danno sia l'etichetta della tab
-- (simbolo dell'espansione più numero della carta) sia la sua ancora, nella forma
-- <codice espansione>-<numero>, es. A2-049: i redirect delle ristampe puntano lì
-- (#RINVIA [[Carta#A2-049]]) e MediaWiki:Tabs.js apre la tab corrispondente.
-- Ogni tab porta anche data-tab-card, es. "Busta Deluxe ex 363", che combacia con
-- la parte fra parentesi del titolo del redirect: così MediaWiki:Tabs.js apre la
-- tab giusta anche quando il redirect NON ha l'ancora.
-- In alternativa tabN impone un'etichetta libera, senza ancora.

local tabs = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local gccp = require("GCCPocket-data")
-- stylua: ignore end

-- Ritorna l'argomento, se non vuoto, nil altrimenti
local get = function(args, key)
    local v = args[key]
    if not v then
        return nil
    end
    v = txt.trim(v)
    return v ~= "" and v or nil
end

-- Contenitore esterno + riquadro bianco, come Template:Infobox/image:
-- le tab vanno dentro il riquadro, non sul gradiente dell'infobox
local box = function(content)
    return table.concat({
        '<div class="width-xl-100" style="padding: 0.2em;">',
        '<div class="roundy white-bg text-center" style="padding: 0.5em;">',
        content,
        "</div></div>",
    })
end

-- Ancora della tab: codice dell'espansione e numero della carta, es. A2-049
local anchor = function(set, cardno)
    if not (set and cardno and gccp.codes[set]) then
        return nil
    end
    return gccp.codes[set] .. "-" .. mw.text.split(cardno, "/")[1]
end

-- Espansione e numero come compaiono nel titolo del redirect, senza zeri
-- iniziali, es. "Busta Deluxe ex 363"
local cardId = function(set, cardno)
    if not (set and cardno) then
        return nil
    end
    local num = mw.text.split(cardno, "/")[1]
    return set .. " " .. tostring(tonumber(num) or num)
end

tabs.main = function(frame)
    local conf = frame.args
    local data = frame:getParent().args
    -- permette sia la chiamata dal template sia quella diretta, per i test
    if not (data.image or data.reprint1) then
        data = conf
    end
    local size = get(conf, "size") or "180px"
    local border = get(conf, "bordercolor")
    local border2 = get(conf, "bordercolor2")
    local labelclass = get(conf, "labelclass") or "text-center width-xl-30"

    -- segnala le espansioni non ancora presenti in Modulo:GCCPocket/data
    local unknown = false
    local label = function(set, cardno, custom)
        if custom then
            return custom
        end
        if not (set and cardno) then
            return nil
        end
        if not gccp.codes[set] then
            unknown = true
        end
        return table.concat({
            frame:expandTemplate({
                title = "Exp",
                args = { set, pocket = "yes" },
            }),
            " (",
            cardno,
            ")",
        })
    end

    local imgs = {}
    local add = function(n)
        local img = get(data, n == 0 and "image" or ("reprint" .. n))
        if not img then
            return
        end
        local set, cardno = get(data, "set" .. n), get(data, "cardno" .. n)
        table.insert(imgs, {
            img = img,
            desc = get(data, n == 0 and "caption" or ("recaption" .. n)),
            label = label(set, cardno, get(data, "tab" .. n)),
            id = anchor(set, cardno),
            card = cardId(set, cardno),
        })
    end
    for i = 0, 30 do
        add(i)
    end

    local picture = function(e)
        return table.concat({
            "[[File:",
            e.img,
            "|",
            size,
            "|class=img-fluid]]",
            e.desc and table.concat({
                '<div class="small-text">',
                e.desc,
                "</div>",
            }) or "",
        })
    end

    if #imgs == 0 then
        return box(
            "<div class=\"small-text\">''Nessuna immagine disponibile''</div>"
        )
    end
    if #imgs == 1 then
        return box(picture(imgs[1]))
    end

    local header, content = {}, {}
    for i, e in ipairs(imgs) do
        -- senza set/cardno si ripiega sulla posizione, come prima
        local id = e.id or tostring(i - 1)
        local card = e.card
                and table.concat({
                    ' data-tab-card="',
                    mw.text.encode(e.card),
                    '"',
                })
            or ""
        table.insert(
            header,
            table.concat({
                '<div class="tabs-select ',
                labelclass,
                i == 1 and " tabs-select-active" or "",
                '" data-tab="',
                id,
                '"',
                card,
                ">'''",
                e.label or tostring(i),
                "'''</div>",
            })
        )
        table.insert(
            content,
            table.concat({
                '<div class="tabs-tab',
                i == 1 and " tabs-tab-active" or "",
                '" data-tab="',
                id,
                '"',
                card,
                ">",
                picture(e),
                "</div>",
            })
        )
    end
    -- bordo sfumato solo se i due colori sono diversi (doppio tipo)
    local grad = border and border2 and border2 ~= border
    return box(table.concat({
        '<div class="tabs tabs-card-labels',
        grad and " tabs-grad-border" or "",
        '" style="',
        border and table.concat({ "border-color: #", border, "; " }) or "",
        grad and table.concat({
            "--tabs-border-grad: linear-gradient(to right, #",
            border,
            ", #",
            border2,
            "); ",
        }) or "",
        '--tabs-label-border: solid 0.3em; --tabs-label-gap: 0.2em;"><div class="tabs-header">',
        table.concat(header),
        '</div><div class="tabs-content text-center">',
        table.concat(content),
        "</div></div>",
        unknown
                and "[[Categoria:Carte del GCC Pocket con espansione sconosciuta]]"
            or "",
    }))
end

tabs.Main = tabs.main

return tabs
