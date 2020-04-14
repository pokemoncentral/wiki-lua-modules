-- Gli header e i footer per le tabelle dei Pokémon
-- che imaprano una data mossa tramite vari metodi

local j = {}

local mw = require('mw')

local w = require('Wikilib')
local tab = require('Wikilib-tables')  -- luacheck: no unused
local txt = require('Wikilib-strings') -- luacheck: no unused
local multigen = require('Wikilib-multigen')
local mlentry = require('Movelist-entry')
local css = require('Css')
local c = require("Colore-data")
local gendata = require("Gens-data")
local moves = require("Move-data")
local mtdata = require("Machines-data")

-- Tabelle dati

j.strings = {
	HEADERBASE = [=[
{| class="roundy text-center white-rows roundy-footer" style="${bg}; border-spacing: 0; padding: 0.3ex;"
! class="roundytl hidden-xs" rowspan="${rs}" | #
! rowspan="${rs}" colspan="2" | Pokémon
! class="hidden-sm" rowspan="${rs}" | Tipo
! class="hidden-sm" style="padding: 0 0.7ex;" rowspan="${rs}" | Gruppo uova
! class="roundytr" colspan="${cs}" | ]=],
	HEADERTM = [=[
! class="roundytop" style="background: #${bg}; min-width: 4ex; line-height: 1em;" colspan="${cs}" | [[${genl} generazione|${genr}]]<div class="text-small">${tm}</div>
]=],
}

-- Contiene i colspan dell'ultima cella degli headers

local cs = {}
cs.level = function(gen) return (gendata.latest + 1 - gen) * 3 end
cs.breed, cs.tm = cs.level, cs.level
cs.event = function() return 1 end
cs.tutor = function(gen) return gen end
-- cs.autotm = function(gen)
-- 	-- TODO: compute the right colspan (it may be enough a filter with i >= gen)
-- 	return table.fold(j.tmcellgames, 0, function(acc, gengames)
-- 		return acc + #gengames
-- 	end, ipairs)
-- end

-- Contiene le sigle e i nomi interi dei giochi delle celle del tutor

local games = {}
games[2] = {{'C', 'cristallo'}}
games[3] = {{'RFVF', 'rossofuoco'}, {'S', 'smeraldo'}, {'XD', 'xd'}}
games[4] = {{'DP', 'diamante'}, {'Pt', 'platino'}, {'HGSS', 'heartgold'}}
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
	local str = '! class="roundytop" style="background: #${bg}; min-width: 6ex;" | ${game}\n'
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

j.headers = function(tipo, gen, kind)
	return string.interp(j.strings.HEADERBASE, {
		bg = css.horizGradLua{type = tipo},
	    rs = kind == 'event' and 1 or 2,
	    cs = cs[kind](gen),
	})
end

-- Interfaccia

-- Mosse apprese per livello

j.levelh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen = p[1] or 'pcwiki', tonumber(p[2]) or 0
    return string.interp([=[${str}Livello
|- class="white-text"
${g}]=], {str = j.headers(tipo, gen, 'level'), g = cells.level(gen)})
end

j.Levelh = j.levelh

-- Mosse apprese per evento

j.eventh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo = p[1] or 'pcwiki'
    return string.interp([=[${str}Ottenuto in
|-
]=], {str = j.headers(tipo, nil, 'event')})
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
${g}]=], {str = j.headers(tipo, gen, 'tm'), g = cells.tm(gen, tms)})
end

j.TMh, j.Tmh = j.tmh, j.tmh

-- Mosse apprese tramite breeding

j.breedh = function(frame)
    local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo, gen = p[1] or 'pcwiki', tonumber(p[2]) < 2 and 2 or tonumber(p[2])
    return string.interp([=[
${str}Padre
|- class="white-text"
${g}]=], {str = j.headers(tipo, gen, 'breed'), g = cells.breed(gen)})
end

j.Breedh = j.breedh

-- Mosse apprese tramite insegnamosse

j.tutorh = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
    local tipo = p[1] or 'pcwiki'
	return string.interp([=[${str}Gioco
|- class="white-text"
]=], {str = j.headers(tipo, tonumber(p[2]) or 0, 'tutor')})
end

j.Tutorh = j.tutorh

-- Celle tutor nelle varie gen
for g = 2,8 do
	j["tutor" .. tostring(g)] = function(frame)
		return cells.tutor(g, w.trimAndMap(mw.clone(frame.args), string.lower))
	end

	j["Tutor" .. tostring(g)] = j["tutor" .. tostring(g)]
end

-- Mosse ombra

j.shadowh = function(frame)
	local p = w.trimAndMap(mw.clone(frame.args), string.lower)
	local game = p[1] or 'xd'

	local colo = string.interp('\n! class="roundytop" style="background: #${bg}; width: 100px;" | [[Pokémon Colosseum|<span style="color:#555">C</span>]]\n', {bg = c.colo.normale})
	return string.interp([=[${str}Livello
|-${colo}
! class="roundytop" style="background: #${bg}; width: 100px;" | [[Pokémon XD: Tempesta Oscura|<span style="color:#FFF">XD</span>]]]=],
{
    str = j.headers('xd', game == 'colo' and gendata.latest or gendata.latest - 1,
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

j.footer = function(_)
    return foot({
		cs = 5 + cs.level(1),
		last = ''})
end

-- Footer per le mosse apprese per livello

j.levelf = function(_)
    return foot({
		cs = 5 + cs.level(1),
		last = [=[

* Le mosse segnate al livello "Evo" possono essere apprese al momento dell'evoluzione.]=]})
end

-- Footer per le mosse apprese per accoppiamento

j.breedf = function(_)
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


-- ============================ Automatic tm header ===========================
j.tmcellgames = {
	{ { bg = gendata[1].region, abbr = "" } }, -- 1
	{ { bg = gendata[2].region, abbr = "" } }, -- 2
	{ -- 3
		{ bg = gendata[3].region, abbr = "RZS" },
		{ bg = gendata[3].region, abbr = "RFVF" },
	},
	{ -- 4
		{ bg = "diamante", abbr = "DPPt" },
		{ bg = "heartgold", abbr = "HGSS" },
	},
	{ { bg = gendata[5].region, abbr = "" } }, -- 5
	{ -- 6
		{bg = 'x', abbr = 'XY'},
		{bg = 'rubinoomega', abbr = 'ROZA'},
	},
	{
		{ bg = 'sole', abbr = "SLUSUL" },
		{ bg = 'lgp', abbr = "LGPE" },
	}, -- 7
	{
		{ bg = 'spada', abbr = "SpSc" },
	}, -- 8
}

j.autotmhlua = function(move)
	local tipo = multigen.getGenValue(moves[move].type)
	local startgen = moves[move].gen or 1
	local res = {
		j.headers(tipo, startgen, 'tm'),
		'Macchine\n|- class="white-text"\n',
	}
	local link
	for g = startgen, gendata.latest do
		local tmkind, tmnum = table.deepSearch(mtdata[g], move)
		link = tmkind
		     and table.concat{'[[', tmkind, string.nFigures(tmnum, 2), ']]'}
			 or 'Ness.'
		table.insert(res, string.interp(j.strings.HEADERTM, {
			bg = c[gendata[g].region].normale,
			genl = gendata[g].ext,
			genr = gendata[g].roman,
			tm = link,
			cs = mlentry.maxCellsNumber[g],
		}))
	end
	return table.concat(res)
end

-- WikiCode interface for tmhlua: the only (optional) argument is the move
-- name, defaults to {{BASEPAGENAME}}
j.autotmh = function(frame)
	local move = frame.args[1] and string.trim(frame.args[1])
	                           or mw.title.getCurrentTitle().text
	move = mw.text.decode(move):lower()
	return j.autotmhlua(move)
end
j.autoTMh, j.Autotmh = j.autotmh, j.autotmh


return j
