-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative non sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused

local mw = require('mw')

--[[

Creates the link for an alternative form. There are two general
kinds of link: those pointing to the specific subpage of the Pokémon,
and those pointing to general pages (eg: "Forma di Alola").
This function handles boths, depending on the arguments.
This function also handles empty form name, yielding no link at all
(an empty string).

Arguments:
	- black: a boolean value. If true returns black links, otherwise normal
	- formName: name of the specific form
	- poke: base name of the Pokémon
	- general: an optional string argument. If given, the function assumes
			the link target should be the general page whose title is given by
			the value of this parameter (eg: for a Megaevoluzione, this
			parameter should be "Megaevoluzione")

--]]
local function makeSingleLink(black, formName, poke, general)
	if formName == "" then
		return ""
	end

	local target
	if general then
		target = table.concat{general, "#", t[poke].anchor or string.fu(poke)}
	else
		target = table.concat{string.fu(poke), "/Forme"}
	end
	return string.interp('<div class="small-text${black}">[[${target}|${formName}]]</div>', {
		black = black and " black-text" or "",
		formName = formName,
		target = target
	})
end

--[[

Adds links to alternative forms pointing to a generic page instead of
the specific subpage of the Pokémon. This function modifies links only
for a given list of abbrs, and doesn't change other links.
Arguments:
	- black: a boolean value. Is true adds blacklinks, otherwise normal
	- target: the target page name
	- list: a list of keys to which add the links for this target
	- abbrs: the list of abbrs to modify

--]]
local function makeTargetedLink(black, target, list, abbrs)
	local index = black and 'blacklinks' or 'links'

	for _, name in pairs(list) do
		t[name][index] = table.map(t[name].names, function(formName, formAbbr)
			if table.search(abbrs, formAbbr) then
				return makeSingleLink(black, formName, name, target)
			else
				return t[name][index] and t[name][index][formAbbr]
			end
		end)
	end
end

-- Creates links to alternative forms
local function makeLinks(black)
	local index = black and 'blacklinks' or 'links'

	-- Removing support tables since we don't want to operate on them
	local stdLinks = table.filter(t, function(_, key)
		return not table.search({'mega', 'megaxy', 'archeo', 'alola', 'galar',
		                         'gigamax'}, key)
	end)

	-- Adds standard links
	for name, poke in pairs(stdLinks) do
		poke[index] = table.map(poke.names, function(formName)
			return makeSingleLink(black, formName, name)
			-- return formName == ''
			-- 	   and ''
			-- 	   or string.interp(link, {
			-- 		anchor = poke.anchor or string.fu(name),
			-- 		formName = formName
			-- })
		end)
	end

	-- Adds links of forms with a dedicated page
	makeTargetedLink(black, 'Megaevoluzione', table.merge(t.mega, t.megaxy), {"base", "M", "MX", "MY"})
	makeTargetedLink(black, 'Archeorisveglio', t.archeo, {"base", "A"})
	makeTargetedLink(black, 'Forma di Alola', t.alola, {"base", "A"})
	makeTargetedLink(black, 'Forma di Galar', t.galar, {"base", "G"})
	makeTargetedLink(black, 'Gigamax', t.gigamax, {"base", "Gi"})
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = {}
t.eevee = {}
t.castform = {}
t.deoxys = {}
t.wormadam = {}
t.rotom = {}
t.giratina = {}
t.shaymin = {}
t.arceus = {}
t.basculin = {}
t.darmanitan = {}
t.tornadus = {}
t.kyurem = {}
t.meloetta = {}
t.greninja = {}
t.meowstic = {}
t.aegislash = {}
t.pumpkaboo = {}
t.zygarde = {}
t.hoopa = {}
t.lycanroc = {}
t.oricorio = {}
t.wishiwashi = {}
t.silvally = {}
t.minior = {}
t.necrozma = {}
t.toxtricity = {}
t.alcremie = {}
t.eiscue = {}
t.indeedee = {}
t.morpeko = {}
t.zacian = {}
t.zamazenta = {}
t.eternatus = {}
t.urshifu = {}

-- Generazione dinamica delle megaevoluzioni e archeorisveglio

-- Tabella con i Pokémon che hanno una sola megaevoluzione

t.mega = {'venusaur', 'blastoise', 'beedrill', 'pidgeot', 'alakazam',
	'gengar', 'slowbro', 'kangaskhan', 'pinsir', 'gyarados', 'aerodactyl',
	'ampharos', 'steelix', 'scizor', 'heracross', 'houndoom', 'tyranitar',
	'sceptile', 'blaziken', 'swampert', 'gardevoir', 'sableye', 'mawile',
	'aggron', 'medicham', 'manectric', 'sharpedo', 'camerupt', 'altaria',
	'banette', 'absol', 'glalie', 'salamence', 'metagross', 'latias', 'latios',
	'rayquaza', 'lopunny', 'garchomp', 'lucario', 'abomasnow', 'gallade',
	'audino', 'diancie'}

-- Tabella contentente i Pokémon che hanno più megaevoluzioni

t.megaxy = {'charizard', 'mewtwo'}

-- Tabella contenente i Pokémon che hanno una archeorisveglio

t.archeo = {'kyogre', 'groudon'}

-- Tabella contenente i Pokémon che hanno una forma di Alola:
-- per efficienza, alcuni sono alla fine del modulo

t.alola = {'rattata', 'raichu', 'sandshrew', 'vulpix', 'diglett', 'meowth',
	'persian', 'geodude', 'grimer', 'exeggutor', 'marowak'}

-- Tabella contenente i Pokémon che hanno una forma di Galar:
-- per efficienza, alcuni sono alla fine del modulo

t.galar = {'meowth', 'ponyta', 'slowpoke', 'slowbro', "farfetch'd", 'weezing',
	'mr. mime', 'articuno', 'zapdos', 'moltres', 'slowking', 'corsola',
	'zigzagoon', 'darumaka', 'yamask', 'stunfisk'}

-- Table with Pokémon with a Gigamax

t.gigamax = {'venusaur', 'charizard', 'blastoise', 'butterfree', 'meowth',
	'machamp', 'gengar', 'kingler', 'lapras', 'eevee', 'snorlax', 'garbodor',
	'melmetal', 'rillaboom', 'cinderace', 'inteleon', 'corviknight', 'orbeetle',
	'drednaw', 'coalossal', 'flapple', 'appletun', 'sandaconda', 'centiskorch',
	'hatterene', 'grimmsnarl', 'alcremie', 'copperajah', 'duraludon'}


--[[

Alternative forms names. Keys are the abbr.

--]]

t.pikachu.names = {Cs = 'Pikachu Cosplay', R = 'Pikachu rockstar',
	D = 'Pikachu damigella', Cn = 'Pikachu confetto',
	S = 'Pikachu scienziata', W = 'Pikachu wrestler', Cm = 'Compagno',
	Gi = 'Pikachu Gigamax', base = ''}
t.eevee.names = {Cm = 'Compagno', base = ''}
t.castform.names = {S = 'Forma Sole', P = 'Forma Pioggia',
	N = 'Forma Nuvola di Neve', base = 'Forma Castform'}
t.deoxys.names = {A = 'Forma Attacco', D = 'Forma Difesa',
	V = 'Forma Velocità', base = 'Forma Normale'}
t.wormadam.names = {Sa = 'Manto Sabbia', Sc = 'Manto Scarti',
	base = 'Manto Pianta'}
t.rotom.names = {C = 'Rotom Calore', L = 'Rotom Lavaggio', G = 'Rotom Gelo',
	V = 'Rotom Vortice', T = 'Rotom Taglio', base = 'Forma Rotom'}
t.giratina.names = {O = 'Forma Originale', base = 'Forma Alterata'}
t.shaymin.names = {C = 'Forma Cielo', base = 'Forma Terra'}
t.arceus.names = {base = 'Normale', L = 'Lotta', Vo = 'Volante', Ve = 'Veleno',
	T = 'Terra', R = 'Roccia', Aq = 'Acqua', C = 'Coleottero', Er = 'Erba',
	P = 'Psico', B = 'Buio', S = 'Spettro', Ai = 'Acciaio', Fu = 'Fuoco',
	D = 'Drago', Fo = 'Folletto', El = 'Elettro', G = 'Ghiaccio',
	Sc = 'Sconosciuto'}
t.basculin.names = {B = 'Forma Lineablu', base = 'Forma Linearossa'}
t.darmanitan.names = {Z = 'Stato Zen', G = 'Forma di Galar',
	GZ = "Stato Zen (Galar)", base = 'Stato Normale'}
t.tornadus.names = {T = 'Forma Totem', base = 'Forma Incarnazione'}
t.kyurem.names = {N = 'Kyurem Nero', B = 'Kyurem Bianco', base = 'Forma di Kyurem'}
t.meloetta.names = {D = 'Forma Danza', base = 'Forma Canto'}
t.greninja.names = {A = 'Forma Ash', base = ''}
t.meowstic.names = {F = 'Femmina', base = 'Maschio'}
t.aegislash.names = {S = 'Forma Spada', base = 'Forma Scudo'}
t.pumpkaboo.names = {S = 'Mini', L = 'Grande', XL = 'Maxi', base = 'Normale'}
t.zygarde.names = {D = 'Forma 10%', P = 'Forma Perfetta', base = 'Forma 50%'}
t.hoopa.names = {L = 'Libero', base = 'Vincolato'}
t.oricorio.names = {C = 'Stile Cheerdance', H = 'Stile Hula', B = 'Stile Buyō',
	base = 'Stile Flamenco'}
t.lycanroc.names = {N = 'Forma Notte', C = 'Forma Crepuscolo', base = 'Forma Giorno'}
t.wishiwashi.names = {B = 'Forma Banco', base = 'Forma Individuale'}
t.silvally.names = {base = 'Tipo Normale', L = 'Tipo Lotta', Vo = 'Tipo Volante',
	Ve = 'Tipo Veleno', T = 'Tipo Terra', R = 'Tipo Roccia', Aq = 'Tipo Acqua',
	C = 'Tipo Coleottero', Er = 'Tipo Erba', P = 'Tipo Psico', B = 'Tipo Buio',
	S = 'Tipo Spettro', Ai = 'Tipo Acciaio', Fu = 'Tipo Fuoco',
	D = 'Tipo Drago', Fo = 'Tipo Folletto', El = 'Tipo Elettro',
	G = 'Tipo Ghiaccio'}
t.minior.names = {R = 'Forma Nucleo', base = 'Forma Meteora'}
t.necrozma.names = {V = 'Necrozma Criniera del Vespro', A = "Necrozma Ali dell'Aurora",
	U = 'UltraNecrozma', base = ''}
t.toxtricity.names = {B = 'Forma Basso', Gi = "Toxtricity Gigamax", base = 'Forma Melodia'}
t.alcremie.names = {base = ""}
t.eiscue.names = {L = "Liquefaccia", base = "Gelofaccia"}
t.indeedee.names = t.meowstic.names
t.morpeko.names = {V = 'Motivo Panciavuota', base = 'Motivo Panciapiena'}
t.zacian.names = {R = 'Re delle Spade', base = 'Eroe di Mille Lotte'}
t.zamazenta.names = {R = 'Re degli Scudi', base = 'Eroe di Mille Lotte'}
t.eternatus.names = {D = 'Dynamax Infinito', base = ''}
t.urshifu.names = {P = 'Stile Pluricolpo', Gi = 'Urshifu Gigamax (Stile Singolcolpo)',
	PGi = 'Urshifu Gigamax (Stile Pluricolpo)', base = 'Stile Singolcolpo'}
for _, v in pairs(t.mega) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	t[v].names.M = 'Mega' .. string.fu(v)
end
for _, v in pairs(t.megaxy) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	local fu = string.fu(v)
	t[v].names.MX = table.concat{'Mega', fu, ' X'}
	t[v].names.MY = table.concat{'Mega', fu, ' Y'}
end
for _, v in pairs(t.archeo) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	t[v].names.A = 'Archeorisveglio'
end
for _, v in pairs(t.alola) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	t[v].names.A = 'Forma di Alola'
end
for _, v in pairs(t.galar) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	t[v].names.G = 'Forma di Galar'
end
for _, v in pairs(t.gigamax) do
	if not t[v] then
		t[v] = { names = {base = ''} }
	end
	t[v].names.Gi = string.fu(v) .. " Gigamax"
end

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.rattata.anchor = 'Rattata e Raticate'
t.sandshrew.anchor = 'Sandshrew e Sandslash'
t.vulpix.anchor = 'Vulpix e Ninetales'
t.diglett.anchor = 'Diglett e Dugtrio'
t.persian.anchor = 'Meowth e Persian'
t.geodude.anchor = 'Geodude, Graveler e Golem'
t.ponyta.anchor = 'Ponyta e Rapidash'
t.grimer.anchor = 'Grimer e Muk'
t.zigzagoon.anchor = 'Zigzagoon e Linoone'
-- t.wormadam.anchor = 'Burmy e Wormadam'
-- t.tornadus.anchor = 'Forze della Natura'
-- t.pumpkaboo.anchor = 'Pumpkaboo e Gourgeist'


-- Table to map extended names to abbrs

t.pikachu.ext = {cosplay = 'Cs', rockstar = 'R', damigella = 'D',
	confetto = 'Cn', scienziata = 'S', wrestler = 'W', compagno = 'Cm',
	gigamax = 'Gi'}
t.eevee.ext = {compagno = 'Cm'}
t.castform.ext = {sole = 'S', pioggia = 'P', neve = 'N'}
t.deoxys.ext = {attacco = 'A', difesa = 'D', ['velocità'] = 'V'}
t.wormadam.ext = {sabbia = 'Sa', scarti = 'Sc'}
t.rotom.ext = {calore = 'C', lavaggio = 'L', gelo = 'G', vortice = 'V',
	taglio = 'T'}
t.giratina.ext = {originale = 'O', origine = 'O'}
t.shaymin.ext = {cielo = 'C'}
    t.arceus.ext = {lotta = 'L', volante = 'Vo', veleno = 'Ve', terra = 'T',
	roccia = 'R', acqua = 'Aq', coleottero = 'C', erba = 'Er', psico = 'P',
	buio = 'B', spettro = 'S', acciaio = 'Ai', fuoco = 'Fu', drago = 'D',
	folletto = 'Fo', elettro = 'El', ghiaccio = 'G', coleot = 'C',
    sconosciuto = 'Sc'}
t.basculin.ext = {lineablu = 'B'}
t.darmanitan.ext = {zen = 'Z', galar = 'G', ["galar zen"] = 'GZ'}
t.tornadus.ext = {totem = 'T'}
t.kyurem.ext = {nero = 'N', bianco = 'B'}
t.meloetta.ext = {danza = 'D'}
t.greninja.ext = {ash = 'A'}
t.meowstic.ext = {femmina = 'F'}
t.aegislash.ext = {spada = 'S'}
t.pumpkaboo.ext = {mini = 'S', grande = 'L', maxi = 'XL'}
t.zygarde.ext = {dieci = 'D', perfetto = 'P'}
t.hoopa.ext = {libero = 'L'}
t.lycanroc.ext = {notte = 'N', crepuscolo = 'C', giorno = 'base'}
t.oricorio.ext = {cheerdance = 'C', hula = 'H', buyo = 'B',
	flamenco = 'base'}
t.wishiwashi.ext = {banco = 'B', individuale = 'base'}
t.silvally.ext = mw.clone(t.arceus.ext)
t.silvally.ext.sconosciuto = nil
t.minior.ext = {nucleo = 'R', meteora = 'base'}
t.necrozma.ext = {vespro = 'V', aurora = 'A', ultra = 'U', necrozma = 'base'}
t.toxtricity.ext = {basso = 'B', gigamax = 'Gi', melodia = 'base'}
t.alcremie.ext = {lattevaniglia = 'base'}
t.eiscue.ext = {liquefaccia = 'L', gelofaccia = 'base'}
t.indeedee.ext = t.meowstic.ext
t.morpeko.ext = {panciavuota = 'V', panciapiena = 'base'}
t.zacian.ext = {eroe = 'base', re = 'R'}
t.zamazenta.ext = t.zacian.ext
t.eternatus.ext = {dynamax = 'D'}
t.urshifu.ext = {pluricolpo = 'P', gigamax = "Gi", singolcolpo = 'base'}
for _, v in pairs(t.mega) do
	t[v].ext = t[v].ext or {}
	t[v].ext.mega = 'M'
end
for _, v in pairs(t.megaxy) do
	t[v].ext = t[v].ext or {}
	t[v].ext.megax = 'MX'
	t[v].ext.megay = 'MY'
end
for _, v in pairs(t.archeo) do
	t[v].ext = t[v].ext or {}
	t[v].ext.archeo = 'A'
end
for _, v in pairs(t.alola) do
	t[v].ext = t[v].ext or {}
	t[v].ext.alola = 'A'
end
for _, v in pairs(t.galar) do
	t[v].ext = t[v].ext or {}
	t[v].ext.galar = 'G'
end
for _, v in pairs(t.gigamax) do
	t[v].ext = t[v].ext or {}
	t[v].ext.gigamax = "Gi"
end

--[[

Arrays keeping the order in which alternative forms are listed in the latest
game.

--]]

t.venusaur.gamesOrder = {'base', 'M', 'Gi'}
t.charizard.gamesOrder = {'base', 'MX', 'MY', 'Gi'}
t.blastoise.gamesOrder = {'base', 'M', 'Gi'}
t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W', 'Cm', 'Gi'}
t.meowth.gamesOrder = {'base', 'A', 'G', 'Gi'}
t.gengar.gamesOrder = {'base', 'M', 'Gi'}
t.slowbro.gamesOrder = {'base', 'M', 'G'}
t.eevee.gamesOrder = {'base', 'Cm', 'Gi'}
t.castform.gamesOrder = {'base', 'S', 'P', 'N'}
t.deoxys.gamesOrder = {'base', 'A', 'D', 'V'}
t.wormadam.gamesOrder = {'base', 'Sa', 'Sc'}
t.rotom.gamesOrder = {'base', 'C', 'L', 'G', 'V', 'T'}
t.giratina.gamesOrder = {'base', 'O'}
t.shaymin.gamesOrder = {'base', 'C'}
t.arceus.gamesOrder = {'base', 'L', 'Vo', 'Ve', 'T', 'R', 'C', 'S', 'Ai', 'Fu',
	'Aq', 'Er', 'El', 'P', 'G', 'D', 'B', 'Fo', 'Sc'}
t.basculin.gamesOrder = {'base', 'B'}
t.darmanitan.gamesOrder = {'base', 'Z', 'G', 'GZ'}
t.tornadus.gamesOrder = {'base', 'T'}
t.kyurem.gamesOrder = {'base', 'B', 'N'}
t.meloetta.gamesOrder = {'base', 'D'}
t.greninja.gamesOrder = {'base', 'A'}
t.meowstic.gamesOrder = {'base', 'F'}
t.aegislash.gamesOrder = {'base', 'S'}
t.pumpkaboo.gamesOrder = {'base', 'S', 'L', 'XL'}
t.zygarde.gamesOrder = {'D', 'base', 'P'}
t.hoopa.gamesOrder = {'base', 'L'}
t.lycanroc.gamesOrder = {'base', 'N', 'C'}
t.oricorio.gamesOrder = {'base', 'C', 'H', 'B'}
t.wishiwashi.gamesOrder = {'base', 'B'}
t.silvally.gamesOrder = mw.clone(t.arceus.gamesOrder)
t.minior.gamesOrder = {'base', 'R'}
t.necrozma.gamesOrder = {'base', 'V', 'A', 'U'}
t.toxtricity.gamesOrder = {'base', 'B', 'Gi'}
t.eiscue.gamesOrder = {'base', 'L'}
t.indeedee.gamesOrder = t.meowstic.gamesOrder
t.morpeko.gamesOrder = {'base', 'V'}
t.zacian.gamesOrder = {'base', 'R'}
t.zamazenta.gamesOrder = t.zacian.gamesOrder
t.eternatus.gamesOrder = {'base', 'D'}
t.urshifu.gamesOrder = {'base', 'Gi', 'P', 'PGi'}
table.remove(t.silvally.gamesOrder)
for _, v in pairs(t.mega) do
	t[v].gamesOrder = t[v].gamesOrder or {'base', 'M'}
end
for _, v in pairs(t.megaxy) do
	t[v].gamesOrder = t[v].gamesOrder or {'base', 'MX', 'MY'}
end
for _, v in pairs(t.archeo) do
	t[v].gamesOrder = t[v].gamesOrder or {'base', 'A'}
end
for _, v in pairs(t.alola) do
	t[v].gamesOrder = t[v].gamesOrder or {'base', 'A'}
end
for _, v in pairs(t.galar) do
	t[v].gamesOrder = t[v].gamesOrder or {'base', 'G'}
end
for _, v in pairs(t.gigamax) do
	t[v].gamesOrder = t[v].gamesOrder or {"base", "Gi"}
end

--[[

Pokémon with different cries between forms.
This array is guaranteed to be a sorted subset of gamesOrder (same sorting)

--]]

for _, v in pairs(t.mega) do
	t[v].cries = {'M'}
end
for _, v in pairs(t.megaxy) do
	t[v].cries = {'MX', 'MY'}
end
for _, v in pairs(t.archeo) do
	t[v].cries = {'A'}
end
t.slowbro.cries = {'M'}
t.shaymin.cries = {'C'}
t.tornadus.cries = {'T'}
t.kyurem.cries = {'B', 'N'}
t.pumpkaboo.cries = {'XL'}
t.zygarde.cries = {'D', 'P'}
t.hoopa.cries = {'L'}
t.oricorio.cries = {'C', 'H', 'B'}
t.lycanroc.cries = {'N', 'C'}
t.wishiwashi.cries = {'B'}
t.necrozma.cries = {'V', 'A', 'U'}

--[[

Oldest game in which each form, included base form, appears.

--]]

t.rattata.since = {A = 'sl', base = 'rb'}
t.pikachu.since = {Cs = 'roza', R = 'roza', D = 'roza',
	Cn = 'roza', S = 'roza', W = 'roza', Cm = 'lgpe',
	Gi = 'spsc', base = 'rb'}
t.raichu.since = {A = 'sl', base = 'rb'}
t.sandshrew.since = {A = 'sl', base = 'rb'}
t.vulpix.since = {A = 'sl', base = 'rb'}
t.diglett.since = {A = 'sl', base = 'rb'}
t.meowth.since = {A = 'sl', G = 'spsc', Gi = 'spsc', base = 'rb'}
t.persian.since = {A = 'sl', base = 'rb'}
t.geodude.since = {A = 'sl', base = 'rb'}
t.ponyta.since = {G = 'spsc', base = 'rb'}
t.slowpoke.since = {G = 'spsc', base = 'rb'}
t.slowbro.since = {M = 'roza', G = 'spsc', base = 'rb'}
t["farfetch'd"].since = {G = 'spsc', base = 'rb'}
t.grimer.since = {A = 'sl', base = 'rb'}
t.exeggutor.since = {A = 'sl', base = 'rb'}
t.marowak.since = {A = 'sl', base = 'rb'}
t.weezing.since = {G = 'spsc', base = 'rb'}
t['mr. mime'].since = {G = 'spsc', base = 'rb'}
t.eevee.since = {Cm = 'lgpe', Gi = 'spsc', base = 'rb'}
t.articuno.since = {G = 'spsc', base = 'rb'}
t.zapdos.since = {G = 'spsc', base = 'rb'}
t.moltres.since = {G = 'spsc', base = 'rb'}
t.slowking.since = {G = 'spsc', base = 'oa'}
t.corsola.since = {G = 'spsc', base = 'oa'}
t.zigzagoon.since = {G = 'spsc', base = 'rz'}
t.castform.since = {S = 'rz', P = 'rz', N = 'rz', base = 'rz'}
t.deoxys.since = {A = 'rfvf', D = 'rfvf', V = 's', base = 'rz'}
t.wormadam.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
t.rotom.since = {C = 'pt', L = 'pt', G = 'pt', V = 'pt', T = 'pt', base = 'dp'}
t.giratina.since = {O = 'pt', base = 'dp'}
t.shaymin.since = {C = 'pt', base = 'dp'}
t.arceus.since = {base = 'dp', L = 'dp', Vo = 'dp', Ve = 'dp', T = 'dp',
	R = 'dp', Aq = 'dp', C = 'dp', Er = 'dp', P = 'dp', B = 'dp', S = 'dp',
	Ai = 'dp', Fu = 'dp', D = 'dp', Fo = 'xy', El = 'dp', G = 'dp', Sc = 'dp'}
t.basculin.since = {B = 'nb', base = 'nb'}
t.darumaka.since = {G = 'spsc', base = 'nb'}
t.darmanitan.since = {Z = 'nb', G = 'spsc', GZ = 'spsc', base = 'nb'}
t.yamask.since = {G = 'spsc', base = 'rz'}
t.stunfisk.since = {G = 'spsc', base = 'nb'}
t.tornadus.since = {T = 'n2b2', base = 'nb'}
t.kyurem.since = {N = 'n2b2', B = 'n2b2', base = 'nb'}
t.meloetta.since = {D = 'nb', base = 'nb'}
t.greninja.since = {A = 'sl', base = 'xy'}
t.meowstic.since = {F = 'xy', base = 'xy'}
t.aegislash.since = {S = 'xy', base = 'xy'}
t.pumpkaboo.since = {S = 'xy', L = 'xy', XL = 'xy', base = 'xy'}
t.zygarde.since = {D = 'sl', P = 'sl', base = 'xy'}
t.hoopa.since = {L = 'roza', base = 'xy'}
t.lycanroc.since = {N = 'sl', base = 'sl', C = 'usul'}
t.oricorio.since = {C = 'sl', H = 'sl', B = 'sl', base = 'sl'}
t.wishiwashi.since = {B = 'sl', base = 'sl'}
t.silvally.since = {base = 'sl', L = 'sl', Vo = 'sl', Ve = 'sl', T = 'sl',
	R = 'sl', Aq = 'sl', C = 'sl', Er = 'sl', P = 'sl', B = 'sl', S = 'sl',
	Ai = 'sl', Fu = 'sl', D = 'sl', Fo = 'sl', El = 'sl', G = 'sl'}
t.minior.since = {base = 'sl', R = 'sl'}
t.necrozma.since = {base = 'sl', V = 'usul', A = 'usul', U = 'usul'}
t.toxtricity.since = {B = 'spsc', Gi = 'spsc', base = 'spsc'}
t.eiscue.since = {L = 'spsc', base = 'spsc'}
t.indeedee.since = {F = 'spsc', base = 'spsc'}
t.morpeko.since = {base = 'spsc', V = 'spsc'}
t.zacian.since = {R = 'spsc', base = 'spsc'}
t.zamazenta.since = {R = 'spsc', base = 'spsc'}
t.eternatus.since = {D = 'spsc', base = 'spsc'}
t.urshifu.since = {P = 'spsc', Gi = 'spsc', PGi = 'spsc', base = 'spsc'}
t.venusaur.since = {M = 'xy', Gi = 'spsc', base = 'rb'}
t.blastoise.since = {M = 'xy', Gi = 'spsc', base = 'rb'}
t.beedrill.since = {M = 'roza', base = 'rb'}
t.pidgeot.since = {M = 'roza', base = 'rb'}
t.alakazam.since = {M = 'xy', base = 'rb'}
t.gengar.since = {M = 'xy', Gi = 'spsc', base = 'rb'}
t.kangaskhan.since = {M = 'xy', base = 'rb'}
t.pinsir.since = {M = 'xy', base = 'rb'}
t.gyarados.since = {M = 'xy', base = 'rb'}
t.aerodactyl.since = {M = 'xy', base = 'rb'}
t.ampharos.since = {M = 'xy', base = 'oa'}
t.steelix.since = {M = 'roza', base = 'oa'}
t.scizor.since = {M = 'xy', base = 'oa'}
t.heracross.since = {M = 'xy', base = 'oa'}
t.houndoom.since = {M = 'xy', base = 'oa'}
t.tyranitar.since = {M = 'xy', base = 'oa'}
t.sceptile.since = {M = 'roza', base = 'rz'}
t.blaziken.since = {M = 'xy', base = 'rz'}
t.swampert.since = {M = 'roza', base = 'rz'}
t.gardevoir.since = {M = 'xy', base = 'rz'}
t.sableye.since = {M = 'roza', base = 'rz'}
t.mawile.since = {M = 'xy', base = 'rz'}
t.aggron.since = {M = 'xy', base = 'rz'}
t.medicham.since = {M = 'xy', base = 'rz'}
t.manectric.since = {M = 'xy', base = 'rz'}
t.banette.since = {M = 'xy', base = 'rz'}
t.sharpedo.since = {M = 'roza', base = 'rz'}
t.camerupt.since = {M = 'roza', base = 'rz'}
t.altaria.since = {M = 'roza', base = 'rz'}
t.absol.since = {M = 'xy', base = 'rz'}
t.glalie.since = {M = 'roza', base = 'rz'}
t.salamence.since = {M = 'roza', base = 'rz'}
t.metagross.since = {M = 'roza', base = 'rz'}
t.latias.since = {M = 'roza', base = 'rz'}
t.latios.since = {M = 'roza', base = 'rz'}
t.rayquaza.since = {M = 'roza', base = 'rz'}
t.lopunny.since = {M = 'roza', base = 'dp'}
t.garchomp.since = {M = 'xy', base = 'dp'}
t.lucario.since = {M = 'xy', base = 'dp'}
t.abomasnow.since = {M = 'xy', base = 'dp'}
t.gallade.since = {M = 'roza', base = 'rz'}
t.audino.since = {M = 'roza', base = 'nb'}
t.diancie.since = {M = 'roza', base = 'xy'}
t.charizard.since = {MX = 'xy', MY = 'xy', Gi = 'spsc', base = 'rb'}
t.mewtwo.since = {MX = 'xy', MY = 'xy', base = 'rb'}
t.groudon.since = {A = 'roza', base = 'rz'}
t.kyogre.since = {A = 'roza', base = 'rz'}
t.butterfree.since = {base = 'rb', Gi = 'spsc'}
t.machamp.since = {base = 'rb', Gi = 'spsc'}
t.kingler.since = {base = 'rb', Gi = 'spsc'}
t.lapras.since = {base = 'rb', Gi = 'spsc'}
t.snorlax.since = {base = 'rb', Gi = 'spsc'}
t.garbodor.since = {base = 'nb', Gi = 'spsc'}
t.melmetal.since = {base = 'lgpe', Gi = 'spsc'}
t.rillaboom.since = {base = 'spsc', Gi = 'spsc'}
t.cinderace.since = {base = 'spsc', Gi = 'spsc'}
t.inteleon.since = {base = 'spsc', Gi = 'spsc'}
t.corviknight.since = {base = 'spsc', Gi = 'spsc'}
t.orbeetle.since = {base = 'spsc', Gi = 'spsc'}
t.drednaw.since = {base = 'spsc', Gi = 'spsc'}
t.coalossal.since = {base = 'spsc', Gi = 'spsc'}
t.flapple.since = {base = 'spsc', Gi = 'spsc'}
t.appletun.since = {base = 'spsc', Gi = 'spsc'}
t.sandaconda.since = {base = 'spsc', Gi = 'spsc'}
t.centiskorch.since = {base = 'spsc', Gi = 'spsc'}
t.hatterene.since = {base = 'spsc', Gi = 'spsc'}
t.grimmsnarl.since = {base = 'spsc', Gi = 'spsc'}
t.alcremie.since = {base = 'spsc', Gi = 'spsc'}
t.copperajah.since = {base = 'spsc', Gi = 'spsc'}
t.duraludon.since = {base = 'spsc', Gi = 'spsc'}

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pikachu['until'] = {Cs = 'roza', R = 'roza', D = 'roza',
	Cn = 'roza', S = 'roza', W = 'roza', Cm = 'lgpe'}
t.eevee['until'] = {Cm = 'lgpe'}
t.arceus['until'] = {Sc = 'hgss'}

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti
-- Tables are copied since links should be changed
t.raticate = table.copy(t.rattata)
t.sandslash = table.copy(t.sandshrew)
t.ninetales = table.copy(t.vulpix)
t.dugtrio = table.copy(t.diglett)
t.graveler = table.copy(t.geodude)
t.golem = table.copy(t.geodude)
t.rapidash = table.copy(t.ponyta)
t.muk = table.copy(t.grimer)
t.linoone = table.copy(t.zigzagoon)
t.thundurus, t.landorus = table.copy(t.tornadus), table.copy(t.tornadus)
t.gourgeist = table.copy(t.pumpkaboo)

-- Adding missing Pokémon to set with a certain kind of forms. Added here
-- to avoid useless repetitions of cycles
-- Otehr Alola forms
table.insert(t.alola, 'raticate')
table.insert(t.alola, 'sandslash')
table.insert(t.alola, 'ninetales')
table.insert(t.alola, 'dugtrio')
table.insert(t.alola, 'meowth')
table.insert(t.alola, 'graveler')
table.insert(t.alola, 'golem')
table.insert(t.alola, 'muk')
-- Other Galar forms
table.insert(t.galar, 'rapidash')
table.insert(t.galar, 'linoone')
-- Other Gigamax forms
table.insert(t.gigamax, 'pikachu')
table.insert(t.gigamax, 'toxtricity')
table.insert(t.gigamax, 'urshifu')

-- Link creation should be done AFTER copying Pokémon with same forms, in order
-- to use the right name for the link
makeLinks()      -- normal links
makeLinks(true)  -- black links

t[19] = t.rattata
t[20] = t.raticate
t[25] = t.pikachu
t[26] = t.raichu
t[27] = t.sandshrew
t[28] = t.sandslash
t[37] = t.vulpix
t[38] = t.ninetales
t[50] = t.diglett
t[51] = t.dugtrio
t[52] = t.meowth
t[53] = t.persian
t[74] = t.geodude
t[75] = t.graveler
t[76] = t.golem
t[77] = t.ponyta
t[78] = t.rapidash
t[79] = t.slowpoke
t[80] = t.slowbro
t[83] = t["farfetch'd"]
t[88] = t.grimer
t[89] = t.muk
t[103] = t.exeggutor
t[105] = t.marowak
t[110] = t.weezing
t[122] = t['mr. mime']
t[133] = t.eevee
t[199] = t.slowking
t[222] = t.corsola
t[263] = t.zigzagoon
t[264] = t.linoone
t[351] = t.castform
t[386] = t.deoxys
t[413] = t.wormadam
t[479] = t.rotom
t[487] = t.giratina
t[492] = t.shaymin
t[493] = t.arceus
t[550] = t.basculin
t[554] = t.darumaka
t[555] = t.darmanitan
t[562] = t.yamask
t[618] = t.stunfisk
t[641] = t.tornadus
t[642] = t.thundurus
t[645] = t.landorus
t[646] = t.kyurem
t[648] = t.meloetta
t[658] = t.greninja
t[678] = t.meowstic
t[681] = t.aegislash
t[710] = t.pumpkaboo
t[711] = t.gourgeist
t[718] = t.zygarde
t[720] = t.hoopa
t[741] = t.oricorio
t[745] = t.lycanroc
t[746] = t.wishiwashi
t[773] = t.silvally
t[774] = t.minior
t[800] = t.necrozma
t[849] = t.toxtricity
t[869] = t.alcremie
t[875] = t.eiscue
t[876] = t.indeedee
t[877] = t.morpeko
t[888] = t.zacian
t[889] = t.zamazenta
t[890] = t.eternatus
t[892] = t.urshifu
t[3] = t.venusaur
t[9] = t.blastoise
t[15] = t.beedrill
t[18] = t.pidgeot
t[65] = t.alakazam
t[94] = t.gengar
t[115] = t.kangaskhan
t[127] = t.pinsir
t[130] = t.gyarados
t[142] = t.aerodactyl
t[181] = t.ampharos
t[208] = t.steelix
t[212] = t.scizor
t[214] = t.heracross
t[229] = t.houndoom
t[248] = t.tyranitar
t[254] = t.sceptile
t[257] = t.blaziken
t[260] = t.swampert
t[282] = t.gardevoir
t[302] = t.sableye
t[303] = t.mawile
t[306] = t.aggron
t[308] = t.medicham
t[310] = t.manectric
t[319] = t.sharpedo
t[323] = t.camerupt
t[334] = t.altaria
t[354] = t.banette
t[359] = t.absol
t[362] = t.glalie
t[373] = t.salamence
t[376] = t.metagross
t[380] = t.latias
t[381] = t.latios
t[384] = t.rayquaza
t[428] = t.lopunny
t[445] = t.garchomp
t[448] = t.lucario
t[460] = t.abomasnow
t[475] = t.gallade
t[531] = t.audino
t[719] = t.diancie
t[6] = t.charizard
t[150] = t.mewtwo
t[382] = t.kyogre
t[383] = t.groudon
t[12] = t.butterfree
t[68] = t.machamp
t[99] = t.kingler
t[131] = t.lapras
t[143] = t.snorlax
t[569] = t.garbodor
t[809] = t.melmetal
t[812] = t.rillaboom
t[815] = t.cinderace
t[818] = t.inteleon
t[823] = t.corviknight
t[826] = t.orbeetle
t[834] = t.drednaw
t[839] = t.coalossal
t[841] = t.flapple
t[842] = t.appletun
t[844] = t.sandaconda
t[849] = t.toxtricity
t[851] = t.centiskorch
t[858] = t.hatterene
t[861] = t.grimmsnarl
t[869] = t.alcremie
t[879] = t.copperajah
t[884] = t.duraludon

return t
