push = require 'push'
Class = require 'class'

require 'Cell'
require 'Grid'

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 1024

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 512

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 4)

    -- set LÖVE's active font to the smallFont object
    love.graphics.setFont(smallFont)
    love.window.setTitle('Game of Life')

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = false
    })

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
    mousePosX = 0
    mousePosY = 0

    grid = Grid()

    gameState = 'start'

    debug.debug()
end


function love.update(dt)
    if gameState == 'start' then
        if love.keyboard.wasPressed('space') then
            gameState = 'play'
        end
    elseif gameState == 'play' then
        grid:update(dt)

        love.graphics.setBackgroundColor(255, 255, 255)

        if love.keyboard.wasPressed('r') then
            grid = Grid()
            gameState = 'start'
        elseif love.keyboard.wasPressed('space') then
            gameState = 'start'
        end
    end

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

-- updates the buttonsPressed table for each frame
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
    if button == 1 then
        mousePosX = x
        mousePosY = y
    end
end

-- returns the state of the table
function love.mouse.wasPressed(button) 
    return love.mouse.buttonsPressed[button]
end
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

--[[
    Keyboard handling, called by LÖVE each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    
    -- if we press enter during the start state of the game, we'll go into play mode
    -- during play mode, the Cell will move in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
        end
    end
end

function love.draw()
    push:apply('start')
    
    love.graphics.setBackgroundColor(0, 0, 0)
    grid:render()

    push:apply('end')
end