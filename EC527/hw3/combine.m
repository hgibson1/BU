M = csvread('test_combine_new.csv');

start = 100;
elements = M(start:end, 1);
com4 = M(start:end, 2)./elements;
com4(abs(com4 - mean(com4)) > std(com4)*2.5)=mean(com4); 
com6_5 = M(start:end, 3)./elements;
com6_5(abs(com6_5 - mean(com6_5)) > std(com6_5)*2.5)=mean(com6_5); 
com8 = M(start:end, 4)./elements;
com8(abs(com8 - mean(com8)) > std(com8)*2.5)=mean(com8); 
com8_2 = M(start:end, 5)./elements;
com8_2(abs(com8_2 - mean(com8_2)) > std(com8_2)*2.5)=mean(com8_2); 
com8_4 = M(start:end, 6)./elements;
com8_4(abs(com8_4 - mean(com8_4)) > std(com8_4)*2.5)=mean(com8_4); 
com8_8 = M(start:end, 7)./elements;
com8_8(abs(com4 - mean(com4)) > std(com4)*2.5)=mean(com4); 

figure
scatter(elements, com4, 'r');
hold
scatter(elements, com6_5, 'g');
scatter(elements, com8, 'b');
scatter(elements, com8_2, 'y');
scatter(elements, com8_4, 'm');
scatter(elements, com8_8, 'c');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Combine Performance');
legend('com4', 'com6_5', 'com8', 'com8_2', 'com8_4', 'com8_8');
