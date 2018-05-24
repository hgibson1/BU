N = csvread('test_intrinsics.csv');
start = 100;
elements = N(start:end, 1);
atest1 = N(start:end, 2)./elements;
atest2 = N(start:end, 3)./elements;

figure
scatter(elements, atest1, 'r');
hold
scatter(elements, atest2, 'g');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Intrinsics Test Performance');
legend('ArrayTest1', 'ArrayTest2');

M = csvread('test_intrinsics_new.csv');
elements = M(start:end, 1);
add = M(start:end, 2)./elements;
add(abs(add-mean(add)) > std(add)*2) = mean(add);
addi = M(start:end, 3)./elements;
addi(abs(addi-mean(addi)) > std(addi)*2) = mean(addi);
mul = M(start:end, 4)./elements;
mul(abs(mul-mean(mul)) > std(mul)*2) = mean(mul);
muli = M(start:end, 5)./elements;
muli(abs(muli-mean(muli)) > std(muli)*2) = mean(muli);

figure
scatter(elements, add, 'r');
hold
scatter(elements, addi, 'g');
scatter(elements, mul, 'b');
scatter(elements, muli, 'y');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Intrinsic Function Performance');
legend('add', 'add_intr', 'mul', 'mul_intr');

