Bird = Class{}

local GRAVITY = 20

local JUMP_SPEED = -5
local MOVE_SPEED = 1

function Bird:init(  )
    self.image = love.graphics.newImage('images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2) 

    self.dy = 0
    self.mouseclicked = false

end
function Bird:collides(pipe)
    if(self.x + 2) + (self.width - 4) >= pipe.x and self.x <= pipe.x + pipe.width then
        if(self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + pipe.height then
            return true
        end
    end
    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or self.mouseclicked then
        sounds['jump']:play()
        self.dy = JUMP_SPEED
    end
    self.y = self.y + self.dy
    self.mouseclicked = false
end
function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end