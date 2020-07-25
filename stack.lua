
local module = {}

module.Stack = {}

function module.add(number)
    if typeof(number) == "number" then
        table.insert(module.Stack, number)
    else
        error('Incorrect arg 1 on stack.Add(). Expected type "number," got type "'..typeof(number)..'."')
    end
end

function module.drop()
    table.remove(module.Stack)
end

return module