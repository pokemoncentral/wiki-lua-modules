--[[

La barra per scorrere sequenzialmente in ordine di dex
nazionale in cima ed in fondo ad ogni pagina dei Pokémon

--]]

local m = {}

local mw = require('mw')

local txt = require('Wikilib-strings') -- luacheck: no unused
local multigen = require('Wikilib-multigen')
local prevnext = require('PrevNext')
local data = require("Wikilib-data")
local pokes = require("Poké-data")

m.PokePrecSucc = function(frame)
    local poke = string.trim(frame.args[1]):lower()
    local pokeData = multigen.getGen(pokes[poke] or pokes[mw.text.decode(poke)])
    local type1, type2 = pokeData.type1, pokeData.type2
    local prev = (pokeData.ndex - 2 + data.pokeNum) % data.pokeNum + 1
    local next = pokeData.ndex % data.pokeNum + 1
    local prevTf, nextTf = string.tf(prev), string.tf(next)
    local prevname, nextname = pokes[prev].name, pokes[next].name
    return prevnext.PrevNextLua{
        color = type1,
        color2 = type2,
        series = pokeData.name,
        list = "Elenco Pokémon secondo il Pokédex Nazionale",
        prev = table.concat{"#", prevTf, ": ", prevname},
        prevlink = prevname,
        prevspr = prevTf,
        next = table.concat{"#", nextTf, ": ", nextname},
        nextlink = nextname,
        nextspr = nextTf,
    }
end

m.pokeprecsucc, m.pokePrecSucc = m.PokePrecSucc, m.PokePrecSucc

return m
