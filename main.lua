require("Script/Managers/LoadManagers")
require("Script/PathTile")
local FPS = 1 / 30
local nextTime = 0


KEY_H = 0
KEY_V = 0

function love.load()
    math.randomseed(os.time())

    love.window.setMode(64 * 16, 64 * 9)

    nextTime = love.timer.getTime()

    clientWidth, clientHeight = love.graphics.getDimensions()


    LoadManagers()

    GameManager:InitGame()

    DungeonManager:StartDungeon()

    local backgroundMusic = love.audio.newSource("Sound/background.wav", "stream")
    backgroundMusic:play()
end

function love.update(dt)
    nextTime = nextTime + FPS

    --GameManager:Update(dt)

    KEY_H = 0
    KEY_V = 0
end


function love.draw()

    --GameManager:Draw()
    DungeonManager:Draw()

    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS( )), 10, 10)

    local curTime = love.timer.getTime()
    if nextTime <= curTime then
        nextTime = curTime
        return
    end
    love.timer.sleep(nextTime - curTime)
end

function love.keypressed(key, unicode)
    if love.keyboard.isDown("up", "w") then
        KEY_V = -1
    end

    if love.keyboard.isDown("down", "s") then
        KEY_V = 1
    end

    if love.keyboard.isDown("left", "a") then
        KEY_H = -1
    end

    if love.keyboard.isDown("right", "d") then
        KEY_H = 1
    end
end
