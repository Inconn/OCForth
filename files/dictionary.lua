local filesystem = require("filesystem")

local json = require("./json.lua")

local dictionary = {}
dictionary.entries = {}

-- load dictionary
if not filesystem.exists("./dictionary.json") then
    filesystem.copy("./defaultdictionary.json", "./dictionary.json")
end
dictionary.entries = json.decode(io.open("./dictionary.json", "r").read("*a"))

for i, v in pairs(dictionary.entries) do

end

-- lookup for entry
function dictionary:lookUp(entryName)
    return dictionary.entries[entryName]
end

-- add entry to dictionary
function dictionary:addEntry(entryName, entryCode)
    dictionary.entries[entryName] =
    {
        "codetype" = "forth",
        "code" = entryCode
    }
end

-- save dictionary
function dictionary:saveDictionary()
    io.open("./dictionary.json", "w").write(json.encode(dictionary.entries))
end

return dictionary
