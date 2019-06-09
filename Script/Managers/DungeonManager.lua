require("Script/PathTile")
require("Script/Utils/Queue")

DungeonManager_ = {
    minBound = 0,
    maxBound = 0,

    chamberSize = 3,

    tileList = {},

    gridPosition = {},

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
    self.gridPosition = {}
    self.tileList = {}

    self.maxBound = 8-- math.random(50, 100)

    -- 필수 경로 --
    self:BuildEssentialPath()

    -- 무작위 경로 ()필수 경로에 무작위 길을 추가) --
    self:BuildRandomPath()
end

function DungeonManager_:Draw()
    for i = 1, #self.tileList, 1 do
        self.tileList[i]:Draw()
    end
end

-- 입구부터 출구까지의 필수 경로 --
function DungeonManager_:BuildEssentialPath()
    -- 랜덤 시작점
    local randomY = math.random(0, self.maxBound)

    local ePath = PathTile(0, randomY, TileType.ESSENTIAL, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)
    ePath.id = 0
    local nextEPathPosX = 0
    local nextEPathPosY = 0
    local nextEPath = nil

    self.startPos = {x = ePath.x, y = ePath.y}

    local key = ""

    -- 그리드 길이를 따라 얼마나 멀리 왔는지를 추적
    -- maxBound와 같아질 때까지 필수 경로가 오른쪽으로 이동(boundTracker += 1)
    local boundTracker = 0

    while boundTracker < self.maxBound do
        key = ePath.x .. ":" .. ePath.y
        self.gridPosition[key] = TileType.ESSENTIAL
        table.insert(self.tileList, ePath)


        local adjacentTileCount = #(ePath.adjacentPathTiles)
        local randomIndex = math.random(1, adjacentTileCount)

        if adjacentTileCount > 0 then
            nextEPathPosX = ePath.adjacentPathTiles[randomIndex].x
            nextEPathPosY = ePath.adjacentPathTiles[randomIndex].y
        else
            break
        end

        nextEPath = PathTile(nextEPathPosX, nextEPathPosY, TileType.ESSENTIAL, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)

        -- 오른쪽으로 이동했다면 boundTracker += 1
        --if nextEPath.x > ePath.x or (nextEPath.x == self.maxBound - 1 and math.random(0, 1) == 1) then
        if nextEPath.x > ePath.x or (nextEPath.x == self.maxBound - 1 and math.random(0, 1) == 1) then
            boundTracker = boundTracker + 1
        end

        ePath = nextEPath
    end


    key = ePath.x .. ":" .. ePath.y
    if self.gridPosition[key] == nil then
        self.gridPosition[key] = TileType.ESSENTIAL
        table.insert(self.tileList, ePath)
    end

    ePath.id = 20
    self.endPos = {x = ePath.x, y = ePath.y}
end

-- 무작위 경로 ()필수 경로에 무작위 길을 추가) --
function DungeonManager_:BuildRandomPath()
    local pathQueue = Queue:New{}

    local essentialPath = nil
    local pathTile = nil

    for i = 1, #self.tileList, 1 do
        essentialPath = self.tileList[i]
        pathTile = PathTile(essentialPath.x, essentialPath.y, TileType.RANDOM, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)
        pathQueue:Push(pathTile)
    end

    while pathQueue:IsEmpty() == false do

        pathTile = pathQueue:Pop()

        local adjacentTileCount = #(pathTile.adjacentPathTiles)
        if adjacentTileCount > 0 then
            if math.random(1, 5) == 1 then
                self:BuildRandomChamber(pathTile)

            elseif math.random(1, 5) == 1 or (pathTile.type == TileType.RANDOM and adjacentTileCount > 1) then
                local randomIndex = math.random(1, adjacentTileCount)

                local newPathPosX = pathTile.adjacentPathTiles[randomIndex].x
                local newPathPosY = pathTile.adjacentPathTiles[randomIndex].y

                local key = newPathPosX .. ":" .. newPathPosY

                if self.gridPosition[key] == nil then
                    self.gridPosition[key] = TileType.RANDOM
                    local newPathTile = PathTile(newPathPosX, newPathPosY, TileType.RANDOM, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)
                    table.insert(self.tileList, newPathTile)
                    pathQueue:Push(newPathTile)
                end
            end

        end

    end


end

function DungeonManager_:BuildRandomChamber(tile)
    local chamberSize = self.chamberSize

    local adjacentTileCount = #(tile.adjacentPathTiles)
    local randomIndex = math.random(1, adjacentTileCount)

    local chamberOriginX = tile.adjacentPathTiles[randomIndex].x
    local chamberOriginY = tile.adjacentPathTiles[randomIndex].y

    local key = ""

    for x = chamberOriginX, chamberOriginX + chamberSize - 1, 1 do
        for y = chamberOriginY, chamberOriginY + chamberSize - 1, 1 do
            key = x .. ":" .. y
            if self.minBound < x and x < self.maxBound and self.minBound < y and y < self.maxBound and self.gridPosition[key] == nil then
                self.gridPosition[key] = TileType.EMPTY
                local newPathTile = PathTile(x, y, TileType.EMPTY, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)
                table.insert(self.tileList, newPathTile)
            end
        end
    end


end
