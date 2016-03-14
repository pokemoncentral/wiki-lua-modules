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
local c = require('Colore-data')
local machines = require('Machines-data')
local gens = require('Gens-data')
local moves = require('Move-data')

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
<div class="roundy text-center pull-center" style="border: 3px solid #${colorDark}; background: #${colorNormal}; width: ${wd}; padding: 2px;">
	<div class="roundytop" style="background: #${colorLight}; font-size: 90%; margin-bottom: 2px; font-weight: bold;">[[MT]] di [[${gen} generazione]]</div>
	<div style="background: #eaeaea; font-size: 88%; margin-bottom: 2px; padding: 0px 2px;">${listmt}</div>
	<div style="background: #${colorLight}; font-size: 90%; margin-bottom: 2px; font-weight: bold;">[[MN]] di [[${gen} generazione]]</div>
	<div class="roundybottom" style="background: #eaeaea; font-size: 88%; padding: 0px 2px;">${listmn}</div>
</div>]=],
	{
		colorDark = c[gens[gen].region].dark,
		colorNormal = c[gens[gen].region].normale,
		colorLight = c[gens[gen].region].light,
		wd = width or "65%",
		gen = gens[gen].ext,
		listmt = makeMachinesList(machines[gen].MT),
		listmn = makeMachinesList(machines[gen].MN)
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
	local gens, color = {}, nil
	local move = params[1]:match('^(%a+) %(mossa%)$') or params[1]
	
	if moves[move] then
		color = c[moves[move].type]
		for gen, genMc in ipairs(machines) do
			if table.deepSearch(genMc, move) then
				table.insert(gens, MTGen(gen, "auto"))
			end
		end
	else
		color = c[params.tipo or "pcwiki"]
		gens = mw.text.split(params[1], '', true)
		table.sort(gens)
		gens = table.map(gens, function(gen)
				return MTGen(tonumber(gen), "auto")
			end)
	end
	
	return string.interp([=[
{| class="roundy pull-center text-center grid mw-collapsible ${collapsed}" style="border: 3px solid #${colorDark}; background: #${colorNormal}; width: ${wd};"
|-
! class="roundy text-center" style="color: #000; background: #${colorLight};" | [[MT|<span style="color: #000;">MT</span>]] nelle varie generazioni
|-
|${mtGens}
|}
[[Categoria:Mosse Macchina]]]=],
	{
		colorNormal = color.normale,
		colorDark = color.dark,
		colorLight = color.light,
		wd = "58%",
		collapsed = #gens > 1 and "mw-collapsed" or "",
		mtGens = table.concat(gens, '\n|-\n|')
	})
end

m.MTGen = function(frame)
	local params = w.trimAll(frame.args)
	return MTGen(tonumber(params[1]), params.width) ..
			"[[Categoria:Mosse Macchina]]"
end

print(m[arg[1]]{ args={arg[2], width = arg[3]} })

return m
