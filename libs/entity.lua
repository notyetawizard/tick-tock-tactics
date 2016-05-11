entity = {}

function entity:move(dir)
    if dir == "up" then self.y = self.y - 1
    elseif dir == "down" then self.y = self.y + 1
    elseif dir == "left" then self.x = self.x - 1
    elseif dir == "right" then self.x = self.x + 1
    end
end

function entity.new(x, y)
    local new = {
        x = x,
        y = y,
        move = entity.move
    }
    return new
end

return entity
