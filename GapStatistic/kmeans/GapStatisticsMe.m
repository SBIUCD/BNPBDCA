function [opt_k, gap, slwk] = GapStatisticsMe(data,clusters, no_iter,image_file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Mu=mean(data);
%Sigma=cov(data);
min1=repmat(min(data),size(data,1),1);
max1=repmat(max(data),size(data,1),1);
interval=max1-min1;

disp('calculating dispersion......');
mlwk=zeros(1,length(clusters));
slwk=zeros(1,length(clusters));
lwk=zeros(1,length(clusters));

parfor i=1:length(clusters)
    idx=kmeans(data,clusters(i), 'Distance','hamming','emptyaction','drop');
    lwk(i)=Dispersion(data,idx);
    disp(i);
    disp('Calculating expected dispersions....')
    d=ExpectedDisplersion1(min1, interval, size(data,1), clusters(i), no_iter);
    mlwk(i)=mean(d);
    slwk(i)=std(d)/sqrt(1+1/no_iter);
end
opt_k=0;
gap=mlwk-lwk;
for k=1:length(gap)-1
   if(gap(k)>=gap(k+1)-slwk(k+1))
       opt_k=k;
       break;
   end
end
fig=figure();errorbar(gap,slwk);
export_fig(gcf,image_file,'-jpg','-r300','-q100','-transparent');
close(fig);
end

