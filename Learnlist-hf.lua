-- I vari headers e footers dei learnlist, tutti riuniti per condividere
-- la tabella dei colori

local d = {}

local mw = require('mw')

local txt = require('Wikilib-strings')
local lib = require('Wikilib-learnlists')
local c = require("Colore-data")
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
firstcell.cs.level = {1, 1, 1, 1, 2, 2, 1}

firstcell.cs.tm = {2, 2, 2, 2, 2, 2, 2}
firstcell.cs.breed = {1, 1, 1, 1, 1, 1, 1}
firstcell.cs.tutor = {1, 1, 4, 5, 4, 4, 2}
firstcell.cs.preevo = firstcell.cs.breed
firstcell.cs.event = firstcell.cs.breed

firstcell.rs.level = {1, 1, 1, 1, 2, 2, 1}
firstcell.rs.breed = {1, 1, 1, 1, 1, 1, 1}
firstcell.rs.tm = firstcell.rs.breed
firstcell.rs.tutor = firstcell.rs.breed
firstcell.rs.preevo = firstcell.rs.breed
firstcell.rs.event = firstcell.rs.breed

-- Tabella con i vari metodi di apprendimento delle mosse

local ways = {}
ways.level = 'aumentando di livello'
ways.tm = 'tramite MT/MN'
ways.breed = 'tramite accoppiamento'
ways.tutor = "dall'Insegnamosse"
ways.preevo = 'tramite evoluzioni precedenti'
ways.event = 'tramite eventi'

-- Tabella con le celle della prima riga degli headers

local cells = {}
cells.moveandtype = '!! rowspan = "${r}" | &nbsp;[[Mossa|<span style="color:#000;">Mossa</span>]]&nbsp; !! rowspan = "${r}" | &nbsp;[[Tipi|<span style="color:#000;">Tipo</span>]]&nbsp;'
cells.ppp = [=[!! rowspan = "${r}" | &nbsp;[[Potenza|<span style="color:#000;">Pot.</span>]]&nbsp;
! rowspan = "${r}" | &nbsp;[[Precisione|<span style="color:#000;">Prec.</span>]]&nbsp;
! rowspan = "${r}" | &nbsp;[[PP|<span style="color:#000;">PP</span>]]&nbsp;]=]
cells.cat = '!! rowspan = "${r}" | &nbsp;[[Categoria danno|<span style="color:#000;">Cat.</span>]]&nbsp;'
cells.gara = [=[!! rowspan = "${r}" | &nbsp;[[Virtù Gara|<span style="color:#000;">Virtù</span>]]&nbsp;
! rowspan = "${r}" | &nbsp;[[Saggio di recitazione|<span style="color:#000;">Fascino</span>]]&nbsp;]=]
cells.inib = '!! rowspan = "${r}" | &nbsp;[[Intralcio|<span style="color:#000;">Intralcio</span>]]&nbsp;'
cells.level = '! colspan = "${c}" | &nbsp;[[Livello|<span style="color:#000;">Lv.</span>]]&nbsp;'
cells.tm = '! colspan = "${c}" | &nbsp;[[MT|<span style="color:#000;">MT</span>]]/[[MN|<span style="color:#000;">MN</span>]]&nbsp;'
cells.breed = '! colspan = "${c}" | &nbsp;[[Mossa uovo|<span style="color:#000;">${parent}</span>]]&nbsp;'
cells.tutor = '! colspan = "${c}" | &nbsp;[[Videogiochi Pokémon|<span style="color:#000;">Gioco</span>]]&nbsp;'
cells.preevo = '! colspan = "${c}" | &nbsp;[[Evoluzione|<span style="color:#000;">Stadio</span>]]&nbsp;'
cells.event = '! colspan = "${c}" | &nbsp;[[Evento Pokémon|<span style="color:#000;">Evento</span>]]&nbsp;'
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

|- style="background:#${bg};"
! &nbsp;&nbsp;[[Pokémon Nero e Bianco|<span style="color:#000;">NB</span>]]&nbsp;&nbsp;
! &nbsp;[[Pokémon Nero 2 e Bianco 2|<span style="color:#000;">N2B2</span>]]&nbsp;]=]
games[6] = [=[

|- style="background:#${bg};"
! &nbsp;&nbsp;[[Pokémon X e Y|<span style="color:#000;">XY</span>]]&nbsp;&nbsp;
! &nbsp;[[Pokémon Rubino Omega e Zaffiro Alpha|<span style="color:#000;">ROZA</span>]]&nbsp;]=]

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
rowsf.level = [=[*Il livello "Inizio" indica una mossa conosciuta da ${poke} ottenuto a livello 1 nella ${genl} generazione.
*Le mosse segnate al livello &#x2670; possono essere apprese al momento dell'evoluzione.]=]
rowsf.breed1 = [=[*Le mosse segnate con un asterisco (*) si ottengono solo con una [[catena di accoppiamenti|<span style="color:#000;">catena di accoppiamenti</span>]] su ${poke} nella ${genl} generazione.
*Le mosse segnate con una doppia croce (‡) possono essere ottenute solo da un Pokémon che le abbia apprese in una generazione precedente.
*Le mosse segnate con un'abbreviazione di un gioco in apice si possono ottenere su ${poke} solo in quel gioco.]=]
rowsf.breed2 = [=[

*Le mosse segnate con una croce (†) si possono ottenere su ${poke} solo se ad uscire dall'uovo è [[${baby}|<span style="color: #000">${baby}</span>]], e non altrimenti.]=]
rowsf.tutor = [=[*Un'abbreviazione nera in una casella colorata indica che ${poke} può imparare la mossa dall'Insegnamosse in quel gioco.
*Un'abbreviazione colorata in una casella bianca indica che ${poke} non può imparare la mossa dall'Insegnamosse in quel gioco.]=]
rowsf.event = '*Un livello in apice indica che ${poke} può imparare questa mossa normalmente nella ${genl} generazione a quel livello.'
rowsf.last = [[

*Clicca sui numeri delle generazioni in alto per vedere le mosse apprese ${way} nelle altre generazioni.]]

-- Testo da aggiungere per le forme

rowsf.forms = {}
rowsf.forms.none = "'evoluzione"
rowsf.forms.yes = '\'evoluzione o una [[Differenze di forma#${poke}|<span style="color: #000;">forma alternativa</span>]]'
rowsf.forms.mega = 'a [[Megaevoluzione|<span style="color: #000;">Megaevoluzione</span>]]'

-- Funzioni di supporto

-- Generano i link alle altre generazione, in alto a destra degli headers

local genlink = function(gen, method, poke)
    if gen == gendata.latest then
        return txt.interp('[[${poke}#${way}|<span style="color:#000;">${genroman}</span>]]',
            {poke = poke, way = string.fu(ways[method]),
			genroman = gendata[gen].roman})
    else
        return txt.interp('[[${poke}/Mosse apprese nella ${genletters} generazione#${way}|<span style="color:#000;">${genroman}</span>]]',
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

local lowrow = function(gen, kind, bg)
	local values = {r = firstcell.rs[kind][gen],
		c = firstcell.cs[kind][gen], parent = gen > 5 and
		'Genitore' or 'Padre', bg = bg}
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
	local color2 = tipo1 == tipo2 and c[tipo1].light or c[tipo2].normale
    return txt.interp([=[{| class="roundy text-center pull-center" style="background: #${background}; border: 3px solid #${color2};"
|-
| class="roundytop" style="background: #${cells_upper};" colspan="${colspan}" |
{| style="width: 100%; background: transparent;"
! style="width: 60%;" | <span class="big-font"><span class="big-font">${gentitle}&nbsp;generazione</span></span>
! style="width: 40%;" |
{| class="roundy" style="background:transparent; border: 2px solid #${background};"
! style="line-height:10px;" | <span class="small-font">Altre&nbsp;generazioni:</span>
|-
! ${links}
|}
|}
|- class="text-center" style="background:#${color2};"
${low_row}]=],
{
    background = c[tipo1].normale,
    color2 = color2,
    cells_upper = c[tipo1].light,
    colspan = cs[kind][genh],
    gentitle = string.fu(gendata[genh].ext),
    links = oldgenslinks(genh, genp, kind, poke),
    low_row = lowrow(genh, kind, color2)
})
end

-- Genera i footer, chiamata da tutti i footer

local footer = function(pars, kind)
	local tipo, form = pars[3] or 'Sconosciuto', string.lower(pars.form or 'none')
	local genf, genp = tonumber(pars[4]) or 0, tonumber(pars[5]) or 0
	local poke = pars[1] or ''
	local preevoBold = kind == 'preevo' and "'evoluzione precedente di" or ''
    return txt.interp([=[|-
| class="roundybottom text-left small-font" style="background:#${background}; line-height:10px;" colspan="${colspan}" |
${kindrows}
*Il '''grassetto''' indica una mossa che ha lo [[Same Type Attack Bonus|<span style="color: #000">STAB</span>]] quando viene usata da un${preevoBold} ${poke}.
*Il ''corsivo'' indica una mossa che ha lo STAB solo quando viene usata da un${form} di${preevoItalic} ${poke}.${last}
|}]=],
{
    background = c[tipo].light,
    colspan = cs[kind][genf],
    kindrows = rowf(kind, genf, poke),
    preevoBold = preevoBold,
    poke = poke,
    form = txt.interp(rowsf.forms[form], {poke = poke}) or '',
    preevoItalic = kind == 'preevo' and " un'evoluzione precedente di" or '',
    last = genp < gendata.latest and txt.interp(rowsf.last, {way = ways[kind]}) or ''
})
end

d.levelh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'level')
end

d.Levelh = d.levelh

-- Header per le mosse imparate tramite MT/MN

d.tmh = function(frame)
	return header(lib.sanitize(mw.clone(frame.args)), 'tm')
end

d.Tmh = d.tmh

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

-- Footer per le mosse imparate tramite MT/MN

d.tmf = function(frame)
    return footer(lib.sanitize(mw.clone(frame.args)), 'tm')
end

d.Tmf = d.tmf

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
    local moveKind = {tm = 'MT e MN', tutor = 'mossa tutor'}
    local letterGen = {}
    tab2['1'], tab2['2'], tab2['3'], tab2['4'], tab2['5'], tab2['6'] = 'prima', 'seconda', 'terza', 'quarta', 'quinta', 'sesta'
    tab2.I, tab2.II, tab2.III, tab2.IV, tab2.V, tab2.VI = tab2['1'], tab2['2'], tab2['3'], tab2['4'], tab2['5'], tab2['6']
    return txt.interp([=[|-
! style="background:#FFF; border:1px solid #D8D8D8;" colspan ="8" | ${poke} può imparare ''qualsiasi'' ${moveKind} nella ${gen} generazione${except}.]=],
{
    poke = p[1] or 'Questo Pokémon',
    moveKind = moveKind[p[3] or 'tm'],
    gen = letterGen[p[2]] or 'brockolosa',
    except = p[3] == 'tm' and '' or ' tranne [[mosse tutor peculiari|<span style="color:#000">quelle peculiari</span>]]'
})
end

d.AllTM, d.Alltm = d.alltm, d.alltm

return d
