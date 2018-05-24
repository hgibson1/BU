files = dir('tblock*.csv');
len = length(files);
blocks = [10, 100, 1000];


for i = 1:len
M = csvread(files(i).name);
elements = M(:,1).^2;

figure
scatter(elements, M(:,2), 'r');
hold
scatter(elements, M(:,3), 'g');
xlabel('Elements in Matrix');
set(gca, 'xscale', 'log');
ylabel('Cycles');
set(gca, 'yscale', 'log');
legend('transpose_rev', 'transpose');
title(sprintf('Cycles to Execute, blocksize=%d', blocks(i)));

figure
scatter(elements, M(:,2)./elements, 'r');
hold
scatter(elements, M(:,3)./elements, 'g');
xlabel('Elements in Matrix');
set(gca, 'xscale', 'log');
ylabel('Cycles per Element');
set(gca, 'yscale', 'log');
legend(['transpose_rev', 'transpose']);
title(sprintf('Cycles per Element to Execute, blocksize=%d', blocks(i)));
end






