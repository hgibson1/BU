%initializes
clear
clc
imaqreset % resets all video objets

%setup video object and set resolution
vid = imaqhwinfo('winvideo')
vid = videoinput('winvideo',1,  'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
preview(vid);
