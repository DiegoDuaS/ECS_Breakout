local function createPaddle(world)
    local w, h = 100, 20

    return world:createEntity({
        position = { x = love.graphics.getWidth() / 2 - w / 2, y = love.graphics.getHeight() - 40 },
        size = { w = w, h = h },
        color = { 1, 1, 1 },
        paddle = { speed = 400 },
        collider = true
    })
end

return createPaddle
