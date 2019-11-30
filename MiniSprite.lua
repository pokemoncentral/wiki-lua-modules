--[[

Modulo per i mini-sprites, per utilizzo sia
interno da altri moduli, che esterno dal wikicode

--]]

local o = {}

local mw = require('mw')

local txt = require('Wikilib-strings') -- luacheck: no unused
local gendata = require("Gens-data")
local pokes = require("Poké-data")

-- Alias delle generazioni se ce ne sono alcune con i MS uguali
local genAliases = {}
genAliases['3'] = '5'
genAliases['4'] = '5'
genAliases['6'] = '7'

-- Generazioni di soli static
local staticOnly = {false, false, false, false, false, true, true}

-- Generazioni di soli ani
local aniOnly = {true, true, false, false, false, false, false}

--[[

Effettua il trim di ndex e generazione e
inserisce eventualmente i valori default.
Inoltre, se la generazione è l'ultima
ritorna la stringa vuota. Ritorna anche
il nome del Pokémon, gestendo pure le uova

--]]

local getData = function(n, gen, link)
	n = string.trim(n or '000')
	link = string.trim(link)
	gen = string.trim(gen or '')

	gen = genAliases[gen] or gen
	if gen == tostring(gendata.latest) then
	    gen = ''
	end

	if link == 'nil' or link == '' then
	    local numberN = string.parseInt(n)
	    if pokes[numberN] then
		    link = pokes[numberN].name
	    elseif n:find('.*[Uu]ovo.*') then
		    link = 'Uova Pokémon'
	    else
		    link = 'Missingno'
	    end
	end
	return n, gen, link
end

--[[

Adapter a mediawiki per le funzioni in lua.
Ha come argomento una table con la seguente
struttura:
- 1 | ndex: il numero di dex nazionale
- 2 | link (opzionale): il link che avrà l'immagine
- 3 | gen (opzionale): la generazione dell'immagine

--]]

local splitMwArgs = function(tab)
    return (tab.ndex or tab[1]), (tab.gen or tab[3]), (tab.link or tab[2])
end

-- Mini-sprite animati

-- Chiamata interna da altri moduli

o.aniLua = function(n, gen, link)
	local ani = staticOnly[tonumber(gen)] and '' or 'Ani'
	local ext = staticOnly[tonumber(gen)] and 'png' or 'gif'
	local n, gen, link = getData(n, gen, link)
	return string.interp("[[File:${ani}${num}MS${gen}.${ext}|${name}|link=${name}]]",
		{num = n, gen = gen, name = link, ani = ani, ext = ext})
end

o.ani_lua = o.aniLua

-- Chiamata esterna dal wikicode

o.ani = function(frame)
    return o.aniLua(splitMwArgs(mw.clone(frame.args)))
end

o.Ani, o.AniP, o.aniP = o.ani, o.ani, o.ani

-- Mini-sprite statici

-- Chiamata interna da altri moduli

o.staticLua = function(n, gen, link)
	local ani = aniOnly[tonumber(gen)] and 'Ani' or ''
	local ext = aniOnly[tonumber(gen)] and 'gif' or 'png'
	local n, gen, link = getData(n, gen, link)
    return string.interp("[[File:${ani}${num}MS${gen}.${ext}|${name}|link=${name}]]",
        {num = n, gen = gen, name = link, ani = ani, ext = ext})
end

o.static_lua = o.staticLua

-- Chiamata esterna dal wikicode

o.static = function(frame)
    return o.staticLua(splitMwArgs(mw.clone(frame.args)))
end

o.Static, o.staticP, o.StaticP = o.static, o.static, o.static

return o
--arg = {'static', '487', 'Giratina', '1'}
--print(o[arg[1]]{args={ndex = arg[2], link = arg[3], gen = arg[4]}})
