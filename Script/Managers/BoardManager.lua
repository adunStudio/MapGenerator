require("/Script/Tile")
require("/Script/Wall")

BoardManager_ =
{
    COL = 5,
    ROW = 5,

    sight = 3,

    floorTileList = {},
    wallList = {}
}

function BoardManager_:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function BoardManager_:BoardSetup()
    for y = 0, self.ROW - 1 do
        for x = 0, self.COL - 1 do
            self.floorTileList[{x, y}] = Tile:New{x = x, y = y, type = math.random(32, 39)}
        end
    end

end

function BoardManager_:AddToBoard(h, v, player)
    local _x = player.x
    local _y = player.y
    local sightX = 0
    local sightY = 0

    -- right
    if h == 1 then
        sightX = _x + self.sight
        sightY = _y + 1

        for x = _x + 1, sightX, 1 do
            for y = _y - 1, sightY, 1 do
                self:AddTiles(x, y)
            end
        end

        return
    end

    -- left
    if h == - 1 then
        sightX = _x - self.sight
        sightY = _y + 1

        for x = sightX, _x - 1, 1 do
            for y = _y - 1, sightY, 1 do
                self:AddTiles(x, y)
            end
        end

        return
    end

    -- Down
    if v == 1 then
        sightX = _x + 1
        sightY = _y + self.sight

        for y = _y + 1, sightY, 1 do
            for x = _x - 1, sightX, 1 do
                self:AddTiles(x, y)
            end
        end

        return
    end

    if v == -1 then
        sightX = _x + 1
        sightY = _y - self.sight

        for y = sightY, _y - 1, 1 do
            for x = _x - 1, sightX, 1 do
                self:AddTiles(x, y)
            end
        end

        return
    end
end

function BoardManager_:AddTiles(x, y)
    local key = x .. ":" .. y

    if self.floorTileList[key] ~= nil then
        return nil
    end

    self.floorTileList[key] = Tile:New{x = x, y = y, type = math.random(32, 39)}

    if math.random(1, 5) == 1 then
        self.wallList[key] = Wall:New{x = x, y = y, type = math.random(24, 31)}
    end
end

function BoardManager_:IsWall(x, y)
    local key = x .. ":" .. y

    if self.wallList[key] == nil then
        return false
    end

    if self.wallList[key].hp <= 0 then
        return false
    end

    return true
end

function BoardManager_:Draw()
    for k in pairs(self.floorTileList) do
        self.floorTileList[k]:Draw()
    end

    for k in pairs(self.wallList) do
        self.wallList[k]:Draw()
    end

end
