function [c] = cluster_centroid(IDX, data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=[];
ucl=unique(IDX);
for i=1:length(ucl)
    c=[c;mean(data(IDX==ucl(i),:))];
end

end

