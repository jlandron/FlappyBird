Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')

PIPE_SPEED = 60

--global variables for size of pipe
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

function Pipe:init(orientation, y)
    --start the pipe off the right of the screen
    self.x = VIRTUAL_WIDTH
    --randomize the 
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation
    
end

function Pipe:update(dt)
    
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, 
        (self.orientation=='top' and self.y + PIPE_HEIGHT or self.y),
        0, --rotation, none
        1, --x axis scale
        self.orientation == 'top' and -1 or 1) -- y axis scale, -1 flips along y, 1 does nothing
end