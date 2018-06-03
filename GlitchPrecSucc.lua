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

local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local css = require('Css')
local data = require("Wikilib-data")
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
	return string.interp([=[
<div class="roundy-20" style="${bg} margin: 1ex 0;">
<div class="inline-block width-xl-40 width-xs-50 text-right"><span class="inline-block width-xl-10 width-xs-20">[[${namePrev}|<span style="color:#000">&larr;</span>]]</span><span class="inline-block width-xl-10 hidden-xs">${sprPrev}</span><span class="inline-block width-xl-80" style="padding: 0 1em; box-sizing: border-box;">[[${namePrev}|<span style="color:#000">#${prev}: ${displayPrev}</span>]]</span></div><div class="inline-block text-center width-xl-20 hidden-xs">[[Elenco Pokémon Glitch|<span style="color:#000">${name}</span>]]</div><div class="inline-block width-xl-40 width-xs-50"><span class="inline-block width-xl-80" style="padding: 0 1em; box-sizing: border-box;">[[${nameNext}|<span style="color:#000">#${nxt}: ${displayNext}</span>]]</span><span class="inline-block width-xl-10 hidden-xs">${sprNext}</span><span class="inline-block width-xl-10 width-xs-20">[[${nameNext}|<span style="color:#000">&rarr;</span>]]</span></div>
</div>]=],
{
    bg = css.horizGradLua{type1 = tipo1, type2 = tipo2},
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
arg={'Missingno.', 'RB'}
print(m.glitchPrecSucc{args={arg[1], game = arg[2]}})

-- return m
