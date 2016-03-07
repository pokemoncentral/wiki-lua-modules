--[[

Modulo con alcuni dati relativi alle generazioni:
ogni generazione ha associata una table con indice
il proprio numero

--]]

local gendata = {}

-- Ultima generazione, con alias per i non anglofoni

gendata.latest = 6
gendata.last = gendata.latest
gendata.lastGen, gendata.last_gen = gendata.latest, gendata.latest
gendata.latestGen, gendata.latest_gen = gendata.latest, gendata.latest

--[[

Trascrizione in lettera e in numeri romani degli ordinali
delle generazioni e le regioni corrispondenti.

--]]

gendata[1] = {ext = 'prima', roman = 'I', region = 'kanto'}
gendata[2] = {ext = 'seconda', roman = 'II', region = 'johto'}
gendata[3] = {ext = 'terza', roman = 'III', region = 'hoenn'}
gendata[4] = {ext = 'quarta', roman = 'IV', region = 'sinnoh'}
gendata[5] = {ext = 'quinta', roman = 'V', region = 'unima'}
gendata[6] = {ext = 'sesta', roman = 'VI', region = 'kalos'}

-- Sigle dei giochi in minuscolo delle generazioni

gendata[1].games = {'rb', 'g', 'st'}
gendata[2].games = {'oa', 'c', 'st2'}
gendata[3].games = {'rz', 'rfvf', 's', 'colo', 'xd'}
gendata[4].games = {'dp', 'pt', 'hgss', 'pbr'}
gendata[5].games = {'nb', 'n2b2'}
gendata[6].games = {'xy', 'roza'}

return gendata
