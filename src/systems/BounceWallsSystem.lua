-- Entities tagged with `bounceWalls` reflect off the left, right and top
-- walls. The bottom is NOT a wall: a ball that reaches it is lost
-- (MatchSystem). Each bounce emits a `ballBounced` event so the
-- BallSpeedSystem can speed the ball up. Runs AFTER movement.

local BounceWallsSystem = {}

function BounceWallsSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    local screenW = love.graphics.getWidth()

    for entity, pos, size, vel in registry:each("position", "size", "velocity", "bounceWalls") do
        local bounced = false

        if pos.x < 0 then
            pos.x = 0
            vel.vx = -vel.vx
            bounced = true
        elseif pos.x + size.w > screenW then
            pos.x = screenW - size.w
            vel.vx = -vel.vx
            bounced = true
        end

        if pos.y < 0 then
            pos.y = 0
            vel.vy = -vel.vy
            bounced = true
        end

        if bounced then
            registry:spawn({ ballBounced = { ball = entity } })
        end
    end
end

return BounceWallsSystem
