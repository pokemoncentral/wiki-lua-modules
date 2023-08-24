--[[

Tabella contenente le MT e le MN delle varie generazioni

Può essere chiamato con il nome della pagina
{{#invoke: MTCompatto | MTCompatto | {{BASEPAGENAME}} }}

oppure con il nome di una mossa
{{#invoke: MTCompatto | MTCompatto | Surf }}

oppure specificando le generazioni da mostrare
{{#invoke: MTCompatto | MTCompatto | 123 | tipo = pcwiki }}


Si può anche usare MTGen per avere la tabella di una sola generazione
{{#invoke: MTCompatto | MTGen | 4 | width = 65% }}

--]]

local m = {}

-- stylua: ignore start
local mw = require('mw')

local w = require('Wikilib')
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local multigen = require('Wikilib-multigen')
local links = require('AbbrLink')
local css = require('Css')
local cc = require('ChooseColor')
local machines = require("Machines-data")
local gens = require("Gens-data")
local moves = require("Move-data")
-- stylua: ignore end

local strings = {
    MAIN_BOX = [=[
<br class="clear-all" />
<div class="roundy pull-center text-center mw-collapsible${collapsed} width-xl-55 width-md-75 width-sm-100" style="${bg} padding: 0.5ex; padding-bottom: 0.01ex;">
<div class="roundy text-center ${text}" style="font-weight: bold; margin-bottom: 0.5ex;">[[MT]] nelle varie generazioni</div>
<div class="mw-collapsible-content">${mtGens}
</div></div>
[[Categoria:Mosse Macchina]]]=],
    GEN_BOX = [=[
<div class="roundy text-center pull-center text-small" style="${bg} width: ${wd}; padding: 0.5ex; margin-bottom: 0.5ex;">
${listmt}${listmn}${listdt}
</div>]=],
    LIST_BOX = [=[
<div class="black-text" style="margin-top: 2px; font-weight: bold;">[[${kind}]] di [[${gen} generazione]]</div>
<div class="${roundy}" style="background: #eaeaea; margin-bottom: 2px; padding: 0px 2px;">${list}</div>
]=],
}

--[[

A partire da una lista di MT/MN del Modulo:Machines/data,
ritorna una stringa che contiene i link a
tutte le mosse in essa contenuta

--]]

local function makeMachinesList(list)
    local mapped = tab.map(list, function(move, num)
        num = string.format("%02d", num)
        if type(move) == "table" then
            return txt.interp("${num} (${games})", {
                num = num,
                games = table.concat(
                    tab.map(move, function(movegame)
                        local games, locmove = movegame[1], movegame[2]
                        games = mw.text.split(games, " ")
                        local keyGame = table.remove(games, 1)

                        return links[keyGame .. "Lua"]({
                            games = games,
                            multigen.getGenValue(moves[locmove].name),
                        })
                    end),
                    " | "
                ),
            })
        else
            return txt.interp("[[${mv}|${num}]]", {
                mv = multigen.getGenValue(moves[move].name),
                num = num,
            })
        end
    end)
    if mapped[0] then
        return mapped[0] .. " | " .. table.concat(mapped, " | ")
    else
        return table.concat(mapped, " | ")
    end
end

--[[

Ritorna un div che contente le MT e MN
di una certa generazione.
width è opzionale, default 65%

--]]

local function MTGen(gen, width)
    return txt.interp(strings.GEN_BOX, {
        --bg = css.horizGradLua{type = gens[gen].region},
        bg = txt.interp("background: #{{#invoke: colore | ${color} | light}};", {
            color = gens[gen].region,
        }),
        wd = width or "65%",
        gen = gens[gen].ext,
        listmt = txt.interp(strings.LIST_BOX, {
            kind = "MT",
            roundy = (machines[gen].MN or machines[gen].DT) and ""
                or "roundybottom",
            list = makeMachinesList(machines[gen].MT),
            gen = gens[gen].ext,
        }),
        listmn = machines[gen].MN and txt.interp(strings.LIST_BOX, {
            kind = "MN",
            roundy = "roundybottom",
            list = makeMachinesList(machines[gen].MN),
            gen = gens[gen].ext,
        }) or "",
        listdt = machines[gen].DT and txt.interp(strings.LIST_BOX, {
            kind = "DT",
            roundy = "roundybottom",
            list = makeMachinesList(machines[gen].DT),
            gen = gens[gen].ext,
        }) or "",
    })
end

--[[

Come il template MT compatto:
Prende in input il nome della pagina e restituisce la
tabella contenente le sottotabelle delle generazioni
in cui la mossa è un'MT o MN

--]]

m.MTCompatto = function(frame)
    local params = w.trimAndMap(frame.args, string.lower)
    local gens = {}
    local color
    local move = params[1] or mw.getCurrentTitle().text
    local moveData = moves[move]

    if not moveData then
        move = mw.text.decode(move)
        moveData = moves[move]
    end

    if moveData then
        color = multigen.getGenValue(moveData.type)
        for gen, genMc in ipairs(machines) do
            if tab.deepSearch(genMc, move) then
                table.insert(gens, MTGen(gen, "auto"))
            end
        end
    else
        color = params.tipo or "pcwiki"
        gens = mw.text.split(params[1], "", true)
        table.sort(gens)
        gens = tab.map(gens, function(gen)
            return MTGen(tonumber(gen), "auto")
        end)
    end

    return txt.interp(strings.MAIN_BOX, {
        bg = css.horizGradLua({ type = color }),
        collapsed = #gens > 1 and " mw-collapsed" or "",
        mtGens = table.concat(gens),
        text = cc.forModGradBgLua(color),
    })
end

m.MTGen = function(frame)
    local params = w.trimAll(frame.args)
    return MTGen(tonumber(params[1]), params.width)
        .. "[[Categoria:Mosse Macchina]]"
end

return m
