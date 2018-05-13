%Models the conversion of RNA sequences into Amino Acids in the influenza virus

fid1=fopen('aminotable.dat','r'); %Opens Table displaying conversion of nucliotides to amino acids
if fid1==-1 %Checks if file open was sucessful
    disp('File Open Not Successful')
end
while feof(fid1)==0
    aminotable=textscan(fid1,'#%c#%c#%c-%c'); %Reads conversion data from the file and stores it in cell array 'data'
end
for i=1:length(aminotable{1}) %creates a structure of structures that stores amino acid under feildnames that are amino acids
    rna2amino.(aminotable{1}(i)).(aminotable{2}(i)).(aminotable{3}(i))=(aminotable{4}(i));
end
closeresult=fclose(fid1); %Closes file
if closeresult==0 %Checks that file close was successful
    disp('File Close Successful')
else
    disp('File Close Not Successful')
end

answer=input('Would you like to compare Influenza files? ','s');
while isequal(answer,'y')==1 
year=input('What year would you like Influenza data from? '); %Returns the year of second file to load/compare
year=num2str(year);
filename2=strcat('Influenza',year,'.dat');
fid2=fopen(filename2,'r'); %Opens file with name that has year of data collection
if fid2==-1 %Checks if file open was sucessful
    disp('File Open Not Successful')
end
fludata=textscan(fid2,'%s'); %reads file
code=fludata{1}{3}; %obtains virus Accession code
subtype=fludata{1}{5}; %obtains virus subtype
date=struct('Day',fludata{1}{10}(1:2),'Month',fludata{1}{10}(4:5),'Year',fludata{1}{7}); %creates aquisition date structure
location=strcat(fludata{1}{12},fludata{1}{13}); %obtains aquitistion location
region=fludata{1}{15}; %obtains aquisition region 
VirusInfo(2)=struct('Accession_code',code,'Subtype',subtype,'Aquisition_date',date,'Location',location,'Region',region); %creates virus info structure
cRNA2=fludata{1}{18}; %Gets cRNA string
cRNA2=upper(cRNA2);
RNA2=Transcription(cRNA2);%Transcribes cRNA into RNA
Amino2=Translation(RNA2,rna2amino);%Translates RNA into an amino acid chain
closeresult=fclose(fid2); %Closes file
if closeresult==0 %Checks that file close was successful
    disp('File Close Successful')
else
    disp('File Close Not Successful')
end

year=input('What year would you like Influenza data from? '); %Returns the year of first file to load/compare
year=num2str(year);
filename1=strcat('Influenza',year,'.dat');
fid2=fopen(filename1,'r'); %Opens file with name that has year of data collection
if fid2==-1 %Checks if file open was sucessful
    disp('File Open Not Successful')
end
fludata=textscan(fid2,'%s'); %reads file
code=fludata{1}{3}; %obtains virus Accession code
subtype=fludata{1}{5}; %obtains virus subtype
date=struct('Day',fludata{1}{10}(1:2),'Month',fludata{1}{10}(4:5),'Year',fludata{1}{7}); %creates aquisition date structure
location=strcat(fludata{1}{12},fludata{1}{13}); %obtains aquitistion location
region=fludata{1}{15}; %obtains aquisition region 
VirusInfo(1)=struct('Accession_code',code,'Subtype',subtype,'Aquisition_date',date,'Location',location,'Region',region); %creates virus info structure
cRNA1=fludata{1}{18}; %Gets cRNA string
cRNA1=upper(cRNA1);
RNA1=Transcription(cRNA1);%Transcribes cRNA into RNA
Amino1=Translation(RNA1,rna2amino);%Translates RNA into an amino acid chain
closeresult=fclose(fid2); %Closes file
if closeresult==0 %Checks that file close was successful
    disp('File Close Successful')
else
    disp('File Close Not Successful')
end

[mutRNA,mutAmino,RNAmat,Aminomat,percentcomp]=viralcomparison(RNA1,RNA2,Amino1,Amino2); %Compares two virus strains

filename3=strcat(filename1(1:13),'_',filename2);%Creates name for comparasion file
fid3=fopen(filename3,'a'); %creates comparason file to append to
if fid3==-1 %Checks if file open was sucessful
    disp('File Open Not Successful')
end
fprintf(fid3,'Virus 1 Accession Code: %s\n',VirusInfo(1).Accession_code);%Writes Virus 1 code to file
fprintf(fid3,'Virus 2 Accession Code: %s\n',VirusInfo(2).Accession_code);%Writes Virus 2 code to file
fprintf(fid3,'                           \n'); %leaves a blank line
fprintf(fid3,'Location: %s & %s\n',VirusInfo(1).Location,VirusInfo(2).Location); %Writes the locations of Virus 1 and 2 to file
fprintf(fid3,'Region: %c & %c\n',VirusInfo(1).Region,VirusInfo(2).Region); %Writes regions of virus 1 and 2 to file
fprintf(fid3,'                           \n');%leaves a blank line
fprintf(fid3,'RNA Percent Difference: %.2f\n',percentcomp(1)); 
fprintf(fid3,'Amino Acid Percent Difference: %.2f\n',percentcomp(2)); %Writes percent differences in virus RNA and amino acid sequence to file
fprintf(fid3,'                           \n');%leaves a blank line
fprintf(fid3,'RNA Mutation Locations:\n'); %Label for RNA mutation locations
for i=1:length(mutRNA)/10 %Writes locations of mutations to file with 10 locations per row
    fprintf(fid3,'%d %d %d %d %d %d %d %d %d %d\n',mutRNA(i),mutRNA(i+1),mutRNA(i+2),mutRNA(i+3),mutRNA(i+4),mutRNA(i+5),mutRNA(i+6),mutRNA(i+7),mutRNA(i+8),mutRNA(i+9));
end   
fprintf(fid3,'                           \n');%leaves a blank line
fprintf(fid3,'Amino Acid Mutation Locations:\n');%Label for Amino Acid mutation locations
for i=1:length(mutRNA)/10 %Writes locations of amino acids to file with 10 locations per row
    fprintf(fid3,'%d %d %d %d %d %d %d %d %d %d\n',mutAmino(i),mutAmino(i+1),mutAmino(i+2),mutAmino(i+3),mutAmino(i+4),mutAmino(i+5),mutAmino(i+6),mutAmino(i+7),mutAmino(i+8),mutAmino(i+9));
end   
fprintf(fid3,'                           \n');%leaves a blank line 
fprintf(fid3,'RNA Mutations\n'); %Label for RNA mutations
for i=1:length(RNAmat)/20 %Writes mutations in RNA seqence, with 20 mutations per row. The first row is virus 1 and the second row is virus 2.
    fprintf(fid3,'%c%c%c%c%c%c%c%c%c%c %c%c%c%c%c%c%c%c%c%c\n',RNAmat(1,i),RNAmat(1,i+1),RNAmat(1,i+2),RNAmat(1,i+3),RNAmat(1,i+4),RNAmat(1,i+5),RNAmat(1,i+6),RNAmat(1,i+7),RNAmat(1,i+8),RNAmat(1,i+9),RNAmat(1,i+10),RNAmat(1,i+11),RNAmat(1,i+12),RNAmat(1,i+13),RNAmat(1,i+14),RNAmat(1,i+15),RNAmat(1,i+16),RNAmat(1,i+17),RNAmat(1,i+18),RNAmat(1,i+19));
    fprintf(fid3,'%c%c%c%c%c%c%c%c%c%c %c%c%c%c%c%c%c%c%c%c\n',RNAmat(2,i),RNAmat(2,i+1),RNAmat(2,i+2),RNAmat(2,i+3),RNAmat(2,i+4),RNAmat(2,i+5),RNAmat(2,i+6),RNAmat(2,i+7),RNAmat(2,i+8),RNAmat(2,i+9),RNAmat(2,i+10),RNAmat(2,i+11),RNAmat(2,i+12),RNAmat(2,i+13),RNAmat(2,i+14),RNAmat(2,i+15),RNAmat(2,i+16),RNAmat(2,i+17),RNAmat(2,i+18),RNAmat(2,i+19));
    fprintf(fid3,'                                         \n');
end
fprintf(fid3,'                           \n'); %Leaves blank space
fprintf(fid3,'Amino Acid Mutations\n'); %Label for Amino Acid sequence locations
for i=1:length(Aminomat)/20 %Writes mutations in Amino Acid seqence, with 20 mutations per row. The first row is virus 1 and the second row is virus 2.
    fprintf(fid3,'%c%c%c%c%c%c%c%c%c%c %c%c%c%c%c%c%c%c%c%c\n',Aminomat(1,i),Aminomat(1,i+1),Aminomat(1,i+2),Aminomat(1,i+3),Aminomat(1,i+4),Aminomat(1,i+5),Aminomat(1,i+6),Aminomat(1,i+7),Aminomat(1,i+8),Aminomat(1,i+9),Aminomat(1,i+10),Aminomat(1,i+11),Aminomat(1,i+12),Aminomat(1,i+13),Aminomat(1,i+14),Aminomat(1,i+15),Aminomat(1,i+16),Aminomat(1,i+17),Aminomat(1,i+18),Aminomat(1,i+19));
    fprintf(fid3,'%c%c%c%c%c%c%c%c%c%c %c%c%c%c%c%c%c%c%c%c\n',Aminomat(2,i),Aminomat(2,i+1),Aminomat(2,i+2),Aminomat(2,i+3),Aminomat(2,i+4),Aminomat(2,i+5),Aminomat(2,i+6),Aminomat(2,i+7),Aminomat(2,i+8),Aminomat(2,i+9),Aminomat(2,i+10),Aminomat(2,i+11),Aminomat(2,i+12),Aminomat(2,i+13),Aminomat(2,i+14),Aminomat(2,i+15),Aminomat(2,i+16),Aminomat(2,i+17),Aminomat(2,i+18),Aminomat(2,i+19));
    fprintf(fid3,'                                         \n');
end
closeresult=fclose(fid3); %Closes file
if closeresult==0 %Checks that file close was successful
    disp('File Close Successful')
else
    disp('File Close Not Successful')
end
answer=input('Would you like to compare another set of Influenza files? ','s'); %Promps user for another comparison
end