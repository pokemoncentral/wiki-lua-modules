--[[

In questa libreria si hanno funzioni relative
all'IO con MediaWiki: per esempio, le più comuni
processazioni dei parametri in input e i pattern
tipici per la creazione dell'output

--]]

local w = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')

-- Rimuove gli spazi vuoti all'inizio e alla fine di una stringa
w.trim = string.trim

--[[

Rende possibile la string interpolation in stile Python
es.: interp("${name} is ${value}", {name = "foo", value = "bar"}
vedi: http://lua-users.org/wiki/StringInterpolation

--]]
w.interp = string.interp

--[[

Ritorna una nuova table in cui tutte le stringhe vuote
o contenenti solo spazi sono sostituite da nil, e gli
altri valori sono eventualmente processati da una
funzione che prende in ingresso valore e chiave.

Ciò è utile poiché suddette stringhe valutano a true,
rendendo più verbosa la necessaria sostituzione con
valori default: infatti MediaWiki le usa per i parametri
posizionali e nominali vuoti. Es:
	{{#invoke: myModule | myFunction | aa || name= }}
	ha frame.args == {[1] = ' aa ', [2] = '', name = ''}

Bisogna tuttavia stare attenti quando si usano funzioni
che operano sui soli indici interi, come table.concat,
ipairs o l'operatore #: queste considerano come ultimo
indice quello precedente ad un valore nil, creado problemi
in presenza i buchi, cosa che questa funzione tende a
fare. Un esempio può essere:
	#{'aa', 'bb', nil, 'dd'} == 3

Se ne consiglia dunque l'uso solo in casi in cui si faccia
esclusivamente accesso diretto ai parametri. 

--]]
w.emptyStringToNil = function(tab, funct)
	if funct then
		return table.map(tab, function(value, key)
			if tostring(value):find('%S') then
				return funct(value, key)
			end
			-- Nessun ritorno esplicito, quindi nil
		end)
	end
	return table.map(tab, function(value)
			if tostring(value):find('%S') then
				return value
			end
			-- Nessun ritorno esplicito, quindi nil
		end)
end

w.empty_string_to_nil = w.emptyStringToNil

--[[

Effettua il trim di tutti gli elementi di una table.
Il secondo parametro (default true) attiva il mapping
delle stringhe vuote o di soli spazi in nil.

--]]
w.trimAll = function(tab, emptyStringToNil)
	if emptyStringToNil == nil or emptyStringToNil then
		return w.emptyStringToNil(tab, string.trim)
	end
    return table.map(tab, string.trim)
end

w.trim_all = w.trimAll

--[[

Effettua il mapping di una table con una funzione
data a cui vengono passati gli elementi dopo il trim.
Il terzo parametro (default true) attiva il mapping
delle stringhe vuote o di soli spazi in nil.
Secondo e terzo parametro possono essere scambiati,
per maggior leggibilità in caso di chiamata con
funzione definita on-the-fly.

--]]
w.trimAndMap = function(tab, funct, emptyStringToNil)
	if type(funct) == 'boolean' then
		funct, emptyStringToNil = emptyStringToNil, funct
	end
	local callback = function(s, key)
		return funct(string.trim(s), key)
	end
	if emptyStringToNil == nil or emptyStringToNil then
		return w.emptyStringToNil(tab, callback)
	end
    return table.map(tab, callback)
end

w.trim_and_map = w.trimAndMap

--[[

Effettua il mapping di una tabella con la funzione
data, per poi concatenarla usando un eventuale
separatore.
Funzione e separatore possono essere scambiati,
per maggior leggibilità in caso di chiamata con
funzinoe definita on-the-fly.

--]]
w.mapAndConcat = function(tab, sep, funct)
	if type(sep) == 'function' then
		sep, funct = funct, sep
	end
	return table.concat(table.map(tab, funct, ipairs), sep)
end

w.map_and_concat = w.mapAndConcat

return w
