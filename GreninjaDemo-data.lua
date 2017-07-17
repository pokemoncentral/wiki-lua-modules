-- Modulo per gestire Greninja Demo SL

--[[

!!! ATTENZIONE !!!

Questo modulo modifica le copie cachate dei
moduli dati Poké/data e AltForms/data
aggiungendo la forma Demo SL di Greninja

--]]

local d = {}
local pokes = require('Poké-data')
local stats = require('PokéStats-data')
local forms = require('AltForms-data')

-- Poké/data
pokes.greninjaD, pokes['658D'] = pokes.greninja, pokes.greninja

-- AltForms/data
forms.greninja.names.D = 'Evento Demo SL'
forms.greninja.changeability = {'A', 'D'}
forms.greninja.links.D = '<div class="small-text">[[Differenze di forma#Greninja|Evento Demo SL]]</div>'
forms.greninja.blacklinks.D = '<div class="small-text">[[Differenze di forma#Greninja|<span style="color:#000">Evento Demo SL</span>]]</div>'
forms.greninja.ext.evento = 'D'
forms.greninja.gamesOrder = {'base', 'D', 'A'}
forms.greninja.since.D = 'sl'

return d
