Board = {}

function Board:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.grid = {}
    return obj
end

function Board:draw()

end

function Board:update(dt)

end