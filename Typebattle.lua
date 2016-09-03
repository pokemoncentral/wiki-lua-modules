-- Il vecchio template typebattle: visualizza le tabelle
-- di efficacia tipo per il tipo in questione

local tb = {}

local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local b = require('Boxtipo')
local c = require("Colore-data")

-- Le tabelle seguenti contengono i tipi che cambiano rapporti con gli altri DOPO
-- la prima e la quinta rispettivamente

local gen1 = {'coleottero', 'fuoco', 'ghiaccio', 'psico', 'spettro', 'veleno'}
local gen5 = {'acciaio', 'buio', 'spettro'}

local eff = function(tipo, gen)
	local et = require('EffTipi' .. (gen < 6 and gen or ''))
	local values, test, f = {0, 0.5, 2}, {}, {bg = c[tipo].dark, bd = c[tipo].light, cells = c[tipo].normale}
	for k, v in pairs(values) do
        test = {false}
        test = et.difesa(v, tipo, tipo, 'Tanfo')
        f['dx' .. v] = test[1] and b.box_list(test, 'center') or 'Nessuna'
        test = {false}
        test = et.attacco(v, tipo)
        f['ax' .. v] = test[1] and b.box_list(test, 'center') or 'Nessuna'
    end
	return string.interp([=[{| class="roundy" style="background: #${bg}; border: 3px solid #${bd}; text-align: center;" 
! class="roundytop" style="background:#${bd}; font-size: 120%;" | Danno inflitto
! class="roundytop" style="background:#${bd}; font-size: 120%;" | Danno subito
|-
! style="background: #${cells};" | <span class="explain" title="2x">Superefficace</span>
! style="background: #${cells};" | <span class="explain" title="2x">Superefficace</span>
|-
| style="background: #FFF;" | 
{| style="margin:auto;"
| ${ax2}
|}
| style="background: #FFF;" |
{| style="margin:auto;"
| ${dx2}
|}
|-
! style="background: #${cells};" | <span class="explain" title="½x">Non molto efficace</span>
! style="background: #${cells};" | <span class="explain" title="½x">Non molto efficace</span>
|-
| style="background: #FFF;" |
{| style="margin:auto;"
| ${ax0.5}
|}
| style="background: #FFF;" |
{| style="margin:auto;"
| ${dx0.5}
|}
|-
! style="background: #${cells};" | <span class="explain" title="0x">Non ha effetto</span>
! style="background: #${cells};" | <span class="explain" title="0x">Non ha effetto</span>
|-
| class="roundybottom" style="background: #FFF;" |
{| style="margin:auto;"
| ${ax0}
|}
| class="roundybottom" style="background: #FFF;" |
{| style="margin:auto;"
| ${dx0}
|}
|}]=], f)	
end	
	
tb.typebattle = function(frame)
	local tipo = (string.trim(frame.args[1]) or 'sconosciuto (tipo)'):match('(%a+) %(tipo%)'):lower()
	local notes = [=[

<span style="font-size: 90%">'''Note''':
*Per la prima generazione, ignorare la presenza di eventuali tipi Buio e Acciaio.
*Per le generazioni precedenti alla sesta, ignorare la presenza di un eventuale tipo Folletto.</span>]=]
	if not table.search(gen1, tipo) and not table.search(gen5, tipo) then
		return eff(tipo, 6) .. notes
	end
	local str = {'{|'}
	if table.search(gen1, tipo) then
		table.insert(str, '===Nella prima generazione===\n' .. eff(tipo, 1))
	end
	if table.search(gen5, tipo) then
		table.insert(str, table.concat{'===Dalla seconda alla quinta generazione===\n', eff(tipo, 5),
			'===Dalla sesta generazione in poi===\n', eff(tipo, 6), '\n|}'})
		return table.concat(str, '\n| style="vertical-align: top" |\n') .. notes
	else
		table.insert(str, table.concat{'===Dalla seconda generazione in poi===\n', eff(tipo, 6), '\n|}'})
		return table.concat(str, '\n| style="vertical-align: top" |\n') .. notes
	end
end

tb.foo = tb.typebattle

return tb

