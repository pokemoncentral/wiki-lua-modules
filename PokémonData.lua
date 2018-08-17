--[[

Module used as a frontend to wikicode for data modules

--]]

local b = {}

-- Data modules aren't loaded here because they probably won't be used

local mw = require('mw')

local txt = require('Wikilib-strings') -- luacheck: no unused
local form = require('Wikilib-forms')
local data
local abils
local forms

--[[

Returns the passed table if it's already been loaded, otherwise the module
named after the second parameter is loaded and returned. The module is loaded
with mw.loadData unless the third parameter is true

--]]

local loadData = function(tab, moduleName, useRequire)
    if not tab then
        local loadFunction = useRequire and require or mw.loadData
        return loadFunction('Modulo:' .. moduleName)
    end
    return tab
end


-- Returns ndex given the name

b.getNdex = function(frame)
    data = loadData(data, 'Poké/data')
    return string.tf(data[string.trim(frame.args[1] or '')].ndex)
end

b.get_ndex = b.getNdex

-- Returns the name given ndex

b.getName = function(frame)
    data = loadData(data, 'Poké/data')
    local ndex = string.trim(frame.args[1] or '')
    return data[tonumber(ndex) or ndex].name
end

b.get_name = b.getName

--[[

Return the form name given ndex with abbr. If the ndex is without abbr, returns
the Pokémon name even if it hasn't got alternate forms.

--]]

b.getFormName = function(frame)
    forms = loadData(forms, 'AltForms/data')
    local name, abbr = form.getnameabbr(string.trim(frame.args[1]))
    return forms[name] and forms[name].names[abbr] or b.getName{args={name}}
end

--[[

Returns a Pokémon's ability (specified by the second parameter) given its name
or ndex.
The name can contain a form abbreviation, and if it's a Pokémon name (not an
ndex) it should be lowercase but the first letter, that can be both upper or
lower case.

--]]

local getAbil = function(name, abilityNumber)
    abils = loadData(abils, 'PokéAbil/data')
    return abils[form.nameToDataindex(name)]['ability' .. abilityNumber]
end

-- Returns a Pokémon's first ability given its name or ndex

b.getAbil1 = function(frame)
    return getAbil(frame.args[1] or '', '1')
end

b.get_abil_1 = b.getAbil1

-- Returns a Pokémon's second ability given its name or ndex

b.getAbil2 = function(frame)
    return getAbil(frame.args[1] or '', '2')
end

b.get_abil_2 = b.getAbil2

-- Returns a Pokémon's hidden ability given its name or ndex

b.getAbild = function(frame)
    return getAbil(frame.args[1] or '', 'd')
end

b.get_abil_d, b.get_abil_h, b.get_abil_n = b.getAbild, b.getAbild, b.getAbild


--[[

Returns a Pokémon's type (specified by the second parameter) given its name or
ndex.
The name can contain a form abbreviation, and if it's a Pokémon name (not an
ndex) it should be lowercase but the first letter, that can be both upper or
lower case.

--]]

local getType = function(name, typeNumber)
    data = loadData(data, 'Poké/data')
    return string.fu(data[form.nameToDataindex(name)]['type' .. typeNumber])
end

-- Returns a Pokémon's first type given its name or ndex

b.getType1 = function(frame)
    return getType(frame.args[1] or '', '1')
end

b.get_type_1 = b.getType1

-- Returns a Pokémon's second type given its name or ndex. If the Pokémon has
-- only one type, it returns the first type instead

b.getType2 = function(frame)
    return getType(frame.args[1] or '', '2')
end

b.get_type_2 = b.getType2

--[[

The first parameter is an ndex (maybe with an abbr). Returns the second
parameter if the Pokémon has two types, otherwise the third. The two last
parameters are trimmed.
This function is meant to replace an #if parser function to check whether a
Pokémon has two types or not.

--]]
b.ifTwoTypes = function(frame)
    data = loadData(data, 'Poké/data')
    local poke = data[form.nameToDataindex(frame.args[1])]
    local isDualType = poke.type1 == poke.type2
    return isDualType and string.trim(frame.args[2]) or string.trim(frame.args[3])
end


--[[

Frontend for wikilib/forms.getlink: returns the link to an'alternate form from
module AltForms/data or UselessForms/data. The Pokémon name (first argument)
may be both a name or a ndex followed by the abbr, the second argument is a
flag to get black or normal link.

--]]

b.getLink = function(frame)
    local name, black = string.trim(frame.args[1]), string.trim(frame.args[2])
    local link = form.getLink(name, black)
    if link ~= '' then
        return link
    else
        form.loadUseless(false)
        return form.getLink(name, black)
    end
end

b.getlink = b.getLink

return b
