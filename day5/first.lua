local prompt      = require "util.prompt"
-- local lib    = require "day5.lib"
local file        = "./day5/sample.txt"
-- local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input5.txt"

---@alias Rules table<integer, integer[]>

---@type Rules
local beforeRules = {}
---@type Rules
local afterRules  = {}

---@type integer[][]
local lines       = {}

---@param lineNo number
---@param pos number
---@return number|nil
local function getNum(lineNo, pos)
    local line = lines[lineNo]
    if line == nil then
        error('tried to get nul line')
        return nil
    end

    return line[pos]
end

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

---@param lineNo number
local function checkAfter(lineNo) 
    local pos = 1
    while pos <= #lines do
        local current = getNum(lineNo, pos)
        for i = pos, 1, -1 do
            local before = getNum(lineNo, i)
            if hasRule(beforeRules, before, current) then
                goto continue

            end
            ::continue::
        end
        pos = pos + 1
    end


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

for i, line in ipairs(lines) do
end



local answer = 0
print("The answer is:")
print(answer)
