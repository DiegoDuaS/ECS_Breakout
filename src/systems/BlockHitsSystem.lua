local Collision = require("src.Collision")

local ROWS, COLS = 5, 8
local WIDTH, HEIGHT = 80, 25
local PADDING = 10
local OFFSET_X, OFFSET_Y = 40, 50

local BlockHitsSystem = {}

function BlockHitsSystem.setup(scene)
    for row = 1, ROWS do
        for col = 1, COLS do
            scene.registry:spawn({
                position = {
                    x = OFFSET_X + (col - 1) * (WIDTH + PADDING),
                    y = OFFSET_Y + (row - 1) * (HEIGHT + PADDING),
                },
                size = { w = WIDTH, h = HEIGHT },
                color = { r = 0, g = 1, b = 0 },
                block = {},
            })
        end
    end
end

function BlockHitsSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for _, bp, bs, bv in registry:each("position", "size", "velocity", "ball") do
        for blockEntity, kp, ks in registry:each("position", "size", "block") do
            if Collision.aabb(bp.x, bp.y, bs.w, bs.h, kp.x, kp.y, ks.w, ks.h) then
                registry:destroy(blockEntity)
                bv.vy = -bv.vy
                break
            end
        end
    end
end

return BlockHitsSystem
