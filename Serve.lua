Serve = Class { _includes = baseState }

function Serve:update(dt)
    if love.keyboard.isDown('return') then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
        gGameState:change('play')
    end
end

function Serve:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!",
        0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    displayScore()
    player1:render()
    player2:render()
    ball:render()
end
