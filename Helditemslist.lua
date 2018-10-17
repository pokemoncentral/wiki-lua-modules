--[[

Module to create an entry in the list of Pokémon by wild held items.

--]]

local h = {}

local mw = require('mw')

local w = require('Wikilib')
local txt = require('Wikilib-strings')          -- luacheck: no unused
local tab = require('Wikilib-tables')           -- luacheck: no unused
local games = require('Wikilib-games')
local oop = require('Wikilib-oop')
local list = require('Wikilib-lists')
local multigen = require('Wikilib-multigen')
local links = require('Links')
local ms = require('MiniSprite')
local css = require('Css')
local pokes = require("Poké-data")
local abbrevModules = {
	blackabbrev = require('Blackabbrev-data'),
	colorabbrev = require('Colorabbrev-data'),
}

h.Entry = oop.makeClass(list.PokeSortableEntry)

-- Utility strings
h.Entry.strings = {
	ENTRY_HEAD = [=[<div class="roundy flex flex-row flex-wrap flex-main-center flex-items-center text-center width-xl-100" style="padding: 0.5ex; margin: 1ex 0; ${bg}">
<div class="roundy flex flex-row flex-nowrap flex-main-center flex-items-center" style="padding: 0 1ex; margin: 0.5ex; background: #fff;">
<div>'''${ndex}'''</div>
<div>${ms}</div>
<div>[[${name}]]${blacklink}</div>
</div>
<div class="flex flex-row flex-wrap flex-main-space-around flex-items-stretch">]=],
	ENTRY_FOOT = [[</div></div>]],

	BOX_HEAD = [[<div class="roundy flex flex-row flex-wrap flex-main-space-around flex-items-center" style="background: #fff; margin: 0.5ex;">]],
	BOX_FOOT = [[</div>]],

	PERC_BOX = [=[<div style="padding: 1ex;">
<div>${abbrev}</div>
<div>${img}</div>
<div>${percentage}%</div>
</div>]=]
}

--[[

Create a single game box taking an array of item/game tables (element of the
data module array).

--]]
h.Entry.makeGameBox = function(this, itemsList, gen)
	percBoxes = table.map(itemsList, function(v)
		local abbrevs = table.concat(table.map(v.games, function(abbr, index)
			if v.abbrTypes then
				return abbrevModules[v.abbrTypes[index]][abbr]
			else
				return abbrevModules.blackabbrev[abbr]
			end
		end))
		return string.interp(this.strings.PERC_BOX, {
			abbrev = abbrevs,
			img = gen < 3
					and string.interp(
						'[[${item}|<span style="color: #000;">${item}</span>]]',
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
    local this = h.Entry.super.new(poke, pokes[poke].ndex)

	this.helds = helds

    return setmetatable(this, h.Entry)
end

--[[

Wikicode for a list entry.

--]]
h.Entry.__tostring = function(this)
	local pokedata = multigen.getGen(pokes[this.name])
	local form = type(this.formsData) == 'table'
				and this.formsData.blacklinks[this.formAbbr]
				or ''

	local result = { string.interp(this.strings.ENTRY_HEAD, {
		bg = css.slantedGradLua{
			150,
			type = pokedata.type1,
			type2 = pokedata.type2
		},
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
h.helditem = function(frame)
	return list.makeList{
		source = require("Helditems-data"),
		makeEntry = h.Entry.new,
		iterator = list.pokeNames,
		header = '',
		separator = '',
		footer = '',
	}
end
h.Helditem = h.helditem

return h
