--[[

Modulo che sostituisce il template squadra: laddove
il template sia chiamato molte volte in una stessa
pagina ed ogni chiamata ne contiene alcune al modulo
colore si generano dei fastidiosi errori script.

I parametri sono gli stessi del template squadra, con
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
local r = require('Roundy')
local gbl = require('GamesColorLinks')
local c = require('Colore-data')

-- Modulo squadra intero

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
		class = [=[<div style="line-height:10px;">'''<span class="small-text">[[${class}|<span style="color:#000">${class}</span>]]</span>'''</div>]=],
		
		secondtrainer = [=[
	
	| ''e'' 
	| <div style="line-height:10px;">'''<span class="small-text">[[${class2} (classe allenatore)|<span style="color:#000">${class2}</span>]]</span>'''</div>'''<span class="big-text">${name2}</span>'''</div>]=],
	
		secondsprite = [=[
	
	| style="width: 80px; height: 80px; ${r80} background: #${headcolor2}; border: 2px solid #${bordercolor2};" | [[File:${sprite2}]]]=]
	}


	-- Interpolation
	return string.interp([=[{| class="text-center mw-collapsible mw-collapsed" style="${r20} background: #${color}; border: 2px solid #${bordercolor};" cellspacing="1" cellpadding="2"
| 
{| class="pull-center" style="background: transparent;" cellspacing="1" cellpadding="2"
! style="width: 80px; height: 80px; ${r80} background: #${headcolor1}; border: 2px solid #${bordercolor1};" | [[File:${sprite}]]
| 
{| class="roundy pull-center" style="width: 200px; background: #${headcolor}; border-collapse:collapse;"
| ${class}'''<span class="big-text">${name}</span>'''${secondtrainer}
|-
| colspan="3" | '''[[${location}|<span style="color:#000;">${locationname}</span>]]'''
|-
| class="small-text" colspan="3" | ${game}
|}${secondsprite}
|-
| <div style="line-height:10px;"><span class="small-text">Ricompensa:</span></div>'''${prize}'''
| 
{| class="pull-center" style="background: transparent; border-collapse:collapse;"
| class="roundy" style="background: #${headcolor}; line-height:10px;" | ${balls}
|}
|}
|  
|-
| colspan="2" | 
{| class="roundytop pull-center" style="background:#${color1}; border: 5px solid #${color1};"
|
${party}
|}
|}<br><br clear="left">
]=],
{
	r20 = r.roundyLua('20px'),
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

-- Squadra/Single

s.single = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
		
	-- Colori in esadecimale, con valori di default dapprima "sconosciuto" e poi quelli calcolati prima
	
	local colors = lib.gethex{color = p.color or c.sconosciuto.normale, bordercolor = p.bordercolor or c.sconosciuto.dark,
		headcolor = p.headcolor or c.sconosciuto.light}
	local colors = lib.gethex({headcolor1 = p.headcolor1 or colors.headcolor,
		bordercolor1 = p.bordercolor1 or colors.bordercolor}, colors)

	-- Stringa per la trainerclass, non sempre presente
	local class = [=[

|-
| style="line-height:10px" | '''<small>[[${classlink}|<span style="color:#000">${class}</span>]]</small>''']=]

	return string.interp([=[{| class="mw-collapsible mw-collapsed" style="text-align: center; float: left; ${r20} background: #${color}; border: 2px solid #${bordercolor}" cellspacing="1" cellpadding="2"
|-
| 
{| style="margin:auto; background: transparent" cellspacing="1" cellpadding="2"
! width="80px" height="80px" style="${r80} background: #${headcolor1}; border: 2px solid #${bordercolor1}" | [[File:${sprite}${size}]]
| 
{| class="roundy" width="200px" style="margin:auto; text-align:center; background: #${headcolor}; border-collapse:collapse"${class}
|-
| '''<big>${name}</big>'''
|-
| '''[[${location}|<span style="color:#000">${locationname}</span>]]'''
|-
| <small>${game}</small>
|}
|-
| style="text-align:center;" | <div style="line-height:10px"><small>Ricompensa:</small></div>'''${prize}'''
| 
{| class="roundy" style="margin:auto; background: transparent; border-collapse:collapse"
|-
| class="roundy" style="background: #${headcolor}; line-height:10px" | ${balls}
|}
|}
|  
|-
| colspan="2" | 
{| class="roundy" style="text-align: center; background: #${color}; border: 5px solid #${color}; width: 100%;"]=],
{
	r20 = r.roundyLua('20px'),
	color = colors.color,
	bordercolor = colors.bordercolor,
	r80 = r.roundyLua('80px'),
	headcolor1 = colors.headcolor1,
	bordercolor1 = colors.bordercolor1,
	sprite = p.sprite,
	size = p.size and '|' .. p.size or '',
	headcolor = colors.headcolor,
	class = p.class and string.interp(class, {class = p.class,
		classlink = p.classlink or trainerClass[p.name] or p.class .. ' (classe allenatore)'}) or '',
	name = p.name or 'Oak',
	location = p.location or 'Brockolandia',
	locationname = p.locationname or p.location or 'Brockolandia',
	game = gbl[p.game]{args={'000'}} or p.game,
	prize = p.prize or '[[File:PokémonDollar.png|link=Pokémon Dollar]]0',
	balls = lib.balls(tonumber(p.pokemon or p.pokemon1) or 0)
})
end

s.Single = s.single

-- Squadra/Tag

s.tag = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	
	-- Colori in esadecimale, con valori di default "sconosciuto"
	
	local colors = lib.gethex{color = p.color or c.sconosciuto.normale, bordercolor = p.bordercolor or c.sconosciuto.dark,
		headcolor = p.headcolor or c.sconosciuto.light, headcolor1 = p.headcolor1 or c.sconosciuto.light,
		headcolor2 = p.headcolor2 or c.sconosciuto.light, bordercolor1 = p.bordercolor1 or c.sconosciuto.dark,
		bordercolor2 = p.bordercolor2 or c.sconosciuto.dark, color1 = p.color1 or c.sconosciuto.dark}
	
	return string.interp([=[{| class="mw-collapsible mw-collapsed" style="text-align: center; float: left; ${r20} background: #${color}; border: 2px solid #${bordercolor}" cellspacing="1" cellpadding="2"
|-
| 
{| style="margin:auto; background: transparent" cellspacing="1" cellpadding="2"
! width="80px" height="80px" style="${r80} background: #${headcolor1}; border: 2px solid #${bordercolor1}" | [[File:${sprite}${size}]]
| 
{| class="roundy" width="200px" style="margin:auto; text-align:center; background: #${headcolor}; border-collapse:collapse"
|-
| style="line-height:10px" | '''<small>[[${classlink}|<span style="color:#000">${class}</span>]]</small>'''
| rowspan="2" | ''e''
| style="line-height:10px" | '''<small>[[${classlink2}|<span style="color:#000">${class2}</span>]]</small>'''
|-
| '''<big>${name}</big>'''
| '''<big>${name2}</big>'''
|-
| colspan="3" | '''[[${location}|<span style="color:#000">${locationname}</span>]]'''
|-
| colspan="3" | <small>${game}</small>
|}
! width="80px" height="80px" style="${r80} background: #${headcolor2}; border: 2px solid #${bordercolor2}" | [[File:${sprite2}${size2}]]
|-
| style="text-align:center;" | <div style="line-height:10px"><small>Ricompensa:</small></div>'''${prize}'''
| 
{| class="roundy" style="margin:auto; background: transparent; border-collapse:collapse"
|-
| class="roundy" width="96px" style="background: #${headcolor}; line-height:10px" | ${balls}
|}
|}
|  
|-
| colspan="2" | 
{| class="roundytop" style="width: 100%; background: #${color1}; border: 5px solid #${color1}"]=],
{
	r20 = r.roundyLua('20px'),
	color = colors.color,
	bordercolor = colors.bordercolor,
	r80 = r.roundyLua('80px'),
	headcolor1 = colors.headcolor1,
	bordercolor1 = colors.bordercolor1,
	sprite = p.sprite,
	size = p.size and '|' .. p.size or '',
	headcolor = colors.headcolor,
	classlink = p.classlink or trainerClass[p.name] or p.class .. ' (classe allenatore)',
	class = p.class or 'Professor',
	classlink2 = p.classlink2 or trainerClass[p.name2] or p.class2 .. ' (classe allenatore)',
	class2 = p.class2 or 'Professor',
	name = p.name or 'Oak',
	name2 = p.name2 or 'Oak',
	location = p.location or 'Brockolandia',
	locationname = p.locationname or p.location  or 'Brockolandia',
	game = gbl[p.game]{args={'000'}} or p.game,
	headcolor2 = colors.headcolor2,
	bordercolor2 = colors.bordercolor2,
	sprite2 = p.sprite2,
	size2 = p.size2 and '|' .. p.size2 or '',
	prize = p.prize or '[[File:PokémonDollar.png|link=Pokémon Dollar]]0',
	balls = lib.balls(tonumber(p.pokemon1) or 0, tonumber(p.pokemon2) or 0),
	color1 = colors.color1
})
end

s.Tag = s.tag

-- Squadra/Div

s.div = function(frame)
	return string.interp([=[

|}
{| class="roundybottom" style="width: 100%; background: #${color}; border: 5px solid #${color}"]=],
{color = lib.gethex{string.trim(frame.args.color) or c.sconosciuto.normale}[1]})
end

s.Div = s.div

--[[

Squadra/Footer: data la sua semplicità, è meglio non
usarlo: il traduttore di macro, per esempio, non lo fa

--]]
s.footer = function(frame) return '|}\n|}<br><br clear="left">' end

s.Footer = s.footer

return s
