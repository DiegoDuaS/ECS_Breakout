local START_SPEED = 300
local SIZE = 16

local BallSpawnSystem = {}

function BallSpawnSystem.setup(scene)
    scene.registry:spawn({
        serveRequest = { direction = love.math.random() < 0.5 and -1 or 1 },
    })
end

function BallSpawnSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for requestEntity, request in registry:each("serveRequest") do
        registry:destroy(requestEntity)

        registry:spawn({
            position = {
                x = (love.graphics.getWidth() - SIZE) / 2,
                y = love.graphics.getHeight() / 2,
            },
            size = { w = SIZE, h = SIZE },
            velocity = { vx = START_SPEED * request.direction, vy = -START_SPEED },
            color = { r = 1, g = 0, b = 0 },
            ball = { speedup = 1.05, maxSpeed = 850 },
            bounceWalls = {},
        })
    end
end

return BallSpawnSystem
