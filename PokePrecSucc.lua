--[[

La barra per scorrere sequenzialmente in ordine di dex
nazionale in cima ed in fondo ad ogni pagina dei Pokémon

--]]

local m = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local ms = require('MiniSprite')
local css = require('Css')
local data = require("Wikilib-data")
local pokes = require("Poké-data")

m.PokePrecSucc = function(frame)
    local poke = string.trim(frame.args[1]):lower()
    local pokeData = pokes[poke] or pokes[mw.text.decode(poke)]
    local type1, type2 = pokeData.type1, pokeData.type2
    local prev = (pokeData.ndex - 2 + data.pokeNum) % data.pokeNum + 1
	local nxt = pokeData.ndex % data.pokeNum + 1
	local prevTf, nxtTf = string.tf(prev), string.tf(nxt)
    return string.interp([=[
<div class="roundy-20 flex flex-row flex-nowrap flex-main-space-between flex-items-center" style="${bg} margin: 1ex 0; padding: 0 3.5%;">
	<div>
		<span class="align-middle" style="padding-right: 1.5rem;">[[${nameprev}|<span style="color:#000">&larr;</span>]]</span>
		${staticprev}
	</div>
	<div>
		[[${nameprev}|<span style="color:#000">#${prev}: ${nameprev}</span>]]
		<span style="padding: 0 5.5rem;">
			[[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">${name}</span>]]
		</span>
		[[${namenext}|<span style="color:#000">#${nxt}: ${namenext}</span>]]
	</div>
	<div>
		${staticnext}
		<span class="align-middle" style="padding-left: 1.5rem;">[[${namenext}|<span style="color:#000">&rarr;</span>]]</span>
	</div>
</div>]=],
{
	bg = css.horizGradLua(type1, type1 == type2 and 'light' or 'normale', type2, 'normale'),
    nameprev = pokes[prev].name,
    prev = prevTf,
    staticprev = ms.staticLua(prevTf),
    name = pokeData.name,
    namenext = pokes[nxt].name,
    nxt = nxtTf,
    staticnext = ms.staticLua(nxtTf)
})
end

m.pokeprecsucc, m.pokePrecSucc = m.PokePrecSucc, m.PokePrecSucc

print(m.pokeprecsucc{args={arg[1]}})
-- return m
