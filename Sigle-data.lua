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
    link = 'Rosso e Blu',
    text = 'Rosso',
    display = {
        {'R', 'rosso'}
    }
}}
x.B = {{
	link = 'Rosso e Blu',
	text = 'Blu',
	display = {
		{'B', 'blu'}
	}
}}
x.V = {{
	link = 'Rosso e Verde',
	text = 'Verde',
	display = {
		{'V', 'verde'}
	}
}}
x.G = {{
    link = 'Giallo',
    display = {
        {'G', 'giallo'}
    }
}}
x.RB = {{
    link = 'Rosso e Blu',
    display = {
        {'R', 'rosso'},
        {'B', 'blu'}
    }
}}
x.RV = {{
    link = 'Rosso e Verde',
    display = {
        {'R', 'rosso'},
        {'V', 'verde'}
    }
}}
x.RBG = {
{
    link = 'Rosso e Blu',
    text = 'Rosso, Blu',
    display = {
        {'R', 'rosso'},
        {'B', 'blu'}
    }
}, x.G[1]}
x.RVBG = {x.RBG[1],
{
    link = 'Blu (Giappone)',
    text = 'Blu',
    display = {
        {'B', 'blu'}
    }
}, x.G[1]
}
x.O = {{
	link = 'Oro e Argento',
	text = 'Oro',
	display = {
		{'O', 'oro'}
	}
}}
x.A = {{
	link = 'Oro e Argento',
	text = 'Argento',
	display = {
		{'A', 'argento'}
	}
}}
x.C = {{
    link = 'Cristallo',
    display = {
        {'C', 'cristallo'}
    }
}}
x.OA = {{
    link = 'Oro e Argento',
    display = {
        {'O', 'oro'},
        {'A', 'argento'}
    }
}}
x.OAC = {
{
    link = 'Oro e Argento',
    text = 'Oro, Argento',
    display = {
        {'O', 'oro'},
        {'A', 'argento'}
    }
}, x.C[1]}
x.Ru = {{
	link = 'Rubino e Zaffiro',
	text = 'Rubino',
	display = {
		{'R', 'rubino'}
	}
}}
x.RU = x.Ru
x.Z = {{
	link = 'Rubino e Zaffiro',
	text = 'Zaffiro',
	display = {
		{'Z', 'zaffiro'}
	}
}}
x.S = {{
    link = 'Smeraldo',
    display = {
        {'S', 'smeraldo'}
    }
}}
x.Sm, x.SM = x.S, x.S
x.RZ = {{
    link = 'Rubino e Zaffiro',
    display = {
        {'R', 'rubino'},
        {'Z', 'zaffiro'}
    }
}}
x.RuZa, x.RUZA = x.RZ, x.RZ
x.RZS = {
{
    link = 'Rubino e Zaffiro',
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
	link = 'Rosso Fuoco e Verde Foglia',
	text = 'Rosso Fuoco',
	display = {
		{'RF', 'rossofuoco'}
	}
}}
x.VF = {{
	link = 'Rosso Fuoco e Verde Foglia',
	text = 'Verde Foglia',
	display = {
		{'VF', 'verdefoglia'}
	}
}}
x.RFVF = {{
	link = 'Rosso Fuoco e Verde Foglia',
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
	link = 'Diamante e Perla',
	text = 'Diamante',
	display = {
		{'D', 'diamante'}
	}
}}
x.P = {{
	link = 'Diamante e Perla',
	text = 'Perla',
	display = {
		{'P', 'perla'}
	}
}}
x.Pt = {{
    link = 'Platino',
    display = {
		{'Pt', 'platino'}
    }
}}
x.PT = x.Pt
x.DP = {{
    link = 'Diamante e Perla',
    display = {
		{'D', 'diamante'},
		{'P', 'perla'}
    }
}}
x.DPPt = {
{
	link = 'Diamante e Perla',
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
	link = 'Oro HeartGold e Argento SoulSilver',
	text = 'Oro HeartGold',
	display = {
		{'HG', 'heartgold'}
	}
}}
x.SS = {{
	link = 'Oro HeartGold e Argento SoulSilver',
	text = 'Argento SoulSilver',
	display = {
		{'SS', 'soulsilver'}
	}
}}
x.HGSS = {{
	link = 'Oro HeartGold e Argento SoulSilver',
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
	link = 'Rosso Fuoco e Verde Foglia',
	text = 'Rosso Fuoco, Verde Foglia',
	display = {
		{'RF', 'rossofuoco'},
        {'VF', 'verdefoglia'}
	}
}, x.HGSS[1]}
x.OACRFVFHGSS = {x.OAC[1], x.C[1], x.RFVFHGSS[1], x.HGSS[1]}
x.N = {{
	link = 'Nero e Bianco',
	text = 'Nero',
	display = {
		{'N', 'nero'}
	}
}}
x.Bi = {{
	link = 'Nero e Bianco',
	text = 'Bianco',
	display = {
		{'B', 'bianco'}
	}
}}
x.BI = x.Bi
x.NB = {{
	link = 'Nero e Bianco',
	display = {
		{'N', 'nero'},
		{'B', 'bianco'}
	}
}}
x.NeBi, x.NEBI = x.NB, x.NB
x.N2 = {{
	link = 'Nero 2 e Bianco 2',
	text = 'Nero 2',
	display = {
		{'N2', 'nero2'}
	}
}}
x.B2 = {{
	link = 'Nero 2 e Bianco 2',
	text = 'Bianco 2',
	display = {
		{'B2', 'bianco2'}
	}
}}
x.N2B2 = {{
	link = 'Nero 2 e Bianco 2',
	display = {
		{'N2', 'nero2'},
		{'B2', 'bianco2'}
	}
}}
x.NN2 = {x.N[1], x.N2[1]}
x.BB2 = {x.Bi[1], x.B2[1]}
x.NBN2B2 = {
{
	link = 'Nero e Bianco',
	text = 'Nero, Bianco',
	display = {
		{'N', 'nero'},
		{'B', 'bianco'}
	}
}, x.N2B2[1]}
x.X = {{
	link = 'X e Y',
	text = 'X',
	display = {
		{'X', 'x'}
	}
}}
x.Y = {{
	link = 'X e Y',
	text = 'Y',
	display = {
		{'Y', 'y'}
	}
}}
x.XY = {{
    link = 'X e Y',
    display = {
	{'X', 'x'},
	{'Y', 'y'}
    }
}}
x.RO = {{
	link = 'Rubino Omega e Zaffiro Alpha',
	text = 'Rubino Omega',
	display = {
		{'RΩ', 'rubinoomega'}
	}
}}
x.ZA = {{
	link = 'Rubino Omega e Zaffiro Alpha',
	text = 'Zaffiro Alpha',
	display = {
		{'Zα', 'zaffiroalpha'}
	}
}}
x.ROZA = {{
    link = 'Rubino Omega e Zaffiro Alpha',
    display = {
	{'RΩ', 'rubinoomega'},
	{'Zα', 'zaffiroalpha'}
    }
}}
x.XYROZA = {
{
    link = 'X e Y',
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
x.So = {{
	link = 'Sole e Luna',
	text = 'Sole',
	display = {
		{'S', 'sole'}
	}
}}
x.SO = x.So
x.L = {{
	link = 'Sole e Luna',
	text = 'Luna',
	display = {
		{'L', 'luna'}
	}
}}
x.SL = {{
    link = 'Sole e Luna',
    display = {
		{'S', 'sole'},
		{'L', 'luna'}
    }
}}
x.SJ = {{
    link = 'Stadium (Giappone)',
    text = 'Stadium',
    display = {
	{'SJ', 'rosso'}
    }
}}
x.St = {{
    link = 'Stadium',
    display = {
	{'St', 'rosso'}
    }
}}
x.ST = x.St
x.S2 = {{
    link = 'Stadium 2',
    display = {
	{'S2', 'oro'}
    }
}}
x.St2, x.ST2 = x.S2, x.S2
x.StS2 = {x.St[1], x.S2[1]}
x.COLO = {{
    link = 'Colosseum',
    display = {
	{'Colo.', 'colo'}
    }
}}
x.Colo = x.COLO
x.XD = {{
    link = 'XD: Tempesta Oscura',
    text = 'XD',
    display = {
	{'XD', 'XD'}
    }
}}
x.ColoXD = {x.Colo[1], x.XD[1]}
x.COLOXD = x.ColoXD
x.PBR = {{
    link = 'Battle Revolution',
    display = {
	{'BR', 'battle_revolution'}
    }
}}
x.PMDR = {{
    link = 'Mystery Dungeon: Squadra Rossa e Squadra Blu',
    text = 'Mystery Dungeon: Squadra Rossa',
    display = {
	{'R', 'mdrosso'}
    }
}}
x.PMDB = {{
    link = 'Mystery Dungeon: Squadra Rossa e Squadra Blu',
    text = 'Mystery Dungeon: Squadra Blu',
    display = {
	{'B', 'mdblu'}
    }
}}
x.PMDRB = {{
    link = 'Mystery Dungeon: Squadra Rossa e Squadra Blu',
    display = {
	{'R', 'mdrosso'},
	{'B', 'mdblu'}
    }
}}
x.PMDT = {{
    link = "Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    text = 'Mystery Dungeon: Esploratori del Tempo',
    display = {
	{'T', 'mdtempo'}
    }
}}
x.Time, x.Tempo, x.TIME, x.TEMPO = x.PMDT, x.PMDT, x.PMDT, x.PMDT
x.PMDO = {{
    link = "Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    text = "Mystery Dungeon: Esploratori dell'Oscurità",
    display = {
	{'O', 'mdoscurita'}
    }
}}
x.PMDD, x['Oscurità'], x.Oscurita, x.Darkenss = x.PMDO, x.PMDO, x.PMDO, x.PMDO
x['OSCURITÀ'], x.OSCURITA, x.DARKNESS = x.PMDO, x.PMDO, x.PMDO
x.PMDTO = {{
    link = "Mystery Dungeon: Esploratori del Tempo ed Esploratori dell'Oscurità",
    display = {
	{'T', 'mdtempo'},
	{'O', 'mdoscurita'}
    }
}}
x.PMDTD = x.PMDTO
x.PMDC = {{
    link = 'Mystery Dungeon: Esploratori del Cielo',
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
	link = "Mystery Dungeon: I Portali sull'Infinito",
	display = {
		{'PSI', 'mdportali'}
	}
}}
x.PMDPsI, x.PMDGTI, x.Infnito = x.PMDPSI, x.PMDPSI, x.PMDPSI
x.infnito, x.INFINITO, x.Infinity = x.PMDPSI, x.PMDPSI, x.PMDPSI
x.infinity, x.INFINITY = x.PMDPSI, x.PMDPSI
x.PSMD = {{
	link = "Super Mystery Dungeon",
	display = {
		{'SMD', 'mdsuper'}
	}
}}
x.Super, x.super = x.PSMD, x.PSMD

return x
