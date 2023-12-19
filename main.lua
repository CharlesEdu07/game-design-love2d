local love = require("love")
local graphics = love.graphics
local math = require("math")
local keyboard = love.keyboard

local Background = require("boardgame.background")
local Mecha = require("boardgame.mecha")
local Dice = require("boardgame.dice")
local Field = require("boardgame.field")

function love.load()
    -- Get screen size of the current computer.
    love.window.setMode(0, 0, {
        resizable = false
    })
    Screen_Height = love.graphics.getHeight()
    Screen_Width = love.graphics.getWidth()
    -- Scale = math.ceil(Screen_Width / 1000)

    -- Set game screen
    Height = Screen_Height -- 720
    Width = Screen_Width   -- 1368
    love.window.setMode(Width, Height, {
        resizable = false
    })

    -- Set title, font and colors
    love.window.setTitle('Robot Dice Wars')
    love.graphics.setFont(love.graphics.newFont("fonts/Pixeled.ttf", 16))
    -- White = { 255, 255, 255 }
    Red = { 255, 0, 0 }

    -- Set max fps value
    MAX_FPS = 60
    -- Speed = 60
    -- Border = 0

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

    Player_1_Summon_Positions = { 195, 258, 321, 384, 447 }

    -- mecha1 = Mecha:new('sprite_5.png', 2, 89, 195)
    -- mecha2 = Mecha:new('sprite_10.png', 3, 89, 258)
    -- mecha3 = Mecha:new('sprite_8.png', 4, 89, 321)
    -- mecha4 = Mecha:new('sprite_12.png', 5, 89, 384)
    -- Mecha5 = Mecha:new('sprite_10.png', 6, 89, 447)

    Dice = Dice:new(652, 590)

    for i = 1, 95 do
        table.insert(Blocks, Field:new(85 + ((i - 1) % 19) * 63, 190 + math.floor((i - 1) / 19) * 63))
    end
end

function love.update(dt)
    love.timer.sleep(1 / MAX_FPS)

    if (Can_Play) then
        Can_Play = false

        -- print("Turno antes da jogada: " .. Turn)
        Dice_Values = {}
        for i = 0, 2 do
            Dice_Values[i] = Dice:roll()
        end

        -- print(Dice_Values[0])
        -- print(Dice_Values[1])
        -- print(Dice_Values[2])

        Level_Value = Verify_Dice_Result(Dice_Values[0], Dice_Values[1], Dice_Values[2])

        if Level_Value ~= 0 then
            Summon_Robot(Level_Value)
            Level_Value = 0
        end

        Pass_Turn()

        print("Turno depois da jogada: " .. Turn)
    end
end

function Summon_Robot(Level_Value)
    if (Turn == 0 and #Deck1 == 0) then
        print("Level_Value: " .. Level_Value)

        Choose_Row = true
        line = 1
        mecha = Choose_Robot(Level_Value, line)

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

function Choose_Robot(Level_Value, line)
    Summon_Position = Player_1_Summon_Positions[line]
    -- table.insert(Deck1, Mecha:new('sprite_' .. Level_Value .. '.png', 2, 89, Summon_Position))
    return Mecha:new('sprite_' .. Level_Value .. '.png', Level_Value, 89, Summon_Position)
end

function Verify_Dice_Result(dice_value1, dice_value2, dice_value3)
    -- Verify if two dices are equal and different from six
    -- return dice_value if a pair exists, return zero if not.
    if (Are_Two_Dices_Equal(dice_value1, dice_value2, dice_value3) and
            not Are_Two_Dices_Equal_Six(dice_value1, dice_value2, dice_value3)) then
        if Is_Equal(dice_value1, dice_value2) then
            -- print("1 e 2 iguais: " .. dice_value1, dice_value2)
            return dice_value1
        end

        if Is_Equal(dice_value1, dice_value3) then
            -- print("1 e 3 iguais: " .. dice_value1, dice_value3)
            return dice_value1
        end

        if Is_Equal(dice_value2, dice_value3) then
            -- print("2 e 3 iguais: " .. dice_value2, dice_value3)
            return dice_value2
        end
    end

    return 0
end

function Is_Equal(value1, value2)
    if (value1 == value2) then
        return true
    else
        return false
    end
end

function Are_Two_Dices_Equal(value1, value2, value3)
    if (value1 == value2) then
        return true
    elseif (value1 == value3) then
        return true
    elseif (value2 == value3) then
        return true
    else
        return false
    end
end

function Are_Two_Dices_Equal_Six(value1, value2, value3)
    if (value1 == value2) and value1 == 6 then
        return true
    elseif (value1 == value3) and value1 == 6 then
        return true
    elseif (value2 == value3) and value2 == 6 then
        return true
    else
        return false
    end
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

    love.graphics.print({ Red, "Tecle SPACE para rolar os dados" }, 472, 540)

    for _, Block in ipairs(Blocks) do
        Block:draw()
    end

    if Choose_Row then
        love.graphics.print({ Red, "Tecle 1, 2, 3, 4 ou 5 para escolher a linha" }, 472, 560)
        -- if input ~= "space" then
        --    line = tonumber(input)
        -- end
        --mecha = Choose_Robot(Level_Value, line)
        Choose_Row = false
        Draw_Mecha = true
    end

    if Draw_Mecha then
        mecha:draw()
    end

    -- mecha1:draw()
    -- mecha2:draw()
    -- mecha3:draw()
    -- mecha4:draw()
    -- Mecha5:draw()

    Dice:draw()
end

function love.quit()

end
