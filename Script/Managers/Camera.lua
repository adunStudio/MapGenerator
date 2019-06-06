Camera_ = {}
Camera_.x = 0
Camera_.y = 0
Camera_.scaleX = 1
Camera_.scaleY = 1
Camera_.rotation = 0

function Camera_:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Camera_:Set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
    love.graphics.translate(-self.x, - self.y)
end

function Camera_:Unset()
    love.graphics.pop()
end

function Camera_:Move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
end

function Camera_:Rotate(dr)
    self.rotation = self.rotation + dr
end

function Camera_:Scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
end

function Camera_:SetPosition(x, y)
    self.x = x or self.x
    self.y = y or self.y
end

function Camera_:SetScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end
