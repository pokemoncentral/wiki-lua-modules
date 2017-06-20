--[[

Tabella contenente le MT e le MN delle varie generazioni

Può essere chiamato con il nome della pagina
{{#invoke: MTCompatto | MTCompatto | {{BASEPAGENAME}} }}

oppure con il nome di una mossa
{{#invoke: MTCompatto | MTCompatto | Surf }}

oppure specificando le generazioni da mostrare
{{#invoke: MTCompatto | MTCompatto | 123 | tipo = pcwiki }}


Si può anche usare MTGen per avere la tabella di una sola generazione
{{#invoke: MTCompatto | MTGen | 4 | width = 65% }}

--]]

local m = {}

local mw = require('mw')

local w = require('Wikilib')
local tab = require('Wikilib-tables')
local txt = require('Wikilib-strings')
local links = require('AbbrLink')
local css = require('Css')
local machines = require("Machines-data")
local gens = require("Gens-data")
local moves = require("Move-data")

--[[

A partire da una lista di MT/MN del Modulo:Machines/data,
ritorna una stringa che contiene i link a
tutte le mosse in essa contenuta

--]]

local makeMachinesList = function(list)
	return table.concat(table.map(list, function(move, num)
			num = string.format('%02d', num)
			if type(move) == 'table' then
				return string.interp('${num} (${games})',
					{
						num = num,
						games = table.concat(table.map(move, function(movegame)
								return links[movegame[1]:upper() .. 'Lua'](
										moves[movegame[2]].name, '', true)
							end), ' | ')
					})
			else
				return string.interp("[[${mv} (mossa)|${num}]]",
					{
						mv = moves[move].name,
						num = num
					})
			end
		end), " | ")
end

--[[

Ritorna un div che contente le MT e MN
di una certa generazione.
width è opzionale, default 65%

--]]

local MTGen = function(gen, width)	
	return string.interp([=[
<div class="roundy text-center pull-center" style="${bg} width: ${wd}; padding: 0.5ex; margin-bottom: 0.5ex;">
<div style="font-size: 90%; margin-bottom: 2px; font-weight: bold;">[[MT|<span style="color: #000;">MT</span>]] di [[${gen} generazione|<span style="color: #000;">${gen} generazione</span>]]</div>
<div ${roundy}style="background: #eaeaea; font-size: 90%; margin-bottom: 2px; padding: 0px 2px;">${listmt}</div>${listmn}
</div>]=],
	{
		bg = css.horizGradLua{gens[gen].region, 'normale', gens[gen].region, 'light'},
		wd = width or "65%",
		gen = gens[gen].ext,
		roundy = machines[gen].MN and '' or 'class="roundybottom" ',
		listmt = makeMachinesList(machines[gen].MT),
		listmn = machines[gen].MN and string.interp([=[
<div style="font-size: 90%; margin-bottom: 2px; font-weight: bold;">[[MN|<span style="color: #000;">MN</span>]] di [[${gen} generazione|<span style="color: #000;">${gen} generazione</span>]]</div>
<div class="roundybottom" style="background: #eaeaea; font-size: 88%; padding: 0px 2px;">${mnlist}</div>]=],
			{
				mnlist = makeMachinesList(machines[gen].MN),
				gen = gens[gen].ext,
			}) or ''
	})
end


--[[

Come il template MT compatto:
Prende in input il nome della pagina e restituisce la
tabella contenente le sottotabelle delle generazioni
in cui la mossa è un'MT o MN

--]]

m.MTCompatto = function(frame)
	local params = w.trimAndMap(frame.args, string.lower)
	local gens, color = {}, 'sconosciuto'
	local move = params[1]:match('^(.+) %(mossa%)$') or params[1]
	local moveData = moves[move]

	if not moveData then
		move = mw.text.decode(move)
		moveData = moves[move]
	end
	
	if moveData then
		color = moveData.type
		for gen, genMc in ipairs(machines) do
			if table.deepSearch(genMc, move) then
				table.insert(gens, MTGen(gen, "auto"))
			end
		end
	else
		color = params.tipo or 'pcwiki'
		gens = mw.text.split(params[1], '', true)
		table.sort(gens)
		gens = table.map(gens, function(gen)
				return MTGen(tonumber(gen), "auto")
			end)
	end
	
	return string.interp([=[
<div class="roundy pull-center text-center mw-collapsible${collapsed} width-xl-55 width-md-75 width-sm-100" style="${bg} padding: 0.5ex; padding-bottom: 0.01ex;">
<div class="roundy text-center" style="color: #000; font-weight: bold; margin-bottom: 0.5ex;">[[MT|<span style="color: #000;">MT</span>]] nelle varie generazioni</div>
<div class="mw-collapsible-content">${mtGens}
</div></div>
[[Categoria:Mosse Macchina]]]=],
	{
		bg = css.horizGradLua{color, 'light', color, 'normale'},
		collapsed = #gens > 1 and " mw-collapsed" or "",
		mtGens = table.concat(gens)
	})
end

m.MTGen = function(frame)
	local params = w.trimAll(frame.args)
	return MTGen(tonumber(params[1]), params.width) ..
			"[[Categoria:Mosse Macchina]]"
end
arg={'MTCompatto', 'Surf'}
print(m[arg[1]]{ args={arg[2], width = arg[3]} })

return m
