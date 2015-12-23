function [b] = betaparams(B)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
b=(1./mean(B));
b(b==Inf)=10^5;
b=b;
end

