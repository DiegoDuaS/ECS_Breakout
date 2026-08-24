local MAX_BALL_SPEED = 600

local function createBall(world)
    local w, h = 16, 16

    return world:createEntity({
        position = { x = love.graphics.getWidth() / 2 - w / 2, y = love.graphics.getHeight() / 2 },
        size = { w = w, h = h },
        color = { 1, 0, 0 },
        velocity = { dx = 1, dy = -1, speed = 300, maxSpeed = MAX_BALL_SPEED },
        ball = true,
        collider = true
    })
end

return createBall
