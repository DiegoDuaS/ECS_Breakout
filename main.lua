----------------------------------------------------------------------
-- Breakout on an Entity-Component-System
--
--   Scene      the game screen; owns a Registry + ordered Systems
--   Registry   the DATA: components indexed by entity
--   Entity     just a number — a key into the registry
--   System     the LOGIC: runs over entities that have certain components
--
-- main.lua holds NO game logic: it assembles the scene and forwards
-- LÖVE's callbacks. Even a key press becomes a tiny `keyPressed` entity
-- that the InputSystem consumes.
----------------------------------------------------------------------

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

-- A long frame (dragging the window, a hiccup) would teleport the ball
-- through the paddle or the bottom wall, so cap the time step.
local MAX_DT = 1 / 30

local scene

function love.load()
    scene = Scene.new("breakout")

    -- system order IS the frame order: input -> spawn -> control ->
    -- simulate -> resolve -> speed up -> match rules -> draw
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

    scene:setup() -- each system creates what it owns
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
