-- Modulo contenente dati utili per le sigle dei giochi

local x = {}

--[[

Ogni sigla ha associata una table per ogni link da
visualizzare. Tale table ha la seguente struttura:

- All'indice link il titolo della pagina
        (senza Pokémon davanti per brevità)
- All'indice text il testo da visualizzare nel link
        (opzionale, default all'indice link)
- All'indice display una table di coppie:
    - primo elemento: sigla del gioco
    - secondo elemento: colore del gioco

--]]

x.R = {{
    link = 'Pokémon Rosso e Blu',
    text = 'Rosso',
    display = {
        {'R', 'rosso'}
    }
}}
x.B = {{
	link = 'Pokémon Rosso e Blu',
	text = 'Blu',
	display = {
		{'B', 'blu'}
	}
}}
x.V = {{
	link = 'Pokémon Rosso e Verde',
	text = 'Verde',
	display = {
		{'V', 'verde'}
	}
}}
x.G = {{
    link = 'Pokémon Giallo',
    display = {
        {'G', 'giallo'}
    }
}}
x.Bj = {{
    link = 'Pokémon Blu (Giappone)',
    text = 'Blu',
    display = {
        {'B', 'blu'}
    }
}}
x.RB = {{
    link = 'Pokémon Rosso e Blu',
    display = {
        {'R', 'rosso'},
        {'B', 'blu'}
    }
}}
x.RV = {{
    link = 'Pokémon Rosso e Verde',
    display = {
        {'R', 'rosso'},
        {'V', 'verde'}
    }
}}
x.RBG = {
{
    link = 'Pokémon Rosso e Blu',
    text = 'Rosso, Blu',
    display = {
        {'R', 'rosso'},
        {'B', 'blu'}
    }
}, x.G[1]}
x.RVBG = {x.RBG[1], x.Bj[1], x.G[1]}
x.O = {{
	link = 'Pokémon Oro e Argento',
	text = 'Oro',
	display = {
		{'O', 'oro'}
	}
}}
x.A = {{
	link = 'Pokémon Oro e Argento',
	text = 'Argento',
	display = {
		{'A', 'argento'}
	}
}}
x.C = {{
    link = 'Pokémon Cristallo',
    display = {
        {'C', 'cristallo'}
    }
}}
x.OA = {{
    link = 'Pokémon Oro e Argento',
    display = {
        {'O', 'oro'},
        {'A', 'argento'}
    }
}}
x.OAC = {
{
    link = 'Pokémon Oro e Argento',
    text = 'Oro, Argento',
    display = {
        {'O', 'oro'},
        {'A', 'argento'}
    }
}, x.C[1]}
x.Ru = {{
	link = 'Pokémon Rubino e Zaffiro',
	text = 'Rubino',
	display = {
		{'R', 'rubino'}
	}
}}
x.RU = x.Ru
x.Z = {{
	link = 'Pokémon Rubino e Zaffiro',
	text = 'Zaffiro',
	display = {
		{'Z', 'zaffiro'}
	}
}}
x.S = {{
    link = 'Pokémon Smeraldo',
    display = {
        {'S', 'smeraldo'}
    }
}}
x.Sm, x.SM = x.S, x.S
x.RZ = {{
    link = 'Pokémon Rubino e Zaffiro',
    display = {
        {'R', 'rubino'},
        {'Z', 'zaffiro'}
    }
}}
x.RuZa, x.RUZA = x.RZ, x.RZ
x.RZS = {
{
    link = 'Pokémon Rubino e Zaffiro',
    text = 'Rubino, Zaffiro',
    display = {
        {'R', 'rubino'},
        {'Z', 'zaffiro'}
    }
}, x.S[1]}
x.RuZaSm, x.RUZASM = x.RZS, x.RZS
x.RS = {x.Ru[1], x.S[1]}
x.RuS, x.RUS = x.RS, x.RS
x.ZS = {x.Z[1], x.S[1]}
x.RF = {{
	link = 'Pokémon Rosso Fuoco e Verde Foglia',
	text = 'Rosso Fuoco',
	display = {
		{'RF', 'rossofuoco'}
	}
}}
x.VF = {{
	link = 'Pokémon Rosso Fuoco e Verde Foglia',
	text = 'Verde Foglia',
	display = {
		{'VF', 'verdefoglia'}
	}
}}
x.RFVF = {{
	link = 'Pokémon Rosso Fuoco e Verde Foglia',
	display = {
		{'RF', 'rossofuoco'},
        {'VF', 'verdefoglia'}
	}
}}
x.RZSRFVF = {x.RZS[1], x.S[1], x.RFVF[1]}
x.RuZaSmRFVF, x.RUZASMRFVF = x.RZSRFVF, x.RZSRFVF
x.RBGRFVF = {x.RBG[1], x.G[1], x.RFVF[1]}
x.SRFVF = {x.S[1], x.RFVF[1]}
-- x.SMRFVF, x.RFVFS = x.SRFVF, x.SRFVF
x.D = {{
	link = 'Pokémon Diamante e Perla',
	text = 'Diamante',
	display = {
		{'D', 'diamante'}
	}
}}
x.P = {{
	link = 'Pokémon Diamante e Perla',
	text = 'Perla',
	display = {
		{'P', 'perla'}
	}
}}
x.Pt = {{
    link = 'Pokémon Platino',
    display = {
		{'Pt', 'platino'}
    }
}}
x.PT = x.Pt
x.DP = {{
    link = 'Pokémon Diamante e Perla',
    display = {
		{'D', 'diamante'},
		{'P', 'perla'}
    }
}}
x.DPPt = {
{
	link = 'Pokémon Diamante e Perla',
	text = 'Diamante, Perla',
	display = {
		{'D', 'diamante'},
		{'P', 'perla'}
	}
}, x.Pt[1]}
x.DPP, x.DPPT = x.DPPt, x.DPPt
x.DPt = {x.D[1], x.Pt[1]}
x.DPT = x.DPt
x.PPt = {x.P[1], x.Pt[1]}
x.PPT = x.PPt
x.HG = {{
	link = 'Pokémon Oro HeartGold e Argento SoulSilver',
	text = 'Oro HeartGold',
	display = {
		{'HG', 'heartgold'}
	}
}}
x.SS = {{
	link = 'Pokémon Oro HeartGold e Argento SoulSilver',
	text = 'Argento SoulSilver',
	display = {
		{'SS', 'soulsilver'}
	}
}}
x.HGSS = {{
	link = 'Pokémon Oro HeartGold e Argento SoulSilver',
	display = {
		{'HG', 'heartgold'},
		{'SS', 'soulsilver'}
	}
}}
x.DHGSS = {x.D[1], x.HGSS[1]}
x.PHGSS = {x.P[1], x.HGSS[1]}
x.DPPtHGSS = {x.DPPt[1], x.Pt[1], x.HGSS[1]}
x.DPPHGSS, x.DPPTHGSS = x.DPPtHGSS, x.DPPtHGSS
x.PtHGSS = {x.Pt[1], x.HGSS[1]}
x.PTHGSS = x.PtHGSS
x.OHG = {x.O[1], x.HG[1]}
x.ASS = {x.A[1], x.SS[1]}
x.OCHG = {x.O[1], x.C[1], x.HG[1]}
x.OACSS = {x.OAC[1], x.C[1], x.SS[1]}
x.CHGSS = {x.C[1], x.HGSS[1]}
x.OACHGSS = {x.OAC[1], x.C[1], x.HGSS[1]}
x.RFVFHGSS = {
{
	link = 'Pokémon Rosso Fuoco e Verde Foglia',
	text = 'Rosso Fuoco, Verde Foglia',
	display = {
		{'RF', 'rossofuoco'},
        {'VF', 'verdefoglia'}
	}
}, x.HGSS[1]}
x.OACRFVFHGSS = {x.OAC[1], x.C[1], x.RFVFHGSS[1], x.HGSS[1]}
x.N = {{
	link = 'Pokémon Nero e Bianco',
	text = 'Nero',
	display = {
		{'N', 'nero'}
	}
}}
x.Bi = {{
	link = 'Pokémon Nero e Bianco',
	text = 'Bianco',
	display = {
		{'B', 'bianco'}
	}
}}
x.BI = x.Bi
x.NB = {{
	link = 'Pokémon Nero e Bianco',
	display = {
		{'N', 'nero'},
		{'B', 'bianco'}
	}
}}
x.NeBi, x.NEBI = x.NB, x.NB
x.N2 = {{
	link = 'Pokémon Nero 2 e Bianco 2',
	text = 'Nero 2',
	display = {
		{'N2', 'nero2'}
	}
}}
x.B2 = {{
	link = 'Pokémon Nero 2 e Bianco 2',
	text = 'Bianco 2',
	display = {
		{'B2', 'bianco2'}
	}
}}
x.N2B2 = {{
	link = 'Pokémon Nero 2 e Bianco 2',
	display = {
		{'N2', 'nero2'},
		{'B2', 'bianco2'}
	}
}}
x.NN2 = {x.N[1], x.N2[1]}
x.BB2 = {x.Bi[1], x.B2[1]}
x.NBN2B2 = {
{
	link = 'Pokémon Nero e Bianco',
	text = 'Nero, Bianco',
	display = {
		{'N', 'nero'},
		{'B', 'bianco'}
	}
}, x.N2B2[1]}
x.X = {{
	link = 'Pokémon X e Y',
	text = 'X',
	display = {
		{'X', 'x'}
	}
}}
x.Y = {{
	link = 'Pokémon X e Y',
	text = 'Y',
	display = {
		{'Y', 'y'}
	}
}}
x.XY = {{
    link = 'Pokémon X e Y',
    display = {
	{'X', 'x'},
	{'Y', 'y'}
    }
}}
x.RO = {{
	link = 'Pokémon Rubino Omega e Zaffiro Alpha',
	text = 'Rubino Omega',
	display = {
		{'RΩ', 'rubinoomega'}
	}
}}
x.ZA = {{
	link = 'Pokémon Rubino Omega e Zaffiro Alpha',
	text = 'Zaffiro Alpha',
	display = {
		{'Zα', 'zaffiroalpha'}
	}
}}
x.ROZA = {{
    link = 'Pokémon Rubino Omega e Zaffiro Alpha',
    display = {
	{'RΩ', 'rubinoomega'},
	{'Zα', 'zaffiroalpha'}
    }
}}
x.XYROZA = {
{
    link = 'Pokémon X e Y',
    text = 'X, Y',
    display = {
	{'X', 'x'},
	{'Y', 'y'}
    }
}, x.ROZA[1]}
x.RRO = {x.Ru[1], x.RO[1]}
x.ZZA = {x.Z[1], x.ZA[1]}
x.RZROZA = {x.RZS[1], x.ROZA[1]}
x.SROZA = {x.S[1], x.ROZA[1]}
x.RSRO = {x.Ru[1], x.S[1], x.RO[1]}
x.ZSZA = {x.Z[1], x.S[1], x.ZA[1]}
x.RZSROZA = {x.RZS[1], x.S[1], x.ROZA[1]}
x.DemoROZA = {{
    link = 'Pokémon Rubino Omega e Zaffiro Alpha Versione Demo Speciale',
    display = {
		{'Demo'},
		{'RΩ', 'rubinoomega'},
		{'Zα', 'zaffiroalpha'},
    }
}}
x.So = {{
	link = 'Pokémon Sole e Luna',
	text = 'Sole',
	display = {
		{'S', 'sole'}
	}
}}
x.SO = x.So
x.L = {{
	link = 'Pokémon Sole e Luna',
	text = 'Luna',
	display = {
		{'L', 'luna'}
	}
}}
x.SL = {{
    link = 'Pokémon Sole e Luna',
    display = {
		{'S', 'sole'},
		{'L', 'luna'}
    }
}}
x.DemoSL = {{
    link = 'Pokémon Sole e Pokémon Luna: Versione demo speciale',
    text = 'Sole e Luna: Versione demo speciale',
    display = {
		{'Demo'},
		{'S', 'sole'},
		{'L', 'luna'},
    }
}}
x.Us = {{
	link = 'Pokémon Ultrasole e Ultraluna',
	text = 'Ultrasole',
	display = {
		{'Us', 'ultrasole'}
	}
}}
x.US = x.Us
x.Ul = {{
	link = 'Pokémon Ultrasole e Ultraluna',
	text = 'Ultraluna',
	display = {
		{'Ul', 'ultraluna'}
	}
}}
x.UL = x.Ul
x.UsUl = {{
    link = 'Pokémon Ultrasole e Ultraluna',
    display = {
		{'Us', 'ultrasole'},
		{'Ul', 'ultraluna'}
    }
}}
x.USUL, x.USL = x.UsUl, x.UsUl
x.SUs = {x.So[1], x.Us[1]}
x.SUS, x.SoUs = x.SUs, x.SUs
x.LUl = {x.L[1], x.Ul[1]}
x.LUL = x.LUl
x.SLUsUl =  {
{
    link = 'Pokémon Sole e Luna',
    text = 'Sole, Luna',
    display = {
		{'S', 'sole'},
		{'L', 'luna'}
    }
}, x.USUL[1]}
x.SLUSUL = x.SLUsUl
x.LGP = {{
    link = "Pokémon: Let's Go, Pikachu! e Let's Go, Eevee!",
    text = "Let's Go, Pikachu!",
    display = {
	{'LGP', 'LG_pikachu'}
    }
}}
x.LgP = x.LGP
x.LGE = {{
    link = "Pokémon: Let's Go, Pikachu! e Let's Go, Eevee!",
    text = "Let's Go, Eevee!",
    display = {
	{'LGE', 'LG_eevee'}
    }
}}
x.LgE = x.LGE
x.LGPE = {{
    link = "Pokémon: Let's Go, Pikachu! e Let's Go, Eevee!",
    display = {
		{'LG'},
		{'P', 'LG_pikachu'},
		{'E', 'LG_eevee'}
    }
}}
x.LgPE = x.LGPE
x.Sp = {{
    link = 'Pokémon Spada e Scudo',
    text = 'Spada',
    display = {
        {'Sp', 'spada'}
    }
}}
x.Sc = {{
    link = 'Pokémon Spada e Scudo',
    text = 'Scudo',
    display = {
        {'Sc', 'scudo'}
    }
}}
x.SpSc = {{
    link = 'Pokémon Spada e Scudo',
    display = {
        {'Sp', 'spada'},
        {'Sc', 'scudo'}
    }
}}
x.IATC = {{
    link = 'Pokémon Spada e Scudo - Pass di espansione',
    display = {
        {'IA', 'isolaarmatura'},
        {'TC', 'landacorona'}
    }
}}
x.IA = {{
    link = "L'isola solitaria dell'armatura",
    display = {
        {'IA', 'isolaarmatura'}
    }
}}
x.TC = {{
    link = 'Le terre innevate della corona',
    display = {
        {'TC', 'landacorona'}
    }
}}
x.DL = {{
	link = 'Pokémon Diamante Lucente e Perla Splendente',
	text = 'Diamante Lucente',
	display = {
		{'DL', 'diamantelucente'}
	}
}}
x.PS = {{
	link = 'Pokémon Diamante Lucente e Perla Splendente',
	text = 'Perla Splendente',
	display = {
		{'PS', 'perlasplendente'}
	}
}}
x.DLPS = {{
	link = 'Pokémon Diamante Lucente e Perla Splendente',
	display = {
		{'DL', 'diamantelucente'},
        {'PS', 'perlasplendente'}
	}
}}
x.LPA = {{
    link = 'Leggende Pokémon: Arceus',
    display = {
		{'LPA', 'leggendearceus'}
    }
}}
x.Sa = {{
	link = 'Pokémon Scarlatto e Violetto',
	text = 'Scarlatto',
	display = {
		{'S', 'scarlatto'}
	}
}}
x.Vi = {{
	link = 'Pokémon Scarlatto e Violetto',
	text = 'Violetto',
	display = {
		{'V', 'violetto'}
	}
}}
x.SV = {{
	link = 'Pokémon Scarlatto e Violetto',
	display = {
		{'S', 'scarlatto'},
		{'V', 'violetto'},
	}
}}

x.SJ = {{
    link = 'Pokémon Stadium (Giappone)',
    text = 'Stadium',
    display = {
		{'SJ', 'rosso'}
    }
}}
x.St = {{
    link = 'Pokémon Stadium',
    display = {
	{'St', 'rosso'}
    }
}}
x.ST = x.St
x.S2 = {{
    link = 'Pokémon Stadium 2',
    display = {
	{'S2', 'oro'}
    }
}}
x.St2, x.ST2 = x.S2, x.S2
x.StS2 = {x.St[1], x.S2[1]}
x.COLO = {{
    link = 'Pokémon Colosseum',
    display = {
	{'Colo.', 'colo'}
    }
}}
x.Colo = x.COLO
x.XD = {{
    link = 'Pokémon XD: Tempesta Oscura',
    text = 'XD',
    display = {
	{'XD', 'XD'}
    }
}}
x.ColoXD = {x.Colo[1], x.XD[1]}
x.COLOXD = x.ColoXD
x.PBR = {{
    link = 'Pokémon Battle Revolution',
    display = {
	{'BR', 'battle_revolution'}
    }
}}
x.PMDR = {{
    link = 'Pokémon Mystery Dungeon: Squadra Rossa e Squadra Blu',
    text = 'Mystery Dungeon: Squadra Rossa',
    display = {
	{'R', 'mdrosso'}
    }
}}
x.PMDB = {{
    link = 'Pokémon Mystery Dungeon: Squadra Rossa e Squadra Blu',
    text = 'Mystery Dungeon: Squadra Blu',
    display = {
	{'B', 'mdblu'}
    }
}}
x.PMDRB = {{
    link = 'Pokémon Mystery Dungeon: Squadra Rossa e Squadra Blu',
    display = {
	{'R', 'mdrosso'},
	{'B', 'mdblu'}
    }
}}
x.PMDT = {{
    link = "Pokémon Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    text = 'Mystery Dungeon: Esploratori del Tempo',
    display = {
	{'T', 'mdtempo'}
    }
}}
x.Time, x.Tempo, x.TIME, x.TEMPO = x.PMDT, x.PMDT, x.PMDT, x.PMDT
x.PMDO = {{
    link = "Pokémon Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    text = "Mystery Dungeon: Esploratori dell'Oscurità",
    display = {
	{'O', 'mdoscurita'}
    }
}}
x.PMDD, x['Oscurità'], x.Oscurita, x.Darkenss = x.PMDO, x.PMDO, x.PMDO, x.PMDO
x['OSCURITÀ'], x.OSCURITA, x.DARKNESS = x.PMDO, x.PMDO, x.PMDO
x.PMDTO = {{
    link = "Pokémon Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    display = {
	{'T', 'mdtempo'},
	{'O', 'mdoscurita'}
    }
}}
x.PMDTD = x.PMDTO
x.PMDC = {{
    link = 'Pokémon Mystery Dungeon: Esploratori del Cielo',
    display = {
	{'C', 'mdcielo'}
    }
}}
x.PMDS, x.Sky, x.Cielo, x.SKY, x.CIELO = x.PMDC, x.PMDC, x.PMDC, x.PMDC, x.PMDC
x.PMDTOC = {x.PMDTO[1], x.PMDC[1]}
x.PMDTDS = x.PMDTOC
x.PMDTC = {x.PMDT[1], x.PMDC[1]}
x.PMDTS = x.PMDTC
x.PMDOC = {x.PMDO[1], x.PMDC[1]}
x.PMDDS = x.PMDOC
x.PMDPSI = {{
	link = "Pokémon Mystery Dungeon: i portali sull'infinito",
	display = {
		{'PSI', 'mdportali'}
	}
}}
x.PMDPsI, x.PMDGTI, x.Infnito = x.PMDPSI, x.PMDPSI, x.PMDPSI
x.infnito, x.INFINITO, x.Infinity = x.PMDPSI, x.PMDPSI, x.PMDPSI
x.infinity, x.INFINITY = x.PMDPSI, x.PMDPSI
x.PSMD = {{
	link = "Pokémon Super Mystery Dungeon",
	display = {
		{'SMD', 'mdsuper'}
	}
}}
x.Super, x.super = x.PSMD, x.PSMD
x.PMDDX = {{
	link = "Pokémon Mystery Dungeon: Squadra di Soccorso DX",
	display = {
		{'MDDX', 'mddx'}
	}
}}
x.Ra = {{
	link = "Pokémon Ranger (gioco)",
	display = {
		{'Ra', 'ranger'}
	}
}}
x.RA, x.ra = x.Ra, x.Ra
x.OsA = {{
	link = "Pokémon Ranger: Ombre su Almia",
	display = {
		{'OsA', 'OsA'}
	}
}}
x.OSA, x.osa, x.Osa = x.OsA, x.OsA, x.OsA
x.Tdl = {{
	link = "Pokémon Ranger: Tracce di luce",
	display = {
		{'Tdl', 'TL'}
	}
}}
x.TDL, x.TdL = x.Tdl, x.Tdl
x.Cq = {{
    link = 'Pokémon Conquest',
    display = {
	{'Cq', 'conquest'}
    }
}}

-- Super Smash Bros.
x['64'] = {{
    link = 'Super Smash Bros.',
    display = {
	{'64', 'arancione'}
    }
}}
x.Melee = {{
    link = 'Super Smash Bros. Melee',
    display = {
	{'Melee', 'arancione'}
    }
}}
x.melee = x.Melee
x.Brawl = {{
    link = 'Super Smash Bros. Brawl',
    display = {
	{'Brawl', 'arancione'}
    }
}}
x.brawl = x.Brawl
x['3DS/Wii U'] = {{
    link = 'Super Smash Bros. for Nintendo 3DS/Wii U',
    display = {
	{'3DS', 'arancione'},
	{'/', 'nero'},
	{'Wii U', 'TL'}
    }
}}
x['4'], x['3DSWiiU'], x['3DS/WiiU'], x['3DS-WiiU'] = x['3DS/Wii U'], x['3DS/Wii U'], x['3DS/Wii U'], x['3DS/Wii U']
x['3DS'] = {{
    link = 'Super Smash Bros. for Nintendo 3DS/Wii U',
    display = {
	{'3DS', 'arancione'}
    }
}}
x['Wii U'] = {{
    link = 'Super Smash Bros. for Nintendo 3DS/Wii U',
    display = {
	{'Wii U', 'TL'}
    }
}}
x.WiiU = x['Wii U']
x.Ultimate = {{
    link = 'Super Smash Bros. Ultimate',
    display = {
	{'Ultimate', 'nero'},
    }
}}
x.ultimate = x.Ultimate

-- Non-games abbreviations
x.CPM = {{
    link = 'Club Pokémiglia',
    display = {
        {'CPM', 'club_pokémiglia'}
    }
}}
x.DW = {{
    link = 'Pokémon Dream World',
    display = {
        {'DW', 'dream_world'}
    }
}}
x.PW = {{
    link = 'Pokéwalker',
    display = {
        {'PW', 'pokewalker'}
    }
}}
x.SA = {{
    link = 'Safari Amici',
    display = {
        {'SA', 'safari_amici'}
    }
}}
x.PA = {{
    link = 'Parco Amici',
    display = {
        {'PA', 'parco_amici'}
    }
}}
x.HOME = {{
    link = 'Pokémon HOME',
    display = {
        {'HOME', 'home'}
    }
}}

return x
