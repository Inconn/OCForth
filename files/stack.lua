-- stack object

local stack = {}

function stack:new()

    local t = {}

    t._entries = {}

    function t:push(...)
        if ... then
            local targs = {...}

            for _,v in ipairs(targs) do
                table.insert(self._entries, v)
            end
        end
    end

    function t:pop()

        local num = self._entries[#self._entries]

        table.remove(self._entries)
        return num
    end

    return t
end

return stack
