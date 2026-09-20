-- Spawns balls. Nobody calls this system directly: whoever wants a ball
-- (scene setup, the B key) spawns an entity carrying only a
-- `serveRequest` component, and this system consumes it on the same frame.

local START_SPEED = 300 -- per axis: the ball starts moving diagonally
local SIZE = 16

local BallSpawnSystem = {}

function BallSpawnSystem.setup(scene)
    -- ask for the opening serve; update() does the actual spawning
    scene.registry:spawn({
        serveRequest = { direction = love.math.random() < 0.5 and -1 or 1 },
    })
end

function BallSpawnSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for requestEntity, request in registry:each("serveRequest") do
        registry:destroy(requestEntity) -- consume the event

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
