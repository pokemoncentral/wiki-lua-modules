--[[

This module contains utility functions
and data related to games

--]]

local g = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local formUtil = require('Wikilib-forms')
local genUtil = require('Wikilib-gens')
local gendata = require("Gens-data")
local alts = formUtil.allFormsData()

--[[

Lowercase abbreviations of main series
games in release order: Green is after
Red and Blue in order to avoid crashes
while retaining Red and Blue as first
games.

--]]
g.gamesChron = {}
for _, data in ipairs(gendata) do
    g.gamesChron = table.merge(
            g.gamesChron, data.games)
end

g.gamesOrder = g.gamesChron

--[[

This function returns wether the passed
Pokémon, exists in the given game.

The Pokémon can be passed as either name
or ndex, optionally followed by a form
abbreviation.

--]]
g.isInGame = function(poke, game)
    local ndex = string.parseInt(poke)
    local abbr = formUtil.getAbbr(poke)

    -- Pokémon given as a name
    if not ndex then
        local name = formUtil.getNameAbbr(poke)
        ndex = formUtil.getNdexForm(name)
    end

    --[[
        So far, completely new Pokémon have
        been released only in new generations.
        This, comparing generations is enough.
    --]]
	if abbr == 'base' then
		return genUtil.getGen.game(game)
				>= genUtil.getGen.ndex(ndex)
	end

	local alt = alts[ndex]
	local sinceOrd = table.search(g.gamesChron,
			alt.since[abbr])

    -- Until not found means available until latest game
    local untilOrd = (alt['until'] and alt['until'][abbr])
            and table.search(g.gamesChron, alt['until'][abbr])
            or #g.gamesChron
	local gameOrd = table.search(g.gamesChron,
			game)

	return gameOrd >= sinceOrd and gameOrd <= untilOrd
end

g.is_in_game, g.isingame = g.isInGame, g.isInGame

--[[

Returns whether the passed Pokémon is
present in the given generation.
Alternative forms can also be checked,
by passing the Pokémon name as the usual
name + abbreviation.

--]]
g.isInGen = function(poke, gen)
    local baseForm, abbr = formUtil.getNameAbbr(poke)

    if not abbr or abbr == '' then
        return genUtil.getGen.ndex(pokes[baseForm].ndex) <= gen
    end

    return g.anyInGen(gen, formUtil.formSpan(baseForm, abbr))
end
g.isingen, g.is_in_gen = g.isInGen, g.isInGen

--[[

Returns true if the first game passed
has been released previously than the
second.

--]]
g.isBefore = function(game1, game2)
    return table.search(g.gamesChron, game1)
            < table.search(g.gamesChron, game2)
end

g.is_before, g.isbefore = g.isBefore, g.isBefore

--[[

Returns true if at least one of the
specified games belongs to the passed
generation.

Games can be passed as an table in the
second argument, in which case the third
parameter will be ignored. Otherwise,
they can be expressed as a range between
two games, the second one being optional
and defaulting to the latest released game.

--]]

g.anyInGen = function(gen, from, to)

    --[[
        `from` is a game and no `to` is given:
        all games up to the latest are meant,
        so that we can check for `from` being
        released previously or in passed gen.
    --]]
    if type(from) ~= 'table' and not to then
        return genUtil.getGen.game(from) <= gen
    end

    -- Flipping for faster indexing check
    local games = table.flip(type(from) == 'table'
            and from
            or table.slice(g.gamesChron,
                    table.search(g.gamesChron, from),
                    table.search(g.gamesChron, to)
            ))

    return table.any(gendata[gen].games, function(game)
        return games[game]
    end)
end

g.any_in_gen, g.anyingen = g.anyInGen, g.anyInGen

return g
