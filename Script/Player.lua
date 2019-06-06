Player =
{
    wallDamage = 1,
    health = 3,
    x = 0,
    y = 0,

    flipX = 1,

    type = 0,

    time = 0,
    animationTime = 0.15
}

function Player:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Player:Update(dt)
    self.time = self.time + dt
    if self.time >= self.animationTime then
        self.type = self.type + 1
        self.type = self.type % 6
        self.time = 0
    end


    if GameManager.playerTurn == false then
        return
    end

    local canMove = false

    if KEY_H ~= 0 then
        KEY_V = 0
    end

    if KEY_H ~= 0 or KEY_V ~= 0 then
        if GameManager:IsMoveAble(self.x + KEY_H, self.y + KEY_V) == true then
            self.x = self.x + KEY_H
            self.y = self.y + KEY_V

            BoardManager:AddToBoard(KEY_H, KEY_V, self)
        end

        if KEY_H ~= 0 then
            self.flipX = KEY_H
        end

    end

end

function Player:Draw()
    if self.flipX == -1 then
        love.graphics.draw(SPRITE_SHEET, SpriteManager.quads[self.type], self.x * SpriteManager.widthHeight, self.y * SpriteManager.widthHeight, 0, -2, 2, 32, 0)
    else
        love.graphics.draw(SPRITE_SHEET, SpriteManager.quads[self.type], self.x * SpriteManager.widthHeight, self.y * SpriteManager.widthHeight, 0, 2,  2)
    end
end
