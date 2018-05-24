from socket import (socket, AF_INET, SOCK_STREAM, 
                    SOL_SOCKET, SO_REUSEADDR) 


HOST = '' #hostname, empty string means local host
PORT = 6789 #port number
BACKLOG = 5 #number of clients that can wait in queue if multiple trying to connect
SIZE = 1024 #message size 

#Creates TCP/IP socket
server_socket = socket(AF_INET, SOCK_STREAM)
server_socket.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1) 
server_socket.bind((HOST, PORT))
server_socket.listen(BACKLOG) 

while True:
    print 'Ready to serve...' 
    #accepts client connection
    client_socket, address = server_socket.accept()
    message = client_socket.recv(SIZE) #gets message from client
    filename = message.strip().split()[1] #extracts name of file from url
    try: 
        #opens file with name filename in same directory as server script
        file = open(filename[1:])    
        output_data = file.read() #extracts 'Hello World!' text from file
        client_socket.send(output_data) #sends text to client
        client_socket.send('HTTP/1.1 200 OK') #sends 200 response to client
    except IOError:  
        #client asked for file that is not stored on server
        file = open('file_not_found.html')
        output_data = file.read() #Extracts '404 File Not Found' text from file_not_found.html
        client_socket.send(output_data) #sends text with 404 response to client

    #closes client socket
    client_socket.close()
    
server_socket.close() #closes server socket
