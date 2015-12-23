function [ stats ] = makeStats(B, cl )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ucm=unique(cl,'stable');
stats=zeros(length(ucm),1+size(B,2));
for i=1:length(ucm)
    mi=cl==ucm(i);
    if sum(mi)>1
        stats(ucm(i),:)=[sum(mi) sum(B(mi,:))];
    else
        stats(ucm(i),:)=[sum(mi) B(mi,:)];
    end
end

end

