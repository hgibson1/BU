function [RNA]=Transcription(cRNA)
%Models the transcription of cRNA to RNA
%Recieves a cRNA strand as input and outputs an RNA strand
RNA=strrep(cRNA,'T','U'); %Replaces the Thymine nucleotides with Uracil nucleotides
end

