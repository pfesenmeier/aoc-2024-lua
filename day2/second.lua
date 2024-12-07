-- local file = "./day2/sample.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input2.txt"

--- @param line string
--- @return fun(): number?
local function parseNums(line)
    local matches = line:gmatch('%d+')

    return function()
        local next = matches()
        if next then
            return tonumber(next)
        end
    end
end

---@param nums integer[]
--- @return fun(): number[]
local function numberSets(nums)
    local i = 0
    return function()
        if i == 0 then
            i = i + 1
            return nums
        end
        while i < #nums + 1 do
            local set = {}
            for index, value in ipairs(nums) do
                if index ~= i then
                    table.insert(set, value)
                end
            end
            i = i + 1
            return set
        end
    end
end

--- @param nums integer[]
--- @return boolean
local function isValid(nums)
    --- @type integer
    local prev = nil
    --- @type 'Increasing' | 'Decreasing' | nil
    local direction
    for index, value in ipairs(nums) do
        if index == 2 then
            if prev > value then
                direction = 'Decreasing'
            elseif prev < value then
                direction = 'Increasing'
            end
        end

        if index ~= 1 then
            if prev == value then
                return false
            end

            if prev > value and direction == 'Increasing' then
                return false
            end

            if prev < value and direction == 'Decreasing' then
                return false
            end

            local diff = math.abs(prev - value)

            if diff < 1 or diff > 3 then
                return false
            end
        end
        prev = value
    end

    return true
end

local answer = 0
for line in io.lines(file) do
    local nums = {}
    for num in parseNums(line) do
        table.insert(nums, num)
    end

    for set in numberSets(nums) do
        if isValid(set) then
            -- local shouldstop = false
            -- vim.ui.input({ prompt = line}, function(input)
            --     print(input)
            --     if input == 'x' then
            --         shouldstop = true
            --     end
            -- end)
            -- if shouldstop then return end
            answer = answer + 1
            break
        end
    end
end

print("the answer is:")
print(answer)
