--[[

Crea una tabella in cui sono presenti tutte le debolezze e
resistenze di un Pokémon, con tanto di note nel footer.
Per i Pokémon con più forme, crea solo le tabelle
effettivamente diverse, inserendo nel titolo tutte le
forme che condividono la stessa.

Può essere chiamato con il nome di un Pokémon, es:

{{#invoke: DebRes | DebRes | Nidoking }}

O direttamente con tipi e abilità, sia con parametri
posizionali che con con nome, es:

{{#invoke: DebRes | DebRes | Veleno | Terra | Velenopunto | Antagonismo
        | Forzabruta | Remasabbia }}
{{#invoke: DebRes | DebRes | type1=Veleno | type2=Terra | abil1=Velenopunto
        | abil2=Antagonismo | abild=Clorofilla | abile=Risplendi }}

Può essere chiamato anche con un solo tipo e una sola abilità, es:

{{#invoke: DebRes | DebRes | Spettro | | Levitazione }}
{{#invoke: DebRes | DebRes | type=Spettro | abil=Levitazione }}

Può essere chiamato anche con un solo tipo, es

{{#invoke: DebRes | DebRes | Spettro }}
{{#invoke: DebRes | DebRes | type=Spettro }}

Può essere chiamato anche con due soli tipi, es

{{#invoke: DebRes | DebRes | Veleno | Terra }}
{{#invoke: DebRes | DebRes | type1=Veleno | type2=Terra }}

Si potrebbe anche mescolare notazione posizionale e con nome, ma
consiglio vivamente di NON FARLO

--]]

local dr = {}

local mw = require('mw')

local box = require('Box')
local et = require('EffTipi')
local link = require('Links')
local w = require('Wikilib')
local abillib = require('Wikilib-abils')
local list = require('Wikilib-lists')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')  -- luacheck: no unused
local tab = require('Wikilib-tables')   -- luacheck: no unused
local css = require('Css')
local abilData = require("PokéAbil-data")
local pokes = require("Poké-data")

--[[

Questa classe rappresenta una tabella di efficacia
tipi. Primariamente, contiene informazioni riguardo
l'efficacia dei vari tipi di attacchi contro un
certo Pokémon (o forma alternativa), ovvero contro
una certa combinazione di tipi e abilità; oltre a
ciò, possiede le righe che compongono il footer e
le forme che hanno tali dati di efficacia tipi.

--]]
dr.EffTable = oop.makeClass(list.Labelled)

-- Stringhe utili
dr.EffTable.strings = {

	--[[
		Wikicode per la parte iniziale di un box
		(Debolezze, Immunità, Danno Normale, ecc)
	--]]
	BOX_INIT = [=[<div class="roundy flex flex-row flex-wrap flex-items-stretch" style="padding: 0.5em 0; margin: 0;"><span class="inline-flex flex-items-center flex-main-center width-xl-30 width-xs-100" style="padding: 0.3em;">'''${text}'''</span><div class="flex flex-row flex-wrap flex-items-stretch roundy width-xl-70 width-xs-100" style="border-spacing: 0; padding: 0;">]=],

	-- Wikicode per una riga di tipi aventi la stessa efficacia
	BOX_LINE = [=[<div class="flex flex-row flex-wrap flex-items-stretch width-xl-100" style="padding: 0.1em;"><div class="inline-flex flex-items-center flex-main-center roundy width-xl-5 width-sm-10 width-xs-100" style="padding: 0 0.2em; background: #FFF;">${eff}&times;</div><div class="inline-flex flex-row flex-wrap flex-items-center flex-main-start width-xl-95 width-sm-90 width-xs-100" style="padding-left: 0.2em;">${types}</div></div>]=],
}

--[[

Tutte i possibili moltiplicatori dell'efficacia,
considerando anche le triple resistenze e gli
effetti di Filtro/Solidroccia e Pellearsa

--]]
dr.EffTable.allEff = {0, 0.25, 0.5, 1, 2, 4, -- Standard
-- 0.125, -- Tripla resistenza (al momento inutile)
-- 0.3125, 0.625, 1.25, 2.5, 5, -- Pellearsa (al momento inutile)
1.5, 3 -- Filtro/Solidroccia
}

--[[

Visualizzazione dei moltiplicatori di efficacia,
se diversa dal semplice numero

--]]
dr.EffTable.effStrings = {
	[0.5] = '½',
	[0.25] = '¼'
}

--[[

Ritorna la visualizzazione dell'efficacia, se
presente, altrimenti semplicemente il numero
con la virgola come separatore decimale

--]]
dr.EffTable.displayEff = function(eff)
	return dr.EffTable.effStrings[eff] or
		(tostring(eff):gsub('%.', ','))
end

--[[

Ritorna true se bisogna aggiungere una
riga del footer di categoria MAYBE per
una certa abilità, dati i tipi del Pokémon.
Ciò accade se l'abilità non modifica
l'efficacia di tipi a cui i tipi propri
del Pokémon danno già immunità

--]]
dr.EffTable.shouldAddMaybe = function(abil, types)
	local abilMod = et.modTypesAbil[abil]
	local immType1 = et.typesHaveImm[types.type1]
	local immType2 = et.typesHaveImm[types.type2]

	if not abilMod then
		return false
	end
	if not (immType1 or immType2) then
		return true
	end

	for k, type in pairs(abilMod) do
		if immType1 and table.search(immType1, type)
				or immType2 and table.search(immType2, type) then
			return false
		end
	end
	return true
end

--[[

Usata per il sorting delle righe dei tipi
aventi la stessa efficacia, fa in modo che
vengano ordinate per efficacia decrescente

--]]
dr.EffTable.greatestEffFirst = function(line0, line1)
	return line0.eff > line1.eff
end

-- Stampa i tipi dati come Boxes tipi
dr.EffTable.printTypes = function(types)
	return box.listTipoLua(types, ' inline-block width-xl-15 width-md-20 width-sm-35 width-xs-45',
		'margin: 0.3ex; padding: 0.3ex 0; line-height: 3ex; font-weight: bold;')
end

-- Crea la table dei colori, prendendo i dati da types
dr.EffTable.createColors = function(this, types)
	this.colors = {
		type1 = types.type1,
		type2 = types.type2,
	}
end

--[[

Stampa una riga di tipi aventi la stessa
efficacia, aggiungendo il bordo inferiore
se indicato

--]]
dr.EffTable.printEffLine = function(data, roundy)
	return string.interp(dr.EffTable.strings.BOX_LINE,
		{
			rd = roundy or '',
			eff = dr.EffTable.displayEff(data.eff),
			types = dr.EffTable.printTypes(data.types),
		})
end

-- Stampa un singolo box (Debolezze, Immunità, Danno Normale, ecc)
dr.EffTable.printSingleBox = function(boxData, colors)

	--[[
		Il controllo andrebbe comunque fatto dopo la
		seconda table.remove, ma qui è più leggibile
	--]]
	if #boxData == 1 then
		return string.interp(table.concat{dr.EffTable.strings.BOX_INIT,
				dr.EffTable.printEffLine(boxData[1]), '</div></div>'},
		{
			text = boxData.text,
		})
	end

	-- Prima e ultima riga hanno l'efficacia arrotondata
	local firstLine = dr.EffTable.printEffLine(table.remove(boxData, 1),
			'top', colors)
	local lastLine = dr.EffTable.printEffLine(table.remove(boxData),
			'bottom')

	-- Controllo superfluo, ma il caso con due righe è molto comune
	local allLines
	if #boxData > 0 then
		allLines = table.map(boxData, function(lineData)
				if type(lineData) == 'table' then
					return dr.EffTable.printEffLine(lineData, '', colors)
				end
			end)
	else
		allLines = {}
	end

	table.insert(allLines, 1, firstLine)
	table.insert(allLines, lastLine)
	allLines = table.concat(allLines)
	return string.interp(table.concat{dr.EffTable.strings.BOX_INIT,
			allLines, '</div></div>'},
		{
			text = boxData.text,
		})
end

-- Prints non-empty effectiveness boxes only
dr.EffTable.printEffBoxes = function(boxes, colors)
	boxes = table.filter(boxes, function(b)
			return type(b) ~= 'table' or #b > 0
	end)
	return w.mapAndConcat(boxes, function(b)
			return dr.EffTable.printSingleBox(b, colors)
		end)
end

--[[

Costruttore della classe: ha in ingresso il
nome del Pokémon, nella forma nome + sigla,
e, opzionalmente, il nome esteso della forma

--]]
dr.EffTable.new = function(name, formName)
	local types, abils

	if type(name) == 'table' and type(formName) == 'table' then
		types = table.map(name, string.lower)
		abils = table.map(formName, string.lower)
	else
		types = pokes[name]
		abils = table.map(abillib.lastAbils(abilData[name]), string.lower)
	end

	local this = setmetatable(dr.EffTable.super.new(formName),
			dr.EffTable)
	this.collapse = ''

	-- Dati per la stampa
	this:createColors(types)

	local onlyAbil = table.getn(abils) == 1

	--[[
		Se l'abilità non è unica, il calcolo
		dell'efficacia va fatto senza abilità,
		poiché se ne terrà conto nel footer
	--]]
	local abil = onlyAbil and abils.ability1 or 'tanfo'

	--[[
		Per ogni possibile efficacia, se vi sono
		tipi che la hanno, inserisce una table
		con i loro nomi all'indice dell'efficacia
		stessa
	--]]
	for k, eff in ipairs(dr.EffTable.allEff) do
		local types = et.difesa(eff, types.type1, types.type2, abil)
		if #types > 0 then

			--[[
				I tipi devono essere ordinati per il
				confronto e la conversione a stringa
			--]]
			table.sort(types)
			this[eff] = types
		end
	end

	--[[
		Contiene le righe del footer sotto forma di
		istanze di dr.EffTable.FooterLine
	--]]
	this.footer = {}

	if abil ~= 'magidifesa' then
		if et.typesHaveImm[types.type1] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
					types, abils))
		end

		--[[
			I tipi vanno scambiati perché il costruttore
			di dr.EffTable.FooterLine controlla solo il primo
		--]]
		if not (types.type1 == types.type2) and et.typesHaveImm[types.type2] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('RINGTARGET',
					{type1 = types.type2, type2 = types.type1}, abils))
		end
	end

	if onlyAbil then
		if et.modTypesAbil[abil] then
			table.insert(this.footer, dr.EffTable.FooterLine.new('TAKENOFF',
					types, abil))
		end
	else

		-- Can't use table.map because of string indices
		for key, abil in pairs(abils) do
			if dr.EffTable.shouldAddMaybe(abil, types) then
				table.insert(this.footer, dr.EffTable.FooterLine.new('MAYBE',
						types, abil))
			end
		end
	end

	-- Footer should be sorted for equality and printing
	table.sort(this.footer)

	return this
end

--[[

Equaity operator for effectiveness tables. Returns true if both the footers
and the effectiveness values are equal.

--]]
dr.EffTable.__eq = function(a, b)
	if not table.equal(a.footer, b.footer) then
		return false
	end

	--[[
        dr.EffTable.allEff is used since a and b can have different
        effectinevess values.
    --]]
	for k, eff in pairs(dr.EffTable.allEff) do
		if not table.equal(a[eff], b[eff]) then
			return false
		end
	end

	return true
end

-- Collapsed setter
dr.EffTable.setCollapse = function(this, collapse)
	this.collapse = collapse
end

--[[

Returns the wikicode representation of an effectiveness table as a string.
Only non-empty effectivenesses are added and the footer is only present if it
contains at least one line.

--]]
dr.EffTable.__tostring = function(this)
	local weak = {text = 'Debolezze'}
	local std = {text = 'Danno normale'}
	local res = {text = 'Resistenze'}
	local imm = {text = 'Immunit&agrave;'}

    local bg = css.horizGradLua{
        type1 = this.colors.type1,
        type2 = this.colors.type2
    }
	local interpData = {
		bg = bg,
		foot = #this.footer < 1 and '' or string.interp([=[<div class="roundy text-left text-small" style="padding: 0.5em 0; margin: 0;">${lines}</div>]=],
				{
					lines = w.mapAndConcat(this.footer, tostring)
				})
	}

    -- Can't use ipairs because effectivenesses are not integers but floats
	for eff, types in pairs(this) do
		if type(eff) == 'number' then
            --[[
                eff is not used as an index since sorting is only supported for
                integer indixes
            --]]
			if eff == 0 then
				table.insert(imm, {eff = 0, types = types})
			elseif eff < 1 then
				table.insert(res, {eff = eff, types = types})
			elseif eff == 1 then
				table.insert(std, {eff = 1, types = types})
			else -- eff > 1
				table.insert(weak, {eff = eff, types = types})
			end
		end
	end

	-- Pointless to sort imm and std, as they only have one item
	table.sort(res, dr.EffTable.greatestEffFirst)
	table.sort(weak, dr.EffTable.greatestEffFirst)

	interpData.effBoxes = dr.EffTable.printEffBoxes({weak, std, res, imm},
            this.colors)

	local effTab = string.interp([[<div class="roundy pull-center text-center width-xl-80 width-md-100" style="padding: 0.5ex; padding-bottom: 0.01ex; ${bg}">${effBoxes}${foot}</div>]], interpData)

	if #this.labels > 0 then
		return string.interp([[==== ${title} ====
<div class="${collapse}">
${effTab}
</div>]],
			{
				title = mw.text.listToText(this.labels, ', ', ' e '),
				collapse = this.collapse or '',
				effTab = effTab
			})
	end

	return tab
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
	MAYBE = 'Se questo Pok&eacute;mon ha [[${abil} (abilità)|${abil}]] ',

    -- TAKENOFF category beginning text
	TAKENOFF = 'Se questo Pok&eacute;mon perde [[${abil} (abilità)|${abil}]], o se ne sono annullati gli effetti, ',

    -- RINGTARGET category beginning text
	RINGTARGET = 'Se questo Pok&eacute;mon tiene un [[Facilsaglio]]',

	-- Strings to be concatenated to RINGTARGET for some types
	SPETTRO = ', se un avversario usa [[Preveggenza (mossa)|Preveggenza]] o [[Segugio (mossa)|Segugio]] o ha [[Nervisaldi (abilità)|Nervisaldi]], ',
	BUIO = ' o se un avversario usa [[Miracolvista (mossa)|Miracolvista]], ',
	VOLANTE = ' o una [[Ferropalla]] o se viene usata [[Gravità (mossa)|Gravit&agrave;]], ',

	--[[
		Strings to be concatenated to RINGTARGET for immunities shared by
        ability and types
	--]]
	NOT_HAVE_ABIL = 'e se non ha [[${abil} (abilità)|${abil}]], ',
	IMM_TAKENOFF = 'e se ha perso [[${abil} (abilità)|${abil}]] o ne sono stati annullati gli effetti, ',

	-- New effectieness text
	EFF = "l'efficacia delle mosse di tipo ${types} &egrave; pari a ${eff}×"
}

-- Sorting categories to sort footerlines
dr.EffTable.FooterLine.kindOrder = {'MAYBE', 'TAKENOFF', 'RINGTARGET'}

--[[

Returns whether an ability gives immunity to a certain type. The arguments are
the ability and the type.
It just checks whether the effectivenes of type against a type that doesn't
have immunities by itself is zero.

--]]
dr.EffTable.FooterLine.abilityGrantsImm = function(abil, type)
	return 0 == et.efficacia(type, 'elettro', 'elettro', abil)
end

--[[

This table holds functions to generate the initial part of a FooterLine based
on its category.

--]]
dr.EffTable.FooterLine.init = {}

-- Initial part for MAYBE category. Simple string interpolation.
dr.EffTable.FooterLine.init.MAYBE = function(abil)
	return string.interp(dr.EffTable.FooterLine.strings.MAYBE,
			{abil = string.camelCase(abil)})
end

-- Initial part for TAKENOFF category. Simple string interpolation.
dr.EffTable.FooterLine.init.TAKENOFF = function(abil)
	return string.interp(dr.EffTable.FooterLine.strings.TAKENOFF,
			{abil = string.camelCase(abil)})
end

--[[

Initial part for RINGTARGET category. After adding some more strings based on
the type and the abilities, concatenates the result.

--]]
dr.EffTable.FooterLine.init.RINGTARGET = function(abils, type)
	local pieces = {dr.EffTable.FooterLine.strings.RINGTARGET}

    -- Adding text for specific types, otherwise a space
	table.insert(pieces, dr.EffTable.FooterLine.strings[type:upper()] or ' ')

	--[[
        If the Pokémon has only one ability, the related string deals with its
        loss, otherwise it is about the possibility of it happening.
	--]]
	local notAbil = table.getn(abils) == 1
			and dr.EffTable.FooterLine.strings.IMM_TAKENOFF
			or dr.EffTable.FooterLine.strings.NOT_HAVE_ABIL

	--[[
		Adds a stirng for every ability that shares an immunity with the
        type of the footerline
	--]]
	for k, abil in pairs(abils) do
		for k, typeImm in pairs(et.typesHaveImm[type:lower()]) do
			if dr.EffTable.FooterLine.abilityGrantsImm(abil, typeImm) then
				table.insert(pieces, string.interp(notAbil,
						{abil = string.camelCase(abil)}))
			end
		end
	end

	return table.concat(pieces)
end

--[[

FooterLine constructor. Its arguments are a line category, the Pokémon type
and a single ability. The only exception is the RINGTARGET category, that
requires all of thePokémon abilities.

--]]
dr.EffTable.FooterLine.new = function(kind, types, abil)
	local this = setmetatable({}, dr.EffTable.FooterLine)

	kind = kind:upper()
	types = table.map(types, string.lower)
	abil = type(abil) ~= 'table' and abil:lower()
			or table.map(abil, string.lower)

	-- Line category
	this.kind = kind

	-- Initial part of the footer line
	this.init = '\n*' .. dr.EffTable.FooterLine.init[kind](abil, types.type1)

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

    --[[
        RINGTARGET type with mono-type Pokémon, the new effectiveness are 1x
        against the types the Pokémon is immune to
    --]]
    if kind == 'RINGTARGET' and types.type1 == types.type2 then
        this.newEff[1] = et.typesHaveImm[types.type1]
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
	for k, type in ipairs(newTypes) do
		local eff = et.efficacia(type, types.type1, types.type2, abil)
		if this.newEff[eff] then
			table.insert(this.newEff[eff], type)
		else
			this.newEff[eff] = {type}
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
    if this.kind == 'RINGTARGET' then
        -- The new types are the ones the first type is immune to
        newTypes = et.typesHaveImm[types.type1]
        -- The Pokémon is now mono-type, in type effectiveness respect
        types.type1 = types.type2
    else
        -- The new types are the ones the ability has an impact on
        newTypes = et.modTypesAbil[abil]
        --[[
            If the ability is taken off, then it should not be taken in
            account when dealing with this line type effectiveness
        --]]
        abil = this.kind == 'TAKENOFF' and 'tanfo' or abil
    end

    return newTypes, types, abil
end

--[[
    This method takes care of corner case abilities that need to be treated
    separately when calculating new effectiveness. It takes as argument athe
    ability to be checked and possibly handled, and the types to be used when
    calculating the new effectiveness. If the ability is a corner case, true
    is returned, false otherwise. Such abilities are so far Filtro,
    Solidroccia, Scudoprisma and Magidifesa.
--]]
dr.EffTable.FooterLine.makeSpecialAbil = function(this, abil, types)
    abil = abil:lower()
	if this.kind ~= 'RINGTARGET' then
		if table.search({'filtro', 'solidroccia', 'scudoprisma'}, abil) then
			local xKeys
			if this.kind == 'TAKENOFF' then
                --[[
                    The ability is taken off, hence the new effectiveness is
                    the non-reduced one, that without the ability.
                --]]
				xKeys = {[2] = 2, [4] = 4}
			else
                --[[
                    The ability is acquired, hence the new effectiveness is
                    the reduced one, that with the ability.
                --]]
				xKeys = {[2] = 1.5, [4] = 3}
			end

			for k, v in pairs(xKeys) do
				local x = et.difesa(k, types.type1, types.type2, 'tanfo')
				if #x > 0 then
                    -- See the comment for this.newEff in the constructor
					table.sort(x)
					this.newEff[v] = x
				end
			end

			return true

        --[[
            The stantard footer would be too long here. Furthermore, the
            ability will always be Shedinja's peculiar, so we chose a custom
            solution.
        --]]
		elseif abil == 'magidifesa' then
			this.tostring = string.interp(table.concat{'\n*',
                    dr.EffTable.FooterLine.strings.TAKENOFF,
					[=[solo mosse di tipo ${normale} e ${lotta} non lo renderanno esausto.]=]},
					{
						abil = 'Magidifesa',
						normale = link.colorType('Normale'),
						lotta = link.colorType('Lotta')
					})

			return true
		end
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
			and table.equal(a.newEff, b.newEff)
end

--[[

Less than operator for FooterLine, to allow sorting. Comparison is made by
categories, as specified in dr.EffTable.FooterLine.kindOrder. In case of
equality, the initial parts of the lines are compared alphabetically.

--]]
dr.EffTable.FooterLine.__lt = function(a, b)
	local aIndex = table.search(dr.EffTable.FooterLine.kindOrder, a.kind)
	local bIndex = table.search(dr.EffTable.FooterLine.kindOrder, b.kind)
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

	local newEff = {}
	--[[
		Can't use table.map because this.newEff has string indices, that
        wouldn't work with table.concat
	--]]
	for eff, types in pairs(this.newEff) do
		local colorTypes = table.map(types, function(type)
				return link.colorType(type)
			end)
		table.insert(newEff, string.interp(dr.EffTable.FooterLine.strings.EFF,
				{
					types = mw.text.listToText(colorTypes, ', ', ' e '),
					eff = dr.EffTable.displayEff(eff)
				}))
	end

	return table.concat{this.init,
        mw.text.listToText(newEff, ', ', ' e '),
        '.'
    }
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
			EffTable:setCollapse('mw-collapsible' ..
					(key == 1 and '' or ' mw-collapsed'))
			return tostring(EffTable)
		end, '\n')
end

--[[

Wikicode interface function: takes as input the name or the ndex of a Pokémon,
or a combo types + abilities and generate the HTML code for type effectiveness
tables for all forms of the Pokémon. While all tables are collapsible, the one
for the base form is the only default-expanded one, whereas the other tables
are all collapsed by default.

--]]
dr.debRes = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
	local pokeData = pokes[string.parseInt(p[1]) or p[1]]
			or pokes[mw.text.decode(p[1])]

	--[[
		If no data is found, the first parameter is the type, that is no
        Pokémon is given and types and abilities are directly provided
	--]]
	if not pokeData then
		local types, abils = {}, {}
		types.type1 = p[1] or p.type1 or p.type
		types.type2 = p[2] or p.type2 or types.type1
		abils.ability1 = p[3] or p.abil1 or p.abil
		abils.ability2 = p[4] or p.abil2
		abils.abilityd = p[5] or p.abild
		abils.abilitye = p[6] or p.abile
		return tostring(dr.EffTable.new(types, abils))
	end

	return list.makeFormsLabelledBoxes({
		name = pokeData.name:lower(),
		makeBox = dr.EffTable.new,
		printBoxes = dr.EffTable.printEffTables
	})
end

dr.DebRes, dr.debres = dr.debRes, dr.debRes

return dr
