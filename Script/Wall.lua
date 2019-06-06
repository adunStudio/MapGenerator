Wall =
{
    type = 0,
    hp = 3,
    x
}

function Wall:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Wall:Attacked(damage)
    self.hp = self.hp - damage
end

function Wall:Draw()
    if self.hp <= 0 then
        return
    end

    SpriteManager:Draw(self.type, self.x, self.y)
end
