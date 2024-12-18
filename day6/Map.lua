---@class Location
---@field x integer
---@field y integer

-- metatable for meta-capabiities
-- __index meta-capability for field access
-- form https://stackoverflow.com/a/46750129
---@class Map
---@field private positions string[][]
---@field direction '<'|'v'|'>'|'^'
---@field location Location
local Map = {
    moves = 0,
}
Map.__index = Map

function Map:new(positions, direction, location)
    local o = {}
    setmetatable(o, self)

    o.positions = positions
    o.direction = direction
    o.location = location
    return o
end

function Map.create(path)
    local positions = {}
    local direction
    local location
    local j = 1
    for line in io.lines(path) do
        local row = {}
        for i = 1, #line do
            local char = line:sub(i, i)
            if char == '>' or char == '<' or char == '^' or char == 'v' then
                direction = char
                location = { x = i, y = j }
            end
            table.insert(row, char)
        end
        table.insert(positions, row)
        j = j + 1
    end
    return Map:new(positions, direction, location)
end

function Map:get(location)
    local row = self.positions[location.y]
    if row == nil then
        return nil
    end

    return row[location.x]
end

function Map:set(x, y, char)
    local row = self.positions[y]
    if row == nil then
        error('tried to set outside of map')
    end

    if row[x] ~= nil then
        self.positions[y][x] = char
    else
        error('tried to set outside of map')
    end
end

function Map:print()
    for _, row in ipairs(self.positions) do
        local line = ""
        for _, char in ipairs(row) do
            line = line .. char
        end
        print(line)
    end
end

function Map:count_visited()
    local visited = 0
    for _, row in ipairs(self.positions) do
        for _, char in ipairs(row) do
            if char ~= '.' and char ~= '#' then
                visited = visited + 1
            end
        end
    end
    return visited
end

return Map
