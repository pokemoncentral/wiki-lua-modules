local e = {}

e.printHeading = function(testName, args)
    local line = {
        "~~~~~~~~~~~~~~",
        testName,
    }

    local stringArgs = {}
    for key, value in pairs(args and args.args or args or {}) do
        stringArgs[key] = tostring(value)
    end
    if #stringArgs > 0 then
        table.insert(line, "-")
        table.insert(line, "[")
        table.insert(line, table.concat(stringArgs, ", "))
        table.insert(line, "]")
    end

    table.insert(line, "~~~~~~~~~~~~~~")

    print("")
    print(table.concat(line, " "))
    print("")
end

return e
