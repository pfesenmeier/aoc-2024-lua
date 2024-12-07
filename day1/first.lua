-- local file = "./day1/sample.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input1.txt"
local left = {}
local right = {}
for line in io.lines(file) do
    local l = line:sub(1, 5)
    local r = line:sub(9)

    table.insert(left, l)
    table.insert(right, r)
end

table.sort(left)
table.sort(right)

local answer = 0

for index, l in ipairs(left) do
    local r = right[index]
    local diff = math.abs(r - l)

    answer = answer + diff

end

print("the answer is:")
print(answer)
