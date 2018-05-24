function [yClean] = OKAY_blob_size(image)

% If set of blurry images: we can implement this type of blind filter,
% deconvblind, or deconvlucy into the code to correct for some blurryness:
% it does not give definite correctness if the depth of field is wrong, but
% it might help with segmentation, especially if blurred images cause the
% particles to seem like a single particle.
PSF = fspecial('gaussian',15,15);
originalImage = deconvblind(image,PSF);
%}
originalImage = mat2gray(originalImage);
grayImage = mean(originalImage,3);
%If originalImage needs to be filtered still

binaryImage = imanal_no_lines(grayImage,1,.25,1,1);
binaryImage = ~binaryImage;
%Change image to binary
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
%[mm,nn] = size(binaryImage);


dataStruct = regionprops(binaryImage,'Area');
data = [dataStruct.Area];
data = data(data>0);

% Assume the data is each areas of spheres and find the radius of each.
for ii = 1:numel(data)
    data(ii) = sqrt(data(ii))/pi;
end
% Linearly convert pixel lengths to measured length: 2.3 microns per pixel
data = data * 2.3*(10^(-6));

% Clean up data that is too small to be resolved by the microscope
dataClean = data(data > (4 * 10^-6));

% Clean up data that is too big and will be seen as blury
dataClean = dataClean(dataClean < (18 * 10^-6));

DATA.clean = dataClean;
DATA.clean = DATA.clean;

%sets number of bins
binsize = (4:1:18) * 10^(-6);

% Generates histogram for pretty graphs that can be shaped to exemplify bell curves
yClean = hist(dataClean, binsize);   

end


