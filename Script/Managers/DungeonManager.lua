require("Script/PathTile")

DungeonManager_ = {
    minBound = 0,
    maxBound = 0,

    tileList = {},

    startPos = {},
    endPos = {}
}

function DungeonManager_:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function DungeonManager_:StartDungeon()
    self.tileList = {}
    self.tileList[TileType.ESSENTIAL] = {}
    self.tileList[TileType.RANDOM]    = {}
    self.tileList[TileType.EMPTY]     = {}

    self.maxBound = math.random(50, 100)

    self:BuildEssentialPath()
end

function DungeonManager_:BuildEssentialPath()
    local randomY = math.random(0, self.maxBound)

    local pathTile = PathTile(0, randomY, TileType.ESSENTIAL, math.random(32, 39), self.minBound, self.maxBound, self.tileList)

    startPos = pathTile
end
