-- Modulo per il Template Spr

local s = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local w = require('Wikilib')
local gens = require('Wikilib-gens')
local wdata = require('Wikilib-data')

local mw = require('mw')

--[[

Table che mantiene le associazioni tra il secondo parametro in lowercase e le
sigle dei giochi negli sprite

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
	['sole e luna'] = 'sl',
	['ultrasole e ultraluna'] = 'usul',
    ["let's go pikachu e let's go eevee"] = 'lgpe',
	['spada e scudo'] = 'spsc',
	colosseum = 'colo',
	-- XD is not necessary
	stadium = 'stad',
	['stadium 2'] = 'stad2'
}

-- Alias per la table di cui sopra
table.tableKeysAlias(gamesAbbr,
	{'verde', 'rosso e blu', 'oro', 'cristallo', 'rubino e zaffiro',
        'rosso fuoco e verde foglia', 'smeraldo', 'diamante e perla',
        'heartgold e soulsilver', 'nero e bianco', 'nero 2 e bianco 2',
        'x e y', 'rubino omega e zaffiro alpha', 'sole e luna',
        'ultrasole e ultraluna', "let's go pikachu e let's go eevee",
		'spada e scudo', 'stadium 2'},
	{{'rosso e verde', 'rv', 'v'}, {'rosso', 'blu', 'r', 'b'},
    {'oro e argento', 'oa'}, {'c'}, {'rubino', 'zaffiro', 'ru', 'za', 'z'},
	{'rosso fuoco', 'verde foglia', 'rf', 'vf'}, {'s'},
	{'diamante', 'perla', 'd', 'p'},
    {'oro heartgold e argento soulsilver', 'heartgold', 'oro heartgold',
        'soulsilver', 'argento soulsilver', 'hg', 'ss'},
	{'nero', 'bianco', 'n', 'bi'}, {'nero 2', 'bianco 2', 'n2', 'b2', 'n2b2'},
	{'x', 'y', 'xy'}, {'rubino omega', 'zaffiro alpha', 'ro', 'za'},
	{'sole', 'luna', 'so', 'l'}, {'ultrasole', 'ultraluna', 'us', 'ul'},
    {"let's go", "let's go pikachu", "let's go eevee",
        "let's go pikachu e eevee", 'pikachu', 'eevee', 'pikachu e eevee',
        'lgpe', 'pe'},
	{'spada', 'scudo', 'sp', 'sc'},
	{'stad 2'}})

--[[

Table per convertire dalle sigle usate negli sprite a quelle usate nella
funzione getGen.games del modulo Wikilib/gens

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

Table usata per ordinare le parole che compongono la variante dello sprite.
L'ordine relativo di 'male' e 'female' è irrilevante, poiché non possono
coesistere.

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
local gifs = {'cr', 'sme', 'nb', 'nb2', 'xy', 'roza', 'sl', 'usul', 'lgpe', 'spsc'}

-- Table per le dimensioni degli sprite
local sizes = {
	stad = '|120px',
	stad2 = '|120px',
	xy = '|150px',
	roza = '|150px',
	sl = '|150px',
	usul = '|150px',
	lgpe = '|150px',
	spsc = '|150px',
}

-- Table per le stringhe da interpolare a seconda del gioco
local interpStrings = {
	current = '[[File:${ndex}.png${size}]]',
	md = '[[File:MDP${ndex}.png]]',
	rb = '[[File:Spr${game}${variant}${ndex}.${ext}${size}]]',
}

-- Alias per la table di cui sopra
table.tableKeysAlias(interpStrings,
	{'rb'},
	{{'verde', 'gia', 'or', 'ar', 'oa', 'cr', 'oac', 'rz', 'rfvf', 'sme', 'dp',
        'pt', 'hgss', 'nb', 'nb2', 'xy', 'roza', 'sl', 'usul', 'lgpe', 'spsc',
		'colo', 'xd', 'stad', 'stad2'}})

--[[

Ritorna gif se il gioco è presente nella table gifs, con l'unica eccezione
degli sprite shiny e restrostanti di smeraldo che sono in png. Negli altri
casi png.

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

La variante è obbligatoria per i giochi dalla quarta generazione in poi,
mentre la dimensione è sempre opzionale.

La variante può contenere le parole 'female', 'male', 'back' e 'shiny' in
qualsiasi ordine e in qualsiasi numero, con la sola restrizione che 'male' e
'female' non possono coesistere.

--]]
s.sprLua = function(ndex, game, variant, size)
	game = string.lower(game or 'current')

	variant = string.trim(variant or ''):lower()

	game = gamesAbbr[game] or game
	local gen = gens.getGen.game(gamesAbbrGen[game] or game)

	--[[
		I giochi di seconda generazione hanno 'oac' come gioco negli sprite
        posteriori.
	--]]
	if gen and gen == 2 and variant:find('back') then
		game = 'oac'
	end

	variant = table.unique(mw.text.split(variant, '%s+'))
	table.sort(variant, function(a, b)
			return table.search(variantPiecesOrder, a)
					< table.search(variantPiecesOrder, b)
		end)

	--[[
	Prima della quarta generazione non c'erano differenze di genere negli
	sprite.

	NB: la stringa 'male' è trovata sia in 'male' che in 'female'.
	--]]
	if gen and gen < 4 and variant[1]:find('male') then
		-- Elimina il genere dalla variante
		table.remove(variant, 1)
	end
	-- If the Pokémon is female only and the gen recent enough, add female
	if gen and gen > 4
	   and table.search(wdata.onlyFemales, tonumber(ndex))
	   and variant[1] == 'male' then
		variant[1] = 'female'
	end

	variant = table.concat(variant, ' ')

	return w.interp(interpStrings[game],
	{
		game = game,
		variant = variants[variant] or '',
		ndex = ndex or '001',
		ext = getExtension(game, variant),
		size = size and '|' .. size or sizes[game] or ''
	})
end

s.spr_lua = s.sprLua

--[[

Link agli sprite, chiamata da Wikicode (adapter per lua)

- Primo argomento: numero di dex nazionale, con eventuale sigla della forma
    alternativa
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
