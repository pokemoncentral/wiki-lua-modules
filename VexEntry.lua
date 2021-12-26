--[[

Module to replace the VexEntry template. Right now only replace it, but I
intend to use it to replace all its derivate templates (Vex*).

The interface is as simple as:

{{#invoke: VexEntry | Vex1 | <args> }}
{{#invoke: VexEntry | Vexhs | <args> }}
and so on for any other variant.

Arguments are only positional and are in order ndex, name of the Pokémon and a
list of "yes"/"no" that states the presence of the Pokémon in each game of the
entry (in the entry's order)

--]]

local v = {}

local mw = require('mw')

local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused
local formlib = require('Wikilib-forms')
local multigen = require('Wikilib-multigen')
local w = require('Wikilib')
local css = require('Css')
local ms = require('MiniSprite')
local blackabbr = require("Blackabbrev-data")
local colorabbr = require("Colorabbrev-data")
local pokes = require("Poké-data")

--[[

Make a single game's abbr, either black or color depending on disp.

Arguments:
	- disp: either "yes" or "no", if "yes" means that the Pokémon is present so
	        the game must be blackabbrev, otherwise is colorabbrev.
	- abbr: abbr of the game to display. If abbr is nil or the empty string
	        this function return an empty string (handles parameter not passed)

--]]
v.makeGame = function(disp, abbr)
	if not abbr or abbr == "" then
		return ""
	end
	return disp == "yes" and blackabbr[abbr]
	                     or table.concat{ "&nbsp;", colorabbr[abbr], "&nbsp;" }
end

--[[

Main builder of WikiCode interfaces.

Parametri (named):
	- ndex: numero di Dex (compresa sigla dell'eventuale forma alternativa).
	- pkmn: nome del Pokémon (senza eventuale forma alternativa).
	- gen: generazione dell'entry, usata per prendere i tipi del Pokémon
	       (opzionale, default alla generazione corrente).
	- abbr1: sigla del primo gioco.
	- disp1: disponibilità nel primo gioco (''yes''/''no'').
	- abbr2, disp2: seconda sigla e disponibilità nel secondo gioco (come sopra).
	- abbr3, disp3: terza sigla e disponibilità nel terzo gioco (come sopra, ma
	                appare solo se presente).
	- abbr4, disp4: quarta sigla e disponibilità nel quarto gioco (come sopra,
	                ma appare solo se presente).

--]]
v.VexEntry = function(args)
	local p = w.trimAll(args)
    formlib.loadUseless(true)
	local form = formlib.getLink(p.ndex, "black") or ""
	local baseName, _ = formlib.getNameAbbr(p.ndex)
	local pokedata = pokes[p.ndex] or pokes[baseName]
	pokedata = multigen.getGen(pokedata, args.gen)
	return string.interp([=[
|-
| style="padding: 0.5em;" | <div class="flex flex-row flex-nowrap flex-items-center"><div class="inline-block roundy-full" style="${radialGrad}">${ms}</div>
<span class="flex-item-fill" style="padding-left: 0.3em;">[[${pkmn}]]${formLink}</span></div>
| style="padding: 0.5em;" | ${abbr1}${abbr2}${abbr3}${abbr4}
]=], {
	radialGrad = css.radialGradLua{"circle closest-side",
	                               type1 = pokedata.type1,
	                               type2 = pokedata.type2 },
	ms = ms.staticLua(p.ndex, args.gen),
	pkmn = p.pkmn,
	formLink = form ~= "" and string.interp(
	        '<div class="small-text">${form}</div>', { form = form }) or "",
	abbr1 = v.makeGame(p.disp1, p.abbr1),
	abbr2 = v.makeGame(p.disp2, p.abbr2),
	abbr3 = v.makeGame(p.disp3, p.abbr3),
	abbr4 = v.makeGame(p.disp4, p.abbr4),
})
end

--[[

Derived entries: are just an interface to the general one with some parameters
fixed. Automatically generated from the set of fixed parameters.

baseParamMap contains a map from positional arguments of interfaces to named
arguments of the base function "VexEntry".

The fixedParams table contains the list of fixed parameters for the entry
"Vex" .. key where key is the key in the table. To create a new WikiCode
interface is enough to add such a table.

--]]
local baseParamMap = { "ndex", "pkmn", "disp1", "disp2", "disp3", "disp4" }
local fixedParams = {
	['1'] = { abbr1 = "R", abbr2 = "V", abbr3 = "B", abbr4 = "G", gen = 1 },
	['2'] = { abbr1 = "O", abbr2 = "A", abbr3 = "C", gen = 2 },
	['3'] = { abbr1 = "Ru", abbr2 = "Z", abbr3 = "S", gen = 3 },
	fl = { abbr1 = "RF", abbr2 = "VF", gen = 3 },
	['4'] = { abbr1 = "D", abbr2 = "P", abbr3 = "Pt", gen = 4 },
	hs = { abbr1 = "HG", abbr2 = "SS", gen = 4 },
	['5'] = { abbr1 = "N", abbr2 = "Bi", gen = 5 },
	n2b2 = { abbr1 = "N2", abbr2 = "B2", gen = 5 },
	['6'] = { abbr1 = "X", abbr2 = "Y", gen = 6 },
	roza = { abbr1 = "RO", abbr2 = "ZA", gen = 6 },
	['7'] = { abbr1 = "So", abbr2 = "L", gen = 7 },
	usul = { abbr1 = "US", abbr2 = "UL", gen = 7 },
	['8'] = { abbr1 = "Sp", abbr2 = "Sc", gen = 8 },
	LGPE = { abbr1 = "LGP", abbr2 = "LGE", gen = 7 },
	DLPS = { abbr1 = "DL", abbr2 = "PS", gen = 8 },
	md1 = { abbr1 = "PMDR", abbr2 = "PMDB", gen = 3 },
	md2 = { abbr1 = "PMDT", abbr2 = "PMDO", abbr3 = "PMDC", gen = 4 },
}

for funcName, params in pairs(fixedParams) do
	v['Vex' .. funcName] = function(frame)
		local args = mw.clone(params)
		for k, val in pairs(frame.args) do
			args[baseParamMap[k]] = val
		end
		return v.VexEntry(args)
	end
end

return v
