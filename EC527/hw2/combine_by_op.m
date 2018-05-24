files = dir('*.csv');
ops = length(files);
leg = cell(1, ops);
colors = ['r', 'g', 'b', 'm', 'c', 'y'];

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,2)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine1 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,3)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine2 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,4)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine3 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,5)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine4 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,6)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine5 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,7)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine6 Performance')
legend(char(leg));

figure
for i=1:ops
    leg{i} = strrep(files(i).name, '.csv', '');
    M = csvread(files(i).name);
    elements = M(50:end,1);
    cpe = M(50:end,8)./elements;
    avg = mean(cpe);
    cpe(abs(cpe - avg) > std(cpe)*3)=avg; 
    scatter(elements, cpe, colors(i));
    if (i==1) 
        hold
    end
end
xlabel('Elements in Array');
set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
%set(gca, 'yscale', 'log');
title('Combine7 Performance')
legend(char(leg));