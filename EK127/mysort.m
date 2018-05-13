function [outvec]=mysort(invec)
outvec=zeros(1,length(invec)); 
for i=1:length(invec)-1
    indlow=1;
    for j=i+1:length(invec)
        if invec(i)<invec(j)
            indlow=i;
        end
    end
end
temp=invec(i);
invec(i)=invec(indlow);
outvec(j)=invec(i);
end

