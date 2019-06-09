TileType =
{
    ESSENTIAL = 0,
    RANDOM    = 1,
    EMPTY     = 2
}

PathTile =
{
    x = 0,
    y = 0,
    type = 0,
    id = 0,

    adjacentPathTiles = {}
}

PathTile.__index = PathTile

setmetatable(PathTile, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PathTile.new(x, y, type, id, min, max, currentTiles)
  local self = setmetatable({}, PathTile)

  self.x = x
  self.y = y
  self.type = type
  self.id = id

  self.adjacentPathTiles = self:GetAdjacentPath(min, max, currentTiles)

  return self
end

function PathTile.Draw(self)
    SpriteManager:Draw(self.id, self.x, self.y)
end

function PathTile.GetAdjacentPath(self, min, max, currentTiles)
    local key = self.x .. ":" .. self.y
    local pathTiles = {}

    local key_up = self.x .. ":" .. (self.y - 1)
    if self.y - 1 >= min and currentTiles[key_up] == nil then
        --pathTiles[key_up] = {x = self.x, y = self.y - 1}
        table.insert(pathTiles, {x = self.x, y = self.y - 1})
    end

    local key_down = self.x .. ":" .. (self.y + 1)
    if self.y + 1 < max and currentTiles[key_down] == nil  then
        --pathTiles[key_down] = {x = self.x, y = self.y + 1}
        table.insert(pathTiles, {x = self.x, y = self.y + 1})
    end

    if self.type ~= TileType.ESSENTIAL then
        local key_left = (self.x - 1) .. ":" .. self.y
        if self.x - 1 >= min and currentTiles[key_left] == nil then
            pathTiles[key_left] = {x = self.x - 1, y = self.y}
            table.insert(pathTiles, {x = self.x - 1, y = self.y})
        end
    end

    local key_right = (self.x + 1) .. ":" .. self.y
    if self.x + 1 < max and currentTiles[key_right] == nil  then
        --pathTiles[key_right] = {x = self.x + 1, y = self.y}
        table.insert(pathTiles, {x = self.x + 1, y = self.y})
    end

    return pathTiles
end
