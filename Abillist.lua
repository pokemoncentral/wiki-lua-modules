--[[

This module prints the list of all Pokémon, alternative forms included, having
a given ability.

--]]

local k = {}

local mw = require('mw')

local css = require('Css')
local links = require('Links')
local list = require('Wikilib-lists')
local ms = require('MiniSprite')
local oop = require('Wikilib-oop')
local resp = require('Resp')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local genlib = require('Wikilib-multigen')
local pokes = require('Poké-data')
local gens = require('Gens-data')

--[[

Class representing a list entry. Fulfills requirements of makeList, sortNdex
and sortForms of Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Printing ability is a complex job: event have to be handled, as well as
generation changes. The first argumetn is the ability to be printed, the second
one whether it should be marked or not, to be used for events.

--]]
Entry.printAbil = function(abil, marked)
    if not abil then
        return marked and '' or 'Nessuna'
    end

    -- Marked abilities are italic
    local toHTML
    if marked then
        toHTML = function(ability)
            return string.interp([=[<div>''${abil}''</div>]=],
                {
                    abil = links.aColor(ability, '000'),
                })
        end
    else
        toHTML = links.aColor
    end

    if type(abil) == 'string' then
        return toHTML(abil, '000')
    end

    -- Adding generations superscripts
    return table.concat(table.map(genlib.getGenSpan(abil), function(v)
        local first, last = gens[v.first].roman, gens[v.last].roman
        return string.interp(
            '<div>${abil}<sup>${gen}</sup></div>',
            {
                abil = v.val == 'Nessuna' and v.val
                        or toHTML(v.val, '000'),
                gen = v.first == v.last and first
                        or table.concat{first, '-', last}
            })
    end))
end

--[[

Constructor: the first argument is an entry from Poké/data, the second one its
key and the third is the ability the Pokémon must have. As specified by
makeList in Wikilib/lists, returns nil whenever the Pokémon can not have the
ability.

--]]
Entry.new = function(pokeAbil, name, abil)
    if not table.deepSearch(pokeAbil, abil) then
        return nil
    end

    local pokedata = genlib.getGen(pokes[name])
    local this = Entry.super.new(name, pokedata.ndex)
    this = table.merge(this, pokeAbil)
    return setmetatable(table.merge(this, pokedata), Entry)
end

-- Wikicode for a list entry: Pokémon mini sprite, name, types and abilities.
Entry.__tostring = function(this)
    return string.interp([=[| class="min-width-sm-20" data-sort-value="${ndex}" | ${static}
| class="min-width-sm-40 min-width-xs-80" | [[${name}|<span style="color: #000;">${name}</span>]]${form}
| class="min-width-xl-20 width-sm-40 width-xs-100" style="padding: 1ex 0.8ex;" | ${types}
| class="min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Prima abilit&agrave;</div>${abil1}${abilEv}
| class="min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Seconda abilit&agrave;</div>${abil2}
| class="min-width-sm-33" style="padding: 0.3ex;" | <div class="visible-sm text-small">Abilit&agrave; speciali</div>${abild}]=],
{
    ndex = this.ndex and string.tf(this.ndex) or '???',
    static = ms.staticLua(string.tf(this.ndex or 0) ..
            (this.formAbbr == 'base' and '' or this.formAbbr or '')),
    name = this.name,
    form = this.formsData and this.formsData.blacklinks[this.formAbbr] or '',
    types = resp.twoTypeBoxesLua(this.type1, this.type2, {'thin'}, nil,
        {'inline-block-sm', 'min-width-sm-70'}),
    abil1 = Entry.printAbil(this.ability1),
    abilEv = Entry.printAbil(this.abilitye, true),
    abil2 = Entry.printAbil(this.ability2),
    abild = Entry.printAbil(this.abilityd),
})
end

-- Wikicode for list header: it takes the type name, for colors
local makeHeader = function(type)
    return string.interp([=[{| class="sortable roundy text-center pull-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|- class="hidden-sm"
! style="padding-top: 0.5ex; padding-bottom: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000;">#</span>]]
! Pok&eacute;mon
! [[Tipo|<span style="color:#000;">Tipi</span>]]
! Prima abilit&agrave;
! Seconda abilit&agrave;
! Abilit&agrave; speciale]=],
        {
            bg = css.horizGradLua{type = type}
        })
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
        source = require('PokéAbil-data'),
        iterator = list.pokeNames,
        entryArgs = abil,
        makeEntry = Entry.new,
        header = makeHeader(type),
        separator = '|- class="roundy flex-sm flex-row flex-wrap flex-main-stretch flex-items-center" style="margin-top: 0.5rem;"',
        footer = [[|-
! class="text-left font-small" colspan="6" style="padding: 0.3ex 0.3em;" |
* Le abilità in ''corsivo'' sono ottenibili solo in determinate circostanze.
|}]]
    })
end

k.Abillist = k.abillist

return k
