%plot for DiffEQ lab
syms a b
ezplot(6*a-4*b == (a+6)^2/4, [-30 30]) 
h = ezplot(6*a-4*b == (a+6)^2/4, [-30 30]);
set(h,'color','r')
hold on

syms a b
ezplot(6*a == 4*b, [-30 30])
i = ezplot(6*a == 4*b, [-30 30]);
set(i,'color','g')
hold on

a = '-6';
b = 't';
ezplot(a, b, [-30 30])
j = ezplot(a, b, [-30 30]);
set(j,'color','b')
hold on

a = '0';
b = 't'
ezplot(a, b, [-30 30])
k = ezplot(a, b, [-30 30]);
set(k,'color','k')
hold on

a = 't';
b = '0';
ezplot(a, b, [-30 30])
l = ezplot(a, b, [-30 30]);
set(l,'color','k')
hold on

legend('6*a-4*b = (a+6)^2/4','6*a = 4*b','a = -6')
xlabel('a')
ylabel('b')
axis([-30 30 -30 30])
title('a b plane')