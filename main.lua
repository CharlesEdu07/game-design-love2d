local love = require("love")
local graphics = love.graphics
local math = require("math")
local keyboard = love.keyboard
local mouse = love.mouse

local Background = require("boardgame.background")
local Mecha = require("boardgame.mecha")
local Dice = require("boardgame.dice")
local Field = require("boardgame.field")

function love.load()
    width = 1368
    height = 720

    love.window.setMode(width, height, {
        resizable = false
    })

    love.window.setTitle('MDW')

    love.graphics.setFont(love.graphics.newFont("fonts/Pixeled.ttf", 16))

    white = {255, 255, 255}

    fps = 60
    speed = 60
    border = 0

    background = Background:new()
    blocks = {}

    mecha1 = Mecha:new('sprite_5.png', 2, 85, 189)
    mecha2 = Mecha:new('sprite_10.png', 3, 85, 252)
    mecha3 = Mecha:new('sprite_8.png', 4, 85, 315)
    mecha4 = Mecha:new('sprite_12.png', 5, 85, 378)
    mecha5 = Mecha:new('sprite_10.png', 6, 85, 441)

    dice = Dice:new(200, 200)

    for i = 1, 95 do
        table.insert(blocks, Field:new(85 + ((i - 1) % 19) * 63, 190 + math.floor((i - 1) / 19) * 63))
    end
end

function love.update(dt)
    if keyboard.isDown('space') then
        dice:roll()
    end

    dice:draw()
end

function love.draw()
    background:draw()

    for _, block in ipairs(blocks) do
        block:draw()
    end

    -- mecha1:draw()
    -- mecha2:draw()
    -- mecha3:draw()
    -- mecha4:draw()
    -- mecha5:draw()

    dice:draw()
end

function love.quit()

end
