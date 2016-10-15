-- Modulo per gestire Greninja Demo SL

--[[

!!! ATTENZIONE !!!

Questo modulo modifica le copie cachate dei
moduli dati Poké/data e AltForms/data
aggiungendo la forma Demo SL di Greninja

--]]

local d = {}
local pokes = require('Poké-data')
local forms = require('AltForms-data')

d.addGreninjaDemo = function()
	-- Poké/data
	pokes.greninjaD = pokes.greninja
	pokes['658D'] = pokes.greninja
	pokes.greninjaA = pokes.greninja
	pokes['658A'] = pokes.greninja
	
	-- AltForms/data
	forms.greninja.names.D = 'Evento Demo SL'
	forms.greninja.links.D = '<div class="small-text">[[Differenze di forma#Greninja|Evento Demo SL]]</div>'
	forms.greninja.blacklinks.D = '<div class="small-text">[[Differenze di forma#Greninja|<span style="color:#000">Evento Demo SL</span>]]</div>'
	forms.greninja.ext.evento = 'D'
	forms.greninja.gamesOrder = {'base', 'D', 'A'}
	forms.greninja.since.D = 'sl'
	
	forms[658] = forms.greninja
end

d.addGreninjaDemo()

return d
