
local GRID = 20
local CELL = 30
local STEP_TIME = 0.5

local snake, direction, nextDirection, food
local timer, score, gameOver
local eatSound
local paused = false
local highScore = 0

-- Create food at a random free position
local function spawnFood()
    while true do
        local x = love.math.random(0, GRID - 1)
        local y = love.math.random(0, GRID - 1)
        local free = true

        for _, seg in ipairs(snake) do
            if seg.x == x and seg.y == y then
                free = false
                break
            end
        end

        if free then
            food = {x = x, y = y}
            return
        end
    end
end

-- Save high score
local function saveHighScore()
    love.filesystem.write("highscore.txt", tostring(highScore))
end

-- Load high score
local function loadHighScore()
    local data = love.filesystem.read("highscore.txt")

    if data then
        highScore = tonumber(data) or 0
    else
        highScore = 0
    end
end

-- Reset the game
local function resetGame()
    snake = {
        {x = 10, y = 10},
        {x = 9, y = 10},
        {x = 8, y = 10}
    }

    direction = {x = 1, y = 0}
    nextDirection = {x = 1, y = 0}

    timer = 0
    score = 0
    gameOver = false
    paused = false

    -- Reset snake speed
    STEP_TIME = 0.5

    spawnFood()
end

-- Move the snake
local function moveSnake()
    direction = nextDirection

    local head = snake[1]

    local newHead = {
        x = head.x + direction.x,
        y = head.y + direction.y
    }

    -- Wrap around walls
    newHead.x = newHead.x % GRID
    newHead.y = newHead.y % GRID

    -- Self collision
    for _, seg in ipairs(snake) do
        if seg.x == newHead.x and seg.y == newHead.y then
            gameOver = true
            return
        end
    end

    table.insert(snake, 1, newHead)

    -- Eat food or move normally
    if newHead.x == food.x and newHead.y == food.y then
        score = score + 1

        -- Update and save high score
        if score > highScore then
            highScore = score
            saveHighScore()
        end

        -- Play eating sound
        eatSound:stop()
        eatSound:play()

        -- Increase speed after eating
        STEP_TIME = math.max(0.05, STEP_TIME - 0.05)

        spawnFood()
    else
        table.remove(snake)
    end
end

function love.load()
    love.window.setMode(GRID * CELL, GRID * CELL)
    love.window.setTitle("Snake")

    -- Load eating sound
    eatSound = love.audio.newSource("eat.wav", "static")

    -- Load saved high score
    loadHighScore()

    resetGame()
end

function love.update(dt)
    -- Stop updating when paused or game over
    if gameOver or paused then return end

    timer = timer + dt

    if timer >= STEP_TIME then
        timer = timer - STEP_TIME
        moveSnake()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
        return
    end

    if gameOver then
        if key == "space" or key == "return" then
            resetGame()
        end
        return
    end

    -- Pause and resume with P
    if key == "p" then
        paused = not paused
        return
    end

    if paused then return end

    if (key == "up" or key == "w") and direction.y == 0 then
        nextDirection = {x = 0, y = -1}

    elseif (key == "down" or key == "s") and direction.y == 0 then
        nextDirection = {x = 0, y = 1}

    elseif (key == "left" or key == "a") and direction.x == 0 then
        nextDirection = {x = -1, y = 0}

    elseif (key == "right" or key == "d") and direction.x == 0 then
        nextDirection = {x = 1, y = 0}
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.12)

    -- Draw food
    love.graphics.setColor(1, 0.3, 0.3)
    love.graphics.rectangle(
        "fill",
        food.x * CELL,
        food.y * CELL,
        CELL - 2,
        CELL - 2
    )

    -- Draw snake
    for i, seg in ipairs(snake) do
        if i == 1 then
            love.graphics.setColor(0.5, 1, 0.6)
        else
            love.graphics.setColor(0.3, 0.8, 0.4)
        end

        love.graphics.rectangle(
            "fill",
            seg.x * CELL,
            seg.y * CELL,
            CELL - 2,
            CELL - 2
        )
    end

    -- Draw score and high score
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.print("High Score: " .. highScore, 10, 30)

    -- Pause message
    if paused then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(
            "PAUSED - Press P to resume",
            0, GRID * CELL / 2 - 20,
            GRID * CELL, "center"
        )
    end

    -- Game over message
    if gameOver then
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle(
            "fill", 0, 0, GRID * CELL, GRID * CELL
        )

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(
            "GAME OVER\nScore: " .. score ..
            "\nHigh Score: " .. highScore ..
            "\nPress SPACE to restart",
            0, GRID * CELL / 2 - 50,
            GRID * CELL, "center"
        )
    end
end
