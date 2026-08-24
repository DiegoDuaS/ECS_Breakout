local World = {}
World.__index = World

function World.new()
    return setmetatable({
        entities = {},
        nextId = 1
    }, World)
end

function World:createEntity(components)
    local entity = components or {}
    entity.id = self.nextId
    self.nextId = self.nextId + 1
    table.insert(self.entities, entity)
    return entity
end

function World:removeEntity(entity)
    for i, e in ipairs(self.entities) do
        if e == entity then
            table.remove(self.entities, i)
            return
        end
    end
end

function World:query(...)
    local required = { ... }
    local result = {}
    for _, entity in ipairs(self.entities) do
        local matches = true
        for _, component in ipairs(required) do
            if entity[component] == nil then
                matches = false
                break
            end
        end
        if matches then
            table.insert(result, entity)
        end
    end
    return result
end

return World
