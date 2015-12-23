function [] = save_clusters(cls_labels,centroids,data,names,dir)
%saves clustering results 
ucls = unique(cls_labels);
for i=1:length(ucls)
    index_cls_i=cls_labels==ucls(i);
    centroid_i=centroids(ucls(i),:);
    C=corr(data(index_cls_i,:)',centroid_i');
    cnames=names(index_cls_i);
    
    [Y, I]=sort(C,'descend');
    cnames1=cnames(I);
    filename=[dir 'Cluster' num2str(ucls(i)) '.txt'];
    fid=fopen(filename,'w+');
    fprintf(fid,'%s\n',cnames1{:});
    fclose(fid);
end

end

