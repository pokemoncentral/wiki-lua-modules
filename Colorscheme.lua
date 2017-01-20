-- Tentativo di sostituire i template colorschemelight/dark
-- Sto palesemente copiando dal modulo colore, perché non ho la più pallida idea di come farlo
-- Lasciatemi provare prima di cancellare la pagina

-- Ogni funzione ritorna la stringa esadecimale di colore relativa.  Nel wikicode si invoca così:
-- {{#invoke: colorscheme | kanto | light}}
-- Oppure
-- {{#invoke: colorscheme | kanto | dark}}

local c = {}
local txt = require('Wikilib-strings')

-- Questa è la funzione principale che viene chiamata da (quasi) tutte le altre.
-- Restituisce il codice esadecimale giusto per la variante richiesta.

local function _colore(variante, light, dark)
    variante = string.trim(variante:lower())
    local colors = {light = light, dark = dark}
	return colors[variante] or 'Errore'
end

-- Elenco colori

c.kanto = function(frame) return _colore(frame.args[1], 'AAFFAA', 'FFAAAA') end
c.Kanto, c.RG, c.RV, c['Red, Green & Blue'], c['Rosso, Verde & Blu'] = c.kanto, c.kanto, c.kanto, c.kanto, c.kanto
c.orange = function(frame) return _colore(frame.args[1], 'FFDDAA', 'FFBB55') end
c.Orange = c.orange
c.johto = function(frame) return _colore(frame.args[1], 'DDDDDD', 'FFCB49') end
c.Johto, c.GS, c['Gold, Silver & Crystal'], c.OA, c['Oro, Argento & Cristallo'] = c.johto, c.johto, c.johto, c.johto, c.johto
c.hoenn = function(frame) return _colore(frame.args[1], '9999FF', 'FF7777') end
c.Hoenn, c.AG, c.RS, c.RZ, c['Ruby & Sapphire'], c['Rubino & Zaffiro'] = c.hoenn, c.hoenn, c.hoenn, c.hoenn, c.hoenn, c.hoenn
c.smeraldo = function(frame) return _colore(frame.args[1], '77FF77', '55DD55') end
c.Smeraldo, c.Emerald, c.Frontier = c.smeraldo, c.smeraldo, c.smeraldo
c.sinnoh = function(frame) return _colore(frame.args[1], 'FFCCCC', 'AAAAFF') end
c.Sinnoh, c.DP, c['Diamond & Pearl'], c['Diamante & Perla'] = c.sinnoh, c.sinnoh, c.sinnoh, c.sinnoh
c.Pika = function(frame) return _colore(frame.args[1], 'E66650', 'FFF7A5') end
c.pika = c.Pika
c.Side = function(frame) return _colore(frame.args[1], 'FDBB99', 'FD7F4F') end
c.side, c.Hoso, c.hoso = c.Side, c.Side, c.Side
c.giallo = function(frame) return _colore(frame.args[1], 'FEEF46', 'FFD733') end
c.Yellow, c.Giallo = c.giallo, c.giallo
c.RFVF = function(frame) return _colore(frame.args[1], '32FA32', 'FF9359') end
c.FRLG, c['FireRed & LeafGreen'], c['Rosso Fuoco & Verde Foglia'] = c.RFVF, c.RFVF, c.RFVF
c.Platino = function(frame) return _colore(frame.args[1], 'BBBBBB', '999999') end
c.platino, c.Platinum = c.Platino, c.Platino
c.HGSS = function(frame) return _colore(frame.args[1], 'EBEBEB', 'CEB654') end
c['HeartGold & SoulSilver'], c['HeartGold e SoulSilver'] = c.HGSS, c.HGSS
c.Almia = function(frame) return _colore(frame.args[1], '7090E3', '2D4B98') end
c.almia = c.Almia
c.Fiore = function(frame) return _colore(frame.args[1], 'FFE815', 'FF965E') end
c.fiore = c.Fiore
c.Auros = function(frame) return _colore(frame.args[1], 'DDE6F1', 'B6CAE4') end
c.auros, c.Colosseum, c.colosseum = c.Auros, c.Auros, c.Auros
c.NB = function(frame) return _colore(frame.args[1], 'C3C3C3', '2C2C2C') end
c.BN, c.BW, c.Unima, c.Unova, c.unima, c.Isshu = c.NB, c.NB, c.NB, c.NB, c.NB, c.NB
c['Black & White'], c['Nero & Bianco'], c['Nero e Bianco'] = c.NB, c.NB, c.NB
c.NB2 = function(frame) return _colore(frame.args[1], 'E3CED0', '424B50') end
c.Isshu2, c.Unova2, c.Unima2, c.N2B2 = c.NB2, c.NB2, c.NB2, c.NB2
c.NBs2, c.B2W2, c.BW2, c['Black 2 & White 2'] = c.NB2, c.NB2, c.NB2, c.NB2
c['Best Wishes 2'], c['Best Wishes stagione 2'] = c.NB2, c.NB2
c.cristalline = function(frame) return _colore(frame.args[1], 'FFE6AA', 'FFCD55') end
c.Cristalline = c.cristalline
c.kalos = function(frame) return _colore(frame.args[1], 'F16A81', '025DA6') end
c.Kalos, c.xy, c.XY = c.kalos, c.kalos, c.kalos
c.ROZA = function(frame) return _colore(frame.args[1], '729ABF', 'AB2813') end
c.ORAS, c['Omega Ruby & Alpha Sapphire'], c['Rubino Omega e Zaffiro Alpha'] = c.ROZA, c.ROZA, c.ROZA
c.XYZ = function(frame) return _colore(frame.args[1], 'A4CC51', '3EAE30') end
c['XY & Z'], c.Z, c.xyz, c.z = c.XYZ, c.XYZ, c.XYZ, c.XYZ
c.alola = function(frame) return _colore(frame.args[1], '7FC5F6', 'FFA94D') end
c.Alola, c.SL, c.SM, c['S&M'], c['Sun & Moon'], c['Sole e Luna'] = c.alola, c.alola, c.alola, c.alola, c.alola, c.alola
c.pcwiki = function(frame) return _colore(frame.args[1], 'CEE0F4', '779FD3') end
c.Pcwiki = c.pcwiki

return c
