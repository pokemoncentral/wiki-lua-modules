-- "Test cases" for Typelist

local typelist = require('Typelist').typelist

-- No real corner cases exist
print(typelist{args={'Fuoco'}})

if #arg > 0 then
    -- Specific ability from command line
    print(typelist{args={arg[1]}})
end
