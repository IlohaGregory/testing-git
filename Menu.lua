Menu = Class { _includes = baseState }
Cmp = 1
function Menu:update(dt)
    --if cmp = -1 it is a player, if it is one then it is computer.
    if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
        Cmp = Cmp * -1
    end
    if love.keyboard.isDown("return") then
        gGameState:change('serve')
    end
end

function Menu:render()
    love.graphics.setFont(titleFont)
    love.graphics.printf('Pong', 0, 64, VIRTUAL_WIDTH, "center")
    local playerType
    if Cmp == 1 then
        playerType = 'Computer'
    elseif Cmp == -1 then
        playerType = 'Player'
    end
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to select', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Player Type <' .. playerType .. '>', 0, 100, VIRTUAL_WIDTH, "center")
end
