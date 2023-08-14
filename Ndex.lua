--[[

This module prints an entry in a list of Pokémon.

The interface allow for printing from WikiCode, and expose the class for other
modules to use it.

Example call from WikiCode:
{{#invoke: ndex | list | 396 397 398 487 487O 422E | color = alola }}

Takes a list of space separated ndexes and print the relative entries. The
color argument specify the color of the background (a name from modulo colore).

The other interface prints only the header, with the color specified:
{{#invoke: ndex | header | sinnoh }}

--]]

local n = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local w = require('Wikilib')
local form = require('Wikilib-forms')
local oop = require('Wikilib-oop')
local lists = require('Wikilib-lists')
local gen = require('Wikilib-gens')
local multigen = require('Wikilib-multigen')
local box = require('Box')
local ms = require('MiniSprite')
local css = require('Css')
local pokes = require('Poké-data')
local formsData = form.allFormsData()
-- stylua: ignore end

-- Loads also useless forms because there can be entries for useless forms
form.loadUseless(true)
local alts = form.allFormsData()

--[[

This class holds data about name, ndex, types and form of a Pokémon. It also
support useless forms.

--]]
n.Entry = oop.makeClass(lists.PokeLabelledEntry)

n.Entry.strings = {
    ENTRY = string.gsub(
        [=[
<div class="width-xl-33 width-md-50 width-sm-100" style="padding: 0.2em;">
<div class="flex flex-row flex-wrap flex-items-center flex-main-stretch roundy white-bg height-100 vert-middle" style="padding-right: 0.2em; padding-top: 0.1em;"><!--
--><div class="width-xl-15" style="padding: 0.3ex;">#${ndex}</div><!--
--><div class="width-xl-15">${ms}</div><!--
--><div class="text-center width-xl-30" style="padding: 0.3ex;">[[${name}]]${form}</div><!--
--><div class="width-xl-30" style="padding: 0.3ex;">${types}</div>
</div></div>]=],
        "<!%-%-\n%-%->",
        ""
    ),

    HEADER = [=[
<div class="roundy pull-center text-center flex flex-row flex-wrap flex-items-stretch flex-main-space-evenly width-xl-100" style="${bg}; padding: 0.2em;">]=],
}

n.Entry.new = function(pokedata, name)
    local this = n.Entry.super.new(name, pokedata.ndex)

    local baseName, abbr = form.getpokekeyabbr(name)

    if alts[baseName] then
        -- Table.copy because alts is mw.loadData, so mw.clone doesn't work
        this.formsData = tab.copy(alts[baseName])
        this.formAbbr = abbr
    end
    if this.labels[1] == "" then
        this.labels[1] = nil
    end

    return setmetatable(tab.merge(this, pokedata), n.Entry)
end

-- WikiCode for an entry: card layout with all the informations on one line.
n.Entry.__tostring = function(this)
    local formtag = ""
    if this.labels[1] then
        formtag = this.labels[1] == "Tutte le forme"
                and '<div class="small-text">Tutte le forme</div>'
            or this.formsData.links[this.formAbbr]
    end

    local type1 = multigen.getGenValue(this.type1)
    local type2 = multigen.getGenValue(this.type2)
    local types = type2 == type1 and { type1 } or { type1, type2 }

    local ndex = gen.ndexToString(this.ndex)
    local msidx = ndex == "???" and ndex
        or ndex .. form.toEmptyAbbr(this.formAbbr or "")

    return txt.interp(n.Entry.strings.ENTRY, {
        ndex = ndex,
        ms = ms.staticLua({ msidx }),
        name = this.name,
        form = formtag,
        types = box.listTipoLua(
            table.concat(types, ", "),
            "thin",
            "width-xl-100",
            "margin: 0 0.2ex 0.2ex 0;"
        ),
    })
end

-- ================================== Header ==================================
n.headerLua = function(color)
    return txt.interp(n.Entry.strings.HEADER, {
        bg = css.horizGradLua({ type = color or "pcwiki" }),
    })
end

n.header = function(frame)
    return n.headerLua(txt.trim(frame.args[1]))
end

--[[

WikiCode interface, to print a list of entries.

--]]
n.list = function(frame)
    local ndexlist = frame.args[1]
    local res = { n.headerLua(txt.trim(frame.args.color)) }
    for ndex in ndexlist:gmatch("[^ ]+") do
        local baseName, _ = form.getpokekeyabbr(ndex)
        table.insert(
            res,
            tostring(n.Entry.new(pokes[ndex] or pokes[baseName], ndex))
        )
    end
    table.insert(res, "</div>")
    return table.concat(res)
end
n.List = n.list

-- =============================== Manual entry ===============================
n.manualEntry = function(frame)
    local p = w.trimAll(frame.args)
    local ndex, abbr = form.getndexabbr(p[1], p.form)
    local name = txt.fu(p[2])
    local formtag = formsData[ndex] and formsData[ndex].links[abbr] or ""
    local types = { p.type1, p.type2 }

    local ndexs, msidx
    if not tonumber(ndex) then
        ndexs = "???"
        msidx = ndexs
    else
        ndexs = txt.ff(ndex)
        msidx = ndexs .. abbr
    end

    return txt.interp(n.Entry.strings.ENTRY, {
        ndex = ndexs,
        ms = ms.staticLua({ msidx }),
        name = name,
        form = formtag,
        types = box.listTipoLua(
            table.concat(types, ", "),
            "thin",
            "width-xl-100",
            "margin: 0 0.2ex 0.2ex 0;"
        ),
    })
end

return n
