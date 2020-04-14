-- Da usarsi in ((Elenco Pokémon con abilità nascosta disponibile))

local m = {}
local txt = require('Modulo:Wikilib/strings')
local multigen = require('Modulo:Wikilib/multigen')
local gens = require('Modulo:Wikilib/gens')
local ms = require('Modulo:MiniSprite')
local sup = mw.loadData('Modulo:Sup/data')
local pokes = mw.loadData('Modulo:Poké/data')
local abils = mw.loadData('Modulo:PokéAbil/data')

-- accessoria (non esportata) per i link alle aree
local function splitareas(text,gen)
	local regions = {[5] = "Unima", [6] = "Kalos", [7] = "Alola"}
	local areas = {}
	for w in text:gmatch("[^,]+") do
		if w:find("Percorso") then
			table.insert(areas,table.concat{"[[",w," (",regions[gen],")|",w,"]]"})
		else table.insert(areas,table.concat{"[[",w,"]]"})
		end
	end
	return table.concat(areas,", ")
end

-- per alcune formattazioni speciali
local function specialtext(text)
	if text:find("%^") then
		text = text:gsub("%^(.-)%^",function(a) return sup[a] end)
	end
	if text:find("%*") then
		text = text:gsub("%*(.-)%*",function(a) return "<span class=\"explain tooltips\" title=\""..a.."\">*</span>" end)
	end
	return text
end

m.haentry = function(frame)
	local ndex = string.trim(frame.args.num)
	ndex = tonumber(ndex) or ndex
	local poke = pokes[ndex]
	local abil = abils[ndex]

	local final = {
		'|- class="flex-sm flex-row flex-wrap flex-main-center flex-items-center roundy" style="margin-top: 0.3em;"\n| style="padding: 0.5em;" |',
		string.tf(poke.ndex),
		'\n| style="padding: 0.5em;" |',
		ms.staticLua(type(ndex) == 'number' and string.tf(ndex) or ndex),
		'\n| style="padding: 0.5em;" |',
		"[[",
		poke.name,
		']]\n| class="width-sm-100" style="padding: 0.5em;" | <span class="visible-sm">Abilità speciale: </span>[[',
		multigen.getGenValue(abil.abilityd or abil.ability1),
		"]]"
	}

	if frame.args.gen5ha then
		table.insert(final, table.concat{'<span class="explain tooltips" title="', frame.args.gen5ha, ' nella quinta generazione">*</span>'})
	end
	if not abil.abilityd then
		table.insert(final, table.concat{'<span class="explain tooltips" title="Uguale all\'abilità normale">*</span>'})
	end
	table.insert(final, '\n| class="width-sm-100" style="padding: 0.5em;" |')

	-- QUINTA GENERAZIONE

	if gens.getGen.ndex(poke.ndex) <= 5 then

		local disp5 = {}

		-- Dream World

		if frame.args.dwarea then
			local dwarea = "[[Dream World]]: "..splitareas(frame.args.dwarea,5)
			if frame.args.dwversion then
				dwarea = dwarea .. sup[frame.args.dwversion]
			end
			table.insert(disp5,dwarea)
		end

		-- Meandri nascosti

		if frame.args.hh then
			local hh = "[[Meandri nascosti]]: "..splitareas(frame.args.hh,5)
			if frame.args.hhversion then
				hh = hh..sup[frame.args.hhversion]
			end
			table.insert(disp5,hh)
		end

		-- scambi di Sciroccopoli

		if frame.args.nimbasa then
			local nimbasa = "[[Sciroccopoli]] ([[Scambio]] con "
			if frame.args.nimbasa == "M" then --giocatore maschio
				nimbasa = nimbasa.."[[Lilì]]"
			elseif frame.args.nimbasa == "F" then --giocatrice femmina
				nimbasa = nimbasa.."[[Dadì]]"
			else nimbasa = nimbasa.."[[Lilì]] o [[Dadì]]" --entrambi
			end
			table.insert(disp5,nimbasa..")")
		end

		-- RAdar

		if frame.args.radar then
			local radar = "[[RAdar Pokémon]]"
			if frame.args.radar ~= "true" then
				radar = radar..sup[frame.args.radar]
			end
			table.insert(disp5,radar)
		end

		-- altri metodi

		if frame.args.gen5other then
			table.insert(disp5,specialtext(frame.args.gen5other))
		end

		-- caso base: non disponibile

		if #disp5==0 then
			disp5="''Non disponibile''"
			else disp5 = table.concat(disp5,"<br />")
		end

		table.insert(final, '<span class="visible-sm">Nella [[quinta generazione]]: </span>' .. disp5..'\n| class="width-sm-100" style="padding: 0.5em;" |')

	end

	-- SESTA GENERAZIONE
	if gens.getGen.ndex(poke.ndex) <= 6 then
		local disp6 = {}

		-- Orde

		if frame.args.horde then
			local horde = {"[[Gruppi di Pokémon]]: ",splitareas(frame.args.horde,6)}
			if frame.args.hordeversion then
				table.insert(horde,sup[frame.args.hordeversion])
			end
			table.insert(disp6,table.concat(horde))
		end

		-- Safari

		if frame.args.safari then
			local safari = {"[[Safari Amici]] ("}
			local slist = {}
			for w in frame.args.safari:gmatch("[^, ]+") do -- per i pochi che si trovano in più Safari
				table.insert(slist,table.concat{"[[Safari Amici#Safari di tipo ", w, "|", w, "]]"})
			end
			table.insert(safari,table.concat(slist,", "))
			table.insert(safari,")")
			if frame.args.safariforme then -- quando solo alcune forme si trovano nel safari
				table.insert(safari,' <span style="font-size:smaller;">(')
				table.insert(safari,frame.args.safariforme)
				table.insert(safari,')</span>')
			end
			table.insert(disp6,table.concat(safari))
		end

		-- altri metodi

		if frame.args.gen6other then
			table.insert(disp6,specialtext(frame.args.gen6other))
		end

		-- caso base: necessita trasferitore (non "non disponibile": se non è nè in quinta nè in sesta non deve apparire nella lista)

		if table.getn(disp6)==0 then
			disp6="[[Pokétrasferitore]]"
			else disp6 = table.concat(disp6,"<br />")
		end
		
		table.insert(final, '<span class="visible-sm">Nella [[sesta generazione]]: </span>'..disp6..'\n| class="width-sm-100" style="padding: 0.5em;" |')
	end

	if gens.getGen.ndex(poke.ndex) <= 7 then
		-- SETTIMA GENERAZIONE
		-- I don't really know if there may be some standard method, so I'll add
		-- just this
		local disp7 = {}

		-- other methods

		if frame.args.gen7other then
			table.insert(disp7, specialtext(frame.args.gen7other))
		end

		-- base case: Banca Pokémon (it's not "Not available" because it wouldn't
		-- have appeared in the list if it hadn't been available neither in sixth
		-- nor fifth gen)

		if table.getn(disp7)==0 then
			disp7="[[Banca Pokémon]]"
		else
			disp7 = table.concat(disp7,"<br />")
		end
		
		table.insert(final, '<span class="visible-sm">Nella [[settima generazione]]: </span>' .. disp7 .. "\n")
	end

	return table.concat(final)
end

return m
