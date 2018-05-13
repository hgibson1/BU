function [C]=myAND(A,B)
%Performs logical opperations on arrays A and B and returns array C of 1 (logical true) or 0 (logical false). 
%The function returns true if both A and B are set to true, otherwise it returns false.
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
    C=[];
else
%returns C=AND(A,B) if A and B are the same size
     C=A.*B;
end
end

