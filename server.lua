socket = require "socket"
local udp = socket.udp()

--udp:settimeout(0)
udp:setsockname("*", 9995)

while true do
    print(udp:receivefrom())
end
