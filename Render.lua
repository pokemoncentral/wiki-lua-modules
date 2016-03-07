-- Modulo per ridurre le chiamate a lua in caso di molti entry

local r = {}

local w = require('Modulo:Wikilib')
local tab = require('Modulo:Wikilib/tables')

r.entry = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    local modu = require('Modulo:' .. p[1]:match('^(.+)%.'))
    local func = p[1]:match('%.(%a+)$')
    table.remove(p, 1)

    return table.concat(table.map(p, function(value)
			local prepared = value:gsub('%[%[(.*)%]%]', '%1')
					:gsub('|', '£€')
        
			local mockFrame = {args={}}
        
			for param in prepared:gmatch('€(.-)£') do
				local k, v = param:match('^(.+)=(.+)$')
				if k and v then
					mockFrame.args[k] = v
				else
					table.insert(mockFrame.args, param)
				end
			end
			return modu[func](mockFrame)
		end), '\n')
end

print(r.entry{args=arg})
-- return r
