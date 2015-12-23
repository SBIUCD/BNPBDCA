function [fig] = bars_with_error_bars(X,colors)
%plots bars with error bars
if size(colors,1)==1;
    colors=repmat(colors,size(X,1),1);
end
m=mean(X);
s=std(X);
fig=figure; hold on;
for j=1:length(m)
    h=bar(j,m(j),'FaceColor',colors(j,:),'EdgeColor','k');
    x = get(get(h(1),'children'),'xdata');
    barsx=mean(x,1);
    errorbar(barsx',m(j),s(j),'k','LineWidth',2);
end
hold off;
end

