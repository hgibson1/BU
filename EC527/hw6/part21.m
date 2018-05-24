M = csvread('sor.csv');
start = 1;
stop = 125;
elements = M(start:stop, 1).^2;

mmm_b = M(start:stop, 2)./elements;
mmm_b(abs(median(mmm_b) - mmm_b) > std(mmm_b)) = median(mmm_b);
mmm_omp = M(start:stop, 4)./elements;
mmm_omp(abs(median(mmm_omp) - mmm_omp) > std(mmm_omp)) = median(mmm_omp);

scatter(elements, mmm_b, 'r');
hold
scatter(elements, mmm_omp, 'c');
set(gca, 'xscale', 'log');
set(gca, 'yscale' ,'log');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Performance of OMP SOR');
legend('Serial', 'Threaded');


