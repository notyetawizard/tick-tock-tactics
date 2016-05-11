entity = {}

function entity:move(dir)
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
