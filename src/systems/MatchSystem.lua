-- Owns the match state (a singleton component) and decides how it ends:
--
--   lost  every ball reached the bottom of the screen
--   won   every block was destroyed
--
-- When the match ends, every simulation system freezes (they all check
-- `match.state`), the message stays on screen for a moment, and then the
-- game closes.

local CLOSE_DELAY = 2 -- seconds the final message stays visible

local MatchSystem = {}

-- This system owns the match state, so it creates it.
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
