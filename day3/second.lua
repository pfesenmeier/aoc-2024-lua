-- local file = "./day3/sample2.txt"
local file = os.getenv("HOME") .. "/Downloads/aoc2024/input3.txt"

local answer = 0
local enabled = true
for line in io.lines(file) do
    local current = 1
    while current < #line + 1 do
        local _, doEnd = string.find(line, "do%(%)", current)
        local _, dontEnd = string.find(line, "don't%(%)", current)
        local _, mulEnd = string.find(line, "mul%(%d%d*%d*,%d%d*%d*%)", current)
        doEnd = doEnd or #line + 1
        dontEnd = dontEnd or #line + 1
        mulEnd = mulEnd or #line + 1

        if doEnd < dontEnd and doEnd < mulEnd then
            enabled = true
            current = doEnd
        elseif dontEnd < doEnd and dontEnd < mulEnd then
            enabled = false
            current = dontEnd
        elseif mulEnd < doEnd and mulEnd < doEnd then
            local first, second = string.match(line, "mul%((%d%d*%d*),(%d%d*%d*)%)", current)
            if enabled then
                answer = answer + first * second
            end
            current = mulEnd
        else
            break
        end
    end
end

print("The answer is:")
print(answer)
