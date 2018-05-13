function [C] = myNAND(A,B)
%Logical fuction, accepts arrays A and B and returns array C
%Returns logical true when either A or B is equal to zero and logical false when A and B are both equal to one
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
   C=[];
else
%returns C=NAND(A,B) if A and B are the same size
     C=~(A.*B);
end
end

