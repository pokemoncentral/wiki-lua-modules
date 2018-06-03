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
	{{#invoke: squadra | ... | color=erba dark}}
	{{#invoke: squadra | ... | headcolor2=elettro}}

--]]

local s = {}

local w = require('Wikilib')
local lib = require('Squadra-lib')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local r = require('Roundy')
local gbl = require('GamesColorLinks')
local c = require("Colore-data")

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

-- Squadra/Single

-- Stringa per la trainerclass, non sempre presente
local classString = [=[<div style="line-height: 10px" class="text-small">'''[[${classlink}|<span style="color:#000">${class}</span>]]'''</div>]=]


s.single = function(frame)
	local p = w.trimAll(mw.clone(frame.args))

	-- Colori in esadecimale, con valori di default dapprima "sconosciuto" e poi quelli calcolati prima

	local colors = lib.gethex{
		color = p.color or c.sconosciuto.normale,
		bordercolor = p.bordercolor or c.sconosciuto.dark,
		headcolor = p.headcolor or c.sconosciuto.light}
	colors = lib.gethex({
		back1 = p.back1 or colors.headcolor,
		back2 = p.back2 or colors.bordercolor,
		head1 = p.head1 or colors.color,
		head2 = p.head2 or p.back1 or colors.headcolor,
		sprcolor1 = p.sprcolor1 or p.head1 or colors.color,
		sprcolor2 = p.sprcolor2 or p.back1 or colors.headcolor,
		}, colors)

	local interpData = table.merge(colors, {

		r80 = r.roundyLua('80px'),
		collapsiblelighttext = (p.expandiblelight and p.expandiblelight:lower()) == 'yes' and 'light-text' or '',
		sprite = p.sprite,
		size = p.size and '|' .. p.size or '',
		class = p.class and string.interp(classString, {class = p.class,
			classlink = p.classlink or trainerClass[p.name] or p.class .. ' (classe allenatore)'}) or '',
		name = p.name or 'Oak',
		location = p.location or 'Brockolandia',
		locationname = p.locationname or p.location or 'Brockolandia',
		game = gbl[p.game]{args={'000'}} or p.game,
		prize = p.prize or '[[File:PokémonDollar.png|link=Pokémon Dollar]]0',
		balls = lib.balls(tonumber(p.pokemon or p.pokemon1) or 0)
	})

	return string.interp([=[{| class="mw-collapsible mw-collapsed ${collapsiblelighttext} text-center pull-left roundy" style="padding: 0.5ex; background: linear-gradient(to right, #${back1}, #${back2});"
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-center" style="padding: 0 2.5em;">
<div>
<div style="padding: 0.3ex; ${r80} background: linear-gradient(to right, #${sprcolor1}, #${sprcolor2});">[[File:${sprite}${size}]]</div>
<div class="text-small" style="margin-top: 0.5ex; line-height: 10px">Ricompensa:</div>
<div>'''${prize}'''</div>
</div>
<div>
<div class="roundy text-center" style="margin-left: 1ex; width: 18em; padding: 0.2ex; background: linear-gradient(to right, #${head1}, #${head2});">
${class}
<div class="text-big">'''${name}'''</div>
<div>'''[[${location}|<span style="color: #000;">${locationname}</span>]]'''</div>
<div class="text-small">${game}</div>
</div>
<div class="roundy pull-center" style="margin-top: 0.5ex; width: 14ex; padding: 0.2ex; background: linear-gradient(to right, #${head1}, #${head2}); line-height: 10px">${balls}</div>
</div>
</div>
|-
| style="padding: 0;" | <div class="roundy flex flex-row flex-nowrap flex-items-center flex-main-space-around" style="background: linear-gradient(to right, #${back1}, #${back2};">]=],
	interpData)
end

s.Single = s.single

-- Squadra/Tag

s.tag = function(frame)
	local p = w.trimAll(mw.clone(frame.args))

	-- Colori in esadecimale, con valori di default "sconosciuto"

	local colors = lib.gethex{
		color = p.color or c.sconosciuto.normale,
		bordercolor = p.bordercolor or c.sconosciuto.dark,
		headcolor = p.headcolor or c.sconosciuto.light}
	colors = lib.gethex({
		back1 = p.back1 or colors.headcolor,
		back2 = p.back2 or colors.bordercolor,
		head1 = p.head1 or colors.color,
		head2 = p.head2 or p.back1 or colors.headcolor,
		sprcolor1 = p.sprcolor1 or p.head1 or colors.color,
		sprcolor2 = p.sprcolor2 or p.back1 or colors.headcolor,
		spr2color1 = p.spr2color1 or c.sconosciuto.normale,
		spr2color2 = p.spr2color2 or c.sconosciuto.normale,
		}, colors)

	local interpData = table.merge(colors, {
		r80 = r.roundyLua('80px'),
		collapsiblelighttext = (p.expandiblelight and p.expandiblelight:lower()) == 'yes' and 'light-text' or '',
		sprite = p.sprite,
		size = p.size and '|' .. p.size or '',
		class = p.class and string.interp(classString, {class = p.class,
			classlink = p.classlink or trainerClass[p.name] or p.class .. ' (classe allenatore)'}) or '',
		class2 = p.class2 and string.interp(classString, {class = p.class2,
			classlink = p.classlink2 or trainerClass[p.name2] or p.class2 .. ' (classe allenatore)'}) or '',
		name = p.name or 'Oak',
		name2 = p.name2 or 'Oak',
		location = p.location or 'Brockolandia',
		locationname = p.locationname or p.location  or 'Brockolandia',
		game = gbl[p.game]{args={'000'}} or p.game,
		sprite2 = p.sprite2,
		size2 = p.size2 and '|' .. p.size2 or '',
		prize = p.prize or '[[File:PokémonDollar.png|link=Pokémon Dollar]]0',
		balls = lib.balls(tonumber(p.pokemon1) or 0, tonumber(p.pokemon2) or 0),
	})

	return string.interp([=[{| class="mw-collapsible mw-collapsed ${collapsiblelighttext} text-center pull-left roundy" style="padding: 0.5ex; background: linear-gradient(to right, #${back1}, #${back2});"
|-
| <div class="flex flex-row flex-nowrap flex-items-center flex-main-center" style="padding: 0 2.5em;">
<div>
<div style="padding: 0.3ex; ${r80} background: linear-gradient(to right, #${sprcolor1}, #${sprcolor2});">[[File:${sprite}${size}]]</div>
<div class="text-small" style="margin-top: 0.5ex; line-height: 10px">Ricompensa:</div>
<div>'''${prize}'''</div>
</div>
<div>
<div class="roundy text-center" style="margin-left: 1ex; width: 18em; padding: 0.2ex; background: linear-gradient(to right, #${head1}, #${head2});"><div class="flex flex-row flex-nowrap flex-items-center flex-main-center">
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
<div class="roundy pull-center" style="margin-top: 0.5ex; width: 14ex; padding: 0.2ex; background: linear-gradient(to right, #${head1}, #${head2}); line-height: 10px">${balls}</div>
</div>
<div class="flex-items-self-start" style="margin-left: 1ex; padding: 0.3ex; ${r80} background: linear-gradient(to right, #${spr2color1}, #${spr2color2});">[[File:${sprite2}]]</div>
</div>
|-
| <div class="roundy" style="background: linear-gradient(to bottom, #${sprcolor1}, #${spr2color2}); padding: 0.5ex;">
<div class="flex flex-row flex-nowrap flex-items-center flex-main-space-around">]=],
	interpData)
end

s.Tag = s.tag

-- Squadra/Div

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
