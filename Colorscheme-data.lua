-- Primo tentativo di utilizzo della funzione mediawiki "require"

-- In questo modulo semplicemente è contenuta una tabella con tutti i colori:
-- Il primo indice è il nome del colore, e il secondo la variante

local c = {}
local s = require('Colorscheme')

for a in pairs(s) do
    c[a] = {}
    c[a].light = s[a]{args={'light'}}
    c[a].dark = s[a]{args={'dark'}}
end

return c
