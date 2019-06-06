require("Script/Player")

GameManager_ =
{
    turnDelay = 0.1,

    hp = 100,

    playerTurn = true,

    enemyList = {},

    player = nil
}

function GameManager_:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function GameManager_:InitGame()
    BoardManager:BoardSetup()

    self.enemyList = {}

    self.player = Player:New{x = 2, y = 2}

end

function GameManager_:Draw()
    Camera:Set()

    BoardManager:Draw()
    self.player:Draw()

    Camera:Unset()
end

function GameManager_:Update(dt)
    self.player:Update(dt)
    Camera:SetPosition(self.player.x * 64 - love.graphics.getWidth() / 2  + 32, self.player.y * 64 - love.graphics.getHeight()/ 2 + 32 )

    if self.playerTurn == false then
        return
end

function GameManager_:IsMoveAble(x, y)
    if BoardManager:IsWall(x, y) == true then
        return false
    end

    return true
end





end
