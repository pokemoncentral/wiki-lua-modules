-- Header + Entries per la pagina 'Elenco Pokémon per disponibilità in game'

local f = {}
local c = require('Colore-data')
local w = require('Wikilib')
local txt = require('Wikilib-strings')
local tab = require('Wikilib-tables')
local t = require('AltForms-data')
local wl = require('Wikilib-data')

-- Contiene i giochi delle celle dell'header apposito

local games = {}
games[1] = string.interp([=[!! style="background: #${r}" width="30px"| [[Pokémon Rosso|<span style="color:#${tc}">R</span>]]
! style="background: #${v}" width="30px"| [[Pokémon Verde|<span style="color:#${tc}">V</span>]]
! style="background: #${b}" width="30px"| [[Pokémon Blu|<span style="color:#${tc}">B</span>]]
! style="background: #${g}" width="30px"| [[Pokémon Giallo|<span style="color:#${tc}">G</span>]]]=],
{r = c.rosso.normale, v = c.verde.normale, b = c.blu.normale, g = c.giallo.normale, tc = c.background})
games[2] = string.interp([=[!! style="background: #${o}" width="30px"| [[Pokémon Oro|<span style="color:#${tc}">O</span>]]
! style="background: #${a}" width="30px"| [[Pokémon Argento|<span style="color:#${tc}">A</span>]]
! style="background: #${cr}" width="30px"| [[Pokémon Cristallo|<span style="color:#${tc}">C</span>]]]=],
{o = c.oro.normale, a = c.argento.normale, cr = c.cristallo.normale, tc = c.background})
games[3] = string.interp([=[!! style="background: #${r}" width="30px"| [[Pokémon Rubino|<span style="color:#${tc}">R</span>]]
! style="background: #${z}" width="30px"| [[Pokémon Zaffiro|<span style="color:#${tc}">Z</span>]]
! style="background: #${s}" width="30px"| [[Pokémon Smeraldo|<span style="color:#${tc}">S</span>]]
! style="background: #${rf}" width="30px"| [[Pokémon Rosso Fuoco|<span style="color:#${tc}">RF</span>]]
! style="background: #${vf}" width="30px"| [[Pokémon Verde Foglia|<span style="color:#${tc}">VF</span>]]]=],
{r = c.rubino.normale, z = c.zaffiro.normale, s = c.smeraldo.normale, rf = c.rossofuoco.normale, vf = c.verdefoglia.normale, tc = c.background})
games[4] = string.interp([=[!! style="background: #${d}" width="30px"| [[Pokémon Diamante|<span style="color:#${tc}">D</span>]]
! style="background: #${p}" width="30px"| [[Pokémon Perla|<span style="color:#${tc}">P</span>]]
! style="background: #${pt}" width="30px"| [[Pokémon Platino|<span style="color:#${tc}">Pt</span>]]
! style="background: #${hg}" width="30px"| [[Pokémon HeartGold|<span style="color:#${tc}">HG</span>]]
! style="background: #${ss}" width="30px"| [[Pokémon SoulSilver|<span style="color:#${tc}">SS</span>]]]=],
{d = c.diamante.normale, p = c.perla.normale, pt = c.platino.normale, hg = c.heartgold.normale, ss = c.soulsilver.normale, tc = c.background})
games[5] = string.interp([=[!! style="background: #${n}" width="30px"| [[Pokémon Nero|<span style="color:#${tc}">N</span>]]
! style="background: #${b}" width="30px"| [[Pokémon Bianco|<span style="color:#${tc}">B</span>]]
! style="background: #${n2}" width="30px"| [[Pokémon Nero 2|<span style="color:#${tc}">N2</span>]]
! style="background: #${b2}" width="30px"| [[Pokémon Bianco 2|<span style="color:#${tc}">B2</span>]]]=],
{n = c.nero.normale, b = c.bianco.normale, n2 = c.nero2.normale, b2 = c.bianco2.normale, tc = c.background})
games[6] = string.interp([=[!! style="background: #${x}" width="30px"| [[Pokémon X|<span style="color:#${tc}">X</span>]]
! style="background: #${y}" width="30px"| [[Pokémon Y|<span style="color:#${tc}">Y</span>]]]=],
{x = c.x.normale, y = c.y.normale, tc = c.background})

-- Contiene le celle dei giochi spinoff per gli header

local spins = {}
spins[1] = string.interp('! style=" background: #${bg}" width="40px"| [[Pokémon Stadium|<span style="color:#${tc};">Stad</span>]]\n',
    {bg = c.blu.normale, tc = c.background})
spins[2] = string.interp('! style=" background: #${bg}" width="40px"| [[Pokémon Stadium 2|<span style="color:#${tc};">Stad2</span>]]\n',
    {bg = c.bronzo.normale, tc = c.background})
spins[3] = string.interp([=[! style=" background: #${cl}" width="40px"| [[Pokémon Colosseum|<span style="color:#${tc};">Colo</span>]]
! style=" background: #${xd}" width="40px"| [[Pokémon XD: Tempesta Oscura|<span style="color:#${tc};">XD</span>]]
! style=" background: #${brz}" width="40px"| [[Pokémon Box Rubino e Zaffiro|<span style="color:#${tc};">Box</span>]]
! style=" background: #${chn}" width="40px"| [[Pokémon Channel|<span style="color:#${tc};">Chn</span>]]
]=], {cl = c.colo.normale, xd = c.xd.normale, brz = c.rubino.normale, chn = c.giallo.normale, tc = c.background})
spins[4] = string.interp([=[! style=" background: #${br}" width="40px"| [[Pokémon Battle Revolution|<span style="color:#${tc};">PBR</span>]]
! style=" background: #${mpr}" width="40px"| [[My Pokémon Ranch|<span style="color:#${tc};">Ranch</span>]]
! style=" background: #${rng}" width="40px"| [[Pokémon Ranger (gioco)|<span style="color:#${tc};">Ran</span>]]
! style=" background: #${osa}" width="40px"| [[Pokémon Ranger: Ombre su Almia|<span style="color:#${tc};">OsA</span>]]
! style=" background: #${tl}" width="40px"| [[Pokémon Ranger: Tracce di Luce|<span style="color:#${tc};">TdL</span>]]
! style=" background: #${pw}" width="40px"| [[Pokéwalker|<span style="color:#${tc};">PW</span>]]
]=], {br = c.br.normale, mpr = c.diamante.normale, rng = c.ranger.normale, osa = c.osa.normale, tl = c.tl.normale,
    pw = c.rosso.normale, tc = c.background})
spins[5] = string.interp([=[! style=" background: #${dw}" width="40px"| [[Pokémon Dream World|<span style="color:#${tc};">DW</span>]]
! style=" background: #${ra}" width="40px"| [[RAdar Pokémon|<span style="color:#${tc};">RA</span>]]
]=], {dw = c.dw.normale, ra = c.arancione.normale, tc = c.background})
spins[6] = string.interp('! style=" background: #${bg}" width="40px"| <span style="color:#${tc};">Ness.</span>',
    {bg = c.x.normale, tc = c.background})

-- Genera le celle degli header

local cells = function(gen, kind)
    local b, row, ex = 1, {'|-\n'}, kind == 'std' and games or spins
    local str = '! style="background:#${bg};" colspan="${cs}" | [[${genl} generazione|<span style="color:#${tc};">${genr}</span>]]\n'
    local cs = {std = {4, 3, 5, 5, 4, 2}, spinoff = {1, 1, 4, 6, 2, nil}}
    for a = gen, 6 do
        table.insert(row, b, string.interp(str,
            {bg = c[wl.gendata[a].region].normale, cs = cs[kind][a], genl = wl.gendata[a].ext, tc = c.background, genr = wl.gendata[a].roman}))
        table.insert(row, 2 * b + 1, ex[a])
        b = b + 1
    end
    return table.concat(row)
end

-- Applica trim e first uppercase ai parametri

local sanitize = function(tab)
    return w.trimAndMap(tab, string.fu)
end

-- Restituisce lo sfondo e il testo della cella

local _colors = function(p, game)
    if table.search({'A', 'C', 'Ce', 'Ds', 'E', 'G', 'P', 'R'}, p) then
        return c[game].normale, table.search(wl.whitetext, game) and c.background or '000'
    else
        return c.background, c[game].normale
    end
end

-- Per i giochi di sesta generazione

local _avail6 = function(p)
    local t = {x = p[1] or 'N', y = p[2] or 'N'}
    t.bgx, t.tx = _colors(p[1] or 'N', 'x')
    t.bgy, t.ty = _colors(p[2] or 'N', 'y')
    return string.interp([=[

| style="background: #${bgx}; color: #${tx};" | '''${x}'''
| style="background: #${bgy}; color: #${ty};" | '''${y}''']=], t)
end

-- Per i giochi di quinta generazione

local _avail5 = function(p)
    local t = {n = p[1] or 'N', b = p[2] or 'N', n2 = p[3] or 'N', b2 = p[4] or 'N'}
    t.bgn, t.tn = _colors(p[1] or 'N', 'nero')
    t.bgb, t.tb = _colors(p[2] or 'N', 'bianco')
    t.bgn2, t.tn2 = _colors(p[3] or 'N', 'nero2')
    t.bgb2, t.tb2 = _colors(p[4] or 'N', 'bianco2')
    return string.interp([=[

| style="background: #${bgn}; color: #${tn};" | '''${n}'''
| style="background: #${bgb}; color: #${tb};" | '''${b}'''
| style="background: #${bgn2}; color: #${tn2};" | '''${n2}'''
| style="background: #${bgb2}; color: #${tb2};" | '''${b2}''']=], t)
end

-- Per i giochi di quarta generazione

local _avail4 = function(p)
    local t = {d = p[1] or 'N', p = p[2] or 'N', pt = p[3] or 'N', hg = p[4] or 'N', ss = p[5] or 'N'}
    t.bgd, t.td = _colors(p[1] or 'N', 'diamante')
    t.bgp, t.tp = _colors(p[2] or 'N', 'perla')
    t.bgpt, t.tpt = _colors(p[3] or 'N', 'platino')
    t.bghg, t.thg = _colors(p[4] or 'N', 'heartgold')
    t.bgss, t.tss = _colors(p[5] or 'N', 'soulsilver')
    return string.interp([=[

| style="background: #${bgd}; color: #${td};" | '''${d}'''
| style="background: #${bgp}; color: #${tp};" | '''${p}'''
| style="background: #${bgpt}; color: #${tpt};" | '''${pt}'''
| style="background: #${bghg}; color: #${thg};" | '''${hg}'''
| style="background: #${bgss}; color: #${tss};" | '''${ss}''']=], t)
end

-- Per i giochi di terza generazione

local _avail3 = function(p)
    local t = {r = p[1] or 'N', z = p[2] or 'N', s = p[3] or 'N', rf = p[4] or 'N', vf = p[5] or 'N'}
    t.bgr, t.tr = _colors(p[1] or 'N', 'rubino')
    t.bgz, t.tz = _colors(p[2] or 'N', 'zaffiro')
    t.bgs, t.ts = _colors(p[3] or 'N', 'smeraldo')
    t.bgrf, t.trf = _colors(p[4] or 'N', 'rossofuoco')
    t.bgvf, t.tvf = _colors(p[5] or 'N', 'verdefoglia')
    return string.interp([=[

| style="background: #${bgr}; color: #${tr};" | '''${r}'''
| style="background: #${bgz}; color: #${tz};" | '''${z}'''
| style="background: #${bgs}; color: #${ts};" | '''${s}'''
| style="background: #${bgrf}; color: #${trf};" | '''${rf}'''
| style="background: #${bgvf}; color: #${tvf};" | '''${vf}''']=], t)
end

-- Per i giochi di seconda generazione

local _avail2 = function(p)
    local t = {o = p[1] or 'N', a = p[2] or 'N', c = p[3] or 'N'}
    t.bgo, t.to = _colors(p[1] or 'N', 'oro')
    t.bga, t.ta = _colors(p[2] or 'N', 'argento')
    t.bgc, t.tc = _colors(p[3] or 'N', 'cristallo')
    return string.interp([=[

| style="background: #${bgo}; color: #${to};" | '''${o}'''
| style="background: #${bga}; color: #${ta};" | '''${a}'''
| style="background: #${bgc}; color: #${tc};" | '''${c}''']=], t)
end

-- Per i giochi di prima generazione

local _avail1 = function(p)
    local t = {r = p[1] or 'N', v = p[2] or 'N', b = p[3] or 'N', g = p[4] or 'N'}
    t.bgr, t.tr = _colors(p[1] or 'N', 'rosso')
    t.bgv, t.tv = _colors(p[2] or 'N', 'verde')
    t.bgb, t.tb = _colors(p[3] or 'N', 'blu')
    t.bgg, t.tg = _colors(p[4] or 'N', 'giallo')
    return string.interp([=[

| style="background: #${bgr}; color: #${tr};" | '''${r}'''
| style="background: #${bgv}; color: #${tv};" | '''${v}'''
| style="background: #${bgb}; color: #${tb};" | '''${b}'''
| style="background: #${bgg}; color: #${tg};" | '''${g}''']=], t)
end

-- Provvisorio, per gli spinoff di sesta generazione

local _so6 = function(p)
    return string.interp('| style="background: #${bg};" | &nbsp;', {bg = c.y.normale})
end

-- Per gli spinoff di quinta generazione

local _so5 = function(p)
    local t = {dw = p[1] or 'N', ra = p[2] or 'N'}
    t.bgdw, t.tdw = _colors(p[1] or 'N', 'dw')
    t.bgra, t.tra = _colors(p[2] or 'N', 'orange')
    return string.interp([=[

| style="background: #${bgdw}; color: #${tdw};" | '''${dw}'''
| style="background: #${bgra}; color: #${tra};" | '''${ra}''']=], t)
end

-- Per gli spinoff di quarta generazione

local _so4 = function(p)
    local t = {pbr = p[1] or 'N', mpr = p[2] or 'N', rng = p[3] or 'N', osa = p[4] or 'N', tl = p[5] or 'N', pw = p[6] or 'N'}
    t.bgpbr, t.tpbr = _colors(p[1] or 'N', 'br')
    t.bgmpr, t.tmpr = _colors(p[2] or 'N', 'perla')
    t.bgrng, t.trng = _colors(p[3] or 'N', 'ranger')
    t.bgosa, t.tosa = _colors(p[4] or 'N', 'osa')
    t.bgtl, t.ttl = _colors(p[6] or 'N', 'tl')
    t.bgpw, t.tpw = _colors(p[6] or 'N', 'rosso')
    return string.interp([=[

| style="background: #${bgpbr}; color: #${tpbr};" | '''${pbr}'''
| style="background: #${bgmpr}; color: #${tmpr};" | '''${mpr}'''
| style="background: #${bgrng}; color: #${trng};" | '''${rng}'''
| style="background: #${bgosa}; color: #${tosa};" | '''${osa}'''
| style="background: #${bgtl}; color: #${ttl};" | '''${tl}'''
| style="background: #${bgpw}; color: #${tpw};" | '''${pw}''']=], t)
end

-- Per gli spinoff di terza generazione

local _so3 = function(p)
    local t = {colo = p[1] or 'N', xd = p[2] or 'N', box = p[3] or 'N', chn = p[4] or 'N'}
    t.bgcolo, t.tcolo = _colors(p[1] or 'N', 'colo')
    t.bgxd, t.txd = _colors(p[2] or 'N', 'xd')
    t.bgbox, t.tbox = _colors(p[3] or 'N', 'zaffiro')
    t.bgchn, t.tchn = _colors(p[4] or 'N', 'giallo')
    return string.interp([=[

| style="background: #${bgcolo}; color: #${tcolo};" | '''${colo}'''
| style="background: #${bgxd}; color: #${txd};" | '''${xd}'''
| style="background: #${bgbox}; color: #${tbox};" | '''${box}'''
| style="background: #${bgchn}; color: #${tchn};" | '''${chn}''']=], t)
end


-- Per gli spinoff di seconda generazione

local _so2 = function(p)
    local t = {st2 = p[1] or 'N'}
    t.bgst2, t.tst2 = _colors(p[1] or 'N', 'bronzo')
    return string.interp([=[

| style="background: #${bgst2}; color: #${tst2};" | '''${st2}''']=], t)
end

-- Per gli spinoff di prima generazione

local _so1 = function(p)
    local t = {st = p[1] or 'N'}
    t.bgst, t.tst = _colors(p[1] or 'N', 'blu')
    return string.interp([=[

| style="background: #${bgst}; color: #${tst};" | '''${st}''']=], t)
end



-- L'header per i giochi della serie principale

f.h = function(frame)
    local gen = tonumber(frame.args[1]) or 1
    local cs = {23, 19, 16, 11, 6, 2}
    return string.interp([=[{| class="roundytop" style="margin: auto; background: #${bg}; border: 3px solid #${bd}; text-align: center;"
! style="background:#${bd};" rowspan="3" class="roundytl" width="26px"| #
! style="background:#${bd};" rowspan="3" width="101px" colspan="2" | Pokémon
! style="background:#${bd};" class="roundytr" colspan="${cs}" | Giochi
|-
${g}]=],
{
    bg = c.pcwiki.dark,
    bd = c.pcwiki.normale,
    cs = cs[gen],
    g = cells(gen, 'std')
})
end

f.H = f.h

--L'header per gli spinoff

f.spinoffh = function(frame)
    local gen = tonumber(frame.args[1]) or 1
    local cs = {15, 14, 13, 9, 3, nil}
    return string.interp([=[{| class="roundytop" style="margin: auto; background: #${bg};  border: 3px solid #${bd}; text-align: center;"
! style="background:#${bd};" rowspan="3" class="roundytl" width="26px"| #
! style="background:#${bd};" rowspan="3" width="101px" colspan="2" | Pokémon
! style="background:#${bd};" class="roundytr" colspan="${cs}" | Giochi
|-
${g}]=],
{
    bg = c.pcwiki.dark,
    bd = c.pcwiki.normale,
    cs = cs[gen],
    g = cells(gen, 'spinoff')
})
end

f.Spinoffh = f.spinoffh

-- Entry per tutte le generazioni, che chiama quelli specifici per una singola generazione.

f.entry = function(frame)
    local p = sanitize(frame.args)
    local n, g = tonumber(p[1]) or 1, ''
    if n < 152 then
        g = table.concat{_avail1{p[4], p[5], p[6], p[7]}, _avail2{p[8], p[9], p[10]}, _avail3{p[11], p[12], p[13], p[14], p[15]},
            _avail4{p[16], p[17], p[18], p[19], p[20]}, _avail5{p[21], p[22], p[23], p[24]}, _avail6{p[25], p[26]}}
    elseif n < 252 then
        g = table.concat{_avail2{p[4], p[5], p[6]}, _avail3{p[7], p[8], p[9], p[10], p[11]}, _avail4{p[12], p[13], p[14], p[15], p[16]},
            _avail5{p[17], p[18], p[19], p[20]}, _avail6{p[21], p[22]}}
    elseif n < 387 then
        g = table.concat{_avail3{p[4], p[5], p[6], p[7], p[8]}, _avail4{p[9], p[10], p[11], p[12], p[13]},
            _avail5{p[14], p[15], p[16], p[17]}, _avail6{p[18], p[19]}}
    elseif n < 494 then
        g = table.concat{_avail4{p[4], p[5], p[6], p[7], p[8]}, _avail5{p[9], p[10], p[11], p[12]},
            _avail6{p[13], p[14]}}
    elseif n < 650 then
        g = table.concat{_avail5{p[4], p[5], p[6], p[7]}, _avail6{p[8], p[9]}}
    else
        g = _avail6{p[4], p[5]}
    end
    return string.interp([=[|- style="background:#${bg};"
| width="26px" | ${num}
| width="26px" | [[File:${num}${frmspt}MS.png|link=${name}|${name}]]
| width="75px" | [[${name}]]${frmlnk}${h}]=],
{
    bg = c.background,
    num = p[1] or '001',
    name = p[2] or 'Bulbasaur',
    frmspt = p[3] and t.sigle[p[3]:lower()] or '',
    frmlnk = p[3] and table.concat{'\n<small>', t.links[p[3]:lower()], '</small>'} or '',
    h = g
})
end

f.Entry = f.entry

-- Entry per gli spinoff

f.spinoff = function(frame)
    local p = sanitize(frame.args)
    local n, g = tonumber(p[1]) or 1, ''
    if n < 152 then
        g = table.concat{_so1(p[4]), _so2(p[5]), _so3(p[6], p[7], p[8], p[9]), _so4(p[10], p[11], p[12], p[13], p[14], p[15], p[16], p[17]),
            _so5(p[18], p[19]), _so6()}
    elseif n < 252 then
        g = table.concat{_so2(p[4]), _so3(p[5], p[6], p[7], p[8]), _so4(p[9], p[10], p[11], p[12], p[13], p[14], p[15], p[16]),
            _so5(p[17], p[18]), _so6()}
    elseif n < 387 then
        g = table.concat{_so3(p[4], p[5], p[6], p[7]), _so4(p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15]), _so5(p[16], p[17]), _so6()}
    elseif n < 494 then
        g = table.concat{_so4(p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11]), _so5(p[12], p[13]), _so6()}
    elseif n < 650 then
        g = table.concat{_so5(p[4], p[5]), _so6()}
    else
        g = _so6()
    end
    return string.interp([=[|- style="background:#${bg};"
| width="26px" | ${num}
| width="26px" | [[File:${num}${frmspt}MS.png|link=${name}|${name}]]
| width="75px" | [[${name}]]${frmlnk}${h}]=],
{
    bg = c.background,
    num = p[1] or '001',
    name = p[2] or 'Bulbasaur',
    frmspt = p[3] and t.sigle[p[3]:lower()] or '',
    frmlnk = p[3] and table.concat{'\n<small>', t.links[p[3]:lower()], '</small>'} or '',
    h = g
})
end

f.Spinoff = f.spinoff

return f
