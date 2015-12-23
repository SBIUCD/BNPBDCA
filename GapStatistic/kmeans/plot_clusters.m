function [] = plot_clusters( IDX,Z,X,xlabels,figure_size,outdir)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if exist(outdir,'dir')~=7
    mkdir(outdir);
end
u=unique(IDX(find(isnan(IDX)==0)));
cmap=flipud(cbrewer('div','RdYlBu',64));
f1=figure();
Y=[];
color_fill = [0.62 0.78 1];
color_draw=[0.02 0.36 0.8];

for i=1:length(u)
    subplot(ceil(length(u)/4),4,i)
    ind=IDX==u(i);
    bar=(ones(2,size(Z,2))*-1);
    y1=Z(ind,:);
    y=[bar;y1];
    %plot(1:size(Z,2),y1);drawnow;
    [polygon, centroids, X1]=DefineSurroundingPolygon(y1,X);
    fill(polygon(1,:),polygon(2,:),color_fill,'EdgeColor','none');hold on;plot(X1,centroids,'LineWidth',2,'Color',color_draw);hold off;xlim([min(X1) max(X1)]); drawnow;
    Y=[Y; y];
    
end
export_fig(gcf,[outdir 'pattern'], '-jpg','-r300','-q95','-transparent');
%f2=figure('Position',figure_size);
%figure('Position',figure_size);
figure;imagesc(Y);colorbar();colormap(cmap);set(gca,'XTick',X,'XTickLabel',xlabels);
% scale = 0.4;
% pos = get(gca, 'Position');
% pos(2) = pos(2)+scale*pos(4);
% pos(4) = (1-scale)*pos(4);
% set(gca, 'Position', pos);
%rotate_xlabels1(gca,30);
 export_fig(gcf,[outdir 'image'], '-jpg','-r300','-q95','-transparent');   
 
 
    function [polygon, centroid_smoothed, X_smoothed] = DefineSurroundingPolygon(data,X)
        mins=min(data);
        maxs= max(data);
        centroid=mean(data);
        %min_X=1:length(mins);
        min_Y=mins;
        %max_X=min_X;
        max_Y=maxs;
        X_smoothed=1:0.1:X(end);
        min_Y_smoothed=interp1(X,min_Y,X_smoothed,'pchip');
        max_Y_smoothed=interp1(X, max_Y, X_smoothed,'pchip');
        centroid_smoothed=interp1(X,centroid,X_smoothed,'pchip');
        polygon_X=[X_smoothed fliplr(X_smoothed)];
        polygon_Y=[min_Y_smoothed fliplr(max_Y_smoothed)];
        polygon=[polygon_X;polygon_Y];
    end
        


end

