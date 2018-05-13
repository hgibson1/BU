function [table]=saveTable(A,B,C,function_name)
%saves the desired logic table to a .dat file.
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
end   
s=date;
%saves the current date as s
if ispc()
%returns the username as a string
    [~,username]=system('echo %username%'); %on windows
else
    [~,username]=system('echo $USER'); %on MAC
end
username=username(1:end-1);
%gets rid of newline character
file_name=strcat(function_name,'_',username,'_',s,'.dat');
%saves the file name as the name of the function, the username, and the date
save(file_name,'prealtable','-ascii')
%saves the truth table to a .dat file
end

