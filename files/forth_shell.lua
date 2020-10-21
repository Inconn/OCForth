-- start forth shell
local interpret, stack = ...

local term = require("term")
local component = require("component")
local gpu = component.gpu

term.write("Forth shell made by Incon\n Type \"exit\" to stop.")

while true do
    local oldColor = gpu.getForeground()
    gpu.setForeground(0x09bbff)
    term.write("forth>")
    gpu.setForeground(0xffffff)

    local code = io.read()
    if code == "exit" then
        break
    end
    local result = interpret(code)

    term.write(result.."\n")
end
