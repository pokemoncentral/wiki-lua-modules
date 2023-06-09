--[[

Funzioni di libreria per la gestione
delle forme alternative

--]]

local f = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local genUtil = require('Wikilib-gens')
local alt = require("AltForms-data")
-- stylua: ignore end

-- Boolean used to avoid double loading of useless forms
local allFormsLoaded = false

--[[

Unisce le tabelle AltForms/data e UselessForms/data
gestendo anche la presenza di Pokémon in entrambi.
Restituisce la tabella così creata

--]]
f.allFormsData = function()
    -- Avoid a second loading of all forms
    if allFormsLoaded then
        return alt
    end

    local all = tab.copy(alt)
    local useless = require("UselessForms-data")
    local both = require("BothForms-data")

    --[[
        No need for ipairs because integer keys
        are used only to index Pokémon by ndex
    --]]
    for k, v in pairs(useless) do
        if all[k] then
            -- This Pokémon is in both useless and altForms, thus it is
            -- granted to be also in bothForms
            all[k] = both[k]
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
        allFormsLoaded = true
    else
        alt = require("UselessForms-data")
    end
end

f.loaduseless, f.load_useless = f.loadUseless, f.loadUseless

--[[

Estrae la sigla della forma alternativa dal nome del Pokémon così come è negli
indici delle tabelle dati o negli ndex dei Mini Sprite, oppure a partire dal
nome del Pokémon e quello esteso della forma alternativa. In caso di
fallimento, ritorna la stringa vuota.

--]]
---@deprecated use getnameabbr or getndexabbr instead
f.getabbr = function(name, extform)
    if alt[tonumber(name) or name:lower()] then
        extform = string.lower(extform or "")
        name = tonumber(name) or name:lower()
        return alt[name].ext[extform] or "base"
    end
    return name:match("(%u+%a*)$") or "base"
end

--[[

Estrae nome e sigla della forma alternativa
dal nome del Pokémon così come è negli indici
delle tabelle dati o negli ndex dei Mini Sprite.
In caso di fallimento, ritorna la stringa vuota.

--]]
---@deprecated use getndexabbr instead
f.getnameabbr = function(name, extform)
    if alt[tonumber(name) or name:lower()] then
        extform = string.lower(extform or "")
        name = tonumber(name) or name:lower()
        return name, alt[name].ext[extform] or "base"
    end
    local poke, abbr = name:match("^([%lé%-♂♀'%s%.&#;%d]+)(%u*%a*)$")
    return tonumber(poke) or poke or "", abbr or "base"
end
---@deprecated use getndexabbr instead
f.getNameAbbr = f.getnameabbr

--[[

Given a Pokémon ndex, possibly followed by a form abbr, split the ndex itself
from the abbr. If given a Pokémon name instead of an ndex, the function returns
it as is. The second parameter is an optional abbr, which is used when no abbr
is found in name.

The name behaviour is needed because in general it not possible to separate the
name from the abbr. If there is some extra assumption (eg. the name is all
lowercase), it's the caller's resposibility to exploit it.

--]]
---@param name string An ndex+abbr or Pokémon name
---@param abbr string? An optional abbr, to be used when name doesn't contain any
---@return number|string, string
f.getndexabbr = function(name, abbr)
    -- name is just an ndex
    local ndex = string.match(name, "^(%d+)$")
    if ndex then
        return tonumber(ndex), abbr or "base" ---@diagnostic disable-line: return-type-mismatch
    end
    -- name is an ndex followed by an abbr
    local ndex, abbr_ = string.match(name, "^(%d+)(%u%a*)$")
    if ndex then
        return tonumber(ndex), abbr_ ---@diagnostic disable-line: return-type-mismatch
    end
    -- name is not an ndex: it's assumed to be a Pokémon name. In this case,
    -- there is no abbr in the name, so it's returned unmodified
    return name, abbr or "base"
end

--[[

Given a Pokémon name or ndex, return the link to the alternative form. The
second parameter specify the kind of link, and can either be "black", "plain"
or "" (default to ""). The optional third parameter is the abbr of the
alternative form.

--]]
f.getlink = function(poke, black, abbr)
    black = black or ""
    poke, abbr = f.getndexabbr(poke, abbr)
    return alt[poke] and alt[poke][black .. "links"][abbr] or ""
end
f.getLink = f.getlink

--[[

Dato il nome di un Pokémon con forma alternativa,
ne determina il numero di dex nazionale senza passare
per il modulo Poké/data. Ritorna 0 in caso di errore.

--]]
f.getNdexForm = function(poke)
    if type(poke) == "number" then
        return poke
    end

    poke = string.lower(poke)
    if not alt[poke] then
        return 0
    end
    for k, tab in pairs(alt) do
        if type(k) == "number" and tab == alt[poke] then
            return k
        end
    end
end

f.getndexform, f.get_ndex_form = f.getNdexForm, f.getNdexForm

-- Converte la sigla vuota in 'base'
f.toBase = function(abbr)
    return abbr == "" and "base" or abbr
end

f.tobase, f.to_base = f.toBase, f.toBase

-- Converte la sigla 'base' nella sigla vuota
f.toEmptyAbbr = function(abbr)
    return abbr == "base" and "" or abbr
end

f.toemptyabbr, f.to_empty_abbr = f.toEmptyAbbr, f.toEmptyAbbr

--[[

Ritorna un valore convertibile a true se
il Pokémon passato, solo come nome, ha una
megaevoluzione o archeorisveglio, uno equiparabile
a false altrimenti

--]]
f.hasMega = function(poke)
    poke = string.lower(poke or "")
    if alt.mega then
        return tab.search(alt.mega, poke)
            or tab.search(alt.megaxy, poke)
            or tab.search(alt.archeo, poke)
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
    poke = string.lower(poke or "")
    if alt.alola then
        return tab.search(alt.alola, poke)
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
        alt[poke]["until"] and alt[poke]["until"][abbr] or genUtil.latest.game
end

f.formspan, f.form_span = f.formSpan, f.formSpan

--[[

Parse an argument that should be a Pokémon name or ndex, the latter possibly
followed by a form abbr, so that it can be used to index a data module. The
second argument "abbr" is optional and specify the form.

If name is a Pokémon name it can't be followed by the abbr. If name already
contains an abbr (eg. ndex + abbr) the second argument is ignored.

This function makes name lowercase, and removes the form abbr if it is useless.

--]]
---@param abbr string?
f.nameToDataindex = function(name, abbr)
    name = txt.trim(tostring(name))
    local namePlain, abbr = f.getndexabbr(name, abbr)
    -- Make lowercase for indexing
    namePlain = type(namePlain) == "string" and namePlain:lower() or namePlain
    -- The local variable is needed because global alt can be changed with
    -- loadUseless
    local trueAlt = require("AltForms-data")
    -- If the Pokémon isn't in AltForms/data, should return the plain name. The
    -- second check is for Pokémon with both forms
    if not (trueAlt[namePlain] and trueAlt[namePlain].names[abbr]) then
        return namePlain
    end
    if abbr ~= "base" then
        local nameTxt = type(namePlain) == "number" and txt.ff(namePlain)
            or namePlain
        return nameTxt .. abbr
    else
        return namePlain
    end
end

--[[

Less than confront for form abbr of a Pokémon. The parameters are the Pokémon's
AltForms-data and the two form abbr.

--]]
f.abbrLT = function(formsData, abbr1, abbr2)
    return tab.search(formsData.gamesOrder, abbr1)
        < tab.search(formsData.gamesOrder, abbr2)
end

--[[

This function returns the sorting key of Pokémon names, taking care of
alternative forms. The returned value is meant to be used as data-sort-value
in sortable tables.

The sorting key should be just the Pokémon name when it has no forms, or no
displayed link. Otherwise, the name should be used first, followed by the
form name.

Arguments:
    - ndex: The ndex or the name of the base form Pokémon.
    - abbr: The form abbreviation name.
    - poke: The name of the Pokémon.

--]]
f.formSortValue = function(ndex, abbr, poke)
    ndex = f.getNdexForm(type(ndex) == "string" and ndex:lower() or ndex)
    local data, value, name = alt[ndex], "${name}", poke
    local formName

    if data and data.links[abbr] ~= "" then
        formName = data.names[abbr]
        value = "${name}, ${form}"
    end

    return txt.interp(value, {
        name = name,
        form = formName,
    })
end

--[[

Given the name or ndex of an useless form maps it to the base form's name or
ndex. On other names and ndexes is the identity.

--]]
f.uselessToEmpty = function(name)
    local useless = require("UselessForms-data")
    local basename, abbr = f.getnameabbr(name)
    if useless[basename] and useless[basename].names[abbr] then
        return basename
    end
    return name
end

return f
