-- Ognuna di questa funzioni sostituisce uno switch. Le chiamate sono solo a titolo
-- di esempio, e possono prevedere variazioni.

local switches = {}

local w = require('Wikilib')
local txt = require('Wikilib-strings')
local t = require('Wikilib-tables')
local ot = require('Wikilib-others')
local c = require('Colore-data')

-- Ritorna "light" se il parametro è 'Light', "dark" se il parametro è
-- 'Dark', Rocket', 'Rocketex', 'Idro', 'Aqua', 'Magma', 'Galassia',
-- 'Galactic', 'Plasma' o 'PlasmaEX';
-- chiamata: {{#invoke | PokémoncardInfobox | background | <parametroSwitch> }}

switches.background = function(frame)
	local bgShade = {Dark = 'dark', Light = 'light'}
	t.tableKeysAlias(bgShade, {'Dark'}, {{'Rocket', 'Rocketex', 'Idro', 'Aqua', 'Magma',
		'Galassia', 'Galactic', 'Plasma', 'PlasmaEX'}})
	return bgShade[txt.trim(frame.args[1])]
end

switches.Background = switches.background

-- Questo è una piccola eccezione, ritorna direttamente il codice per i
-- bordi delle tabelle; non ritorna niente se il primo parametro NON è
-- 'Rocket', 'Rocketex', 'Idro', 'Aqua', 'Magma', 'Galassia','Galactic',
-- 'Dark', 'Light', 'ex', 'Shiny', 'Cristallo', 'Stella', 'Leggenda',
-- 'Crystal', 'Prime', 'EX', 'Legend', 'Plasma' o 'PlasmaEX'; imposta il bordo
-- a 4px se il primo parametro è 'ex', 'Rocketex', 'Stella', 'Cristallo', 'Prime', 'EX' o 'Leggenda', 8px altrimenti; ogni possibile parametro ha il suo colore, in base al valore del secondo parametro;
-- chiamata: {{#invoke | PokémoncardInfobox | border | <parametroSwitch> | {{{type|}}} }}

switches.border = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	local tab = {'border: ', 'px solid #'}
	local wholeBorderDisplay = {'Rocket', 'Rocketex', 'Idro', 'Aqua', 'Magma', 'Galassia',
		'Galactic', 'Dark', 'Light', 'ex', 'Shiny', 'Cristallo', 'Stella', 'Leggenda',
		'Crystal', 'Prime', 'EX', 'Legend', 'Plasma', 'PlasmaEX'}
	local wholeBorder4px = {'ex', 'Rocketex', 'Stella', 'Cristallo', 'Prime', 'EX', 'Leggenda'}
	local wholeBorderColor = {Rocket = '222', Light = 'FFFF99', Cristallo = 'FFD700', Plasma = '014087',
		ex = p[2] == 'Incolore' and 'D0D070' or 'DDD'}
	t.tableKeysAlias(wholeBorderColor, {'Rocket', 'ex', 'Cristallo'}, {{'Rocketex', 'Idro', 'Aqua', 'Magma', 'Galassia', 'Galactic', 'Dark'},
		{'EX', 'Prime'}, {'Stella', 'Leggenda'}})
	if not t.linear_search(wholeBorderDisplay, p[1]) then
		return ''
	end
	table.insert(tab, 2, t.linear_search(wholeBorder4px, p[1]) and '4' or '8')
	table.insert(tab, wholeBorderColor[p[1]])
	return table.concat(tab)
end

switches.Border = switches.border

-- Ritorna il colore del testo, con tanto di ombreggiatura, per i valori
-- 'Prime', 'Leggenda' o 'Ex' del primo parametro, sulla base degli altri due;
-- chiamata: {{#invoke | PokémoncardInfobox | color | <parametroSwitch> | {{{type|}}} | {{{type2|{{{type|}}}}}} }}

switches.color = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	local textColor = {Prime = p[2] == 'Incolore' and c.heartgold.normale or c.soulsilver.normale,
		Leggenda = table.concat{c.heartgold.normale, '; text-shadow: #', c.soulsilver.normale, ' 0px 1px 1px'},
		EX = p[2] == 'Oscurità' and 'FFF' or '000'}
	return (textColor[p[1]] or p[3] == 'Oscurità' and 'FFF' or '000') .. ';"'
end

switches.Color = switches.color

-- Ritorna l'immagine da mettere accanto al nome del Pokémon,
-- se il parametro vale 'Leggenda', 'PlasmaEX', 'Galassia', 'Capopalestra', 'Superquattro', 'Campione', 'Asso Lotta', 'Film', 'EX', 'Legend' o
-- 'Galactic';
-- chiamata:  {{#invoke | PokémoncardInfobox | nameImage | <parametroSwitch> }}

switches.nameImage = function(frame)
	local image = {Leggenda = '[[File:Pokémon LEGGENDA.png|LEGGENDA]]', PlasmaEX = '[[File:Pokémon EX.png|x18px|EX]]',
		Galassia = '[[File:Pokémon SP G.png|Galassia]]', Capopalestra = '[[File:Pokémon SP CP.png|Capopalestra]]',
		Superquattro = '[[File:Pokémon SP 4.png|Superquattro]]', Campione = '[[File:Pokémon SP C.png|Campione]]',
		['Asso Lotta'] = '[[File:Pokémon SP AL.png|Asso Lotta]]', Film = '[[File:Pokémon SP F.png|Film]]',
		TURBO = '[[File:TURBO.png|TURBO]]'}
	t.tableKeysAlias(image,  {'PlasmaEX', 'Leggenda', 'Galassia'}, {{'EX', 'MegaEX'}, {'Legend'}, {'Galactic'}})
	return image[txt.trim(frame.args[1])] or ''
end

switches.NameImage = switches.nameImage

-- Ritorna un piccolo pedice, da mettere di fianco al nome, se il secondo
-- parametro vale 'δ', 'ex', 'exδ', 'X', 'star' o 'starδ';
-- chiamata: {{#invoke | PokémoncardInfobox | title | {{star}} | {{{level|}}} }}

switches.title = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	local title = {['δ'] = '<small>δ Specie Delta</small>', ex = "''<big><big>ex</big></big>''",
		['exδ'] = "''<big><big>ex</big></big>'' <small>δ Specie Delta</small>", X = "<small>LIV.</small>''<big>X</big>''",
		star = p[1], ['starδ'] = p[1] .. '<small>δ Specie Delta</small>'}
	return title[p[2]] or (p[2] == '' and '&nbsp;' or '<small>LV.</small>' .. p[2])
end

switches.Title = switches.title

-- Ritorna un numero intero casuale in un certo intervallo, definito dai
-- due parametri;
-- chiamata: {{#invoke | PokémoncardInfobox | random | inf | sup }}

switches.random = function(frame)
	return ot.random(tonumber(frame.args[1]), tonumber(frame.args[2]))
end

switches.Random = switches.random

-- Ritorna '888' se il parametro è 'Dark', 'Rocket', 'Rocketex', 'Idro',
-- 'Aqua', 'Magma', 'Galassia', 'Galactic', 'Plasma' o 'PlasmaEX'; 'FFF'
-- altrimenti.
-- chiamata: {{#invoke | PokémoncardInfobox | innerbg | <parametroSwitch> }}

switches.innerbg = function(frame)
	local bgShade = {'Dark', 'Rocket', 'Rocketex', 'Idro', 'Aqua', 'Magma',
		'Galassia', 'Galactic', 'Plasma', 'PlasmaEX'}
	return t.linear_search(bgShade, txt.trim(frame.args[1])) and '888' or 'FFF'
end

switches.Innerbg = switches.innerbg

-- Ritorna la variante del sottotemplate per l'evostage, ciò che va dopo
-- 'PokémoncardInfobox/'.
-- chiamata:  {{#invoke | PokémoncardInfobox | evostage | {{{evostage|}}} }}

switches.evostage = function(frame)
	local stages = {Baby = 'Evobaby', Babyspecial = 'Evobabyspecial', Base = 'Evobasic', Basic = 'Evobasic',
		Basicspecial = 'Evobasicspecial', ['Stage 1'] = 'Evostage1', ['Stage 2'] = 'Evostage2', ['LIV.X'] = 'EvoX',
		EX = 'EvoEX', Legend = 'EvoLegendSpecial', Restored = 'Evorestored', MegaEX = 'EvomegaEX', TURBO = 'EvoTurbo',
		Archeo = 'EvoArcheo'}
	t.tableKeysAlias(stages, {'Stage 1', 'Stage 2', 'LIV.X', 'Legend'},
		{{'Stadio 1'}, {'Stadio 2'}, {'LV.X'}, {'Leggenda', 'Leggenda2', 'Legend2'}})
	return stages[txt.trim(frame.args[1])]
end

switches.Evostage = switches.evostage

-- Ritorna il completamento del link alla pagina del Pokémon nel GCC
-- (es [[Bulbasaur (GCC)#chiamata al template]])
-- chiamata: {{#invoke | PokémoncardInfobox | anchor | <parametroSwitch> | {{{level|}}} | {{{class|}}} | {{{cardname|}}} }}

switches.anchor = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	local anchor = {Leggenda = '&nbsp;LEGGENDA', EX = '-EX', Galassia = '&nbsp;G', Capopalestra = '&nbsp;CP',
		Superquattro = '&nbsp;4', Campione = '&nbsp;C', ['Asso Lotta'] = '&nbsp;AL', Film = '&nbsp;F'}
	t.tableKeysAlias(anchor,  {'EX', 'Leggenda', 'Galassia'}, {{'PlasmaEX'}, {'Legend'}, {'Galactic'}})
	local anchor1 = {star = '&nbsp;☆', ex = '&nbsp;ex', X = '&nbsp;LIV.X', EX = '-EX'}
	anchor1['starδ'] = anchor1.star
	local anchor2 = {ex = '&nbsp;ex'}
	anchor2['exδ'] = anchor2.ex
	local anchor3 = {EX = '-EX'}
	anchor3.PlasmaEX = anchor3.EX
	return table.concat{p[4], anchor[p[1]] or '', anchor1[p[2]] or '', '|', p[4], anchor2[p[2]] or '', anchor3[p[3]] or ''}
end

switches.Anchor = switches.anchor

-- Ritorna l'immagine da inserire accando alla carta, se il
-- parametro vale 'Leggenda', 'Galassa', 'Capopalestra', 'Superquattro', 'Campione', 'Asso Lotta', 'Film', 'Legend' o 'Galactic'.
-- chiamata: {{#invoke | PokémoncardInfobox | cardNameImage | <parametroSwitch> }}

switches.cardNameImage = function(frame)
	local images = {Leggenda = '[[File:Pokémon LEGGENDA.png]]', Galassia = '[[File:Pokémon SP G.png|Galactic]]',
		Capopalestra = '[[File:Pokémon SP CP.png|Capopalestra]]', Superquattro = '[[File:Pokémon SP 4.png|Superquattro]]',
		Campione = '[[File:Pokémon SP C.png|Campione]]', ['Asso Lotta'] = '[[File:Pokémon SP AL.png|Asso Lotta]]',
		Film = '[[File:Pokémon SP F.png|Film]]'}
	t.tableKeysAlias(images,  {'Leggenda', 'Galassia'}, {{'Legend'}, {'Galactic'}})
	return images[txt.trim(frame.args[1])] or ''
end

switches.CardNameImage = switches.cardNameImage

-- Gestisce le categorie in cui inserire la carta sulla base dei
-- parametri passati.
-- chiamata: {{#invoke | PokémoncardInfobox | categories | {{{evostage|}}} | <parametroSwitch> | {{{level|}}} }}

switches.categories = function(frame)
	local p = w.trimAll(mw.clone(frame.args))
	local stages = {Baby = '[[Category:Carte Baby Pokémon]]', Basic = '[[Categoria:Carte Pokémon Base]]',
		Ricreato = '[[Categoria:Carte Pokémon Ricreate]]',
		['Fase 1'] = '[[Categoria:Carte Pokémon Fase 1]][[Category:Carte evolute]]',
		['Fase 2'] = '[[categoria:Carte Pokémon Fase 2]][[Category:Carte evoluzione]]',
		['LIV.X'] = '[[Category:Carte Pokémon LIV.X]]'}
	t.tableKeysAlias(stages, {'Baby', 'Basic', 'Ricreato', 'Fase 1', 'Fase 2', 'LIV.X'},
		{{'Babyspecial'}, {'Base'}, {'Restored'}, {'Stage 1'}, {'Stage 2'}, {'LV.X'}})
	local class = {Galassia = '[[Category:Carte Pokémon SP]][[Category:Team Galassia (GCC)]]',
		Capopalestra = '[[Category:Carte Pokémon SP]]', Rocketex = '[[Category:Carte Pokémon ex]]',
		Dark = '[[Category:Pokémon con "Dark" nei loro nomi]]',
		Light = '[[Category:Pokémon con "Light" nei loro nomi]]', Prime = '[[Category:Carte Pokémon Prime]]',
		Leggenda = '[[Category:Carte Pokémon LEGGENDA]]', EX = '[[Category:Carte Pokémon EX]]',
		Plasma = '[[Category:Carte Team Plasma]]', Cristallo = '[[Category:Carte Pokémon Cristallo]]',
		Stella = p[3]:match('star') and '[[Category:Carte Pokémon ☆]]' or '[[Category:Pokémon con "Shining" nei loro nomi]]',
		TURBO = '[[Categoria:Carte TURBO]]', Archeo = '[[Categoria:Carte Pokémon Archeorisveglio]]'}
	class.PlasmaEX = class.EX .. class.Plasma
	t.tableKeysAlias(class, {'Capopalestra', 'Rocketex'}, {{'Superquattro', 'Campione', 'Asso Lotta', 'Film'}, {'ex'}})
	return table.concat{stages[p[1]] or '', class[p[2]] or '',
		p[3]:match('δ') and '[[Category:Carte Pokémon di δ Specie Delta]]' or ''}
end

switches.Categories = switches.categories

return switches
