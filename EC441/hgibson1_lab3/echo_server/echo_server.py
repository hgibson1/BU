from socket import (socket, AF_INET, SOCK_STREAM, 
                    SOL_SOCKET, SO_REUSEADDR) 

HOST = '' #hostname, empty string means local host
PORT = 50000 #port number
BACKLOG = 5 #number of clients that can wait in queue if multiple trying to connect
SIZE = 1024 #message size 

#Creates TCP/IP socket
#AF_INET indicates IPv4
#SOCK_STREAM indicates 
#SOL_SOCKET indicates this can be only socket
#SO_REUSEADDR indicates same port used every time
#1 indicates
s = socket(AF_INET, SOCK_STREAM)
s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1) 
s.bind((HOST, PORT))
s.listen(BACKLOG)

#accepts client connection
client, address = s.accept()
data = client.recv(SIZE)

#sends data to client
client.send(data)

#close socket
client.close()
s.close()

