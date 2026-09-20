-- Axis-aligned bounding box overlap. Shared by every system that resolves
-- ball-vs-something collisions.

local Collision = {}

function Collision.aabb(ax, ay, aw, ah, bx, by, bw, bh)
    return ax < bx + bw and bx < ax + aw
       and ay < by + bh and by < ay + ah
end

return Collision
