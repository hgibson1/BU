M = csvread('transpose1.csv');
N = csvread('transpose2.csv');
P = csvread('transpose3.csv');
start = 100;
stand = 2;
elements = M(start:end, 1).^2;
tone = M(start:end, 2)./elements;
%tone(abs(tone-mean(tone)) > std(tone)*stand) = mean(tone);
toptone = M(start:end, 3)./elements;
%toptone(abs(toptone-mean(toptone)) > std(toptone)*stand) = mean(toptone);
ttwo = N(start:end, 2)./elements;
%ttwo(abs(ttwo-mean(ttwo)) > std(ttwo)*stand) = mean(ttwo);
topttwo = N(start:end, 3)./elements;
%topttwo(abs(topttwo-mean(topttwo)) > std(topttwo)*stand) = mean(topttwo);
tthree = P(start:end, 2)./elements;
%tthree(abs(tthree-mean(tthree)) > std(tthree)*stand) = mean(tthree);
toptthree = P(start:end, 3)./elements;
%toptthree(abs(toptthree-mean(toptthree)) > std(toptthree)*stand) = mean(toptthree);

figure
scatter(elements, toptone, 'r');
hold
scatter(elements, topttwo, 'g');
scatter(elements, toptthree, 'b');
xlabel('Elements in Array');
%set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
title('Transpose with Intrinsics at Different Optimizations');
legend('Level 1 Opt', 'Level 2 Opt', 'Level 3 Opt');

figure
scatter(elements, ttwo, 'r');
hold 
scatter(elements, topttwo, 'g');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Performance of Transpose at Optimization 2');
legend('No Blocking or Intrinsics', 'Blocking and Intrinsics');

