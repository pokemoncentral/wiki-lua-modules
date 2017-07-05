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
<div class="roundy-20" style="${bg} margin: 1ex 0;">
<div class="inline-block width-xl-40 width-xs-50 text-right"><span class="inline-block width-xl-10 width-xs-20">[[${nameprev}|<span style="color:#000">&larr;</span>]]</span><span class="inline-block width-xl-10 hidden-xs">${staticprev}</span><span class="inline-block width-xl-80" style="padding: 0 1em; box-sizing: border-box;">[[${nameprev}|<span style="color:#000">#${prev}: ${nameprev}</span>]]</span></div><div class="inline-block text-center width-xl-20 hidden-xs">[[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">${name}</span>]]</div><div class="inline-block width-xl-40 width-xs-50"><span class="inline-block width-xl-80" style="padding: 0 1em; box-sizing: border-box;">[[${namenext}|<span style="color:#000">#${nxt}: ${namenext}</span>]]</span><span class="inline-block width-xl-10 hidden-xs">${staticnext}</span><span class="inline-block width-xl-10 width-xs-20">[[${namenext}|<span style="color:#000">&rarr;</span>]]</span></div>
</div>]=],
{
    bg = css.horizGradLua{type1 = type1, type2 = type2},
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
