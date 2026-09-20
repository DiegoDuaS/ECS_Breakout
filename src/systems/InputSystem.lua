local InputSystem = {}

function InputSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")

    for keyEntity, event in registry:each("keyPressed") do
        registry:destroy(keyEntity)

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
