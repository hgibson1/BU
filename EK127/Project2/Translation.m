function [Protien] = Translation(RNA,datastruct)
%Translates an RNA sequence into an amino acid chain
%Recives an RNA strand and the ma2amino data structure as input and outputs
%a protien chain

Protien=blanks(length(RNA)/3); %preallocates blank vector of characters
for i=1:length(RNA)/3
       Protien(i)=datastruct.(RNA(i)).(RNA(i+1)).(RNA(i+2));
end
end

