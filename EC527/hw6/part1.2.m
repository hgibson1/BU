R = csvread('simple4thread.csv');
S = csvread('complex4thread.csv');
start = 2;
stop = 4000;
elements = R(start:stop, 1).^2;
simple_serial = R(start:stop, 2)./elements;
simple_2thread = R(start:stop, 3)./elements;
simple_4thread = R(start:stop, 4)./elements;
complex_serial = S(start:stop, 2)./elements;
complex_2thread = S(start:stop, 3)./elements;
complex_4thread = S(start:stop, 4)./elements;

figure
scatter(elements, simple_serial, 'r');
hold
scatter(elements, simple_2thread, 'b');
scatter(elements, simple_4thread, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles to Per Element Execute');
set(gca, 'yscale', 'log');
title('Thread Performance for Simple Computation');
legend('Serial', '2 Threads', '4 Threads');

figure
scatter(elements, complex_serial, 'r');
hold
scatter(elements, complex_2thread, 'b');
scatter(elements, complex_4thread, 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles to Per Element Execute');
set(gca, 'yscale', 'log');
title('Thread Performance for Complex Computation');
legend('Serial', '2 Threads', '4 Threads');

simple_speedup2 = simple_2thread./simple_serial;
simple_speedup4 = simple_4thread./simple_serial;
complex_speedup2 = complex_serial./complex_2thread;
complex_speedup4 = complex_serial./complex_4thread;

simple_fraction2 = 0.67*(1 - simple_speedup2.^(-1));
simple_fraction4 = 0.8*(1 - simple_speedup4.^(-1));
complex_fraction2 = 0.67*(1 - complex_speedup2.^(-1));
complex_fraction4 = 0.8*(1 - complex_speedup4.^(-1));

simple_cycles2 = (1 - simple_fraction2).*simple_2thread.*elements - simple_serial.*elements;
simple_cycles4 = (1 - simple_fraction4).*simple_4thread.*elements - simple_serial.*elements;
complex_cycles2 = (1 - complex_fraction2).*complex_2thread.*elements - simple_serial.*elements;
complex_cycles4 = (1 - complex_fraction4).*complex_4thread.*elements - simple_serial.*elements;

figure
scatter(elements(1:100), simple_cycles2(1:100), 'b');
hold
scatter(elements(1:100), simple_cycles4(1:100), 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('CPU Cycles');
set(gca, 'yscale', 'log');
legend('2 Threads', '4 Threads');
title('Thread Overhead (Simple Computation)');

figure
scatter(elements(1:10), complex_cycles2(1:10), 'b');
hold
scatter(elements(1:10), complex_cycles4(1:10), 'c');
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('CPU Cycles');
set(gca, 'yscale', 'log');
legend('2 Threads', '4 Threads');
title('Thread Overhead for Complex Computation');

















