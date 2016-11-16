-- Modulo che, data un'abilità, restituisce la tabella dei Pokémon che la hanno

local k = {}

local mw = require('mw')

local links = require('Links')
local ms = require('MiniSprite')
local abillib = require('Wikilib-abils')
local oop = require('Wikilib-oop')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local list = require('Wikilib-lists')
local form = require('Wikilib-forms')
local forms = require("AltForms-data")
local c = require("Colore-data")
local pokes = require('Poké-data')

-- !!! ATTENZIONE !!!
--- Questo modulo modifica le copie cachate degli altri moduli dati
local gre = require('GreninjaDemo-data')

--[[

Classe che rappresenta l'entry della tabella,
implementando le interfacce richieste dalle
funzoni makeList, sortNdex e sortForms di
Wikilib/lists

--]]
local Entry = oop.makeClass(list.PokeSortableEntry)

--[[

Costruttore della classe: il primo argomento
è un elemento del modulo dati PokéAbil/data,
il secondo la chiave associata ed il terzo
l'abilita che il Pokémon deve avere. Come
richiesto da makeList in Wikilib/lists, nel
caso l'entry non debba essere inserita,
viene ritornato nil

--]]
Entry.new = function(pokeAbil, name, abil)
	if not table.deepSearch(pokeAbil, abil) then
		return nil
	end

	local this = Entry.super.new(name, pokes[name].ndex)

	this = table.merge(this, pokeAbil)
	
	return setmetatable(table.merge(this, pokes[name]), Entry)
end

-- Wikicode di un'abilità, gestendo il cambio tra generazioni
local printAbil = function(abil)
	if not(abil) then
		return 'Nessuna'
	end
	if type(abil) == 'string' then
		return links.aColor(abil, '000')
	end
	return table.concat(table.map(abillib.abilspan(abil), function(v)
		return string.interp(
			'<div>${abil}<sup>${gen}</sup></div>',
			{
				abil = v.abil == 'Nessuna' and v.abil or links.aColor(v.abil, '000'),
				gen = v.s == v.e and v.s or table.concat{v.s, '-', v.e},
			})
	end))
end

-- Wikicode per la riga di tabella associata all'entry
Entry.__tostring = function(this)
	local monoType = this.type1 == this.type2
	return string.interp([=[| style="border:1px solid #D8D8D8;" | ${ani}
| style="border:1px solid #D8D8D8;" | [[${name}|<span style="color:#000">${name}</span>]]${form}
| colspan="${cs}" style="background:#${std1}; border:1px solid #${dark1};" | [[${type1} (tipo)|<span style="color:#FFF">${type1}</span>]]${type2}
| style="border:1px solid #D8D8D8;" | ${abil1}
| style="border:1px solid #D8D8D8;" | ${abil2}
| style="border:1px solid #D8D8D8;" | ${abild}]=],
{
	ani = ms.aniLua(string.tf(this.ndex or 0) ..
			(this.formAbbr == 'base' and '' or this.formAbbr or '')),
	name = this.name,
	form = this.formsData
			and this.formsData.blacklinks[this.formAbbr]
			or '',
	cs = monoType and '2' or '1',
	std1 = c[this.type1].normale,
	dark1 = c[this.type1].dark,
	type1 = string.fu(this.type1),
	type2 = monoType and '' or string.interp('\n|style="background:#${std2}; border:1px solid #${dark2};" | [[${type2} (tipo)|<span style="color:#FFF">${type2}</span>]]',
		{std2 = c[this.type2].normale, dark2 = c[this.type2].dark, type2 = string.fu(this.type2)}),
	abil1 = printAbil(this.ability1),
	abil2 = printAbil(this.ability2),
	abild = printAbil(this.abilityd),
})
end

-- Ritorna il wikicode per l'header usando il tipo dato per i colori
local makeHeader = function(type)
	return string.interp([=[{| class="roundy text-center pull-center white-rows" style="border: 3px solid #${dark}; background: #${normale};"
|-
! class="roundytl" style="background: #${light};" | [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000;">#</span>]]
! style="background: #${light};" | Pok&eacute;mon
! colspan="2" style="background: #${light};" | [[Tipo|<span style="color:#000;">Tipi</span>]]
! style="background: #${light};" | Prima abilit&agrave;
! style="background: #${light};" | Seconda abilit&agrave;
! class="roundytr" style="background: #${light};" | Abilit&agrave; nascosta]=], c[type])
end

-- Ritorna il wikicode per il footer usando il tipo dato per i colori
local makeFooter = function(type)
	return string.interp([=[
| class="roundybottom text-left font-small" colspan="7" style="background: #${bg}; line-height:10px;" | '''Questa tabella è completamente corretta solo per i giochi di [[settima generazione|<span style="color:#000">settima generazione</span>]].'''
*Per i giochi di [[terza generazione|<span style="color:#000">terza generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive, le seconde e quelle nascoste.
*Per i giochi di [[quarta generazione|<span style="color:#000">quarta generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive e quelle nascoste.
*Per i giochi di [[quinta generazione|<span style="color:#000">quinta</span>]] e [[sesta generazione|<span style="color:#000">sesta generazione</span>]] si ignorino le abilità introdotte nelle generazioni successive.
|}]=], {bg = c[type].light})
end


--[[

Funzione d'interfaccia: si passano il tipo per il colore
e il titolo della pagina, da cui si ricava quello
dell'abilità.

--]]
k.abillist = function(frame)
	local type = string.trim(frame.args[1]) or 'pcwiki'
	local abil = string.trim(mw.text.decode(frame.args[2]))
	abil = abil:match('^(.+) %(abilità%)') or 'Cacofonia'

	return list.makeList({
		source = require('PokéAbil-data'),
		iterator = list.pokeNames,
		entryArgs = abil,
		makeEntry = Entry.new,
		header = makeHeader(type),
		footer = makeFooter(type)
	})
end

k.Abillist = k.abillist

--return k

print(k.abillist{args=arg})
