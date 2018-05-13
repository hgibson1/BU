function [samesize]=checksize(A,B)
%Accepts arrays A and B and determines if they are the same length
[rA cA]=size(A);
%calculates the size of array A
[rB cB]=size(B);
%calculates the size of array B
if rA~=rB
%returns if A and B don't have the same number of rows 
    samesize=0;
end
if cA~=cB
%returns false if A and B don't have the same number of columns 
    samesize=0;
else
%returns true if A and B have the same number of columns and rows
    samesize=1;
end
end

