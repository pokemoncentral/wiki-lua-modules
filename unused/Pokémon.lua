--[[

Box per un singolo Pokémon, con sprite,
nickname, sesso, livello, tipi, abilità
strumento e mosse

--]]

local p = {}

local bag = require('Bag')
local bt = require('Box')
local txt = require('Wikilib-strings')      -- luacheck: no unused
local w = require('Wikilib')
local spr = require('Sprite')
local c = require("Colore-data")
local pokes = require("Poké-data")

local shinyStars = {[2] = 'GS', [3] = 'RS', [4] = 'DP',
		[5] = 'BW', [6] = 'XY'}

local getGender = function(name, gender)
	gender = mw.ustring.lower(gender)
	name = mw.ustring.lower(name)

	if gender == 'none' or
			mw.ustring.sub(1, -2) == 'nidoran' then
		return ''
	end
	return gender == 'both' and table.concat{data.gender.male, '/',
			data.gender.female} or data.gender[gender]
end

local makeTypeBox = function(type, roundyVariant)
	return bt.boxTipoLua(type, nil, roundyVariant .. ' inline-block', 'padding: 3px 10px;')
end

local makeAbilitiesBox = function(abil1, abil2)
	return string.interp([=[<div class="small-font" style="margin-top: 3px; margin-bottom: -3px;">Abilit&agrave;:</div><div>${abil1}${abil2}]=],
	{
		abil1 = abil1:lower() == 'nessuna' and '[[Abilit&agrave;|Nessuna]]' or
				table.concat{'[[', abil1, ' (abilit&agrave;)|<span style="color: #000;">',
				string.fu(abil1), '</span>]]'},
		abil2 = abil2 and table.concat{'&nbsp;[[', abil2,
				' (abilit&agrave;)|<span style="color: #000;">', string.fu(abil2),
				'</span>]]'} or ''
	})
end

p['Pokémon'] = function(frame)
	local params = w.trimAll(frame.args)

	--No defaults for ndex and pokemon

	params.ndex = params.ndex or pokes[string.fl(params.pokemon)].ndex
	local poke = pokes[tonumber(params.ndex) or params.ndex]
	params.pokemon = params.pokemon or poke.name

	params.nickname = params.nickname or string.fu(params.pokemon)
	params.shiny = (params.shiny and params.shiny:lower()) == 'yes'
	params.spritegender = params.spritegender and params.spritegender ..
				((not params.spritegender:find('shiny') and params.shiny) and ' shiny' or '')
				or params.gender or 'male'

	params.game = params.game or 'current'
	params.gen = params.gen or 6
	params.gender = params.gender or 'none'
	params.level = params.level or '0'
	params.ability = params.ability or 'nessuna'

	local type1, type2 = poke.type1, poke.type2

	return string.interp([=[<div class="roundy text-center" style="padding: 3px; width: ${width}px; background: #{bg}; border: 3px solid #${bd};"><div class="grid" style="width: 100%;"><div class="grid-row"><div class="grid-cell align-middle" style="width: 50%;"><div class="roundy inline-block" style="padding: 5px; background: #FFF; border: 2px solid #${bd};">${spr}</div><div class="roundy" style="background: #FFF; margin-top: 5px; border: 2px solid #${bd};">${name}${gender}&nbsp;<span class="small-font">L.</span>${level}${shinyStar}</div></div><div class="grid-cell align-middle"><div class="small-font" style="margin-bottom: 1px;">Tip${typeEnd}:</div>${type1Box}${type2Box}${abilities}${item}</div></div></div><div class="grid" style="width: 100%; border-spacing: 5px;"><div class="grid-row">{{MoveBox|name={{{move1|none}}}|type={{{move1type|Sconosciuto}}}|cat={{{move1cat|Fisico}}}|gen={{{gen|6}}}}}{{MoveBox|name={{{move2|none}}}|type={{{move2type|Sconosciuto}}}|cat={{{move2cat|Fisico}}}|gen={{{gen|6}}}}}</div><div class="grid-row">{{MoveBox|name={{{move3|none}}}|type={{{move3type|Sconosciuto}}}|cat={{{move3cat|Fisico}}}|gen={{{gen|6}}}}}{{MoveBox|name={{{move4|none}}}|type={{{move4type|Sconosciuto}}}|cat={{{move4cat|Fisico}}}|gen={{{gen|6}}}}}</div></div></div>]=],
	{
		width = (params.game:lower() == 'current' or params.gen > 5) and '360' or '320',
		bg = c[type1].light,
		bd = c[type2][type1 == type2 and 'dark' or 'normale'],
		spr = spr.sprLua(params.ndex, params.game, params.spritegender),
		name = table.concat{'[[', params.pokemon, '|<span style="color: #000;">',
				params.nickname, '</span>]]'},
		gender = gen > 1 and getGender(params.pokemon, params.gender) or '',
		level = params.level,
		shinyStar = (gen > 1 and params.spritegender:find('shiny')) and
				table.concat{'[[File:Shiny', shinyStars[params.gen], 'Star.png]]'}) or '',
		typeEnd = type1 == type2 and 'o' or 'i',
		type1Box = makeTypeBox(type1, type1 == type2 and '' or 'left'),
		type2Box = type1 == type2 and '' or makeTypeBox(type2, 'right'),
		abilities = gen > 2 and makeAbilitiesBox(params.ability, params.ability2) or '',
		item = (gen > 1 and params.held) and table.concat{[=[<div class="small-font" style="margin-top: 2px; margin-bottom: -3px;">Strumento:</div><div>]=],
				item and bag.bag(item) or 'Nessuno', '</div>'} or '',







end

p.pokémon, p.Pokemon, p.pokemon = p.Pokémon, p.Pokémon, p.Pokémon

return p
