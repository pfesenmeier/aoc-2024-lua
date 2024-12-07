local lib = {}

---@enum (key) Direction
lib.direction = {
    Up = { 0, 1 },
    UpRight = { 1, 1 },
    Right = { 1, 0 },
    DownRight = { 1, -1 },
    Down = { 0, -1 },
    DownLeft = { -1, -1 },
    Left = { -1, 0 },
    UpLeft = { -1, 1 },
}

lib.xdirection = {
    { -1, 1, "UpLeft" },
    { -1, -1, "DownLeft" },
    { 1,  -1, "DownRight" },
    { 1,  1, "UpRight" },
}

return lib
