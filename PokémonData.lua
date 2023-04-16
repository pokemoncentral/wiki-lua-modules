--[[

Module used as a frontend to wikicode for data modules.

Each interface function is documented in its own comment, with examples.

--]]

local b = {}

-- Data modules aren't loaded here because they probably won't be used

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local formlib = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local wlib = require('Wikilib')
local cc = require('ChooseColor')
-- stylua: ignore end

--[[

Given the frame.args, find out which Pokémon the caller wants, and return a
value to index data module to get that Pokémon.

Inspects the first argument, which should be either the name or the ndex (the
latter possibly with an abbr), and the 'form' named argument, which can specify
the abbr when the first parameter is the name.

--]]
local function parseName(args)
    local p = wlib.trimAll(args)
    return formlib.nameToDataindex(mw.text.decode(p[1]), p.form)
end

--[[

Returns the ndex given the name. Note that this is the plain (ingame) ndex even
for alternative forms.

Ex:
{{#invoke: PokémonData | getNdex | Staraptor }}            --> 0398
{{#invoke: PokémonData | getNdex | alakazam }}             --> 0065
{{#invoke: PokémonData | getNdex | giratina | form = O }}  --> 0487

--]]
b.getNdex = function(frame)
    local pokes = require("Poké-data")
    return txt.ff(pokes[parseName(frame.args)].ndex)
end
b.get_ndex = b.getNdex

--[[

Returns the name given ndex. The argument can be an alternative forms' ndex.

Ex:
{{#invoke: PokémonData | getNdex | 398 }}   --> Staraptor
{{#invoke: PokémonData | getNdex | 65 }}    --> Alakazam
{{#invoke: PokémonData | getNdex | 487O }}  --> Giratina

--]]
b.getName = function(frame)
    local pokes = require("Poké-data")
    return pokes[parseName(frame.args)].name
end
b.get_name = b.getName

--[[

Return the form name given ndex with abbr. If the abbr doesn't have a form name
(or there's no abbr at all) it returns an empty string.

Ex:
{{#invoke: PokémonData | getFormName | 800A }}  --> Necrozma Ali dell'Aurora
{{#invoke: PokémonData | getFormName | 422E }}  --> Mare Est
{{#invoke: PokémonData | getFormName | 422 }}   --> Mare Ovest
{{#invoke: PokémonData | getFormName | 28 }}    --> (empty string)

--]]
b.getFormName = function(frame)
    local forms = formlib.allFormsData()
    local p = wlib.trimAll(frame.args)
    local name, abbr = formlib.getndexabbr(p[1], p.form)
    return forms[name] and forms[name].names[formlib.toBase(abbr)] or ""
end

--[[

Returns a Pokémon's ability (specified by the second parameter) given its name
or ndex. The optional third parameter is the generation.
The name can contain a form abbreviation, and if it's a Pokémon name (not an
ndex) it should be lowercase but the first letter, that can be both upper or
lower case.

--]]
local function getAbil(frame, abilityNumber, gen)
    local abils = require("PokéAbil-data")
    return multigen.getGenValue(
        abils[parseName(frame.args)]["ability" .. abilityNumber] or "",
        tonumber(gen)
    )
end

--[[

Returns a Pokémon's first ability given its name or ndex. An optional 'gen'
parameter specifies the generation.

Ex:
{{#invoke: PokémonData | getAbil1 | 065 }}   --> Sincronismo
{{#invoke: PokémonData | getAbil1 | Alakazam }}  --> Sincronismo
{{#invoke: PokémonData | getAbil1 | 487O }}  --> Levitazione
{{#invoke: PokémonData | getAbil1 | 094 | gen = 5 }}  --> Levitazione

--]]
b.getAbil1 = function(frame)
    return getAbil(frame, "1", frame.args.gen)
end
b.get_abil_1 = b.getAbil1

--[[

Returns a Pokémon's second ability given its name or ndex. If the Pokémon
has no second ability, it returns an empty string. An optional 'gen'
parameter specifies the generation.

Ex:
{{#invoke: PokémonData | getAbil2 | 65 }}    --> Forza Interiore
{{#invoke: PokémonData | getAbil2 | Alakazam }} --> Forza Interiore
{{#invoke: PokémonData | getAbil2 | 398 }}   --> (empty string)

--]]
b.getAbil2 = function(frame)
    return getAbil(frame, "2", frame.args.gen)
end
b.get_abil_2 = b.getAbil2

--[[

Returns a Pokémon's hidden ability given its name or ndex. If the Pokémon
has no hidden ability, it returns an empty string. An optional 'gen'
parameter specifies the generation.

Ex:
{{#invoke: PokémonData | getAbild | 65 }}    --> Magicscudo
{{#invoke: PokémonData | getAbild | Alakazam }}    --> Magicscudo
{{#invoke: PokémonData | getAbild | 487O }}  --> (empty string)

--]]
b.getAbild = function(frame)
    return getAbil(frame, "d", frame.args.gen)
end
b.get_abil_d, b.get_abil_h, b.get_abil_n = b.getAbild, b.getAbild, b.getAbild

--[[

Returns a Pokémon's event ability given its name or ndex. If the Pokémon
has no event ability, it returns an empty string. An optional 'gen'
parameter specifies the generation.

Ex:
{{#invoke: PokémonData | getAbile | 487O }}  --> (empty string)
{{#invoke: PokémonData | getAbile | 744 }}   --> Mente Locale

--]]
b.getAbile = function(frame)
    return getAbil(frame, "e", frame.args.gen)
end
b.get_abil_e = b.getAbile

--[[

Returns a Pokémon's type (specified by the second parameter) given its name or
ndex. If the third parameter is true return the short version of the type (ie.
Coleottero becomes Coleot if the Pokémon has two types), otherwise return the
full name. Optional parameters are gen, to specify the generation, and form, to
specify the form abbr.

--]]
local function getType(frame, typeNumber, short)
    local pokes = require("Poké-data")
    local p = wlib.trimAll(frame.args)
    local type = multigen.getGenValue(
        pokes[parseName(p)]["type" .. typeNumber],
        tonumber(p.gen)
    )
    if not short then
        type = type == "coleot" and "coleottero" or type
    end
    return txt.fu(type)
end

--[[

Returns a Pokémon's first type given its name or ndex. An optional 'gen'
parameter specifies the generation.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | getType1 | 398 }}    --> Normale
{{#invoke: PokémonData | getType1 | Staraptor }}    --> Normale
{{#invoke: PokémonData | getType1 | 493Fu }}  --> Fuoco
{{#invoke: PokémonData | getType1 | Aegislash | form = S }}  --> Spettro

--]]
b.getType1 = function(frame)
    return getType(frame, "1", false)
end
b.get_type_1 = b.getType1

--[[

Returns a Pokémon's second type given its name or ndex. If the Pokémon has
only one type, it returns the first type instead. An optional 'gen' parameter
specifies the generation.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | getType2 | 398 }}   --> Volante
{{#invoke: PokémonData | getType2 | Staraptor }}  --> Volante
{{#invoke: PokémonData | getType2 | 65 }}    --> Psico
{{#invoke: PokémonData | getType2 | 479L }}  --> Acqua
{{#invoke: PokémonData | getType2 | 082 | gen = 1 }}  --> Elettro
{{#invoke: PokémonData | getType2 | Giratina | form = O }}  --> Drago

--]]
b.getType2 = function(frame)
    return getType(frame, "2", false)
end
b.get_type_2 = b.getType2

--[[

Same as getType1/2 but return the short version of the type, that is
"Coleottero" becomes "Coleot" if the Pokémon has two types.

Ex:
{{#invoke: PokémonData | getShortType2 | 752 }}   --> Coleot
{{#invoke: PokémonData | getShortType1 | 0752 }}  --> Acqua
{{#invoke: PokémonData | getShortType1 | Caterpie }}  --> Coleottero

--]]
b.getShortType1 = function(frame)
    return getType(frame, "1", true)
end
b.getShortType2 = function(frame)
    return getType(frame, "2", true)
end

--[[

Returns a Pokémon's types given its name or ndex, in a format suitable to be
used as CSS gradient classes. An optional 'gen' parameter specifies the
generation.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | gradTypes | 398 }}   --> normale-volante
{{#invoke: PokémonData | gradTypes | Staraptor }}  --> normale-volante
{{#invoke: PokémonData | gradTypes | 65 }}    --> psico-psico
{{#invoke: PokémonData | gradTypes | 479L }}  --> elettro-acqua
{{#invoke: PokémonData | gradTypes | 082 | gen = 1 }}  --> elettro-elettro

--]]
b.gradTypes = function(frame)
    return table.concat({ b.getType1(frame), b.getType2(frame) }, "-"):lower()
end
b.grad_types = b.gradTypes

--[[

Returns a Pokémon's stats (specified by the second parameter) given its name or
ndex. An optional 'gen' parameter specifies the generation. If the Pokémon
doesn't have the stat (i.e: stat "spec" of a non gen 1 Pokémon) return an empty
string.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | getStat | 398 | hp }}     --> 85
{{#invoke: PokémonData | getStat | Staraptor | hp }}    --> 85
{{#invoke: PokémonData | getStat | 65 | spatk }}   --> 135
{{#invoke: PokémonData | getStat | 487O | def }}   --> 100
{{#invoke: PokémonData | getStat | 189 | spdef | gen = 2 }}  --> 85

--]]
b.getStat = function(frame)
    local stats = require("PokéStats-data")
    local stat = txt.trim(frame.args[2])
    return multigen.getGenValue(
        stats[parseName(frame.args)][stat],
        tonumber(frame.args.gen)
    )
end

--[[

The first parameter is an ndex (maybe with an abbr). Returns the second
parameter if the Pokémon has two types, otherwise the third. The two last
parameters are trimmed.
This function is meant to replace an #if parser function to check whether a
Pokémon has two types or not.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

--]]
b.ifTwoTypes = function(frame)
    local pokes = require("Poké-data")
    local poke = pokes[parseName(frame.args)]
    local isDualType = poke.type1 == poke.type2
    return isDualType and txt.trim(frame.args[2]) or txt.trim(frame.args[3])
end

--[[

Returns the link to an alternative form. The Pokémon name (first parameter) can
be both a name or a ndex followed by the abbr, the second argument is a flag
to get black or normal link.
The ndex may be the base form's one. If the ndex doesn't correspond to a
Pokémon with alternative forms, it returns an empty string.

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | getLink | 487 }}
{{#invoke: PokémonData | getLink | 487O }}
{{#invoke: PokémonData | getLink | 028A }}
{{#invoke: PokémonData | getLink | 028 }}
{{#invoke: PokémonData | getLink | 774R }}
{{#invoke: PokémonData | getLink | 398 }}

The second, optional paramenter is used to specify the kind of link. Can be
either "black" (a small, black link), "" (a small, normal link) or "plain"
(just the link). Default to ""

Ex:
{{#invoke: PokémonData | getLink | 487 | plain }}

--]]
b.getLink = function(frame)
    local name = txt.trim(frame.args[1])
    local abbr = frame.args.form and txt.trim(frame.args.form)
    local black = txt.trim(frame.args[2] or "")
    -- Links also to UselessForms
    formlib.loadUseless(true)
    return formlib.getlink(name, black, abbr)
end
b.getlink = b.getLink

--[[

Returns a list of pairs (abbr, name) of alternative forms with different cry.
The list is comma-separated, with elements in a pair a separated by a dash.
If a Pokémon has no alternative form returns an empty string. If all forms have
the same cry, returns the special value 'all'

--]]
b.getCriesList = function(frame)
    local forms = require("AltForms-data")
    local result = {}
    local ndex = txt.trim(frame.args[1])
    local formData = forms[tonumber(ndex) or ndex]
    -- No alt forms case
    if formData == nil then
        return ""
    end
    -- No alt forms with different cries
    if not formData.cries then
        return "all"
    end
    -- Standard list
    table.map(formData.cries, function(abbr)
        table.insert(
            result,
            table.concat({
                abbr,
                "-",
                formData.names[abbr],
            })
        )
    end)
    return table.concat(result, ",")
end

--[[

Return the text color to use on a gradient made of a Pokémon's types. An
optional 'gen' parameter specifies the generation. The result is one of the two
css classes "white-text" and "black-text".

The form abbr can be included in the ndex, but not in the Pokémon name; in the
latter case, use the optional parameter 'form' to specify it.

Ex:
{{#invoke: PokémonData | getPokeTextColor | 398 }}               --> black-text
{{#invoke: PokémonData | getPokeTextColor | Staraptor }}         --> black-text
{{#invoke: PokémonData | getPokeTextColor | 498O }}              --> white-text
{{#invoke: PokémonData | getPokeTextColor | 082 | gen = 1 }}     --> black-text
{{#invoke: PokémonData | getPokeTextColor | Rotom | form = L }}  --> black-text

--]]
b.getPokeTextColor = function(frame)
    local type1 = b.getType1(frame):lower()
    local type2 = b.getType2(frame):lower()

    return cc.forModGradBgLua(type1, type2)
end

return b
