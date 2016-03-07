-- Modulo che, dato un tipo, restituisce l'elenco dei Pokémon
-- che lo hanno come primo tipo, secondo o unico

local g = {}

local ms = require('MiniSprite')
local r = require('Roundy')
local txt = require('Wikilib-strings')
local list = require('Wikilib-lists')
local form = require('Wikilib-forms')
local c = require('Colore-data')
local pokes = require('Poké-data')

-- Le condizioni che i tipi di un Pokémon devono rispettare per i tre tipi di entry:
-- 0 per il tipo singolo
-- 1 per il primo tipo
-- 2 per il secondo

local cond = {}
cond[0] = function(poke, tipo) return poke.type1 == poke.type2 and poke.type1 == tipo end
cond[1] = function(poke, tipo) return poke.type1 ~= poke.type2 and poke.type1 == tipo end
cond[2] = function(poke, tipo) return poke.type1 ~= poke.type2 and poke.type2 == tipo end

-- Le prime celle di ogni entry, essendo uguali, vengono create
-- con questa funzione

local firstcells = function(poke, name)
	return string.interp([=[|-
| style="background:#FFF; border:1px solid #D8D8D8;" | ${ndex}
| style="background:#FFF; border:1px solid #D8D8D8;" | ${ani}
| style="background:#FFF; border:1px solid #D8D8D8;" | [[${nome}]]${form}]=],
{
	ndex = string.three_figures(poke.ndex),
	ani = ms.aniLua(string.tf(poke.ndex) .. form.getabbr(name)),
	nome = poke.name,
	form = form.getlink(name)
})
end

-- Lo header: riceve il tipo e un numero tra 0, 1 e 2:
-- 0 indica i Pokémon monotipo
-- 1 indica Pokémon con il primo tipo uguale a quello dato
-- 2 indica Pokémon con il secondo tipo uguale a quello dato

local header = function(tipo, n)
	return string.interp([=[{| class="roundy sortable pull-center text-center" style="background: #${bg}; border: 3px solid #${bd};"
! [[Elenco Pokémon secondo il Pokédex Nazionale|<span style="color:#000">#<span>]]
! &nbsp;
! [[Pokémon|<span style="color:#000">Pokémon<span>]]
${tipi}]=],
{
	bg = c[tipo].normale,
	bd = c[tipo].dark,
	tipi = n == 0 and '! [[Tipo|<span style="color:#000">Tipo</span>]]\n'
		or [=[! [[Tipo|<span style="color:#000">Tipo 1</span>]]
! [[Tipo|<span style="color:#000">Tipo 2</span>]]
]=]
})
end

-- Crea il footer a partire da un entry

local footer = function(entry)
	entry = entry:gsub('^|%-\n| style="background:#FFF; border:1px solid #D8D8D8;"',
		table.concat{'|-\n| style="background:#FFF; border:1px solid #D8D8D8;',
		r.blLua('6px'), '"'})
	entry = entry:gsub([[| style="(.-)background:#(.+); border: 1px solid #(.+)" | (.+)$]],
		function(a, b, c, d) return string.interp([=[| style="${a}background:#${b}; border: 1px solid #${c}; ${rbr}" | ${d}
|}]=], {a = a, b = b, c = c, rbr = r.brLua('6px'), d = d}) end)
	return entry
end

-- I tre tipi di entry:
-- 0 per il tipo singolo
-- 1 per il primo tipo
-- 2 per il secondo

-- Si passano il nome del Pokémon con tanto di sigla per un'eventuale forma alternativa
-- e il tipo che si sta cercando, e ritorna l'entry corrispondente tramite interpolazione

local line = {}

line[0] = function(name, tipo)
	local poke = pokes[name]
	return string.interp([=[${cells}
| style="color:#FFF; background:#${std}; border: 1px solid #${dark};" | '''${t}''']=],
{
	cells = firstcells(poke, name),
	std = c[tipo].normale,
	dark = c[tipo].dark,
	t = tipo
})
end

line[1] = function(name, tipo)
	local poke = pokes[name]
	return string.interp([=[${cells}
| style="background:#${std}; border: 1px solid #${dark}; color:#FFF;" | '''${t}'''
| style="background:#${stda}; border: 1px solid #${darka}" | [[${ta} (tipo)|<span style="color: #FFF">${ta}</span>]]]=],
{
	cells = firstcells(poke, name),
	std = c[tipo].normale,
	dark = c[tipo].dark,
	t = tipo,
	stda = c[poke.type2].normale,
	darka = c[poke.type2].dark,
	ta = string.fu(poke.type2)
})
end

line[2] = function(name, tipo)
	local poke = pokes[name]
	return string.interp([=[${cells}
| style="background:#${stda}; border: 1px solid #${darka}" | [[${ta} (tipo)|<span style="color: #FFF">${ta}</span>]]
| style="color:#FFF; background:#${std}; border: 1px solid #${dark};" | '''${t}''']=],
{
	cells = firstcells(poke, name),
	stda = c[poke.type1].normale,
	darka = c[poke.type1].dark,
	ta = string.first_uppercase(poke.type1),
	std = c[tipo].normale,
	dark = c[tipo].dark,
	t = tipo
})
end

-- Genera tutti gli entries. Prende un tipo in minuscolo e un numero tra 0, 1 e 2:
-- 0 indica che si cercano i Pokémon monotipo
-- 1 indica che si cercano i Pokémon con il primo tipo uguale a quello dato
-- 1 indica che si cercano i Pokémon con il secondo tipo uguale a quello dato

-- Dopo aver cercato i Pokémon che rispettano la condizione 0, 1 o 2
-- se la condizione è la 0 inserisce anche arceus, poi riordina la tabella
-- e infine rende l'ultima entry il footer della tabella

local body = function(tipo, n)
	local entries = {}
	for name, poke in pairs(pokes) do
		if list.isName(name) and cond[n](poke, tipo) then
			table.insert(entries, line[n](name, string.fu(tipo)))
		end
	end
	if n == 0 and tipo ~= 'normale' then
		table.insert(entries, line[0]('arceus', string.fu(tipo)))
	end
	table.sort(entries, list.sortNdex(list.ndexAniMS, list.gamesOrder))
	table.insert(entries, footer(table.remove(entries)))
	return table.concat(entries, '\n')
end

-- Interfaccia: si passa il titolo della pagina, da cui viene estratto i tipo.
-- Si creano poi le intestazioni e si inseriscono a pettine tra le stesse gli elenchi Pokémon

g.typelist = function(frame)
	local tipo = string.trim(frame.args[1]):match('^(%a+) %(tipo%)$'):lower() or 'sconosciuto'
	local upper = string.fu(tipo)
	local second = tipo == 'coleottero' and 'coleot' or tipo
	local str = {table.concat{'===Pokémon di tipo ', upper,
		' puro==='}, table.concat{'===Pokémon di tipo ', upper,
		' parziale===\n====Pokémon di tipo ', upper, ' come tipo primario===='},
		table.concat{'====Pokémon di tipo ', upper,
		' come tipo secondario===='}}
	table.insert(str, 2, table.concat{header(tipo, 0), body(tipo, 0)})
	table.insert(str, 4, table.concat{header(tipo, 1), body(second, 1)})
	table.insert(str, table.concat{header(tipo, 2), body(second, 2)})
	return table.concat(str, '\n')
end

g.Typelist = g.typelist

--return g

print(g.typelist{args={arg[1]}})
