local function checkWin(world)
    for _, entity in ipairs(world:query("block")) do
        if entity.block.active then
            return false
        end
    end
    return true
end

return checkWin
