--[[

La barra per scorrere sequenzialmente in ordine di
indice esadecimale i Pokémon glitch di uno stesso
gioco o generazione.

La chiamata base è questa:

{{#invoke: GlitchPrecSucc | GlitchPrecSucc | nomePokémon }}

Tuttavia, se il Pokémon glitch non ha un nome
univoco tra i Pokémon glitch di tutte le generazioni,
è necessario specificare il gioco/generazione
nel parametro game. Per esempio:

{{#invoke: GlitchPrecSucc | GlitchPrecSucc | nomePokémon | game = RZS}}

I valori riconosciuti del parametro game sono i seguenti:

RB, G, OA, C, RZS, RFVF, 4, 5, 6

--]]

local m = {}

local mw = require('mw')

local txt = require('Wikilib-strings')  -- luacheck: no unused
local tab = require('Wikilib-tables')  -- luacheck: no unused
local links = require('Links')
local prevnext = require('PrevNext')
local glitches = require('Glitch-data')

--[[

Ogni funzione di questa table stampa un
esadecimale in base al tipo dell'argomento

--]]

local printHex = {}

-- Ritorna l'esadecimale intatto, poiché già string

printHex.string = function(hex)
    return hex
end

-- Formatta l'esadecimale in maiuscolo su quattro cifre

printHex.number = function(hex)
    return string.format('%04X', hex)
end

--[[

Se la table contiene esadecimali contigui
tra di loro, stampa il primo e l'ultimo
separati da un trattino; in caso contrario
stampa la stringa 'Vari' con un title che
contiene tutti gli esadecimali

--]]

printHex.table = function(hexes)
    local contiguous = true
    for k = 1, #hexes - 1 do
        if hexes[k] + 1 ~= hexes[k + 1] then
            contiguous = false
            break
        end
    end

    if contiguous then
        return table.concat{printHex.number(hexes[1]),
                '-', printHex.number(hexes[#hexes])}
    end

    for k, hex in ipairs(hexes) do
        hexes[k] = printHex.number(hex)
    end
    return links.tt('Vari', table.concat(hexes, ', '))
end

--[[

Funzione di interfaccia per il WIkicode:
crea la barra mediante interpolazione di stringhe

--]]

m.GlitchPrecSucc = function(frame)
    local glitch = mw.text.decode(string.trim(frame.args[1]))
    local game = tonumber(frame.args.game) or string.trim(frame.args.game):upper()

    local glitchIndex
    if glitches[game] then
        glitchIndex = table.deepSearch(glitches[game], glitch)
    else
        game, glitchIndex = table.deepSearch(glitches, glitch)
    end
    game = glitches[game]

    local tipo1 = game[glitchIndex].type1:gsub(' ', '_')
    local tipo2 = (game[glitchIndex].type2 or tipo1):gsub(' ', '_')

    local size = table.getn(game)
    local prev = (glitchIndex - 2 + size) % size + 1
	local nxt = glitchIndex % size + 1

    return prevnext.PrevNextLua{
        color = tipo1,
        color2 = tipo2,
        series = game[glitchIndex].name,
        list = "Elenco Pokémon Glitch",

        prev = table.concat{"#", printHex[type(game[prev].hex)](game[prev].hex),
                            ": ", game[prev].displayName or game[prev].name
                           },
        prevlink = game[prev].name,
        previmg = not game[prev].spr:find('%.') and game[prev].spr
                      or table.concat{'[[File:', game[prev].spr, ']]'},

        next = table.concat{"#", printHex[type(game[nxt].hex)](game[nxt].hex),
                            ": ", game[nxt].displayName or game[nxt].name
                           },
        nextlink = game[nxt].name,
        nextimg = not game[nxt].spr:find('%.') and game[nxt].spr
                      or table.concat{'[[File:', game[nxt].spr, ']]'},
    }
end

m.glitchprecsucc, m.glitchPrecSucc = m.GlitchPrecSucc, m.GlitchPrecSucc

return m
