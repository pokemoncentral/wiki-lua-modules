-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative non sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')

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
			return string.interp(link, {
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
	-- pagina apposita e non "Differenze di forma

	link = link:gsub('Differenze di forma', 'Forma di Alola')
	for _, poke in pairs(t.alola) do
		t[poke][index] = table.map(t[poke].names, function(formName)
			return string.interp(link, {
					anchor = t[poke].anchor or string.fu(poke),
					formName = formName
			})
		end)
	end
end

-- Tabelle associate ai Pokémon: ne mancano alcuni perché sarebbero
-- identici, in questo modulo, ad altri, e dunque sono costituiti
-- da alias, raggruppati in fondo al modulo

t.pikachu = {}
t.castform = {}
t.deoxys = {}
t.wormadam = {}
t.rotom = {}
t.giratina = {}
t.shaymin = {}
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

-- Generazione dinamica delle megaevoluzioni e archeorisveglio

-- Tabella con i Pokémon che hanno una sola megaevoluzione

t.mega = {'venusaur', 'blastoise', 'beedrill', 'pidgeot', 'alakazam',
	'slowbro', 'gengar', 'kangaskhan', 'pinsir', 'gyarados', 'aerodactyl',
	'ampharos', 'steelix', 'scizor', 'heracross', 'houndoom', 'tyranitar',
	'sceptile', 'blaziken', 'swampert', 'gardevoir', 'sableye', 'mawile',
	'aggron', 'medicham', 'manectric', 'banette', 'sharpedo', 'camerupt',
	'altaria', 'absol', 'glalie', 'salamence', 'metagross', 'latias',
	'latios', 'rayquaza', 'lopunny', 'garchomp', 'lucario', 'abomasnow',
	'gallade', 'audino', 'diancie'}

-- Tabella contentente i Pokémon che hanno più megaevoluzioni

t.megaxy = {'charizard', 'mewtwo'}

-- Tabella contenente i Pokémon che hanno una archeorisveglio

t.archeo = {'kyogre', 'groudon'}

-- Tabella contenente i Pokémon che hanno una forma di Alola:
-- per efficienza, alcuni sono alla fine del modulo

t.alola = {'rattata', 'raichu', 'sandshrew', 'vulpix', 'meowth', 'grimer',
	'exeggutor', 'marowak'}

-- Nomi delle forme alternative: le chiavi sono le sigle, così da poter
-- mettere solo queste nelle altre sottotabelle

t.pikachu.names = {Cs = 'Pikachu Cosplay', R = 'Pikachu Rockstar',
	D = 'Pikachu Damigella', Cn = 'Pikachu Confetto',
	S = 'Pikachu Scienziata', W = 'Pikachu Wrestler', base = 'Pikachu'}
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
t.basculin.names = {B = 'Forma Lineablu', base = 'Forma Linearossa'}
t.darmanitan.names = {Z = 'Stato Zen', base = 'Forma Normalità'}
t.tornadus.names = {T = 'Forma Totem', base = 'Forma Incarnazione'}
t.kyurem.names = {N = 'Kyurem Nero', B = 'Kyurem Bianco', base = 'Forma Base'}
t.meloetta.names = {D = 'Forma Danza', base = 'Forma Canto'}
t.greninja.names = {A = 'Forma Ash', base = 'Greninja'}
t.meowstic.names = {F = 'Femmina', base = 'Maschio'}
t.aegislash.names = {S = 'Forma Spada', base = 'Forma Scudo'}
t.pumpkaboo.names = {S = 'Mini', L = 'Grande', XL = 'Maxi', base = 'Normale'}
t.zygarde.names = {D = 'Forma 10%', P = 'Forma Perfetta', base = 'Forma 50%'}
t.hoopa.names = {L = 'Libero', base = 'Vincolato'}
t.lycanroc.names = {N = 'Forma Notte', base = 'Forma Giorno'}
t.oricorio.names = {C = 'Stile Cheerdance', H = 'Stile Hula', B = 'Stile Buyō',
	base = 'Stile Flamenco'}
t.wishiwashi.names = {B = 'Forma Banco', base = 'Forma Individuale'}
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
	t[v].names = {A = 'Forma di Alola', base = 'Forma Normale'}
end

-- Sigle delle forme alternative che cambiano tipo rispetto alla forma base,
-- che dunque non è presente

t.castform.changetype = {'S', 'P', 'N'}
t.wormadam.changetype = {'Sa', 'Sc'}
t.rotom.changetype = {'C', 'L', 'G', 'V', 'T'}
t.shaymin.changetype = {'C'}
t.darmanitan.changetype = {'Z'}
t.meloetta.changetype = {'D'}
t.charizard.changetype = {'MX'}
t.pinsir.changetype = {'M'}
t.gyarados.changetype = {'M'}
t.pinsir.changetype = {'M'}
t.mewtwo.changetype = {'MX'}
t.ampharos.changetype = {'M'}
t.sceptile.changetype = {'M'}
t.aggron.changetype = {'M'}
t.altaria.changetype = {'M'}
t.groudon.changetype = {'A'}
t.lopunny.changetype = {'M'}
t.audino.changetype = {'M'}
t.hoopa.changetype = {'L'}
t.oricorio.changetype = {'C', 'H', 'B'}
for k, v in pairs(t.alola) do
	t[v].changetype = {'A'}
end

-- Sigle delle forme alternative che cambiano abilità rispetto alla forma base,
-- che non è dunque presente; visto che la maggior parte delle megaevoluzioni
-- cambiano abilità, è più conveniente inserirle preliminarmente tutte e
-- togliere quelle che invece non la cambiano

t.giratina.changeability = {'O'}
t.shaymin.changeability = t.shaymin.changetype
t.basculin.changeability = {'B'}
t.tornadus.changeability = {'T'}
t.kyurem.changeability = {'N', 'B'}
t.greninja.changeability = {'A'}
t.meowstic.changeability = {'F'}
t.zygarde.changeability = {'P'}
t.lycanroc.changeability = {'N'}
for k, v in pairs(t.mega) do
	t[v].changeability = {'M'}
end
for k, v in pairs(t.megaxy) do
	t[v].changeability = {'MX', 'MY'}
end
for k, v in pairs(t.archeo) do
	t[v].changeability = {'A'}
end
for k, v in pairs(t.alola) do
	t[v].changeability = t[v].changetype
end
t.scizor.changeability = nil
t.tyranitar.changeability = nil
t.medicham.changeability = nil
t.latias.changeability = nil
t.latios.changeability = nil
t.garchomp.changeability = nil
t.abomasnow.changeability = nil
t.audino.changeability = nil
t.meowth.changeability = nil

-- Sigle delle forme alternative che cambiano statistiche rispetto alla forma
-- base, che non è dunque presente

t.deoxys.changestats = {'A', 'D', 'V'}
t.wormadam.changestats = t.wormadam.changetype
t.rotom.changestats = t.rotom.changetype
t.giratina.changestats = t.giratina.changeability
t.shaymin.changestats = t.shaymin.changetype
t.darmanitan.changestats = t.darmanitan.changetype
t.tornadus.changestats = t.tornadus.changeability
t.kyurem.changestats = t.kyurem.changeability
t.meloetta.changestats = t.meloetta.changetype
t.aegislash.changestats = {'S'}
t.pumpkaboo.changestats = {'S', 'L', 'XL'}
t.zygarde.changestats = {'D', 'P'}
t.hoopa.changestats = t.hoopa.changetype
t.wishiwashi.changestats = {'B'}
for k, v in pairs(t.mega) do
	t[v].changestats = {'M'}
end
for k, v in pairs(t.megaxy) do
	t[v].changestats = {'MX', 'MY'}
end
for k, v in pairs(t.archeo) do
	t[v].changestats = {'A'}
end

-- Sigle delle forme alternative che cambiano mosse apprese rispetto alla
-- forma base, che non è dunque presente

t.pikachu.changemoves = {'R', 'D', 'Cn', 'S', 'W'}
t.deoxys.changemoves = t.deoxys.changestats
t.wormadam.changemoves = t.wormadam.changetype
t.rotom.changemoves = t.rotom.changetype
t.shaymin.changemoves = t.shaymin.changetype
t.kyurem.changemoves = t.kyurem.changeability
t.meowstic.changemoves = t.meowstic.changeability
--t.zygarde.changemoves = {}
t.hoopa.changemoves = t.hoopa.changetype

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.rattata.anchor = 'Rattata e Raticate'
t.sandshrew.anchor = 'Sandshrew e Sandslash'
t.vulpix.anchor = 'Vulpix e Ninetales'
t.grimer.anchor = 'Grimer e Muk'
t.wormadam.anchor = 'Burmy e Wormadam'
t.tornadus.anchor = 'Trio dei Kami'
t.pumpkaboo.anchor = 'Pumpkaboo e Gourgeist'

-- Link alle forme alternative.

makeLinks()

-- Link neri alle forme alternative.

makeLinks(true)

-- Per passare dai nomi estesi delle forme alternative alle sigle

t.pikachu.ext = {cosplay = 'Cs', rockstar = 'R', damigella = 'D',
	confetto = 'Cn', scienziata = 'S', wrestler = 'W'}
t.castform.ext = {sole = 'S', pioggia = 'P', neve = 'N'}
t.deoxys.ext = {attacco = 'A', difesa = 'D', ['velocità'] = 'V'}
t.wormadam.ext = {sabbia = 'Sa', scarti = 'Sc'}
t.rotom.ext = {calore = 'C', lavaggio = 'L', gelo = 'G', vortice = 'V',
	taglio = 'T'}
t.giratina.ext = {originale = 'O', origine = 'O'}
t.shaymin.ext = {cielo = 'C'}
t.basculin.ext = {lineablu = 'B'}
t.darmanitan.ext = {zen = 'Z'}
t.tornadus.ext = {totem = 'T'}
t.kyurem.ext = {nero = 'N', bianco = 'B'}
t.meloetta.ext = {danza = 'D'}
t.greninja.ext = {ash = 'A'}
t.meowstic.ext = {femmina = 'F'}
t.aegislash.ext = {spada = 'S'}
t.pumpkaboo.ext = {mini = 'S', grande = 'L', maxi = 'XL'}
t.zygarde.ext = {['forma 10%'] = 'D', perfetto = 'P'}
t.hoopa.ext = {libero = 'L'}
t.lycanroc.ext = {notte = 'N', giorno = 'base'}
t.oricorio.ext = {cheerdance = 'C', hula = 'H', buyo = 'B',
	flamenco = 'base'}
t.wishiwashi.ext = {banco = 'B', individuale = 'base'}
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

-- Arrays in cui è memorizzato l'ordine con cui le varie forme appaiono
-- nell'ultimo gioco. Si usano indici numerici per facilitare l'ordinamento

t.pikachu.gamesOrder = {'base', 'Cs', 'R', 'D', 'Cn', 'S', 'W'}
t.castform.gamesOrder = {'base', 'S', 'P', 'N'}
t.deoxys.gamesOrder = {'base', 'A', 'D', 'V'}
t.wormadam.gamesOrder = {'base', 'Sa', 'Sc'}
t.rotom.gamesOrder = {'base', 'C', 'L', 'G', 'V', 'T'}
t.giratina.gamesOrder = {'base', 'O'}
t.shaymin.gamesOrder = {'base', 'C'}
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
t.lycanroc.gamesOrder = {'base', 'N'}
t.oricorio.gamesOrder = {'base', 'C', 'H', 'B'}
t.wishiwashi.gamesOrder = {'base', 'B'}
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

-- Tabelle contenenti le sigle dei primi giochi in ordine cronologico in cui
-- la forma è supportata, compresa la forma base

t.rattata.since = {A = 'sl', base = 'rb'}
t.pikachu.since = {Cs = 'roza', R = 'roza', D = 'roza',
	Cn = 'roza', S = 'roza', W = 'roza', base = 'rb'}
t.raichu.since = {A = 'sl', base = 'rb'}
t.sandshrew.since = {A = 'sl', base = 'rb'}
t.vulpix.since = {A = 'sl', base = 'rb'}
t.meowth.since = {A = 'sl', base = 'rb'}
t.grimer.since = {A = 'sl', base = 'rb'}
t.exeggutor.since = {A = 'sl', base = 'rb'}
t.marowak.since = {A = 'sl', base = 'rb'}
t.castform.since = {S = 'rz', P = 'rz', N = 'rz', base = 'rz'}
t.deoxys.since = {A = 'rfvf', D = 'rfvf', V = 's', base = 'rz'}
t.wormadam.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
t.rotom.since = {C = 'pt', L = 'pt', G = 'pt', V = 'pt', T = 'pt', base = 'dp'}
t.giratina.since = {O = 'pt', base = 'dp'}
t.shaymin.since = {C = 'pt', base = 'dp'}
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
t.lycanroc.since = {N = 'sl', base = 'sl'}
t.oricorio.since = {C = 'sl', H = 'sl', B = 'sl', base = 'sl'}
t.wishiwashi.since = {B = 'sl', base = 'sl'}
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

-- Altre forme di Alola, messe qui per evitare inutili iterazioni dei cicli precedenti

table.insert(t.alola, 'raticate')
table.insert(t.alola, 'sandslash')
table.insert(t.alola, 'ninetales')
table.insert(t.alola, 'muk')

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti

t.raticate = t.rattata
t.sandslash = t.sandshrew
t.ninetales = t.vulpix
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
t[52] = t.meowth
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
