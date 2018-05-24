M = csvread('dot.csv');

elements = M(50:end, 1);
dot = M(50:end, 2)./elements;
dot(abs(dot - mean(dot)) > std(dot)*3)=mean(dot); 
dot_opt = M(50:end, 3)./elements;
dot_opt(abs(dot_opt - mean(dot_opt)) > std(dot_opt)*3)=mean(dot_opt); 

scatter(elements, dot, 'r');
hold
scatter(elements, dot_opt, 'g');
xlabel('Elements')
ylabel('Cycles Per Element')
title('Dot Product Optimization')
legend('dot', 'dot_opt')