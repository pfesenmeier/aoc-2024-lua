---@alias Rules table<integer, integer[]>

---@class (exact) Lib
---@field private beforeRules Rules 
---@field private afterRules Rules 
---@field private lines integer[][]
local Lib       = {}

---@param rules Rules
---@param key integer
---@param value integer
local function insert(rules, key, value)
    if rules[key] == nil then
        rules[key] = {}
    end
    table.insert(rules[key], value)
end

---@param rule 'before'|'after'
---@param key integer
---@param value integer
function Lib:hasRule(rule, key, value)
    local rules
    if rule == 'before' then
        rules = self.beforeRules
    else
        rules = self.afterRules
    end

    local entry = rules[key]
    -- print('here' .. rules)
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

---@param file string
---@return table
---@return table
---@return table
local function parseFile(file)
    local parseRules = true
    local beforeRules = {}
    local afterRules = {}
    local lines = {}
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
    return beforeRules, afterRules, lines
end

function Lib:new(file)
    local o = {}
    setmetatable(o, self)
    ---@diagnostic disable-next-line: inject-field
    self.__index = self
    local beforeRules, afterRules, lines = parseFile(file)
    o.beforeRules = beforeRules
    o.afterRules = afterRules
    o.lines = lines
    return o
end


return Lib
