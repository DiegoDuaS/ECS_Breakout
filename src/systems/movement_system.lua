local function update(world, dt)
    for _, entity in ipairs(world:query("position", "velocity")) do
        entity.position.x = entity.position.x + entity.velocity.dx * entity.velocity.speed * dt
        entity.position.y = entity.position.y + entity.velocity.dy * entity.velocity.speed * dt
    end
end

return update
