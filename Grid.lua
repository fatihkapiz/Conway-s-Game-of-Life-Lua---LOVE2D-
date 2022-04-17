require 'Cell'

Grid = Class{}

function Grid:init()
    cells = {}          -- create the matrix
    cellsNext = {}
    for i=1,64 do
        cells[i] = {}     -- create a new row
        cellsNext[i] = {}
        for j=1,64 do
            cells[i][j] = Cell((j - 1) * 8, (i - 1) * 8, 8, 8)
            cells[i][j]:setState(math.random(2) - 1)
            cellsNext[i][j] = Cell((j - 1) * 8, (i - 1) * 8, 8, 8)
        end
    end

    for i=1,64 do
        for j=1,64 do
            if cells[i][j]:getState() == 1 then
                cells[i][j]:setState(math.random(2) - 1)
            end
        end
    end
end

function Grid:update(dt)
    for y=1,64 do 
        for x=1,64 do
            k = Grid:checkCellNeighbours(y, x)

            cells[y][x]:setNeighborsOn(k)
        end
    end

    for y=1,64 do
        for x=1,64 do

            if cells[y][x]:getState() == 1 and (cells[y][x]:getNeighborsOn() == 2 or cells[y][x]:getNeighborsOn() == 3) then
                cellsNext[y][x]:setState(1)
            elseif cells[y][x]:getState() == 0 and cells[y][x]:getNeighborsOn() == 3 then
                cellsNext[y][x]:setState(1)
            elseif cells[y][x]:getState() == 1 and cells[y][x]:getNeighborsOn() > 3 then
                cellsNext[y][x]:setState(0)
            else 
                cellsNext[y][x]:setState(0)
            end
        end
    end

    cells, cellsNext = cellsNext, cells

    love.timer.sleep(0.3)
end



function Grid:render()
    for i=1,64 do
        for j=1,64 do
            cells[i][j]:render()
        end
    end
end

function Grid:checkCellNeighbours(y, x)

    x = x % 65
    y = y % 65
    down = y - 1
    up = y + 1
    left = x - 1
    right = x + 1

    if  x == 1 then
        left = 64
    else 
        left = x - 1
    end

    if x == 64 then
        right = 1
    else
        right = x + 1
    end

    if y == 1 then
        up = 64
    else 
        up = y - 1
    end

    if y == 64 then
        down = 1
    else
        down = y + 1
    end

    local aliveAmount = cells[up][left]:getState() +
    cells[up][x]:getState() +
    cells[up][right]:getState() +
    cells[y][left]:getState() +
    cells[y][right]:getState() +
    cells[down][left]:getState() +
    cells[down][x]:getState() +
    cells[down][right]:getState()
 
    return aliveAmount
end
