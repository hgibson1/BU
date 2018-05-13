A=[0 0 1 1]; 
B=[0 1 0 1]; 

choice_select=menu('Chose an Opperation','Exit the Program','Calculate the table of a logic function','Calculate a logic function from a file');
%allows the user the choice of exiting the program, calculating the table for a logic function or calculating a logic function from a file

if choice_select==1
%terminates the script
    disp('Program Terminating')
    exit

elseif choice_select==2
%calculates tables of a logic function 
    choice_function=menu('Chose a logic function','AND','OR','XOR','NAND','NOR','NXOR');
    %allows the user the choices of logic function
    if choice_function==1
    %returns C=and(A,B)
        C=myAND(A,B);
        function_name= 'AND';
    elseif choice_function==2
    %returns C=or(A,B)
        C=myOR(A,B);
        function_name= 'OR';
    elseif choice_function==3
    %returns C=xor(A,B)
        C=myXOR(A,B);
        function_name= 'XOR';
    elseif choice_function==4
    %returns C=nand(A,B)
        C=myNAND(A,B);
        function_name= 'NAND';
    elseif choice_function==5
    %returns C=nor(A,B)
        C=myNOR(A,B);
        function_name= 'NOR';
    elseif choice_function==6
    %returns C=nxor(A,B)
        C=myNXOR(A,B);
        function_name= 'NXOR';
    else
        disp('Error')
        exit
    end
    %calculates the value of C based on A and B using the function the user selected
    printTable(A,B,C,function_name)
    %prints the truth table to the command window
    choice_yesno=menu('Would you like to write the results of this table to a file?','Yes','No');
    %gives the usler the option of saving the table to a file
    if choice_yesno==1
        saveTable(A,B,C,function_name)
    else
    %saves the truth table to file if the user selects yes 
        disp('Program Terminating')
        exit
    end
    
elseif choice_select==3
%calculates a logic function from a file
    file=input('What file would you like to evaluate? ');
    try
       data = load(file);
    catch myerror
        fprintf('The file does not exist!\n')
    end
 %Loads the file if it exists and exits the program if it doesn't  
    A=data(:,1);
    B=data(:,2);
    C=data(:,3);
 %Assigns the columns in the file to A B and C
    if checksize(A,B)==0
 %displays an error message if A B and C are not the same size
        disp('Error')
    elseif checksize(B,C)==0
        disp('Error')
    else
 %Determines the logical function and displays it to the command window
    fnc = compareTable(A,B,C);
    fprintf('%s\n',fnc);
    end

else
%terminates the program if there is an error
    disp('Error')
    disp('Program Terminating')
    exit
end
    
