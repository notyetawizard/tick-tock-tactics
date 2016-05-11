### TODO
* Next up is to get the client sending some moves to the server, and the server sending them back.

* The objects table should *not* be updated locally by the client, and should need to wait for the server to send it. This prevents invalid moves locally, and also keeps the player from thinking their move went through if it didn't. 
