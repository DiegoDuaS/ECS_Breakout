local function createBlocks(world)
    local rows, cols = 5, 8
    local w, h, padding = 80, 25, 10
    local offsetX, offsetY = 40, 50

    for row = 1, rows do
        for col = 1, cols do
            world:createEntity({
                position = {
                    x = offsetX + (col - 1) * (w + padding),
                    y = offsetY + (row - 1) * (h + padding)
                },
                size = { w = w, h = h },
                color = { 0, 1, 0 },
                block = { active = true },
                collider = true
            })
        end
    end
end

return createBlocks
