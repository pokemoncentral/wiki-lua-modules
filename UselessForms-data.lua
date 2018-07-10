-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings') -- luacheck: no unused
local tab = require('Wikilib-tables') -- luacheck: no unused

-- Crea i link alle forme alternative

local makeLinks = function(black)
	local link = black
			and '<div class="small-text">[[Differenze di forma#${anchor}|<span style="color:#000">${formName}</span>]]</div>'
			or '<div class="small-text">[[Differenze di forma#${anchor}|${formName}]]</div>'
	local index = black and 'blacklinks' or 'links'

	for name, poke in pairs(t) do
		poke[index] = table.map(poke.names, function(formName)
			return string.interp(link, {
					anchor = poke.anchor or string.fu(name),
					formName = formName
			})
		end)
	end
end

-- Tabelle associate ai Pokémon: ne mancano alcuni perché sarebbero
-- identici, in questo modulo, ad altri, e dunque sono costituiti
-- da alias, raggruppati in fondo al modulo

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

-- Nomi delle forme alternative: le chiavi sono le sigle, così da poter
-- mettere solo queste nelle altre sottotabelle

t.pikachu.names = {O = 'Berretto Originale', H = 'Berretto Hoenn',
	Si = 'Berretto Sinnoh', U = 'Berretto Unima',
	K = 'Berretto Kalos', A = 'Berretto Alola',
	Co = 'Berretto Compagni', base = 'Pikachu'}
t.pichu.names = {S = 'Pichu Spunzorek', base = 'Pichu'}
t.unown.names = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', PE = '!', PI = '?'}
t.burmy.names = {Sa = 'Manto Sabbia', Sc = 'Manto Scarti',
	base = 'Manto Pianta'}
t.cherrim.names = {S = 'Forma Splendore', base = 'Forma Nuvola'}
t.shellos.names = {E = 'Mare Est', base = 'Mare Ovest'}
t.unfezant.names = {F = 'Femmina', base = 'Maschio'}
t.deerling.names = {E = 'Forma Estate', A = 'Forma Autunno',
	I = 'Forma Inverno', base = 'Forma Primavera'}
t.frillish.names = t.unfezant.names
t.keldeo.names = {R = 'Forma Risoluta', base = 'Forma Normale'}
t.genesect.names = {I = 'Forma Idromodulo', V = 'Forma Voltmodulo', P = 'Forma Piromodulo',
	G = 'Forma Gelomodulo', base = 'Forma Normale'}
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
	F = 'Taglio Faraone', base = 'Nessun Taglio'}
t.xerneas.names = {A = 'Modo Attivo', base = 'Modo Relax'}
t.mimikyu.names = {S = 'Forma Smascherata', base = 'Forma Mascherata'}
t.minior.names = {R = 'Nucleo Rosso', Ar = 'Nucleo Arancione', G = 'Nucleo Giallo',
	Ve = 'Nucleo Verde', Az = 'Nucleo Azzurro', I = 'Nucleo Indaco',
	Vi = 'Nucleo Violetto', base = 'Forma Meteora'}

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.shellos.anchor = 'Shellos e Gastrodon'
t.burmy.anchor = 'Burmy e Wormadam'
t.deerling.anchor = 'Deerling e Sawsbuck'
t.frillish.anchor = 'Frillish e Jellicent'
t.floette.anchor = 'Flabébé, Floette e Florges'

-- Link alle forme alternative.

makeLinks()

-- Link neri alle forme alternative.

makeLinks(true)

-- Per passare dai nomi estesi delle forme alternative alle sigle

t.pikachu.ext = {originale = 'O', hoenn = 'H', sinnoh = 'Si',
	unima = 'U', kalos = 'K', alola = 'A', compagni = 'Co'}
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
	azzurro = 'Az', indaco = 'I', violetto = 'Vi'}
t.mimikyu.ext = {smascherata = 'S'}

-- Arrays in cui è memorizzato l'ordine con cui le varie forme appaiono
-- nell'ultimo gioco. Si usano indici numerici per facilitare l'ordinamento

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

-- Tabelle contenenti le sigle dei primi giochi in ordine cronologico in cui
-- la forma è supportata, compresa la forma base

t.pikachu.since = {O = 'sl', H = 'sl', Si = 'sl', U = 'sl',
	K = 'sl', A = 'sl', Co = 'usul', base = 'rb'}
t.pichu.since = {S = 'hgss', base = 'oa'}
t.unown.since = {base = 'oa', B = 'oa', C = 'oa', D = 'oa', E = 'oa', F = 'oa',
	G = 'oa', H = 'oa', I = 'oa', J = 'oa', K = 'oa', L = 'oa', M = 'oa', N = 'oa',
	O = 'oa', P = 'oa', Q = 'oa', R = 'oa', S = 'oa', T = 'oa', U = 'oa', V = 'oa',
	W = 'oa', X = 'oa', Y = 'oa', Z = 'oa', PE = 'rz', PI = 'rz'}
t.burmy.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
t.cherrim.since = {S = 'dp', base = 'dp'}
t.shellos.since = {E = 'dp', base = 'dp'}
t.unfezant.since = {F = 'nb', base = 'nb'}
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

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pichu['until'] = {S = 'hgss'}

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti

t.gastrodon = t.shellos
t.sawsbuck = t.deerling
t.jellicent = t.frillish
t['flabébé'], t.florges = t.floette, t.floette
t[25] = t.pikachu
t[172] = t.pichu
t[201] = t.unown
t[412] = t.burmy
t[421] = t.cherrim
t[422] = t.shellos
t[423] = t.gastrodon
t[521] = t.unfezant
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

return t
