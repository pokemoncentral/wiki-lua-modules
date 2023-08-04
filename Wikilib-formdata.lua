--[[

Library for functions shared between AltForms-data, UselessForms-data, and
possibly BothForms-data and any future module for alternative forms.

Functions in this library should _only_ be used by data modules to prepare data
to be served "statically" (eg. for link creation). If a function is used in
other modules to compute things from the data, it _must_ be put in
Wikilib-forms instead.

--]]

local p = {}

-- stylua: ignore start
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
-- stylua: ignore end

-- ================================== LINKS ==================================

-- All available names and contexts for links
local contexts = {
    links = '<div class="small-text">${link}</div>',
    blacklinks = '<div class="small-text black-text">${link}</div>',
    plainlinks = "${link}",
}

--[[

Initializes the tables for all kinds of links in a Pokémon table.

--]]
p.initializeLinkTables = function(poketab)
    for index, _ in pairs(contexts) do
        poketab[index] = poketab[index] or {}
    end
end

--[[

Creates all the links for an alternative form. There are two general kinds of
link: those pointing to the specific subpage of the Pokémon, and those pointing
to general pages (eg: "Forma di Alola"). This function handles boths, depending
on the arguments. This function also handles empty form name, yielding no link
at all (an empty string).

Please note that this function assumes the link tables already exists; make
sure to use initializeLinkTables to do that.

Arguments (named):
	- poketab: table for the Pokémon (where links should be stored, referring
            to the given formAbbr)
    - formAbbr: abbr of the form to make the links for
	- poke: base name of the Pokémon
	- linkTarget: an optional string argument. If given, the function assumes
			the link target should be the general page whose title is given by
			the value of this parameter. Example: for a Megaevoluzione, this
			parameter should be "Megaevoluzione")

--]]
p.makeSingleLink = function(poketab, formAbbr, poke, linkTarget)
    local formName = poketab.names[formAbbr]
    if formName == "" then
        for index, _ in pairs(contexts) do
            poketab[index][formAbbr] = ""
        end
        return
    end

    local target
    if linkTarget then
        target =
            table.concat({ linkTarget, "#", poketab.anchor or txt.fu(poke) })
    else
        target = table.concat({ txt.fu(poke), "/Forme" })
    end
    for index, context in pairs(contexts) do
        poketab[index][formAbbr] = txt.interp(context, {
            link = table.concat({ "[[", target, "|", formName, "]]" }),
        })
    end
end

--[[

Adds links to alternative forms pointing to a generic page instead of the
specific subpage of the Pokémon. This function modifies links only for a given
list of abbrs, and doesn't change other links.

Abbr "base" is a special case. "base" is changed only if all the other forms of
the Pokémon are changed by this function, because this means that the Pokémon
only has forms of a certain kind (eg. only Paldean forms), so it doesn't have a
subpage.

Please note that this function assumes the link tables already exists; make
sure to use initializeLinkTables to do that.

Arguments:
    - linkTarget: the target for the link
    - abbrs: the list of abbrs to modify (it shouldn't contain "base")
    - names: a list of keys (pokemon names) to work on
    - t: the base data table, to index with keys in names

--]]
p.makeTargetedLink = function(linkTarget, abbrs, names, t)
    for _, name in pairs(names) do
        local poke = t[name]

        -- Whether this function should edit the link for "base" abbr
        local shouldEditBase = tab.all(poke.names, function(_, abbr)
            return abbr == "base" or tab.search(abbrs, abbr)
        end)

        local formsToEdit = tab.filter(poke.names, function(_, abbr)
            return (abbr == "base" and shouldEditBase)
                or tab.search(abbrs, abbr)
        end)

        for formAbbr, _ in pairs(formsToEdit) do
            p.makeSingleLink(poke, formAbbr, name, linkTarget)
        end
    end
end

--[[

Add standard links, ie. links to the subpage. If needed, they can be
overwritten later using makeTargetedLink.

Arguments:
    - name: name of the Pokémon
    - poke: table of the Pokémon in the data module

--]]
p.makeStandardLinks = function(name, poke)
    p.initializeLinkTables(poke)
    for formAbbr, _ in pairs(poke.names) do
        p.makeSingleLink(poke, formAbbr, name)
    end
end

return p
