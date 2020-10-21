-- interpret and run forth code.

local dictionary = require("./dictionary.lua")
local stackLib = require("./stack.lua")
local termLib = require("term")

local stack = stackLib.new()

function interpret(l)
    local line = string.sub(l, 1, string.len(l)-1)
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
        -- check each term to determine if it's valid or not

        local term = dictionary.lookUp(termName)
        print(term)
        if termDefinition then -- check if there is a new term being defined.
            if newTermName == "" then
                -- set name of new term
                newTermName = termName
            elseif term == nil or type(tonumber(termName)) == "number" then
                return termName .. " is not defined"
            elseif termName == ";" then
                -- end definition of term and add term to dictionary
                termDefinition = false
                dictionary.addEntry(newTermName, string.sub(termCode, 2, -1))
                newTermName = ""
                termCode = ""
            else
                -- add code to new term
                termCode = termCode .. " " .. termName
            end
        elseif type(tonumber(termName)) == "number" then -- if there's no term being defined, check if the term is a number.
            stack.push(tonumber(term))
        elseif term == nil and not termDefintion then -- if it's not a number, check if the term exists in the dictionary.
            -- term isn't in dictionary, throw error.
            return termName .. " is not defined"
        elseif term.codetype == "lua" and not termDefiniton then -- if it does exist, check if it's lua.
            -- run the term as lua
            local ret = load(term.code, "term "..termName)(stack, term)
            if ret
                if string.sub(ret, 1, 4) == "Err:" then
                    return string.sub(ret, 4)
                elseif returnStr == "" then
                    returnStr = ret
                else
                    returnStr = returnStr .. " " .. ret
                end
            end
        elseif term.codetype == "forth" and not termDefintion then -- if it does exist, check if it's forth
            -- interpret term as forth
            interpret(term.code)
        end
    end
    if returnStr == "" then
        return "ok"
    else
        return returnStr .. " ok"
    end
end

return interpret, stack
