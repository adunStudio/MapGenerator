Queue = {}

function Queue:Push(item)
    table.insert(self.list, item)
end

function Queue:Pop()
    return table.remove(self.list, 1)
end

function Queue:IsEmpty()
    return #self.list == 0
end

function Queue:Size()
    return #self.list
end

function Queue:New()
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.list = {}
    return o
end
