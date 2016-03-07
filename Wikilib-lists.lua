-- Funzioni di utilità per i moduli che generano elenchi

local list = {}
local tab = require('Wikilib-tables')
local alt = require('AltForms-data')
local other = require('UselessForms-data')
local females = require('Wikilib-data').onlyFemales

--[[

Funzioni per l'ordinamento (secondo argomento di
table.sort()).

Controllano dapprima se i due argomenti sono diversi,
poiché, inspiegabilmente, nel sorting lua compara
l'ultimo elemento con se stesso, e ciò può generare
errori

--]]

--[[

Ritorna i valori default per list.sortNdex e
list.sortForms

Per il primo argomento, lo lascia inalterato
se è già una funzione, altrimenti ne costruisce
una supponendo che sia un pattern.

Il secondo argomento ha semplicemente come
valore default list.alphaOrder

--]]

local sortDefaults = function(getInfo, compareForms)
	compareForms = compareForms or list.alphaOrder
	if type(getInfo) ~= 'function' then
		return function(str) return str:match(getInfo) end, compareForms
	end
	return getInfo, compareForms
end

--[[

La seguente funzione ritorna una funzione per
l'ordinamento in base al numero di dex nazionale.

Il primo argomento indica come prelevare il numero
di dex e eventualmente la forma: può essere una
funzione od un pattern

Il secondo argomento indica come ordinare le forme
in caso di ndex uguale, e deve essere una funzione

--]]

list.sortNdex = function(getInfo, compareForms)
	getInfo, compareForms = sortDefaults(getInfo, compareForms)
	return function(a, b)
		if a == b then
			return false
		end
		local na, sa = getInfo(a)
		local nb, sb = getInfo(b)
		if a ~= b and na == nb then
			return compareForms(sa, sb, na)
		else
			return na < nb
		end
	end
end

list.sort_ndex = list.sortNdex

--[[

Valori predefiniti per il primo argomento di
list.sortNdex (per prelevare ndex e forma)

--]]

-- Estrae ndex e forma da un mini sprite animato

list.ndexAniMS = 'Ani(%d+)(%a*)MS%d?%.gif'

list.ndexanims, list.ndex_ani_ms = list.ndexAniMS, list.ndexAniMS

-- Estrae ndex e forma da un mini sprite statico

list.ndexStaticMS = '(%d+)(%a*)MS%d?%.png'

list.ndexstaticms, list.ndex_static_ms = list.ndexStaticMS, list.ndexStaticMS

--[[

Estrae ndex e sigla da uno sprite; non basta
un pattern perché gli sprite femmina, a differenza dei mini
sprite, non hanno la sigla F in fondo

--]]

list.ndexSprite = function(str)
	local sex, ndex, form = str:match('Spr[%l2]-([fm]?)(%d+)(%a*)%.')
	if form == '' and sex == 'f' and
		not table.search(females, tonumber(ndex)) then
		form = 'F'
	end
	return ndex, form
end

list.ndex_sprite, list.ndexsprite = list.ndexSprite, list.ndexSprite

--[[

Funzioni predefinte per il secondo argomento di
list.sortNdex e list.sortForms
(per ordinare le forme con lo stesso ndex)

--]]

-- Ordine alfabetico

list.alphaOrder = function(sa, sb)
	return string.lower(sa or 'a') < string.lower(sb or 'a')
end

list.alpha_order, list.alphaorder = list.alphaOrder, list.alphaOrder

-- Ordine dei giochi

list.gamesOrder = function(sa, sb, poke)
	poke = tonumber(poke) or poke:lower()
	if not alt[poke] then
		alt, other = other, alt
	end
	return table.search(alt[poke].gamesOrder, sa) <
		table.search(alt[poke].gamesOrder, sb)
end

list.games_order, list.gamesorder = list.gamesOrder, list.gamesOrder

--[[

La seguente funzione ritorna una funzione per
l'ordinamento in base alla sigla della forma
alternativa.

Il primo argomento indica come prelevare la
sigla della forma: può essere una funzione od
un pattern

Il secondo argomento indica come ordinare le
forme, e deve essere una funzione

Il terzo argomento specifica il Pokémon di
cui si ordinano le forme: può essere sia il
numero di dex nazionale che il nome

--]]

list.sortForms = function(getInfo, compareForms, poke)
	local ndex = tonumber(poke)
	if ndex then
		poke = ndex
	elseif poke:find('^%D') then
		poke = poke:lower()
	end
	getInfo, compareForms = sortDefaults(getInfo, compareForms)
	return function(a, b)
		if a == b then
			return false
		end
		local sa = getInfo(a) or ''
		local sb = getInfo(b) or ''
		return compareForms(sa, sb, poke)
	end
end

--[[

Valori predefiniti per il primo argomento di
list.sortForms (per prelevare la sigla forma)

--]]

-- Estrae la sigla da un mini sprite animato

list.formAniMS = 'Ani%d+(%a*)MS%d?%.gif'

list.formanims, list.form_ani_ms = list.formAniMS, list.formAniMS

-- Estrae la sigla da un mini sprite statico

list.formStaticMS = '%d+(%a*)MS%d?%.png'

list.formstaticms, list.form_static_ms = list.formStaticMS, list.formStaticMS

--[[

Estrae la sigla da uno sprite; non basta un pattern
perché gli sprite femmina, a differenza dei mini
sprite, non hanno la sigla F in fondo

--]]

list.formSprite = function(str)
	local sex, ndex, form = str:match('Spr[%l2]-([fm]?)(%d+)(%a*)%.')
	if form == '' and sex == 'f' and
		not table.search(females, tonumber(ndex)) then
		return 'F'
	end
	return form
end

list.formsprite, list.form_sprite = list.formSprite, list.formSprite

-- Altre funzioni di utilità

--[[

Funzione per filtrare i Pokémon negli elenchi,
cosicché non appaiano più volte: ritorna true
solo se l'argomento è una stringa e non inizia
con un numero

--]]

list.isName = function(key)
	return type(key) == 'string' and (key:find('^%D'))
end

list.is_name, list.isname = list.isName, list.isName

return list
