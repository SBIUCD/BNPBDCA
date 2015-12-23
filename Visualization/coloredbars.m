function [fig] = coloredbars(X,xlabel,dim,th)
%plots bars with error bars



c=linspecer(size(X,2));
m=mean(X);
if nargin==4
    Id=m>th;
    m=m(Id);
    c=c(Id,:);
    xlabel=xlabel(Id);
end

%s=std(X);
fig=figure('Position',dim); hold on;
for j=1:length(m)
    h=bar(j,m(j),'FaceColor',c(j,:),'EdgeColor','k');
    % x = get(get(h(1),'children'),'xdata');
    %barsx=mean(x,1);
    %bar(barsx',m(j),'k','LineWidth',2);
end
hold off;
xlim([0.5 length(m)+0.5]);
set(gca,'XTick',[1:length(m)],'XTickLabel',xlabel,'FontSize',12);
rotateXLabels(gca,45);
end

