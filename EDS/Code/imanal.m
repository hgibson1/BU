%% Inalysis code takes in image and returns partilce size distribution and
% total obscuration.

%%
function [img, obs] = imanal(imgin,level,channel)
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
if channel == 0
    img = imgin;
    img = rgb2gray(imgin); %convert image to grayscale
else
    img = imgin(:,:,channel);  %takes green channel for resolution so says Calvin
   
end


%     background = imopen(img,strel('disk',15)); %use open function to get background
%     img = img + background; % clear background by adding
%     level = graythresh(img); %compute thresh hold level using Otsu's method
img = im2bw(img,level); %convert image to binary.
%get total obscuration as percentage
    [r c] = size(img); % find dimensions of image
    obs = sum(sum(~img))/(r*c);  % diveds black pixels by size of image
    
end
