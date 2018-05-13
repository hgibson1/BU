function [table]=printTable(A,B,C,function_name)
%Recieves arrays A and B and array C which is the result of a logical function of A and B along with the string name of that function
if checksize(A,B)==0
%returns an empty vector if A and B are not the same size
    table=[];
elseif checksize(B,C)==0
%returns an empty vector if B and C are not the same size
    table=[];
else
    [rC cC]=size(C);
    prealtable=zeros(cC,3);
%preallocates a matix with a columns for A B and C and rows equal to the number of columns in vectors A B and C
    prealtable(:,1)=A;
%assigns A to column 1 of the preallocated table
    prealtable(:,2)=B;
%assigns B to column 2 of the preallocated table
    prealtable(:,3)=C;
%assigns C to column 3 of the preallocated table
    fprintf('Function: %s\n',function_name)
%displays the header line
    disp('     A     B     C')
%displays the column headers
    table=prealtable;
end
end
