socket = require "socket"

function love.load()
    --establish networking
    udp = socket.udp()
    local address, port = "50.72.136.153", 9995
    udp:settimeout(0)
    udp:setpeername(address, port)
    msg = "Here's a message!"
    
    --some graphics things
    love.graphics.setDefaultFilter("nearest")
    love.graphics.setBackgroundColor(0, 64, 64)
end

function love.keypressed(key)
    if key == (",") then hero:action("up")
    elseif key == ("o") then hero:action("down")
    elseif key == ("a") then hero:action("left")
    elseif key == ("e") then hero:action("right")
    end
end

function updateObjects(r)
    if objects = nil then objects = {}
    --break the response into a table of updates to do
    for line in string.gmatch(r, "*/n") do
        local name = string.match(line, "[%w]")
        if objects[name] = nil then objects[name] = {}
        for word in string.gmatch(line, "%w=%w") do
            local key, value = string.gmatch(word, "%w")
            objects[name][key] = value
        end
    end
    --Okay, I think this should be roughly working. It is, however, insecure, and doesn't check to make sure anything is valid!
end

function love.update()
    udp:send(msg)
    updateObjects(udp:receive())
end

function love.draw()
    love.graphics.scale(2)
    for k,v in pairs(objects) do
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(entities.sprites[k], v.x*tile_size, v.y*tile_size)
    end
end
