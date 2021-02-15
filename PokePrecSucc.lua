--[[

Navigation bar with previous and next Pokémon in dex order.

This module exports two functions.
One is the "PokePrecSucc", intended to be used within Pokémon pages, that
links the previous and next Pokémon pages.
The other is "subpage", intended to be used in Pokémon subpages to link
corresponding subpages of previous and next Pokémon.

--]]

local m = {}

local mw = require('mw')

local txt = require('Wikilib-strings') -- luacheck: no unused
local multigen = require('Wikilib-multigen')
local prevnext = require('PrevNext')
local data = require("Wikilib-data")
local pokes = require("Poké-data")

--[[

Base (internal) function to create a PokePrecSucc. Performs basic operations
such as computing previous and next Pokémon ndex, and preparing the printed
text.

Parameters:
    - poke: the Pokémon name
    - linksuffix: (optional) the suffix to append to links. It defaults to
        nothing (ie: links base Pokémon pages). This suffix is appended as is;
        it's not modified, for instance, adding a leading "/".
    - list: (optional) the page to link in the middle of the prevnext.

--]]
local function basePokePrecSucc(poke, linksuffix, list)
    linksuffix = linksuffix or ""
    list = list or "Elenco Pokémon secondo il Pokédex Nazionale"
    local pokeData = multigen.getGen(pokes[poke] or pokes[mw.text.decode(poke)])
    local type1, type2 = pokeData.type1, pokeData.type2
    local pred = (pokeData.ndex - 2 + data.pokeNum) % data.pokeNum + 1
    local succ = pokeData.ndex % data.pokeNum + 1
    local predTf, succTf = string.tf(pred), string.tf(succ)
    local predname, succname = pokes[pred].name, pokes[succ].name
    return prevnext.PrevNextLua{
        color = type1,
        color2 = type2,
        series = pokeData.name,
        list = list,
        prev = table.concat{"#", predTf, ": ", predname},
        prevlink = predname .. linksuffix,
        prevspr = predTf,
        next = table.concat{"#", succTf, ": ", succname},
        nextlink = succname .. linksuffix,
        nextspr = succTf,
    }
end

--[[

Function to create a PrecSucc of subpages.

Usage:
{{#invoke: PokePrecSucc | subpage | <Pokémon name> | <suffix> | ... }}

- 1: (optional) the name of a Pokémon. In a Pokémon subpage the suggested value
    for this is "{{ROOTPAGENAME}}", that evaluates to the page name that
    (often) is the Pokémon name desired. It defaults to the root page title.
- 2: (optional) if given, it is used to determine the subpage to link. It
    should be the name of the subpage to link without the leading /. It
    defaults to the same suffix as the page it's invoked in.
- list: (optional) the page to link from the middle text (the name of the
    current Pokémon). Defaults to "Elenco Pokémon secondo il Pokédex Nazionale"

--]]
m.subpage = function(frame)
    local poke = string.trim(frame.args[1]
                             or mw.title.getCurrentTitle().rootText)
    local subpageSuffix = ""
    if frame.args[2] then
        subpageSuffix = "/" .. string.trim(frame.args[2])
    else
        local title = mw.title.getCurrentTitle()
        if title.isSubpage then
            subpageSuffix = "/" .. mw.title.getCurrentTitle().subpageText
        end
    end

    return basePokePrecSucc(poke:lower(), subpageSuffix, poke)
end

--[[

Function to create a PrecSucc in a Pokémon page.

Usage:
{{#invoke: PokePrecSucc | PokePrecSucc | <Pokémon name> }}

- 1: (optional) the name of a Pokémon. In a Pokémon the suggested value for
    this is "{{PAGENAME}}", that evaluates to the page name that (often) is
    the Pokémon name desired. If not given, it defaults to the page title.

--]]
m.PokePrecSucc = function(frame)
    local poke = string.trim(frame.args[1]
                             or mw.title.getCurrentTitle().text):lower()
    return basePokePrecSucc(poke)
end

m.pokeprecsucc, m.pokePrecSucc = m.PokePrecSucc, m.PokePrecSucc

return m
