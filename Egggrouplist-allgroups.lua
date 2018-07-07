--[[

This module has the sole purpose of
creating the list of Pokémon by type
in the namesake page.

--]]

local g = {}

local css = require('Css')
local resp = require('Resp')
local str = require('Wikilib-strings')      -- luacheck: no unused
local tab = require('Wikilib-tables')       -- luacheck: no unused
local tl = require('Egggrouplist')
local data = require("Wikilib-data")

--[[

Override of this method: prints
both egg groups in the full list

--]]
tl.Entry.groupsString = function(this)
    local otherGroup = this.group1 == this.group and this.group2 or this.group1
    return '|' .. resp.eggsTwoCellsLua(this.group, otherGroup,
        tl.Entry.eggBox, tl.Entry.eggCell)
end

--[[

Sorting function for Entry:
Pokémon with two groups are sorted first for
second group order, then for ndex

--]]
tl.DoubleGroupEntry.__lt = function(a, b)
	if a.type2 == b.type2 then
		return tl.DoubleGroupEntry.super.__lt(a, b)
	end

	return a.type2 < b.type2
end

--[[

Wikicode for list header: it takes the group
name, for colors, and the number of groups,
to print the correct amount of group columns.

--]]
local makeHeader = function(group, groupsCount)
	return string.interp([=[{| class="roundy-corners sortable pull-center text-center white-rows" style="border-spacing: 0; padding: 0.3ex; ${bg};"
|- class="hidden-xs"
! style="padding-top: 0.5ex; padding-bottom: 0.5ex; padding-left: 0.5ex;" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">#</span>]]
! class="unsortable" | <span class="hidden-xs">&nbsp;</span>
! [[Pokémon|<span style="color:#000">Pokémon</span>]]
! class="unsortable" | [[Tipo|<span style="color:#000">Tipo</span>]]
${groups}]=],
{
	bg = css.horizGradLua{type = group:gsub(' ', '_') .. '_uova'},
	groups = table.concat{
		'! [[Gruppi uova|<span style="color:#000">Primo gruppo</span>]]\n',
		groupsCount < 2 and '' or '! [[Gruppi uova|<span style="color:#000">Altro gruppo</span>]]'
	},
})
end

--[[

Wikicode interface: takes no parameters
and returns the list of all Pokémon by
type, with relative headings for every
part. Indeed, they are divided, for each
type, into mono-typed and first-typed,
the latter being sorted by second type.

Example:
{{#invoke: Typelist/alltypes | typelist }}

--]]
g.grouplist = function(frame)
	local tables = {}

	for _, group in ipairs(data.allGroups) do
		table.insert(tables, tl.makeGroupTable(group, tl.SingleGroupEntry, table.concat{'===Solo nel gruppo ', string.fu(group), '==='}, makeHeader))
		-- groups Ditto and Sconosciuto doesn't have the double entry
		if group ~= 'ditto' and group ~= 'sconosciuto' then
			table.insert(tables, tl.makeGroupTable(group, tl.DoubleGroupEntry, table.concat{'===Nel gruppo ', string.fu(group), ' e in un altro==='}, makeHeader))
		end
	end

	return table.concat(tables, '\n')
end

g.Grouplist, g.GroupList, g.groupList = g.grouplist,
		g.grouplist, g.grouplist

print(g.grouplist())

-- return g
