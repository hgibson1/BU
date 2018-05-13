T = 't';
D = 't^2/4';
ezplot(T,D,[-30,30])
hold on 

T = 't';
D = '0';
ezplot(T,D,[-30,30])
hold on

T = '0';
D = 't';
ezplot(T,D,[-30,30])
hold on

xlabel('T')
ylabel('D')
axis([-30 30 -30 30])
title('Trace-Determinant plane')
legend('D = T^2/4')