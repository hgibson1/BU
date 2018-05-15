function [hands] = deal(nhands,deck)
persistent count
%Creates and initiates a persistent count
if isempty(count)
    count=1;
end
hands=cell(nhands,length(deck)/nhands);
for i=1:nhands
    hands{i,count}=deck{1,count+i-1};
end
count=count+1;
end

