local love = require("love")
local graphics = love.graphics

Field = {}

function Field:new(x, y)
    local field = {}
    setmetatable(field, self)
    self.__index = self
    field.image = love.graphics.newImage('assets/block.png')
    field.image:setFilter('nearest', 'nearest')
    field.rect = {
        x = x,
        y = y,
        width = field.image:getWidth(),
        height = field.image:getHeight()
    }
    field.x = x
    field.y = y

    return field
end

function Field:draw()
    love.graphics.draw(self.image, self.rect.x, self.rect.y)
end

return Field