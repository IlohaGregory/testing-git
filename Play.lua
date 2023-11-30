Play = Class { _includes = baseState }

function Play:update(dt)
    if ball:collides(player1) then
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 5

        -- keep velocity going in the same direction, but randomize it
        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

        sounds['paddle_hit']:play()
    end
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 4

        -- keep velocity going in the same direction, but randomize it
        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

        sounds['paddle_hit']:play()
    end

    -- detect upper and lower screen boundary collision, playing a sound
    -- effect and reversing dy if true
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
        sounds['wall_hit']:play()
    end

    -- -4 to account for the ball's size
    if ball.y >= VIRTUAL_HEIGHT - 4 then
        ball.y = VIRTUAL_HEIGHT - 4
        ball.dy = -ball.dy
        sounds['wall_hit']:play()
    end

    -- if we reach the left edge of the screen, go back to serve
    -- and update the score and serving player
    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1
        sounds['score']:play()

        -- if we've reached a score of 10, the game is over; set the
        -- state to done so we can show the victory message
        if player2Score == 10 then
            winningPlayer = 2
            gGameState:change('gameover')
        else
            gGameState:change('serve')
            -- places the ball in the middle of the screen, no velocity
            ball:reset()
        end
    end

    -- if we reach the right edge of the screen, go back to serve
    -- and update the score and serving player
    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1
        sounds['score']:play()

        -- if we've reached a score of 10, the game is over; set the
        -- state to done so we can show the victory message
        if player1Score == 10 then
            winningPlayer = 1
            gGameState:change('gameover')
        else
            ball:reset()
            gGameState:change('serve')
            -- places the ball in the middle of the screen, no velocity
        end
    end

    --
    -- paddles can move no matter what state we're in
    --
    -- player 1
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2
    if Cmp == -1 then
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    elseif Cmp == 1 then
        if ball.y + 4 < player2.y then
            player2.dy = -PADDLE_SPEED / 1.5
        elseif ball.y > player2.width then
            player2.dy = PADDLE_SPEED / 1.5
        else
            player2.dy = 0
        end
    end

    -- update our ball based on its DX and DY only if we're in play state;
    -- scale the velocity by dt so movement is framerate-independent
    ball:update(dt)

    player1:update(dt)
    player2:update(dt)
end

function Play:render()
    player1:render()
    player2:render()
    ball:render()
    displayScore()
end
