local checkCollision = require("src.utils.collision")

local function update(world, dt)
    local balls = world:query("position", "size", "velocity", "ball")
    local blocks = world:query("position", "size", "block")

    for _, ball in ipairs(balls) do
        for _, block in ipairs(blocks) do
            if block.block.active and checkCollision(ball, block) then
                block.block.active = false
                ball.velocity.dy = -ball.velocity.dy
                break
            end
        end
    end
end

return update
