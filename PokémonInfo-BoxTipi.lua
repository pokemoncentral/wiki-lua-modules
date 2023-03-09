-- Box dei tipi per il PokémonInfo

local b = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local multigen = require('Wikilib-multigen')
local l = require('Links')
local pokes = require("Poké-data")
-- stylua: ignore end

--[[

Questa classe rappresenta una casella
del box dei tipi del PokémonInfo,
mantenendo informazioni sui tipi e
sulle forme che li hanno.

--]]
local TypesBox = oop.makeClass(list.Labelled)

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome/ndex + sigla,
e, opzionalmente, il nome esteso della forma

--]]
TypesBox.new = function(name, formName)
    local this = setmetatable(TypesBox.super.new(formName), TypesBox)

    local pokeData = multigen.getGen(pokes[name])
    this.type1, this.type2 = pokeData.type1, pokeData.type2

    return this
end

TypesBox.__eq = function(a, b)
    return a.type1 == b.type1 and a.type2 == b.type2
end

--[[

Wikicode per una cella del box dei tipi:
i tipi sono su fondo colorato e le forme
sotto in piccolo.

--]]
TypesBox.__tostring = function(this)
    return txt.interp(
        '<div class="width-xl-50 text-center" style="box-sizing: border-box; padding: 0.2em;" >${type1}${type2}${forms}</div>',
        {
            type1 = l.typeColor(this.type1),
            type2 = this.type1 == this.type2 and "" or l.typeColor(this.type2),
            forms = #this.labels < 1 and "" or table.concat({
                '<div class="small-text">',
                mw.text.listToText(this.labels, ", ", " e "),
                "</div>",
            }),
        }
    )
end

--[[

Stampa in HTML una table di Boxes,
raggruppati in due per riga

--]]

local printBoxes = function(boxes)
    local acc = table.map(boxes, tostring)
    table.insert(
        acc,
        1,
        '<div class="roundy white-bg flex flex-row flex-wrap flex-main-stretch flex-items-center" style="padding: 0.2em;">'
    )
    table.insert(acc, "</div>")

    return table.concat(acc)
end

--[[

Dato il nome di un Pokémon o il suo ndex,
ritorna il box dei tipi, con una cella
per ogni diversa combinazione di tipi
delle forme alternative, con sotto i nomi
delle forme che li hanno

--]]
b.boxTipi = function(frame)
    local name = txt.trim(frame.args[1] or ""):lower()
    local pokeData = pokes[txt.parseInt(name) or name]
        or pokes[mw.text.decode(name)]
    pokeData = multigen.getGen(pokeData)
    name = pokeData.name:lower()

    return list.makeFormsLabelledBoxes({
        name = name,
        makeBox = TypesBox.new,
        printBoxes = printBoxes,
    })
end

b.BoxTipi, b.box_tipi, b.Box_tipi = b.boxTipi, b.boxTipi, b.boxTipi

-- print(b.boxTipi{args={arg[1]}})
return b
