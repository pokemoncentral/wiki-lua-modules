--[[

This file contains the base class for a DebRes. Is a module meant for internal
use only, not to be used in pages directly.

It defines a class which is used directly for standard DebRes, and is
subclassed for glitches.

--]]

local dr = {}

-- stylua: ignore start
local mw = require('mw')

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local multigen = require('Wikilib-multigen')
local etlib = require('Wikilib-efftipi')
local w = require('Wikilib')
local box = require('Box')
local link = require('Links')
local css = require('Css')
local cc = require('ChooseColor')
local abilData = require("PokéAbil-data")
local pokes = require("Poké-data")
-- stylua: ignore end

--[[

This class represents a table of type effectiveness. It holds inforation about
the effectiveness of the types against a Pokémon, or an alternative form. This
is the same as having data about effectivenes of types against a types-ability
combination. Furthermore, it has footer lines, as a list of FooterLine
instances, and a list of forms sharing the same effectiveness data.

--]]
dr.EffTable = oop.makeClass(list.Labelled)

-- ========================== STATIC FIELDS/METHODS ===========================
-- Utility strings
dr.EffTable.strings = {

    -- Wikicode for the external DebRes box
    DEBRES_CONTAINER = [[<div class="roundy pull-center text-center overflow-auto width-xl-80 width-md-100 ${textcolor}" style="padding: 0.5ex; padding-bottom: 0.01ex; ${bg}">${effBoxes}${foot}</div>]],

    -- Wikicode for the beginning of a box (Weaknesses, Resistances, etc)
    BOX_INIT = [=[<div style="padding: 0.5em 0;"><span class="inline-block align-middle text-center width-xl-30 width-xs-100" style="padding: 0.3em;">'''${text}'''</span><div class="inline-block align-middle width-xl-70 width-xs-100" style="padding: 0;">]=],

    -- Wikicode for an effextiveness line
    BOX_LINE = [=[<div class="flex flex-row flex-wrap flex-items-stretch width-xl-100" style="padding: 0.1em;"><div class="roundy vert-middle width-xl-5 width-md-10 width-xs-100 black-text" style="padding: 0 0.2em; background: #FFF;"><span>${eff}&times;</span></div><div class="text-left text-center-xs width-xl-95 width-md-90 width-xs-100" style="padding-left: 0.2em;">${types}</div></div>]=],

    -- Wikicode for footer container
    FOOTER_CONTAINER = [=[<div class="text-left text-small" style="padding: 0.5em 0; margin: 0;">${lines}</div>]=],
}

-- All the possible effectiveness values, considering abilities. Therefore,
-- triple resistances are taken in account and Filtro/Solidroccia e Pellearsa
-- as well.
-- stylua: ignore
dr.EffTable.allEff = {
    0, 0.25, 0.5, 1, 2, 4, -- Standard
    -- 0.125, -- Triple resistance (useless for the time being)
    -- 0.3125, 0.625, 1.25, 2.5, 5, -- Pellearsa (useless for the time being)
    1.5, 3 -- Filtro/Solidroccia
}

-- Dedicated effectiveness representations
dr.EffTable.effStrings = {
    [0.5] = "½",
    [0.25] = "¼",
}

-- Classes and styles for type boxes
dr.EffTable.typeBoxStyles = {
    classes = {
        "roundy",
        "text-center",
        "inline-block",
        "width-xl-15",
        "width-md-20",
        "width-sm-35",
        "width-xs-45",
    },
    styles = {
        ["margin"] = "0.3ex",
        ["padding"] = "0.3ex 0",
        ["line-height"] = "3ex",
        ["font-weight"] = "bold",
    },
}

-- Returns a dedicated representation of the effectiveness value, if any.
-- Otherwise it just prints it using the comma as decimal separator
dr.EffTable.displayEff = function(eff)
    return dr.EffTable.effStrings[eff] or (tostring(eff):gsub("%.", ","))
end

-- Used to sort effectiveness boxes by ascending effectiveness
dr.EffTable.greatestEffFirst = function(line0, line1)
    return line0.eff > line1.eff
end

-- Prints a list of types as Boxes
dr.EffTable.printTypes = function(types)
    return box.listTipoLua(
        types,
        nil,
        dr.EffTable.typeBoxStyles.classes,
        dr.EffTable.typeBoxStyles.styles
    )
end

-- Prints a single lines of types having the same effectiveness
dr.EffTable.printEffLine = function(data)
    return txt.interp(dr.EffTable.strings.BOX_LINE, {
        eff = dr.EffTable.displayEff(data.eff),
        types = dr.EffTable.printTypes(data.types),
    })
end

-- Prints a single effectiveness box (Weaknesses, Std, etc...)
dr.EffTable.printSingleBox = function(boxData)
    -- Only effectiveness list have numbers as keys
    local effData = tab.filter(boxData, function(_, key)
        return type(key) == "number"
    end)
    local allLines = w.mapAndConcat(effData, dr.EffTable.printEffLine)

    return txt.interp(
        table.concat({ dr.EffTable.strings.BOX_INIT, allLines, "</div></div>" }),
        {
            text = boxData.text,
        }
    )
end

-- Prints non-empty effectiveness boxes only
dr.EffTable.printEffBoxes = function(boxes)
    boxes = tab.filter(boxes, function(b)
        return type(b) ~= "table" or #b > 0
    end)
    return w.mapAndConcat(boxes, dr.EffTable.printSingleBox)
end

-- Equality operator for effectiveness tables. Returns true if both the footers
-- and the effectiveness values are equal.
dr.EffTable.__eq = function(a, b)
    if not tab.equal(a.footer, b.footer) then
        return false
    end

    -- dr.EffTable.allEff is used since a and b can have differents set of
    -- effectinevess values.
    return tab.all(dr.EffTable.allEff, function(eff)
        return tab.equal(a.effs[eff], b.effs[eff])
    end)
end

-- Get types and abilities from Pokémon name and form name (and gen)
dr.EffTable.parseEntryData = function(name, formName, gen)
    if type(name) == "table" and type(formName) == "table" then
        return tab.map(name, string.lower), tab.map(formName, string.lower), nil
    else
        -- If gen <= 2, no abilities
        local abils = gen <= 2 and { ability1 = "nessuna" }
            or tab.map(multigen.getGen(abilData[name], gen), string.lower)
        return multigen.getGen(pokes[name], gen), abils, formName
    end
end

-- ============================= INSTANCE METHODS =============================

--[[

EffTable constructor. It can be used in two versions.

In the first, name and formname are a string with the Pokémon name, as name +
abbreviation, and an optional extended name of the alternative form.

In the second, name and formname are tables, respectively holding types and
abilities for which the DebRes should be created.

The last parameter is the generation (see boxArgs in makeFormsLabelledBoxes).

--]]
dr.EffTable.new = function(name, formname, gen)
    local types, abils, label = dr.EffTable.parseEntryData(name, formname, gen)

    local this = setmetatable(dr.EffTable.super.new(label), dr.EffTable)
    this.types = types
    this.abils = abils
    this.gen = gen
    this.et = etlib.getEtdata(gen)

    -- More data
    this.onlyAbil = tab.getn(this.abils) == 1
    -- For non unique abilities, the effectiveness calculations have to be
    -- made without ability, since the footer will contain lines about them.
    this.abil = this.onlyAbil and this.abils.ability1 or "nessuna"

    -- Printing stuff
    this.collapse = ""
    this:createColors()

    this:computeEff()
    this:makeFooter()

    return this
end

-- Prepare the tables with colors for printing. Changed in glitch subclasses
dr.EffTable.createColors = function(this)
    this.colors = this.types
end

-- Computes the actual values to put in the output. Does not compute footer
dr.EffTable.computeEff = function(this)
    this.effs = {}
    -- For every possible effectiveness value, checks for types having it
    -- against the current types + ability combination. If some are found, they
    -- are added as a table to this, the key being the effectiveness.
    for _, eff in ipairs(this.allEff) do
        local effTypes = etlib.difesa(
            this.et,
            eff,
            this.types.type1,
            this.types.type2,
            this.abil
        )
        if #effTypes > 0 then
            -- Sorting necessary for comparison and printing.
            table.sort(effTypes)
            this.effs[eff] = effTypes
        end
    end
end

-- Collapsed setter
dr.EffTable.setCollapse = function(this, collapse)
    this.collapse = collapse
    return this
end

-- Returns the wikicode representation of an effectiveness table as a string.
-- Only non-empty effectivenesses are added and the footer is only present if
-- it contains at least one line.
dr.EffTable.__tostring = function(this)
    local weak = { text = "Debolezze" }
    local std = { text = "Danno normale" }
    local res = { text = "Resistenze" }
    local imm = { text = "Immunit&agrave;" }

    local interpData = {
        bg = css.horizGradLua(this.colors),
        foot = #this.footer < 1 and ""
            or txt.interp(this.strings.FOOTER_CONTAINER, {
                lines = w.mapAndConcat(this.footer, tostring),
            }),
    }

    -- Can't use ipairs because effectivenesses are not integers but floats
    for eff, types in pairs(this.effs) do
        -- eff is not used as an index since sorting is only supported for
        -- integer indixes
        if eff == 0 then
            table.insert(imm, { eff = 0, types = types })
        elseif eff < 1 then
            table.insert(res, { eff = eff, types = types })
        elseif eff == 1 then
            table.insert(std, { eff = 1, types = types })
        else -- eff > 1
            table.insert(weak, { eff = eff, types = types })
        end
    end

    -- Pointless to sort imm and std, as they only have one item
    table.sort(res, dr.EffTable.greatestEffFirst)
    table.sort(weak, dr.EffTable.greatestEffFirst)

    interpData.effBoxes = dr.EffTable.printEffBoxes({ weak, std, res, imm })

    interpData.textcolor =
        cc.forModGradBgLua(this.colors.type1, this.colors.type2)

    local effTab = txt.interp(this.strings.DEBRES_CONTAINER, interpData)

    if #this.labels > 0 then
        return txt.interp(
            [[==== ${title} ====
<div class="${collapse}">
${effTab}
</div>]],
            {
                title = mw.text.listToText(this.labels, ", ", " e "),
                collapse = this.collapse or "",
                effTab = effTab,
            }
        )
    end

    return effTab
end

-- ================================== FOOTER ==================================

-- Creates the footer for an efftable, given the primary ability, the types,
-- the full ability list and whether the ability is only one
dr.EffTable.makeFooter = function(this)
    local types = this.types
    local abils = this.abils
    local abil = this.abil
    local etdata = this.et
    this.footer = {}

    if this.gen <= 2 then
        -- No abilities before gen 3, hence no need for the footer
        return
    end

    -- Adding immunities footer lines
    if abil ~= "magidifesa" then
        if etlib.hasAnyImmunity(etdata, types.type1) then
            table.insert(
                this.footer,
                dr.EffTable.FooterLine.new("RINGTARGET", types, abils, etdata)
            )
        end

        if
            types.type1 ~= types.type2
            and etlib.hasAnyImmunity(etdata, types.type2)
        then
            -- Swapping types for dual typed Pokémon, since
            -- dr.EffTable.FooterLine only checks the first one for immunities
            table.insert(
                this.footer,
                dr.EffTable.FooterLine.new(
                    "RINGTARGET",
                    { type1 = types.type2, type2 = types.type1 },
                    abils,
                    etdata
                )
            )
        end
    end

    -- Adding TAKENOFF footer line for Pokémon having just one ability
    if this.onlyAbil then
        if etlib.modTypesAbil[abil] then
            table.insert(
                this.footer,
                dr.EffTable.FooterLine.new("TAKENOFF", types, abil, etdata)
            )
        end

    -- Adding MAYBE footer line for Pokémon having more than one ability
    else
        local maybeAbils = tab.filter(abils, function(ability)
            return etlib.changesEffectiveness(etdata, ability, types)
        end)
        local maybeLines = tab.mapToNum(maybeAbils, function(ability)
            return dr.EffTable.FooterLine.new("MAYBE", types, ability, etdata)
        end)
        this.footer = tab.append(this.footer, maybeLines)
    end

    -- Footer should be sorted for equality and printing
    table.sort(this.footer)
end

--[[

This class represents an item in the footer list of lines. It needs information
about the line category, the initial text and the new effectivenesses.

These are the line categories:
    - MAYBE: This category tells about the effectiveness in case a specimen has
        a certain ability. Used for Pokémon species that can have more than one
        ability.
    - TAKENOFF: This category tells about the effectiveness in case an ability
        is lost. Used for Pokémon species that can have only one ability.
    - RINGTARGET: This category tells about the effectiveness of type-due
        immunities when immunities are lost.
--]]
dr.EffTable.FooterLine = oop.makeClass()

-- Utility footerline strings. They can contain interpolation placeholders.
dr.EffTable.FooterLine.strings = {

    -- MAYBE category beginning text
    MAYBE = "Se questo Pok&eacute;mon ha [[${abil}]] ",

    -- TAKENOFF category beginning text
    TAKENOFF = "Se le abilit&agrave; non compaiono nel gioco, se questo Pok&eacute;mon perde [[${abil}]] o se ne sono annullati gli effetti, ",

    -- RINGTARGET category beginning text
    RINGTARGET = "Se questo Pokémon perde l'immunità data dal tipo ${type} ",

    -- Strings to be concatenated to RINGTARGET for immunities shared by
    -- ability and types
    NOT_HAVE_ABIL = "e se non ha [[${abil}]], ",
    IMM_TAKENOFF = "e se ha perso [[${abil}]] o ne sono stati annullati gli effetti, ",

    -- New effectieness text
    EFF = "l'efficacia delle mosse di tipo ${types} &egrave; pari a ${eff}×",

    -- Magidifesa text
    MAGIDIFESA = "solo le mosse di tipo ${types} continuano a non avere effetto.",
}

-- Sorting categories to sort footerlines
dr.EffTable.FooterLine.kindOrder = { "MAYBE", "TAKENOFF", "RINGTARGET" }

-- This table holds functions to generate the initial part of a FooterLine based
-- on its category.
dr.EffTable.FooterLine.init = {}

-- Initial part for MAYBE category. Simple string interpolation.
dr.EffTable.FooterLine.init.MAYBE = function(abil)
    return string.interp(
        dr.EffTable.FooterLine.strings.MAYBE,
        { abil = string.camelCase(abil) }
    )
end

-- Initial part for TAKENOFF category. Simple string interpolation.
dr.EffTable.FooterLine.init.TAKENOFF = function(abil)
    return string.interp(
        dr.EffTable.FooterLine.strings.TAKENOFF,
        { abil = string.camelCase(abil) }
    )
end

-- Initial part for RINGTARGET category. After adding some more strings based
-- on the type and the abilities, concatenates the result.
dr.EffTable.FooterLine.init.RINGTARGET = function(abils, type, etdata)
    local pieces = {
        string.interp(
            dr.EffTable.FooterLine.strings.RINGTARGET,
            { type = link.colorType(type) }
        ),
    }

    -- If the Pokémon has only one ability, the related string deals with its
    -- loss, otherwise it is about the possibility of it happening.
    local notAbil = tab.getn(abils) == 1
            and dr.EffTable.FooterLine.strings.IMM_TAKENOFF
        or dr.EffTable.FooterLine.strings.NOT_HAVE_ABIL

    -- Adds a string for every ability that shares an immunity with the type of
    -- the footerline
    local abilImm = tab.flatMap(
        etlib.typeImmunesList(etdata, type:lower()),
        function(typeImm)
            return tab.filter(abils, function(abil)
                return etlib.abilityGrantsImm(etdata, abil, typeImm)
            end)
        end
    )
    local abilImmString = tab.mapToNum(abilImm, function(abil)
        return string.interp(notAbil, { abil = string.camelCase(abil) })
    end)

    pieces = tab.append(pieces, abilImmString)

    return table.concat(pieces)
end

--[[

FooterLine constructor. Its arguments are a line category, the Pokémon type
and a single ability. The only exception is the RINGTARGET category, that
requires all of the Pokémon abilities.

--]]
dr.EffTable.FooterLine.new = function(kind, types, abil, etdata)
    local this = setmetatable({}, dr.EffTable.FooterLine)

    kind = kind:upper()
    types = tab.map(types, string.lower)
    abil = type(abil) ~= "table" and abil:lower() or tab.map(abil, string.lower)

    this.kind = kind
    this.et = etdata

    -- Initial part of the footer line
    this.init = "\n*"
        .. dr.EffTable.FooterLine.init[kind](abil, types.type1, etdata)

    --[[
        For every new effectiveness value, a key-value pair is added to this
        table: the key is the effectiveness (as a string), and the value is
        a table of all the types names having this effectiveness.
        Such types need to be kept sorted, so that table.equals can compare
        them correctly and printing is easier.
    --]]
    this.newEff = {}

    -- Handling corner case abilities
    if this:makeSpecialAbil(abil, types) then
        return this
    end

    -- RINGTARGET type with mono-type Pokémon, the new effectiveness are 1x
    -- against the types the Pokémon is immune to
    if kind == "RINGTARGET" and types.type1 == types.type2 then
        this.newEff[1] = etlib.typeImmunesList(etdata, types.type1)
        -- See the comment for this.newEff
        table.sort(this.newEff[1])

        return this
    end

    local newTypes
    newTypes, types, abil = this:makeNewTypes(types, abil)
    -- See the comment for this.newEff
    table.sort(newTypes)

    --[[
        Every type that changes effectiveness is routed into the mapping with
        the corresponding effectiveness in this.newEff. The mapping is
        created on the spot if not already existing.
    --]]
    for _, type in ipairs(newTypes) do
        local eff =
            etlib.efficacia(etdata, type, types.type1, types.type2, abil)
        if this.newEff[eff] then
            table.insert(this.newEff[eff], type)
        else
            this.newEff[eff] = { type }
        end
    end

    return this
end

--[[

This method returns the types that gain a new effectiveness in the footer
line context, as well as returning the new types and abilities to be used
in the effectiveness value calculations. It takes as parameters the types
and abilities to base the computations on.

--]]
dr.EffTable.FooterLine.makeNewTypes = function(this, types, abil)
    local newTypes
    if this.kind == "RINGTARGET" then
        -- The new types are the ones the first type is immune to
        newTypes = etlib.typeImmunesList(this.et, types.type1)
        -- The Pokémon is now mono-type, in type effectiveness respect
        types.type1 = types.type2
    else
        -- The new types are the ones the ability has an impact on
        newTypes = etlib.modTypesAbil[abil]
        -- If the ability is taken off, then it should not be taken in account
        -- when dealing with this line type effectiveness
        abil = this.kind == "TAKENOFF" and "nessuna" or abil
    end

    return newTypes, types, abil
end

--[[

This method takes care of corner case abilities that need to be treated
separately when calculating new effectiveness. It takes as argument athe
ability to be checked and possibly handled, and the types to be used when
calculating the new effectiveness. If the ability is a corner case, true is
returned, false otherwise. Such abilities are so far Filtro, Solidroccia,
Scudoprisma and Magidifesa.

--]]
dr.EffTable.FooterLine.makeSpecialAbil = function(this, abil, types)
    -- RINGTARGET footer line type doesn't deal with abilities
    if this.kind == "RINGTARGET" then
        return false
    end

    -- These abilities reduce the effectiveness of super-effective moves.
    -- However, if the type is TAKENOFF, the effectiveness shown in the footer
    -- should be the one without the ability, that is the increased one.
    if tab.search({ "filtro", "solidroccia", "scudoprisma" }, abil) then
        -- Super-effective number values
        local superEff = tab.filter(dr.EffTable.allEff, function(eff)
            return eff > 1
        end)

        --[[
            Multiplier to derive the effectiveness shown in the footer. It
            should increase the current one if the footer line type is
            TAKENOFF, since the basic calculation is made with the ability.
            Otherwise, the new effectiveness should be decreased,
        --]]
        local mult = this.kind == "TAKENOFF" and 1.33 or 0.75

        --[[
            If the footer line kind is TAKENOFF, the ability needs to be taken
            in account when looking for super-effective types. Otherwise, it
            should be not.
        --]]
        local effAbil = this.kind == "TAKENOFF" and abil or "nessuna"

        --[[
            For any super-effective value that has some types, the types are
            added to the footer with reduced/incrased effectiveness.
        --]]
        for _, eff in ipairs(superEff) do
            local effTypes =
                etlib.difesa(this.et, eff, types.type1, types.type2, effAbil)
            if #effTypes > 0 then
                local newEff = math.ceil(eff * mult * 100) / 100
                -- See the comment for this.newEff in the constructor
                table.sort(effTypes)
                this.newEff[newEff] = effTypes
            end
        end

        return true

    --[[
        The stantard footer would be too long here. Furthermore, the
        ability will always be Shedinja's peculiar, so we chose a custom
        solution.
    --]]
    elseif abil == "magidifesa" then
        this.tostring = string.interp(
            table.concat({
                "\n*",
                dr.EffTable.FooterLine.strings.TAKENOFF,
                dr.EffTable.FooterLine.strings.MAGIDIFESA,
            }),
            {
                abil = "Magidifesa",
                types = table.concat(
                    { link.colorType("Normale"), link.colorType("Lotta") },
                    " e "
                ),
            }
        )

        return true
    end

    return false
end

--[[

Equal operator for FooterLine. Two instances are considered equal if
they both have a tostring field, or if they have the same initial parts and
newEff tables.

--]]
dr.EffTable.FooterLine.__eq = function(a, b)
    return a.tostring and b.tostring
        or not (a.tostring or b.tostring)
            and a.init == b.init
            and tab.equal(a.newEff, b.newEff)
end

--[[

Less than operator for FooterLine, to allow sorting. Comparison is made by
categories, as specified in dr.EffTable.FooterLine.kindOrder. In case of
equality, the initial parts of the lines are compared alphabetically.

--]]
dr.EffTable.FooterLine.__lt = function(a, b)
    local aIndex = tab.search(dr.EffTable.FooterLine.kindOrder, a.kind)
    local bIndex = tab.search(dr.EffTable.FooterLine.kindOrder, b.kind)
    return aIndex == bIndex and a.init < b.init or aIndex < bIndex
end

--[[

String representation of a FooterLine. For every effectiveness value, it
creates colored labels for its types, and it appends them to the initial text.

--]]
dr.EffTable.FooterLine.__tostring = function(this)
    if this.tostring then
        return this.tostring
    end

    local newEff = tab.mapToNum(this.newEff, function(types, eff)
        local colorTypes = tab.map(types, function(type)
            return link.colorType(type)
        end, ipairs)
        return string.interp(dr.EffTable.FooterLine.strings.EFF, {
            types = mw.text.listToText(colorTypes, ", ", " e "),
            eff = dr.EffTable.displayEff(eff),
        })
    end)

    return table.concat({
        this.init,
        mw.text.listToText(newEff, ", ", " e "),
        ".",
    })
end

--[[

Returns the Wikicode for a table of dr.EffTable objects: all tables but the
first are collapsed by default.

--]]
dr.EffTable.printEffTables = function(EffTables)
    -- If only one table is there, nothing to collapse
    if #EffTables == 1 then
        return tostring(EffTables[1])
    end

    -- All tables are collapsible and all default-collapsed but the first one
    return w.mapAndConcat(EffTables, function(EffTable, key)
        EffTable:setCollapse(
            "mw-collapsible" .. (key == 1 and "" or " mw-collapsed")
        )
        return tostring(EffTable)
    end, "\n")
end

return dr
