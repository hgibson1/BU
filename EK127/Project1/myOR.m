function [C] = myOR(A,B)
%Logical function that accepts arrays A and B and returns array C. 
%Returns logical true (1) if either A or B is true, logical true if both are true, and logical false (0) if both are false.
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
   C=[];
else
%returns C=or(A,B)
   C=A+B;
end
end

