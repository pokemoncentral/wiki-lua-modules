--[[

Modulo per i mini-sprites, per utilizzo sia
interno da altri moduli, che esterno dal wikicode

--]]

local o = {}

local txt = require('Wikilib-strings')
local gendata = require("Gens-data")
local pokes = require("Poké-data")

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
	local n, gen, link = getData(n, gen, link)
	return string.interp("[[File:Ani${num}MS${gen}.gif|${name}|link=${name}]]",
    	{num = n, gen = gen, name = link})
end

o.ani_lua = o.aniLua

-- Chiamata esterna dal wikicode

o.ani = function(frame)
    return o.aniLua(splitMwArgs(frame.args))
end

o.Ani, o.AniP, o.aniP = o.ani, o.ani, o.ani

-- Mini-sprite statici

-- Chiamata interna da altri moduli

o.staticLua = function(n, gen, link)
	local n, gen, link = getData(n, gen, link)
    return string.interp("[[File:${num}MS${gen}.png|${name}|link=${name}]]",
    	{num = n, gen = gen, name = link})
end

o.static_lua = o.staticLua

-- Chiamata esterna dal wikicode

o.static = function(frame)
    return o.staticLua(splitMwArgs(frame.args))
end

o.Static, o.staticP, o.StaticP = o.static, o.static, o.static

return o
-- print(o[arg[1]]{args={ndex = arg[2], link = arg[4], gen = arg[3]}})
