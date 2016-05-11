socket = require "socket"

function love.load()
    --establish networking
    udp = socket.udp()
    local address, port = "50.72.136.153", 9995
    udp:settimeout(0)
    udp:setpeername(address, port)
    msg = "Here's a message!"    
    tile_size = 16
    
    --some graphics things
    love.graphics.setDefaultFilter("nearest")
    love.graphics.setBackgroundColor(0, 64, 64)
    
    sprites = {
        hero = love.graphics.newImage("assets/hero.png"),
        enemy = love.graphics.newImage("assets/cursor.png")
    }
end

function love.keypressed(key)
    if key == (",") then hero:action("up")
    elseif key == ("o") then hero:action("down")
    elseif key == ("a") then hero:action("left")
    elseif key == ("e") then hero:action("right")
    end
end

function updateObjects(r)
    --if not objects then objects = {} end
    --break the response into a table of updates to do
    if not objects then objects = {} end
    for name, updates in string.gmatch(r, "([%w]+) ([%w= ]+)\n") do
        if not objects[name] then objects[name] = {} end
        for key, value in string.gmatch(updates, "(%w+)=(%w+)") do
            objects[name][key] = value
        end
    end
    --Okay, I think this should be roughly working. It is, however, insecure, and doesn't check to make sure anything is valid! All that validation should happen prior to things getting put in the objects table, which means: parse into new table; validate and return into objects if good.
end

function love.update()
    udp:send(msg)
    r = udp:receive()
    if r then updateObjects(r) end
end

function love.draw()
    love.graphics.scale(2)
    if objects then
        for k,v in pairs(objects) do
            love.graphics.setColor(255,255,255,255)
            love.graphics.draw(sprites[k], v.x*tile_size, v.y*tile_size)
        end
    end
end
