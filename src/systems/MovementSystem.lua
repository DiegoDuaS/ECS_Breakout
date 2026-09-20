local MovementSystem = {}

function MovementSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for _, pos, vel in registry:each("position", "velocity") do
        pos.x = pos.x + vel.vx * dt
        pos.y = pos.y + vel.vy * dt
    end
end

return MovementSystem
