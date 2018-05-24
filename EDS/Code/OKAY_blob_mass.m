function [yMassClean] = OKAY_blob_mass(BinaryImage)

% If set of blurry images: we can implement this type of blind filter,
% deconvblind, or deconvlucy into the code to correct for some blurryness:
% it does not give definite correctness if the depth of field is wrong, but
% it might help with segmentation, especially if blurred images cause the
% particles to seem like a single particle.
%PSF = fspecial('gaussian',15,15);
%originalImage = deconvblind(image,PSF);
%}
%originalImage = mat2gray(originalImage);
%grayImage = mean(originalImage,3);
%If originalImage needs to be filtered still

%binaryImage = imanal_no_lines(grayImage,1,.25,1,1);
%binaryImage = ~binaryImage;
%Change image to binary
%binaryImage = im2bw(originalImage,.6);
%binaryImage = imclearborder(binaryImage,4);
BinaryImage = ~BinaryImage;

statBin = regionprops(BinaryImage,'Eccentricity','PixelIdxList','Area','Centroid');

% Delete long stringy objects (probably human hairs or glass cracks
stringinesses = [statBin.Eccentricity];
tooStringyLog = stringinesses > .95;
indTooStringyLog = find(tooStringyLog);

for ii = 1:numel(indTooStringyLog)
    BinaryImage(statBin(indTooStringyLog(ii)).PixelIdxList) = 0;
end


% get size of binary image
%[mm,nn] = size(binaryImage);


dataStruct = regionprops(BinaryImage,'Area');
data = [dataStruct.Area];
data = data(data>0);

% Assume the data is each areas of spheres and find the radius of each.
for ii = 1:numel(data)
    %Check parenthesis on sqrt: if pi should be squared to correctly relate
    %A = pi * r^2
    data(ii) = sqrt(data(ii)/pi);
    %8/13/14 get to volume
    data(ii) = data(ii).*data(ii).*data(ii)*pi;
end
% Linearly convert pixel lengths to measured length: 2.3 microns per pixel
data = data * 2.3*(10^(-6)); 
% Clean up data that is too small to be resolved by the microscope
dataClean = data(data > (4 * 10^-6));

% Clean up data that is too big and will be seen as blury
dataClean = dataClean(dataClean < (70 * 10^-6));
dataClean = pi*(dataClean*10^(-6)).^2*2500;
%sets number of bins
binmass = ([4:5:70]*10^(-6))
% Generates histogram 
yMassClean=hist(dataClean, binmass);
yMassClean=yMassClean.*(binmass.^2)
end

