Mecha = {}

function Mecha:new(sprite_name, lv, x, y)
    local mecha = {setmetatable({}, Mecha)}
    mecha.sprite_name = sprite_name
    mecha.width = 60
    mecha.height = 60
    mecha.lv = lv
    mecha.image = love.graphics.newImage('assets/deck/' .. tostring(mecha.lv) .. '/' .. mecha.sprite_name)
    mecha.image:setFilter('nearest', 'nearest')
    mecha.x = x
    mecha.y = y
    mecha.speed = 3
    mecha.rect = {
        x = x,
        y = y,
        width = mecha.width,
        height = mecha.height
    }

    return mecha
end

function Mecha:draw()
    love.graphics.draw(self.image, self.rect.x, self.rect.y)
end

function Mecha:move(value)
    if value == 1 then
        self.x = self.x + self.speed
    elseif value == -1 then
        self.x = self.x - self.speed
    end

    self.x = math.max(0, math.min(self.x, love.graphics.getWidth() - self.width))
end

function Mecha:getX()
    return self.x
end

function Mecha:getY()
    return self.y
end

function Mecha:getLv()
    return self.lv
end
