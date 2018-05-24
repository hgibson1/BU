%% Inalysis code takes in image and returns partilce size distribution and
% total obscuration.

%%
function [img_out, obs] = imanal_no_lines(img_in,high_level,low_level,channel1, channel2)
% % Display original rgb image and 3 channels
% rgblayer(img);

% %transform image into binary
% img_red = imgin(:,:,1);
% img_red1 = img_red;
% img_red1(find(img_red1 > 60)) = 256;
% img_red1(find(img_red1 < 60)) = 0;
% 
% img_thresh = img_red;
% img_thresh(find(img_red1 == 0)) = 256;
% 
% level = graythresh(img_thresh); %compute thresh hold level using Otsu's method
%                               
% img = im2bw(img_thresh,level); %convert image to binary.
if channel1 == 0
    img1 = img_in;
    img1 = rgb2gray(img1); %convert image to grayscale
else
    img1 = img_in(:,:,channel1);  %takes green channel for resolution so says Calvin
end

if channel2 == 0
    img2 = img_in;
    img2 = rgb2gray(img2); %convert image to grayscale
else
    img2 = img_in(:,:,channel2);  %takes green channel for resolution so says Calvin
end

%     background = imopen(img,strel('disk',15)); %use open function to get background
%     img = img + background; % clear background by adding
%     level = graythresh(img); %compute thresh hold level using Otsu's method
img1 = im2bw(img1,low_level); %convert image to binary for low level
img2 = im2bw(img2,high_level); %convert image to binary for low level
img2(find(img1 == 0)) = 1;  %subracts dark areas (lines) from image with high threshold 
img_out = img2;
%get total obscuration as percentage
    [r c] = size(img_out); % find dimensions of image
    obs = sum(sum(~img_out))/(r*c);  % diveds black pixels by size of image
    
end
