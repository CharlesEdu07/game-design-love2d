local love = require("love")
local graphics = love.graphics
local math = require("math")
local keyboard = love.keyboard

local Background = require("boardgame.background")
local Mecha = require("boardgame.mecha")
local Dice = require("boardgame.dice")
local Field = require("boardgame.field")

function love.load()
    Width = 1368
    Height = 720

    love.window.setMode(Width, Height, {
        resizable = false
    })

    love.window.setTitle('MDW')

    love.graphics.setFont(love.graphics.newFont("fonts/Pixeled.ttf", 16))

    White = {255, 255, 255}

    Fps = 60
    Speed = 60
    Border = 0

    Can_Play = false
    Turn = 0
    Can_Move = false
    Can_Summon = false

    Background = Background:new()
    Blocks = {}

    Deck1 = {}
    Deck2 = {}

    Await = 3

    -- mecha1 = Mecha:new('sprite_5.png', 2, 89, 195)
    -- mecha2 = Mecha:new('sprite_10.png', 3, 89, 258)
    -- mecha3 = Mecha:new('sprite_8.png', 4, 89, 321)
    -- mecha4 = Mecha:new('sprite_12.png', 5, 89, 384)
    Mecha5 = Mecha:new('sprite_10.png', 6, 89, 447)

    Dice = Dice:new(652, 590)

    for i = 1, 95 do
        table.insert(Blocks, Field:new(85 + ((i - 1) % 19) * 63, 190 + math.floor((i - 1) / 19) * 63))
    end
end

function love.update(dt)
    if (Can_Play) then
        Can_Play = false

        print("Turno antes da jogada: " .. Turn)

        Dice_value1 = Dice:roll()
        Dice_value2 = Dice:roll()
        Dice_value3 = Dice:roll()

        print(Dice_value1)
        print(Dice_value2)
        print(Dice_value3)

        -- Realizar jogada
        if (Verify_Dice_Result(Dice_value1, Dice_value2, Dice_value3)) then
            Do_Something(Dice_value1, Dice_value2, Dice_value3)
        end

        Pass_Turn()

        print("Turno depois da jogada: " .. Turn)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if (key == "space") then
        Can_Play = true
    end
end

function Verify_Dice_Result(dice_value1, dice_value2, dice_value3)
    if ((Is_Equal(dice_value1, dice_value2) or Is_Equal(dice_valuel, dice_value3) or Is_Equal(dice_value2, dice_value3)) and
        not ((dice_value1 == 6 and dice_value2 == 6) or (dice_value1 == 6 and dice_value3 == 6) or
            (dice_value2 == 6 and dice_value3 == 6))) then

        if Is_Equal(dice_value1, dice_value2) then
            print("1 e 2 iguais: " .. dice_value1, dice_value2)

            return dice_value1
        end

        if Is_Equal(dice_value1, dice_value3) then
            print("1 e 3 iguais: " .. dice_value1, dice_value3)

            return dice_value1
        end

        if Is_Equal(dice_value2, dice_value3) then
            print("2 e 3 iguais: " .. dice_value2, dice_value3)

            return dice_value2
        end
    end

    return 0
end

function Is_Equal(value1, value2)
    if (value1 == value2) then
        return true
    end

    return false
end

function Do_Something(dice_value1, dice_value2, dice_value3)
    -- Verificar se já tem robos em campo
    -- Se sim pode mover ou pode summon
    -- Se não pode apenas summon

end

function Pass_Turn()
    if (Turn == 0) then
        Turn = 1
    else
        Turn = 0
    end
end

function love.draw()
    Background:draw()

    for _, Block in ipairs(Blocks) do
        Block:draw()
    end

    -- mecha1:draw()
    -- mecha2:draw()
    -- mecha3:draw()
    -- mecha4:draw()
    Mecha5:draw()

    Dice:draw()
end

function love.quit()

end
