function [] = plot_clusters1( IDX,Z,xlabels,outdir,th,dim)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

u=unique(IDX(find(isnan(IDX)==0)));


for i=1:length(u)
    ind=find(IDX==u(i));
    coloredbars(Z(ind,:),xlabels,dim,th);	
    export_fig(gcf,[outdir 'cluster' num2str(i)],'-jpg','-q100','-r300','-transparent');
end

end

