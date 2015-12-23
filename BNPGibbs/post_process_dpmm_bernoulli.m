function [c] = post_process_dpmm_bernoulli(Z)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d=size(Z);
c=zeros(d(2),1);
for i=1:d(2)
    p=[];
    for j=1:d(3)
        %if Z(end,i,j)==1
            c(i)=j;
        %end
        all=Z(floor(end/2)+1:end,i,j);
        all=reshape(all,1,length(all));
        p=[p mean(all)];
    end
    c(i)=find(p==max(p));
end

end

