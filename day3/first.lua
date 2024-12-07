local prompt = require "util.prompt"
-- local file = "./day3/sample.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input3.txt"

local answer = 0
for line in io.lines(file) do
    for first, second in string.gmatch(line, "mul%((%d%d*%d*),(%d%d*%d*)%)") do
        answer = answer + first * second
    end
    -- if not prompt(line) then break end
end

print("The answer is:")
print(answer)
