function [ d ] = ExpectedDisplersion1(min, interval, ND, no_clust, no_iter)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

d=zeros(no_iter,1);
for i=1:no_iter
    data=GenerateDataset1(min,interval);
    idx=kmeans(data,no_clust,'Distance','sqEuclidean','EmptyAction','drop');
    d(i)=Dispersion(data,idx);
end

