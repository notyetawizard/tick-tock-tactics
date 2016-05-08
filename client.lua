socket = require "socket"
local udp = socket.udp()
udp:setsockname("*", 9996)

local address, port = "50.72.136.153", 9995

local client_id = "client"

--udp:settimeout(0)
udp:setpeername(address, port)
msg = "Oh. Yeah, it's working. Thanks!"

udp:send(msg)
