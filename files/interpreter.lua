-- interpret and run forth code.

local dictionary = require("./dictionary.lua")
local stackLib = require("./stack.lua")
local termLib = require("term")

local stack = stackLib.new()

function interpret(l)
    local line = l
    -- remove comments so the interpreter doesn't try to interpret them.
    line = string.gsub(line, "%((.-)%)", "")
    line = " " .. line .. " "

    local terms = {}
    string.gsub(line, "% (.-)% ", function(a) table.insert(terms, a)) end
    local returnStr = ""

    local termDefinition = false -- true when defining a new term
    local newTermName = "" -- name of new term
    local termCode = "" -- code of new term
    for index, termName in pairs(terms) do
        -- check each term.
        local term = dictionary:lookUp(termName)
        if term == nil and not termDefintion then
            -- term isn't in dictionary, throw error.
            return termName .. " is not defined"
        elseif term.codetype == "lua" and not termDefiniton then
            -- run the term as lua
            local name, env = debug.getupvalue(interpret, 1)
            local ret = load(term.code, "term "..termName)(stack, term)
            if ret then
                if returnStr == "" then
                    returnStr = ret
                else
                    returnStr = returnStr .. " " .. ret
                end
            end
        elseif term.codetype == "forth" and not termDefintion then
            -- interpret term as forth
            interpret(term.code)
        end
        if termDefinition then
            if newTermName == "" then
                -- set name of new term
                newTermName = termName
            elseif term == nil
                return termName .. " is not defined"
            elseif termName == ";"
                -- end definition of term and add term to dictionary
                termDefinition = false
                dictionary.addEntry(newTermName, string.sub(termCode, 2, -1))
                newTermName = ""
                termCode = ""
            else
                -- add code to new term
                termCode = termCode .. " " .. termName
            end
        end
    end
    if returnStr == "" then
        return "ok"
    else
        return returnStr .. " ok"
    end
end

return interpret, stack
