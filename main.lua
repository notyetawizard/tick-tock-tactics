socket = require "socket"

function love.load()
    --establish networking
    udp = socket.udp()
    local address, port = "50.72.136.153", 9995
    udp:settimeout(0)
    udp:setpeername(address, port)  
    udp:send("init!") 
    tile_size = 16
    
    --some graphics things
    love.graphics.setDefaultFilter("nearest")
    sprites = {
        tile = love.graphics.newImage("assets/tile.png"),
        hole = love.graphics.newImage("assets/hole.png")
    }
    for i = 0, 9, 1 do
        sprites["token_"..i] = love.graphics.newImage("assets/token_"..i..".png")
    end
    
end

function love.keypressed(key)
    local function move(dir)
        udp:send("token_1 mv "..dir)
    end
    
    if key == (",") then move("up")
    elseif key == ("o") then move("down")
    elseif key == ("a") then move("left")
    elseif key == ("e") then move("right")
    end
end

function updateObjects(dg)
    --break the response into a table of updates to do
    if not objects then objects = {} end
    for name, attr in string.gmatch(dg, "([%w_]+) ([%w%-= ]+)\n") do
        if not objects[name] then objects[name] = {} end
        for key, value in string.gmatch(attr, "([%w]+)=([%w%-]+)") do
            objects[name][key] = value
        end
    end
    --Okay, I think this should be roughly working. It is, however, insecure, and doesn't check to make sure anything is valid! All that validation should happen prior to things getting put in the objects table, which means: parse into new table; validate and return into objects if good.
    --Actually, *can* the objects be invalid? Can the client even judge that?
end

function love.update()
    dg = udp:receive()
    if dg then updateObjects(dg) end
end

function love.draw()
    love.graphics.scale(3)
    if objects then
        for k,v in pairs(objects) do
            love.graphics.draw(sprites[k], v.x*tile_size, v.y*tile_size)
        end
    end
end
