--[[
    Lab 2
    Hangman
]]

-- import dependencies
push = require 'lib/push'

Class = require 'lib/class'

require 'src/StateMachine'

require 'src/states/TitleScreenState'
require 'src/states/PlayState'
require 'src/states/GameOverState'


-- dimensions of the window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- resolution of the window
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seed the RNG
    math.randomseed(os.time())

    -- app window title
    love.window.setTitle('Hangman')

    -- initialize our fonts
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/font.ttf', 14)
    largeFont = love.graphics.newFont('fonts/font.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/font.ttf', 56)
    love.graphics.setFont(largeFont)

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end
    }
    gStateMachine:change('title')

    -- initialize keyboard input table
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}
end

-- when the mouse is pressed
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

-- when a key is pressed
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

-- conditional to test if mouse button was pressed, returns boolean
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

-- conditional to test if key was pressed, returns boolean
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

-- updates the state of the game, runs every frame
function love.update(dt)
    gStateMachine:update(dt)

    -- clear the input tables
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

-- updates the look of the game, runs every frame
function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end