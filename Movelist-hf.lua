-- Gli header e i footer per le tabelle dei Pokémon
-- che imaprano una data mossa tramite vari metodi

local j = {}

local mw = require('mw')

local w = require('Wikilib')
local txt = require('Wikilib-strings')          -- luacheck: no unused
local mlentry = require('Movelist-entry')
local ml = require('Movelist')
local css = require('Css')
local c = require("Colore-data")
local gendata = require("Gens-data")

-- Tabelle dati

-- Contiene i colspan dell'ultima cella degli headers

local cs = {}
cs.level = function(gen) return (gendata.latest + 1 - gen) * 3 end
cs.breed, cs.tm = cs.level, cs.level
cs.event = function() return 1 end
cs.tutor = function(gen) return gen end

-- Contiene le sigle e i nomi interi dei giochi delle celle del tutor

local games = {}
games[2] = {{'C', 'cristallo'}}
games[3] = {{'RFVF', 'rossofuoco'}, {'S', 'smeraldo'}, {'XD', 'xd'}}
games[4] = {{'DP', 'diamante'}, {'PT', 'platino'}, {'HGSS', 'heartgold'}}
games[5] = {{'NB', 'nero'}, {'N2B2', 'nero2'}}
games[6] = {{'XY', 'x'}, {'RΩZα', 'rubinoomega'}}
games[7] = {{'SL', 'sole'}, {'USUL', 'ultrasole'}, {'LGPE', 'lgpikachu'}}
games[8] = {{'SpSc', 'spada'}}

-- Contiene le varie funzioni che generano le celle

local cells = {}

-- Funzioni di supporto

-- Funzione per generale le celle dei level

cells.level = function(gen)
	local str = '! class="roundytop" style="background: #${bg}; min-width: 4ex;" colspan="${cs}" | [[${genl} generazione|${genr}]]\n'
    local row = {}
    for a = gen, gendata.latest do
        table.insert(row, string.interp(str, {bg = c[gendata[a].region].normale,
			genl = gendata[a].ext, genr = gendata[a].roman,
			cs = mlentry.maxCellsNumber[a]}))
    end
    return table.concat(row)
end

-- Genera le celle dei tm

cells.tm = function(gen, tms)
	local str = '! class="roundytop" style="background: #${bg}; min-width: 4ex; line-height: 1em;" colspan="${cs}" | [[${genl} generazione|${genr}]]<div class="text-small">${tm}</div>\n'
    local row = {}
    local l
    for a = gen, gendata.latest do
        l = tms[a] == 'NO' and 'Ness.' or string.interp('[[${tm}|${tm}]]', {tm = tms[a]})
        table.insert(row, string.interp(str, {bg = c[gendata[a].region].normale,
			genl = gendata[a].ext, genr = gendata[a].roman, tm = l,
			cs = mlentry.maxCellsNumber[a]}))
    end
    return table.concat(row)
end

-- Genera le celle del breed

cells.breed = function(gen)
	local str = '! class="roundytop" style="background: #${bg}; min-width: 4ex" colspan="${cs}" | [[${genl} generazione|${genr}]]\n'
    local row = {}
    for a = gen, gendata.latest do
        table.insert(row, string.interp(str, {bg = c[gendata[a].region].normale,
			genl = gendata[a].ext, genr = gendata[a].roman,
			cs = mlentry.maxCellsNumber[a]}))
    end
    return table.concat(row)
end

-- Genera le celle del tutor

cells.tutor = function(gen, gms)
	local str = '! class="roundytop" style="background: #${bg}; color: #fff; min-width: 6ex;" | ${game}\n'
    local row = {}
    for a in ipairs(gms) do
		if gms[a] == 'yes' then
			table.insert(row, string.interp(str, {bg = c[games[gen][a][2]].normale,
				game = games[gen][a][1]}))
		end
	end
    return table.concat(row)
end

-- Ritorna le prime celle, comuni a tutti gli headers

local headers = function(tipo, gen, kind)
	return ml.headers(tipo, kind, cs[kind](gen))
end

-- Interfaccia

-- Mosse apprese per livello

j.levelh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen = p[1] or 'pcwiki', tonumber(p[2]) or 0
    return string.interp([=[${str}Livello
|- class="white-text"
${g}]=], {str = headers(tipo, gen, 'level'), g = cells.level(gen)})
end

j.Levelh = j.levelh

-- Mosse apprese per evento

j.eventh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo = p[1] or 'pcwiki'
    return string.interp([=[${str}Ottenuto in
|-
]=], {str = headers(tipo, gen, 'event')})
end

j.Eventh = j.eventh

-- Mosse apprese per MT

j.tmh = function(frame)
    local p, tms = w.trimAndMap(mw.clone(frame.args), string.lower), {}
    local tipo, gen = p[1] or 'pcwiki', tonumber(p[2]) or 0
    for a = 3, 2 + gendata.latest do
        tms[a - 2] = p[a] and string.upper(p[a]) or 'No'
    end
    return string.interp([=[${str}Macchina
|- class="white-text"
${g}]=], {str = headers(tipo, gen, 'tm'), g = cells.tm(gen, tms)})
end

j.TMh, j.Tmh = j.tmh, j.tmh

-- Mosse apprese tramite breeding

j.breedh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen = p[1] or 'pcwiki', tonumber(p[2]) < 2 and 2 or tonumber(p[2])
    return string.interp([=[
${str}Padre
|- class="white-text"
${g}]=], {str = headers(tipo, gen, 'breed'), g = cells.breed(gen)})
end

j.Breedh = j.breedh

-- Mosse apprese tramite insegnamosse

j.tutorh = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, cs = p[1] or 'pcwiki', tonumber(p[2]) or 0
	return string.interp([=[${str}Gioco
|-
]=], {str = headers(tipo, cs, 'tutor')})
end

j.Tutorh = j.tutorh

-- Celle tutor seconda generazione

j.tutor2 = function(frame)
	return cells.tutor(2, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor2 = j.tutor2

-- Celle tutor terza generazione

j.tutor3 = function(frame)
	return cells.tutor(3, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor3 = j.tutor3

-- Celle tutor quarta generazione

j.tutor4 = function(frame)
	return cells.tutor(4, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor4 = j.tutor4

-- Celle tutor quinta generazione

j.tutor5 = function(frame)
	return cells.tutor(5, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor5 = j.tutor5

-- Celle tutor sesta generazione

j.tutor6 = function(frame)
	return cells.tutor(6, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor6 = j.tutor6

-- Celle tutor settima generazione

j.tutor7 = function(frame)
	return cells.tutor(7, w.trimAndMap(mw.clone(frame.args), string.lower))
end

j.Tutor7 = j.tutor7

-- Mosse ombra

j.shadowh = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
	local game = p[1] or 'xd'

	local colo = string.interp('\n! class="roundytop" style="background: #${bg}; width: 100px;" | [[Pokémon Colosseum|<span style="color:#555">C</span>]]\n', {bg = c.colo.normale})
	return string.interp([=[${str}Livello
|-${colo}
! class="roundytop" style="background: #${bg}; width: 100px;" | [[Pokémon XD: Tempesta Oscura|<span style="color:#FFF">XD</span>]]]=],
{
    str = headers('xd', game == 'colo' and gendata.latest or gendata.latest - 1,
		'level'),
    bg = c.xd.light,
    colo = game == 'colo' and colo or ''
})
end

j.Shadowh = j.shadowh

-- Footer

local foot = function(interpData)
	return string.interp([=[|-
! class="text-small text-left" colspan="${cs}" |
* I Pokémon in '''grassetto''' sono quelli che ricevono il [[Bonus di tipo|<span style="color: #000;">bonus di tipo</span>]] dalla mossa.
* I Pokémon in ''corsivo'' sono quelli con evoluzioni o [[Differenze di forma|<span style="color:#333">forme alternative</span>]] che ricevono il bonus di tipo.${last}
|}]=], interpData)
end

j.footer = function(frame)
    return foot({
		cs = 5 + cs.level(1),
		last = ''})
end

-- Footer per le mosse apprese per livello

j.levelf = function(frame)
    return foot({
		cs = 5 + cs.level(1),
		last = [=[

* Le mosse segnate al livello "Evo" possono essere apprese al momento dell'evoluzione.]=]})
end

-- Footer per le mosse apprese per accoppiamento

j.breedf = function(frame)
    return foot({
		cs = 5 + cs.level(1),
		last = [=[

* Premendo su ✔ è possibile vedere i genitori da cui il Pokémon può imparare la mossa.]=]})
end

-- Divisore generazioni event

j.div = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local gen = tonumber(p[1]) or 0
    local genColor = gendata[gen].region
    return string.interp([=[

|-
! colspan="6" style="${bg}" | [[${genl} generazione|<span style="color:#${tc}">${genl} generazione</span>]]]=],
	{
		bg = css.horizGradLua{type = genColor},
		genl = string.fu(gendata[gen].ext),
		tc = c[gendata[gen].region].dark
	})
end

j.Div = j.div

return j
