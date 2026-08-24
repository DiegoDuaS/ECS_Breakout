local function update(world, dt)
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()

    for _, entity in ipairs(world:query("position", "size", "velocity", "ball")) do
        if entity.position.x <= 0 then
            entity.position.x = 0
            entity.velocity.dx = -entity.velocity.dx
        end
        if entity.position.x + entity.size.w >= screenW then
            entity.position.x = screenW - entity.size.w
            entity.velocity.dx = -entity.velocity.dx
        end
        if entity.position.y <= 0 then
            entity.position.y = 0
            entity.velocity.dy = -entity.velocity.dy
        end
        if entity.position.y + entity.size.h >= screenH then
            return true
        end
    end

    return false
end

return update
