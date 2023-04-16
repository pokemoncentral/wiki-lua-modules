-- Tentativo di sostituire i template colorschemelight/dark
-- Sto palesemente copiando dal modulo colore, perché non ho la più pallida idea di come farlo
-- Lasciatemi provare prima di cancellare la pagina

-- Ogni funzione ritorna la stringa esadecimale di colore relativa.  Nel wikicode si invoca così:
-- {{#invoke: colorscheme | kanto | light}}
-- Oppure
-- {{#invoke: colorscheme | kanto | dark}}

local c = {}
-- stylua: ignore
local txt = require('Wikilib-strings')

-- Main function, which generates the function for a single color given the
-- three hexadecimals
local function _colore(light, dark)
    return function(frame)
        local variante = txt.trim(frame.args[1]):lower()
        local colors = { light = light, dark = dark }
        return colors[variante] or error("Unexpected variant")
    end
end

-- Simple const function: returns the same value irrespective of parameters
local function const(val)
    return function()
        return val
    end
end

-- Elenco colori

c.kanto = _colore("AAFFAA", "FFAAAA")
c.Kanto, c.RG, c.RV, c["Red, Green & Blue"], c["Rosso, Verde & Blu"], c["Rosso, Blu & Verde"] =
    c.kanto, c.kanto, c.kanto, c.kanto, c.kanto, c.kanto
c.orange = _colore("FFDDAA", "FFBB55")
c.Orange = c.orange
c.johto = _colore("DDDDDD", "FFCB49")
c.Johto, c.GS, c["Gold, Silver & Crystal"], c.OA, c["Oro, Argento & Cristallo"] =
    c.johto, c.johto, c.johto, c.johto, c.johto
c.hoenn = _colore("9999FF", "FF7777")
c.Hoenn, c.AG, c.RS, c.RZ, c["Ruby & Sapphire"], c["Rubino & Zaffiro"] =
    c.hoenn, c.hoenn, c.hoenn, c.hoenn, c.hoenn, c.hoenn
c.smeraldo = _colore("77FF77", "55DD55")
c.Smeraldo, c.Emerald, c.Frontier = c.smeraldo, c.smeraldo, c.smeraldo
c.sinnoh = _colore("FFCCCC", "AAAAFF")
c.Sinnoh, c.DP, c["Diamond & Pearl"], c["Diamante & Perla"] =
    c.sinnoh, c.sinnoh, c.sinnoh, c.sinnoh
c.Pika = _colore("E66650", "FFF7A5")
c.pika = c.Pika
c.Side = _colore("FDBB99", "FD7F4F")
c.side, c.Hoso, c.hoso = c.Side, c.Side, c.Side
c.giallo = _colore("FEEF46", "FFD733")
c.Yellow, c.Giallo = c.giallo, c.giallo
c.RFVF = _colore("32FA32", "FF9359")
c.FRLG, c["FireRed & LeafGreen"], c["Rosso Fuoco & Verde Foglia"] =
    c.RFVF, c.RFVF, c.RFVF
c.Platino = _colore("BBBBBB", "999999")
c.platino, c.Platinum = c.Platino, c.Platino
c.HGSS = _colore("EBEBEB", "CEB654")
c["HeartGold & SoulSilver"], c["HeartGold e SoulSilver"] = c.HGSS, c.HGSS
c.Almia = _colore("7090E3", "2D4B98")
c.almia = c.Almia
c.Fiore = _colore("FFE815", "FF965E")
c.fiore = c.Fiore
c.Auros = _colore("DDE6F1", "B6CAE4")
c.auros, c.Colosseum, c.colosseum = c.Auros, c.Auros, c.Auros
c.NB = _colore("C3C3C3", "2C2C2C")
c.BN, c.BW, c.Unima, c.Unova, c.unima, c.Isshu =
    c.NB, c.NB, c.NB, c.NB, c.NB, c.NB
c["Black & White"], c["Nero & Bianco"], c["Nero e Bianco"] = c.NB, c.NB, c.NB
c.NB2 = _colore("E3CED0", "424B50")
c.Isshu2, c.Unova2, c.Unima2, c.N2B2 = c.NB2, c.NB2, c.NB2, c.NB2
c.NBs2, c.B2W2, c.BW2, c["Black 2 & White 2"] = c.NB2, c.NB2, c.NB2, c.NB2
c["Best Wishes 2"], c["Best Wishes stagione 2"] = c.NB2, c.NB2
c.cristalline = _colore("FFE6AA", "FFCD55")
c.Cristalline = c.cristalline
c.kalos = _colore("F16A81", "025DA6")
c.Kalos, c.xy, c.XY = c.kalos, c.kalos, c.kalos
c.ROZA = _colore("729ABF", "AB2813")
c.ORAS, c["Omega Ruby & Alpha Sapphire"], c["Rubino Omega e Zaffiro Alpha"] =
    c.ROZA, c.ROZA, c.ROZA
c.XYZ = _colore("A4CC51", "3EAE30")
c["XY & Z"], c.Z, c.xyz, c.z = c.XYZ, c.XYZ, c.XYZ, c.XYZ
c.alola = _colore("7FC5F6", "FFA94D")
c.Alola, c.SL, c.SM, c["S&M"], c["Sun & Moon"], c["Sole e Luna"] =
    c.alola, c.alola, c.alola, c.alola, c.alola, c.alola
c.LGPE = _colore("FFCF11", "C47E39")
c.galar = _colore("ED1165", "00AEEF")
c.Galar = c.galar
c.paldea = _colore("842F8C", "D90D19")
c.Paldea = c.paldea
c.hisui = _colore("EFEEE1", "CECDBE")
c.Hisui = c.hisui
c.sconosciuto = _colore("9DC1B7", "68A090")
c.Sconosciuto = c.sconosciuto
c.pcwiki = _colore("CEE0F4", "779FD3")
c.Pcwiki = c.pcwiki

return c
