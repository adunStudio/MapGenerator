Tile =
{
    x = 0,
    y = 0,
    type = 0,
}

function Tile:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Tile:Draw()
    SpriteManager:Draw(self.type, self.x, self.y)
end
