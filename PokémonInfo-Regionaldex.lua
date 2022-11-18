-- Modulo da usare nel template PokémonInfo per determinare
-- i dex regionali

local rdex = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local links = require('Links')
local dex = require("Dex-data")
local c = require("Colore-data")
local sup = require("Sup-data")
-- stylua: ignore end

-- Ritorna il dex regionale di un Pokémon nel vecchio
-- dex regionale specificato: nel caso in cui non sia
-- presente, ritorna nil

local getOldDex = function(newDex, oldDexTable, changedDexTable)
    if changedDexTable and changedDexTable[newDex] then
        return txt.tf(changedDexTable[newDex])
    end
    for subtract, ndex in ipairs(oldDexTable) do
        if ndex == newDex then
            return nil
        elseif ndex > newDex then
            return txt.tf(newDex - subtract + 1)
        end
    end
    return txt.tf(newDex - tab.getn(oldDexTable))
end

-- Aggiunge un title al primo argomento costituito
-- dal secondo e dal terzo separati da uno spazio

local addtt = function(newDex, oldDex, title)
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
    Kanto = { ord = 1 },
    Johto = { ord = 2 },
    Hoenn = { ord = 3 },
    Sinnoh = { ord = 4 },
    Unima = { ord = 5 },
    Kalos = { ord = 6 },
    Alola = { ord = 7 },
    Galar = { ord = 8 },
    Armatura = { ord = 9, pref = "" },
    Corona = { ord = 10, pref = "" },
    Hisui = { ord = 11 },
    Paldea = { ord = 12 },
}

local region_sort = function(c, d)
    local a, b = c:match(">(%a+)</span>"), d:match(">(%a+)</span>")
    return regiongens[a].ord < regiongens[b].ord
end

--[[

La funzione che genera le celle per i dex regionali:
nello scorrere la tabella fornita dalla search,
controlla che il dex non sia tra quelli aggiornati in seguito
ed effettua l'inserimento; se ciò non accade, concatena all'ultimo
elemento l'asterisco giusto chiamando la funzione olddex.

--]]
local dexlist = function(dexes)
    if tab.getn(dexes) == 0 then
        return nil
    end
    local store = {}
    local str =
        [=[<span><div class="small-font">'''[[Elenco Pokémon secondo il Pokédex ${pref}${reg}|<span class="black-text">${reg}</span>]]'''</div>#${rdex}</span>]=]
    local kalos =
        [=[<span><div class="small-font">'''[[Elenco Pokémon secondo i Pokédex di Kalos#Pokédex di Kalos ${reg}|<span style="color:#${c}">Kalos</span>]]'''</div>#${ttdex}</span>]=]
    for region, rdex in pairs(dexes) do
        if region:find("kalos") then
            local zone = region:match("kalos(%a+)$")
            table.insert(
                store,
                txt.interp(kalos, {
                    c = c["kalos" .. zone].normale,
                    ttdex = links.tt(rdex, zone),
                    reg = zone,
                })
            )
        else
            local oldDexTable = dex[region .. "Added"]
            if oldDexTable then
                local oldDex = getOldDex(
                    tonumber(rdex),
                    oldDexTable,
                    dex[region .. "Changed"]
                )
                if oldDex ~= rdex then
                    rdex = insOld[region](rdex, oldDex or "Non disponibile")
                end
            end
            local regionName = txt.fu(region)
            table.insert(
                store,
                txt.interp(str, {
                    reg = regionName,
                    pref = regiongens[regionName].pref or "di ",
                    rdex = rdex,
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

local search = function(ndex)
    local dexes = {}
    for region, regionalDex in pairs(dex) do
        local rdex = tab.search(regionalDex, ndex)
        if rdex then
            dexes[region] = txt.three_figures(rdex)
        end
    end
    return dexes
end

--Interfaccia. Riceve un ndex su tre cifre e un tipo, e interpola il colore standard
-- del tipo e la lista dei dex regionali, creata con la funzione dexlist, al box in wikicode

rdex.regionaldex = function(frame)
    local ndex = txt.trim(frame.args[1]) or "000"
    return dexlist(search(ndex)) or "In nessun Pokédex regionale"
end

rdex.Regionaldex, rdex.RegionalDex = rdex.regionaldex, rdex.regionaldex

return rdex
