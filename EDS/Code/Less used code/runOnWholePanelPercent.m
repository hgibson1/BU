
%Dirty Data

% Change the plate name to whatever it is using
plateFolder = cd('PlateDirty');

fid = fopen('picList.txt');
data = [];
plateMat = zeros(10,10,5);
while ~feof(fid)
    singlePic = fgetl(fid);
    dataSet = OKAY_blob_fn(singlePic,plateMat);
    data = [data dataSet];
end


% Assume the data is each areas of spheres and find the radius of each.
for ii = 1:numel(data)
    data(ii) = sqrt(data(ii))/pi;
end
% Linearly convert pixel lengths to measured length: 2.3 microns per pixel
dataDirty = data * 2.3*(10^(-6));

% For dynamic bin numbers, chose n bins and pass this number as the second
% argument into the hist function
% Sturges' Rule: k bins: k = log base 2(n) + 1
% Rice Rule: k = 2 * n ^(1/3)
xRange = (1*10^-6):(1*10^-6):(100*10^-6);






% Clean Data

cd(plateFolder);
oldFolder = cd('PlateClean');

% Change the plate name to whatever it is using
fid = fopen('picList.txt');
data = [];
plateMat = zeros(10,10,5);
while ~feof(fid)
    singlePic = fgetl(fid);
    dataSet = OKAY_blob_fn(singlePic,plateMat);
    data = [data dataSet];
end


% Assume the data is each areas of spheres and find the radius of each.
for ii = 1:numel(data)
    data(ii) = sqrt(data(ii))/pi;
end
% Linearly convert pixel lengths to measured length: 2.3 microns per pixel
dataClean = data * 2.3*(10^(-6));


cd(plateFolder);

%%

% Clean up data that is too small to be resolved by the microscope
dataClean = dataClean(dataClean > (4 * 10^-6));
dataDirty = dataDirty(dataDirty > (4 * 10^-6));
% Clean up data that is too big and will be seen as blury
dataClean = dataClean(dataClean < (18 * 10^-6));
dataDirty = dataDirty(dataDirty < (18 * 10^-6));

DATA.clean = dataClean;
DATA.dirty = dataDirty;


DATA.clean = DATA.clean;
DATA.dirty = DATA.dirty;

%%
% Draw a simple Histogram using bar: put data into its groups
figure('Name','Histogram');
%xlim([6,20]);
set(gcf, 'Position', get(0, 'ScreenSize'));
% For dynamic bin numbers, chose n bins and pass this number as the second
% argument into the hist function
% Sturges' Rule: k bins: k = log base 2(n) + 1
% Rice Rule: k = 2 * n ^(1/3)


bins =  (4:1:18) * 10^(-6);
% For pretty graphs that can be shaped to exemplify bell curves
%[t,N,X] = nhist(DATA,'numbers','samebins','maxbins','box','xlabel','radius size of particle in bin (meters)','ylabel','number of particles in bin');
[yClean,indC] = hist(dataClean, bins);   
[yDirty,indD] = hist(dataDirty, bins);

% turn the data into microns instead of meters
bins = bins * 10^ 6;

% Note: indC = indD = bins: shows at which bin each data point is
%br = bar(bins,[yClean;yDirty]');
br = bar(bins,yDirty);
grid on;
%legend('After EDS Activation','Before EDS Activation');
legend('Before EDS Activation');
title('Dust Radius Histogram');
xlabel('Radius Size of Particle in Bin (microns)');
ylabel('Number of Particles in Radius Bin');


% Plot the percent change in every bin
percentChange = (yClean - yDirty)./yDirty * 100;
figure('Name','Percent Change per Bin');
set(gcf, 'Position', get(0, 'ScreenSize'));
% xData = X.clean; %same as X.dirty %if we use the pretty nhist
%plot(bins,percentChange);
zed = zeros(numel(bins),1);
zr = plot(bins, zed,'k');
hold on;
grid on;
pr = plot(bins,percentChange);
title('Percent Change per Dust Radius Size After EDS');
xlabel('Radius Size of Particle in Bin (microns)');
ylabel('Percent Change per Radius Size');
ylim([-100,100]);




%%

% dataClean and dataDirty both refer to radius, sized in meters.  Convert
% to volume and multiply by mass density to back out a mass of the
% particle.
% Density of JSC-1A sand is 2.5g/cm^3 =  approximately.  This is for individual
% particles, so the density of each particle is higher than what is
% researchd for bulk compaction of JSC-1A (usually somewhere around 2g/cm^3
% [2.5g/cm^3] * [1kg/1000g] * [100cm/1m]^3 = 2500kg/m^3
dataCleanMass = ((4/3) * pi * dataClean.*dataClean.*dataClean) * 2500;
dataDirtyMass = ((4/3) * pi * dataDirty.*dataDirty.*dataDirty) * 2500;

%%
% Draw a simple Histogram using bar: put data into its groups
figure('Name','Histogram');
%xlim([(6*10^-6),1*10^-4]);
set(gcf, 'Position', get(0, 'ScreenSize'));
% For dynamic bin numbers, chose n bins and pass this number as the second
% argument into the hist function
% Sturges' Rule: k bins: k = log base 2(n) + 1
% Rice Rule: k = 2 * n ^(1/3)
bins = (1*10^-13):(5*10^-12):(6.1 * 10^-11);
% For pretty graphs that can be shaped to exemplify bell curves
%[t,N,X] = nhist(DATA,'numbers','samebins','maxbins','box','xlabel','radius size of particle in bin (meters)','ylabel','number of particles in bin');
[yMassClean,indMassC] = hist(dataCleanMass, bins);   
[yMassDirty,indMassD] = hist(dataDirtyMass, bins);
% Note: indMassC = indMassD = bins: shows at which bin each data point is
%bm = bar(bins,[yMassClean;yMassDirty]');
bm = bar(bins,yMassDirty);
grid on;
%legend('Before EDS activation','After EDS activation');
legend('Before EDS activation');
title('Dust Mass Histogram');
xlabel('Mass of Particle in Bin (kg)');
ylabel('Number of Particles in Bin');


% Plot the percent change in every bin
percentChangeMass = (yMassClean - yMassDirty)./yMassDirty * 100;
figure('Name','Mass Percent Change per Radius Bin');
set(gcf, 'Position', get(0, 'ScreenSize'));
% xData = X.clean; %same as X.dirty %if we use the pretty nhist
%plot(bins,percentChange);
zed = zeros(numel(bins),1);
zm = plot(bins,zed,'k');
hold on;
grid on;
pm = plot(bins,percentChangeMass);
title('Percent Mass Change per Dust Mass Bin After EDS');
xlabel('Mass of Particle in Bin (kg)');
ylabel('Percent Change per Mass Bin');
ylim([-100,100]);