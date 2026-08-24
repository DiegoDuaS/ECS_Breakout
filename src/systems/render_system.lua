local function draw(world)
    for _, entity in ipairs(world:query("position", "size", "color")) do
        if entity.block == nil or entity.block.active then
            love.graphics.setColor(entity.color[1], entity.color[2], entity.color[3])
            love.graphics.rectangle("fill", entity.position.x, entity.position.y, entity.size.w, entity.size.h)
        end
    end
end

return draw
