local Scene = require("src.ecs.Scene")

local InputSystem = require("src.systems.InputSystem")
local BallSpawnSystem = require("src.systems.BallSpawnSystem")
local PaddleControlSystem = require("src.systems.PaddleControlSystem")
local MovementSystem = require("src.systems.MovementSystem")
local ClampSystem = require("src.systems.ClampSystem")
local BounceWallsSystem = require("src.systems.BounceWallsSystem")
local PaddleHitsSystem = require("src.systems.PaddleHitsSystem")
local BlockHitsSystem = require("src.systems.BlockHitsSystem")
local BallSpeedSystem = require("src.systems.BallSpeedSystem")
local MatchSystem = require("src.systems.MatchSystem")
local RenderSystem = require("src.systems.RenderSystem")

local MAX_DT = 1 / 30

local scene

function love.load()
    scene = Scene.new("breakout")

    scene:addSystem(InputSystem)
    scene:addSystem(BallSpawnSystem)
    scene:addSystem(PaddleControlSystem)
    scene:addSystem(MovementSystem)
    scene:addSystem(ClampSystem)
    scene:addSystem(BounceWallsSystem)
    scene:addSystem(PaddleHitsSystem)
    scene:addSystem(BlockHitsSystem)
    scene:addSystem(BallSpeedSystem)
    scene:addSystem(MatchSystem)
    scene:addSystem(RenderSystem)

    scene:setup()
end

function love.update(dt)
    scene:update(math.min(dt, MAX_DT))
end

function love.draw()
    scene:draw()
end

function love.quit()
    scene:unload()
end

function love.keypressed(key)
    scene.registry:spawn({ keyPressed = { key = key } })
end
