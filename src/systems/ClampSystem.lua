-- Keeps entities tagged with a `clamp` component inside the window
-- (horizontally). The paddle uses this. Runs AFTER movement.

local ClampSystem = {}

function ClampSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    local screenW = love.graphics.getWidth()

    -- the `clamp` tag goes last: its (empty) value just falls off the end
    for _, pos, size in registry:each("position", "size", "clamp") do
        if pos.x < 0 then pos.x = 0 end
        if pos.x + size.w > screenW then pos.x = screenW - size.w end
    end
end

return ClampSystem
