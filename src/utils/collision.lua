local function checkCollision(a, b)
    return a.position.x < b.position.x + b.size.w and
        a.position.x + a.size.w > b.position.x and
        a.position.y < b.position.y + b.size.h and
        a.position.y + a.size.h > b.position.y
end

return checkCollision
