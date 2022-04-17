Cell = Class{}

function Cell:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.state = 0
    self.time = 0
    self.neighborsOn = 0
end

function Cell:getX()
    return self.x
end

function Cell:getY()
    return self.y
end

function Cell:getWidth()
    return self.width
end

function Cell:getHeight()
    return self.height
end

function Cell:setNeighborsOn(num)
    self.neighborsOn = num
end

function Cell:getNeighborsOn()
    return self.neighborsOn
end

function Cell:getState()
    return self.state
end

function Cell:setState(state)
    self.state = state
end

function Cell:update(dt)
end

function Cell:onMouse()
    mouseX, mouseY = love.mouse.getPosition()

    if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height then
        return true
    end
end

function Cell:onClick() 
    if self.state == 0 and self.onMouse() and love.mouse.wasPressed(l) then
        self.state = 1
    elseif self.state == 1 and self.onMouse() and love.mouse.wasPressed(l) then
        self.state = 0
    end
end

function Cell:render()
    if self.state == 0 then
        love.graphics.setColor(73, 46, 84, 0.50)
    elseif self.state == 1 then
        love.graphics.setColor(0, 0, 0)
    end

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end