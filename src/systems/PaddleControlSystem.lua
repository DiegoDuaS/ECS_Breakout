-- Reads the keyboard and turns it into horizontal velocity for paddle
-- entities. It doesn't move anything: that's the MovementSystem's job.

local WIDTH, HEIGHT = 100, 20
local BOTTOM_MARGIN = 40

local PaddleControlSystem = {}

local function anyDown(keys)
    for _, key in ipairs(keys) do
        if love.keyboard.isDown(key) then return true end
    end
    return false
end

-- This system owns the paddle, so it creates it.
function PaddleControlSystem.setup(scene)
    scene.registry:spawn({
        position = {
            x = (love.graphics.getWidth() - WIDTH) / 2,
            y = love.graphics.getHeight() - BOTTOM_MARGIN,
        },
        size = { w = WIDTH, h = HEIGHT },
        velocity = { vx = 0, vy = 0 },
        color = { r = 1, g = 1, b = 1 },
        paddle = { leftKeys = { "left", "a" }, rightKeys = { "right", "d" }, speed = 400 },
        clamp = {},
    })
end

function PaddleControlSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for _, paddle, vel in registry:each("paddle", "velocity") do
        local dir = 0
        if anyDown(paddle.leftKeys) then dir = dir - 1 end
        if anyDown(paddle.rightKeys) then dir = dir + 1 end

        vel.vx = dir * paddle.speed
    end
end

return PaddleControlSystem
