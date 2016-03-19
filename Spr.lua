-- Modulo per il Template Spr

local s = {}

local mw = require('mw')

local tab = require('Wikilib-tables')
local w = require('Wikilib')
local gens = require('Wikilib-gens')

--[[

Table che mantiene le associazioni tra il
secondo parametro in lowercase e le sigle
dei giochi negli sprite

--]]
local gamesAbbr = {
	verde = 'verde',
	['rosso e blu'] = 'rb',
	giallo = 'gia',
	oro = 'or',
	argento = 'ar',
	cristallo = 'cr',
	['rubino e zaffiro'] = 'rz',
	['rosso fuoco e verde foglia'] = 'rfvf',
	smeraldo = 'sme',
	['diamante e perla'] = 'dp',
	platino = 'pt',
	['heartgold e soulsilver'] = 'hgss',
	['nero e bianco'] = 'nb',
	['nero 2 e bianco 2'] = 'nb2',
	['x e y'] = 'xy',
	['rubino omega e zaffiro alpha'] = 'roza',
	colosseum = 'colo',
	-- XD is not necessary
	stadium = 'stad',
	['stadium 2'] = 'stad2'
}

-- Alias per la table di cui sopra
table.tableKeysAlias(gamesAbbr,
	{'verde', 'rosso e blu', 'oro', 'cristallo',
		'rubino e zaffiro', 'rosso fuoco e verde foglia',
		'smeraldo', 'diamante e perla',
		'heartgold e soulsilver', 'nero e bianco',
		'nero 2 e bianco 2', 'x e y',
		'rubino omega e zaffiro alpha', 'stadium 2'},
	{{'rosso e verde', 'rv', 'v'}, {'rosso', 'blu', 'r', 'b'},
	{'oro e argento', 'oa'}, {'c'}, {'rubino', 'zaffiro', 'ru',
		'za', 'z'},
	{'rosso fuoco', 'verde foglia', 'rf', 'vf'}, {'s'},
	{'diamante', 'perla', 'd', 'p'}, {'oro heartgold e argento soulsilver',
		'heartgold', 'oro heartgold', 'soulsilver', 'argento soulsilver',
		'hg', 'ss'},
	{'nero', 'bianco', 'n', 'bi'}, {'nero 2', 'bianco 2',
		'n2', 'b2', 'n2b2'},
	{'x', 'y', 'xy'}, {'rubino omega', 'zaffiro alpha', 'ro', 'za'},
	{'stad 2'}})

--[[

Table per convertire dalle sigle usate
negli sprite a quelle usate nella funzione
getGen.games del modulo Wikilib/gens

--]]
local gamesAbbrGen = {
	verde = 'rb',
	gia = 'g',
	stad = 'st',
	ar = 'oa',
	cr = 'c',
	stad2 = 'st2',
	sme = 's',
	nb2 = 'n2b2'
}

gamesAbbrGen['or'] = gamesAbbrGen.ar

--[[

Table usata per ordinare le parole che
compongono la variante dello sprite.
L'ordine relativo di 'male' e 'female'
è irrilevante, poiché non possono coesistere.

--]]
local variantPiecesOrder = {'female', 'male', 'back', 'shiny'}

-- Sigle per le varianti sesso/shiny/dietro degli sprite
local variants = {
	male = 'm',
	female = 'f',
	shiny = 'sh',
	back = 'd',
	['male shiny'] = 'msh',
	['female shiny'] = 'fsh',
	['back shiny'] = 'dsh',
	['male back'] = 'md',
	['female back'] = 'fd',
	['male back shiny'] = 'mdsh',
	['female back shiny'] = 'fdsh'
}

-- Table per i giochi che hanno gli sprite in .gif
local gifs = {'cr', 'sme', 'xy', 'roza'}

-- Table per le dimensioni degli sprite
local sizes = {
	stad = '|120px',
	stad2 = '|120px',
	xy = '|192px',
	roza = '|192px'
}

--[[

Ritorna gif se il gioco è presente nella table
gifs, con l'unica eccezione degli sprite shiny
e restrostanti di smeraldo che sono in png.
Negli altri casi png.

--]]
local getExtension = function(game, variant)
	if game == 'sme' and variant:find('[dsh]')
			or not table.search(gifs, game) then
		return 'png'
	end
	return 'gif'
end

--[[

Link agli sprite, chiamata da lua.

La variante è obbligatoria per i giochi dalla
quarta generazione in poi, mentre la dimensione
è sempre opzionale.

La variante può contenere le parole 'female',
'male', 'back' e 'shiny' in qualsiasi ordine
e in qualsiasi numero, con la sola restrizione
che 'male' e 'female' non possono coesistere

--]]
s.sprLua = function(ndex, game, variant, size)
	game = string.lower(game or 'current')

	if game == 'current' then
		return table.concat{'[[File:', ndex, '.png]]'}
	end
	
	variant = string.lower(variant or '')

	game = gamesAbbr[game] or game
	local gen = gens.getGen.game(gamesAbbrGen[game] or game)
	--[[
		I giochi di seconda generazione hanno
		'oac' come gioco negli sprite posteriori
	--]]
	if gen == 2 and variant:find('back') then
		game = 'oac'
	end

	variant = table.unique(mw.text.split(variant, '%s+'))	
	table.sort(variant, function(a, b)
			return table.search(variantPiecesOrder, a)
					< table.search(variantPiecesOrder, b)
		end)
	variant = table.concat(variant, ' ')

	--[[
		Prima della quarta generazione non c'erano
		differenze di genere negli sprite.
		
		NB: la stringa 'male' è trovata sia in
		'male' che in 'female'
	--]]
	if gen < 4 and variant:find('male') then
		
		-- Elimina il genere dalla variante
		
		variant = variant:match('male%s+([%w%s]+)')
	end
	variant = variants[variant] or ''
		
	return w.interp('[[File:Spr${game}${variant}${ndex}.${ext}${size}]]',
	{
		game = game,
		variant = variant,
		ndex = ndex or '001',
		ext = getExtension(game, variant),
		size = size and '|' .. size or sizes[game] or ''
	})
end

s.spr_lua = s.sprLua

--[[

Link agli sprite, chiamata da Wikicode (adapter per lua)

- Primo argomento: numero di dex nazionale, con
	eventuale sigla della forma alternativa
- Secondo argomento: gioco
- Terzo argomento: variante (sesso, retro, shiny)
- Quarto argomento (opzionale): dimensione

Esempio: {{#invoke: Spr | spr | 479L | Platino | shiny back | 30px}}

--]]
s.spr = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	return s.sprLua(p[1], p[2], p[3], p[4])
end

s.Spr = s.spr

return s
