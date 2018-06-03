--[[

Modulo dati per i Pokémon Glitch. Di ognuno è memorizzato
l'esadecimale che ha nel gioco in cui compare, lo sprite,
il nome, i tipi e eventualmente come questi ultimi devono
essere visualizzati.

I Pokémon sono divisi per gioco o generazione, gli
esadecimali e i nomi non sono univoci nell'insieme.
Gli indici dei giochi/generazioni sono:

- RB
- G
- OA
- C
- RZS
- RFVF
- 4
- 5
- 6

--]]

local g = {}

local mw = require('mw')

-- Glitch di Rosso e Blu

g.RB = {
	{hex = 0x00, spr = 'MS Missingno I.gif', name = "'M (00)", type1 = 'Uccello', type2 = 'Normale',
			nameDisplay = "'M"},
	{hex = {0x1F, 0x20, 0x32, 0x34, 0x38, 0x3D, 0x3E, 0x3F, 0x43, 0x44,
			0x45, 0x4F, 0x50, 0x51, 0x56, 0x57, 0x5E, 0x5F, 0x73, 0x79,
			0x7A, 0x7F, 0x86, 0x87, 0x89, 0x8A, 0x92, 0x9C, 0x9F, 0xA0,
			0xA1, 0xA2, 0xAC, 0xAE, 0xAF, 0xB5, 0xB6, 0xB7, 0xB8},
			spr = 'MS Missingno I.gif', name = 'Missingno.', type1 = 'Uccello', type2 = 'Normale'},
	{hex = 0xBF, spr = 'MSRBGlitchMenu250.gif', name = '▶ A', type1 = 'Normale', type2 = 'Normale',
			typeEffectiveness = {'Normale'}},
	{hex = 0xC0, spr = 'AniMostroMS1.gif', name = 'a', type1 ='Acqua'},
	{hex = 0xC1, spr = 'AniUccelloMS1.gif', name = 'ゥ (C1)', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xC2, spr = 'AniDragoMS1.gif', name = 'ゥ .4', type1 = 'Pokémaniaco'},
	{hex = 0xC3, spr = 'AniMostroMS1.gif', name = 'h POKé', type1 = 'Spettro', type2 = 'Veleno'},
	{hex = 0xC4, spr = 'AniUccelloMS1.gif', name = 'PokéWTrainer', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xC5, spr = 'MSRBGlitchMenu250.gif', name = 'PkMn (C5)', type1 = 'Normale', type2 = 'Normale',
			typeEffectiveness = {'Glitch'}},
	{hex = 0xC6, spr = 'AniMostroMS1.gif', name = 'ゥL ゥM 4', type1 = 'Acqua', type2 = 'Lotta'},
	{hex = 0xC7, spr = 'AniUccelloMS1.gif', name = '♀Pゥ ゥゥT', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xC8, spr = 'AniDragoMS1.gif', name = 'ゥU?', type1 = 'Pokémaniaco'},
	{hex = 0xC9, spr = 'AniDragoMS1.gif', name = '◣ゥ 8', type1 = 'Roccia', type2 = 'Terra'},
	{hex = 0xCA, spr = 'AniUccelloMS1.gif', name = 'PC4SH', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xCB, spr = 'AniUccelloMS1.gif', name = 'P', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xCC, spr = 'AniMostroMS1.gif', name = 'PkMn ◣ n', type1 = 'Lotta'},
	{hex = 0xCD, spr = 'AniBallMS1.gif', name = 'Trainer (Pokémon Glitch)', type1 = 'Elettro',
			nameDisplay = 'Trainer'},

	{hex = 0xCE, spr = 'AniDragoMS1.gif', name = '▼ W G d', type1 = 'Veleno'},
	{hex = 0xCF, spr = 'AniColeotteroMS1.gif', name = 'OPkMn4X', type1 = 'Coleottero', type2 = 'Veleno'},
	{hex = 0xD0, spr = 'MSRBGlitchMenu250.gif', name = 'PkMn PkMn T', type1 = 'Normale'},
	{hex = 0xD1, spr = 'AniMostroMS1.gif', name = '4B 8 4 8', type1 = 'Acqua', type2 = 'Lotta'},
	{hex = 0xD2, spr = 'AniUccelloMS1.gif', name = "ゥ '", type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xD3, spr = 'AniDragoMS1.gif', name = "M p'u ゥ", type1 = 'Pokémaniaco'},
	{hex = 0xD4, spr = 'AniMostroMS1.gif', name = 'Aゥ G', type1 = 'Spettro', type2 = 'Veleno'},
	{hex = 0xD5, spr = 'AniUccelloMS1.gif', name = 'Pゥ ゥ ゥ', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xD6, spr = 'MSRBGlitchMenu250.gif', name = '4 h', type1 = 'Normale', type2 = 'Normale'},
	{hex = 0xD7, spr = 'AniMostroMS1.gif', name = 'Glitch (D7)', type1 = 'Acqua'},
	{hex = 0xD8, spr = 'AniUccelloMS1.gif', name = 'PkMnaPkMnゥ ♂ fPkMnk', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xD9, spr = 'AniDragoMS1.gif', name = 'PkMnRPkMn "', type1 = 'Glitch'},
	{hex = 0xDA, spr = 'AniDragoMS1.gif', name = 'B (DA)', type1 = 'Roccia', type2 = 'Terra'},
	{hex = 0xDB, spr = 'AniUccelloMS1.gif', name = 'Glitch (DB)', type1 = 'Normale', type2 = 'Terra'},
	{hex = 0xDC, spr = 'AniUccelloMS1.gif', name = 'Glitch (DC)', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xDD, spr = 'AniSurfMS1.gif', name = "7PkMn 'v", type1 = 'Acqua', type2 = 'Veleno'},
	{hex = 0xDE, spr = 'AniBallMS1.gif', name = '-PkMn', type1 = 'Elettro'},
	{hex = 0xDF, spr = 'MSRBGlitchMenu250.gif', name = '.PkMn', type1 = 'Normale', type2 = 'Normale'},
	{hex = 0xE0, spr = 'AniUccelloMS1.gif', name = 'PkMn ▼PkMn', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xE1, spr = 'AniUccelloMS1.gif', name = "'v", type1 = 'Glitch'},
	{hex = 0xE2, spr = 'AniMuccaMS1.gif', name = '……', type1 = 'Glitch', type2 = 'L'},
	{hex = 0xE3, spr = 'AniFioreMS1.gif', name = 'ゥ (E3)',
			type1 = "(Classe dell'ultimo allenatore affrontato)",
			type2 = "(Classe dell'ultimo allenatore affrontato)",
			type1Display = 'Glitch', type2Display = 'Glitch'},
	{hex = 0xE4, spr = 'AniBallMS1.gif', name = 'Glitch (E4)', type1 = 'Coleottero'},
	{hex = 0xE5, spr = 'AniMuccaMS1.gif', name = 'C (maiuscolo)', type1 = 'Glitch',
			nameDisplay = 'C'},
	{hex = 0xE6, spr = 'AniFioreMS1.gif', name = '- -', type1 = 'Glitch'},
	{hex = 0xE7, spr = 'AniClefairyMS1.gif', name = 'Pゥ 4$', type1 = 'Lotta', type2 = 'Glitch'},
	{hex = 0xE8, spr = 'AniMuccaMS1.gif', name = 'X C', type1 = "' ♀ ♀ ' 2222 37572",
			type1Display = 'Glitch'},
	{hex = 0xE9, spr = 'AniBallMS1.gif', name = 'c (minuscolo)', type1 = 'Coleottero',
			nameDisplay = 'c'},
	{hex = 0xEA, spr = 'AniDragoMS1.gif', name = 'A (EA)', type1 = 'Pokémaniaco'},
	{hex = 0xEB, spr = 'AniUccelloMS1.gif', name = 'Glitch (EB)', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xEC, spr = 'AniUccelloMS1.gif', name = 'Glitch (EC)', type1 = 'Glitch', type2 = 'Normale'},
	{hex = 0xED, spr = 'AniMostroMS1.gif', name = 'hゥ', type1 = 'Glitch', type2 = 'Glitch'},
	{hex = 0xEE, spr = 'AniBallMS1.gif', name = '.g', type1 = 'Coleottero', type2 = 'Glitch'},
	{hex = 0xEF, spr = 'AniMostroMS1.gif', name = "ゥ$'M", type1 = 'Glitch', type2 = 'Glitch'},
	{hex = 0xF0, spr = 'AniClefairyMS1.gif', name = 'ゥ$ (F0)', type1 = 'Lotta'},
	{hex = 0xF1, spr = 'AniMostroMS1.gif', name = '94', type1 = 'Normale', type2 = 'Spettro'},
	{hex = 0xF2, spr = 'AniUccelloMS1.gif', name = 'ゥ l (F2)', type1 = 'Volante', type2 = 'Glitch'},
	{hex = 0xF3, spr = 'AniClefairyMS1.gif', name = 'ゥ l (F3)', type1 = 'Elettro'},
	{hex = 0xF4, spr = 'AniDragoMS1.gif', name = 'ゥ$ (F4)', type1 = 'Poké BB'},
	{hex = 0xF5, spr = 'AniFioreMS1.gif', name = 'ゥ (F5)', type1 = 'Glitch', type2 = 'Glitch'},
	{hex = 0xF6, spr = 'AniClefairyMS1.gif', name = "G'Mp", type1 = 'Normale'},
	{hex = 0xF7, spr = 'AniUccelloMS1.gif', name = "'Ng'Mp", type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xF8, spr = 'AniMuccaMS1.gif', name = "'Ng ゥ$", type1 = 'Normale'},
	{hex = 0xF9, spr = 'AniMostroMS1.gif', name = '94 h', type1 = 'Normale', type2 = 'Spettro'},
	{hex = 0xFA, spr = 'AniMostroMS1.gif', name = 'Glitch (FA)', type1 = 'Veleno'},
	{hex = 0xFB, spr = 'AniDragoMS1.gif', name = "'M'Ng", type1 = 'Roccia', type2 = 'Terra'},
	{hex = 0xFC, spr = 'AniBallMS1.gif', name = 'O (Pokémon glitch)', type1 = 'Elettro',
			nameDisplay = 'O'},
	{hex = 0xFD, spr = 'AniMuccaMS1.gif', name = 'ゥ$6ゥ', type1 = 'Elettro'},
	{hex = 0xFE, spr = 'AniMuccaMS1.gif', name = "'M (FE)", type1 = 'Acqua', type2 = 'Psico'},
	{hex = 0xFF, spr = 'Nessuno Sprite Zaino.png', name = "'M (FF)", type1 = 'Fuoco', type2 = 'Volante'}
}

-- Glitch di Giallo

g.G = {
	{hex = 0x00, spr = '3TrainerPoké $ menu.png', name = '3TrainerPoké $', type1 = 'Glitch', type2 = 'Normale'},
	{hex = g.RB[2].hex, spr = 'MSRBGlitchMenu250.gif', name = 'Missingno.', type1 = 'Normale',
			type2 = '999', nameDisplay = 'Missingno.#Forma Pokémon Giallo'},
	{hex = 0xBF, spr = 'YGlitchMenu250.gif', name = '4 4', type1 = '999', type2 = 'Normale'},
	{hex = 0xC0, spr = 'AniMostroMS1.gif', name = '4 4Hy', type1 = 'Acqua', type2 = 'Psico'},
	{hex = 0xC1, spr = 'AniUccelloMS1.gif', name = '♀ .', type1 = 'Normale', type2 = 'Normale'},
	{hex = 0xC2, spr = 'AniUccelloMS1.gif', name = "pPkMnp' '", type1 = '?', type2 = 'Veleno'},
	{hex = 0xC3, spr = 'AniColeotteroMS1.gif', name = 'ゥ ( Z4', type1 = 'Coleottero', type2 = 'Veleno'},
	{hex = 0xC4, spr = 'AniFossileMS1.gif', name = 'X ゥ- xゥ,', type1 = 'Glitch', type2 = 'Normale'},
	{hex = 0xC5, spr = 'AniMostroMS1.gif', name = '4. .', type1 = 'Acqua'},
	{hex = 0xC6, spr = 'AniMuccaMS1.gif', name = 'ァ7g', type1 = 'Acqua', type2 = 'Psico'},
	{hex = 0xC7, spr = 'AniMostroMS1.gif', name = 'u', type1 = 'Fuoco', type2 = 'Volante'},
	{hex = 0xC8, spr = 'MSRBGlitchMenu250.gif', name = 'g g', type1 = 'Normale'},
	{hex = 0xC9, spr = 'AniMostroMS1.gif', name = 'ァ / g J 1', type1 = 'Veleno'},
	{hex = 0xCA, spr = 'AniMostroMS1.gif', name = 'Glitch (CA)', type1 = 'Veleno'},
	{hex = 0xCB, spr = 'AniBallMS1.gif', name = '. pゥ', type1 = 'Elettro'},
	{hex = 0xCC, spr = 'AniSurfMS1.gif', name = '.8', type1 = 'Acqua'},
	{hex = 0xCD, spr = 'AniSurfMS1.gif', name = 'ゥ. B', type1 = 'Acqua'},
	{hex = 0xCE, spr = 'AniSurfMS1.gif', name = 'PkMn pゥぁ ゥぇ (CE)', type1 = 'Acqua'},
	{hex = 0xCF, spr = 'AniSurfMS1.gif', name = '4, ゥァ (CF)', type1 = 'Acqua'},
	{hex = 0xD0, spr = 'AniMostroMS1.gif', name = "ゥ'", type1 = 'Spettro', type2 = 'Veleno'},
	{hex = 0xD1, spr = 'AniUccelloMS1.gif', name = 'B ァ h', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xD2, spr = 'AniMostroMS1.gif', name = 'PkMn ? A', type1 = 'Veleno'},
	{hex = 0xD3, spr = 'AniMuccaMS1.gif', name = 'ゥゥ)', type1 = 'Normale',
			nameDisplay = 'ゥゥ]'},
	{hex = 0xD4, spr = 'AniMostroMS1.gif', name = 'ゥ (D4)', type1 = 'Normale'},
	{hex = 0xD5, spr = 'AniFioreMS1.gif', name = "'ゥ.", type1 = 'Erba', type2 = 'Veleno'},
	{hex = 0xC6, spr = 'AniMostroMS1.gif', name = 'PkMn pゥぁ ゥぇ (D6)', type1 = 'Fuoco'},
	{hex = 0xD7, spr = 'AniUccelloMS1.gif', name = 'B (D7)', type1 = 'Glitch'},
	{hex = 0XD8, spr = 'AniUccelloMS1.gif', name = 'PkMn (D8)', type1 = 'Glitch'},
	{hex = 0xD9, spr = 'AniDragoMS1.gif', name = 'ゥ (D9)', type1 = 'IIIItoto', type2 = '999'},
	{hex = 0xDA, spr = 'AniUccelloMS1.gif', name = ')', type1 = 'Normale', type2 = 'Volante',
			nameDisplay = ']'},
	{hex = 0xDB, spr = 'YGlitchMenu250.gif', name = "ゥ' B", type1 = 'Glitch', type2 = 'Normale'},
	{hex = 0xDc, spr = 'AniDragoMS1.gif', name = 'PkMn (DC)', type1 = 'Normale', type2 = 'Glitch'},
	{hex = 0xDD, spr = 'AniUccelloMS1.gif', name = '4, ゥァ (DD)', type1 = 'Spettro', type2 = 'Normale'},
	{hex = 0XDE, spr = 'AniMuccaMS1.gif', name = '8 (DE)', type1 = 'Fuoco', type2Display = 'Glitch',
			type2 = "(Classe dell'ultimo allenatore affrontato)"},
	{hex = 0xDF, spr = 'AniMostroMS1.gif', name = 'p ID', type1 = 'Acqua', type2 = 'Lotta'},
	{hex = 0xE0, spr = 'AniFioreMS1.gif', name = '8 P ァ', type1 = 'Normale', type2 = 'Normale'},
	{hex = 0xE1, spr = 'AniDragoMS1.gif', name = "'r 'r 4", type1 = 'Lotta'},
	{hex = 0xE2, spr = 'AniDragoMS1.gif', name = '(h4to89', type1 = 'Normale', type2 = 'Glitch'},
	{hex = 0xE3, spr = 'AniUccelloMS1.gif', name = '4 89 4', type1 = 'Spettro', type2 = 'Normale'},
	{hex = 0xE4, spr = 'YGlitchMenu250.gif', name = '8B 4 8', type1 = 'Glitch', type2 = 'Normale'},
	{hex = 0xE5, spr = 'AniMostroMS1.gif', name = 'Z ゥ', type1 = 'Normale'},
	{hex = 0xE6, spr = 'AniMostroMS1.gif', name = '9 (Pokémon glitch)', type1 = 'Normale',
			type2 = 'Normale', nameDisplay = '9', typeEffectiveness = {'Glitch'}},
	{hex = 0xE7, spr = 'AniFossileMS1.gif', name = 'ゥHIゥ.', type1 = 'Glitch', type2 = 'Normale'},
	{hex = 0xE8, spr = 'AniSurfMS1.gif', name = '4(h4hi?$', type1 = 'Acqua'},
	{hex = 0xE9, spr = 'AniMostroMS1.gif', name = '4HI?', type1 = 'Veleno'},
	{hex = 0xEA, spr = 'AniMostroMS1.gif', name = "'r ゥ", type1 = 'Normale'},
	{hex = 0xEB, spr = 'AniBallMS1.gif', name = '$ Pゥ. 4(', type1 = 'Normale'},
	{hex = 0xEC, spr = 'AniUccelloMS1.gif', name = '? (EC)', type1 = 'Normale', type2 = 'Volante',
			nameDisplay = '?/'},
	{hex = 0xED, spr = 'AniMostroMS1.gif', name = '4(h4?', type1 = 'Normale'},
	{hex = 0xEE, spr = 'AniBallMS1.gif', name = 'ゥ► ゥ▼ ゥ', type1 = 'Normale'},
	{hex = 0xEF, spr = 'AniClefairyMS1.gif', name = 'h 4Pゥ ゥ...', type1 = 'Normale'},
	{hex = 0xF0, spr = 'AniMostroMS1.gif', name = ". ゥ ( .I' .", type1 = 'Fuoco', type2 = 'Volante'},
	{hex = 0xF1, spr = 'AniMostroMS1.gif', name = "' B' ゥ", type1 = 'Veleno'},
	{hex = 0xF2, spr = 'AniColeotteroMS1.gif', name = 'ゥ ゥェ ゥ ▷', type1 = 'Coleottero', type2 = 'Glitch'},
	{hex = 0xF3, spr = 'AniBallMS1.gif', name = 'ゥ $ A (F3)', type1 = 'Normale', type2 = 'Glitch'},
	{hex = 0xF4, spr = 'AniUccelloMS1.gif', name = '♂ p ゥ', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xF5, spr = 'AniMostroMS1.gif', name = '▼ pゥ', type1 = 'Normale'},
	{hex = 0xF6, spr = 'AniBallMS1.gif', name = 'ゥ $ A (F6)', type1 = 'Normale'},
	{hex = 0xF7, spr = 'AniFioreMS1.gif', name = 'PkMn (F7)', type1 = 'Erba', type2 = 'Veleno'},
	{hex = 0xF8, spr = 'AniUccelloMS1.gif', name = 'ゥ 4ぁ 4', type1 = 'Ghiaccio', type2 = 'Volante'},
	{hex = 0xF9, spr = 'YGlitchMenu250.gif', name = '$ (Pokémon glitch)', type1 = 'Glitch',
			nameDisplay = '$'},
	{hex = 0xFA, spr = 'AniMostroMS1.gif', name = 'ゥ▾ ゥ♂', type1 = 'Fuoco'},
	{hex = 0xFB, spr = 'AniUccelloMS1.gif', name = 'F q,', type1 = 'Normale', type2 = 'Volante'},
	{hex = 0xFC, spr = 'AniFioreMS1.gif', name = 'ゥ$ 4Mnゥ', type1 = 'Erba', type2 = 'Veleno'},
	{hex = 0xFD, spr = 'AniMostroMS1.gif', name = "x 'rゥ.4-", type1 = 'Terra'},
	{hex = 0xFE, spr = 'AniColeotteroMS1.gif', name = 'ゥ 4ァ 4,', type1 = 'Coleottero',
			nameDisplay = 'ゥ/ 4ァ 4,'},
	{hex = 0xFF, spr = 'Nessuno Sprite Zaino.png', name = 'Q◣', type1 = 'Acqua', type2 = 'Psico'}
}

-- Glitch di Oro e Argento

g.OA = {
	{hex = 0x00, spr = 'AniGlitchMS2.gif', name = '????? (00)', type1 = 'Acciaio',
		type2 = 'Glitch'},
	{hex = 0xFC, spr = 'AniGlitchMS2.gif', name = '????? (FC)', type1 = 'Psico',
		type2 = 'Glitch'},
	{hex = 0xFD, spr = 'AniUovoMS2.gif', name = 'Uovo Glitch', type1 = '???'},
	{hex = 0xFE, spr = 'AniGlitchMS2.gif', name = '????? (FE)', type1 = 'B'},
	{hex = 0xFF, spr = 'AniGlitchMS2.gif', name = '????? (FF)', type1 = "'l) m) ZM",
			type2 = 'Normale (glitch)', type2Display = 'Normale'},
	{hex = '??', spr = 'AniUnownMS2.gif', name = 'Unown Glitch', type1 = '???'}
}

--[[

Glitch di Cristallo: differiscono da quelli di Oro e Argento
per due soli Pokémon, di cui cambiano solo i tipi

--]]

g.C = mw.clone(g.OA)
table.remove(g.C, 4)
table.remove(g.C, 5)
table.insert(g.C, 4, {hex = 0xFE, spr = 'AniGlitchMS2.gif', name = '????? (FE)',
		type1 = 'Normale (glitch)', type1Display = 'Normale',
		type2 = 'Normale (glitch)', type2Display = 'Normale'})
table.insert(g.C, 5, {hex = 0xFF, spr = 'AniGlitchMS2.gif', name = '????? (FF)',
		type1 = 'Normale (glitch)', type1Display = 'Normale',
		type2 = 'Normale (glitch)', type2Display = 'Normale'})

-- Glitch di Rubino, Zaffiro e Smeraldo

g.RZS = {
	{hex = {0x0000}, spr = 'Ani900MS.png', name = '??????????', type1 = 'Normale'},
	{hex = 0x019C, spr = 'AniUovoMS.gif', name = '-', type1 = 'Grinta', type2 = 'Grazia',
			nameDisplay = '- (Pokémon Glitch)'},
	{hex = {0x00FC}, spr = '000MS5.png', name = '?', type1 = 'Normale',
			nameDisplay = '? (Pokémon Glitch)'},
	{hex = '???', spr = 'AniUovoMS.gif', name = 'Uovo Peste', type1 = 'Sconosciuto'}
}

for hex = 0x19D, 0xFFFF do
	table.insert(g.RZS[1].hex, hex)
end
for hex = 0x00FD, 0x0114 do
	table.insert(g.RZS[3].hex, hex)
end

--[[

Glitch di Rosso Fuoco e Verde Foglia: differiscono da quelli
di Rubino, Zaffiro e Smeraldo per un solo Pokémon.

--]]

g.RFVF = mw.clone(g.RZS)
table.remove(g.RFVF, 2)
table.insert(g.RFVF, 2, {hex = 0x019C, spr = 'Nessuno Sprite Zaino.png',
		name = 'óË e Ái', type1 = 'Sconosciuto'})

-- Glitch di quarta generazione

g[4] = {
	{hex = 0x0000, spr = '000MS5.png', name = '-----', type1 = 'Normale'},
	{hex = {0x8000}, spr = 'Vari', name = 'Ibrido di quarta generazione', type1 = 'Glitch'},
	{hex = '???', spr = 'UovoMS.gif', name = 'Uovo Peste', type1 = 'Normale'}
}

for hex = 0x8001, 0x81ED do
	table.insert(g[4][2].hex, hex)
end

-- Glitch di quinta generazione

g[5] = {
	{hex = 0x0000, spr = '000MS5.png', name = '-----', type1 = 'Normale'},
	{hex = '???', spr = 'UovoMS.gif', name = 'Uovo Peste', type1 = 'Normale'}
}

-- Glitch di sesta generazione

g[6] = {
	{hex = '???', spr = 'Uovo Peste Sprite Zaino.png', name = 'Uovo Peste',
			type1 = 'Normale', nameDisplay = 'Uovo Mistero'},
	{hex = {0x02D4}, spr = 'XYCaricamentoMS.png', name = 'Pokémon Glitch 724+',
			type1 = 'Normale'}
}

for hex = 0x02D5, 0xFFFF do
	table.insert(g[6][2].hex, hex)
end

return g
