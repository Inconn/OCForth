-- stack object

local stack = {}

function stack.new()

    local t = {}

    t._entries = {}

    function t.push(...)
        if ... then
            local targs = {...}

            for i,v in ipairs(targs) do
                table.insert(t._entries, v)
            end
        end
    end

    function t.pop()

        local num = t._entries[#t._entries]

        table.remove(t._entries)
        return num
    end

    return t
end

return stack
