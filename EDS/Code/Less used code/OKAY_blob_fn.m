function [ data, grayImage, row, col, m, n, plateIDR01C01 ] = blob_fn( plateIDR01C01, plateMat, numLoops )
% Note: sizes in pixels: there are apprx 2.64X10^-6m per pixel length in
% the images
% For final, return plateMat
% numclumped is a vector showing how many blobs it splits per iteration

% Possible problem in Figure 4: Split Mat: llok at the small 5 white pixels
% in the bottom left hand corner of the picture


%{
            Blob Detection and Analysis
                for Use of Solar Panel Optical Analysis

            PHO 417 Applied ElectroMagnetics
                Prof. Mazumder, Prof. Horenstein
                Jeremy Stark, John Hudelson, Hanna Gibson, David Crowell

            Written by Noah Hudelson, David Crowell
            For questions, please contact <dcrowell> (AT) <bu> (DOT) <edu>

%}
%%
%{
 
 Capabilities

    pass: in image, as .png, .jpeg, or binary matrix of 2 or 3 dimensions

    return: out matrix with histogram data

    show: original image
          colormapped image
          original image with a colored separation of uncleaved blobs

    plot: unbinned data
          binned data
         
 IMPORTANT: All files must be saved in format: fileNameX##Y
 really, just make sure that the row number is 9:10 index
 of the file name and that the col number is the 12:13 index
 of the file name.  Pass in the the input argument as a string
 (with single quotations that contain the name of the file).

%}



%% Begin Timer

tic; % Start timer.


%% Image preprocessing

% Read image

% Find which Column/Picture the microscope is looking at
%{
row = plateIDR01C01(9:10);
col = plateIDR01C01(12:13);
% Parse out the col and row from file name
row = str2double(row);
col = str2double(col);
%}
plateIDR01C01
if numel(plateIDR01C01) == 12
    row = '10';
    col = '10';
elseif (numel(plateIDR01C01) == 10)
    row = plateIDR01C01(4);
    col = plateIDR01C01(5);
elseif (numel(plateIDR01C01) == 11)
    if plateIDR01C01(6) == '0'
        row = plateIDR01C01(4);
        col = '10';
    elseif (plateIDR01C01(5) == '0')
        row = '10';
        col = plateIDR01C01(6);
    end
end

row = str2double(row);
col = str2double(col);

% Read in the picture as a matrix
originalImage = imread(plateIDR01C01);

%{
% If set of blurry images: we can implement this type of blind filter,
% deconvblind, or deconvlucy into the code to correct for some blurryness:
% it does not give definite correctness if the depth of field is wrong, but
% it might help with segmentation, especially if blurred images cause the
% particles to seem like a single particle.
PSF = fspecial('gaussian',15,15);
originalImage = deconvblind(originalImage,PSF);
%}
originalImage = mat2gray(originalImage);
grayImage = mean(originalImage,3);
%If originalImage needs to be filtered still

binaryImage = imanal_no_lines(grayImage,1,.25,1,1);
binaryImage = ~binaryImage;
% Change image to binary
%binaryImage = im2bw(originalImage,.6);
binaryImage = imclearborder(binaryImage,4);
%binaryImage = ~binaryImage

statBin = regionprops(binaryImage,'Eccentricity','PixelIdxList','Area','Centroid');

% Delete long stringy objects (probably human hairs or glass cracks
stringinesses = [statBin.Eccentricity];
tooStringyLog = stringinesses > .95;
indTooStringyLog = find(tooStringyLog);

for ii = 1:numel(indTooStringyLog)
    binaryImage(statBin(indTooStringyLog(ii)).PixelIdxList) = 0;
end


% get size of binary image
[mm,nn] = size(binaryImage);


dataStruct = regionprops(binaryImage,'Area');
data = [dataStruct.Area];
data = data(data>0);



end