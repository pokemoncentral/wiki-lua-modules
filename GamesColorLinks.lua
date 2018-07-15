-- Dalle sigle dei giochi, ritorna il link agli stessi
-- del colore passato

local txt = require('Wikilib-strings')      -- luacheck: no unused
local lib = require('Wikilib-sigle')
local c = require("Colore-data")

local makeLink = function(data, args)
    local color, shade = unpack(args)

    return table.concat(lib.makeTextLinks(data, function(link, text)
        return string.interp('<span style="color:#${color}">${text}</span>',
            {
                color = c[color] and c[color][shade or 'normale'] or color,
                text = text or link
            })
    end))
end

return lib.mapAbbrs(function(_, abbr)
    return lib.onMergedAbbrsArgs(abbr, 2, makeLink)
end)
