-- start forth shell
local interpret, stack = ...

local term = require("term")
local component = require("component")
local gpu = component.gpu

while true do
    local oldColor = gpu.getForeground()
    gpu.setForeground(0x09bbff)
    term.write("forth>")
    gpu.setForeground(0xffffff)

    local code = term.read()
    if code == "exit" then
        break
    end
    local result = interpret(code)

    term.write(code)
end
