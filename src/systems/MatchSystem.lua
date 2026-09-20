local CLOSE_DELAY = 2

local MatchSystem = {}

function MatchSystem.setup(scene)
    scene.registry:spawn({
        match = { state = "play", message = "", closeIn = CLOSE_DELAY },
    })
end

local function finish(match, state, message)
    match.state = state
    match.message = message
    print(message)
end

function MatchSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")

    if match.state ~= "play" then
        match.closeIn = match.closeIn - dt
        if match.closeIn <= 0 then
            love.event.quit()
        end
        return
    end

    local screenH = love.graphics.getHeight()

    for ballEntity, pos, size in registry:each("position", "size", "ball") do
        if pos.y + size.h >= screenH then
            registry:destroy(ballEntity)
        end
    end

    if #registry:query("block") == 0 then
        finish(match, "won", "You Win!")
    elseif #registry:query("ball") == 0 then
        finish(match, "lost", "Game Over")
    end
end

return MatchSystem
