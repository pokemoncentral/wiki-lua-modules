-- Gli header e i footer per le tabelle dei Pokémon
-- che imparano una data mossa tramite vari metodi

local j = {}

-- stylua: ignore start
local mw = require('mw')

local w = require('Wikilib')
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local multigen = require('Wikilib-multigen')
local mlentry = require('Movelist-entry')
local css = require('Css')
local c = require("Colore-data")
local gendata = require("Gens-data")
local moves = require("Move-data")
local mtdata = require("Machines-data")
local cc = require('ChooseColor')
-- stylua: ignore end

-- Tabelle dati

j.strings = {
    HEADERBASE = [=[
{| class="roundy text-center white-rows roundy-footer no-border-spacing" style="${bg}; padding: 0.3em;"
|- class="${textcolor}"
! class="roundytl hidden-xs" rowspan="${rs}" | #
! rowspan="${rs}" colspan="2" | Pokémon
! class="hidden-sm" rowspan="${rs}" | Tipo
! class="hidden-sm" style="padding: 0 0.7ex;" rowspan="${rs}" | Gruppo Uova
! class="roundytr" colspan="${cs}" | ]=],
    HEADERTM = [=[
! class="roundytop ${textcolor}" style="background: #${bg}; min-width: 4ex; line-height: 1em;" colspan="${cs}" | [[${genl} generazione|${genr}]]<div class="text-small">${tm}</div>
]=],
}

-- Contiene i colspan dell'ultima cella degli headers

local cs = {}
cs.level = function(gen)
    return (gendata.latest + 1 - gen) * 3
end
cs.breed, cs.tm = cs.level, cs.level
cs.event = function()
    return 1
end
cs.tutor = function(gen)
    return gen
end
-- cs.autotm = function(gen)
-- 	-- TODO: compute the right colspan (it may be enough a filter with i >= gen)
-- 	return tab.fold(j.tmcellgames, 0, function(acc, gengames)
-- 		return acc + #gengames
-- 	end, ipairs)
-- end

-- Contiene le sigle e i colori dei giochi delle celle del tutor

local games = {}
games[2] = { { "C", "cristallo" } }
games[3] = { { "RFVF", "rossofuoco" }, { "S", "smeraldo" }, { "XD", "xd" } }
games[4] =
    { { "DP", "diamante" }, { "Pt", "platino" }, { "HGSS", "heartgold" } }
games[5] = { { "NB", "nero" }, { "N2B2", "nero2" } }
games[6] = { { "XY", "x" }, { "RΩZα", "rubinoomega" } }
games[7] =
    { { "SL", "sole" }, { "USUL", "ultrasole" }, { "LGPE", "lgpikachu" } }
games[8] = {
    { "SpSc", "spada" },
    { "IA", "isolaarmatura" },
    { "DLPS", "diamantelucente" },
    { "LPA", "leggendearceus" },
}
games[9] = {}

-- Contiene le varie funzioni che generano le celle

local cells = {}

-- Funzioni di supporto

-- Funzione per generale le celle dei level

cells.level = function(gen)
    local str =
        '! class="roundytop ${textcolor}" style="background: #${bg}; min-width: 4ex;" colspan="${cs}" | [[${genl} generazione|${genr}]]\n'
    local row = {}
    for a = gen, gendata.latest do
        table.insert(
            row,
            txt.interp(str, {
                bg = c[gendata[a].region].normale,
                genl = gendata[a].ext,
                genr = gendata[a].roman,
                cs = mlentry.maxCellsNumber[a],
                textcolor = cc.forModBgLua(gendata[a].region),
            })
        )
    end
    return table.concat(row)
end

-- Genera le celle dei tm

cells.tm = function(gen, tms)
    local str =
        '! class="roundytop ${textcolor}" style="background: #${bg}; min-width: 4ex; line-height: 1em;" colspan="${cs}" | [[${genl} generazione|${genr}]]<div class="text-small">${tm}</div>\n'
    local row = {}
    local l
    for a = gen, gendata.latest do
        l = tms[a] == "NO" and "Ness."
            or txt.interp("[[${tm}|${tm}]]", { tm = tms[a] })
        table.insert(
            row,
            txt.interp(str, {
                bg = c[gendata[a].region].normale,
                genl = gendata[a].ext,
                genr = gendata[a].roman,
                tm = l,
                cs = mlentry.maxCellsNumber[a],
                textcolor = cc.forModBgLua(gendata[a].region),
            })
        )
    end
    return table.concat(row)
end

-- Genera le celle del breed

cells.breed = function(gen)
    local str =
        '! class="roundytop ${textcolor}" style="background: #${bg}; min-width: 4ex" colspan="${cs}" | [[${genl} generazione|${genr}]]\n'
    local row = {}
    for a = gen, gendata.latest do
        table.insert(
            row,
            txt.interp(str, {
                bg = c[gendata[a].region].normale,
                genl = gendata[a].ext,
                genr = gendata[a].roman,
                cs = mlentry.maxCellsNumber[a],
                textcolor = cc.forModBgLua(gendata[a].region),
            })
        )
    end
    return table.concat(row)
end

-- Genera le celle del tutor

cells.tutor = function(gen, gms)
    local str =
        '! class="roundytop ${textcolor}" style="background: #${bg}; min-width: 6ex;" | ${game}\n'
    local row = {}
    for a in ipairs(gms) do
        if gms[a] == "yes" then
            table.insert(
                row,
                txt.interp(str, {
                    bg = c[games[gen][a][2]].normale,
                    game = games[gen][a][1],
                    textcolor = cc.forModBgLua(games[gen][a][2]),
                })
            )
        end
    end
    return table.concat(row)
end

-- Ritorna le prime celle, comuni a tutti gli headers

j.headers = function(tipo, gen, kind)
    return txt.interp(j.strings.HEADERBASE, {
        bg = css.horizGradLua({ type = tipo }),
        textcolor = cc.forModGradBgLua(tipo),
        rs = kind == "event" and 1 or 2,
        cs = cs[kind](gen),
    })
end

-- Interfaccia

-- Mosse apprese per livello

j.levelh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen = p[1] or "pcwiki", tonumber(p[2]) or 0
    return txt.interp(
        [=[${str}Livello
|-
${g}]=],
        { str = j.headers(tipo, gen, "level"), g = cells.level(gen) }
    )
end

j.Levelh = j.levelh

-- Mosse apprese per evento

j.eventh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo = p[1] or "pcwiki"
    return txt.interp(
        [=[${str}Ottenuto in
|-
]=],
        { str = j.headers(tipo, nil, "event") }
    )
end

j.Eventh = j.eventh

-- Mosse apprese per MT

j.tmh = function(frame)
    local p, tms = w.trimAndMap(mw.clone(frame.args), string.lower), {}
    local tipo, gen = p[1] or "pcwiki", tonumber(p[2]) or 0
    for a = 3, 2 + gendata.latest do
        tms[a - 2] = p[a] and string.upper(p[a]) or "No"
    end
    return txt.interp(
        [=[${str}Macchina
|-
${g}]=],
        { str = j.headers(tipo, gen, "tm"), g = cells.tm(gen, tms) }
    )
end

j.TMh, j.Tmh = j.tmh, j.tmh

-- Mosse apprese tramite breeding

j.breedh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen =
        p[1] or "pcwiki", tonumber(p[2]) < 2 and 2 or tonumber(p[2])
    return txt.interp(
        [=[
${str}Padre
|-
${g}]=],
        { str = j.headers(tipo, gen, "breed"), g = cells.breed(gen) }
    )
end

j.Breedh = j.breedh

-- Mosse apprese tramite insegnamosse

j.tutorh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo = p[1] or "pcwiki"
    return txt.interp(
        [=[${str}Gioco
|-
]=],
        { str = j.headers(tipo, tonumber(p[2]) or 0, "tutor") }
    )
end

j.Tutorh = j.tutorh

-- Celle tutor nelle varie gen
for g = 2, 8 do
    j["tutor" .. tostring(g)] = function(frame)
        return cells.tutor(g, w.trimAndMap(mw.clone(frame.args), string.lower))
    end

    j["Tutor" .. tostring(g)] = j["tutor" .. tostring(g)]
end

-- Mosse ombra

j.shadowh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local game = p[1] or "xd"

    local colo = txt.interp(
        '\n! class="roundytop ${textcolor}" style="background: #${bg}; width: 100px;" | [[Pokémon Colosseum|C]]\n',
        { bg = c.colo.normale, textcolor = cc.forModBgLua(c.colo.normale) }
    )
    return txt.interp(
        [=[${str}Livello
|-${colo}
! class="roundytop ${textcolor}" style="background: #${bg}; width: 100px;" | [[Pokémon XD: Tempesta Oscura|XD]]]=],
        {
            str = j.headers(
                "xd",
                game == "colo" and gendata.latest or gendata.latest - 1,
                "level"
            ),
            bg = c.xd.light,
            textcolor = cc.forModBgLua(c.xd.light),
            colo = game == "colo" and colo or "",
        }
    )
end

j.Shadowh = j.shadowh

-- Footer

local function foot(interpData)
    return txt.interp(
        [=[|-
! class="text-small text-left ${textcolor}" colspan="${cs}" |
* I Pokémon in '''grassetto''' sono quelli che ricevono il [[bonus di tipo]] dalla mossa.
* I Pokémon in ''corsivo'' sono quelli con evoluzioni o [[Differenze di forma|forme alternative]] che ricevono il bonus di tipo.${last}
|}]=],
        interpData
    )
end

j.footer = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    return foot({
        cs = 5 + cs.level(1),
        textcolor = cc.forModGradBgLua(p[1] or "Sconosciuto"),
        last = "",
    })
end

-- Footer per le mosse apprese per livello

j.levelf = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    return foot({
        cs = 5 + cs.level(1),
        textcolor = cc.forModGradBgLua(p[1] or "Sconosciuto"),
        last = [=[

* Le mosse segnate al livello "Evo" possono essere apprese al momento dell'evoluzione.
* Le mosse segnate al livello "R" possono essere apprese solo tramite ricordamosse.]=],
    })
end

-- Footer per le mosse apprese per accoppiamento

j.breedf = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    return foot({
        cs = 5 + cs.level(1),
        textcolor = cc.forModGradBgLua(p[1] or "Sconosciuto"),
        last = [=[

* Premendo su ✔ è possibile vedere i genitori da cui il Pokémon può imparare la mossa.]=],
    })
end

-- Divisore generazioni event

j.div = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local gen = tonumber(p[1]) or 0
    local genColor = gendata[gen].region
    return txt.interp(
        [=[

|-
! colspan="6" style="${bg}" | [[${genl} generazione|<span style="color:#${tc}">${genl} generazione</span>]]]=],
        {
            bg = css.horizGradLua({ type = genColor }),
            genl = txt.fu(gendata[gen].ext),
            tc = c[gendata[gen].region].dark,
        }
    )
end

j.Div = j.div

-- ============================ Automatic tm header ===========================
j.autotmhlua = function(move)
    local tipo = multigen.getGenValue(moves[move].type)
    local startgen = moves[move].gen or 1
    local res = {
        j.headers(tipo, startgen, "tm"),
        "Macchine\n|-\n",
    }
    local link
    for g = startgen, gendata.latest do
        local tmkind, tmnum = tab.deepSearch(mtdata[g], move)
        local numFigures = g >= 9 and 3 or 2
        link = tmkind
                and table.concat({
                    "[[",
                    tmkind,
                    txt.nFigures(tmnum, numFigures),
                    "]]",
                })
            or "Ness."
        table.insert(
            res,
            txt.interp(j.strings.HEADERTM, {
                bg = c[gendata[g].region].normale,
                textcolor = cc.forModBgLua(gendata[g].region),
                genl = gendata[g].ext,
                genr = gendata[g].roman,
                tm = link,
                cs = mlentry.maxCellsNumber[g],
            })
        )
    end
    return table.concat(res)
end

-- WikiCode interface for tmhlua: the only (optional) argument is the move
-- name, defaults to {{BASEPAGENAME}}
j.autotmh = function(frame)
    local move = frame.args[1] and txt.trim(frame.args[1])
        or mw.title.getCurrentTitle().text
    move = mw.text.decode(move):lower()
    return j.autotmhlua(move)
end
j.autoTMh, j.Autotmh = j.autotmh, j.autotmh

--[[

WikiCode interface for the allTM row. The first parameter if the move name
(optional, default to {{BASEPAGENAME}}). Named parameters are:
  * genderless: put "yes" if the move can be learned by all Pokémon except
    genderless ones.
  * except: the list of Pokémon who can't learn the move

--]]
j.alltm = function(frame)
    local move = frame.args[1] and txt.trim(frame.args[1])
        or mw.title.getCurrentTitle().text
    local genderless = frame.args.genderless
            and txt.trim(frame.args.genderless) == "yes"
        or false
    local hasExcept = frame.args.except
    local cs = tab.fold(mlentry.maxCellsNumber, 0, function(a, b)
        return a + b
    end)

    return txt.interp(
        [=[ |-
! colspan="${cs}" class="black-text white-bg" style="padding: 0 1ex;" | ''Tutti'' i Pokémon che possono apprendere mosse tramite [[MT]]${genderlesspre} possono imparare ${move}${except}.${exceptCategory}]=],
        {
            cs = cs,
            genderlesspre = genderless and " e hanno un [[sesso]]" or "",
            move = move,
            except = hasExcept
                    and (", eccetto " .. txt.trim(frame.args.except))
                or "",
            exceptCategory = hasExcept
                    and [[Categoria:Mosse Macchina insegnabili a tutti i Pokémon]]
                or "",
        }
    )
end
j.allTM, j.Alltm = j.alltm, j.alltm

return j
