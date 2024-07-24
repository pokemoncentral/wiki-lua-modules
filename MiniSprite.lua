--[[

Module to insert MiniSprites.

Examples:

{{#invoke: MiniSprite | static | 487O }}
{{#invoke: MiniSprite | ani | 63 | gen = 2 }}
{{#invoke: MiniSprite | static | 398 | gen = 7 }}
{{#invoke: MiniSprite | static | 398 | female = yes | shiny = yes }}
{{#invoke: MiniSprite | static | 398 | game = LPA }}

--]]

local o = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local genlib = require('Wikilib-gens')
local wlib = require('Wikilib')
local gendata = require("Gens-data")
local pokes = require("Poké-data")
-- stylua: ignore end

-- Alias for generations with the same MS
local genAliases = {}
genAliases[3] = 5
genAliases[4] = 5
genAliases[6] = 7

-- Interp strings for static ms of specific games
local staticGamesString = {
    spsc = "[[File:${num}MSSpSc.png|${name}|40px|link=${name}]]",
    dlps = "[[File:${num}MSDLPS.png|${name}|40px|link=${name}]]",
    lpa = "[[File:Iconlpa${gender}${shiny}${num}.png|${name}|40px|link=${name}]]",
}

-- Return true if the given generation has only static MS
local function staticOnly(gen)
    return gen > 5
end

-- Return true if the given generation has only animated MS
local function aniOnly(gen)
    return gen < 3
end

--[[

Preprocess the arguments to make them more suitable for the module internals.

--]]
local function preprocess(n, gen, game, link)
    n = n or "0000"

    game = game and string.lower(game)
    local gameGen = game and genlib.getGen.game(game)

    -- If game is specified, overrides the gen
    gen = gameGen or tonumber(gen) or gendata.latest
    gen = genAliases[gen] or gen

    if not link then
        local numberN = txt.parseInt(n)
        if pokes[numberN] then
            link = pokes[numberN].name
        elseif n:find(".*[Uu]ovo.*") then
            link = "Uova Pokémon"
        else
            link = "MissingNo"
        end
    end
    return n, gen, game, link
end

--[[

Proxy for Wikicode interfaces: takes arguments from the MW format and returns
arguments for Lua calls.
Supports the following arguments. The ndex can be also the first argument.
    - 1 | ndex: ndex number
    - link (optional): link for the image (by default the Pokémon page)
    - gen (optional): generation of the MS
    - game (optional): game of the MS (if provided, overrides gen)
    - female (optional): for gen 8 and after, use the female MS if given
    - shiny (optional): for gen 8 and after, use the shiny MS if given

DEPRECATION WARNING: link and gen were supported as second and third positional
arguments, respectively. While they still are, the behavious is considered
deprecated and could be removed at any time.

--]]

local function splitMwArgs(args)
    args = wlib.trimAll(mw.clone(args), true)
    return {
        ndex = args.ndex or args[1],
        gen = args.gen or args[3],
        game = args.game,
        link = args.link or args[2],
        female = args.female,
        shiny = args.shiny,
    }
end

-- Animated MS, Lua call
o.aniLua = function(args)
    local n, gen, game, link =
        preprocess(args.ndex or args[1], args.gen, args.game, args.link)
    if staticOnly(gen) then
        args.ndex = n
        args.game = game
        args.gen = gen
        args.link = link
        return o.staticLua(args)
    end
    -- Here we can assume gen < 8, so filenames are much more consistent
    return txt.interp(
        "[[File:Ani${num}MS${gen}.gif|${name}|link=${name}]]",
        { num = n, gen = gen, name = link }
    )
end
o.ani_lua = o.aniLua

-- Animated MS, Wikicode interface
o.ani = function(frame)
    return o.aniLua(splitMwArgs(frame.args))
end
o.Ani, o.AniP, o.aniP = o.ani, o.ani, o.ani

-- Static MS, Lua call
o.staticLua = function(args)
    local n, gen, game, link =
        preprocess(args.ndex or args[1], args.gen, args.game, args.link)
    if aniOnly(gen) then
        args.ndex = n
        args.game = game
        args.gen = gen
        args.link = link
        return o.aniLua(args)
    end
    local interpData = {
        num = n,
        gen = tostring(gen),
        name = link,
        gender = args.female == "yes" and "f" or "m",
        shiny = args.shiny == "yes" and "sh" or "",
    }
    local interpString = staticGamesString[game]
    if interpString == nil then
        if gen < 8 then
            interpString = "[[File:${num}MS${gen}.png|${name}|link=${name}]]"
        else
            interpString =
                "[[File:Mini${gender}${shiny}${num}.png|${name}|40px|link=${name}]]"
        end
    end
    return txt.interp(interpString, interpData)
end
o.static_lua = o.staticLua

-- Static MS, Wikicode interface
o.static = function(frame)
    return o.staticLua(splitMwArgs(frame.args))
end
o.Static, o.staticP, o.StaticP = o.static, o.static, o.static

return o
