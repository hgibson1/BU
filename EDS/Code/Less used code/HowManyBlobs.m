%{
Testing for how many iterations you need to do in order to get an
appropriate number of iterations of erosions.  Record against human vision
and this will allow us to fine tune the algorithm used in BEST_blob_fn.m

Return a newFile.txt that has the mat and then the userValues.  The mat
shows how many blobs matlab has separated thus far, cumulatively,
 and the userValues is the last line of the file that shows how many
separations the file really should have. 
%}



clear

% Prep to write to a file iterations.txt
% If exist('filename.extension','file')==2 then it is a file in Matlab's
% directory
%{
if exist('Iterations.txt', 'file')==2
    delete('Iterations.txt');
end
fileID = 0;
%}

% To save the user time, let the user do all of his work before we run any
% code that will take time to work

numIterations = 1;
numFiles = 100;
% Plate A is 71 pictures, Plate B is 41 pictures in testing

% Open a file and read in each line of data
%{
fid = fopen('PlateA.txt');
userValues = zeros(71,1);
counter = 1;
while ~feof(fid)
    
    singlePic = fgetl(fid);
    originalImage = imread(singlePic);
    imshow(originalImage);
    
    userValues(counter) = input('How many connected blobs do you see? ');
    counter = counter + 1;
end % the while loop of the person looking at pictures

fclose('all');
%}

% Dave
userValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,3,2,0,0,0,0,0,0,0,0,0,6,5,0,0,0,0,2,22,5,2,5,0,0,0,0,2,2,0,3,0,0];

% Matt
% userValues = [0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,7,0,6,5,0,0,0,0,0,20,7,4,3,0,0,0,0,2,2,0,3,0,0];


% Do the heavy matlab processing with many iterations

% Change the plate name to whatever it is using
fid = fopen('PlateB.txt');
counter = 1;
%mat = zeros(numFiles,numIt);
mat = zeros(numFiles,numIterations);
while ~feof(fid)
    singlePic = fgetl(fid);
    % Run the best image recognition software available
    [mat(counter,:),plateIDR01C01] = BEST_blob_fn(singlePic,numIterations);
    
    
    % Start a graph to compare human input to computer imaging
    % y axis is number of blobs
    % x axis is the number of iterations for each separation
    %{
    figure('Name',plateIDR01C01);
    title(plateIDR01C01);
    set(gcf, 'Position', get(0, 'ScreenSize'));
    %}
    xU = 0:numIterations;
    yU = userValues(counter);
    axis([0,numIterations,0,15])
    hold on;
    % One data set for each picture
    x = 1:numel(mat(counter,:));
    y = cumsum(mat(counter,:));
    % Show that up until the first iteration, no clumps are parsed
    xI = [0,x];
    yI = [0,y];
    %ppp = plot(xU,yU,xI,yI);
    %legend(ppp, 'User Data', 'Matlab Iteration Data');
    hold on;
    %}


mat(counter,:) = cumsum(mat(counter,:),2);
%Write to a file
    fileID = fopen('newFile.txt','w');
    dlmwrite('newFile.txt',mat)
    %fprintf(fileID,'%s \n %d \n %d \n\n',plateIDR01C01, userValues, yI);


counter = counter + 1;



end % While loop


% If you want to write to a text file: make sure to rename it to whatever
% you want, specifically who took the test and the parameters of
% thresholding/other adjustments made
%dlmwrite('newFile.txt',userValues','-append')



% Make a bar graph showing the number of iterations and show when how many
% of the 71 pictures get good data, too much separation, or too little
% separation at a given iteration point.

% Make new matrix signMat, with negative numbers show an iteration that
% hasn't broken enough up, zeros show perfect eroding, and positive shows
% too much eroding
% numFiles here is 71, numIterations is 20
signMat = zeros(numFiles,numIterations);
for ii = 1:numFiles
    signMat(ii,:) = mat(ii,:) - (userValues(ii).*ones(1,numIterations));
end

% Make a binary matrix: each row of the matrix will give a binary of which
% pictures at which point need to be eroded/thresholded more, no more, or
% have gone too far
negMat = signMat < 0;
zeroMat = signMat == 0;
plusMat = signMat > 0;

tooLow = zeros(1,numIterations);
justRight = zeros(1,numIterations);
tooHigh = zeros(1,numIterations);

for ii = 1:numIterations
    % fill in a data point for  a iteration according to how many of the
    % pictures fit each profile.  Find number of elements that the index
    % returns from find function
    tooLow(ii) = numel(find(negMat(:,ii)));
    justRight(ii) = numel(find(zeroMat(:,ii)));
    tooHigh(ii) = numel(find(plusMat(:,ii)));
end

figure('Name','Dave B Thresh .10, .01');
title('Dave B Thresh .10, .01');
set(gcf, 'Position', get(0, 'ScreenSize'));
bar(1:20,[tooLow' justRight' tooHigh'], 0.5, 'stack');
axis([0 numIterations+1 0 numFiles+1]);
xlabel('Iteration');
ylabel('number of Pictures');
legend('Need More', 'Perfect', 'Too much');

fclose(fid);
fclose('all');