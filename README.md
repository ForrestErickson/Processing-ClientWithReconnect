# Processing-ClientWithReconnect
A Processing network program, A Socket Client which connects and reconnects to a Server started after the Client.

Developed as a template for my work with wireless communication chips where I have the same problem to solve 
(a client connecting to a server which may come and go). By solving the problem in Proccessing I hope to work 
faster and have the advantage that I can put Wireshark on the network transactions to see how I am doing.

Uses the Processing network library.
When run tries to find if there is a socket connection by using " if (myClient.active() == true)" in the maind draw().
If false, we do not have a server.
I would liked to have used a try catch on opening a server but could not make it work because when I set the catch
exception type for IOException, the IDE said that the try would never produce such an exception. My catch code would be
unreachable and it would not build.

If you run this project before a server it brings up a red window. Then when the server is run and becomes present 
the window changes color and text message in the window identifes the socket (ip address and port) of the server to 
which the client has connected. When the server is terminated the window changes color again. 
Periodicaly (500 milliseconds) the client trys to reconnect and on success again changes the window color.

Left and Righ Mouse presses send some text to the server.
