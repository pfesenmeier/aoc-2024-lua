local prompt = require "util.prompt"
local lib    = require "day4.lib"
-- local file   = "./day4/sample.txt"
local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input4.txt"

---@type string[]
local grid   = {}
for line in io.lines(file) do
    table.insert(grid, line)
end

---@param word string
---@return string|nil
local function sliceWord(word)
    local new = word:sub(2)
    if #new == 0 then
        return nil
    end
    return new
end

---@param point Point
---@return string|nil
local function getCurrent(point)
    local line = grid[point.y]

    if line == nil then
        return nil
    end

    return line:sub(point.x, point.x)
end

---@param word string word to find
---@param pos Point point to start
---@param dir [number, number] earch
---@return boolean found
local function findWord(word, pos, dir)
    local expected = word:sub(1, 1)
    local actual = getCurrent(pos)

    if #word == 1 then
        return expected == actual
    end

    if expected ~= actual then
        return false
    end

    local slice = sliceWord(word)
    if slice == nil then
        error("got a nil slice")
    end

    local newPos = {
        x = pos.x + dir[1],
        y = pos.y + dir[2]
    }

    return findWord(slice, newPos, dir)
end


---@param last Point
---@return integer numFound number of words found
local function findXs(last)
    local xmases = 0
    local firstLetter = "A"
    for y = 1, last.y, 1 do
        for x = 1, last.x, 1 do
            local current = getCurrent({ x = x, y = y })
            if current == firstLetter then
                local xs = 0
                for index, value in ipairs(lib.xdirection) do
                    local newPos = {
                        x = value[1] + x,
                        y = value[2] + y
                    }
                    if findWord('M', newPos, value) then
                        local oppPos = index + 2
                        if oppPos == 5 then
                            oppPos = 1
                        end
                        if oppPos == 6 then
                            oppPos = 2
                        end
                        local oppValue = lib.xdirection[oppPos]
                        local newOppPos = {
                            x = oppValue[1] + x,
                            y = oppValue[2] + y
                        }

                        if findWord('S', newOppPos, oppValue) then
                            -- prompt(string.format("found half %s, %s, %s", x, y, oppValue[3]))
                            xs = xs + 1
                        end
                    end
                end

                if xs == 2 then
                    -- prompt(string.format("found x %s, %s", x, y))
                    xmases = xmases + 1
                end
            end
        end
    end
    return xmases
end


local answer = findXs({ x = #grid[1], y = #grid })
print("The answer is:")
print(answer)
