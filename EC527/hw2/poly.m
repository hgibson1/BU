M = csvread('eval.csv');

elements = M(50:end,1);
eval = M(50:end, 2)./elements;
eval(abs(eval - mean(eval)) > std(eval)*3)=mean(eval); 
opt = M(50:end, 3)./elements;
opt(abs(opt - mean(opt)) > std(opt)*3)=mean(opt); 

scatter(elements, eval, 'r');
hold
scatter(elements, opt, 'g'); 
xlabel('Elements in Array');
ylabel('Cycles Per Element');
title('Performance of Polynomial Functions');
legend('poly','poly-opt');