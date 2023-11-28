Dice = {}
Dice.__index = Dice

function Dice:new(x, y)
    local dice = setmetatable({}, Dice)
    local temp_image = love.graphics.newImage('assets/dice.png')
    dice.image = love.graphics.newImage('assets/dice.png')
    dice.image:setFilter('nearest', 'nearest') -- optional: set image filter mode
    dice.image = love.graphics.newImage('assets/dice.png')
    dice.image = love.graphics.newImage('assets/dice.png')
    dice.image = love.graphics.newImage('assets/dice.png')
    dice.image = love.graphics.newImage('assets/dice.png')
    dice.rect = {
        x = x,
        y = y,
        width = temp_image:getWidth(),
        height = temp_image:getHeight()
    }
    dice.x = x
    dice.y = y
    dice.clicked = false
    dice.action = false

    return dice
end

function Dice:draw()
    local pos = {love.mouse.getPosition()}

    if self.rect.x <= pos[1] and pos[1] <= self.rect.x + self.rect.width and self.rect.y <= pos[2] and pos[2] <=
        self.rect.y + self.rect.height then

        if love.mouse.isDown(1) and not self.clicked then
            self.clicked = true
            self.action = true
            return self.action
        end
    end

    if not love.mouse.isDown(1) then
        self.clicked = false
    end

    love.graphics.draw(self.image, self.rect.x, self.rect.y)
end

function Dice:roll()
    self.random_number = love.math.random(1, 6)
    return self.random_number
end

local dice = Dice:new(200, 200)

function love.load()

end

function love.update(dt)

end

function love.draw()
    dice:draw()
end
