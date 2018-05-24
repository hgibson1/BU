%initializes
clear
clc
imaqreset % resets all video objets

%setup video object and set resolution
vid = imaqhwinfo('winvideo');
vid = videoinput('winvideo',1,  'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');

%set parameters for maximum and minimum threshold value
min = .9999999;
max = 1;

img = getsnapshot(vid); %gets image from camera
subplot(3,3,1); imshow(img); %puts original image as subplot in camera
title('original')

for i = 1:8;
dev = ((max-min)/8);
threshold = min + (dev * (i-1));
[imgnew{i} obs(i)] = imanal(img,threshold); %passes video to analysis function
subplot(3,3,i+1); imshow(imgnew{i}); %puts result into subplot
title(sprintf('%f',threshold));
xlabel(sprintf('%f',obs(i)));
end



% subplot(2,5,2); imshow(imgnew{1});
% subplot(2,5,3); imshow(imgnew{2});
% subplot(2,5,4); imshow(imgnew{3});
% subplot(2,5,5); imshow(imgnew{4});
% subplot(2,5,6); imshow(imgnew{5});
% subplot(2,5,7); imshow(imgnew{6});
% subplot(2,5,8); imshow(imgnew{7});
% subplot(2,5,9); imshow(imgnew{8});
% subplot(2,5,10); imshow(imgnew{9});