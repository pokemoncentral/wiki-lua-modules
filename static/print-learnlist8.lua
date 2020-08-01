--[[

Script to build learnlist-entry calls from pokemoves-data

--]]

-- package.path = "../?.lua;" .. package.path

local p = {}

local tab = require("Wikilib-tables")  -- luacheck: no unused
local str = require("Wikilib-strings") -- luacheck: no unused
local learnlib = require('Wikilib-learnlists')
local wlib = require('Wikilib')
local genlib = require('Wikilib-gens')
local multigen = require('Wikilib-multigen')
local formlib = require('Wikilib-forms')
local learnlist = require('static.learnlist')
local moves = require("Move-data")
local pokes = require("Poké-data")
local altdata = require("AltForms-data")
local pokemoves = require("static.pokemoves-data")

p.strings = {
    HF = "{{#invoke: Learnlist/hf | ${kind}${hf} | ${poke} | ${type1} | ${type2} | ${genh} | ${genp} }}",
    NULLENTRY = "{{#invoke: Learnlist/entry8 | ${kind}null}}",
    ENTRYHEAD = "{{#invoke: render | render | Modulo:Learnlist/entry8 | ${kind} | //",
    ENTRYFOOT = "}}",
    ENTRIES = {
        level = "|${move}|${STAB}|${notes}|${level}| //",
        tm = "|${move}|${STAB}|${notes}|${tmnum}| //",
        breed = "|${parents}|${move}|${STAB}|${notes}| //",
        tutor = "|${move}|${STAB}|${notes}|${spscyn}|${iayn}| //",
        preevo = "|${move}|${STAB}|${poke1}${poke2} //",
    }
}
p.strings.HEADER = string.interp(p.strings.HF, { hf = "h" })
p.strings.FOOTER = string.interp(p.strings.HF, { hf = "f" })


--[[

Add header and footer for a learnlist table.
Arguments:
    - body: body of the learnlist, to enclose between header and footer
    - poke: Pokémon name or ndex
    - gen: the generation of this entry
    - kind: kind of entry. Either "level", "tm", "breed", "tutor", "preevo" and
            "event".

--]]
p.addhf = function(body, poke, gen, kind)
    local name, abbr = formlib.getnameabbr(poke)
    local pokedata = multigen.getGen(pokes[poke], gen)
    -- Interp of concat because the interp data are used twice
    return string.interp(table.concat({
        p.strings.HEADER,
        body,
        p.strings.FOOTER,
    }, "\n"), {
        -- "{{#invoke: learnlist-hf | ${kind}${hf} | ${poke} | ${type1} | ${type2} | ${genh} | ${genp} }}",
        kind = kind,
        poke = pokedata.name,
        type1 = pokedata.type1,
        type2 = pokedata.type2,
        genh = gen,
        genp = (abbr ~= "base" and abbr ~= "") and genlib.getGen.game(altdata[name].since[abbr])
               or genlib.getGen.ndex(pokedata.ndex),
    })
end


--[[

Internal function of genericEntry. Used when taking data not from the data
module (ie: learnlist after base SpSc)

Arguments:
    - poke: Pokémon name or ndex
    - gen: the generation of this entry
    - kind: kind of entry. Either "level", "tm", "breed", "tutor", "preevo" and
            "event". Also used to select functions (picks the funcDict)
    - pmkind: the (possibly fake) entry of the data module

--]]
p._entryGeneric = function(poke, gen, kind, pmkind)
    local funcDict = p.dicts[kind]
    local res = {}
    if pmkind and pmkind[gen] then
        res = funcDict.dataMap(pmkind[gen], function(v, k)
            return funcDict.processData(poke, gen, v, k)
        end)
    end
    local resstr
    if #res == 0 then
        resstr = p.strings.NULLENTRY
    else
        table.sort(res, funcDict.lt)
        resstr = wlib.mapAndConcat(res, "\n", function(val)
            return funcDict.makeEntry(poke, gen, val)
        end)
        resstr = table.concat({
            p.strings.ENTRYHEAD,
            resstr,
            p.strings.ENTRYFOOT,
        }, "\n")
    end

    return p.addhf(resstr, poke, gen, kind)
end

--[[

General function to build a call. Copied from Learnlist module.

Arguments:
    - poke: Pokémon name or ndex
    - gen: the generation of this entry
    - kind: kind of entry. Either "level", "tm", "breed", "tutor", "preevo" and
            "event". Also used to select functions (picks the funcDict)

--]]
p.entryGeneric = function(poke, gen, kind)
    local pmkind = pokemoves[poke][kind]

    return p._entryGeneric(poke, gen, kind, pmkind)
end

-- Fixing dicts (just printing)
p.dicts = learnlist.dicts

--[[

makeEntry: create the string of an entry from an element produced by processData.
    Takes three arguments:
        - poke: Pokémon name or ndex
        - gen: the generation of this entry
        - entry: the element produced by processData

--]]
p.dicts.level.makeEntry = function(poke, gen, pair)
    local move, levels = unpack(pair)
    if #levels ~= 1 then
        print("-------------> ERROR")
        return "-------------> ERROR"
    end
    return string.interp(p.strings.ENTRIES.level, {
        move = multigen.getGenValue(moves[move].name, gen),
        STAB = learnlib.computeSTAB(poke, move, nil, gen),
        notes = "",
        level = string.fu(levels[1]),
    })
end

p.dicts.tm.makeEntry = function(poke, gen, val)
    local move, tmnum, games = unpack(val)

    if games ~= "" then
        print("-------------> ERROR")
        return "-------------> ERROR"
    end
    return string.interp(p.strings.ENTRIES.tm, {
        move = multigen.getGenValue(moves[move].name, gen),
        STAB = learnlib.computeSTAB(poke, move, nil, gen),
        notes = "",
        tmnum = table.concat(tmnum),
    })
end

p.dicts.tutor.makeEntry = function(poke, gen, val)
    -- val :: { <movename>, { <array of games pairs { <abbr>, "Yes"/"No" }> } }
    local move = val[1]
    local gamesarray = val[2]

    if #gamesarray ~= 2 then
        print("-------------> ERROR")
        return "-------------> ERROR"
    end
    -- return "-------------> ERROR2"
    return string.interp(p.strings.ENTRIES.tutor, {
        move = multigen.getGenValue(moves[move].name, gen),
        STAB = learnlib.computeSTAB(poke, move, nil, gen),
        notes = "",
        spscyn = gamesarray[1][2]:lower(),
        iayn = gamesarray[2][2]:lower(),
    })
end

p.dicts.breed.makeEntry = function(poke, gen, val)
    -- val :: { <movename>, { <array of parents> }, <notes> }
    local move = val[1]
    local parents = val[2]

    -- Removes the tt from notes
    local notes = val[3]:gsub('<span class="explain tooltips" title="([%w%s]*)">%*</span>', "%1")

    if #parents == 0 then
        print("-------------> ERROR")
        return "-------------> ERROR"
    end
    parents = wlib.mapAndConcat(parents, function(ndex)
        ndex = type(ndex) == "number" and string.tf(ndex) or ndex
        return table.concat{ "#", ndex, "#" }
    end)

    return string.interp(p.strings.ENTRIES.breed, {
    -- "|${parents}|${move}|${STAB}|${notes}| //",
        move = multigen.getGenValue(moves[move].name, gen),
        STAB = learnlib.computeSTAB(poke, move, nil, gen),
        notes = notes,
        parents = parents,
    })
end

local function makePreevoPoke(pair)
    local t = { string.tf(pair[1]), "|" }
    if pair[2] then
        table.insert(t, pair[2])
        table.insert(t, "|")
    end
    return table.concat(t)
end

p.dicts.preevo.makeEntry = function(poke, gen, val)
    -- val :: { <movename>, { <array of preevo pairs { ndex, notes }> } }
    local move = val[1]
    local preevos = val[2]

    if #preevos < 1 or #preevos > 2 then
        print("-------------> ERROR")
        return "-------------> ERROR"
    end
    return string.interp(p.strings.ENTRIES.preevo, {
        move = multigen.getGenValue(moves[move].name, gen),
        STAB = learnlib.computeSTAB(poke, move, nil, gen),
        poke1 = makePreevoPoke(preevos[1]),
        poke2 = preevos[2] and makePreevoPoke(preevos[2]) or "",
    })
end


p.level = function(poke)
    return p.entryGeneric(poke, 8, "level")
end
p.tm = function(poke)
    return p.entryGeneric(poke, 8, "tm")
end
p.breed = function(poke)
    return p.entryGeneric(poke, 8, "breed")
end
p.tutor = function(poke)
    return p.entryGeneric(poke, 8, "tutor")
end
p.preevo = function(poke)
    return p.entryGeneric(poke, 8, "preevo")
end

return p
