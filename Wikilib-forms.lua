--[[

Funzioni di libreria per la gestione
delle forme alternative

--]]

local mw = require('mw')

local f = {}
local tab = require('Wikilib-tables')
local alt = require("AltForms-data")

--[[

Unisce le tabelle AltForms/data e UselessForms/data
gestendo anche la presenza di Pokémon in entrambi.
Restituisce la tabella così creata

--]]
f.allFormsData = function()
	local all = mw.clone(alt)
	local useless = require("UselessForms-data")

	-- No need for ipairs because integer keys
	-- are used only to index Pokémon by ndex
	for k, v in pairs(useless) do
		if all[k] then
			-- This Pokémon is in both useless and altForms
			-- Right now only Pikachu
			all[k].names = table.merge(all[k].names, v.names)
			all[k].ext = table.merge(all[k].ext, v.ext)
			all[k].since = table.merge(all[k].since, v.since)
			all[k].links = table.merge(all[k].links, v.links)
			all[k].blacklinks = table.merge(all[k].blacklinks, v.blacklinks)
			-- gamesOrder is a problem
			-- right now, with Pikachu, it is possible to
			-- simply concatenate the two tables and remove
			-- the second 'base'
			all[k].gamesOrder = table.noDuplicates(table.merge(all[k].gamesOrder, v.gamesOrder))
		else
			all[k] = v
		end
	end

	return all
end

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
	poke, abbr = name:match("^([%lé%-♂♀%s%.&#;%d]+)(%u*%a*)$")
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

	--[[
		È stato fornito il terzo parametro,
		si cerca nella table ext. Il '' a
		default in abbr serve per assicurare
		l'indicizzazione nell'istruzione successiva
	--]]
	if alt[tonumber(poke) or poke:lower()] then
		extform = string.lower(extform or '')
		poke = tonumber(poke) or poke:lower()
		abbr = alt[poke].ext[extform] or ''
		return alt[poke][black .. 'links'][abbr] or ''
	end

	--[[
		Senza terzo parametro, bisogna estrarre
		nome del Pokémon e sigla della forma
		alternativa dal nome, per poi usarli come
		indici del modulo AltForms/data
	--]]
	local name, form = poke:match("^([%lé%-♂♀%s%.&#;%d]+)(%u*%a*)$")
	if form == '' then
		return ''
	end
	name = tonumber(name) or name
	return alt[name][black .. 'links'][form] or ''
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

f.getndexform, f.get_ndex_form = f.getNdexForm, f.getNdexForm, f.getNdexForm

-- Converte la sigla vuota in 'base'
f.toBase = function(abbr)
	return abbr == '' and 'base' or abbr
end

f.to_base = f.toBase

-- Converte la sigla 'base' nella sigla vuota
f.toEmptyAbbr = function(abbr)
	return abbr == 'base' and '' or abbr
end

f.to_empty_abbr, f.toEmpty, f.to_empty =
f.toEmptyAbbr, f.toEmptyAbbr, f.toEmptyAbbr

--[[

Ritorna un valore convertibile a true se
il Pokémon passato, solo come nome, ha una
megaevoluzione o archeorisveglio, uno equiparabile
a false altrimenti

--]]
f.hasMega = function(poke)
	poke = string.lower(poke or '')
	if alt.mega then
		return table.search(alt.mega, poke) or table.search(alt.megaxy, poke)
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

return f
