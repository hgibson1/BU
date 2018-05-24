from socket import socket, AF_INET, SOCK_STREAM
import sys

#constants
MAIL_SERVER = 'relay.bu.edu' #mail server of BU Domain
PORT = 25 #SMPT well known port 
SIZE = 1024

#initializing socket
client_socket = socket(AF_INET, SOCK_STREAM)
client_socket.connect((MAIL_SERVER, PORT))
print 'connected to server'

MSG = 'Could you hold, I need to eat a biscuit! \r\n' #email message to send
END_MSG = '\r\n.\r\n' #email message terminator

data = client_socket.recv(1024) #gets setup message from server
print data

if data[:3] != '220': #setup message has response 220, if no 220 response exits
    print '220 reply not recieved from server'
    sys.exit(1)

HELO = 'HELO relay.bu.edu \r\n' #sends helo to server
client_socket.send(HELO) #hello used by client to identify seld

data = client_socket.recv(SIZE) #gets server response
print data

if data[:3] != '250': #250 is sucessful response, if not 250 exits
    print '250 reply not recieved from server'
    sys.exit(2)

MAIL_FROM = 'MAIL FROM:<hgibson1@bu.edu> \r\n' #sends id of sender of email to server
client_socket.send(MAIL_FROM)

data = client_socket.recv(SIZE)
print data

if data[:3] != '250': #if not successfull response exits
    print '250 reply not recieved from server'
    sys.exit(3)

RCPT_TO = 'RCPT TO:<hgibson1@bu.edu> \r\n' #sends if of recipient of email to server
#RCPT_TO = 'RCPT TP:<blob@bu.edu> \r\n' #this was the non existent email for the error test
client_socket.send(RCPT_TO)

data = client_socket.recv(SIZE)
print data

if data[:3] != '250': #if not successful response exits
    print '250 reply not recieved from server'
    sys.exit(4)

DATA = 'DATA \r\n' #sends DATA command to server
client_socket.send(DATA) #data signifies begining of message

data = client_socket.recv(SIZE)
print data

if data[:3] != '354': #354 is successful response, if not 354 exits
    print '354 reply not recieved from server'
    sys.exit(5)

client_socket.send(MSG) #sends email. Will be from hgibson1@bu.edu to hgibson1@bu.edu
client_socket.send(END_MSG) #ends email terminator

data = client_socket.recv(SIZE)
print data

if data[:3] != '250': #chekcs for successful responsed and exits if not successful
    print '250 message not recieved from server'
    sys.exit(6)

QUIT = 'QUIT \r\n' #sends quit command to closed connection
client_socket.send(QUIT)

data = client_socket.recv(SIZE)
print data

if data[:3] != '221': #221 indicates successful response. Exits if not successful
    print '221 reply not recieved from server'
    sys.exit(7)

client_socket.close() #closes connection

