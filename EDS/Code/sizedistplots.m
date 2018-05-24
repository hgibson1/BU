bins =  (4:1:18) * 10^(-6);
% turn the data into microns instead of meters

%Plots particle size distribution before EDS
figure;
bar(bins,histdust);
grid on;
title('Partcle size distribution before EDS activation');
xlabel('Radius Size of Particle in Bin (microns)');
ylabel('Number of Particles in Radius Bin');

%Plots particle size distribution after EDS
figure;
bar(bins,histcleaned);
grid on;
title('Partcle size distribution after EDS activation');
xlabel('Radius Size of Particle in Bin (microns)');
ylabel('Number of Particles in Radius Bin');

% Plot the percent change in every bin
% percentChange = (histcleaned - histdust)./histdust * 100;
% figure;
% grid on;
% plot(bins,percentChange);
% title('Percent Change per Dust Radius Size After EDS');
% xlabel('Radius Size of Particle in Bin (microns)');
% ylabel('Percent Change per Radius Size');
% ylim([-100,100]);
