--[[

Modulo di interfaccia per i dati dei Pokémon glitch
(Modulo:Glitch/data), che i template non possono interrogare
direttamente: fornisce il nome della pagina, la miniatura e i tipi
con cui colorare le caselle.

Il modulo dati è indicizzato per gioco o generazione (RB, G, OA, C,
RZS, RFVF, 4, 5, 6): ogni voce riporta l'esadecimale (o gli
esadecimali) con cui il glitch compare nel gioco, che è anche il suo
numero d'indice.

Esempi:

{{#invoke: Glitch | name   | gen = 2 | hex = 000 }}
{{#invoke: Glitch | sprite | gen = 2 | hex = 000 }}
{{#invoke: Glitch | style  | gen = 2 | hex = 000 }}

--]]

local gl = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local css = require('Css')
local colors = require("Colore-data")
local glitches = require("Glitch-data")
-- stylua: ignore end

--[[

Giochi usati come default quando il gioco non è indicato, in base
alla generazione.

--]]

local defaultGames = {
    ["1"] = "RB",
    ["2"] = "OA",
}

--[[

Ritorna l'elenco dei glitch di un gioco, accettando sia la sigla sia
il numero della generazione come chiave.

--]]

local function getGameList(game)
    return glitches[game] or glitches[tonumber(game)]
end

--[[

Cerca nel modulo dati la voce corrispondente a un esadecimale. Gli
esadecimali di una voce possono essere un numero, una table di numeri
o una stringa (nel qual caso la voce non è ricercabile per numero e
viene ignorata).

--]]

local function findEntry(game, hex)
    local list = getGameList(game)
    hex = tonumber(hex, 16) or tonumber(hex)
    if not list or not hex then
        return nil
    end

    for _, entry in ipairs(list) do
        local hexes = entry.hex
        if type(hexes) ~= "table" then
            hexes = { hexes }
        end
        for _, h in ipairs(hexes) do
            if h == hex then
                return entry
            end
        end
    end
end

--[[

Interpreta gli argomenti comuni: hex (o primo parametro posizionale),
gen e game.

--]]

local function parseArgs(args)
    local game = txt.trim(args.game or "")
    if game == "" then
        game = defaultGames[txt.trim(tostring(args.gen or ""))] or ""
    end
    return string.upper(game), txt.trim(tostring(args.hex or args[1] or ""))
end

local function getEntry(args)
    local game, hex = parseArgs(args)
    return findEntry(game, hex)
end

--[[

Ritorna il nome della pagina del Pokémon glitch, o il parametro
default se il glitch non è presente nel modulo dati.

--]]

gl.name = function(frame)
    local entry = getEntry(frame.args)
    return entry and entry.name or txt.trim(frame.args.default or "")
end
gl.Name = gl.name

--[[

Ritorna uno dei tipi del Pokémon glitch, usando il tipo "esibito"
(typeNDisplay) quando è presente, che è quello di cui si usano i
colori. Se il tipo non è tra i colori, ritorna 'sconosciuto'.

--]]

local function getType(args, number)
    local entry = getEntry(args)
    local type_ = entry
        and (
            entry["type" .. number .. "Display"]
            or entry["type" .. number]
            or entry.type1
        )
    if not type_ or not colors[string.lower(type_)] then
        type_ = "sconosciuto"
    end
    return type_
end

gl.type1 = function(frame)
    return getType(frame.args, 1)
end
gl.Type1 = gl.type1

gl.type2 = function(frame)
    return getType(frame.args, 2)
end
gl.Type2 = gl.type2

--[[

Ritorna lo stile CSS del gradiente dei tipi del Pokémon glitch.

--]]

gl.style = function(frame)
    return css.horizGradLua({
        type1 = getType(frame.args, 1),
        type2 = getType(frame.args, 2),
    })
end
gl.Style = gl.style

--[[

Ritorna la miniatura del Pokémon glitch, con il nome del glitch come
testo alternativo e il parametro link (o il nome della voce) come
pagina linkata. Se la voce non ha una miniatura sotto forma di file
(per esempio 'Vari') la ritorna così com'è.

--]]

gl.sprite = function(frame)
    local entry = getEntry(frame.args)
    if not entry or not entry.spr then
        return ""
    end
    if not entry.spr:find("%.") then
        return entry.spr
    end

    local link = txt.trim(frame.args.link or "")
    if link == "" then
        link = entry.link or entry.name
    end

    return txt.interp("[[File:${spr}|${name}|link=${link}]]", {
        spr = entry.spr,
        name = entry.name,
        link = link,
    })
end
gl.Sprite = gl.sprite

return gl
