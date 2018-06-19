--[[

This module prints the list of all Pokémon, alternative forms included, having
a given type. It divides them into mono-typed, first-typed and second-typed.

--]]

local g = {}

local mw = require('mw')

local box = require('Box')
local css = require('Css')
local ms = require('MiniSprite')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local pokes = require('Poké-data')

--[[

Base class for specialized list entry (mono-, first- and second-typed): it is
not utilizable directly because it does not filter the type.

--]]
g.Entry = oop.makeClass(list.PokeSortableEntry)

-- Typebox-related constants
g.Entry.typeBox = {
    classes = '-5 text-center',
    styles = 'padding: 0.5ex 0.3em;'
}

-- Returns the heading line for tables, given type, heading level and ending.
g.Entry.makeHeader = function(type, level, ending)
    type = type == 'coleot' and 'Coleottero' or string.fu(type)
    local headerTags = string.rep('=', level)
    return table.concat({headerTags, 'Pokémon di tipo', type, ending,
            headerTags}, ' ')
end

-- Returns wikicode for typeboxes
g.Entry.makeTypeBox = function(type)
    return box.boxTipoLua(string.fu(type), g.Entry.typeBox.classes,
        g.Entry.typeBox.styles)
end

--[[

Constructor: first argument is an entry from Poké/data, second one its key.
Subclasses are to return nil, as specified by makeList in Wikilib/lists.

--]]
g.Entry.new = function(pokeData, name)
    local this = g.Entry.super.new(name, pokeData.ndex)

    return setmetatable(table.merge(this, pokeData), g.Entry)
end

--[[

Wikicode for a list entry: Pokémon ndex, mini sprite, name and types.
Mono-typed Pokémon display the type only once.

--]]
g.Entry.__tostring = function(this)
    local monoType = this.type1 == this.type2
    return string.interp([=[| class="min-width-xs-20" | ${ndex}
| class="min-width-xs-20" | ${static}
| class="min-width-xs-60" style="padding: 0.5ex 0.5em;" | [[${name}]]${form}
| class="min-width-xs-${xsWidth}" style="padding: 1.2ex 0.3ex;" | ${type1}${type2}]=],
    {
        ndex = this.ndex and string.tf(this.ndex) or '???',
        static = ms.staticLua(string.tf(this.ndex or 0) ..
                (this.formAbbr == 'base' and '' or this.formAbbr or '')),
        name = this.name,
        form = this.formsData and this.formsData.links[this.formAbbr] or '',
        xsWidth = 70 / (monoType and 1 or 2),
        type1 = g.Entry.makeTypeBox(this.type1),
        type2 = monoType and ''
                or ' || class="min-width-xs-35" style="padding: 1.2ex 0.3ex;" | '
                        .. g.Entry.makeTypeBox(this.type2)
    })
end

-- Mono-typed Pokémon entry class
g.MonoTypeEntry = oop.makeClass(g.Entry)

-- Creates mono-typed headings
g.MonoTypeEntry.makeHeader = function(type)
    return g.MonoTypeEntry.super.makeHeader(type, 3, 'puro')
end

--[[

Constructor: the first argument is an entry from Poké/data, the second one its
key and the third is the type the Pokémon must have. As specified by makeList
in Wikilib/lists, returns nil whenever the Pokémon is either dual-typed or not
of the passed type.

--]]
g.MonoTypeEntry.new = function(pokeData, name, type)
    if pokeData.type1 ~= pokeData.type2
            or type ~= pokeData.type1 then
        return nil
    end

    return setmetatable(g.MonoTypeEntry.super.new(pokeData,
            name), g.MonoTypeEntry)
end

-- First-typed Pokémon entry class
g.FirstTypeEntry = oop.makeClass(g.Entry)

-- Creates first-typed headings
g.FirstTypeEntry.makeHeader = function(type)
    return g.FirstTypeEntry.super.makeHeader(type, 4,
        'come tipo primario')
end

--[[

Constructor: the first argument is an entry from Poké/data, the second one its
key and the third is the type the Pokémon must have as first. As specified by
makeList in Wikilib/lists, returns nil whenever the Pokémon is either
mono-typed or its first type is not the passed one.

--]]
g.FirstTypeEntry.new = function(pokeData, name, type)
    if pokeData.type1 == pokeData.type2
            or type ~= pokeData.type1 then
        return nil
    end

    return setmetatable(g.FirstTypeEntry.super.new(pokeData,
            name), g.FirstTypeEntry)
end

-- Second-typed Pokémon entry class
g.SecondTypeEntry = oop.makeClass(g.Entry)

-- Creates second-typed headings
g.SecondTypeEntry.makeHeader = function(type)
    return g.SecondTypeEntry.super.makeHeader(type, 4,
        'come tipo secondario')
end

--[[

Constructor: the first argument is an entry from Poké/data, the second one its
key and the third is the type the Pokémon must have as second. As specified by
makeList in Wikilib/lists, returns nil whenever the Pokémon is either
mono-typed or its second type is not the passed one.

--]]
g.SecondTypeEntry.new = function(pokeData, name, type)
    if pokeData.type1 == pokeData.type2
            or type ~= pokeData.type2 then
        return nil
    end

    return setmetatable(g.SecondTypeEntry.super.new(pokeData,
            name), g.SecondTypeEntry)
end

--[[

Wikicode for list header: it takes the type name, for colors, and the number of
types, to print the correct amount of type columns.

--]]
local makeHeader = function(type, typesCount)
    return string.interp([=[{| class="roundy sortable pull-center text-center roundy-footer white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|- class="hidden-xs"
! style="padding-top: 0.5ex; padding-bottom: 0.5ex; padding-left: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">#</span>]]
! &nbsp;
! [[Pokémon|<span style="color:#000">Pokémon</span>]]
${types}]=],
{
    bg = css.horizGradLua{type = type},
    types = typesCount < 2 and '! [[Tipo|<span style="color:#000">Tipo</span>]]'
        or [=[! [[Tipo|<span style="color:#000">Tipo 1</span>]]
! [[Tipo|<span style="color:#000">Tipo 2</span>]]]=]
})
end

--[[

Creates heading and HTML table for Pokémons of a given type. Its first argument
is such type, the second one an Entry class complying to makeList in
Wikilib/listm and the third is the heading line. The latter argument is
optional, defaulting to the return of the Entry class makeHeader method.

--]]
g.makeTypeTable = function(type, Entry, header)
    return table.concat({header or Entry.makeHeader(type),
        list.makeList({
            source = pokes,
            iterator = list.pokeNames,
            entryArgs = type,
            makeEntry = Entry.new,
            header = makeHeader(type,
                    Entry == g.MonoTypeEntry and 1 or 2),
            separator = '|- class="roundy flex-xs flex-row flex-wrap flex-main-center flex-items-center" style="margin: 0.5rem 0;"',
            footer = '|}'
        })}, '\n')
end

--[[

Wikicode interface function: takes a type as the title of its page ('<type>')
and prints a list fo all the Pokémon having such type, dividing them into
mono-typed, first-typed and second-typed. Heading for sublists are also
displayed.

Examples:
{{#invoke: Typelist | Typelist | Ghiaccio }}

(in type pages only)
{{#invoke: Typelist | Typelist | {{BASEPAGENAME}} }}

--]]
g.typelist = function(frame)

    -- Extracting type from page title
    local monoType = string.trim(mw.text.decode(frame.args[1]
            or 'sconosciuto')):lower()

    -- Dual-typed Pokémon have 'coleottero' as 'coleot'
    local dualType = monoType == 'coleottero' and 'coleot' or monoType

    return table.concat({
            g.makeTypeTable(monoType, g.MonoTypeEntry),
            g.Entry.makeHeader(monoType, 3, 'parziale'),
            g.makeTypeTable(dualType, g.FirstTypeEntry),
            g.makeTypeTable(dualType, g.SecondTypeEntry)
        }, '\n\n')
end

g.Typelist, g.TypeList, g.typeList = g.typelist, g.typelist, g.typelist

-- print(g.typelist{args={arg[1]}})

return g
