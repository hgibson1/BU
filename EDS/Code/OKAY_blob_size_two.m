function [yClean] = OKAY_blob_size_two(BinaryImage)

% If set of blurry images: we can implement this type of blind filter,
% deconvblind, or deconvlucy into the code to correct for some blurryness:
% it does not give definite correctness if the depth of field is wrong, but
% it might help with segmentation, especially if blurred images cause the
% particles to seem like a single particle.
% PSF = fspecial('gaussian',15,15);

%}
% originalImage = mat2gray(originalImage);
% grayImage = mean(originalImage,3);
% %If originalImage needs to be filtered still
% 
% binaryImage = imanal_no_lines(grayImage,1,.25,1,1);
% binaryImage = ~binaryImage;
% %Change image to binary
% %binaryImage = im2bw(originalImage,.6);


%on 8/13/14 Dave addedthe ~ (NOT) operator before the BinaryImage in the next line to invert the image processed: check this inversion if stuff is coming out weird
%BinaryImage = ~BinaryImage;
%BinaryImage = deconvblind(BinaryImage,PSF);
%BinaryImage = imclearborder(BinaryImage,4);
statBin= regionprops(BinaryImage,'Eccentricity','PixelIdxList','Area','Centroid');

% Delete long stringy objects (probably human hairs or glass cracks
stringinesses = [statBin.Eccentricity];
tooStringyLog = stringinesses > .95;
indTooStringyLog = find(tooStringyLog);

for i = 1:numel(indTooStringyLog)
    BinaryImage(statBin(indTooStringyLog(i)).PixelIdxList) = 0;
end

dataStruct = regionprops(BinaryImage,'Area');
data = [dataStruct.Area];
data = data(data>0);

% Assume the data is each areas of spheres and find the radius of each.
for j = 1:numel(data)
    %Dave 8/13/14: sqrt of whole thing, not just data
    data(j) = sqrt(data(j)/pi);
end
% Linearly convert pixel lengths to measured length: 2.3 microns per pixel
data = data * 2.3*(10^(-6));

% Clean up data that is too small to be resolved by the microscope
dataClean = data(data > (2 * 10^(-6)));

% Clean up data that is too big and will be seen as blury
dataClean = dataClean(dataClean < (70 * 10^(-6)));

%DATA.clean = dataClean;
%DATA.clean = DATA.clean;

%sets number of bins
binsize = [2:1:68] * 10^(-6);

% Generates histogram for pretty graphs that can be shaped to exemplify bell curves
yClean = hist(dataClean, binsize);   

end


