-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused

-- Creates link to alternative forms in list pointing to target instead of
-- "Differenze di forma"
local makeTargetedLink = function(linkstr, index, target, list)
	linkstr = linkstr:gsub('Differenze di forma', target)
	for _, poke in pairs(list) do
		t[poke][index] = table.map(t[poke].names, function(formName)
			return formName == ''
				   and ''
				   or string.interp(linkstr, {
					anchor = t[poke].anchor or string.fu(poke),
					formName = formName
			})
		end)
	end
end

-- Creates links to alternative forms
local makeLinks = function(black)
	local link = black
			and '<div class="small-text black-text">[[Differenze di forma#${anchor}|${formName}]]</div>'
			or '<div class="small-text">[[Differenze di forma#${anchor}|${formName}]]</div>'
	local index = black and 'blacklinks' or 'links'

	local stdLinks = table.filter(t, function(_, key)
		return not table.search({'gigamax'}, key)
				and not table.search(t.gigamax, key)
	end)

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

	-- Link of forms with a dedicated page instead of "Differenze di forma"
	makeTargetedLink(link, index, 'Gigamax', t.gigamax)
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = {}
t.pichu = {}
t.unown = {}
t.burmy = {}
t.cherrim = {}
t.shellos = {}
t.unfezant = {}
t.deerling = {}
t.frillish = {}
t.keldeo = {}
t.genesect = {}
t.vivillon = {}
t.pyroar = {}
t.floette = {}
t.furfrou = {}
t.xerneas = {}
t.minior = {}
t.mimikyu = {}
t.cramorant = {}
t.sinistea = {}
t.alcremie = {}
t.urshifu = {}

-- Table with Pokémon with a Gigamax

t.gigamax = {'venusaur', 'charizard', 'blastoise', 'butterfree', 'meowth',
	'machamp', 'gengar', 'kingler', 'lapras', 'eevee', 'snorlax', 'garbodor',
	'melmetal', 'rillaboom', 'cinderace', 'inteleon', 'corviknight', 'orbeetle',
	'drednaw', 'coalossal', 'flapple', 'appletun', 'sandaconda', 'toxtricity',
	'centiskorch', 'hatterene', 'grimmsnarl', 'copperajah', 'duraludon'}

--[[

Alternative forms names. Keys are the abbr.

--]]

t.pikachu.names = {O = 'Berretto Originale', H = 'Berretto Hoenn',
	Si = 'Berretto Sinnoh', U = 'Berretto Unima',
	K = 'Berretto Kalos', A = 'Berretto Alola',
	Co = 'Berretto Compagni', Gi = 'Gigamax', base = ''}
t.pichu.names = {S = 'Pichu Spunzorek', base = ''}
t.unown.names = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', PE = '!', PI = '?'}
t.burmy.names = {Sa = 'Manto Sabbia', Sc = 'Manto Scarti',
	base = 'Manto Pianta'}
t.cherrim.names = {S = 'Forma Splendore', base = 'Forma Nuvola'}
t.shellos.names = {E = 'Mare Est', base = 'Mare Ovest'}
t.unfezant.names = {F = '', base = ''}
t.deerling.names = {E = 'Forma Estate', A = 'Forma Autunno',
	I = 'Forma Inverno', base = 'Forma Primavera'}
t.frillish.names = t.unfezant.names
t.keldeo.names = {R = 'Forma Risoluta', base = 'Forma Normale'}
t.genesect.names = {I = 'Con Idromodulo', V = 'Con Voltmodulo',
	P = 'Con Piromodulo', G = 'Con Gelomodulo', base = 'Senza Modulo'}
t.vivillon.names = {base = 'Motivo Nevi Perenni', No = 'Motivo Nordico',
	Mn = 'Motivo Manto di Neve', C = 'Motivo Continentale', Pr = 'Motivo Prato',
	E = 'Motivo Eleganza', Ga = 'Motivo Giardinfiore', T = 'Motivo Trendy',
	Mr = 'Motivo Marino', A = 'Motivo Arcipelago', D = 'Motivo Deserto',
	Sb = 'Motivo Sabbia', F = 'Motivo Fluviale', Pl = 'Motivo Pluviale',
	Sv = 'Motivo Savana', So = 'Motivo Solare', O = 'Motivo Oceanico',
	Gu =  'Motivo Giungla', Po = 'Motivo Poké Ball', Sr = 'Motivo Sbarazzino'}
t.pyroar.names = t.unfezant.names
t.floette.names = {G = 'Fiore Giallo', A = 'Fiore Arancione',
	Bi = 'Fiore Bianco', Bl = 'Fiore Blu', base = 'Fiore Rosso'}
t.furfrou.names = {C = 'Taglio Cuore', St = 'Taglio Stella',
	D = 'Taglio Diamante', Si = 'Taglio Signorina', Gd = 'Taglio Gentildonna',
	Gu = 'Taglio Gentiluomo', R = 'Taglio Regina', K = 'Taglio Kabuki',
	F = 'Taglio Faraone', base = 'Forma Selvatica'}
t.xerneas.names = {A = 'Modo Attivo', base = 'Modo Relax'}
t.mimikyu.names = {S = 'Forma Smascherata', base = 'Forma Mascherata'}
t.minior.names = {R = 'Nucleo Rosso', Ar = 'Nucleo Arancione',
	G = 'Nucleo Giallo', Ve = 'Nucleo Verde', Az = 'Nucleo Azzurro',
	I = 'Nucleo Indaco', Vi = 'Nucleo Violetto', base = 'Forma Meteora'}
t.cramorant.names = {T = "Forma Inghiottitutto", I = "Forma Inghiottintero", base = ""}
t.sinistea.names = {base = "", A = ""}
t.alcremie.names = {base = "Lattevaniglia", R = "Latterosa", Ma = "Lattematcha",
	Me = "Lattementa", L = "Lattelimone", S = "Lattesale", Rm = "Rosamix",
	Cm = "Caramelmix", Tm = "Triplomix", Gi = "Gigamax"}
t.urshifu.names = {Gi = "Urshifu Gigamax", PGi = "Urshifu Gigamax", base = "Stile Singolcolpo"}
for _, v in pairs(t.gigamax) do
	t[v] = {}
	t[v].names = {Gi = string.fu(v) .. " Gigamax", base = ""}
end

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.shellos.anchor = 'Shellos e Gastrodon'
t.burmy.anchor = 'Burmy e Wormadam'
t.deerling.anchor = 'Deerling e Sawsbuck'
t.floette.anchor = 'Flabébé, Floette e Florges'

-- Alternative forms' links

makeLinks()

-- Alternative forms' black links

makeLinks(true)

-- Table to map extended names to abbrs

t.pikachu.ext = {originale = 'O', hoenn = 'H', sinnoh = 'Si',
	unima = 'U', kalos = 'K', alola = 'A', compagni = 'Co', gigamax = 'Gi'}
t.pichu.ext = {spunzorek = 'S'}
t.unown.ext = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', ['!'] = 'PE', ['?'] = 'PI'}
t.burmy.ext = {sabbia = 'Sa', scarti = 'Sc'}
t.cherrim.ext = {splendore = 'S'}
t.shellos.ext = {est = 'E'}
t.unfezant.ext = {femmina = 'F'}
t.deerling.ext = {estate = 'E', autunno = 'A', inverno = 'I'}
t.frillish.ext = t.unfezant.ext
t.keldeo.ext = {risoluta = 'R'}
t.genesect.ext = {idromodulo = 'I', voltmodulo = 'V', piromodulo = 'P',
	gelomodulo = 'G'}
t.vivillon.ext = {nordico = 'No', ['manto di neve'] = 'Mn',
	continentale = 'C', prato = 'Pr', eleganza = 'E', giardinfiore = 'Ga',
	['nevi perenni'] = 'Ne', trendy = 'T', marino = 'Mr', arcipelago = 'A',
	deserto = 'D', sabbia = 'Sb', fluviale = 'F', pluviale = 'Pl',
	savana = 'Sv', solare = 'So', oceanico = 'O', giungla = 'Gu',
	['poké ball'] = 'Po', sbarazzino = 'Sr', ball = 'Po'}
t.pyroar.ext = t.unfezant.ext
t.floette.ext = {giallo = 'G', arancione = 'A', bianco = 'Bi', blu = 'Bl'}
t.furfrou.ext = {cuore = 'C', stella = 'St', diamante = 'D', dignorina = 'Si',
	gentildonna = 'Gd', gentiluomo = 'Gu', regina = 'R', kabuki = 'K',
	faraone = 'F'}
t.xerneas.ext = {attivo = 'A'}
t.minior.ext = {rosso = 'R', arancione = 'Ar', giallo = 'G', verde = 'Ve',
	azzurro = 'Az', indaco = 'I', violetto = 'Vi', meteora = 'base'}
t.mimikyu.ext = {smascherata = 'S'}
t.cramorant.ext = {inghiottitutto = 'T', inghiottintero = 'I'}
t.sinistea.ext = {}
t.alcremie.ext = {lattevaniglia = 'base', latterosa = 'R', lattematcha = 'Ma',
	lattementa = 'Me', lattelimone = 'L', lattesale = 'S', rosamix = 'Rm',
	caramelmix = 'Cm', triplomix = 'Tm', gigamax = 'Gi'}
t.urshifu.ext = {gigamax = "Gi"}
for _, v in pairs(t.gigamax) do
	t[v].ext = {gigamax = "Gi"}
end

--[[

Arrays keeping the order in which alternative forms are listed in the latest
game.

--]]

t.pikachu.gamesOrder = {'base', 'O', 'H', 'Si', 'U', 'K', 'A', 'Co'}
t.pichu.gamesOrder = {'base', 'S'}
t.unown.gamesOrder = {'base', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
	'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'PE', 'PI'}
t.burmy.gamesOrder = {'base', 'Sa', 'Sc'}
t.cherrim.gamesOrder = {'base', 'S'}
t.shellos.gamesOrder = {'base', 'E'}
t.unfezant.gamesOrder = {'base', 'F'}
t.deerling.gamesOrder = {'base', 'E', 'A', 'I'}
t.frillish.gamesOrder = t.unfezant.gamesOrder
t.keldeo.gamesOrder = {'base', 'R'}
t.genesect.gamesOrder = {'base', 'I', 'V', 'P', 'G'}
t.vivillon.gamesOrder = {'base', 'No', 'Mn', 'C', 'Pr', 'E', 'Ga', 'T', 'Mr', 'A',
	'D', 'Sb', 'F', 'Pl', 'Sv', 'So', 'O', 'Gu', 'Sr', 'Po'}
t.pyroar.gamesOrder = t.unfezant.gamesOrder
t.floette.gamesOrder = {'base', 'G', 'A', 'Bl', 'Bi'}
t.furfrou.gamesOrder = {'base', 'C', 'St', 'Si', 'Gd', 'D', 'Gu', 'R', 'K', 'F'}
t.xerneas.gamesOrder = {'base', 'A'}
t.minior.gamesOrder = {'base', 'R', 'Ar', 'G', 'Ve', 'Az', 'I', 'Vi'}
t.mimikyu.gamesOrder = {'base', 'S'}
t.cramorant.gamesOrder = {'base', 'T', 'I'}
t.sinistea.gamesOrder = {'base', 'A'}
t.alcremie.gamesOrder = {'base', 'R', 'Ma', 'Me', 'L', 'S', 'Rm', 'Cm', 'Tm'}
t.urshifu.gamesOrder = {"base", "Gi", "GiP"}
for _, v in pairs(t.gigamax) do
	t[v].gamesOrder = {"base", "Gi"}
end

--[[

Oldest game in which each form, included base form, appears.

--]]

t.venusaur.since = {base = 'rb', Gi = 'spsc'}
t.charizard.since = {base = 'rb', Gi = 'spsc'}
t.blastoise.since = {base = 'rb', Gi = 'spsc'}
t.butterfree.since = {base = 'rb', Gi = 'spsc'}
t.pikachu.since = {O = 'sl', H = 'sl', Si = 'sl', U = 'sl',
	K = 'sl', A = 'sl', Co = 'usul', Gi = 'spsc', base = 'rb'}
t.meowth.since = {base = 'rb', Gi = 'spsc'}
t.machamp.since = {base = 'rb', Gi = 'spsc'}
t.gengar.since = {base = 'rb', Gi = 'spsc'}
t.kingler.since = {base = 'rb', Gi = 'spsc'}
t.lapras.since = {base = 'rb', Gi = 'spsc'}
t.eevee.since = {base = 'rb', Gi = 'spsc'}
t.snorlax.since = {base = 'rb', Gi = 'spsc'}
t.pichu.since = {S = 'hgss', base = 'oa'}
t.unown.since = {base = 'oa', B = 'oa', C = 'oa', D = 'oa', E = 'oa', F = 'oa',
	G = 'oa', H = 'oa', I = 'oa', J = 'oa', K = 'oa', L = 'oa', M = 'oa', N = 'oa',
	O = 'oa', P = 'oa', Q = 'oa', R = 'oa', S = 'oa', T = 'oa', U = 'oa', V = 'oa',
	W = 'oa', X = 'oa', Y = 'oa', Z = 'oa', PE = 'rz', PI = 'rz'}
t.burmy.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
t.cherrim.since = {S = 'dp', base = 'dp'}
t.shellos.since = {E = 'dp', base = 'dp'}
t.unfezant.since = {F = 'nb', base = 'nb'}
t.garbodor.since = {base = 'nb', Gi = 'spsc'}
t.deerling.since = {E = 'nb', A = 'nb', I = 'nb', base = 'nb'}
t.frillish.since = t.unfezant.since
t.keldeo.since = {R = 'n2b2', base = 'nb'}
t.genesect.since = {I = 'nb', V = 'nb', P = 'nb', G = 'nb', base = 'nb'}
t.vivillon.since = {base = 'xy', No = 'xy', Mn = 'xy', C = 'xy', Pr = 'xy',
	E = 'xy', Ga = 'xy', T = 'xy', Mr = 'xy', A = 'xy', D = 'xy', Sb = 'xy',
	F = 'xy', Pl = 'xy', Sv = 'xy', So = 'xy', O = 'xy', Gu =  'xy',
	Po = 'xy', Sr = 'xy'}
t.pyroar.since = {F = 'xy', base = 'xy'}
t.floette.since = {G = 'xy', A = 'xy', Bi = 'xy', Bl = 'xy', base = 'xy'}
t.furfrou.since = {C = 'xy', St = 'xy', D = 'xy', Si = 'xy', Gd = 'xy',
	Gu = 'xy', R = 'xy', K = 'xy', F = 'xy', base = 'xy'}
t.xerneas.since = {A = 'xy', base = 'xy'}
t.minior.since = {base = 'sl', R = 'sl', Ar = 'sl', G = 'sl', Ve = 'sl',
	Az = 'sl', I = 'sl', Vi = 'sl'}
t.mimikyu.since = {base = 'sl', S = 'sl'}
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
t.cramorant.since = {T = 'spsc', I = 'spsc', base = 'spsc'}
t.toxtricity.since = {base = 'spsc', Gi = 'spsc'}
t.centiskorch.since = {base = 'spsc', Gi = 'spsc'}
t.sinistea.since = {base = 'spsc', A = 'spsc'}
t.hatterene.since = {base = 'spsc', Gi = 'spsc'}
t.grimmsnarl.since = {base = 'spsc', Gi = 'spsc'}
t.alcremie.since = {base = 'spsc', R = 'spsc', Ma = 'spsc', Me = 'spsc',
	L = 'spsc', S = 'spsc', Rm = 'spsc', Cm = 'spsc', Tm = 'spsc', Gi = 'spsc'}
t.copperajah.since = {base = 'spsc', Gi = 'spsc'}
t.duraludon.since = {base = 'spsc', Gi = 'spsc'}
t.urshifu.since = {base = 'spsc', Gi = 'spsc', PGi = 'spsc'}

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pichu['until'] = {S = 'hgss'}

-- Other Gigamax forms
table.insert(t.gigamax, 'pikachu')
table.insert(t.gigamax, 'toxtricity')
table.insert(t.gigamax, 'alcremie')
table.insert(t.gigamax, 'urshifu')

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti
t.gastrodon = t.shellos
t.sawsbuck = t.deerling
t.jellicent = t.frillish
t['flabébé'], t.florges = t.floette, t.floette
t.polteageist = t.sinistea
t[3] = t.venusaur
t[6] = t.charizard
t[9] = t.blastoise
t[12] = t.butterfree
t[25] = t.pikachu
t[52] = t.meowth
t[68] = t.machamp
t[94] = t.gengar
t[99] = t.kingler
t[131] = t.lapras
t[133] = t.eevee
t[143] = t.snorlax
t[172] = t.pichu
t[201] = t.unown
t[412] = t.burmy
t[421] = t.cherrim
t[422] = t.shellos
t[423] = t.gastrodon
t[521] = t.unfezant
t[569] = t.garbodor
t[585] = t.deerling
t[586] = t.sawsbuck
t[592] = t.frillish
t[593] = t.jellicent
t[647] = t.keldeo
t[649] = t.genesect
t[666] = t.vivillon
t[668] = t.pyroar
t[669] = t['flabébé']
t[670] = t.floette
t[671] = t.florges
t[676] = t.furfrou
t[716] = t.xerneas
t[774] = t.minior
t[778] = t.mimikyu
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
t[845] = t.cramorant
t[849] = t.toxtricity
t[851] = t.centiskorch
t[854] = t.sinistea
t[855] = t.polteageist
t[858] = t.hatterene
t[861] = t.grimmsnarl
t[869] = t.alcremie
t[879] = t.copperajah
t[884] = t.duraludon

return t
