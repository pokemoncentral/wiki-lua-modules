-- Tabelle dati di utilità generale

local t = {}

-- Numero totale dei Pokémon

t.pokeNum = 905
t.poke_num = t.pokeNum

--[[

Table containig the list of colors so dark that require white text when used
as background.
The variant taken into account is normale

--]]
-- stylua: ignore
t.whitetext = {'b', 'blu', 'pmdb', 'mdblu', 'md_blu', 'pmdo', 'mdoscurita',
	'md_oscurita', 'pmdpsi', 'mdportali', 'md_portali', 'pmdr', 'mdrosso',
	'md_rosso', 'pmdt', 'mdtempo', 'md_tempo', 'n', 'nero', 'n2', 'nero 2',
	'nero2', 'nero_2', 'osa', 'ra', 'ranger', 'r', 'rosso', 'ru', 'rubino',
	'ro', 'rubino omega', 'rubinoomega', 'rubino_omega', 's', 'smeraldo', 'x',
	'y', 'xd', 'z', 'zaffiro', 'za', 'zaffiro alpha', 'zaffiroalpha',
	'zaffiro_alpha', 'l', 'luna', 'ul', 'ultraluna', 'lge', 'lgeevee',
	'lg_eevee', 'sc', 'scudo', 'lc', 'landacorona', 'cpm', 'club pokémiglia',
	'club_pokémiglia', 'pw', 'pokewalker', 'pokéwalker', '000', '000000'}

-- Ndex e nomi dei Pokémon esclusivamente femmina
-- stylua: ignore
t.onlyFemales = {29, 30, 31, 113, 115, 124, 238, 241, 242, 314, 380,
	413, 416, 440, 478, 488, 548, 549, 629, 630, 669, 670, 671, 758, 761,
	762, 763, 856, 857, 858, 868, 869, 905,
	'alcremie', 'blissey', 'bounsweet', 'chansey', 'cresselia', 'enamorus',
	'flabébé', 'floette', 'florges', 'froslass', 'happiny', 'hatenna',
	'hattrem', 'hatterene', 'illumise', 'jynx', 'kangaskhan', 'latias',
	'lilligant', 'mandibuzz', 'milcery', 'miltank', 'nidoqueen', 'nidoran♀',
	'nidorina', 'petilil', 'salazzle', 'smoochum', 'steenee', 'tsareena',
	'vespiquen', 'vullaby', 'wormadam'}

t.only_females, t.onlyfemales = t.onlyFemales, t.onlyFemales

--[[

Ndex e nomi dei Pokémon che hanno differenze tra i due generi non
sufficientemente vistose da avere un mini sprite diverso

--]]
-- stylua: ignore
t.alsoFemales = {3, 12, 19, 20, 25, 26, 41, 42, 44, 45, 64, 65, 84, 85, 97,
	111, 112, 118, 119, 123, 129, 130, 154, 165, 166, 178, 185, 186, 190, 194,
	195, 198, 202, 203, 207, 208, 212, 214, 215, 217, 221, 224, 229, 232, 255,
	256, 257, 267, 269, 272, 274, 275, 307, 308, 315, 316, 317, 322, 323, 332,
	350, 369, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 407, 415, 417,
	418, 419, 424, 443, 444, 445, 449, 450, 453, 454, 456, 457, 459, 460, 461,
	464, 465, 473, 'abomasnow', 'aipom', 'alakazam', 'ambipom', 'beautifly',
	'bibarel', 'bidoof', 'blaziken', 'buizel', 'butterfree', 'cacturne',
	'camerupt', 'combee', 'combusken', 'croagunk', 'dodrio', 'doduo',
	'donphan', 'dustox', 'finneon', 'floatzel', 'gabite', 'garchomp', 'gible',
	'girafarig', 'gligar', 'gloom', 'golbat', 'goldeen', 'gulpin', 'gyarados',
	'heracross', 'hippopotas', 'hippowdon', 'houndoom', 'hypno', 'kadabra',
	'kricketot', 'kricketune', 'ledian', 'ledyba', 'ludicolo', 'lumineon',
	'luxio', 'luxray', 'magikarp', 'mamoswine', 'medicham', 'meditite',
	'meganium', 'milotic', 'murkrow', 'numel', 'nuzleaf', 'octillery',
	'pachirisu', 'pichu', 'pikachu', 'piloswine', 'politoed', 'quagsire',
	'raichu', 'raticate', 'rattata', 'relicanth', 'rhydon', 'rhyhorn',
	'rhyperior', 'roselia', 'roserade', 'scizor', 'scyther', 'seaking',
	'shiftry', 'shinx', 'sneasel', 'snover', 'staraptor', 'staravia', 'starly',
	'steelix', 'sudowoodo', 'swalot', 'tangrowth', 'torchic', 'toxicroak',
	'ursaring', 'venusaur', 'vileplume', 'weavile', 'wobbuffet', 'wooper',
	'xatu', 'zubat'}

t.femalesToo, t.also_females, t.alsofemales =
    t.alsoFemales, t.alsoFemales, t.alsoFemales

--[[

Sigle in minuscolo dei giochi della serie principale in ordine di
pubblicazione: verde è inserito dopo rosso e blu così da non dare
problemi nel caso in cui sia inserito, nonostante non sia uscito fuori
dal Giappone

--]]
-- stylua: ignore
t.gamesChron = {'rb', 'v', 'g', 'oa', 'c', 'rz', 'rfvf', 's', 'dp', 'pt',
	'hgss', 'nb', 'n2b2', 'xy', 'roza', 'sl', 'usul', 'spsc', 'dlps', 'lpa',
	'sv'}

t.gamesOrder = t.gamesChron

--[[

Tabella contenente i tipi in rodine alfabetico.
Contiene 'coleot' e non 'coleottero' perché la maggior parte
delle volte il tipo è abbreviato

--]]
-- stylua: ignore
t.allTypes = {'acciaio', 'acqua', 'buio', 'coleot', 'drago',
		'elettro', 'erba', 'folletto', 'fuoco', 'ghiaccio',
		'lotta', 'normale', 'psico', 'roccia', 'spettro',
		'terra', 'veleno', 'volante'}

t.types, t.all_types = t.allTypes, t.allTypes

--[[

Tables of all the egg groups in alphabetic order.

--]]
-- stylua: ignore
t.allGroups = {'erba', 'coleottero', 'volante', 'umanoide',
	'minerale', 'amorfo', 'campo', 'acqua 1', 'acqua 2',
	'acqua 3', 'mostro', 'magico', 'drago', 'ditto',
	'sconosciuto'}

t.types, t.all_types = t.allTypes, t.allTypes

-- Tabella sostitutiva dei template {{male}} e {{female}}

t.genders = {
    male = '<span style="color:#0000FF;">♂</span>',
    female = '<span style="color:#FF6060;">♀</span>',
}
t.genders["♂"] = t.genders.male
t.genders["♀"] = t.genders.female

-- Misc data about statistics

t.statsOrder = { "hp", "atk", "def", "spatk", "spdef", "spec", "spe" }

return t
