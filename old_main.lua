function love.load()
    love.graphics.setDefaultFilter("nearest")
    love.graphics.setBackgroundColor(0, 64, 64)
    
    tile_size = 16
    hero = {
        x = 8,
        y = 8,
        dx = 0,
        dy = 0,
        speed = 1,
        sprite = love.graphics.newImage("hero.png")
    }
    
    hero.action = hero.move
    
    cursor = {
        x = hero.x,
        y = hero.y,
        locked = false,
        sprite = love.graphics.newImage("cursor.png"),
        sprite_unlocked = love.graphics.newImage("cursor.png"),
        sprite_locked = love.graphics.newImage("cursor_locked.png"),
    }
    function cursor:lock(set)
        if set == null then self.locked = not self.locked    
        else self.locked = set
        end
        if self.locked == true then self.sprite = self.sprite_locked
        else self.sprite = self.sprite_unlocked
        end
    end
end
