-- Turns raw key presses into game actions. love.keypressed only spawns a
-- tiny entity carrying a `keyPressed` component; this system consumes it
-- here, inside the normal update order ("events as entities").
--
-- (Held keys are state, not events: PaddleControlSystem polls
-- love.keyboard.isDown each frame instead.)

local InputSystem = {}

function InputSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")

    for keyEntity, event in registry:each("keyPressed") do
        registry:destroy(keyEntity) -- consume the event

        if event.key == "escape" then
            love.event.quit()
        elseif event.key == "b" and match.state == "play" then
            registry:spawn({
                serveRequest = { direction = love.math.random() < 0.5 and -1 or 1 },
            })
        end
    end
end

return InputSystem
