function [C]=myNOR(A,B)
%Logical function, accepts arrays A and B and returns array C
%Returns Logical true when A and B both equal 0, and logical false when either A or B is equal to one.
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
   C=[];
else
%returns C=NOR(A,B) if A and B are the same size
     C=~(A+B);
end
end



