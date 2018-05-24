files = dir('Om*00000.csv');
len = length(files);
colors = ['g', 'b', 'm', 'c', 'o', 'y', 'k', 'p'];
mins = zeros(1, len);

M = csvread(files(1).name);
omega = M(:, 1);
iterations = M(:, 2);
scatter(omega, iterations, 'r');
[val, index] = min(iterations);
mins(1) = omega(index);
hold
for i = 2:len
    M = csvread(files(i).name);
    iterations = M(:, 2);
    [val, index] = min(iterations);
    mins(i) = omega(index);
    scatter(omega, iterations, colors(i - 1));
end
xlabel('Omega Value');
ylabel('Iterations');
set(gca, 'yscale', 'log');
title('Omega Value vs Array Size');
legend('10000000 Elements', '200000 Elements', '500000 Elements', '700000 Elements');

figure
arraysizes = [10000000, 200000, 500000, 700000];
scatter(arraysizes, mins, 'r');
xlabel('Array Size');
set(gca, 'xscale', 'log');
ylabel('Optimal Omega Value');
title('Optimal Omega as a Function of Array Size');
