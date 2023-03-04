--[[

This module prints the list of all Pokémon,
alternative forms included having a given
egg group. It splits them between single and
double egg group.

--]]

local g = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local form = require('Wikilib-forms')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local multigen = require('Wikilib-multigen')
local css = require('Css')
local ms = require('MiniSprite')
local resp = require('Resp')
local pokes = require('Poké-data')
local groups = require('PokéEggGroup-data')
-- stylua: ignore end

form.loadUseless(true)
local alt = form.allFormsData()

--[[

Base class for specialized list entry
(single and double egg group): it is
not utilizable directly because it does
not filter the egg group.

--]]
g.Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Constructor: first argument is an entry
from PokéEggGroup/data, second one its key.
Subclasses are to return nil, as specified
by makeList in Wikilib/lists.

--]]
g.Entry.new = function(eggData, name, group)
    local baseName, abbr = form.getnameabbr(name)
    local pokeData =
        tab.merge(multigen.getGen(eggData), pokes[name] or pokes[baseName])
    pokeData = multigen.getGen(pokeData)
    local this = g.Entry.super.new(name, pokeData.ndex)

    this.group = group
    this.formsData = alt[baseName]
    this.formsData = this.formsData and tab.copy(this.formsData)
    if this.formsData and not this.formsData.names[abbr] then
        -- Se la forma non esiste in alt[baseName] è una versione evento che non esiste
        -- nei moduli dati. Prende tutti i dati dalla forma normale
        this.formsData.links[abbr] = this.formsData.links.base:gsub(
            this.formsData.names.base,
            '<div class="text-small">Evento</div>'
        )
    end
    this.formAbbr = abbr
    -- Se c'è un'altra forma del Pokémon in PokéEggGroup-data
    -- ha senso scrivere la forma, altrimenti no
    if abbr ~= "base" then
        this.formLink = this.formsData and this.formsData.links or {}
    else
        this.formLink = {}
        for k in pairs(this.formsData.names) do
            if groups[baseName .. k] then
                this.formLink = this.formsData and this.formsData.links or {}
                break
            end
        end
    end

    return setmetatable(tab.merge(this, pokeData), g.Entry)
end

--[[

Styles for egg groups boxes, given as arguments for eggBoxLua. The indices are
numeric so that they can be easier used to call functions.

--]]
g.Entry.eggBox = {
    { "thick" }, -- pdfs
    { "vert-center" }, -- classes
    { height = "100%" }, -- styles
}

--[[

Styles for egg groups cells, given as arguments for eggsTwoCells. The indices
are numeric so that they can be easier used to call functions.

--]]
g.Entry.eggCell = {
    { "one-box-cell" }, -- pdfs
    false, -- bp
    {}, -- classes
    { height = "100%" }, -- styles
}

--[[

Function that creates the egg group cells
in the __tostring method. It's body is
separated from that method because
Egggrouplist-allgroups overrides it.

--]]
g.Entry.groupsString = function(this)
    if not this.group2 then
        return ""
    end

    local group =
        txt.fu(this.group1 == this.group and this.group2 or this.group1)

    -- Little abuse here, but ensures styles consistency
    return "|"
        .. resp.eggsTwoCellsLua(group, nil, g.Entry.eggBox, g.Entry.eggCell)
end

--[[

Wikicode for a list entry: Pokémon ndex,
mini sprite, name and types. Mono-typed
Pokémon display the type only once.

--]]
g.Entry.__tostring = function(this)
    local twoGroups = this.group2 ~= nil
    return txt.interp(
        [=[| class="min-width-xs-20" | ${ndex}
| class="min-width-xs-20" | ${static}
| class="min-width-xs-60" style="padding: 0 0.5em;" | [[${name}]]${form}
| class="min-width-xl-${typesWidth} width-xs-100" style="padding: 1ex 0.8ex; height: 100%;" | ${types}${groups}]=],
        {
            ndex = this.ndex and txt.tf(this.ndex) or "???",
            static = ms.staticLua({
                txt.tf(this.ndex or 0)
                    .. (this.formAbbr == "base" and "" or this.formAbbr or ""),
            }),
            name = this.name,
            form = this.formLink[this.formAbbr] or "",
            typesWidth = twoGroups and "20" or "30",
            types = resp.twoTypeBoxesLua(
                this.type1,
                this.type2,
                { "thin" },
                nil,
                { "vert-center" }
            ),
            groups = this:groupsString(),
        }
    )
end

-- Single-grouped Pokémon entry class
g.SingleGroupEntry = oop.makeClass(g.Entry)

-- Creates Single-grouped headings
g.SingleGroupEntry.header = "===Solo in questo gruppo==="

--[[

Constructor: the first argument is an entry
from PokéEggGroup/data, the second one its key and
the third is the group the Pokémon must have.
As specified by makeList in Wikilib/lists,
returns nil whenever the Pokémon is either
dual-grouped or not of the passed group.

--]]
g.SingleGroupEntry.new = function(eggData, name, group)
    if eggData.group2 or group ~= eggData.group1 then
        return nil
    end

    return setmetatable(
        g.SingleGroupEntry.super.new(eggData, name, group),
        g.SingleGroupEntry
    )
end

-- First-typed Pokémon entry class
g.DoubleGroupEntry = oop.makeClass(g.Entry)

-- Creates first-typed headings
g.DoubleGroupEntry.header = "===In questo gruppo e in un altro==="

--[[

Constructor: the first argument is an entry
from PokéEggGroup/data, the second one its key and
the third is the group the Pokémon must have
as first. As specified by makeList in Wikilib/lists,
returns nil whenever the Pokémon is either
single-grouped or it hasn't the passed one.

--]]
g.DoubleGroupEntry.new = function(eggData, name, group)
    if
        not eggData.group2
        or not tab.search(multigen.getGen(eggData), group)
    then
        return nil
    end

    return setmetatable(
        g.DoubleGroupEntry.super.new(eggData, name, group),
        g.DoubleGroupEntry
    )
end

--[[

Wikicode for list header: it takes the group
name, for colors, and the number of groups,
to print the correct amount of group columns.

--]]
local makeHeader = function(group, groupsCount)
    return txt.interp(
        [=[{| class="roundy-corners sortable pull-center text-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|- class="hidden-xs"
! style="padding-top: 0.5ex; padding-bottom: 0.5ex; padding-left: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">#</span>]]
! class="unsortable" | &nbsp;
! [[Pokémon|<span style="color:#000">Pokémon</span>]]
! [[Tipo|<span style="color:#000">Tipo</span>]]
${groups}]=],
        {
            bg = css.horizGradLua({ type = group:gsub(" ", "_") .. "_uova" }),
            groups = groupsCount < 2 and ""
                or '! [[Gruppi Uova|<span style="color:#000">Altro gruppo</span>]]',
        }
    )
end

--[[

Creates heading and HTML table for
Pokémons of a given type. Its first
argument is such type, the second one
an Entry class complying to makeList
in Wikilib/listm and the third is the
heading line. The latter argument is
optional, defaulting to the return
of the Entry class makeHeader method.

--]]
g.makeGroupTable = function(group, Entry, header, headerGenerator)
    headerGenerator = headerGenerator or makeHeader
    return table.concat({
        header or Entry.header,
        list.makeList({
            source = groups,
            iterator = list.pokeNames,
            entryArgs = group,
            makeEntry = Entry.new,
            header = headerGenerator(
                group,
                Entry == g.SingleGroupEntry and 1 or 2
            ),
            separator = '|- class="roundy flex-xs flex-wrap flex-main-center flex-items-center" style="margin: 0.5rem 0; height: 100%;"',
        }),
    }, "\n")
end

--[[

Wikicode interface function: takes a egg group
as the title of its page ('<group> (Gruppo Uova)')
and prints a list fo all the Pokémon having
only such group. Heading for sublists are also displayed.

Examples:
{{#invoke: Egggrouplist | singlegrouplist | Mostro (Gruppo Uova) }}

(in type pages only)
{{#invoke: Egggrouplist | singlegrouplist | {{BASEPAGENAME}} }}

--]]
g.singlegrouplist = function(frame)
    -- Extracting type from page title
    local group = string
        .trim(mw.text.decode(frame.args[1] or "sconosciuto (Gruppo Uova)"))
        :match("^([%a%d%s]+) %(Gruppo Uova%)$")
        :lower()

    return g.makeGroupTable(group, g.SingleGroupEntry)
end

g.Singlegrouplist, g.singleGroupList, g.SingleGroupList =
    g.singlegrouplist, g.singlegrouplist, g.singlegrouplist

--[[

Wikicode interface function: takes a egg group
as the title of its page ('<group> (Gruppo Uova)')
and prints a list fo all the Pokémon having
both that and another group. Heading for
sublists are also displayed.

Examples:
{{#invoke: Egggrouplist | doublegrouplist | Mostro (Gruppo Uova) }}

(in type pages only)
{{#invoke: Egggrouplist | doublegrouplist | {{BASEPAGENAME}} }}

--]]
g.doublegrouplist = function(frame)
    -- Extracting type from page title
    local group = string
        .trim(mw.text.decode(frame.args[1] or "sconosciuto (Gruppo Uova)"))
        :match("^([%a%d%s]+) %(Gruppo Uova%)$")
        :lower()

    return g.makeGroupTable(group, g.DoubleGroupEntry)
end

g.Egggrouplist, g.eggGroupList, g.EggGroupList =
    g.egggrouplist, g.egggrouplist, g.egggrouplist

return g
