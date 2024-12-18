package.loaded['day6.Map'] = nil
package.loaded['day6.Guard'] = nil
local Guard = require 'day6.Guard'
-- local file = './day6/sample.txt'
local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input6.txt"
local Map = require 'day6.Map'

local sampleMap = Map.create(file)
local numRows = #sampleMap.positions
local numCols = #sampleMap.positions[1]

local validLocations = 0

local function detectTimeLoop(guard)
    local turns = 0
    while guard:get_state() ~= 'about_to_exit' do
        if turns > 1000000 then
            print('short circuit')
            return true
        end
        if guard:get_state() == 'obstructed' then
            guard:turn_right()
        else
            local nextLocation = guard:get_state()
            if guard:move(nextLocation) then
                return true
            end
        end
        turns = turns + 1
    end
    return false
end

for i = 1, numRows do
    for j = 1, numCols do
        local map = Map.create(file)
        local guard = Guard:new(map)

        ---@diagnostic disable-next-line: empty-block
        if i == map.location.y and j == map.location.x then
            -- skip starting location
        elseif map:get({ x = i, y = j }) ~= '#' then
            guard.map:set(i, j, '#')
            if detectTimeLoop(guard) then
                validLocations = validLocations + 1
                print('found: ' .. validLocations)
            end
        end
        print('iter: ' .. j .. ', ' .. i)
    end
end

print("the answer is")
print(validLocations)
