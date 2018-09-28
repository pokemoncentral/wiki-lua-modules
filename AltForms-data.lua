-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative non sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused

local mw = require('mw')

-- Crea i link alle forme alternative

local makeLinks = function(black)
	local link = black
			and '<div class="small-text">[[Differenze di forma#${anchor}|<span style="color:#000">${formName}</span>]]</div>'
			or '<div class="small-text">[[Differenze di forma#${anchor}|${formName}]]</div>'
	local index = black and 'blacklinks' or 'links'

	-- Si eliminano le table di supporto e i
	-- Pokémon che non hanno i link standard

	local stdLinks = table.filter(t, function(_, key)
		return
				not table.search({'mega', 'megaxy',
						'archeo', 'alola'}, key)
			and
				not table.search(t.mega, key)
			and
				not table.search(t.megaxy, key)
			and
				not table.search(t.archeo, key)
			and
				not table.search(t.alola, key)
	end)

	-- Links standard

	for name, poke in pairs(stdLinks) do
		poke[index] = table.map(poke.names, function(formName)
			return formName == ''
				   and ''
				   or string.interp(link, {
					anchor = poke.anchor or string.fu(name),
					formName = formName
			})
		end)
	end

	-- Link vuoti: mega, megaxy e archeo

	for _, poke in pairs(t.mega) do
		t[poke][index] = table.map(t[poke].names, function()
				return ''
		end)
	end
	for _, poke in pairs(t.megaxy) do
		t[poke][index] = table.map(t[poke].names, function()
				return ''
		end)
	end
	for _, poke in pairs(t.archeo) do
		t[poke][index] = table.map(t[poke].names, function()
				return ''
		end)
	end

	-- Link alle forme di alola, che puntano ad una
	-- pagina apposita e non "Differenze di forma"

	link = link:gsub('Differenze di forma', 'Forma di Alola')
	for _, poke in pairs(t.alola) do
		t[poke][index] = table.map(t[poke].names, function(formName)
			return formName == ''
				   and ''
				   or string.interp(link, {
					anchor = t[poke].anchor or string.fu(poke),
					formName = formName
			})
		end)
	end
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = {}
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

-- Generazione dinamica delle megaevoluzioni e archeorisveglio

-- Tabella con i Pokémon che hanno una sola megaevoluzione

t.mega = {'venusaur', 'blastoise', 'beedrill', 'pidgeot', 'alakazam',
	'slowbro', 'gengar', 'kangaskhan', 'pinsir', 'gyarados', 'aerodactyl',
	'ampharos', 'steelix', 'scizor', 'heracross', 'houndoom', 'tyranitar',
	'sceptile', 'blaziken', 'swampert', 'gardevoir', 'sableye', 'mawile',
	'aggron', 'medicham', 'manectric', 'sharpedo', 'camerupt', 'altaria',
	'banette', 'absol', 'glalie', 'salamence', 'metagross', 'latias',
	'latios', 'rayquaza', 'lopunny', 'garchomp', 'lucario', 'abomasnow',
	'gallade', 'audino', 'diancie'}

-- Tabella contentente i Pokémon che hanno più megaevoluzioni

t.megaxy = {'charizard', 'mewtwo'}

-- Tabella contenente i Pokémon che hanno una archeorisveglio

t.archeo = {'kyogre', 'groudon'}

-- Tabella contenente i Pokémon che hanno una forma di Alola:
-- per efficienza, alcuni sono alla fine del modulo

t.alola = {'rattata', 'raichu', 'sandshrew', 'vulpix', 'diglett', 'meowth',
	'geodude', 'grimer', 'exeggutor', 'marowak'}

--[[

Alternative forms names. Keys are the abbr.

--]]

t.pikachu.names = {Cs = 'Pikachu Cosplay', R = 'Pikachu Rockstar',
	D = 'Pikachu Damigella', Cn = 'Pikachu Confetto',
	S = 'Pikachu Scienziata', W = 'Pikachu Wrestler', base = ''}
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
t.darmanitan.names = {Z = 'Stato Zen', base = 'Stato Normale'}
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
t.necrozma.names = {V = 'Necrozma Criniera del Vespro', A = 'Necrozma Ali dell\'Aurora',
	U = 'UltraNecrozma', base = ''}
for k, v in pairs(t.mega) do
	local fu = string.fu(v)
	t[v] = {}
	t[v].names = {M = 'Mega' .. fu, base = fu}
end
for k, v in pairs(t.megaxy) do
	local fu = string.fu(v)
	t[v] = {}
	t[v].names = {MX = table.concat{'Mega', fu, ' X'},
		MY = table.concat{'Mega', fu, ' Y'}, base = fu}
end
for k, v in pairs(t.archeo) do
	local fu = string.fu(v)
	t[v] = {}
	t[v].names = {A = 'Archeo' .. fu, base = fu}
end
for k, v in pairs(t.alola) do
	t[v] = {}
	t[v].names = {A = 'Forma di Alola', base = ''}
end

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.rattata.anchor = 'Rattata e Raticate'
t.sandshrew.anchor = 'Sandshrew e Sandslash'
t.vulpix.anchor = 'Vulpix e Ninetales'
t.diglett.anchor = 'Diglett e Dugtrio'
t.meowth.anchor = 'Meowth e Persian'
t.geodude.anchor = 'Geodude, Graveler e Golem'
t.grimer.anchor = 'Grimer e Muk'
t.wormadam.anchor = 'Burmy e Wormadam'
t.tornadus.anchor = 'Forze della Natura'
t.pumpkaboo.anchor = 'Pumpkaboo e Gourgeist'

-- Alternative forms' links

makeLinks()

-- Alternative forms' black links

makeLinks(true)

-- Table to map extended names to abbrs

t.pikachu.ext = {cosplay = 'Cs', rockstar = 'R', damigella = 'D',
	confetto = 'Cn', scienziata = 'S', wrestler = 'W'}
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
t.darmanitan.ext = {zen = 'Z'}
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
for k, v in pairs(t.mega) do
	t[v].ext = {mega = 'M'}
end
for k, v in pairs(t.megaxy) do
	t[v].ext = {megax = 'MX', megay = 'MY'}
end
for k, v in pairs(t.archeo) do
	t[v].ext = {archeo = 'A'}
end
for k, v in pairs(t.alola) do
	t[v].ext = {alola = 'A'}
end

--[[

Arrays keeping the order in which alternative forms are listed in the latest
game.

--]]

t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W'}
t.castform.gamesOrder = {'base', 'S', 'P', 'N'}
t.deoxys.gamesOrder = {'base', 'A', 'D', 'V'}
t.wormadam.gamesOrder = {'base', 'Sa', 'Sc'}
t.rotom.gamesOrder = {'base', 'C', 'L', 'G', 'V', 'T'}
t.giratina.gamesOrder = {'base', 'O'}
t.shaymin.gamesOrder = {'base', 'C'}
t.arceus.gamesOrder = {'base', 'L', 'Vo', 'Ve', 'T', 'R', 'C', 'S', 'Ai', 'Fu',
	'Aq', 'Er', 'El', 'P', 'G', 'D', 'B', 'Fo', 'Sc'}
t.basculin.gamesOrder = {'base', 'B'}
t.darmanitan.gamesOrder = {'base', 'Z'}
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
table.remove(t.silvally.gamesOrder)
for k, v in pairs(t.mega) do
	t[v].gamesOrder = {'base', 'M'}
end
for k, v in pairs(t.megaxy) do
	t[v].gamesOrder = {'base', 'MX', 'MY'}
end
for k, v in pairs(t.archeo) do
	t[v].gamesOrder = {'base', 'A'}
end
for k, v in pairs(t.alola) do
	t[v].gamesOrder = {'base', 'A'}
end

--[[

Pokémon with different cries between forms.
This array is guaranteed to be a sorted subset of gamesOrder (same sorting)

--]]

for k, v in pairs(t.mega) do
	t[v].cries = {'M'}
end
for k, v in pairs(t.megaxy) do
	t[v].cries = {'MX', 'MY'}
end
for k, v in pairs(t.archeo) do
	t[v].cries = {'A'}
end
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
	Cn = 'roza', S = 'roza', W = 'roza', base = 'rb'}
t.raichu.since = {A = 'sl', base = 'rb'}
t.sandshrew.since = {A = 'sl', base = 'rb'}
t.vulpix.since = {A = 'sl', base = 'rb'}
t.diglett.since = {A = 'sl', base = 'rb'}
t.meowth.since = {A = 'sl', base = 'rb'}
t.geodude.since = {A = 'sl', base = 'rb'}
t.grimer.since = {A = 'sl', base = 'rb'}
t.exeggutor.since = {A = 'sl', base = 'rb'}
t.marowak.since = {A = 'sl', base = 'rb'}
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
t.darmanitan.since = {Z = 'nb', base = 'nb'}
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
t.venusaur.since = {M = 'xy', base = 'rb'}
t.blastoise.since = {M = 'xy', base = 'rb'}
t.beedrill.since = {M = 'roza', base = 'rb'}
t.pidgeot.since = {M = 'roza', base = 'rb'}
t.alakazam.since = {M = 'xy', base = 'rb'}
t.slowbro.since = {M = 'roza', base = 'rb'}
t.gengar.since = {M = 'xy', base = 'rb'}
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
t.charizard.since = {MX = 'xy', MY = 'xy', base = 'rb'}
t.mewtwo.since = {MX = 'xy', MY = 'xy', base = 'rb'}
t.groudon.since = {A = 'roza', base = 'rz'}
t.kyogre.since = {A = 'roza', base = 'rz'}

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pikachu['until'] = {Cs = 'roza', R = 'roza', D = 'roza',
	Cn = 'roza', S = 'roza', W = 'roza'}
t.arceus['until'] = {Sc = 'hgss'}

-- Altre forme di Alola, messe qui per evitare inutili iterazioni dei cicli precedenti

table.insert(t.alola, 'raticate')
table.insert(t.alola, 'sandslash')
table.insert(t.alola, 'ninetales')
table.insert(t.alola, 'dugtrio')
table.insert(t.alola, 'persian')
table.insert(t.alola, 'graveler')
table.insert(t.alola, 'golem')
table.insert(t.alola, 'muk')

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti

t.raticate = t.rattata
t.sandslash = t.sandshrew
t.ninetales = t.vulpix
t.dugtrio = t.diglett
t.persian = t.meowth
t.graveler = t.geodude
t.golem = t.geodude
t.muk = t.grimer
t.thundurus, t.landorus = t.tornadus, t.tornadus
t.gourgeist = t.pumpkaboo
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
t[88] = t.grimer
t[89] = t.muk
t[103] = t.exeggutor
t[105] = t.marowak
t[351] = t.castform
t[386] = t.deoxys
t[413] = t.wormadam
t[479] = t.rotom
t[487] = t.giratina
t[492] = t.shaymin
t[493] = t.arceus
t[550] = t.basculin
t[555] = t.darmanitan
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
t[3] = t.venusaur
t[9] = t.blastoise
t[15] = t.beedrill
t[18] = t.pidgeot
t[65] = t.alakazam
t[80] = t.slowbro
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

return t
