start = 1;
stop = 100;

M = csvread('mmmomp_iprivate.csv');
elements = M(start:stop, 1).^2;
mmm_ijk = M(start:stop, 2); %ijk Baseline
mmm_kij = M(start:stop, 4); %kji Baseline

mmm_ijk_out = M(start:stop, 3);
mmm_kij_out = M(start:stop, 5);

M = csvread('mmmomp_mid.csv');
mmm_ijk_mid = M(start:stop, 3);
mmm_kij_mid = M(start:stop, 5);

M = csvread('mmmomp_inner.csv');
mmm_ijk_in = M(start:stop, 3);
mmm_kij_in = M(start:stop, 5);

figure
scatter(elements, mmm_ijk, 'r');
hold
scatter(elements, mmm_ijk_out, 'b');
scatter(elements, mmm_ijk_mid, 'c');
scatter(elements, mmm_ijk_in, 'g');
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('Elements in Array');
ylabel('Cycles to Execute');
title('Performance of ijk Matrix Multiply');
legend('Baseline', 'Outer loop Parellelized', 'Middle Loop Parellelized', 'Inner Loop Parellelized');

figure
scatter(elements, mmm_kij, 'r');
hold
scatter(elements, mmm_kij_out, 'b');
scatter(elements, mmm_kij_mid, 'c');
scatter(elements, mmm_kij_in, 'g');
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('Elements in Array');
ylabel('Cycles to Execute');
title('Performance of kij Matrix Multiply');
legend('Baseline', 'Outer loop Parellelized', 'Middle Loop Parellelized', 'Inner Loop Parellelized');

M = csvread('mmmomp_ishared.csv');
mmm_ijk_shared = M(start:stop, 3);
mmm_kij_shared = M(start:stop, 5);

figure
scatter(elements, mmm_ijk, 'r');
hold
scatter(elements, mmm_ijk_out, 'b');
scatter(elements, mmm_ijk_shared, 'c');
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('Elements in Array');
ylabel('Cycles to Execute');
title('Performance of ijk Matrix Multiply with Shared Indecies');
legend('Baseline', 'Indecies not Shared', 'Indecies Shared');

figure
scatter(elements, mmm_kij, 'r');
hold
scatter(elements, mmm_kij_out, 'b');
scatter(elements, mmm_kij_shared, 'c');
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('Elements in Array');
ylabel('Cycles to Execute');
title('Performance of kij Matrix Multiply with Shared Indecies');
legend('Baseline', 'Indecies not Shared', 'Indecies Shared');




