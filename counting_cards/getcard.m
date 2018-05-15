function [card]=getcard
%Generates a random card
suitnum=randi([1,4],1);
if suitnum==1
    suit=' Spades';
elseif suitnum==2
    suit=' Hearts';
elseif suitnum==3
    suit=' Clubs';
elseif suitnum==4
    suit=' Diamonds';
else
    suit=[];
end
%Assigns the card a suit
cardnum=randi([1,13],1);
if cardnum==1
    cardnum='Ace';
elseif cardnum==11
    cardnum='Jack';
elseif cardnum==12
    cardnum='Queen';
elseif cardnum==13
    cardnum='King';
else
    cardnum=num2str(cardnum);
end
%assigns the card a number
card=strcat(cardnum,' of ',suit);
%displays the card as a string
end

