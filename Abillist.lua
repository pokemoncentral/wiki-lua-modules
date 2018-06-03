--[[

This module prints the list of all Pokémon, alternative forms included, having
a given ability.

--]]

local k = {}

local mw = require('mw')

local abillib = require('Wikilib-abils')
local box = require('Box')
local css = require('Css')
local links = require('Links')
local list = require('Wikilib-lists')
--local mg = require('Wikilib-multigen')
local ms = require('MiniSprite')
local oop = require('Wikilib-oop')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local txt = require('Wikilib-strings')      -- luacheck: no unused
local pokes = require('Poké-data')

--[[

Class representing a list entry. Fulfills requirements of makeList, sortNdex
and sortForms of Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

Entry.printTypeBox = function(type, typesCount)
    return box.boxTipoLua(
        string.fu(type),
        'text-center roundy-5',
        string.interp('padding: 0 0.5ex; margin-bottom: 0.2ex; height: ${width}%;',
                {width = 100 / typesCount})
    )
end

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
    return table.concat(table.map(abillib.abilspan(abil), function(v)
        return string.interp(
            '<div>${abil}<sup>${gen}</sup></div>',
            {
                abil = v.abil == 'Nessuna' and v.abil
                        or toHTML(v.abil, '000'),
                gen = v.first == v.last and v.first
                        or table.concat{v.first, '-', v.last}
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

    local this = Entry.super.new(name, pokes[name].ndex)
    this = table.merge(this, pokeAbil)
    return setmetatable(table.merge(this, pokes[name]), Entry)
end

-- Wikicode for a list entry: Pokémon mini sprite, name, types and abilities.
Entry.__tostring = function(this)
    local typesCount = this.type1 == this.type2 and 1 or 2

    return string.interp([=[| ${static}
| class="hidden-xs" | ${name}${form}
| class="hidden-xs" style="padding: 1ex 0.8ex; font-size: 90%;" | ${type1}${type2}
| ${abil1}${abilEv}
| ${abil2}
| ${abild}]=],
{
    static = ms.staticLua(string.tf(this.ndex or 0) ..
            (this.formAbbr == 'base' and '' or this.formAbbr or '')),
    name = this.name,
    form = this.formsData
            and this.formsData.blacklinks[this.formAbbr]
            or '',
    type1 = Entry.printTypeBox(this.type1, typesCount),
    type2 = typesCount == 1 and ''
            or Entry.printTypeBox(this.type2, typesCount),
    abil1 = Entry.printAbil(this.ability1),
    abilEv = Entry.printAbil(this.abilitye, true),
    abil2 = Entry.printAbil(this.ability2),
    abild = Entry.printAbil(this.abilityd),
})
end

-- Wikicode for list header: it takes the type name, for colors
local makeHeader = function(type)
    return string.interp([=[{| class="roundy text-center pull-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|-
! style="padding-top: 0.5ex; padding-bottom: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000;">#</span>]]
! class="hidden-xs" | Pok&eacute;mon
! class="hidden-xs" | [[Tipo|<span style="color:#000;">Tipi</span>]]
! Prima abilit&agrave;
! Seconda abilit&agrave;
! Abilit&agrave; nascosta]=],
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
    abil = abil:match('^(.+) %(abilità%)') or 'Cacofonia'

    return list.makeList({
        source = require('PokéAbil-data'),
        iterator = list.pokeNames,
        entryArgs = abil,
        makeEntry = Entry.new,
        header = makeHeader(type),
        footer = [[| class="text-left font-small" colspan="6" style="background: transparent; padding: 0.3ex 0.3em;" |
* Le abilità in ''corsivo'' sono ottenibili solo in determinate circostanze.
|}]]
    })
end

k.Abillist = k.abillist

return k
