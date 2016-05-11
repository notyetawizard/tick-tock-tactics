socket = require "socket"
entity = require "libs/entity"

local port = 9995
local udp = socket.udp()
udp:setsockname("*", port)

--only objects need to be sent to client as updates, map data should be sent *once* at the beggining of a game, or loaded from the files.

--temporary game data stuff!
objects = {
    hero = entity.new(8, 8),
    enemy = entity.new(3, 6)
}

function serializeObjects()
    local msg = ""
    for k, v in pairs(objects) do
        --seperate the x,y,hp,etc out somehow? Loop through them.
        msg = msg..table.concat({k, "x="..v.x, "y="..v.y}, " ").."\n" 
    end
    return msg
end

function updateObjects()
    action, dir = string.match("([%w]+) ([%w]+)")
    if action == "mv" then
        --need to set this up for multiple clients!
        hero:move(dir)
    end
end

while true do
    data, ip, port = udp:receivefrom()
    
    udp:sendto(serializeObjects(), ip, port)
end
