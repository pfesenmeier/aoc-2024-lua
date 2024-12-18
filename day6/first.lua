package.loaded['day6.Map'] = nil
package.loaded['day6.Guard'] = nil
local Guard = require 'day6.Guard'
local file = './day6/sample.txt'
-- local file   = os.getenv("HOME") .. "/Downloads/aoc2024/input6.txt"
local Map = require 'day6.Map'

local map = Map.create(file)
local guard = Guard:new(map)

while guard:get_state() ~= 'about_to_exit' do
    if guard:get_state() == 'obstructed' then
        guard:turn_right()
    else
        local nextLocation = guard:get_state()
        guard:move(nextLocation)
    end
end
print(guard.map:count_visited())
