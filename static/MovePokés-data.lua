#!/usr/bin/lua
--[[

Offline generator of module MovePokés-data.

Running this locally creates automatically the data module in the parent
directory. Supposing this is inside the "static" subdir of wiki-lua-modules
this creates the module in the right place for local testing, and of course
the result can be uploaded by standard means.

This module is intended to contain any information computable from
PokéMoves-data but that is (supposed to be) too heavy for an online
computation, so it's precomputed.

Right now the biggest issue is memory, but that doesn't really matter, the
point is we've to compute it statically.

--]]

package.path = "../?.lua;" .. package.path

local mp = {}

local DataDumper = require('dumper')
local tab = require('Wikilib-tables')       -- luacheck: no unused
local lib = require('Wikilib-learnlists')
local pokemoves = require("PokéMoves-data")

--[[

For each tutor move, compute the set of games in which it's a tutor. It assumes
that a move is a tutor in a game iff there exists a Pokémon that learns it via
tutor in that game.

--]]

-- mp.movetutorpresence is a table that maps move names to arrays of booleans
-- that specify whether that move is a tutor in the game with that index
mp.movetutorpresence = { }

local startidx = { }
local basemove = { }
local basemovelen = table.fold(lib.games.tutor, 0, function(acc, t)
    table.insert(startidx, acc)
    return acc + #t
end, ipairs)
for _ = 1, basemovelen do
    table.insert(basemove, false)
end

for _, poke in pairs(pokemoves) do
    for gen, gentutor in ipairs(poke.tutor) do
        local si = startidx[gen]
        for move, tutorarray in pairs(gentutor) do
            if not mp.movetutorpresence[move] then
                mp.movetutorpresence[move] = table.copy(basemove)
            end
            local tgm = mp.movetutorpresence[move]
            for i, learn in ipairs(tutorarray) do
                tgm[si + i] = tgm[si + i] or learn
            end
        end
    end
end

-- mp.movetutorindexes is a table that maps move names to an array of indexes
-- of games in which that move is a tutor
mp.movetutorindexes = table.map(mp.movetutorpresence, function(presence)
    return table.fold(presence, {}, function(acc, pres, idx)
        if pres then
            table.insert(acc, idx)
        end
        return acc
    end, ipairs)
end)

-- ============================== Final printing ==============================
local comment = [=[
--[[

This module is intended to contain any information computable from
PokéMoves-data but that is (supposed to be) too heavy for an online
computation, so it's precomputed.

This module is computed from a script, so
    ANY CHANGE WILL BE OVERWRITTEN WITH THE NEXT UPLOAD
To modify this module, contact an administrator.
Probably if you want to modify this module you should instead modify
PokéMoves/data.

--]]

]=]

local outfile = io.open("../" .. arg[0], "w")
outfile:write(comment)
outfile:write(DataDumper(mp, nil, true))
outfile:write("\n")
outfile:close()
