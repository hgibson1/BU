start = 1;
stop = 4000;
M = csvread('ompfor.csv');
elements = M(start:stop, 1).^2;
omp_cb_bl = M(start:stop, 2); %CPU bound baseline
omp_cb = M(start:stop, 3); %CPU bound openmp
omp_mb_bl = M(start:stop, 4); %Memory bound baseline
omp_mb = M(start:stop, 5); %Memory bound openmp
omp_ob_bl = M(start:stop, 6); %Overhead bound baseline
omp_ob = M(start:stop, 7); %Overhead bound openmp
%{
figure
scatter(elements, omp_cb_bl, 'r');
hold
scatter(elements, omp_cb, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles to Execute');
set(gca, 'yscale', 'log');
title('Compute Bound Function');
legend('Baseline', 'OpenMP');

figure
scatter(elements, omp_mb_bl, 'r');
hold
scatter(elements, omp_mb, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles to Execute');
set(gca, 'yscale', 'log');
title('Memory Bound Function');
legend('Baseline', 'OpenMP');

figure
scatter(elements, omp_ob_bl, 'r');
hold
scatter(elements, omp_ob, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles to Execute');
set(gca, 'yscale', 'log');
title('Overhead Bound Function');
legend('Baseline', 'OpenMP');
%}

%Number of threads = 4 = s
cb_speedup = omp_cb_bl./omp_cb;
mb_speedup = omp_mb_bl./omp_mb;
ob_speedup = omp_ob_bl./omp_ob;

cb_frac = 0.8*(1 - cb_speedup.^(-1));
mb_frac = 0.8*(1 - mb_speedup.^(-1));
ob_frac = 0.8*(1 - ob_speedup.^(-1));

cb_overhead = (1 - cb_frac).*omp_cb;
mb_overhead = (1 - mb_frac).*omp_mb;
ob_overhead = (1 - ob_frac).*omp_ob;

figure
scatter(elements(25:32), cb_overhead(25:32) - omp_cb_bl(25:32), 'r');
lsline
%set(gca, 'yscale', 'log');
%set(gca, 'xscale', 'log');
xlabel('Elements in Array');
ylabel('Cycles to Execute');
title('OpenMP Thread Overhead');

%figure
%scatter(elements(25:32), mb_overhead(25:32) - omp_mb_bl(25:32), 'r');
%set(gca, 'yscale', 'log');
%set(gca, 'xscale', 'log');
%xlabel('Elements in Array');
%ylabel('Cycles');
%title('OpenMP thread Overhead');


%figure
%scatter(elements(25:32), ob_overhead(25:32) - omp_ob_bl(25:32), 'r');
%lsline
%set(gca, 'yscale', 'log');
%set(gca, 'xscale', 'log');



