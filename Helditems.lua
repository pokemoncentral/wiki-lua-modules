--[[

This module build the box containing held items of a Pokémon
to put it in its page.

To use it just type in a Pokémon page:
{{#invoke: helditems | helditems }}

It is also possible to pass explicitly a Pokémon name:
{{#invoke: helditems | helditems | Staraptor }}

or a form, both with and without the name:
{{#invoke: helditems | helditems | Raticate | form = 'A' }}
{{#invoke: helditems | helditems | form = 'A' }}

--]]

local h = {}

local mw = require('mw')

local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local bag = require('Bag')
local css = require('Css')
local gcl = require('GamesColorLinks')
local wdata = require("Wikilib-data")
local c = require("Colore-data")
local pokes = require("Poké-data")
local items = require("PokéItems-data")
local sigle = require("Sigle-data")
local gendata = require("Gens-data")
local sup = require("Sup-data")

local STRINGS = {
    header = [=[
<div class="text-center">
<div class="roundy inline-block" style="padding: 1ex 1ex 0.5ex 1ex; ${bg}">
]=],
    footer = "</div></div>",

    genheader = [=[
{| class="roundy width-xl-100" style="${bg} padding: 0.5ex; margin-bottom: 0.5ex;"
! rowspan="10" style="width: 2em;" | [[${genname} generazione|<span style="color: #${gencolor};">${gennum}</span>]]
]=],

    col1double1 = [=[
! class="roundy-15" colspan="${cs}" style="width: 10em; ${bg}" | <span class="inline-block width-xl-50">${link1}</span><span class="inline-block width-xl-50">${link2}</span>
]=],
    col1double2 = [=[
! class="roundyleft-15" style="width: 5em; ${bg1}" | ${link1}
! class="roundyright-15" style="width: 5em; ${bg2}" | ${link2}
]=],
    col1single = [=[
! class="roundy-15" colspan="${cs}" style="width: 10em; ${bg}" | ${link}
]=],

    col2 = [=[
| class="roundy-15 white-bg" rowspan="${rs}" | ${items}
]=],

    item = [=[${img} [[${itemname}]] (${perc})]=],
}


local games = {
    { {"R", "B"}, {"G"} },
    { {"O", "A"}, {"C"} },
    { {"Ru", "Z"}, {"S"}, {"RF", "VF"} },
    { {"D", "P"}, {"Pt"}, {"HG", "SS"} },
    { {"N", "Bi"}, {"N2", "B2"} },
    { {"X", "Y"}, {"RO", "ZA"} },
    { {"So", "L"}, {"US", "UL"} },
}

--[[

Given either a number or a table of percentages and the corresponding list of
games, returns the text of the percentage.

--]]
local makePerc = function(perc, gs)
    if type(perc) == "number" then
        return tostring(perc) .. "%"
    end
    return table.concat(table.map(gs, function(g, idx)
        return table.concat{perc[idx], "%", sup[g]}
    end), "/")
end

--[[

Given an abbr returns a table in which it's possible to serach for the abbrs
of the single games that make up the abbr

TODO: make something that really does it, not this shit

--]]
local diffgame = { "rubino", "bianco", "rubinoomega", "zaffiroalpha", "sole",
                    "ultrasole", "ultraluna" }
local diffabbr = { "Ru", "Bi", "RO", "ZA", "So",
                    "US", "UL" }
local splitForms = function(abbr)
    return table.flatMap(sigle[abbr], function(sigdata)
        return table.map(sigdata.display, function(t)
            local i = table.search(diffgame, t[2])
            if i then
                return diffabbr[i]
            else
                return t[1]
            end
        end)
    end)
end

--[[

Given infos for a generation from PokéItems-data build a box for that gen.

--]]
local maketab = function(info, gen)
    -- First stage: change the structure of informations.
    -- It produces a table matching games[gen]. This table has an element for
    -- each element of games[gen], that is a table. This table has an index
    -- "colors" with associated a list of a boolean for each game of the
    -- corresponding elements of games[gen], specifying whether that games
    -- should be black or color abbrev. Moreover that table is a list of pairs,
    -- each corresponding to an held item, with the first element being the
    -- name of the item and the second being the percentage. The percentage can
    -- be either a single number or a table, with a number for each game
    -- representing the percentage of each game.

    -- For instance, the table produced for Magby, that can hold the Magmatore
    -- with 5% in D and Pt but with 50% in P, and that can be found only in DP
    -- (not in Pt or HGSS) is:
    -- {
    --     { colors = {true, true}, {"Magmatore", {5, 50}} },  -- DP
    --     { colors = {false}, {"Magmatore", 5} },             -- Pt
    --     { colors = {false, false} }                         -- HGSS
    -- }

    local tempdata = table.map(games[gen], function(gamelist)
        -- gamelist = {"US", "UL"}
        local res = { }
        local colors = table.map(gamelist, function() return false end)
        for _, v in ipairs(info) do
            for i, game in pairs(gamelist) do
                -- v.games = {'SL', 'UsUl'}
                -- game = "So"
                local gidx = table.deepSearch(table.map(v.games, splitForms), game)
                if gidx then
                    -- If the abbr correspond to abbrTypes 'black' (or no
                    -- abbrTypes) the game should be colored (true)
                    if not v.abbrTypes or v.abbrTypes[gidx] == 'black' then
                        colors[i] = true
                    end
                    -- Add the item to the game's list
                    local iidx = table.deepSearch(res, v.item)
                    if iidx then
                        res[iidx][2][i] = v.perc
                    else
                        table.insert(res, { v.item, { [i] = v.perc } })
                    end
                end
            end
        end

        -- Takes any list of percentages in res that are all the same and
        -- flatten them to a single number
        res = table.map(res, function(item)
            -- item = {"Magmatore", {5, 50}}
            local p0 = item[2][1]
            if table.all(item[2], function(p) return p == p0 end) then
                item[2] = p0
            end
            return item
        end, ipairs)
        res.colors = colors

        return res
    end)

    -- To print the first column the program need the colspan
    local cs = "1"
    if not table.all(tempdata, function(d)
            return #d.colors == 1 or (d.colors[1] == d.colors[2])
        end) then
        cs = "2"
    end
    -- Firstcol is a list of strings, that are the WikiCode of the game's cells
    local firstcells = table.mapToNum(games[gen], function(gamelist, idx)
        -- gamelist = {"O", "A"}
        local data = tempdata[idx]
        -- data = { colors = {false, false}, {"Bacca Bruciata", 2}, {"Bacca Bruciata", 23} },

        -- If the Pokémon isn't available in any game, filters out the row
        if not table.any(data.colors, function(b) return b end) then
            return nil
        end

        -- String that should be used for the first column
        local color1 = sigle[gamelist[1]][1].display[1][2]
        local color2 = gamelist[2] and sigle[gamelist[2]][1].display[1][2] or nil
        local text1 = table.search(wdata.whitetext, color1) and "fff" or "000"
        local text2 = table.search(wdata.whitetext, color2) and "fff" or "000"
        if #gamelist == 1 then
            return string.interp(STRINGS.col1single, {
                bg = css.horizGradLua{ type = color1 },
                link = gcl[gamelist[1]]{args={text1}},
                cs = cs
            })
        elseif data.colors[1] and data.colors[2] then
            return string.interp(STRINGS.col1double1, {
                bg = css.horizGradLua{ type1 = color1, type2 = color2 },
                link1 = gcl[gamelist[1]]{args={text1}},
                link2 = gcl[gamelist[2]]{args={text2}},
                cs = cs
            })
        else
            return string.interp(STRINGS.col1double2, {
                bg1 = data.colors[1]
                    and css.horizGradLua{ type = color1 }
                    or "background: #fff;",
                bg2 = data.colors[2]
                    and css.horizGradLua{ type = color2 }
                    or "background: #fff;",
                link1 = gcl[gamelist[1]]{args={data.colors[1] and text1 or c[color1].dark}},
                link2 = gcl[gamelist[2]]{args={data.colors[2] and text2 or c[color2].dark}},
            })
        end
    end, ipairs)

    -- Secondcol is a list of strings, that are the content of the second
    -- column's cells
    local secondcells = table.mapToNum(games[gen], function(gamelist, idx)
        -- gamelist = {"O", "A"}
        local data = tempdata[idx]
        -- data = { colors = {false, false}, {"Bacca Bruciata", 2}, {"Bacca Bruciata", 23} },

        -- If the Pokémon isn't available in any game, filters out the row
        if not table.any(data.colors, function(b) return b end) then
            return nil
        end

        return table.concat(table.map(data, function(it)
            return string.interp(STRINGS.item, {
                img = gen < 3 and "" or bag.bagLua(it[1]),
                itemname = it[1],
                perc = makePerc(it[2], gamelist),
            })
        end, ipairs), " ")
    end, ipairs)
    -- Remove the entire generation if nothing has to be shown
    if #secondcells == 0 then
        return nil
    end

    -- Check for equal consecutive second columns and increment the rowspan
    local secondcells1 = { }
    local lastidx = 1
    for k, v in ipairs(secondcells) do
        if k == 1 then
            table.insert(secondcells1, { items = v, rs = 1 })
            lastidx = 1
        elseif v == secondcells1[lastidx].items then
            secondcells1[lastidx].rs = secondcells1[lastidx].rs + 1
            table.insert(secondcells1, {})
        else
            table.insert(secondcells1, { items = v, rs = 1 })
            lastidx = k
        end
    end

    local rows = table.zip(firstcells, table.map(secondcells1, function(v)
        if v.items then
            return string.interp(STRINGS.col2, v)
        else
            return ""
        end
    end), function(a, b) return a .. b end)

    local genheader = string.interp(STRINGS.genheader, {
        genname = string.fu(gendata[gen].ext),
        gennum = gendata[gen].roman,
        gencolor = c[gendata[gen].region].dark,
        bg = css.horizGradLua{type = gendata[gen].region},
    })

    return table.concat{genheader, table.concat(rows, "|-\n"), "|}"}
end

h.helditems = function(frame)
    local p = w.trimAll(mw.clone(frame.args))

    local pokename = string.lower(p[1] or mw.title.getCurrentTitle().text)
    if p.form then
        pokename = (type(pokename) == "number" and string.tf(pokename)
                    or pokename) .. p.form
    end
    local pokedata = multigen.getgen(pokes[pokename])
    local helddata = items[pokename]

    -- global box
        -- a box for each element of helddata (map)
            -- a row (more or less) for each game with "black"
    local body = table.concat(table.mapToNum(helddata, maketab, ipairs), "\n")
    local header = string.interp(STRINGS.header, {
        bg = css.horizGradLua{type1 = pokedata.type1, type2 = pokedata.type2}
    })

    return table.concat{header, body, STRINGS.footer}
end

return h
