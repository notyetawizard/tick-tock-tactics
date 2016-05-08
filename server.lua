socket = require "socket"

local port = 9995
local udp = socket.udp()
udp:setsockname("*", port)

while true do
    data, ip, port = udp:receivefrom()
    print(data, ip, port)
    udp:sendto("Thanks!", ip, port)
end
