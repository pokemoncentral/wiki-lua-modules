--[[

La barra per scorrere sequenzialmente in ordine di dex
nazionale in cima ed in fondo ad ogni pagina dei Pokémon

--]]

local m = {}

local txt = require('Wikilib-strings')
local ms = require('MiniSprite')
local c = require('Colore-data')
local data = require('Wikilib-data')
local pokes = require('Poké-data')

m.PokePrecSucc = function(frame)
    local poke = string.trim(frame.args[1]):lower()
    local tipo1, tipo2 = pokes[poke].type1, pokes[poke].type2
    local prev = (pokes[poke].ndex - 2 + data.pokeNum) % data.pokeNum + 1
	local nxt = pokes[poke].ndex % data.pokeNum + 1
	local prevTf, nxtTf = string.tf(prev), string.tf(nxt)
    return string.interp([=[{| class="roundy" style="background: #${bg}; border: 3px solid #${bd}; margin-bottom: 5px; margin-top: 5px; width: 100%;"
| class="roundyleft text-right" style="padding-right: 3px; width: 45%; background: #${cells};" | [[${nameprev}|<span style="color:#000">&larr;</span>]]${aniprev}<span style="display: inline-block; width: 70%;">[[${nameprev}|<span style="color:#000">#${prev}: ${nameprev}</span>]]</span>
| class="text-center" style="padding: 0 3px; background: #${cells};" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">${name}</span>]]
| class="roundyright text-left" style="padding-left: 3px; width: 45%; background: #${cells};" | <span style="display: inline-block; width: 70%;">[[${namenext}|<span style="color:#000">#${nxt}: ${namenext}</span>]]</span>${aninext}[[${namenext}|<span style="color:#000">&rarr;</span>]]
|}]=],
{
    bg = c[tipo1].normale,
    bd = tipo1 == tipo2 and c[tipo2].dark or c[tipo2].normale,
    cells = c[tipo1].light,
    nameprev = pokes[prev].name,
    prev = prevTf,
    aniprev = ms.aniLua(prevTf),
    name = pokes[poke].name,
    namenext = pokes[nxt].name,
    nxt = nxtTf,
    aninext = ms.aniLua(nxtTf)
})
end

m.pokeprecsucc, m.pokePrecSucc = m.PokePrecSucc, m.PokePrecSucc

print(m.pokeprecsucc{args={arg[1]}})
-- return m
