local World = require("src.ecs.world")

local createPaddle = require("src.entities.paddle")
local createBall = require("src.entities.ball")
local createBlocks = require("src.entities.blocks")

local inputSystem = require("src.systems.input_system")
local movementSystem = require("src.systems.movement_system")
local wallCollisionSystem = require("src.systems.wall_collision_system")
local paddleCollisionSystem = require("src.systems.paddle_collision_system")
local blockCollisionSystem = require("src.systems.block_collision_system")
local checkWin = require("src.systems.game_state_system")
local renderSystem = require("src.systems.render_system")

local world

function love.load()
    world = World.new()
    createPaddle(world)
    createBall(world)
    createBlocks(world)
end

function love.update(dt)
    inputSystem(world, dt)
    movementSystem(world, dt)

    local gameOver = wallCollisionSystem(world, dt)
    if gameOver then
        print("Game Over")
        love.event.quit()
        return
    end

    paddleCollisionSystem(world, dt)
    blockCollisionSystem(world, dt)

    if checkWin(world) then
        print("You Win!")
        love.event.quit()
    end
end

function love.draw()
    renderSystem(world)
end
