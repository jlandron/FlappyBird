--[[
    update 0: Adding still images
    update 1: Adding parallax
    update 2: Adding the bird
    update 3: Adding gravity
    update 4: Jumping
    update 5: adding pipes
    update 6: making pipes come in pairs
    update 7: adding collision
    update 8: state machine update
    update 9: adding scoring
    update 10: adding countdown
]]
push = require("push")
Class = require("class")

require("Bird") 

require("Pipe")

require("PipePair")

require("StateMachine")
require("states/TitleScreenState")
require("states/ScoreState")
require("states/CountdownState")
require("states/BaseState")
require("states/PlayState")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage("images/background.png")
local backgroundScroll = 0

local ground = love.graphics.newImage("images/ground.png")
local groundScroll = 0

BACKGROUND_SCROLL_SPEED = 10

GROUND_SCROLL_SPEED = 45

local BACKGROUND_LOOPING_POINT = 413

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    math.randomseed(os.clock(0))

    love.window.setTitle("Funny Bird")

    --initialize a font for the game
    smallFont = love.graphics.newFont("fonts/font.ttf", 8)
    mediumFont = love.graphics.newFont("fonts/flappy.ttf", 14)
    flappyFont = love.graphics.newFont("fonts/flappy.ttf", 28)
    hugeFont = love.graphics.newFont("fonts/flappy.ttf", 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ["jump"] = love.audio.newSource("sounds/jump.wav", "static"),
        ["explosion"] = love.audio.newSource("sounds/explosion.wav", "static"),
        ["hurt"] = love.audio.newSource("sounds/hurt.wav", "static"),
        ["score"] = love.audio.newSource("sounds/score.wav", "static"),
        ["countdown"] = love.audio.newSource("sounds/countdown.wav", "static"),
        ["music"] = love.audio.newSource("sounds/marios_way.mp3", "static")
    }

    sounds["music"]:setLooping(true)
    sounds["music"]:play()

    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            vsync = true,
            fullscreen = false,
            resizable = true
        }
    )

    gStateMachine =
        StateMachine {
        ["title"] = function()
            return TitleScreenState()
        end,
        ["play"] = function()
            return PlayState()
        end,
        ["score"] = function()
            return ScoreState()
        end,
        ["countdown"] = function()
            return CountdownState()
        end
    }
    gStateMachine:change("title")

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {} --reset the table
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end
