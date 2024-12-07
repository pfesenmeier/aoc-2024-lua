-- local file = "./day1/sample.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input1.txt"
local left = {}
local right = {}
for line in io.lines(file) do
    local l = line:sub(1, 5)
    local r = line:sub(9)

    table.insert(left, tonumber(l))
    table.insert(right, tonumber(r))
end

local freqs = {}
for _, l in ipairs(left) do
    if freqs[l] == nil then
        local freq = 0
        for _, r in ipairs(right) do
            if r == l then
                freq = freq + 1
            end
        end
        table.insert(freqs, l, freq)
    end
end

local answer = 0
for _, l in ipairs(left) do
    if freqs[l] then
        answer = answer + freqs[l] * l
    end
end

print("the answer is:")
print(answer)
