entity = {}

function entity:move(dir)
end


entity.sprites = {
    hero = love.graphics.newImage("assets/hero.png"),
    enemy = love.graphics.newImage("assets/cursor.png")
}

function entity.new(x, y)
    local new = {
        x = x,
        y = y,
        move = entity.move
    }
    return new
end

return entity
