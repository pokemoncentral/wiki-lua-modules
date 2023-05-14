--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon Glitch di una generazione tra la
seconda e la quinta.
Per i Pokémon glitch con più forme (Missigno.), crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes/5glitch | DebRes | ????? (FF) }}

Se un glitch con lo stesso nome compare in più giochi
il modulo crea automaticamente una tabella diversa per
ogni gioco in cui ha debolezze e resistenze diverse
richiamandolo con solo il nome.
(ATTENZIONE: non crea una tabella per ogni combinazione
di tipi diversa ma per ogni combinazione di debolezze e
resistenze diversa)

È anche possibile passare un parametro game per indicare
il gioco di cui si vuole la tabella, es:

{{#invoke: DebRes/5glitch | DebRes | Uovo Peste | game = RZS }}

--]]

local dr = {}

-- stylua: ignore start
local mw = require('mw')

local w = require('Wikilib')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local wdata = require("Wikilib-data")
local gamesUtil = require('Wikilib-games')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local sig = require('Wikilib-sigle')
local drbase = require('DebRes-base')
local etdata = require("EffTipi-2glitch-data")
local glitch = require("Glitch-data")
-- stylua: ignore end

--[[

Questa classe rappresenta una tabella di efficacia
tipi di prima generazione. Primariamente, contiene
informazioni riguardo l'efficacia dei vari tipi di
attacchi contro un certo Pokémon, ovvero contro una
certa combinazione di tipi; oltre a ciò, possiede
le righe che compongono il footer.

--]]
local GlitchEffTable = oop.makeClass(drbase.EffTable)

-- Tutti i possibili moltiplicatori dell'efficacia
GlitchEffTable.allEff = { 0, 0.25, 0.5, 1, 2, 4 }

-- Override addLabel to use the game name as label
GlitchEffTable.addLabel = function(this, label)
    if type(label) == "table" then
        this.labels = table.merge(this.labels, label)
    else
        table.insert(this.labels, sig.gamesName(label, "/"))
    end
end

-- Override createColors to handle glitch types
GlitchEffTable.createColors = function(this)
    -- The order is important because table.merge use mw.clone on first argument,
    -- that can't be used on data.allTypes because of mw.loadData
    local coloredTypes = table.merge({ "grinta", "grazia" }, wdata.allTypes)

    this.colors = tab.copy(this.types)
    for k, v in pairs(this.colors) do
        this.colors[k] = string.lower(v)
        this.colors[k] = table.search(coloredTypes, this.colors[k])
                and this.colors[k]
            or "sconosciuto"
    end
end

-- Stringhe utili per il footer
GlitchEffTable.FooterStrings = {
    -- Testo se il Pokémon ha tipi diversi da quelli dell'efficacia
    CHANGETYPE = "\n* Nonostante questo Pokémon sia di tipo ${typeOr}, subisce danni come se fosse di tipo ${typeEff}",

    -- Link ad un tipo
    TYPE = "[[${type1}]]",

    -- Link ad un doppio tipo
    DUALTYPE = "[[${type1}]]/[[${type2}]]",
}

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome + sigla gioco,
e, opzionalmente, il nome esteso del gioco

Dato che i glitch non hanno abilità che modificano le
efficacie questo modulo non si occupa di gestirle

--]]
GlitchEffTable.new = function(name, game)
    -- Can't call super.new because it requires parameters that do not exists
    -- for glitches
    local this = setmetatable(GlitchEffTable.super.super.new(), GlitchEffTable)

    if game then
        name = name:gsub("(.*)" .. game .. "$", "%1")
        -- se viene passato il gioco, il glitch ha più
        -- forme, quindi bisogna aggiungere la label
        this:addLabel(game)
    else
        game = tab.deepSearch(glitch, name)
    end

    local data = glitch[game][tab.deepSearch(glitch[game], name)]
    -- data.typeEffectiveness viene usato solo per glitch di prima generazione
    local types = { type1 = data.type1, type2 = data.type2 }
    if not types.type2 then
        types.type2 = types.type1
    end
    this.types = table.map(types, string.lower)
    this.abil = { ability1 = "nessuna" }
    -- placeholder, doesn't really matter as long as it's between 2 and 5
    this.gen = 2
    this.et = etdata

    -- Colori per la stampa
    this:createColors()

    this:computeEff()
    -- No footer for gen 2-5 glitches
    this.footer = {}

    return this
end

--[[

Funzione d'interfaccia al wikicode: prende in ingresso
il nome di un Pokémon glitch e genera le table dell'efficacia
tipi di prima generazione. Se il Pokémon ha più forme,
ritorna una table per ogni forma, tutte collassabili con
solo quella della forma base estesa al caricamento della pagina.

--]]
dr.debRes = function(frame)
    local p = tab.map(mw.clone(frame.args), w.trim)
    local games = {}

    local name = mw.text.decode(p[1])

    --[[
		controlla se il glitch esiste in più giochi,
		e nel caso prepara una table con l'elenco
		dei giochi
	--]]
    if p[2] or p.game then
        table.insert(games, p[2] or p.game)
    else
        for game, glitches in pairs(glitch) do
            if tab.deepSearch(glitches, name) then
                table.insert(games, game)
            end
        end
    end

    -- Crea altData a partire da games
    local altData
    if #games > 1 then
        altData = { gamesOrder = {}, names = {} }
        for k, v in ipairs(games) do
            table.insert(altData.gamesOrder, v)
            altData.names[v] = v
        end
        -- Ordina altData.gamesOrder in modo da avere prima i giochi più vecchi
        table.sort(altData.gamesOrder, function(a, b)
            a = a == "RZS" and "rz" or string.lower(a)
            b = b == "RZS" and "rz" or string.lower(b)
            return gamesUtil.isBefore(a, b)
        end)
    end

    return list.makeFormsLabelledBoxes({
        name = name,
        makeBox = GlitchEffTable.new,
        printBoxes = GlitchEffTable.printEffTables,
        altData = altData,
    })
end
dr.DebRes, dr.debres = dr.debRes, dr.debRes

return dr
