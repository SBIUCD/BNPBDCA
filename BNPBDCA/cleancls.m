function [c1, stats ] = cleancls( B, c )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

uc=unique(c);
c1=zeros(size(B,1),1);
stats=zeros(length(uc),1+size(B,2));
for i=1:length(uc)
    mi=c==uc(i);
    c1(mi)=i;
    if sum(mi)>1
        stats(i,:)=[sum(mi) sum(B(mi,:))];
    else
        stats(i,:)=[sum(mi) B(mi,:)];
    end
end

end

