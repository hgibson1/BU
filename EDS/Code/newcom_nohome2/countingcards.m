deck=cell(1,52); %Creates cell matrix for deck
for i=1:52
    deck{1,i}=getcard; %Assigns a string card name to each position in the deck
    while any(deck{1,i}==deck)==1 %Checks to make sure each card is only used once
        deck{1,i}=getcard;
    end
end