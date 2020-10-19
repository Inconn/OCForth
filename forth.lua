-- load interpreter, get stack (interpreter loads stack)
local interpret, stack = require("./interpreter.lua")

local term = require("term")
local shell = require("shell")
-- parse args (no ops)
local args = shell.parse()
if #args == 0 then
    -- start shell
    loadfile("./files/forth_shell.lua")(interpret, stack))
else
    -- run forth code
    local ret = interpret()
    term.write(ret, true)
end
