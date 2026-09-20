local RenderSystem = {}

local bigFont, smallFont

function RenderSystem.setup(scene)
    bigFont = love.graphics.newFont(48)
    smallFont = love.graphics.newFont(16)
end

function RenderSystem.unload(scene)
    bigFont, smallFont = nil, nil
end

function RenderSystem.draw(scene)
    local registry = scene.registry
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()

    for _, pos, size, color in registry:each("position", "size", "color") do
        love.graphics.setColor(color.r, color.g, color.b)
        love.graphics.rectangle("fill", pos.x, pos.y, size.w, size.h)
    end
    love.graphics.setColor(1, 1, 1)

    local _, match = registry:first("match")
    if match.state == "play" then
        love.graphics.setFont(smallFont)
        love.graphics.printf("A/D or LEFT/RIGHT: move    B: extra ball    ESC: quit",
            0, 10, screenW, "center")
    else
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, screenH / 2 - 60, screenW, 120)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(bigFont)
        love.graphics.printf(match.message, 0, screenH / 2 - 30, screenW, "center")
    end
end

return RenderSystem
