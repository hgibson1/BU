function [table]=compareTable(A,B,C)
%compares a logic table  to the six existing logic functions. 
%takes three column vectors A, B, and C and outputs the name of the logic function that matches the input. If no match is found,
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
    table=[];
elseif checksize(B,C)==0
%returns an empty vector if B and C are not the same size
    table=[];
else
%determines the function and displays 'UNKNOWN' if the function does not match any of the logical functions
        if all(C==myAND(A,B))
            table='AND';
        elseif all(C==myOR(A,B))
            table='OR';
        elseif all(C==myXOR(A,B))
            table='XOR';
        elseif all(C==myNAND(A,B))
            table='NAND';
        elseif all(C==myNOR(A,B))
            table='NOR';
        elseif all(C==myNXOR(A,B))
            table='NXOR';
        else
            table=upper('unknown');
end
end

