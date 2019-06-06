SPRITE_SHEET = nil

SpriteManager_ =
{
    WIDTH_HEIGHT = 32,
    WIDTH_EX = 8,
    HEIGHT_EX = 7,

    -- 스프라이트 전체 크기 --
    spriteWidth = 256,
    spriteHeight = 224,

    widthHeight = 64,

    quads = {},
    x = 0,
    y = 0
}

function SpriteManager_:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function SpriteManager_:Initialize()
    SPRITE_SHEET = love.graphics.newImage("/Image/spritesheet.png")

    local ex = self.WIDTH_EX * self.HEIGHT_EX
    for type = 0, ex, 1 do
        self.quads[type] = love.graphics.newQuad((type % self.WIDTH_EX) * self.WIDTH_HEIGHT, math.floor(type / (self.HEIGHT_EX + 1)) * self.WIDTH_HEIGHT, self.WIDTH_HEIGHT, self.WIDTH_HEIGHT, self.spriteWidth, self.spriteHeight)
    end
end

function SpriteManager_:Draw(type, x , y)
    love.graphics.draw(SPRITE_SHEET, self.quads[type], x * self.widthHeight, y * self.widthHeight, 0, 2, 2)
end
