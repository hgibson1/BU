obsnodustnolines=sum(sum(before_dust));
% obsnodustlines=sum(sum(nodustlines));
obsdustnolines=sum(sum(after_dust));
% obsdustlines=sum(sum(dustlines));
obscleanednolines=sum(sum(after_EDS01));
% obscleanedlines=sum(sum(cleanedlines));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   plotting the before dust, after dust, after cleaning
%   Just a simple bar graph with labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bg=[obsnodustnolines obsdustnolines obscleanednolines];
trialnum=length(bg);
reflmax=ceil(max(bg));
figure
bar(bg)
title('Percent obscuration of dust on EDS panels','FontSize',13,'FontWeight','bold')
axis([0 trialnum+1 0 reflmax+2])
set(gca,'FontWeight','bold','FontSize',13,'Xtick',1:1:trialnum,'XTickLabel',{'Before dust', 'After dust', 'After EDS'})
ylabel('Percent obscuration')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Plotting the surface plot of the obscuration points
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

obsmax=max(max(after_dust));
figure
subplot(3,1,1)
surf(before_dust);
set(gca,'FontWeight','bold','FontSize',13,'ZTick',.5,'ZTickLabel',{'50'})
zlim([0,obsmax+.1])
title('Surface obscuration of EDS panels')
xlabel('Before dust')
subplot(3,1,2)
surf(after_dust);
set(gca,'FontWeight','bold','FontSize',13,'ZTick',.5,'ZTickLabel',{'50'})
zlim([0,obsmax+.1])
xlabel('After dust')
subplot(3,1,3)
surf(after_EDS01);
set(gca,'FontWeight','bold','FontSize',13,'ZTick',.5,'ZTickLabel',{'50'})
zlim([0,obsmax+.1])
xlabel('After EDS activation')
colormap warm


% 
% figure
% subplot(3,1,1)
% surf(nodustlines)
% subplot(3,1,2)
% surf(dustlines);
% subplot(3,1,3)
% surf(cleanedlines)