local prompt      = require "util.prompt"
-- local lib    = require "day5.lib"
-- local file        = "./day5/sample.txt"
local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input5.txt"

---@alias Rules table<integer, integer[]>

---@type Rules
local beforeRules = {}
---@type Rules
local afterRules  = {}

---@type integer[][]
local lines       = {}

---@param rules Rules
---@param key integer
---@param value integer
local function hasRule(rules, key, value)
    local entry = rules[key]
    if entry == nil then
        return nil
    end
    for _, val in ipairs(entry) do
        if value == val then
            return true
        end
    end

    return false
end

---@param rules Rules
---@param key integer
---@param value integer
local function insert(rules, key, value)
    if rules[key] == nil then
        rules[key] = {}
    end
    table.insert(rules[key], value)
end

---@param line number[]
---@diagnostic disable-next-line: unused-function
local function checkLToR(line)
    local i = 1
    while i < #line + 1 do
        local current = line[i]
        local j = i - 1
        while j > 0 do
            local prev = line[j]
            if hasRule(afterRules, prev, current) then
                return false
            end
            j = j - 1
        end
        i = i + 1
    end
    return true
end

local parseRules = true
for line in io.lines(file) do
    if #line == 0 then
        parseRules = false
    elseif parseRules == true then
        local first = tonumber(string.sub(line, 1, 2))
        local second = tonumber(string.sub(line, 4))
        ---@cast first -?
        ---@cast second -?
        insert(beforeRules, first, second)
        insert(afterRules, second, first)
    else
        local nums = {}
        for m in string.gmatch(line, "%d%d") do
            table.insert(nums, tonumber(m))
        end
        table.insert(lines, nums)
    end
end


local answer = 0
for _, line in ipairs(lines) do
    if checkLToR(line) then
        local middleIndex = (#line - 1) / 2 + 1

        answer = answer + line[middleIndex]
    end
end

print("The answer is:")
print(answer)
