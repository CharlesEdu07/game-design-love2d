Background = {}

function Background:new()
    local background = {}
    setmetatable(background, self)
    self.__index = self

    background.image = love.graphics.newImage('/assets/background.png')
    background.image:setFilter('nearest', 'nearest')

    return background
end

function Background:draw()
    love.graphics.draw(self.image, 0, 0)
end

return Background
