--[[

Data module holding some generations-related
information. The top level indexes are numbers
corresponding to every generation.

--]]

local gendata = {}

-- Latest generation and too many aliases

gendata.latest = 9
gendata.last = gendata.latest
gendata.lastGen, gendata.last_gen = gendata.latest, gendata.latest
gendata.latestGen, gendata.latest_gen = gendata.latest, gendata.latest

-- Ordinals, both italian and roman, and regions

gendata[1] = {ext = 'prima', roman = 'I', region = 'kanto'}
gendata[2] = {ext = 'seconda', roman = 'II', region = 'johto'}
gendata[3] = {ext = 'terza', roman = 'III', region = 'hoenn'}
gendata[4] = {ext = 'quarta', roman = 'IV', region = 'sinnoh'}
gendata[5] = {ext = 'quinta', roman = 'V', region = 'unima'}
gendata[6] = {ext = 'sesta', roman = 'VI', region = 'kalos'}
gendata[7] = {ext = 'settima', roman = 'VII', region = 'alola'}
gendata[8] = {ext = 'ottava', roman = 'VIII', region = 'galar'}
gendata[9] = {ext = 'nona', roman = 'IX', region = 'paldea'}

--[[

Lowercase abbreviations of games grouped
by generation: Green is after Red and Blue
in order to avoid crashes while retaining
Red and Blue as first games.

--]]

gendata[1].games = {'rb', 'v', 'g', 'st'}
gendata[2].games = {'oa', 'c', 'st2'}
gendata[3].games = {'rz', 'rfvf', 's', 'colo', 'xd'}
gendata[4].games = {'dp', 'pt', 'hgss', 'pbr'}
gendata[5].games = {'nb', 'n2b2'}
gendata[6].games = {'xy', 'roza'}
gendata[7].games = {'sl', 'usul', 'lgpe'}
gendata[8].games = {'spsc', 'dlps', 'lpa'}
gendata[9].games = {'sv'}

return gendata
