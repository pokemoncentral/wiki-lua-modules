--[[

Funzioni di libreria per la gestione
delle forme alternative

--]]

local mw = require('mw')

local f = {}
local tab = require('Wikilib-tables') -- luacheck: no unused
local txt = require('Wikilib-strings') -- luacheck: no unused
local genUtil = require('Wikilib-gens')
local alt = require("AltForms-data")

--[[

Unisce le tabelle AltForms/data e UselessForms/data
gestendo anche la presenza di Pokémon in entrambi.
Restituisce la tabella così creata

--]]
f.allFormsData = function()
    local all = table.cloneLoadData(alt)
    local useless = require('UselessForms-data')

    --[[
        No need for ipairs because integer keys
        are used only to index Pokémon by ndex
    --]]
    for k, v in pairs(useless) do
        if all[k] then

            --[[
            This Pokémon is in both useless and altForms
            Right now only Pikachu
            --]]
            all[k] = table.recursiveMerge(all[k], v)

            --[[
            gamesOrder is a pain in the neck
            right now, with Pikachu, it is possible to
            simply concatenate the two tables and remove
            the second 'base'
            --]]
            all[k].gamesOrder = table.noDuplicates(table.merge(
                                    all[k].gamesOrder,
                                    v.gamesOrder
                                ))

        else
            all[k] = v
        end
    end

    return all
end

f.allformsdata, f.all_forms_data = f.allFormsData, f.allFormsData

--[[

Se merge è false usa come modulo dati
per le forme alternative UselessForms/data,
se è true li usa entrambi.
Gestisce anche Pikachu, unico Pokémon presente
in entrambi i moduli dati.

--]]
f.loadUseless = function(merge)
    if merge then
        alt = f.allFormsData()
    else
        alt = require("UselessForms-data")
    end
end

f.loaduseless, f.load_useless = f.loadUseless, f.loadUseless

--[[

Estrae la sigla della forma alternativa dal
nome del Pokémon così come è negli indici
delle tabelle dati o negli ndex dei Mini
Sprite, oppure a partire dal nome del Pokémon
e quello esteso della forma alternativa. In
caso di fallimento, ritorna la stringa vuota.

--]]
f.getabbr = function(name, extform)
    if alt[tonumber(name) or name:lower()] then
        extform = string.lower(extform or '')
        name = tonumber(name) or name:lower()
        return alt[name].ext[extform] or 'base'
    end
    return name:match('(%u+%a*)$') or 'base'
end

f.getAbbr, f.get_abbr = f.getabbr, f.getabbr

--[[

Estrae nome e sigla della forma alternativa
dal nome del Pokémon così come è negli indici
delle tabelle dati o negli ndex dei Mini Sprite.
In caso di fallimento, ritorna la stringa vuota.

--]]
f.getnameabbr = function(name, extform)
    if alt[tonumber(name) or name:lower()] then
        extform = string.lower(extform or '')
        name = tonumber(name) or name:lower()
        return name, alt[name].ext[extform] or 'base'
    end
    local poke, abbr = name:match("^([%lé%-♂♀'%s%.&#;%d]+)(%u*%a*)$")
    return tonumber(poke) or poke or '', abbr or 'base'
end

f.getNameAbbr, f.get_name_abbr = f.getnameabbr, f.getnameabbr

--[[

Il parametro black è un booleano, mentre ext
deve essere minuscolo. Recupera il link per
le forme alternative a partire dal nome del
Pokémon comprensivo di sigla, oppure dal nome
del Pokémon e quello esteso della forma alternativa.

--]]
f.getlink = function(poke, black, extform)
    black = black and 'black' or ''
    poke, extform = f.getnameabbr(poke, extform)
    if extform == '' or extform == 'base' then
        return ''
    end
    return alt[poke] and alt[poke][black .. 'links'][extform] or ''
end

f.getLink, f.get_link = f.getlink, f.getlink

--[[

Dato il nome di un Pokémon con forma alternativa,
ne determina il numero di dex nazionale senza passare
per il modulo Poké/data. Ritorna 0 in caso di errore.

--]]
f.getNdexForm = function(poke)
    poke = string.lower(poke or '')
    if not alt[poke] then
        return 0
    end
    for k, tab in pairs(alt) do
        if type(k) == 'number' and tab == alt[poke] then
            return k
        end
    end
end

f.getndexform, f.get_ndex_form = f.getNdexForm, f.getNdexForm

-- Converte la sigla vuota in 'base'
f.toBase = function(abbr)
    return abbr == '' and 'base' or abbr
end

f.tobase, f.to_base = f.toBase, f.toBase

-- Converte la sigla 'base' nella sigla vuota
f.toEmptyAbbr = function(abbr)
    return abbr == 'base' and '' or abbr
end

f.toemptyabbr, f.to_empty_abbr = f.toEmptyAbbr, f.toEmptyAbbr

--[[

Ritorna un valore convertibile a true se
il Pokémon passato, solo come nome, ha una
megaevoluzione o archeorisveglio, uno equiparabile
a false altrimenti

--]]
f.hasMega = function(poke)
    poke = string.lower(poke or '')
    if alt.mega then
        return table.search(alt.mega, poke)
            or table.search(alt.megaxy, poke)
            or table.search(alt.archeo, poke)
    end
    return false
end

f.has_mega, f.hasmega = f.hasMega, f.hasMega

--[[

Ritorna un valore convertibile a true se il
Pokémon passato, solo come nome, ha una forma
di alola, uno equiparabile a false altrimenti.

--]]
f.hasAlola = function(poke)
    poke = string.lower(poke or '')
    if alt.alola then
        return table.search(alt.alola, poke)
    end
    return false
end

f.has_alola, f.hasalola = f.hasAlola, f.hasAlola

--[[

Returns the first and last game a form is
available.

--]]
f.formSpan = function(poke, abbr)
    return alt[poke].since[abbr],
           alt[poke]['until']
           and alt[poke]['until'][abbr]
           or genUtil.latest.game
end

f.formspan, f.form_span = f.formSpan, f.formSpan

--[[

Parse an argument that should be a Pokémon name or ndex followed by a form
abbreviation so that it can be used to index a data module.
If name is a Pokémon name (not an ndex) it should be lowercase but the first
letter, that can be both upper or lower case.

--]]
f.nameToDataindex = function(name)
    local trueName, extform = f.getnameabbr(string.fl(string.trim(name)))
    -- If the Pokémon isn't in altForms/data, should return the plain name
    -- The return when extform == 'base' settles problems with number and concat
    if extform == 'base' or not alt[tonumber(trueName) or trueName] then
        return trueName
    end
    trueName = type(trueName) == 'number' and string.tf(trueName) or trueName
    return trueName .. f.toEmptyAbbr(extform)
end

return f
