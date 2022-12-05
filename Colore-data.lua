--[[

Data module for colors.

Since modulo Colore exports functions (for Wikicode interface), we use this
module to put its data in a tabular form, in order to mw.loadData it.

--]]

local c = {}
-- stylua: ignore
local s = require('Colore')

-- Dynamic generation: calls all colore functions. There a couple corner cases,
-- handledbelow (mainly zona_text and pcwiki)
for a in pairs(s) do
    c[a] = {}
    if string.lower(a:match("(%a)_text") or "zona") == "zona" then
        c[a].normale = s[a]({ args = { "normale" } })
        c[a].light = s[a]({ args = { "light" } })
        c[a].dark = s[a]({ args = { "dark" } })
    else
        c[a] = s[a]({ args = {} })
    end
end

c.background = s.background()
c.Background = c.background
c.pcwiki.medium_light = s.pcwiki({ args = { "medium light" } })
c.pcwiki.medium_dark = s.pcwiki({ args = { "medium dark" } })
c.zona_text = {}
c.zona_text.palude = s.zona_text({ args = { "palude" } })
c.zona_text.marsh = c.zona_text.palude
c.zona_text.vulcano = s.zona_text({ args = { "vulcano" } })
c.zona_text.volcano = c.zona_text.vulcano
c.zona_text.spazio = s.zona_text({ args = { "spazio" } })
c.zona_text.space, c.zona_text.ombra, c.zona_text.shadow =
    c.zona_text.spazio, c.zona_text.spazio, c.zona_text.spazio
c.zona_text.distorsione = s.zona_text({ args = { "distorsione" } })
c.zona_text.distortion = c.zona_text.distorsione
c.zona_text.grotta = "000"
c.zona_text.Grotta, c.zona_text.caverna = c.zona_text.grotta, c.zona_text.grotta
c.zona_text.terra, c.zona_text.Terra, c.zona_text.land =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.foresta, c.zona_text.Foresta, c.zona_text.bosco, c.zona_text.forest =
    c.zona_text.grotta,
    c.zona_text.grotta,
    c.zona_text.grotta,
    c.zona_text.grotta
c.zona_text.nebbia, c.zona_text.Nebbia, c.zona_text.fog =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.palude, c.zona_text.Palude, c.zona_text.marsh =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.cenere, c.zona_text.Cenere, c.zona_text.ash =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.rovine, c.zona_text.Rovine, c.zona_text.ruins =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.sabbia, c.zona_text.Sabbia, c.zona_text.sand =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.lago, c.zona_text.Lago, c.zona_text.lake =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.oceano, c.zona_text.Oceano, c.zona_text.ocean =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.sottacqua, c.zona_text.Sottacqua, c.zona_text.underwater =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.montagna, c.zona_text.Montagna, c.zona_text.mountain =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.vulcano, c.zona_text.Vulcano, c.zona_text.volcano =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.neve, c.zona_text.Neve, c.zona_text.snow =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.spazio, c.zona_text.Spazio, c.zona_text.space =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.distorsione, c.zona_text.Distorsione, c.zona_text.distortion =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.ombra, c.zona_text.Ombra, c.zona_text.shadow =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta
c.zona_text.edificio, c.zona_text.Edificio, c.zona_text.building, c.zona_text.palazzo =
    c.zona_text.grotta,
    c.zona_text.grotta,
    c.zona_text.grotta,
    c.zona_text.grotta
c.zona_text.strada, c.zona_text.Strada, c.zona_text.road =
    c.zona_text.grotta, c.zona_text.grotta, c.zona_text.grotta

return c
