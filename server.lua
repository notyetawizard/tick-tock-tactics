socket = require "socket"
entity = require "libs/entity"

local port = 9995
local udp = socket.udp()
udp:settimeout(1)
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

function updateObjects(dg)
    action, dir = string.match(dg, "([%w]+) ([%w]+)")
    if action == "mv" then
        --need to set this up for multiple clients!
        objects.hero:move(dir)
    end
end

while true do
    dg, ip, port = udp:receivefrom()
    if dg then 
        updateObjects(dg)
        udp:sendto(serializeObjects(), ip, port)
    end
end
