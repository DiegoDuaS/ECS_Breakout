local checkCollision = require("src.utils.collision")

local function update(world, dt)
    local balls = world:query("position", "size", "velocity", "ball")
    local paddles = world:query("position", "size", "paddle")

    for _, ball in ipairs(balls) do
        for _, paddle in ipairs(paddles) do
            if ball.velocity.dy > 0 and checkCollision(ball, paddle) then
                ball.velocity.dy = -ball.velocity.dy
                ball.velocity.speed = math.min(ball.velocity.speed + 30, ball.velocity.maxSpeed)
                ball.position.y = paddle.position.y - ball.size.h
            end
        end
    end
end

return update
