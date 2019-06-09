require("Script/PathTile")

DungeonManager_ = {
    minBound = 0,
    maxBound = 0,

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

end

function DungeonManager_:Draw()
    print(#self.tileList)
    for i = 1, #self.tileList, 1 do
        self.tileList[i]:Draw()
    end
end

-- 입구부터 출구까지의 필수 경로 --
function DungeonManager_:BuildEssentialPath()
    -- 랜덤 시작점
    local randomY = math.random(0, self.maxBound)

    local ePath = PathTile(0, randomY, TileType.ESSENTIAL, math.random(32, 39), self.minBound, self.maxBound, self.gridPosition)

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

        adjacentTileCount = #(ePath.adjacentPathTiles)
        randomIndex = math.random(1, adjacentTileCount)

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
