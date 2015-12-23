function [ lwk] = Dispersion( data, idx)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

uidx=unique(idx);
s=0;
for i=1:length(uidx)
    mi=idx==uidx(i);
    d=data(mi,:);
    s=s+sum(sum(pdist(d)))/(2*sum(mi));
end
lwk=log(s);
end

