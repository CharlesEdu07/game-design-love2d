Field = {}
Field.__index = Field

function Field:new(x, y)
    local field = setmetatable({}, Field)
    field.image = love.graphics.newImage('assets/block.png')
    field.image:setFilter('nearest', 'nearest')
    field.rect = { x = x, y = y, width = field.image:getWidth(), height = field.image:getHeight() }
    field.x = x
    field.y = y

    return field
end

function Field:draw()
    love.graphics.draw(self.image, self.rect.x, self.rect.y)
end

local field = Field:new(200, 200)

function love.load()

end

function love.update(dt)

end

function love.draw()
    field:draw()
end
