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

- RB
- G
- OA
- C
- RZS
- RFVF
- 4
- 5
- 6

--]]

local m = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local c = require('Colore-data')
local data = require('Wikilib-data')
-- Glitch/data should stay require, mw.loadData messes with table library
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
    local contiguos = true
    for k = 1, #hexes - 1 do
        if hexes[k] + 1 ~= hexes[k + 1] then
            continguos = false
            break
        end
    end

    if contiguos then
        return table.concat{printHex.number(hexes[1]),
                '-', printHex.number(hexes[#hexes])}
    end

    for k, hex in ipairs(hexes) do
        hexes[k] = printHex.number(hex)
    end
    return table.concat{'<span class="explain" title="',
            table.concat(hexes, ', '), '">Vari</span>'}
end

--[[

Funzione di interfaccia per il WIkicode:
crea la barra mediante interpolazione di stringhe

--]]

m.GlitchPrecSucc = function(frame)
    local glitch = string.trim(frame.args[1])
    local game = tonumber(frame.args.game) or string.trim(frame.args.game):upper()

    local glitchIndex
    if glitches[game] then
        glitchIndex = table.deepSearch(glitches[game], glitch)
    else
        game, glitchIndex = table.deepSearch(glitches, glitch)
    end
    game = glitches[game]

    local tipo1 = game[glitchIndex].type1
    local tipo2 = game[glitchIndex].type2 or tipo1
    
    local size = table.getn(game)
    local prev = (glitchIndex - 2 + size) % size + 1
	local nxt = glitchIndex % size + 1
    return string.interp([=[{| class="roundy" style="background: #${bg}; border: 3px solid #${bd}; margin-bottom: 5px; margin-top: 5px; width: 100%;"
| class="roundyleft text-right" style="padding-right: 3px; width: 45%; background: #${cells};" | [[${namePrev}|<span style="color:#000">&larr;</span>]]${sprPrev}<span style="display: inline-block; width: 70%;">[[${namePrev}|<span style="color:#000">#${prev}: ${displayPrev}</span>]]</span>
| class="text-center" style="padding: 0 3px; background: #${cells};" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">${name}</span>]]
| class="roundyright text-left" style="padding-left: 3px; width: 45%; background: #${cells};" | <span style="display: inline-block; width: 70%;">[[${nameNext}|<span style="color:#000">#${nxt}: ${displayNext}</span>]]</span>${sprNext}[[${nameNext}|<span style="color:#000">&rarr;</span>]]
|}]=],
{
    bg = c[tipo1].normale,
    bd = tipo1 == tipo2 and c[tipo2].dark or c[tipo2].normale,
    cells = c[tipo1].light,
    namePrev = game[prev].name,
    sprPrev = not game[prev].spr:find('%.') and game[prev].spr
			or table.concat{'[[File:', game[prev].spr, ']]'},
    prev = printHex[type(game[prev].hex)](game[prev].hex),
    displayPrev = game[prev].displayName or game[prev].name,
    name = game[glitchIndex].name,
    nameNext = game[nxt].name,
    nxt = printHex[type(game[nxt].hex)](game[nxt].hex),
    displayNext = game[nxt].displayName or game[nxt].name,
    sprNext = not game[nxt].spr:find('%.') and game[nxt].spr
			or table.concat{'[[File:', game[nxt].spr, ']]'}
})
end

m.glitchprecsucc, m.glitchPrecSucc = m.GlitchPrecSucc, m.GlitchPrecSucc

return m
