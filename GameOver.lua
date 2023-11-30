GameOver = Class { _include = baseState }

function GameOver:update(dt)
    -- if keyboard.isDown('return') then
    ball:reset()

    -- reset scores to 0
    player1Score = 0
    player2Score = 0

    if winningPlayer == 1 then
        servingPlayer = 2
    else
        servingPlayer = 1
    end
    -- gGameState:change('serve')
    -- end
    if love.keyboard.isDown('return') then
        gGameState:change('serve')
    end
end

function GameOver:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
        0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
end
