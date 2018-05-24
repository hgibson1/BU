M = csvread('branch.csv');
elements = M(50:end,1);
ordered_if = M(50:end,2)./elements;
ordered_if(abs(ordered_if - mean(ordered_if)) > std(ordered_if)*4)=mean(ordered_if); 
random_if = M(50:end,3)./elements;
random_if(abs(random_if - mean(random_if)) > std(random_if)*4)=mean(random_if); 
ordered_cm = M(50:end,4)./elements;
ordered_cm(abs(ordered_cm - mean(ordered_cm)) > std(ordered_cm)*4)=mean(ordered_cm); 
random_cm = M(50:end,5)./elements;
random_cm((abs(random_cm) - mean(random_cm)) > std(random_cm)*4)=mean(random_cm); 



figure
scatter(elements, ordered_if, 'r');
hold
scatter(elements, random_if, 'g');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('If-Statement Performance');
legend('Ordered Data','Random Data');

figure
scatter(elements, ordered_cm, 'r');
hold
scatter(elements, random_cm, 'g');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Conditional Move Performance')
legend('Ordered Data','Random Data');

figure
scatter(elements, ordered_if, 'm');
hold
scatter(elements, ordered_cm, 'b');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Performance with Ordered Data');
legend('If-Statement','Conditional Move');

figure
scatter(elements, random_if, 'm');
hold
scatter(elements, random_cm, 'b');
%valif = fit(elements, random_if, 'exp1');
%valcm = fit(elements, random_cm, 'exp1');
%plot(valif, 'm');
%plot(valcm, 'b');
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Performance with Random Data');
legend('If-Statement','Conditional Move');


