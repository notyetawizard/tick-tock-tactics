socket = require "socket"

local udp = socket.udp()

local address, port = "50.72.136.153", 9995

local client_id = "client"

--udp:settimeout(0)
udp:setpeername(address, port)
msg = "Here's a message!"

while true do
    udp:send(msg)
    print(udp:receive())
    os.execute("sleep 1")
end
