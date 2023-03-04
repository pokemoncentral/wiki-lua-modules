--[[

Navigation bar with previous and next Pokémon in dex order.

This module exports two functions.
One is the "PokePrecSucc", intended to be used within Pokémon pages, that
links the previous and next Pokémon pages.
The other is "subpage", intended to be used in Pokémon subpages to link
corresponding subpages of previous and next Pokémon.

--]]

local m = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local multigen = require('Wikilib-multigen')
local genlib = require('Wikilib-gens')
local prevnext = require('PrevNext')
local data = require("Wikilib-data")
local pokes = require("Poké-data")
-- stylua: ignore end

-- Find the next existing ndex, considering there may be holes
local function nextNdex(ndex)
    local succ = ndex % data.pokeNum + 1
    if pokes[succ] then
        return succ
    else
        return nextNdex(succ)
    end
end

-- Find the previous existing ndex, considering there may be holes
local function prevNdex(ndex)
    local pred = (ndex - 2 + data.pokeNum) % data.pokeNum + 1
    if pokes[pred] then
        return pred
    else
        return prevNdex(pred)
    end
end

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

    local pred = prevNdex(pokeData.ndex)
    local succ = nextNdex(pokeData.ndex)
    local predFf = genlib.ndexToString(pred)
    local succFf = genlib.ndexToString(succ)

    local type1, type2 = pokeData.type1, pokeData.type2
    local predname, succname = pokes[pred].name, pokes[succ].name
    return prevnext.PrevNextLua({
        color = type1,
        color2 = type2,
        series = pokeData.name,
        list = list,
        prev = table.concat({ "#", predFf, ": ", predname }),
        prevlink = predname .. linksuffix,
        prevspr = txt.ff(pred),
        next = table.concat({ "#", succFf, ": ", succname }),
        nextlink = succname .. linksuffix,
        nextspr = txt.ff(succ),
    })
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
    local poke = txt.trim(frame.args[1] or mw.title.getCurrentTitle().rootText)
    local subpageSuffix = ""
    if frame.args[2] then
        subpageSuffix = "/" .. txt.trim(frame.args[2])
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
    local poke = txt.trim(frame.args[1] or mw.title.getCurrentTitle().text)
        :lower()
    return basePokePrecSucc(poke)
end

m.pokeprecsucc, m.pokePrecSucc = m.PokePrecSucc, m.PokePrecSucc

return m
