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
    Red = {255, 0, 0}

    Fps = 60
    Speed = 60
    Border = 0

    Can_Play = false
    Turn = 0

    Choose_Row = false
    Can_Move = false
    Can_Summon = false

    Row_Value = 0

    Background = Background:new()
    Blocks = {}

    Deck1 = {}
    Deck2 = {}

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
    love.timer.sleep(1 / Fps)

    if (Can_Play) then
        Can_Play = false

        print("Turno antes da jogada: " .. Turn)

        Dice_Value1 = Dice:roll()
        Dice_Value2 = Dice:roll()
        Dice_Value3 = Dice:roll()

        print(Dice_Value1)
        print(Dice_Value2)
        print(Dice_Value3)

        Level_Value = Verify_Dice_Result(Dice_Value1, Dice_Value2, Dice_Value3)

        if Level_Value ~= 0 then

            Do_Something(Level_Value)
        end

        Pass_Turn()

        print("Turno depois da jogada: " .. Turn)
    end
end

function Do_Something(Level_Value)
    if (Turn == 0 and #Deck1 == 0) then
        print("Level_Value: " .. Level_Value)

        Choose_Row = true

        -- Receber input do jogador em qual linha ele quer colocar o mecha

        -- if (Level_Value == 1) then
        --     print("Level 1")
        --     print("Mecha 1")

        --     table.insert(Deck1, Mecha:new('sprite_5.png', 2, 89, 195))
        -- end

        -- if (Level_Value == 2) then
        --     print("Level 2")
        --     print("Mecha 2")

        --     table.insert(Deck1, Mecha:new('sprite_10.png', 3, 89, 258))
        -- end

        -- if (Level_Value == 3) then
        --     print("Level 3")
        --     print("Mecha 3")

        --     table.insert(Deck1, Mecha:new('sprite_8.png', 4, 89, 321))
        -- end

        -- if (Level_Value == 4) then
        --     print("Level 4")
        --     print("Mecha 4")

        --     table.insert(Deck1, Mecha:new('sprite_12.png', 5, 89, 384))
        -- end

        -- if (Level_Value == 5) then
        --     print("Level 5")
        --     print("Mecha 5")

        --     table.insert(Deck1, Mecha:new('sprite_10.png', 6, 89, 447))
        -- end
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

function Pass_Turn()
    if (Turn == 0) then
        Turn = 1
    else
        Turn = 0
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

function love.textinput(t)
    input = t
end

function love.draw()
    Background:draw()

    love.graphics.print({Red, "Tecle SPACE para rolar os dados"}, 472, 540)

    if Choose_Row then
        love.graphics.print({Red, "Tecle 1, 2, 3, 4 ou 5 para escolher a linha"}, 472, 560)

        if input == "1" then
            Row_Value = 1

            Choose_Row = false
        end
    end

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
