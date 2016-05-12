socket = require "socket"
entity = require "libs/map"

local port = 9995
local udp = socket.udp()
udp:settimeout(1)
udp:setsockname("*", port)

--only objects need to be sent to client as updates, map data should be sent *once* at the beggining of a game, or loaded from the files.

--temporary game data stuff!
map = map.new()
map:newObject("token_1", 8, 8)
map:newObject("token_2", 3, 6)

function serializeObjects()
    local dg = ""
    for k, v in pairs(map.objects) do
        --seperate the x,y,hp,etc out somehow? Loop through them.
        dg = dg..table.concat({k, "x="..v.x, "y="..v.y}, " ").."\n" 
    end
    return dg
end

function updateObjects(dg)
    name, action, dir = string.match(dg, "([%w_]+) ([%w]+) ([%w]+)")
    if action == "mv" then
        map:move(name, dir)
    end
end

while true do
    dg, ip, port = udp:receivefrom()
    if dg then 
        updateObjects(dg)
        udp:sendto(serializeObjects(), ip, port)
    end
end
