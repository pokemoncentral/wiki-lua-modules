--[[

Module to create an entry in the list of Pokémon by wild held items.

--]]

local h = {}

local txt = require('Wikilib-strings')          -- luacheck: no unused
local tab = require('Wikilib-tables')           -- luacheck: no unused
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local multigen = require('Wikilib-multigen')
local links = require('Links')
local ms = require('MiniSprite')
local pokes = require("Poké-data")
local blackabbrev = require("Blackabbrev-data")
local colorabbrev = require("Colorabbrev-data")

h.Entry = oop.makeClass(list.PokeLabelledEntry)

-- Utility strings
h.Entry.strings = {
	ENTRY_HEAD = [=[<div class="roundy text-center width-xl-100 flex flex-row flex-wrap flex-main-center flex-items-center horiz-grad-${type1}-${type2}" style="padding: 0.5ex; margin: 1ex 0">
<div class="roundy bg-white flex flex-row flex-nowrap flex-main-center flex-items-center" style="padding: 0 1ex; margin: 0.5ex;">
<div>'''${ndex}'''</div>
<div>${ms}</div>
<div>[[${name}]]${blacklink}</div>
</div>
<div class="flex-row-stretch-around flex-wrap">]=],
	ENTRY_FOOT = [[</div></div>]],

	BOX_HEAD = [[<div class="roundy bg-white flex-row-center-around flex-wrap" style="margin: 0.5ex;">]],
	BOX_FOOT = [[</div>]],

	PERC_BOX = [=[<div style="padding: 1ex;">
<div>${abbrev}</div>
<div>${img}</div>
<div>${percentage}%</div>
</div>]=]
}

-- Table to get colored abbrevs from type and game abbr
h.Entry.abbrevs = {
	black = function(abbr) return blackabbrev[abbr] end,
	color = function(abbr) return table.concat{
			"&nbsp;", colorabbrev[abbr], "&nbsp;"
		}
	end,
}


--[[

Create a single game box taking an array of item/game tables (element of the
data module array).

--]]
h.Entry.makeGameBox = function(this, itemsList, gen)
	local percBoxes = table.map(itemsList, function(v)
		local abbrevs = table.concat(table.map(v.games, function(abbr, index)
			if v.abbrTypes then
				return this.abbrevs[v.abbrTypes[index]](abbr)
			else
				return this.abbrevs.black(abbr)
			end
		end))
		return string.interp(this.strings.PERC_BOX, {
			abbrev = abbrevs,
			img = gen < 3
					and string.interp(
						'<span class="black-text">[[${item}]]</span>',
						{ item = v.item }
					)
					or links.bag(v.item),
			percentage = v.perc,
		})
	end)

	if #percBoxes > 0 then
		table.insert(percBoxes, this.strings.BOX_FOOT)
		return this.strings.BOX_HEAD .. table.concat(percBoxes)
	else
		return ''
	end
end

--[[

Constructor: the first argument is an entry from HeldItems/data, the second one
is its key.

--]]
h.Entry.new = function(helds, poke)
	-- Skip empty entries
	if #helds == 0 then
		return
	end

    local this = h.Entry.super.new(poke, pokes[poke].ndex)

	this.helds = helds

    return setmetatable(this, h.Entry)
end

--[[

Equality operator for grouping. True iff the two entries have the exact same
this.helds

--]]
h.Entry.__eq = function(a, b)
	return a.ndex == b.ndex and table.equal(a.helds, b.helds)
end

--[[

Wikicode for a list entry.

--]]
h.Entry.__tostring = function(this)
	local pokedata = multigen.getGen(pokes[this.name])
	local form = "<div>" .. table.concat(table.map(this.labels, function(label)
		return this.formsData.blacklinks[label]:gsub("<(/?)div", "<%1span")
	end), ", ") .. "</div>"

	local result = { string.interp(this.strings.ENTRY_HEAD, {
		type1 = pokedata.type1,
		type2 = pokedata.type2,
		ndex = string.tf(this.ndex),
		ms = ms.staticLua(string.tf(this.ndex) .. (this.formAbbr == 'base'
				and '' or this.formAbbr or '')),
		name = pokedata.name,
		blacklink = form,
	})}

	table.map(this.helds, function(v, gen)
		table.insert(result, this:makeGameBox(v, gen))
	end, ipairs)

	table.insert(result, this.strings.ENTRY_FOOT)
	return table.concat(result)
end


--[[

Main wikicode interface.

--]]
h.helditem = function(_)
	return list.makeGroupedList{
		source = require('PokéItems-data'),
		makeEntry = h.Entry.new,
		iterator = list.pokeNames,
		header = '',
		separator = '',
		footer = '',
		fullGroupLabel = '',
	}
end
h.Helditem = h.helditem

return h
