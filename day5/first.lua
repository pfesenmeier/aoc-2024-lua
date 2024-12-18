local prompt      = require "util.prompt"
package.loaded["day5.lib"] = nil
local Lib    = require "day5.lib"
local file        = "./day5/sample.txt"
-- local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input5.txt"
local lib = Lib:new(file)

---@param line number[]
---@diagnostic disable-next-line: unused-function
local function checkLToR(line)
    local i = 1
    while i < #line + 1 do
        local current = line[i]
        local j = i - 1
        while j > 0 do
            local prev = line[j]
            if lib:hasRule('after', prev, current) then
                return false
            end
            j = j - 1
        end
        i = i + 1
    end
    return true
end

local answer = 0
for _, line in ipairs(lib.lines) do
    if checkLToR(line) then
        local middleIndex = (#line - 1) / 2 + 1

        answer = answer + line[middleIndex]
    end
end

print("The answer is:")
print(answer)
