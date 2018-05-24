from socket import socket, AF_INET, SOCK_STREAM

HOST = '128.197.127.65' 
PORT = 6789
SIZE = 1024

s = socket(AF_INET, SOCK_STREAM)
s.connect((HOST, PORT))
s.send('hello_world.html')
data = s.recv(SIZE)

s.close()
print data
