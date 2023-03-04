--[[

Questo modulo sceglie un Pokémon randomicamente e ne
fa usi diversi in base alla funzione

--]]

local p = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local form = require('Wikilib-forms')
local data = require("Wikilib-data")
local pokedata = require("Poké-data")
local alt = require("AltForms-data")
-- stylua: ignore end

-- Ritorna un ndex randomico
local randomNdex = function()
    math.randomseed(os.time())
    return math.random(data.pokeNum)
end

-- Ritorna l'artwork di un Pokèmon random
p.artwork = function(frame)
    local dimensione = txt.trim(frame.args[1] or "100")
    local num = tonumber(frame.args[2]) or randomNdex()
    local nome = pokedata[num].name
    local forme = nil
    alt = form.allFormsData()
    if alt[num] then
        forme = alt[num].gamesOrder
    end
    local ndex = txt.three_figures(num)
    if forme then
        ndex = ndex
            .. form.toEmptyAbbr(
                forme[math.random(tab.getn(forme))],
                nome:lower()
            )
    end

    return txt.interp(
        "[[File:Artwork${num}.png|center|${dimensione}x${dimensione}px|link=${nome}]]",
        { num = ndex, nome = nome, dimensione = dimensione }
    )
end

return p
