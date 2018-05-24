M = csvread('float.csv');

elements = M(:,1);

scatter(elements, M(:,2), 'r');
hold
scatter(elements, M(:,3)./elements, 'g');
scatter(elements, M(:,4)./elements, 'b');
scatter(elements, M(:,5)./elements, 'm');
scatter(elements, M(:,6)./elements, 'y');
scatter(elements, M(:,7)./elements, 'k');
scatter(elements, M(:,8)./elements, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
title('CPE of combine functions');
set(gca, 'yscale', 'log');
legend('combine1', 'combine2', 'combine3', 'combine4', 'combine5', 'combine6', 'combine7');
