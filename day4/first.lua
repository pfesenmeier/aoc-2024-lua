local prompt = require "util.prompt"
local lib = require"day4.lib"
-- local file = "./day4/sample.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input4.txt"

---@type string[]
local grid = {}
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

---@class Point
---@field x integer
---@field y integer

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
---@param dir Direction direction to search
---@return boolean found
local function findWord(word, pos, dir)

    local expected = word:sub(1,1)
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

    local next = lib.direction[dir]
    local newPos = {
        x = pos.x + next[1],
        y = pos.y + next[2]
    }

    return findWord(slice, newPos, dir)
end


---@param word string
---@param last Point
---@return integer numFound number of words found
local function findWords(word, last)
    local xmases = 0
    local firstLetter = word:sub(1, 1)
    local slice = sliceWord(word)
    if slice == nil then
        error("got a nil slice")
    end
    for y = 1, last.y, 1 do
        for x = 1, last.x, 1 do
            local current = getCurrent({ x = x, y = y })
            if current == firstLetter then
                -- if not prompt(string.format("found x: %s, %s", x, y)) then return -1 end
                for key, value in pairs(lib.direction) do
                    local newPos = {
                        x = value[1] + x,
                        y = value[2] + y
                    }
                    if findWord(slice, newPos, key) then
                        -- if not prompt(string.format("found: %s, %s, direction: %s", x, y, key)) then return -1 end
                        xmases = xmases + 1
                    end
                end
            end
        end
    end
    return xmases
end


local answer = findWords("XMAS", { x = #grid[1], y = #grid })
print("The answer is:")
print(answer)
