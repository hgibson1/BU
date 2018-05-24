M = csvread('double*.csv');
elements = M(100:end, 1);
five_two = M(100:end, 6)./elements;
five_two(abs(five_two - mean(five_two)) > std(five_two)*3)=mean(five_two); 
six_two = M(100:end, 7)./elements;
six_two(abs(six_two - mean(six_two)) > std(six_two)*3)=mean(six_two); 
sev_two = M(100:end, 8)./elements;
sev_two(abs(sev_two - mean(sev_two)) > std(sev_two)*3)=mean(sev_two); 

files = dir('unroll*.csv');
loops = length(files);
colors = ['g', 'b', 'm', 'c', 'y'];
leg = cell(1, loops + 1);
leg{1} = 'unroll2';

figure
plot(elements, five_two, 'r');
hold on
for i=1:loops
    leg{i + 1} = strrep(files(i).name, '.csv', '');
    N = csvread(files(i).name);
    cpe = N(100:end, 6)./elements;
    cpe(abs(cpe - mean(cpe)) > std(cpe)*3)=mean(cpe); 
    plot(elements, cpe, colors(i));
end
xlabel('Elements in Array');
%set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
title('combine5 Performance with k Degrees Unrolling');
legend(char(leg));
hold off

figure
plot(elements, six_two, 'r');
hold on
for i=1:loops
    N = csvread(files(i).name);
    cpe = N(100:end, 7)./elements;
    cpe(abs(cpe - mean(cpe)) > std(cpe)*3)=mean(cpe); 
    plot(elements, cpe, colors(i));
end
xlabel('Elements in Array');
%set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
title('combine6 Performance with k Degrees Unrolling');
legend(char(leg));
hold off

figure
plot(elements, sev_two, 'r');
hold on
for i=1:loops
    N = csvread(files(i).name);
    cpe = N(100:end, 8)./elements;
    cpe(abs(cpe - mean(cpe)) > std(cpe)*3)=mean(cpe); 
    plot(elements, cpe, colors(i));
end
xlabel('Elements in Array');
%set(gca, 'xscale', 'log');
ylabel('Cycles Per Element');
title('combine7 Performance with k Degrees Unrolling');
legend(char(leg));
hold off

