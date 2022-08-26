--[[

This module prints the list of all Pokémon, alternative forms included, having
a given ability.

--]]

local k = {}

local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local genlib = require('Wikilib-multigen')
local css = require('Css')
local cc = require('ChooseColor')
local ms = require('MiniSprite')
local resp = require('Resp')
local pokes = require("Poké-data")
local abils = require('PokéAbil-data')
local gens = require("Gens-data")

local mw = require('mw')

--[[

Class representing a list entry. Fulfills requirements of makeList, sortNdex
and sortForms of Wikilib/lists

--]]
k.Entry = oop.makeClass(list.PokeLabelledEntry)

--[[

Printing ability is a complex job: event have to be handled, as well as
generation changes. The first argumetn is the ability to be printed, the second
one whether it should be marked or not, to be used for events.

--]]
k.Entry.printAbil = function(abil, marked)
    if not abil then
        return marked and '' or 'Nessuna'
    end

    -- Marked abilities are italic
    local toHTML
    if marked then
        toHTML = function(ability)
            return table.concat{"<div>''[[", ability, "]]''</div>"}
        end
    else
        toHTML = function(ability)
            return table.concat{"[[", ability, "]]"}
        end
    end

    if type(abil) == 'string' then
        return toHTML(abil)
    end

    -- Adding generations superscripts
    return table.concat(table.map(genlib.getGenSpan(abil), function(v)
        local first, last = gens[v.first].roman, gens[v.last].roman
        return string.interp(
            '<div>${abil}<sup>${gen}</sup></div>',
            {
                abil = (v.val == 'Nessuna' or v.val == 'Sconosciuta') and v.val
                        or toHTML(v.val),
                gen = v.first == v.last and first
                        or table.concat{first, '-', last}
            })
    end))
end

--[[

Constructor: the first argument is an entry from PokéAbil/data, the second
one its key.

--]]
k.Entry.new = function(pokeAbil, name)
    local pokedata = genlib.getGen(pokes[name])
    local this = k.Entry.super.new(name, pokedata.ndex)
    this.abils = pokeAbil
    if this.labels[1] == "" then
        this.labels[1] = nil
    end
    return setmetatable(table.merge(this, pokedata), k.Entry)
end

-- Wikicode for a list entry: Pokémon mini sprite, name, types and abilities.
k.Entry.__tostring = function(this)
    -- local form = this.formsData
    --              and this.formsData.blacklinks[this.formAbbr] or ''
    local form = ""
    if this.labels[1] then
        form = this.labels[1] == 'Tutte le forme'
                and '<div class="small-text">Tutte le forme</div>'
                or this.formsData.blacklinks[this.formAbbr]
    end

    return string.interp([=[| class="min-width-sm-20" data-sort-value="${ndex}" | ${static}
| class="black-text min-width-sm-40 min-width-xs-80" | [[${name}]]${form}
| class="min-width-xl-20 width-sm-40 width-xs-100" style="padding: 1ex 0.8ex;" | ${types}
| class="black-text min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Prima abilit&agrave;</div>${abil1}${abilEv}
| class="black-text min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Seconda abilit&agrave;</div>${abil2}
| class="black-text min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Abilit&agrave; speciali</div>${abild}]=],
{
    ndex = this.ndex and string.tf(this.ndex) or '???',
    static = ms.staticLua{string.tf(this.ndex or 0) ..
            (this.formAbbr == 'base' and '' or this.formAbbr or '')},
    name = this.name,
    form = form,
    types = resp.twoTypeBoxesLua(this.type1, this.type2, {'thin'}, nil,
        {'inline-block-sm', 'min-width-sm-70'}),
    abil1 = k.Entry.printAbil(this.abils.ability1),
    abilEv =k.Entry.printAbil(this.abils.abilitye, true),
    abil2 = k.Entry.printAbil(this.abils.ability2),
    abild = k.Entry.printAbil(this.abils.abilityd),
})
end

k.headers = {}

-- Wikicode for list header: it takes the color name
k.headers.makeHeader = function(color)
    return string.interp([=[{| class="sortable roundy text-center pull-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|- class="hidden-sm ${text}"
! style="padding-top: 0.5ex; padding-bottom: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|#]]
! Pok&eacute;mon
! [[Tipo|Tipi]]
! Prima abilit&agrave;
! Seconda abilit&agrave;
! Abilit&agrave; speciale]=],
        {
            bg = css.horizGradLua{type = color},
            text = cc.forModGradBgLua(color),
        })
end

k.headers.separator = '|- class="roundy flex-sm flex-row flex-wrap flex-main-stretch flex-items-center" style="margin-top: 0.5rem;"'

k.headers.makeFooter = function(color)
    return string.interp([=[|-
! class="text-left font-small ${text}" colspan="6" style="padding: 0.3ex 0.3em;" |
* Le abilità in ''corsivo'' sono ottenibili solo in determinate circostanze.
|}]=],
        {
            text = cc.forModGradBgLua(color),
        })
end

-- =============================== AbilEntry ===============================
-- Class representing an entry of a Pokémon with a certain ability.
k.AbilEntry = oop.makeClass(k.Entry)

--[[

Constructor: the same as the superclass but adding a filter for Pokémon with
a certain ability.
The first argument is an entry from PokéAbil/data, the second one its key and
the third is the ability the Pokémon must have.

--]]
k.AbilEntry.new = function(pokeAbil, name, abil)
    if not table.deepSearch(pokeAbil, abil) then
        return nil
    end

    local this = k.AbilEntry.super.new(pokeAbil, name)
    return setmetatable(this, k.AbilEntry)
end

--[[

Funzione d'interfaccia: si passano il tipo per il colore
e il titolo della pagina, da cui si ricava quello
dell'abilità.

--]]
k.abillist = function(frame)
    local type = string.trim(frame.args[1]) or 'pcwiki'
    local abil = string.trim(mw.text.decode(frame.args[2]))
    abil = abil or 'Cacofonia'

    return list.makeList({
        source = abils,
        iterator = list.pokeNames,
        entryArgs = abil,
        makeEntry = k.AbilEntry.new,
        header = k.headers.makeHeader(type),
        separator = k.headers.separator,
        footer = k.headers.makeFooter(type),
    })
end

k.Abillist = k.abillist

return k
