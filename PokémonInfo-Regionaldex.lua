--[[

Module to compute regional dex in PokémonInfo

--]]

local rdex = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local links = require('Links')
local dex = require("Dex-data")
local c = require("Colore-data")
local sup = require("Sup-data")
-- stylua: ignore end

--[[

Returns the regional dex of a Pokémon in the given oldDex. It returns either
the rdex number or nil.

-- ]]
local function getOldDex(newRdex, oldDexTable, changedDexTable)
    if changedDexTable and changedDexTable[newRdex] then
        return changedDexTable[newRdex]
    end
    for subtract, rdex in ipairs(oldDexTable) do
        if rdex == newRdex then
            return nil
        elseif rdex > newRdex then
            return newRdex - subtract + 1
        end
    end
    return newRdex - tab.getn(oldDexTable)
end

-- Aggiunge un title al primo argomento costituito
-- dal secondo e dal terzo separati da uno spazio

local function addtt(newDex, oldDex, title)
    return txt.interp(links.tt(newDex, oldDex .. title))
end

-- Inserisce le informazioni relative al vecchio dex
-- regionale: per Sinnoh un sup di platino, per le
-- altre un title

local insOld = {}

insOld.johto = function(newDex, oldDex)
    return addtt(newDex, oldDex, " in seconda generazione")
end

insOld.hoenn = function(newDex, oldDex)
    return addtt(newDex, oldDex, " in terza generazione")
end

insOld.sinnoh = function(newDex, oldDex)
    return newDex .. sup.Pt
end

insOld.unima = function(newDex, oldDex)
    return addtt(newDex, oldDex, " in Nero e Bianco")
end

insOld.alola = function(newDex, oldDex)
    return addtt(newDex, oldDex, " in Sole e Luna")
end

-- Ordina la tabella store: la table è esterna alla
-- funzione così da non essere ricreata ogni volta
local regiongens = {
    Kanto = { ord = 1, nfig = 3 },
    Johto = { ord = 2, nfig = 3 },
    Hoenn = { ord = 3, nfig = 3 },
    Sinnoh = { ord = 4, nfig = 3 },
    Unima = { ord = 5, nfig = 3 },
    Kalos = { ord = 6, nfig = 3 },
    Alola = { ord = 7, nfig = 3 },
    Galar = { ord = 8, nfig = 3 },
    Armatura = { ord = 9, pref = "", nfig = 3 },
    Corona = { ord = 10, pref = "", nfig = 3 },
    Hisui = { ord = 11, nfig = 3 },
    Paldea = { ord = 12, nfig = 0 },
}

local function region_sort(c, d)
    local a, b = c:match(">(%a+)</span>"), d:match(">(%a+)</span>")
    return regiongens[a].ord < regiongens[b].ord
end

-- Format a numeric ndex with right number of leading zeros for the given region
local function regionNdexFormat(region, ndex)
    return txt.nFigures(ndex, regiongens[txt.fu(region)].nfig)
end

local STRINGS = {
    base = [=[<span><div class="small-font">'''[[Elenco Pokémon secondo il Pokédex ${pref}${reg}|<span class="black-text">${reg}</span>]]'''</div>#${rdex}</span>]=],
    kalos = [=[<span><div class="small-font">'''[[Elenco Pokémon secondo i Pokédex di Kalos#Pokédex di Kalos ${reg}|<span style="color:#${c}">Kalos</span>]]'''</div>#${ttdex}</span>]=],
}

--[[

La funzione che genera le celle per i dex regionali:
nello scorrere la tabella fornita dalla search,
controlla che il dex non sia tra quelli aggiornati in seguito
ed effettua l'inserimento; se ciò non accade, concatena all'ultimo
elemento l'asterisco giusto chiamando la funzione olddex.

--]]
local function dexlist(dexes)
    if tab.getn(dexes) == 0 then
        return "In nessun Pokédex regionale"
    end
    local store = {}
    for region, rdex in pairs(dexes) do
        if region:find("kalos") then
            local rdexFigures = regionNdexFormat("kalos", rdex)
            local zone = region:match("kalos(%a+)$")
            table.insert(
                store,
                txt.interp(STRINGS.kalos, {
                    c = c["kalos" .. zone].normale,
                    ttdex = links.tt(rdexFigures, zone),
                    reg = zone,
                })
            )
        else
            local oldDexTable = dex.added[region]
            local rdexFigures = regionNdexFormat(region, rdex)
            if oldDexTable then
                local oldDex = getOldDex(rdex, oldDexTable, dex.changed[region])
                if oldDex ~= rdex then
                    local oldDexText = oldDex
                            and regionNdexFormat(region, oldDex)
                        or "Non disponibile"
                    rdexFigures = insOld[region](rdexFigures, oldDexText)
                end
            end
            local regionName = txt.fu(region)
            table.insert(
                store,
                txt.interp(STRINGS.base, {
                    reg = regionName,
                    pref = regiongens[regionName].pref or "di ",
                    rdex = rdexFigures,
                })
            )
        end
    end
    table.sort(store, region_sort)
    for k, v in ipairs(store) do
        store[k] = v
    end
    if #store > 5 then
        table.insert(
            store,
            1 + math.floor(#store / 2),
            '<div class="width-xl-100"></div>'
        )
    end
    return table.concat(store)
end

-- Semplicemente cerca tra tutti i dex se si trova il numero di dex
-- nazionale fornito: in caso positivo, lo inserisce come elemento
-- di una table con indice il nome della regione. Se una certa regione
-- ha più dex regionali (es: alola) inserisce come valore una table
-- contenente il numero di dex nazionale

local function search(ndex)
    local dexes = {}
    for region, regionalDex in pairs(dex) do
        if region ~= "added" and region ~= "changed" then
            local rdex = tab.search(regionalDex, ndex)
            if rdex then
                dexes[region] = rdex
            end
        end
    end
    return dexes
end

--[[

WikiCode interface. Takes a single argument, that is the numeric ndex of the
Pokémon, and computes the list of regional dexes.

--]]
rdex.regionaldex = function(frame)
    local ndex = tonumber(frame.args[1]) or 0
    return dexlist(search(ndex))
end

rdex.Regionaldex, rdex.RegionalDex = rdex.regionaldex, rdex.regionaldex

return rdex
