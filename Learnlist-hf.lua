-- I vari headers e footers dei learnlist, tutti riuniti per condividere
-- la tabella dei colori

-- TODO: add a Lua interface for many of the functions here

local d = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local css = require('Css')
local gendata = require("Gens-data")

-- Tabelle dati

-- Tabella con i valori del colspan della cella con la generazione,
-- che deve coprire tutta la tabella, in base al tipo di header/footer
-- e alla generazione

local cs = {}
cs.level = {6, 6, 9, 9, 8, 11, 8}
cs.tm = {7, 7, 10, 10, 8, 11, 8}
cs.breed = {6, 6, 9, 9, 7, 10, 7}
cs.tutor = {6, 6, 12, 13, 10, 13, 8}
cs.preevo, cs.event = cs.breed, cs.breed

-- Tabella con i valori del colspan e del rowspan della prima cella,
-- divisi per tipo poi per generazione dell'header

local firstcell = {cs = {}, rs = {}}

-- In futuro dovranno essere tutti > 1
firstcell.cs.level = {1, 1, 1, 1, 2, 2, 2}
firstcell.cs.tm = {1, 1, 1, 1, 1, 1, 1}
firstcell.cs.breed = {1, 1, 1, 1, 1, 1, 1}
firstcell.cs.tutor = {1, 1, 3, 3, 2, 2, 2}
firstcell.cs.preevo = firstcell.cs.breed
firstcell.cs.event = firstcell.cs.breed

firstcell.rs.level = {1, 1, 1, 1, 2, 2, 2}
firstcell.rs.breed = {1, 1, 1, 1, 1, 1, 1}
firstcell.rs.tm = firstcell.rs.breed
firstcell.rs.tutor = firstcell.rs.breed
firstcell.rs.preevo = firstcell.rs.breed
firstcell.rs.event = firstcell.rs.breed

-- Tabella con i vari metodi di apprendimento delle mosse

local ways = {}
ways.level = 'aumentando di livello'
ways.tm = 'tramite MT/MN'
ways.tm2 = 'tramite MT'
ways.breed = 'tramite accoppiamento'
ways.tutor = "dall'Insegnamosse"
ways.preevo = 'tramite evoluzioni precedenti'
ways.event = 'tramite eventi'

-- Tabella con le celle della prima riga degli headers

local cells = {}
cells.moveandtype = '!! rowspan = "${r}" | &nbsp;[[Mossa]]&nbsp; !! rowspan = "${r}" | &nbsp;[[Tipo]]&nbsp;'
cells.ppp = [=[!! rowspan = "${r}" | &nbsp;[[Potenza|Pot.]]&nbsp;
! rowspan = "${r}" | &nbsp;[[Precisione|Prec.]]&nbsp;
! rowspan = "${r}" | &nbsp;[[PP]]&nbsp;]=]
cells.cat = '!! rowspan = "${r}" | &nbsp;[[Categoria danno|Cat.]]&nbsp;'
cells.gara = [=[!! rowspan = "${r}" | &nbsp;[[Virtù Gara|Virtù]]&nbsp;
! rowspan = "${r}" | &nbsp;[[Saggio di recitazione|Fascino]]&nbsp;]=]
cells.inib = '!! rowspan = "${r}" | &nbsp;[[Intralcio]]&nbsp;'
cells.level = '! colspan = "${c}" | &nbsp;[[Livello|Lv.]]&nbsp;'
cells.tm = '! colspan = "${c}" | &nbsp;[[MT]]&nbsp;'
cells.tmhm = '! colspan = "${c}" | &nbsp;[[MT]]/[[MN]]&nbsp;'
cells.breed = '! colspan = "${c}" | &nbsp;[[Mossa uovo|${parent}]]&nbsp;'
cells.tutor = '! colspan = "${c}" | &nbsp;[[Videogiochi Pokémon|Gioco]]&nbsp;'
cells.preevo = '! colspan = "${c}" | &nbsp;[[Evoluzione|Stadio]]&nbsp;'
cells.event = '! colspan = "${c}" | &nbsp;[[Evento Pokémon|Evento]]&nbsp;'
cells.basic = table.concat{cells.moveandtype, cells.ppp}
cells.category = table.concat{cells.moveandtype, cells.cat, cells.ppp}
cells[1], cells[2] = cells.basic, cells.basic
cells[5], cells[7] = cells.category, cells.category
cells[3] = table.concat{cells.basic, cells.gara, cells.inib}
cells[4] = table.concat{cells.category, cells.gara}
cells[6] = table.concat{cells.category, cells.gara, cells.inib}

-- Tabella con le celle dei giochi per il levelh
-- incompleta causa mancata implementazione del sistema a due celle

local games = {}
games[5] = [=[

|- class="black-text"
! style="min-width: 2.2em;" | [[Pokémon Nero e Bianco|NB]]
! style="min-width: 3em;" | [[Pokémon Nero 2 e Bianco 2|N2B2]]]=]
games[6] = [=[

|- class="black-text"
! style="min-width: 2.2em;" | [[Pokémon X e Y|XY]]
! style="min-width: 3em;" | [[Pokémon Rubino Omega e Zaffiro Alpha|ROZA]]]=]
games[7] = [=[

|- class="black-text"
! style="min-width: 2.2em;" | [[Pokémon Sole e Luna|SL]]
! style="min-width: 3em;" | [[Pokémon Ultrasole e Ultraluna|USUL]]]=]

-- Tabella con i Pokémon baby ottenibili tramite incensi, necessaria
-- per le righe aggiuntive del footer per le mosse uovo

local baby = {}
baby.Marill, baby.Azumarill = 'Azurill', 'Azurill'
baby.Wobbuffet = 'Wynaut'
baby.Roselia, baby.Roserade = 'Budew', 'Budew'
baby.Chimecho = 'Chingling'
baby.Sudowoodo = 'Bonsly'
baby['Mr. Mime'] = 'Mime Jr.'
baby.Chansey, baby.Blissey = 'Happiny', 'Happiny'
baby.Snorlax = 'Munchlax'
baby.Mantine = 'Mantyke'

-- Tabella con le righe da aggiungere ai footer: manca preevo
-- perché non vi è nessuna riga da aggiungere

local rowsf = {}
rowsf.level = [=[*Il livello "Inizio" indica una mossa conosciuta da ${poke} ottenuto a livello 1 in ${genl} generazione.
*Le mosse segnate al livello "Evo" possono essere apprese al momento dell'evoluzione.]=]
rowsf.breed1 = [=[*Le mosse segnate con un asterisco (*) si ottengono solo con una [[catena di accoppiamenti|<span class="black-text">catena di accoppiamenti</span>]] su ${poke} in ${genl} generazione.
*Le mosse segnate con una doppia croce (‡) possono essere ottenute solo da un Pokémon che le abbia apprese in una generazione precedente.
*Le mosse segnate con un'abbreviazione di un gioco in apice si possono ottenere su ${poke} solo in quel gioco.]=]
rowsf.breed2 = [=[

*Le mosse segnate con una croce (†) si possono ottenere su ${poke} solo se ad uscire dall'uovo è [[${baby}|<span class="black-text">${baby}</span>]], e non altrimenti.]=]
rowsf.tutor = [=[*Un'abbreviazione bianca in una casella colorata indica che ${poke} può imparare la mossa dall'Insegnamosse in quel gioco.
*Un'abbreviazione colorata su sfondo bianco indica che ${poke} non può imparare la mossa dall'Insegnamosse in quel gioco.]=]
rowsf.event = '*Un livello in apice indica che ${poke} può imparare questa mossa normalmente in ${genl} generazione a quel livello.'
rowsf.last = [[

*Clicca sui numeri delle generazioni in alto per vedere le mosse apprese ${way} nelle altre generazioni.]]

-- Testo da aggiungere per le forme

rowsf.forms = {}
rowsf.forms.none = "'evoluzione"
rowsf.forms.yes = '\'evoluzione o una [[Differenze di forma#${poke}|<span class="black-text">forma alternativa</span>]]'
rowsf.forms.mega = 'a [[Megaevoluzione|<span class="black-text">Megaevoluzione</span>]]'

-- Funzioni di supporto

-- Generano i link alle altre generazione, in alto a destra degli headers

local genlink = function(gen, method, poke)
	method = (method == 'tm' and tonumber(gen) > 6) and 'tm2' or method
    if gen == gendata.latest then
        return txt.interp('[[${poke}#${way}|${genroman}]]',
            {poke = poke, way = string.fu(ways[method]),
			genroman = gendata[gen].roman})
    else
        return txt.interp('[[${poke}/Mosse apprese in ${genletters} generazione#${way}|${genroman}]]',
            {poke = poke, genletters = gendata[gen].ext,
            way = string.fu(ways[method]), genroman = gendata[gen].roman})
    end
end

local oldgenslinks = function(genh, genp, method, poke)
    if genp == gendata.latest then
        return 'Nessuna'
    end
    local str = {}
    for a = genp, gendata.latest do
        if a ~= genh then
            table.insert(str, genlink(a, method, poke))
        end
    end
    return table.concat(str, '&nbsp;•&nbsp;')
end

-- Crea le celle dell'ultima riga degli headers

local lowrow = function(gen, kind)
	local values = {r = firstcell.rs[kind][gen],
		c = firstcell.cs[kind][gen], parent = gen > 5 and
		'Genitore' or 'Padre'}

	kind = (kind == 'tm' and gen < 7) and 'tmhm' or kind

	local baseStr = table.concat{cells[kind], cells[gen],
		(kind == 'level' and gen > 4) and games[gen] or ''}
	return txt.interp(baseStr, values)
end

-- Genera solo le righe dei footer diverse in base al tipo dello stesso

local rowf = function(kind, gen, poke)
	local rows = rowsf[kind] or ''
	if kind == 'breed' then
		rows = rowsf.breed1 .. (baby[poke] and rowsf.breed2 or '')
	end
	return txt.interp(rows, {poke = poke, genl = gendata[gen].ext,
		baby = baby[poke]})
end

-- Crea i vari headers; chiamata da tutti gli header

local header = function(pars, kind)
	local tipo1, tipo2 = pars[2] or 'Sconosciuto', pars[3] or 'Sconosciuto'
	local genh, genp = tonumber(pars[4]) or 0, tonumber(pars[5]) or 0
	local poke = pars[1] or ''
	return txt.interp([=[
<div class="text-center max-width-xl-100">
<div class="roundy text-center inline-block max-width-xl-100" style="${bg}">
<div class="flex-row-center-around flex-wrap" style="padding: 0.5ex;"><div><span class="big-font"><span class="big-font">'''${gentitle}&nbsp;generazione'''</span></span></div>
<div class="text-center black-text" style="font-weight: bold; padding: 0.5ex;">
<div class="small-font" style="margin-top: 0.5ex;">Altre&nbsp;generazioni:</div>
<div>${links}</div>
</div>
</div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100" style="margin-top: 0; border-spacing: 0; background: transparent;"
|- class="text-center black-text"
${low_row}]=],
{
	bg = css.horizGradLua{type1 = tipo1, type2 = tipo2},
	gentitle = string.fu(gendata[genh].ext),
	links = oldgenslinks(genh, genp, kind, poke),
	low_row = lowrow(genh, kind)
})
end

-- Genera i footer, chiamata da tutti i footer

local footer = function(pars, kind)
	local tipo, form = pars[3] or 'Sconosciuto', string.lower(pars.form or 'none')
	local genf, genp = tonumber(pars[4]) or 0, tonumber(pars[5]) or 0
	local poke = pars[1] or ''
    return txt.interp([=[
|}</div>
<div class="text-left small-font" style="line-height: 1em; padding: 0 0.5ex 1ex;">
${kindrows}
*Il '''grassetto''' indica una mossa che ha il [[Bonus di tipo|<span class="black-text">bonus di tipo</span>]] quando viene usata da un ${poke}.
*Il ''corsivo'' indica una mossa che ha il bonus di tipo solo quando viene usata da un${form} di ${poke}.${last}
</div>
</div>
</div>]=],
{
	kindrows = rowf(kind, genf, poke),
	poke = poke,
	form = txt.interp(rowsf.forms[form], {poke = poke}) or '',
	last = genp < gendata.latest and txt.interp(rowsf.last, {way = ways[kind]}) or ''
})
end

d.levelh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'level')
end

d.Levelh = d.levelh

d.levelhLGPE = function(frame)
	local pars = lib.sanitize(mw.clone(frame.args))
	local tipo1, tipo2 = pars[2] or 'Sconosciuto', pars[3] or 'Sconosciuto'
	local genh, genp = tonumber(pars[4]) or 0, tonumber(pars[5]) or 0
	local poke = pars[1] or ''
	return txt.interp([=[
<div class="text-center max-width-xl-100">
<div class="roundy text-center inline-block max-width-xl-100" style="${bg}">
<div class="flex-row-center-around flex-wrap" style="padding: 0.5ex;"><div class="big-font"><span class="big-font black-text">'''Settima&nbsp;generazione: [[Pokémon: Let's Go, Pikachu! e Let's Go, Eevee!|LGPE]]'''</span></div>
</div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100" style="margin-top: 0; border-spacing: 0; background: transparent;"
|- class="text-center black-text"
! colspan="2" | [[Livello|Lv.]]
! [[Mossa]]
! [[Tipo]]
! [[Categoria danno|Cat.]]
! [[Potenza|Pot.]]
! [[Statistiche#Precisione|Prec.]]
! [[PP]]]=],
{
	bg = css.horizGradLua{type1 = tipo1, type2 = tipo2}
})
end

d.LevelhLGPE = d.levelhLGPE

-- Header per le mosse imparate tramite MT/MN

d.tmh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'tm')
end

d.Tmh = d.tmh

d.tmhLGPE = function(frame)
	local pars = lib.sanitize(mw.clone(frame.args))
	local tipo1, tipo2 = pars[2] or 'Sconosciuto', pars[3] or 'Sconosciuto'
	local genh, genp = tonumber(pars[4]) or 0, tonumber(pars[5]) or 0
	local poke = pars[1] or ''
	return txt.interp([=[
<div class="text-center max-width-xl-100">
<div class="roundy text-center inline-block max-width-xl-100" style="${bg}">
<div class="flex-row-center-around flex-wrap" style="padding: 0.5ex;"><div class="big-font"><span class="big-font black-text">'''Settima&nbsp;generazione: [[Pokémon: Let's Go, Pikachu! e Let's Go, Eevee!|LGPE]]'''</span></div>
</div>
<div style="overflow-x: auto; margin: 0 0.3ex;">
{| class="white-rows max-width-xl-100 width-xl-100" style="margin-top: 0; border-spacing: 0; background: transparent;"
|- class="text-center black-text"
! [[MT]]
! [[Mossa]]
! [[Tipo]]
! [[Categoria danno|Cat.]]
! [[Potenza|Pot.]]
! [[Statistiche#Precisione|Prec.]]
! [[PP]]]=],
{
	bg = css.horizGradLua{type1 = tipo1, type2 = tipo2}
})
end

d.TmhLGPE = d.tmhLGPE

-- Header per le mosse imparate aumentando di livello

d.breedh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'breed')
end

d.Breedh = d.breedh

-- Header per le mosse imparate dall'Insegnamosse

d.tutorh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'tutor')
end

d.Tutorh = d.tutorh

-- Header per le mosse imparate tramite evoluzioni precedenti

d.prevoh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'preevo')
end

d.Prevoh, d.preevoh, d.Preevoh = d.prevoh, d.prevoh, d.prevoh

-- Header per le mosse imparate tramite eventi

d.eventh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'event')
end

d.Eventh = d.eventh

-- Footer per le mosse imparate aumentando di livello

d.levelf = function(frame)
   return footer(lib.sanitize(mw.clone(frame.args)), 'level')
end

d.Levelf = d.levelf
-- It's not accurate, but almost so I'll use this because right now I'm in a
-- hurry
d.levelfLGPE = d.levelf

-- Footer per le mosse imparate tramite MT/MN

d.tmf = function(frame)
    return footer(lib.sanitize(mw.clone(frame.args)), 'tm')
end

d.Tmf = d.tmf
-- It's not accurate, but almost so I'll use this because right now I'm in a
-- hurry
d.tmfLGPE = d.tmf

-- Footer per le mosse imparate tramite accoppiamento

d.breedf = function(frame)
   return footer(lib.sanitize(mw.clone(frame.args)), 'breed')
end

d.Breedf = d.breedf

-- Footer per le mosse imparate tramite Insegnamosse

d.tutorf = function(frame)
    return footer(lib.sanitize(mw.clone(frame.args)), 'tutor')
end

d.Tutorf = d.tutorf

-- Footer per le mosse imparate tramite accoppiamento

d.prevof = function(frame)
    return footer(lib.sanitize(mw.clone(frame.args)), 'preevo')
end

d.Prevof, d.Preevof, d.preevof = d.prevof, d.prevof, d.prevof

-- Footer per le mosse imparate tramite evento

d.eventf = function(frame)
    return footer(lib.sanitize(mw.clone(frame.args)), 'event')
end

d.Eventf = d.eventf

-- Entry per un Pokémon che impara tutte le MT e MN

d.alltm = function(frame)
    local p = lib.sanitize(mw.clone(frame.args))
	local gen = tonumber(p[2]) or gendata.latest
	local moveKind = {Tm = gen > 6 and '[[MT]]' or '[[MT]] e [[MN]]',
					  Tutor = 'mossa tutor'}
    return txt.interp([=[
|-
! class="white-bg black-text" style="padding: 0.1em 0.3em;" colspan ="${cs}" | ${poke} può imparare ''qualsiasi'' ${moveKind} in ${gen} generazione${except}.]=],
{
    poke = p[1] or 'Questo Pokémon',
    moveKind = moveKind[p[3] or 'Tm'],
    gen = gendata[gen].ext or 'brockolosa',
    except = p[3] == 'Tm' and '' or ' tranne [[mosse tutor peculiari|quelle peculiari]]',
	cs = cs.tm[gen],
})
end

d.AllTM, d.Alltm = d.alltm, d.alltm

return d
