function [] = plot_clusters( IDX,Z,pos)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

u=unique(IDX(find(isnan(IDX)==0)));

% figure;
Y=[];
for i=1:length(u)
%     subplot(ceil(length(u)/4),4,i)
    ind=find(IDX==u(i));
    bar=(ones(1,size(Z,2))*-1);
    y=[bar;Z(ind,:)];
%     plot(1:size(Z,2),y);drawnow;
    Y=[Y; y];
    
end
%figure('Position',[0 0 900 900]);
if nargin==3
    fig=figure('Position',pos);imagesc(Y);
else if nargin==2
        figure;imagesc(Y);
    end
end
    
end

