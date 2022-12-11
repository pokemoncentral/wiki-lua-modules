-- Ogni Pokémon con forme alternative ha una tabella associata con
-- tutte le informazioni necessarie come sottotabelle: si usano le
-- sigle come chiavi, o come elementi stessi se l'informazione della
-- tabella è booleana; sono considerati solo i Pokémon le cui forme
-- alternative sono puramente estetiche

local t = {}

-- stylua: ignore start
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
-- stylua: ignore end

-- TODO: refactor link creations, shamelessly copied from AltForms-data
--[[

Creates the link for an alternative form. There are two general
kinds of link: those pointing to the specific subpage of the Pokémon,
and those pointing to general pages (eg: "Forma di Alola").
This function handles boths, depending on the arguments.
This function also handles empty form name, yielding no link at all
(an empty string).

Arguments:
	- context: a string containing a ${link} replacement. The string is a
			context in which ${link} is replaced with the actual link
	- formName: name of the specific form
	- poke: base name of the Pokémon
	- general: an optional string argument. If given, the function assumes
			the link target should be the general page whose title is given by
			the value of this parameter (eg: for a Megaevoluzione, this
			parameter should be "Megaevoluzione")

--]]
local function makeSingleLink(context, formName, poke, general)
    if formName == "" then
        return ""
    end

    local target
    if general then
        target = table.concat({ general, "#", t[poke].anchor or txt.fu(poke) })
    else
        target = table.concat({ txt.fu(poke), "/Forme" })
    end
    return txt.interp(context, {
        link = table.concat({ "[[", target, "|", formName, "]]" }),
    })
end

-- Create all links for alternative forms (black, blue and plain)
local function makeLinks()
    local contexts = {
        links = '<div class="small-text">${link}</div>',
        blacklinks = '<div class="small-text black-text">${link}</div>',
        plainlinks = "${link}",
    }
    for index, context in pairs(contexts) do
        for name, poke in pairs(t) do
            poke[index] = tab.map(poke.names, function(formName)
                return makeSingleLink(context, formName, name)
            end)
        end
    end
end

--[[

There's a table for each Pokémon. Some are missing because they would be equal
to others, thus there's aliasing at the end of the module.

--]]

t.pikachu = {}
t.pichu = {}
t.unown = {}
t.burmy = {}
t.shellos = {}
t.unfezant = {}
t.deerling = {}
t.frillish = {}
t.keldeo = {}
t.genesect = {}
t.vivillon = {}
t.pyroar = {}
t.floette = {}
t.florges = {}
t.furfrou = {}
t.xerneas = {}
t.minior = {}
t.mimikyu = {}
t.magearna = {}
t.cramorant = {}
t.sinistea = {}
t.alcremie = {}
t.zarude = {}
t.dudunsparce = {}
t.maushold = {}
t.tatsugiri = {}
t.koraidon = {}
t.miraidon = {}

--[[

Alternative forms names. Keys are the abbr.

--]]

-- stylua: ignore start
t.pikachu.names = {O = 'Berretto Originale', H = 'Berretto Hoenn',
	Si = 'Berretto Sinnoh', U = 'Berretto Unima',
	K = 'Berretto Kalos', A = 'Berretto Alola',
	Co = 'Berretto Compagni', G = 'Berretto Giramondo',
	base = ''}
t.pichu.names = {S = 'Pichu Spunzorek', base = ''}
t.unown.names = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', PE = '!', PI = '?'}
t.burmy.names = {Sa = 'Manto Sabbia', Sc = 'Manto Scarti',
	base = 'Manto Pianta'}
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
	Bi = 'Fiore Bianco', Bl = 'Fiore Blu', base = 'Fiore Rosso',
	E = "Fiore Eterno"}
t.florges.names = {G = 'Fiore Giallo', A = 'Fiore Arancione',
	Bi = 'Fiore Bianco', Bl = 'Fiore Blu', base = 'Fiore Rosso'}
t.furfrou.names = {C = 'Taglio Cuore', St = 'Taglio Stella',
	D = 'Taglio Diamante', Si = 'Taglio Signorina', Gd = 'Taglio Gentildonna',
	Gu = 'Taglio Gentiluomo', R = 'Taglio Regina', K = 'Taglio Kabuki',
	F = 'Taglio Faraone', base = 'Forma Selvatica'}
t.xerneas.names = {A = 'Modo Attivo', base = 'Modo Relax'}
t.mimikyu.names = {S = 'Forma Smascherata', base = 'Forma Mascherata'}
t.magearna.names = {A = 'Colore Antico', base = ''}
t.minior.names = {R = 'Nucleo Rosso', Ar = 'Nucleo Arancione',
	G = 'Nucleo Giallo', Ve = 'Nucleo Verde', Az = 'Nucleo Azzurro',
	I = 'Nucleo Indaco', Vi = 'Nucleo Violetto', base = 'Forma Meteora'}
t.cramorant.names = {T = "Forma Inghiottitutto", I = "Forma Inghiottintero", base = ""}
t.sinistea.names = {base = "Forma Contraffatta", A = "Forma Autentica"}
-- Alcremie is below
t.zarude.names = { P = "Zarude Papà", base = "" }
t.dudunsparce.names = { base = "Forma Bimetamero", T = "Forma Trimetamero" }
t.maushold.names = { base = "Trifamiglia", Q = "Quadrifamiglia" }
t.tatsugiri.names = { base = "Forma Arcuata", A = "Forma Adagiata", T = "Forma Tesa" }
t.koraidon.names = { base = "Foggia Integrale", P = "Foggia Parziale", S = "Foggia Scattante", N = "Foggia Nautica", L = "Foggia Librata" }
t.miraidon.names = { base = "Assetto Completo", L = "Assetto Limitato", S = "Assetto Sprint", N = "Assetto Nuoto", P = "Assetto Planata" }
-- stylua: ignore end
-- Alcremie is quite molesto in **** (censored for the sake of poor childen who browse our site)
do
	-- stylua: ignore
	local flavours = {Lv = "Lattevaniglia", R = "Latterosa", Ma = "Lattematcha",
		Me = "Lattementa", L = "Lattelimone", S = "Lattesale", Rm = "Rosamix",
		Cm = "Caramelmix", Tm = "Triplomix"}
	-- stylua: ignore
	local decorations = {Fa = "Bonbonfragola", C = "Bonboncuore",
		B = "Bonbonbosco", Fo = "Bonbonfoglio", Fe = "Bonbonfiore",
		S = "Bonbonstella", Fc = "Bonbonfiocco"}

    t.alcremie.names = { base = "Lattevaniglia Bonbonfragola" }
    for flav, flavname in pairs(flavours) do
        for dec, decname in pairs(decorations) do
            t.alcremie.names[flav .. dec] =
                table.concat({ flavname, " ", decname })
        end
    end
    t.alcremie.names["LvFa"] = nil
end

-- Anchor per i link alle forme alternative,
-- se diversi dal nome del Pokémon

t.shellos.anchor = "Shellos e Gastrodon"
t.burmy.anchor = "Burmy e Wormadam"
t.deerling.anchor = "Deerling e Sawsbuck"
t.floette.anchor = "Flabébé, Floette e Florges"
t.florges.anchor = "Flabébé, Floette e Florges"

-- Table to map extended names to abbrs

-- stylua: ignore start
t.pikachu.ext = {originale = 'O', hoenn = 'H', sinnoh = 'Si',
	unima = 'U', kalos = 'K', alola = 'A', compagni = 'Co', giramondo = 'G'}
t.pichu.ext = {spunzorek = 'S'}
t.unown.ext = {base = 'A', B = 'B', C = 'C', D = 'D', E = 'E', F = 'F',
	G = 'G', H = 'H', I = 'I', J = 'J', K = 'K', L = 'L', M = 'M', N = 'N',
	O = 'O', P = 'P', Q = 'Q', R = 'R', S = 'S', T = 'T', U = 'U', V = 'V',
	W = 'W', X = 'X', Y = 'Y', Z = 'Z', ['!'] = 'PE', ['?'] = 'PI'}
t.burmy.ext = {sabbia = 'Sa', scarti = 'Sc'}
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
t.floette.ext = {giallo = 'G', arancione = 'A', bianco = 'Bi', blu = 'Bl', eterno = 'E'}
t.florges.ext = {giallo = 'G', arancione = 'A', bianco = 'Bi', blu = 'Bl'}
t.furfrou.ext = {cuore = 'C', stella = 'St', diamante = 'D', dignorina = 'Si',
	gentildonna = 'Gd', gentiluomo = 'Gu', regina = 'R', kabuki = 'K',
	faraone = 'F'}
t.xerneas.ext = {attivo = 'A'}
t.minior.ext = {rosso = 'R', arancione = 'Ar', giallo = 'G', verde = 'Ve',
	azzurro = 'Az', indaco = 'I', violetto = 'Vi', meteora = 'base'}
t.mimikyu.ext = {smascherata = 'S'}
t.magearna.ext = {antico = 'A'}
t.cramorant.ext = {inghiottitutto = 'T', inghiottintero = 'I'}
t.sinistea.ext = {}
t.alcremie.ext = {lattevaniglia = 'base', latterosa = 'R', lattematcha = 'Ma',
	lattementa = 'Me', lattelimone = 'L', lattesale = 'S', rosamix = 'Rm',
	caramelmix = 'Cm', triplomix = 'Tm'}
t.zarude.ext = {['papà'] = 'P'}
t.dudunsparce.ext = { trimetamero = "T", bimetamero = "base" }
t.maushold.ext = { quadrifamiglia = "Q", trifamiglia = "base" }
t.tatsugiri.ext = { adagiata = "A", tesa = "T",  arcuata = "base" }
t.koraidon.ext = { integrale = "base", parziale = "P", scattante = "S", nautica = "N", librata = "L" }
t.miraidon.ext = { completo = "base", limitato = "L", sprint = "S", nuoto = "N", planata = "P" }
-- stylua: ignore end

--[[

Arrays keeping the order in which alternative forms are listed in the latest
game.

--]]

-- stylua: ignore start
t.pikachu.gamesOrder = {'base', 'O', 'H', 'Si', 'U', 'K', 'A', 'Co', 'G'}
t.pichu.gamesOrder = {'base', 'S'}
t.unown.gamesOrder = {'base', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
	'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'PE', 'PI'}
t.burmy.gamesOrder = {'base', 'Sa', 'Sc'}
t.shellos.gamesOrder = {'base', 'E'}
t.unfezant.gamesOrder = {'base', 'F'}
t.deerling.gamesOrder = {'base', 'E', 'A', 'I'}
t.frillish.gamesOrder = t.unfezant.gamesOrder
t.keldeo.gamesOrder = {'base', 'R'}
t.genesect.gamesOrder = {'base', 'I', 'V', 'P', 'G'}
t.vivillon.gamesOrder = {'base', 'No', 'Mn', 'C', 'Pr', 'E', 'Ga', 'T', 'Mr', 'A',
	'D', 'Sb', 'F', 'Pl', 'Sv', 'So', 'O', 'Gu', 'Sr', 'Po'}
t.pyroar.gamesOrder = t.unfezant.gamesOrder
t.floette.gamesOrder = {'base', 'G', 'A', 'Bl', 'Bi', 'E'}
t.florges.gamesOrder = {'base', 'G', 'A', 'Bl', 'Bi'}
t.furfrou.gamesOrder = {'base', 'C', 'St', 'Si', 'Gd', 'D', 'Gu', 'R', 'K', 'F'}
t.xerneas.gamesOrder = {'base', 'A'}
t.minior.gamesOrder = {'base', 'R', 'Ar', 'G', 'Ve', 'Az', 'I', 'Vi'}
t.mimikyu.gamesOrder = {'base', 'S'}
t.magearna.gamesOrder = {'base', 'A'}
t.cramorant.gamesOrder = {'base', 'T', 'I'}
t.sinistea.gamesOrder = {'base', 'A'}
-- Alcremie's gamesOrder is filled below, with since
t.zarude.gamesOrder = {'base', 'P'}
t.dudunsparce.gamesOrder = { "base", "T" }
t.maushold.gamesOrder = { "base", "Q" }
t.tatsugiri.gamesOrder = { "base", "A", "T" }
t.koraidon.gamesOrder = { "base", "P", "S", "N", "L" }
t.miraidon.gamesOrder = { "base", "L", "S", "N", "P" }
-- stylua: ignore end

--[[

Oldest game in which each form, included base form, appears.

--]]

-- stylua: ignore start
t.pikachu.since = {O = 'sl', H = 'sl', Si = 'sl', U = 'sl',
	K = 'sl', A = 'sl', Co = 'usul', G = 'spsc', base = 'rb'}
t.pichu.since = {S = 'hgss', base = 'oa'}
t.unown.since = {base = 'oa', B = 'oa', C = 'oa', D = 'oa', E = 'oa', F = 'oa',
	G = 'oa', H = 'oa', I = 'oa', J = 'oa', K = 'oa', L = 'oa', M = 'oa', N = 'oa',
	O = 'oa', P = 'oa', Q = 'oa', R = 'oa', S = 'oa', T = 'oa', U = 'oa', V = 'oa',
	W = 'oa', X = 'oa', Y = 'oa', Z = 'oa', PE = 'rz', PI = 'rz'}
t.burmy.since = {Sa = 'dp', Sc = 'dp', base = 'dp'}
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
t.floette.since = {G = 'xy', A = 'xy', Bi = 'xy', Bl = 'xy', E = 'xy', base = 'xy'}
t.florges.since = {G = 'xy', A = 'xy', Bi = 'xy', Bl = 'xy', base = 'xy'}
t.furfrou.since = {C = 'xy', St = 'xy', D = 'xy', Si = 'xy', Gd = 'xy',
	Gu = 'xy', R = 'xy', K = 'xy', F = 'xy', base = 'xy'}
t.xerneas.since = {A = 'xy', base = 'xy'}
t.minior.since = {base = 'sl', R = 'sl', Ar = 'sl', G = 'sl', Ve = 'sl',
	Az = 'sl', I = 'sl', Vi = 'sl'}
t.mimikyu.since = {base = 'sl', S = 'sl'}
t.magearna.since = {base = 'sl', A = 'sl'}
t.cramorant.since = {T = 'spsc', I = 'spsc', base = 'spsc'}
t.sinistea.since = {base = 'spsc', A = 'spsc'}
t.dudunsparce.since = { base = "sv", T = "sv" }
t.maushold.since = { base = "sv", Q = "sv" }
t.tatsugiri.since = { base = "sv", A = "sv", T = "sv" }
t.koraidon.since = { base = "sv", P = "sv", S = "sv", N = "sv", L = "sv" }
t.miraidon.since = { base = "sv", L = "sv", S = "sv", N = "sv", P = "sv" }
-- stylua: ignore end
-- Alcremie is quite molesto in **** pt. 2
do
    local flavours = { "Lv", "R", "Ma", "Me", "L", "S", "Rm", "Cm", "Tm" }
    local decorations = { "Fa", "C", "B", "Fo", "Fe", "S", "Fc" }

    t.alcremie.gamesOrder = {}
    t.alcremie.since = { base = "spsc" }
    for _, flav in ipairs(flavours) do
        for _, dec in ipairs(decorations) do
            local abbr = table.concat({ flav, dec })
            table.insert(t.alcremie.gamesOrder, abbr)
            t.alcremie.since[abbr] = "spsc"
        end
    end
    t.alcremie.gamesOrder[1] = "base"
    t.alcremie.since["LvFa"] = nil
end
t.zarude.since = { base = "spsc", P = "spsc" }

--[[

Tables containing the last game a form is
available, base form included. Anything
not present defaults to latest games.

--]]

t.pichu["until"] = { S = "hgss" }
t.floette["until"] = { E = "xy" }

-- Alias, messi qui per evitare inutili iterazioni dei cicli precedenti
t.gastrodon = tab.copy(t.shellos)
t.sawsbuck = tab.copy(t.deerling)
t.jellicent = tab.copy(t.frillish)
t["flabébé"] = tab.copy(t.florges)
t.polteageist = tab.copy(t.sinistea)

-- Link creation should be done AFTER copying Pokémon with same forms, in order
-- to use the right name for the link
makeLinks()

t[25] = t.pikachu
t[172] = t.pichu
t[201] = t.unown
t[412] = t.burmy
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
t[669] = t["flabébé"]
t[670] = t.floette
t[671] = t.florges
t[676] = t.furfrou
t[716] = t.xerneas
t[774] = t.minior
t[778] = t.mimikyu
t[801] = t.magearna
t[845] = t.cramorant
t[854] = t.sinistea
t[855] = t.polteageist
t[869] = t.alcremie
t[893] = t.zarude
t[982] = t.dudunsparce
t[925] = t.maushold
t[978] = t.tatsugiri
t[1007] = t.koraidon
t[1008] = t.miraidon

return t
