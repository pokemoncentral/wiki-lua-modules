--[[

This module prints the list of all Pokémon,
alternative forms included, having a given
somehow ability.

--]]

local k = {}

local mw = require('mw')

local box = require('Box')
local css = require('Css')
local links = require('Links')
local ms = require('MiniSprite')
local abillib = require('Wikilib-abils')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local list = require('Wikilib-lists')
local form = require('Wikilib-forms')
local forms = require("AltForms-data")
local c = require("Colore-data")
local pokes = require('Poké-data')

--[[

Class representing a list entry. Fulfills
requirements of makeList, sortNdex and
sortForms of Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

Entry.printTypeBox = function(type, typesCount)
    return box.boxTipoLua(
        string.fu(type),
        'text-center roundy-5 flex flex-row flex-main-center flex-items-center',
        string.interp('padding: 0 0.5ex; margin-bottom: 0.2ex; height: ${width}%;',
                {width = 100 / typesCount})
    )
end

--[[

Printing ability is a complex job: event
have to be handled, as well as generation
changes. The first argumetn is the ability
to be printed, the second one whether it
should be marked or not, to be used for events.

--]]
Entry.printAbil = function(abil, marked)
	if not abil then
		return 'Nessuna'
	end

    -- Marked abilities are italic
    local toHTML
    if marked then
        toHTML = function(abil, color)
            return string.interp([=[[[${ability} (abilità)|<span style="color:#${tc};">''${name}''</span>]]]=],
                {
                    ability = abil,
                    tc = color or '000',
                    name = string.fu(abil)
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

Constructor: the first argument is an entry
from Poké/data, the second one its key and
the third is the ability the Pokémon must have.
As specified by makeList in Wikilib/lists,
returns nil whenever the Pokémon can not
have the ability.

--]]
Entry.new = function(pokeAbil, name, abil)
	if not table.deepSearch(pokeAbil, abil) then
		return nil
	end

	local this = Entry.super.new(name, pokes[name].ndex)

	this = table.merge(this, pokeAbil)

    --[[
        Marking event abilities to
        print them correctly
    --]]
    if abil == this.eventability then
        this.useEvent = true
    end
	
	return setmetatable(table.merge(this, pokes[name]), Entry)
end

--[[

Wikicode for a list entry: Pokémon mini sprite,
name, types and abilities.

--]]
Entry.__tostring = function(this)
	local typesCount = this.type1 == this.type2 and 1 or 2
    local abil1, marked = this.ability1
    if this.useEvent then
        abil1, marked = this.eventability, true
    end
    
	return string.interp([=[| ${static}
| class="hidden-xs" | ${name}${form}
| class="hidden-xs" style="padding: 1ex 0.8ex; font-size: 90%;" | ${type1}${type2}
| ${abil1}
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
	abil1 = Entry.printAbil(abil1, marked),
	abil2 = Entry.printAbil(this.ability2),
	abild = Entry.printAbil(this.abilityd),
})
end

--[[

Wikicode for list header: it takes the type
name, for colors

--]]
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

--return k

print(k.abillist{args=arg})
