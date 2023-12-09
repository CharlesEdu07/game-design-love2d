local love = require("love")
local graphics = love.graphics
local math = require("math")
local keyboard = love.keyboard

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

    turn = 0

    background = Background:new()
    blocks = {}

    mecha1 = Mecha:new('sprite_5.png', 2, 89, 195)
    mecha2 = Mecha:new('sprite_10.png', 3, 89, 258)
    mecha3 = Mecha:new('sprite_8.png', 4, 89, 321)
    mecha4 = Mecha:new('sprite_12.png', 5, 89, 384)
    mecha5 = Mecha:new('sprite_10.png', 6, 89, 447)

    dice = Dice:new(652, 590)

    for i = 1, 95 do
        table.insert(blocks, Field:new(85 + ((i - 1) % 19) * 63, 190 + math.floor((i - 1) / 19) * 63))
    end
end

function love.update(dt)
    dice:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "space" then
        print("Turno antes da jogada: " .. turn)

        dice_value1 = dice:roll()
        dice_value2 = dice:roll()
        dice_value3 = dice:roll()

        print(dice_value1)
        print(dice_value2)
        print(dice_value3)

        verify_dice_result(dice_value1, dice_value2, dice_value3)

        pass_turn()

        print("Turno depois da jogada: " .. turn)
    end
end

function verify_dice_result(dice_value1, dice_value2, dice_value3)
    if (dice_value1 == dice_value2 or dice_value1 == dice_value3 or dice_value2 == dice_value3) then
        print("DO SOMETHING, STUPID")
    end
end

function pass_turn()
    if (turn == 0) then
        turn = 1
    else
        turn = 0
    end
end

function love.draw()
    background:draw()

    for _, block in ipairs(blocks) do
        block:draw()
    end

    mecha1:draw()
    mecha2:draw()
    mecha3:draw()
    mecha4:draw()
    mecha5:draw()

    dice:draw()
end

function love.quit()

end
