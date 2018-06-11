--[[

Modulo temporaneo che sostituisce il modulo squadra:
le chiamate al modulo attuale presentano codice non
compatibile con questo modulo che è stato reso mobile
friendly, pertanto si è reso necessario creare questa
pagina temporanea prima di riunire il tutto.

I parametri dovrebbero essere gli stessi del modulo squadra,
a loro volta gli stessi del template squadra, con
gli stessi nomi. Per quanto riguarda i colori invece,
possono essere inseriti sia valori esadecimali che
colori memorizzati sul wiki: in questo caso basta
inserire "parametro=nomecolore variante", es:
	{{#invoke: party | ... | color=erba dark}}
	{{#invoke: party | ... | headcolor2=elettro}}

--]]

local s = {}

local mw = require('mw')

local w = require('Wikilib')
local wdata = require("Wikilib-data")
local lib = require('Wikilib-squadra')
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused
local gbl = require('GamesColorLinks')
local css = require('Css')

-- Stringa per la trainerclass, non sempre presente
local classString = [=[<div style="line-height: 10px" class="text-small">'''[[${classlink}|<span style="color:#000">${class}</span>]]'''</div>]=]

--[[

Modulo squadra intero: sostituisce entrambe le
altre due funzioni. Per renderlo uguale a tag
aggiungere il parametro tag=yes

--]]

--[===[

Dato che non funziona, viene commentata in blocco

s.squadra = function(frame)
	local p = w.trimAll(mw.clone(frame.args))

	-- La table poke contiene i dati dei Pokémon
	local poke = {p.pokemon1}
	for a = 2, p.pokemon do
		table.insert(poke, p['pokemon' .. a])
	end

	-- Colori in esadecimale, con valori di default dapprima "sconosciuto" e poi quelli calcolati prima

	local colors = lib.gethex{color = p.color or c.sconosciuto.normale, bordercolor = p.bordercolor or c.sconosciuto.dark,
		headcolor = p.headcolor or c.sconosciuto.light}
	local colors = lib.gethex({headcolor1 = p.headcolor1 or colors.headcolor, headcolor2 = p.headcolor2 or colors.headcolor,
		bordercolor1 = p.bordercolor1 or colors.bordercolor, bordercolor2 = p.bordercolor2 or colors.bordercolor,
		color1 = p.color1 or colors.color, color2 = p.color2 or colors.color}, colors)

	-- Stringhe non sempre presenti
	local extra = {
		class = [=[<div class="small-text" style="line-height:10px;">'''[[${class} (classe allenatore)|<span style="color:#000">${class}</span>]]'''</div>]=],

		secondtrainer = [=[<div>''e''</div>
<div>
<div class="small-text" style="line-height:10px;">'''[[${class2} (classe allenatore)|<span style="color:#000">${class2}</span>]]'''</div><div class="big-text">'''${name2}'''</div>
</div>]=],

		secondsprite = [=[<div style="padding: 0.3ex; height: 11ex; width: 11ex; ${r80} background: linear-gradient(to right, #${color2}, #${bordercolor2});">[[File:${sprite2}]]</div>]=]
	}


	-- Interpolation
	return string.interp([=[{| class="mw-collapsible mw-collapsed text-center pull-left roundy" style="padding: 0.5ex; background: linear-gradient(to right, #${headcolor}, #${bordercolor});"
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-center" style="padding: 0 2.5em;">
<div>
<div style="padding: 0.3ex; ${r80} background: linear-gradient(to right, #${color}, #${headcolor});">[[File:${sprite}]]</div>
<div class="text-small" style="margin-top: 0.5ex; line-height: 10px">Ricompensa:</div>
<div>'''${prize}'''</div>
</div>
<div>
<div class="roundy text-center" style="margin-left: 1ex; width: 18em; padding: 0.2ex; background: linear-gradient(to right, #${color}, #${headcolor});"><div class="flex flex-row flex-nowrap flex-items-center flex-main-center">
<div>
${class}
<div class="text-big">'''${name}'''</div>
</div>${secondtrainer}
</div>
<div>'''[[${location}|<span style="color: #000;">${locationname}</span>]]'''</div>
<div class="text-small">${game}</div>
</div>
<div class="roundy pull-center" style="margin-top: 0.5ex; width: 14ex; padding: 0.2ex; background: linear-gradient(to right, #${color}, #${headcolor}); line-height: 10px">${balls}</div>
</div>${secondsprite}
</div>
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-space-around">
${party}
</div>
|}<br><br clear="left">
]=],
{
	color = colors.color,
	bordercolor = colors.bordercolor,
	r80 = r.roundyLua('80px'),
	headcolor1 = colors.headcolor1,
	bordercolor1 = colors.bordercolor1,
	sprite = p.sprite,
	headcolor = colors.headcolor,
	class = p.class and string.interp(extra.class, {class = p.class}) or '',
	name = p.name,
	secondtrainer = p.tag == 'yes' and string.interp(extra.secondtrainer, {class2 = p.class2, name2 = p.name2}) or '',
	location = p.location or 'Brockolandia',
	locationname = p.locationname or p.location or 'Brockolandia',
	game = gbl[p.game]{args={'000'}} or p.game,
	secondsprite = p.tag == 'yes' and
		string.interp(extra.secondsprite, {r80 = r.roundyLua('80px'), headcolor2 = colors.headcolor2, bordercolor2 = colors.bordercolor2,
		sprite2 = p.sprite2}) or '',
	prize = p.prize or '[[File:PokémonDollar.png|link=Pokémon Dollar]]0',
	balls = lib.balls(tonumber(p.pokemon) or 0),
	color1 = colors.color1,
	party = lib.party(poke,
		string.interp('|}\n{| class="roundybottom pull-center" style="background:#${color2}; border: 5px solid #${color2};"',
		{color2 = colors.color2})),
})
end

s.Squadra = s.squadra
--]===]

-- Returns true iff the text should be white on the passed color variant
local needWhiteText = function(color)
	local back2name, back2var = lib.getColor(color)
	return back2var == 'dark'
		or (back2var == 'normale' and table.search(wdata.whitetext, back2name))
end

-- Creates the table of colors common to both single and tag
local calcBaseColors = function(p)
	local colors = lib.gethex{
		color = p.color or 'sconosciuto',
		bordercolor = p.bordercolor or 'sconosciuto',
		headcolor = p.headcolor or 'sconosciuto'
	}
	colors = lib.gethex({
			back1 = p.back1 or colors.headcolor,
			back2 = p.back2 or colors.bordercolor,
			head1 = p.head1 or colors.color,
			head2 = p.head2 or p.back1 or colors.headcolor,
			sprcolor1 = p.sprcolor1 or p.head1 or colors.color,
			sprcolor2 = p.sprcolor2 or p.back1 or colors.headcolor,
	}, colors)

	return colors
end

-- Create the interpData common to both single and party
local calcBaseInterpData = function(p, colors, collapsiblebackground)
	local collapsiblelighttext
	-- Can't use and/or syntax because the value may be false
	if p.expandiblelight then
		collapsiblelighttext = p.expandiblelight:lower() == 'yes'
	else
		collapsiblelighttext = needWhiteText(collapsiblebackground)
	end

	local interpData = {
		sprite = p.sprite,
		size = p.size and '|' .. p.size or '',
		class = p.class and string.interp(classString, {class = p.class,
			classlink = p.classlink or lib.trainerClass[p.name] or p.class .. ' (classe allenatore)'}) or '',
		name = p.name or 'Oak',
		location = p.location or 'Brockolandia',
		locationname = p.locationname or p.location or 'Brockolandia',
		game = gbl[p.game]{args={'000'}} or p.game,
		prize = p.prize or '[[File:PokémonDollar.png|link=Dollari Pokémon]]0',
		balls = lib.balls(tonumber(p.pokemon or p.pokemon1) or 0),

		collapsiblelighttext = collapsiblelighttext and 'light-text' or '',

		mainBackground = css.horizGradLua{colors.back1, colors.back2},
		spriteBackground = css.horizGradLua{colors.sprcolor1, colors.sprcolor2},
		detailsBackground = css.horizGradLua{colors.head1, colors.head2},
	}
	interpData.ballsBackground = interpData.detailsBackground

	return interpData
end

-- Squadra/Single


s.single = function(frame)
	local p = w.trimAll(mw.clone(frame.args))

	local colors = calcBaseColors(p)

	local interpData = calcBaseInterpData(p, colors, p.back2 or p.bordercolor or '')
	interpData.pkmnBackground = interpData.mainBackground

	return string.interp([=[{| class="mw-collapsible mw-collapsed ${collapsiblelighttext} text-center pull-left roundy" style="padding: 0.5ex; ${mainBackground}"
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-center" style="padding: 0 2.5em;">
<div>
<div class="roundy-full" style="padding: 0.3ex; ${spriteBackground}">[[File:${sprite}${size}]]</div>
<div class="text-small" style="margin-top: 0.5ex; line-height: 10px">Ricompensa:</div>
<div>'''${prize}'''</div>
</div>
<div>
<div class="roundy text-center" style="margin-left: 1ex; width: 18em; padding: 0.2ex; ${detailsBackground}">
${class}
<div class="text-big">'''${name}'''</div>
<div>'''[[${location}|<span style="color: #000;">${locationname}</span>]]'''</div>
<div class="text-small">${game}</div>
</div>
<div class="roundy pull-center" style="margin-top: 0.5ex; width: 14ex; padding: 0.2ex; line-height: 10px; ${ballsBackground}">${balls}</div>
</div>
</div>
|-
| style="padding: 0;" | <div class="roundy flex flex-row flex-nowrap flex-items-center flex-main-space-around" style="${pkmnBackground}">]=],
	interpData)
end

s.Single = s.single

-- Squadra/Tag

s.tag = function(frame)
	local p = w.trimAll(mw.clone(frame.args))

	local colors = calcBaseColors(p)
	colors = lib.gethex({
			spr2color1 = p.spr2color1 or 'sconosciuto',
			spr2color2 = p.spr2color2 or 'sconosciuto',
		},
		colors
	)

	local interpData = calcBaseInterpData(p, colors, p.back2 or p.bordercolor or '')
	interpData.class2 = p.class2 and string.interp(classString, {class = p.class2,
			classlink = p.classlink2 or lib.trainerClass[p.name2] or p.class2 .. ' (classe allenatore)'}) or ''
	interpData.name2 = p.name2 or 'Oak'
	interpData.sprite2 = p.sprite2
	interpData.size2 = p.size2 and '|' .. p.size2 or ''
	interpData.balls = lib.balls(tonumber(p.pokemon1) or 0, tonumber(p.pokemon2) or 0)
	interpData.sprite2Background = css.horizGradLua{colors.spr2color1, colors.spr2color2}
	interpData.pkmnBackground = css.vertGradLua{colors.sprcolor1, colors.spr2color2}

	return string.interp([=[{| class="mw-collapsible mw-collapsed ${collapsiblelighttext} text-center pull-left roundy" style="padding: 0.5ex; ${mainBackground}"
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-center" style="padding: 0 2.5em;">
<div>
<div class="roundy-full" style="padding: 0.3ex; ${spriteBackground}">[[File:${sprite}${size}]]</div>
<div class="text-small" style="margin-top: 0.5ex; line-height: 10px">Ricompensa:</div>
<div>'''${prize}'''</div>
</div>
<div>
<div class="roundy text-center" style="margin-left: 1ex; width: 18em; padding: 0.2ex; ${detailsBackground}"><div class="flex flex-row flex-nowrap flex-items-center flex-main-center">
<div>
${class}
<div class="text-big">'''${name}'''</div>
</div>
<div>''e''</div>
<div>
${class2}<div class="big-text">'''${name2}'''</div>
</div>
</div>
<div>'''[[${location}|<span style="color: #000;">${locationname}</span>]]'''</div>
<div class="text-small">${game}</div>
</div>
<div class="roundy pull-center" style="margin-top: 0.5ex; width: 14ex; padding: 0.2ex; ${ballsBackground} line-height: 10px">${balls}</div>
</div>
<div class="flex-items-self-start roundy-full" style="margin-left: 1ex; padding: 0.3ex; ${sprite2Background}">[[File:${sprite2}]]</div>
</div>
|-
| <div class="roundy" style="padding: 0.5ex; ${pkmnBackground}">
<div class="flex flex-row flex-nowrap flex-items-center flex-main-space-around">]=],
	interpData)
end

s.Tag = s.tag

-- Party/Div

s.div = function(frame)
	return string.interp([=[</div>
<div class="flex flex-row flex-nowrap flex-items-center flex-main-space-around" style="margin-top: 0.5ex;">]=])
end

s.Div = s.div

--[[

Squadra/Footer: data la sua semplicità, è meglio non
usarlo: il traduttore di macro, per esempio, non lo fa

--]]
s.footer = function(frame) return '</div>\n|}<br><br clear="left">' end

s.Footer = s.footer

return s
