require("Script/Managers/Camera")
require("Script/Managers/SpriteManager")
require("Script/Managers/DungeonManager")
require("Script/Managers/BoardManager")
require("Script/Managers/GameManager")

SpriteManager = nil
BoardManager = nil
DungeonManager = nil
GameManager = nil
Camera = nil

function LoadManagers()
    Camera = Camera_:New{}

    SpriteManager = SpriteManager_:New{}
    SpriteManager:Initialize()

    DungeonManager = DungeonManager_:New{}
    
    BoardManager = BoardManager_:New{}

    GameManager = GameManager_:New{}
end
