---@alias Dirr '^'|'v'|'<'|'>'

---@class Guard
---@field map Map
---@field direction Dirr
---@field location Location

---@class Guard
local Guard = {}
Guard.__index = Guard


---@param map Map
---@return Guard
function Guard:new(map)
    local o = {}
    setmetatable(o, self)
    o.direction = map.direction
    o.map = map
    o.location = map.location
    return o
end

---@alias State 'obstructed'|'about_to_exit'|Location

---@return State
function Guard:get_state()
    local dir = self.direction
    local location = {
       x = self.location.x,
       y = self.location.y
    }

    if dir == '^' then
        location.y = location.y - 1
    elseif dir == '<' then
        location.x = location.x - 1
    elseif dir == '>' then
        location.x = location.x + 1
    elseif dir == 'v' then
        location.y = location.y + 1
    else
        error('unknown dir')
    end

    local next = self.map:get(location)
    if next == nil then
        return 'about_to_exit'
    elseif next == '#' then
        return 'obstructed'
    else
        return location
    end
end

function Guard:turn_right()
    local dir = self.direction
    if dir == '<' then
        self.direction = '^'
    elseif dir == '>' then
        self.direction = 'v'
    elseif dir == 'v' then
        self.direction = '<'
    elseif dir == '^' then
        self.direction = '>'
    else
        error('unknown dir')
    end
end

function Guard:move(location)
    local prev = self.location

    self.map:set(prev.x, prev.y, self.direction)

    self.location = location

    if self.direction == self.map:get(location) then
        return true
    end

    self.map:set(location.x, location.y, self.direction)
end

return Guard
