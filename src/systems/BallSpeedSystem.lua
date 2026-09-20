-- Speeds balls up whenever they bounce off a wall or the paddle. The
-- collision systems don't touch speed themselves: they emit a
-- `ballBounced` event entity and this system consumes it.
--
-- Events are consumed even when the match is over, so none can linger.

local BallSpeedSystem = {}

function BallSpeedSystem.update(scene, dt)
    local registry = scene.registry

    for eventEntity, event in registry:each("ballBounced") do
        registry:destroy(eventEntity) -- consume the event

        local ball = registry:get(event.ball, "ball")
        local vel = registry:get(event.ball, "velocity")
        if ball and vel then
            vel.vx = vel.vx * ball.speedup
            vel.vy = vel.vy * ball.speedup

            -- cap the total speed, keeping the direction
            local speed = math.sqrt(vel.vx * vel.vx + vel.vy * vel.vy)
            if speed > ball.maxSpeed then
                local scale = ball.maxSpeed / speed
                vel.vx = vel.vx * scale
                vel.vy = vel.vy * scale
            end
        end
    end
end

return BallSpeedSystem
