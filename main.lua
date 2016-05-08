entity = require "libs/entity"

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
    
    function hero:move(dir)
        if dir = "up" then end
    end
    
    hero.action = hero.move
    
    --[[
    function hero:move()
        --return a function into hero.action, if the move is good.
        if math.abs(self.x - cursor.x) + math.abs(self.y - cursor.y) <= self.speed 
        and (cursor.x ~= self.x or cursor.y ~= self.y) then
            cursor:lock(true)
            self.action  = function ()
                self.x, self.y = cursor.x, cursor.y
                self:none()
            end
        --else flash or something so it's clear it didn't work
        end
        
    end
    --]]
    
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

    objects = {}
    table.insert(objects, hero)
    table.insert(objects, cursor)
    
    timer = 0
    turn_time = 5
end

function love.keypressed(key)
    if key == (",") then hero:action("up")
    if key == ("o") then hero:action("down")
    if key == ("a") then hero:action("left")
    if key == ("e") then hero:action("right")
end    

function love.update(dt)    
    timer = timer + dt 
    if timer > turn_time then
        timer = timer - turn_time
    end    
end

function love.draw()
    love.graphics.scale(2)
    for k,v in pairs(objects) do
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(v.sprite, v.x*tile_size, v.y*tile_size)
    end
end
