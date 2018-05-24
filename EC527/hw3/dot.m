M = csvread('test_dot_newi.csv');

start = 100;
elements = M(start:end, 1);
d4 = M(start:end,2)./elements;
d4(abs(d4-mean(d4)) > std(d4)*3) = mean(d4);
d5 = M(start:end,3)./elements;
d5(abs(d5-mean(d5)) > std(d5)*3) = mean(d5);
d6_2 = M(start:end,4)./elements;
d6_2(abs(d6_2-mean(d6_2)) > std(d6_2)*3) = mean(d6_2);
d6_5 = M(start:end,5)./elements;
d6_5(abs(d6_5-mean(d6_5)) > std(d6_5)*3) = mean(d6_5);
d8 = M(start:end,6)./elements;
d8(abs(d8-mean(d8)) > std(d8)*3) = mean(d8);
d8_2 = M(start:end,7)./elements;
d8_2(abs(d8_2-mean(d8_2)) > std(d8_2)*3) = mean(d8_2);
d8_4 = M(start:end,8)./elements;
d8_4(abs(d8_4-mean(d8_4)) > std(d8_4)*3) = mean(d8_4);
doti = M(start:end,9)./elements;
doti(abs(doti-mean(doti)) > std(doti)*3) = mean(doti);

figure
scatter(elements, d4, 'r');
hold
scatter(elements, d5, 'g');
scatter(elements, d6_2, 'b');
scatter(elements, d6_5, 'y');
scatter(elements, d8, 'm');
scatter(elements, d8_2, 'c');
scatter(elements, d8_4, 'k');
xlabel('Elements in Vector');
ylabel('Cycles Per Element');
title('Dot Product Performance');
legend('d4', 'd5', 'd6_2', 'd6_5', 'd8', 'd8_2', 'd8_4');

figure
scatter(elements, d4, 'r');
hold
scatter(elements, d8, 'g');
scatter(elements, doti, 'b');
scatter(elements, d8_4, 'y');
xlabel('Elements in Vector');
ylabel('Cycles Per Element');
title('Dot Product with Intrinsics Performance');
legend('d4', 'd8', 'doti', 'd8_4');