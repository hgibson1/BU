%EK301 A1
%Eric Loehle U48711702
%Brad Miller U90274486
%Hannah Gibson U46409674

connectmat = load('connectmat.dat');
[r,c] = size(connectmat);
Sx = zeros(r,3);
Sy = Sx;
Sx(1,1) = 1;
Sy(1,2) = 1;
xvec = load('xvec.dat');
yvec = load('yvec.dat');
L = zeros(1,2*r);

val = 2;                %SET BY HAND- joint where force is applied 
A = zeros(2*r,c+3);
accuracy = .5;
[A,lengthvec] = build_A_matrix(A,r,c,connectmat,xvec,yvec);
applied_load = member_check(A,L,r,lengthvec,val,accuracy);
accuracy = .01;
applied_load = member_check(A,L,r,lengthvec,val,accuracy,applied_load);
