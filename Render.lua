--[[

Modulo per ridurre le chiamate a lua in caso di molti entry

This module is used when there's the need to invoke the same module
function many times in a row (for instance when each call is an entry
of a list). The goal of this module is to squash all calls in a single
#invoke in order to make it much more lightweight.

The syntax is as follows

{{#invoke: render | render | <module> | <function> | <separator>
| <parameters of the first  entry> | <separator>
| <parameters of the second entry> | <separator>
...
}}

The separator should be a (possibly empty) sequence of "-" enclosed
between "/". For instance "/-/" or "/--/"; also "//" is fine.

Unnamed parameters for a single entry are put as you would in a normal
invocation, so values separated by |. For named parameter you have to use
a slightly different syntax:
<param name> <- <value>
again separated by a |

So for instance a pair of invocations like

{{#invoke: somemodule | somefunction | arg11 | arg12 | arg13 | key1 = val11 | key2 = val12 }}
{{#invoke: somemodule | somefunction | arg21 | arg22 | arg23 | key1 = val21 }}

becomes

{{#invoke: render | render | somemodule | somefunction | //
| arg11 | arg12 | arg13 | key1 <- val11 | key2 <- val12 | //
| arg21 | arg22 | arg23 | key1 <- val21 | //
}}

(note: the last separator // is optional, but my suggestion is to add it)

--]]

local r = {}

local mw = require("mw")

-- stylua: ignore
local w = require('Wikilib')

require("Wikilib-tables") -- use table metatable extensions

-- Deprecated function
r.entry = function(frame)
    local p = w.trimAll(mw.clone(frame.args))
    local modu = require("" .. p[1]:match("^(.+)%."))
    local func = p[1]:match("%.([%a%d]+)$")
    table.remove(p, 1)

    return w.mapAndConcat(p, "\n", function(value)
        local prepared = value:gsub("%[%[(.*)%]%]", "%1"):gsub("|", "£€")

        local mockFrame = { args = {} }

        for param in prepared:gmatch("€(.-)£") do
            local k, v = param:match("^(.+)=(.+)$")
            if k and v then
                mockFrame.args[k] = v
            else
                table.insert(mockFrame.args, param)
            end
        end
        return modu[func](mockFrame)
    end)
end

--[[

New render function.

The previous function was based on a hack of MediaWiki, so we decided
it is better to have a nicer syntax. Also because the current implementation
has problems if you want to put a link/template within the entry.

For the syntax check the doc at the top of the file.

--]]
r.renderLua = function(moduleFunc, args)
    local separator = table.remove(args, 1)
    -- Check if separator matches the standard
    if not separator:match("^/%-*/$") then
        error("Ill formatted separator")
    end
    -- The last separator is optional. If not given, adds it
    if args[#args] ~= separator then
        table.insert(args, separator)
    end

    local mockArgs = {}
    local res = {}
    for i = 1, #args do
        local param = args[i]
        if not param then
            print(i, "'" .. param .. "'")
            return
        end
        if param == separator then
            table.insert(res, moduleFunc(unpack(mockArgs)))
            -- Prepare for the next call
            mockArgs = {}
        else
            local beg = param:find("<%-")
            if beg then
                local key = string.trim(param:sub(1, beg - 1))
                mockArgs[key] = string.trim(param:sub(beg + 2))
            else
                table.insert(mockArgs, args[i])
            end
        end
    end

    return table.concat(res, "\n")
end

r.render = function(frame)
    local p = w.trimAll(mw.clone(frame.args), false)
    local modulename = p[1]
    local module
    if modulename:sub(1, 7) == "Modulo:" then
        module = require(modulename)
    else
        -- This becomes require("Modulo:" .. modulename) before upload to PCW
        module = require("" .. modulename)
    end
    local moduleFunc = module[p[2]]
    local luaModuleFunc = function(...)
        return moduleFunc({ args = { ... } })
    end
    return r.renderLua(luaModuleFunc, table.slice(p, 3))
end

return r
