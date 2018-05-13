function [C] = myNXOR(A,B)
%Logical fuction. Accepts arrays A and B and returns array C
%Returns logical true if A and B are both equal to one or both equal to zero. Returns logical false if either A or B is equal to zero.
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
   C=[];
else
%returns C=NXOR(A,B) if A and B are the same size
     C=~(A.*~B+B.*~A);
end
end
