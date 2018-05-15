deck=makedeck;
nhands=input('How many people are playing? ');
answer=input('Would you like to deal a round? ','s');
while answer=='yes'
    hands=deal(nhands,deck);
    answer=input('Would you like to deal another round? ','s');
end