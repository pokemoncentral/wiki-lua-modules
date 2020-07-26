--[[

Modulo per la gestione di date e orari.

Principalmente usato quando si hanno gli
input della funzione mediawiki #time in
italiano, perché usando semplicemente
delle tables li traduce in inglese e poi
usa mw.language:formatDate() per compere
le stesse operazioni

--]]

local txt = require('Wikilib-strings')

local q = {}

local mw = require('mw')

--[[

Necessario per usare le funzioni #time
di MediaWiki tramite il metodo formatDate()

--]]

q.time = mw.language.new('it')

q.segniZod = {'Ariete', 'Toro', 'Gemelli', 'Cancro',
	'Leone', 'Vergine', 'Bilancia', 'Scorpione',
	'Sagittario', 'Capricorno', 'Acquario', 'Pesci'}

--[[

Probabilmente esiste anche una funzione
Mediawiki per tradurre i mesi, ma una
lua table è certamente più efficiente

--]]

q.mesiEn = {gennaio = 'january', febbraio = 'february',
	marzo = 'march', aprile = 'april', maggio = 'may',
	giugno = 'june', luglio = 'july', agosto = 'august',
	settembre = 'september', ottobre = 'october',
	novembre = 'november', dicembre = 'december'}

--[=[

A partire dalla data nel formato <Giorno> <Mese>,
ritorna il link a wikipedia del segno
zodiacale, nella forma
	[[wp:${segno} (astrologia)|${segno}]]

--]=]

q.wpAstrSignLink = function(frame)
	local day, month = string.match(frame.args[1] or '1 Gennaio',
		'%s*(%d+) (%a+)%s*')
	if day == '' or month == '' then
		return "Errore nella forma dell'input"
	end
	day, month = tonumber(day), q.mesiEn[month:lower()]
	if day < 0 or day > 31 or not month then
		return 'Mese o giorno non validi'
	end

	-- Non si usa math.ceil perché non funzionerebbe per gli interi

	local sign = q.segniZod[math.floor(q.time:formatDate('z',
		table.concat({month, day, '- 80 days'}, ' ')) / 30.416666) + 1]
	return txt.interp('[[wp:${s} (astrologia)|${s}]]', {s = sign})
end

return q
