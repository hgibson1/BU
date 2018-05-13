function [mutRNA2, mutAmino2, RNAmat, Aminomat, percentcomp] = viralcomparison(vRNA1,vRNA2,vAmino1,vAmino2)
%Compares the RNA and Amino acid sequences of two strains of influenza virus
%Recieves as inputs the RNA and Amino Acid sequence of the first virus and
%the RNA and Amino Acid sequence of the second virus and outputs a vector
%of the locations of mutations in RNA sequence of the second virus, a
%vector of locations of mutations of Amino Acids in the second virus, a
%matrix comparing nucleotides at mutated points (with virus 1 in the first
%row and virus 2 in the second row), a matrix comparing Amino Acids and
%mutated points (with virus 1 in the first
%row and virus 2 in the second row), and 

mutRNA2=find(vRNA2~=vRNA1); %Finds locations of mutations in the RNA sequence of the second virus
mutAmino2=find(vAmino2~=vAmino1);%Finds locations of mutations in Amino acid sequence of second virus
RNAmat=[vRNA1(vRNA2~=vRNA1);vRNA2(vRNA1~=vRNA2)]; %Creates matrix comparing nucleotides at mutated points
Aminomat=[vAmino1(vAmino1~=vAmino2);vAmino2(vAmino1~=vAmino2)]; %creates matrix comparing amino acids at mutated points
percentcomp=[100*(length(mutRNA2)/length(vRNA2)) 100*(length(mutAmino2)/length(vAmino2))]; %Compares percent difference between RNA and amino acids in the viruses
end

