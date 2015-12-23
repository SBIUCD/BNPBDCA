function [ pp, p2] = probs( bi, ck, stats, dim, a, b, gamma, T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sd=size(stats);
stats(ck,2:dim+1)= stats(ck,2:dim+1)-bi;
stats(ck,1)=stats(ck,1)-1;

ptm=zeros(1,sd(1));
ptm1=zeros(1,sd(1));
for i=1:sd(1)
    Nk=stats(i,1);
    sk_1=stats(i,2:dim+1)+a;
    sk_0=Nk-stats(i,2:dim+1)+b;
    pot1=sum(betaln(sk_1+bi,sk_0+1-bi)-betaln(sk_1,sk_0));
    ptm(i)=log(Nk)+pot1;
    ptm1(i)=log(Nk)+pot1/T;
end
pot2=sum(betaln(a+bi,b+1-bi)-betaln(a,b));

pp=[ptm pot2+log(gamma)];
pp1=[ptm1 pot2/T+log(gamma)];
% Ix=pp==-Inf;
%  if(sum(Ix)>0)
%      disp(sum(stats(Ix,:)));
%   end
p=exp(pp1-max(pp1));
sump=sum(p);
p0=p/sump;
p2=cumsum(p0);
end

