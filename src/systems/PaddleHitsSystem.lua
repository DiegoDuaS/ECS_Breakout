local Collision = require("src.Collision")

local PaddleHitsSystem = {}

function PaddleHitsSystem.update(scene, dt)
    local registry = scene.registry
    local _, match = registry:first("match")
    if match.state ~= "play" then return end

    for ballEntity, bp, bs, bv in registry:each("position", "size", "velocity", "ball") do
        if bv.vy > 0 then
            for _, pp, ps in registry:each("position", "size", "paddle") do
                if Collision.aabb(bp.x, bp.y, bs.w, bs.h, pp.x, pp.y, ps.w, ps.h) then
                    bp.y = pp.y - bs.h
                    bv.vy = -bv.vy
                    registry:spawn({ ballBounced = { ball = ballEntity } })
                    break
                end
            end
        end
    end
end

return PaddleHitsSystem
