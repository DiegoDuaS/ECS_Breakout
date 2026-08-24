local function update(world, dt)
    for _, entity in ipairs(world:query("position", "size", "paddle")) do
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            entity.position.x = entity.position.x - entity.paddle.speed * dt
        end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            entity.position.x = entity.position.x + entity.paddle.speed * dt
        end

        if entity.position.x < 0 then
            entity.position.x = 0
        end
        if entity.position.x + entity.size.w > love.graphics.getWidth() then
            entity.position.x = love.graphics.getWidth() - entity.size.w
        end
    end
end

return update
