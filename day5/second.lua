local prompt               = require "util.prompt"
package.loaded["day5.lib"] = nil
local Lib                  = require "day5.lib"
-- local file                 = "./day5/sample1.txt"
local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input5.txt"
local lib                  = Lib:new(file)

---@param nums number[]
local function printLine(nums)
    local l = ""
    for index, value in ipairs(nums) do
        l = l .. ',' .. value
    end
    print(l)
end

---@param line number[]
local function checkLToR(line)
    local wasCorrect = true
    local isDone = false
    while isDone == false do
        local i = 1
        local wasCorrectedThisPass = false
        while i < #line + 1 do
            local j = i - 1
            while j > 0 do
                local current = line[i]
                local prev = line[j]
                if lib:hasRule('after', prev, current) then
                    line[j], line[i] = current, prev
                    wasCorrect = false
                    wasCorrectedThisPass = true
                end
                j = j - 1
            end
            i = i + 1
        end
        if not wasCorrectedThisPass then
            -- print('nothing changed')
            isDone = true
        else
            -- print('something changed')
        end
    end
    return wasCorrect
end


local answer = 0
for _, line in ipairs(lib.lines) do
    if not checkLToR(line) then
        local middleIndex = (#line - 1) / 2 + 1

        answer = answer + line[middleIndex]
    end
end

print("The answer is:")
print(answer)
