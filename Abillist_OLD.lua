-- Modulo che, data un'abilità, restituisce la tabella dei Pokémon che la hanno

local k = {}

local ms = require('MiniSprite')
local links = require('Links')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local list = require('Wikilib-lists')
local form = require('Wikilib-forms')
local c = require('Colore-data')
local ab = require('PokéAbil-data')
local pokes = require('Poké-data')

-- Restitusice l'header

local header = function(tipo)
	return string.interp([=[{| class="roundy text-center pull-center" style="border: 3px solid #${dark}; background: #${normale};"
|-
! class="roundytl" style="background: #${light};" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000;">#</span>]]
! style="background: #${light};" | Pok&eacute;mon
! colspan="2" style="background: #${light};" | [[Tipo|<span style="color:#000;">Tipi</span>]]
! style="background: #${light};" | Prima abilit&agrave;
! style="background: #${light};" | Seconda abilit&agrave;
! class="roundytr" style="background: #${light};" | Abilit&agrave; nascosta]=], c[tipo])
end

-- Il footer

local footer = function(tipo)
	return string.interp([=[

|-
| class="roundybottom text-left font-small" colspan="7" style="background: #${bg}; line-height:10px;" | '''Questa tabella è completamente corretta solo per i giochi di [[sesta generazione|<span style="color:#000">sesta generazione</span>]].'''
*Per i giochi di [[terza generazione|<span style="color:#000">terza generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive, le seconde e quelle nascoste.
*Per i giochi di [[quarta generazione|<span style="color:#000">quarta generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive e quelle nascoste.
*Per i giochi di [[quinta generazione|<span style="color:#000">quinta generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive.
|}]=], {bg = c[tipo].light})
end

-- Dato un Pokémon, ne ricava l'entry, sfruttando le tabelle Pokédata e PokéAbildata

local entry = function(name)
	local poke, abils = pokes[name], ab[name]
	local monoType = poke.type1 == poke.type2
	return string.interp([=[|-
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${ani}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | [[${name}|<span style="color:#000">${name}</span>]]${form}
| colspan="${cs}" style="background:#${std1}; border:1px solid #${dark1};" | [[${type1} (tipo)|<span style="color:#FFF">${type1}</span>]]${type2}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${abil1}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${abil2}
| style="background:#FFFFFF; border:1px solid #D8D8D8;" | ${abild}]=],
{
	ani = ms.aniLua(string.tf(poke.ndex) .. form.getabbr(name)),
	name = poke.name,
	form = form.getlink(name, true),
	cs = monoType and '2' or '1',
	std1 = c[poke.type1].normale,
	dark1 = c[poke.type1].dark,
	type1 = string.fu(poke.type1),
	type2 = monoType and '' or string.interp('\n|style="background:#${std2}; border:1px solid #${dark2};" | [[${type2} (tipo)|<span style="color:#FFF">${type2}</span>]]',
		{std2 = c[poke.type2].normale, dark2 = c[poke.type2].dark, type2 = string.fu(poke.type2)}),
	abil1 = abils.ability1 and links.aColor(abils.ability1, '000') or 'Nessuna',
	abil2 = abils.ability2 and links.aColor(abils.ability2, '000') or 'Nessuna',
	abild = abils.abilityd and links.aColor(abils.abilityd, '000') or 'Nessuna'
})
end

--[[

Scans through the pokeabil table to find Pokémon with the
given ability: then sorts the table and returns the concatenation

--]]

local entries = function(abil)
	local str = {}
	for name, poke in pairs(ab) do
		if list.isName(name) and table.search(poke, abil) then
			table.insert(str, entry(name))
		end
	end
	table.sort(str, list.sortNdex(list.ndexAniMS, list.gamesOrder))
	return table.concat(str, '\n')
end

--[[

Funzione d'interfaccia: si passano il tipo per il colore
e il titolo della pagina, da cui si ricava quello
dell'abilità. Poi si chiamano le funzioni header-etries-
footer per costruire la tabella

--]]

k.abillist = function(frame)
	local type = string.trim(frame.args[1]) or 'pcwiki'
	local abil = string.trim(frame.args[2]):match('^(.+) %(abilità%)') or 'Cacofonia'
	return table.concat({header(type), entries(abil), footer(type)}, '\n')
end

k.Abillist = k.abillist

--return k

print(k.abillist{args=arg})
