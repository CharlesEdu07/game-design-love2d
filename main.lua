require "boardgame.board"
require "boardgame.player"

function love.load()
    myBoard = Board:new()
    player1 = Player:new("Player 1")
    player2 = Player:new("Player 2")
end

function love.update(dt)
    myBoard:update(dt)
end

function love.draw()
    myBoard:draw()
end