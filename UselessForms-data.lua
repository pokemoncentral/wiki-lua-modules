-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative sono puramente estetiche

local t = {}
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')


-- Tabelle associate ai Pokémon: ne mancano alcuni perché sarebbero
-- identici, in questo modulo, ad altri, e dunque sono costituiti
-- da alias, raggruppati in fondo al modulo

t.unown = {}
t.burmy = {}
t.cherrim = {}
t.shellos = {}
t.arceus = {}
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

-- Nomi delle forme alternative: le chiavi sono le sigle, così da poter
-- mettere solo queste nelle altre sottotabelle

t.unown.names = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', PE = '!', PI = '?'}
t.burmy.names = {Sa = 'Manto Sabbia', Sc = 'Manto Scarti',
	base = 'Manto Pianta'}
t.cherrim.names = {S = 'Forma Splendore', base = 'Forma Nuvola'}
t.shellos.names = {E = 'Mare Est', base = 'Mare Ovest'}
t.arceus.names = {base = 'Tipo Normale', L = 'Tipo Lotta', Vo = 'Tipo Volante',
	Ve = 'Tipo Veleno', T = 'Tipo Terra', R = 'Tipo Roccia', Aq = 'Tipo Acqua',
	C = 'Tipo Coleottero', Er = 'Tipo Erba', P = 'Tipo Psico', B = 'Tipo Buio',
	S = 'Tipo Spettro', Ai = 'Tipo Acciaio', Fu = 'Tipo Fuoco',
	D = 'Tipo Drago', Fo = 'Tipo Folletto', El = 'Tipo Elettro',
	G = 'Tipo Ghiaccio'}
t.unfezant.names = {F = 'Femmina', base = 'Maschio'}
t.deerling.names = {E = 'Forma Estate', A = 'Forma Autunno',
	I = 'Forma Inverno', base = 'Forma Primavera'}
t.frillish.names = t.unfezant.names
t.keldeo.names = {R = 'Forma Risoluta', base = 'Forma Normale'}
t.genesect.names = {I = 'Forma Idromodulo', V = 'Forma Voltmodulo', P = 'Forma Piromodulo',
	G = 'Forma Gelomodulo', base = 'Forma di Genesect'}
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

-- Link alle forme alternative.

for name, poke in pairs(t) do
	poke.links = {}
	for k, v in pairs(poke.names) do
		poke.links[k] =
		table.concat{'<div class="small-text">[[Differenze di forma#',
			string.fu(name), '|', v, ']]</div>'}
	end
	poke.links.base = ''
end

t.shellos.links = {E = '<div class="small-text">[[Differenza di forma#Shellos e Gastrodon|mare Est]]</div>',
	base = ''}
t.burmy.links = {Sa = '<div class="small-text">[[Differenze di forma#Burmy e Wormadam|Manto Sabbia]]</div>',
	Sc = '<div class="small-text">[[Differenze di forma#Burmy e Wormadam|Manto Scarti]]</div>', base = ''}
t.deerling.links = {E = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|Forma Estate]]</div>',
	A = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|Forma Autunno]]</div>',
	I = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|Forma Inverno]]</div>',
	base = ''}
t.frillish.links = {F = '<div class="small-text">[[Differenza di forma#Frillish e Jellicent|Femmina]]</div>',
	base = ''}
t.floette.links = {A = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|Fiore Arancione]]</div>',
	G = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|Fiore Giallo]]</div>',
	Bi = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|Fiore Bianco]]</div>',
	Bl = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|Fiore Blu]]</div>',
	base = ''}

-- Link neri alle forme alternative.

for name, poke in pairs(t) do
	poke.blacklinks = {}
	for k, v in pairs(poke.names) do
		poke.blacklinks[k] =
			table.concat{'<div class="small-text">[[Differenze di forma#',
			string.fu(name), '|<span style="color:#000">',
			v, '</span>]]</div>'}
	end
	poke.blacklinks.base = ''
end

t.shellos.blacklinks = {E = '<div class="small-text">[[Differenza di forma#Shellos e Gastrodon|<span style="color:#000">mare Est</span>]]</div>',
	base = ''}
t.burmy.blacklinks = {Sa = '<div class="small-text">[[Differenze di forma#Burmy e Wormadam|<span style="color:#000">Manto Sabbia</span>]]</div>',
	Sc = '<div class="small-text">[[Differenze di forma#Burmy e Wormadam|<span style="color:#000">Manto Scarti</span>]]</div>', base = ''}
t.deerling.blacklinks = {E = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|<span style="color:#000">Forma Estate</span>]]</div>',
	A = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|<span style="color:#000">Forma Autunno</span>]]</div>',
	I = '<div class="small-text">[[Differenza di forma#Deerling e Sawsbuck|<span style="color:#000">Forma Inverno</span>]]</div>',
	base = ''}
t.frillish.blacklinks = {F = '<div class="small-text">[[Differenza di forma#Frillish e Jellicent|<span style="color:#000">Femmina</span>]]</div>',
	base = ''}
t.floette.blacklinks = {A = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|<span style="color:#000">Fiore Arancione</span>]]</div>',
	G = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|<span style="color:#000">Fiore Giallo</span>]]</div>',
	Bi = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|<span style="color:#000">Fiore Bianco</span>]]</div>',
	Bl = '<div class="small-text">[[Differenza di forma#Flabébé, Floette e Florges|<span style="color:#000">Fiore Blu</span>]]</div>',
	base = ''}

-- Per passare dai nomi estesi delle forme alternative alle sigle

t.unown.ext = t.unown.names
t.burmy.ext = {sabbia = 'Sa', scarti = 'Sc'}
t.cherrim.ext = {splendore = 'S'}
t.shellos.ext = {est = 'E'}
t.arceus.ext = {lotta = 'L', volante = 'Vo', veleno = 'Ve', terra = 'T',
	roccia = 'R', acqua = 'A', coleottero = 'C', erba = 'Er', psico = 'P',
	buio = 'B', spettro = 'S', acciaio = 'A', fuoco = 'Fu', drago = 'D',
	folletto = 'Fo', elettro = 'El', ghiaccio = 'G', coleot = 'C'}
t.unfezant.ext = {femmina = 'F'}
t.deerling.ext = {estate = 'E', autunno = 'A', inverno = 'I'}
t.frillish.ext = t.unfezant.ext
t.keldeo.ext = {risoluta = 'R'}
t.genesect.ext = {idromodulo = 'I', voltmodulo = 'V', piromodulo = 'P',
	gelomodulo = 'G'}
t.vivillon.ext = {nordico = 'No', ['manto di neve'] = 'Mn',
	continentale = 'C', prato = 'Pr', eleganza = 'E', ['nevi perenni'] = 'Ne',
	trendy = 'T', marino = 'Mr', arcipelago = 'A', deserto = 'D', sabbia = 'Sb',
	fluviale = 'F', pluviale = 'Pl', savana = 'Sv', solare = 'So',
	oceanico = 'O', giungla = 'Gu', ['poké ball'] = 'Po', sbarazzino = 'Sb',
	ball = 'Po'}
t.pyroar.ext = t.unfezant.ext
t.floette.ext = {giallo = 'G', arancione = 'A', bianco = 'Bi', blu = 'Bl'}
t.furfrou.ext = {cuore = 'C', stella = 'St', diamante = 'D', dignorina = 'Si',
	gentildonna = 'Gd', gentiluomo = 'Gu', regina = 'R', kabuki = 'K',
	faraone = 'F'}
t.xerneas.ext = {attivo = 'A'}

-- Arrays in cui è memorizzato l'ordine con cui le varie forme appaiono
-- nell'ultimo gioco. Si usano indici numerici per facilitare l'ordinamento

t.unown.gamesOrder = {'', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
	'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'PE', 'PI'}
t.burmy.gamesOrder = {'', 'Sa', 'Sc'}
t.cherrim.gamesOrder = {'', 'S'}
t.shellos.gamesOrder = {'', 'E'}
t.arceus.gamesOrder = {'', 'L', 'Vo', 'Ve', 'T', 'R', 'C', 'S', 'Ai', 'Fu',
	'Aq', 'Er', 'El', 'P', 'G', 'D', 'B', 'Fo'}
t.unfezant.gamesOrder = {'', 'F'}
t.deerling.gamesOrder = {'', 'E', 'A', 'I'}
t.frillish.gamesOrder = t.unfezant.gamesOrder
t.keldeo.gamesOrder = {'', 'R'}
t.genesect.gamesOrder = {'', 'I', 'V', 'P', 'G'}
t.vivillon.gamesOrder = {'', 'No', 'Mn', 'C', 'Pr', 'E', 'Ga', 'T', 'Mr', 'A',
	'D', 'Sb', 'F', 'Pl', 'Sv', 'So', 'O', 'Gu', 'Sr', 'Po'}
t.pyroar.gamesOrder = t.unfezant.gamesOrder
t.floette.gamesOrder = {'', 'G', 'A', 'Bl', 'Bi'}
t.furfrou.gamesOrder = {'', 'C', 'F', 'Gd', 'Gu', 'K', 'R', 'Si', 'St'}
t.xerneas.gamesOrder = {'', 'A'}

-- Tabelle contenenti le sigle dei primi giochi in ordine cronologico in cui
-- la forma è supportata, compresa la forma base

t.unown.since = {base = 'oa', B = 'oa', C = 'oa', D = 'oa', E = 'oa', F = 'oa',
	G = 'oa', H = 'oa', I = 'oa', J = 'oa', K = 'oa', L = 'oa', M = 'oa', N = 'oa',
	O = 'oa', P = 'oa', Q = 'oa', R = 'oa', S = 'oa', T = 'oa', U = 'oa', V = 'oa',
	W = 'oa', X = 'oa', Y = 'oa', Z = 'oa', PE = 'rz', PI = 'rz'}
t.burmy.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
t.cherrim.since = {S = 'dp', base = 'dp'}
t.shellos.since = {E = 'dp', base = 'dp'}
t.arceus.since = {base = 'dp', L = 'dp', Vo = 'dp', Ve = 'dp', T = 'dp',
	R = 'dp', Aq = 'dp', C = 'dp', Er = 'dp', P = 'dp', B = 'dp', S = 'dp',
	Ai = 'dp', Fu = 'dp', D = 'dp', Fo = 'xy', El = 'dp', G = 'dp'}
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


-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti

t.gastrodon = t.shellos
t.sawsbuck = t.deerling
t.jellicent = t.frillish
t['flabébé'], t.florges = t.floette, t.floette
t[201] = t.unown
t[412] = t.burmy
t[421] = t.cherrim
t[422] = t.shellos
t[423] = t.gastrodon
t[493] = t.arceus
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

return t
